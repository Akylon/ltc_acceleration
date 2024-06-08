#pragma once
#include "dense.h"
#include "QuantAdder.h"
#include "activation_relu.h"
#include "activation_tanh.h"
#include "activation_sigmoid.h"
#include "quantOperations.h"
#include "../testbenches/tInterP_test.h"

#include <ap_int.h>

template<const size_t resolution, const int tShift, const int outShift, const size_t units, const DenseParams_t &inSigParams, const DenseParams_t &inStateParams, const DenseParams_t &ff1Params, const DenseParams_t &ff2Params, const DenseParams_t &taParams, const DenseParams_t &tbParams>
class LTC {
private:
	typedef ap_int<resolution> T;

	typedef Dense<inSigParams> denseInSig_t;
	typedef Dense<inStateParams> denseInState_t;
	typedef Dense<ff1Params> ff1_t;
	typedef Dense<ff2Params> ff2_t;
	typedef Dense<taParams> ta_t;
	typedef Dense<tbParams> tb_t;

	static constexpr int tanh_out_shift = 2-(int)resolution;

	denseInSig_t denseInSig;
	denseInState_t denseInState;
	ff1_t ff1;
	ff2_t ff2;
	ta_t ta;
	tb_t tb;

	static constexpr int statesShift = 2-resolution; // since states in range=[-2, 2] and a single shift has been done on state update
	T (&states)[units];

	friend bool tInterP_test();

	void updateState(const T &t_in, const typename ff1_t::out_t &ff1Out, const typename ff2_t::out_t &ff2Out, const typename ta_t::out_t &taOut, const typename tb_t::out_t &tbOut){
		// ff1 * (1.0 - t_interp) + t_interp * ff2

		//cout << "units= " << units << endl;
		for(size_t i=0; i<units; ++i){
#pragma HLS UNROLL
			ap_int<resolution> tInterp;
			constexpr int shiftTinterp = 2-(int)resolution; // since tInterp in range=[0,1]
			calcTinterp(t_in, taOut[i], tbOut[i], tInterp);
			/*cout << "shiftTinterp= " << shiftTinterp << endl;
			cout << "tInterp= " << tInterp << endl;*/

			ap_int<resolution> sub;
			constexpr int shiftSub = 2-(int)resolution; // since 1-tInterp in range=[0,1]
			quantSub<resolution, resolution, 0, shiftTinterp, shiftSub>((ap_int<resolution>)1, tInterp, sub);
			/*cout << "shiftSub= " << shiftSub << endl;
			cout << "sub= " << sub << endl;*/

			ap_int<resolution> prod1;
			constexpr int shiftProd1 = 2-(int)resolution; // since prod1 in range=[-1, 1]
			quantMul<resolution, resolution, tanh_out_shift, shiftSub, shiftProd1>(ff1Out[i], sub, prod1);
			/*cout << "ff1Out= " << ff1Out[i] << endl;
			cout << "shiftProd1= " << shiftProd1 << endl;
			cout << "prod1= " << prod1 << endl;*/

			ap_int<resolution> prod2;
			constexpr int shiftProd2 = 2-(int)resolution; // since prod2 in range=[-1, 1]
			quantMul<resolution, resolution, tanh_out_shift, shiftTinterp, shiftProd2>(ff2Out[i], tInterp, prod2);
			/*cout << "i = " << i << endl;
			cout << "tanh_out_shift= " << tanh_out_shift << endl;
			cout << "ff2Out= " << ff2Out[i] << endl;
			cout << "shiftProd2= " << shiftProd2 << endl;
			cout << "prod2= " << prod2 << endl;*/

			// no correction needed, since shiftSum = shiftStates
			ap_int<resolution+1> sum = prod1 + prod2; // can directly be computed since prod1 and prod2 have same scale
			states[i] = (T)sum;
			/*cout << "sum= " << sum << endl;
			cout << "state= " << states[i] << endl;
			cout << "statesShift" << statesShift << endl;*/
		}
	}

	void calcTinterp(const ap_int<resolution> &t_in, const ap_int<resolution> &ta_out, const ap_int<resolution> &tb_out, ap_int<resolution> &tInterp) {

		constexpr int prodShift = tShift+ta_t::OUTSHIFT;
		constexpr int prodWidth = resolution*2; //TODO: Even less bits can be used since -128 is not considered to be a valid value

		constexpr int correction = prodShift-tb_t::OUTSHIFT;
		constexpr int wCorrection = correction >= 0 ? correction : 0;
		constexpr int bCorrection = correction >= 0 ? 0 : -correction;

		constexpr int sumWidthCase1 = prodWidth + correction + 1;
		constexpr int sumWidthCase2 = (int)resolution >= -correction ? prodWidth + 1 : (int)resolution - correction + 1;

		constexpr size_t sumWidth = prodShift>=tb_t::OUTSHIFT ? sumWidthCase1 : sumWidthCase2;
		constexpr int sumShift = prodShift>=tb_t::OUTSHIFT ? tb_t::OUTSHIFT : prodShift;

		typedef ap_int<prodWidth> Prod_t;
		typedef ap_int<sumWidth> Sum_t;
		typedef ap_int<resolution> Out_t;


		static_assert(wCorrection>=0, "Weight correction must be larger or equal zero");
		static_assert(bCorrection>=0, "Bias correction must be larger or equal zero");



		Prod_t product = (Prod_t)t_in * (Prod_t)ta_out * (-1);
		Sum_t sum = ((Sum_t)product<<wCorrection) + ((Sum_t)tb_out<<bCorrection);
		Out_t result;
		quantSigmoid<sumWidth, resolution, sumShift>(sum, result);
		/*
		cout << "prodShift= " << prodShift << endl;
		cout << "tb_t::OUTSHIFT= " << tb_t::OUTSHIFT << endl;
		cout << "tInterP prod= " << product << endl;
		cout << "tInterP tb_out= " << tb_out << endl;
		cout << "tInterP wCorrection= " << wCorrection << endl;
		cout << "tInterP bCorrection= " << bCorrection << endl;
		cout << "tInterP sumshift= " << sumShift << endl;
		cout << "tInterP sum= " << sum << endl;

		cout << "result= " << result << endl;*/

		// pass result to output
		tInterp = result;
	}


public:
	/*
	 * :param weights: const pointer to array of T
	 * 		The array must have length of numberOfNeurons*numberOfFeatures.
	 * 		weights = {wOfNeuron0OfFeature0, wOfNeuron0OfFeature1, ..., wOfNeuron1OfFeature0, wOfNeuron1OfFeature1, ...}
	 * :param biases: const pointer to array of T
	 * 		The array must have length of numberOfNeurons.
	 * 		biases = {biasOfNeuron0, biasOfNeuron1, ...}
	 * :param inSize: size_t
	 * 		stores lenght of input data
	 * :param numberOfFeatures: size_t
	 * 		stores number of input features
	 * :param numberOfNeurons: size_t
	 * 		stores number of Neurons
	 */
	LTC(const T *const inSigWeights, const T *const inSigBiases,
		const T *const inStateWeights, const T *const inStateBiases,
		const T *const ff1Weights, const T *const ff1Biases,
		const T *const ff2Weights, const T *const ff2Biases,
		const T *const taWeights, const T *const taBiases,
		const T *const tbWeights, const T *const tbBiases,
		T (&states)[units])
		:denseInSig(inSigWeights, inSigBiases),
		 denseInState(inStateWeights, inStateBiases),
		 ff1(ff1Weights, ff1Biases),
		 ff2(ff2Weights, ff2Biases),
		 ta(taWeights, taBiases),
		 tb(tbWeights, tbBiases),
		 states(states){}

	~LTC() {
	}

	/*
	 * :param inputs: const pointer of type T
	 * 		inputs must have length of numberOfFeatures*inSize
	 * 		inputs = {in0OfFeature0, in1OfFeature0, ..., in0OfFeature1, in1OfFeature1, ...}
	 * :param outputs: const pointer of type T
	 * 		outputs must have length of numberOfFeatures*inSize
	 * 		outputs = {out0OfFeature0, out1OfFeature0, ..., out0OfFeature1, out1OfFeature1, ...}
	 */
	void evaluate(const T t_in, const T *const sig_in, T *const outputs) {

		typename denseInSig_t::out_t backboneOut;
		typename denseInSig_t::out_t denseInOutputs;
		typename denseInSig_t::out_t denseInSigOutputs;
		typename denseInState_t::out_t denseInStateOutputs;

		/*cout << "********************************" << endl;
		cout << "** sig in evaluation" << endl;

		for(size_t i=0; i<denseInSig_t::FEATURES; ++i){
			cout << "sig_in[" << i << "]: " << sig_in[i] << endl;
		}*/

		denseInSig.evaluate(sig_in, denseInSigOutputs);

		/*for(size_t i=0; i<denseInSig_t::NEURONS; ++i){
			cout << "DenseInSigOut[" << i << "]: " << denseInSigOutputs[i] << endl;
		}

		cout << "** state in evaluation" << endl;
		for(size_t i=0; i<units; ++i){
			cout << "states[" << i << "]: " << states[i] << endl;
		}*/
		denseInState.evaluate(states, denseInStateOutputs);

		/*for(size_t i=0; i<denseInSig_t::NEURONS; ++i){
			cout << "DenseInStateOut[" << i << "]: " << denseInStateOutputs[i] << endl;
		}

		cout << "** backbone evaluation" << endl;*/
		constexpr size_t outSize = denseInSig_t::NEURONS*denseInSig_t::INSIZE;
		//TODO: the shifts the combination operation of sig and states is not well defined
		QuantAdd<resolution, denseInSig_t::OUTSHIFT, denseInState_t::OUTSHIFT, denseInState_t::OUTSHIFT>(denseInSigOutputs, denseInStateOutputs, denseInOutputs, outSize);
		activation_relu(denseInOutputs, backboneOut, denseInSig_t::NEURONS*denseInSig_t::INSIZE);

		// Distribute backboneOut to different buffers
		typename denseInSig_t::out_t ff1In;
		typename denseInSig_t::out_t ff2In;
		typename denseInSig_t::out_t taIn;
		typename denseInSig_t::out_t tbIn;
		for(size_t i=0; i<denseInSig_t::NEURONS; ++i){
#pragma HLS UNROLL
			ap_int<resolution> &temp = backboneOut[i];
			ff1In[i] = temp;
			ff2In[i] = temp;
			taIn[i] = temp;
			tbIn[i] = temp;
		}

		/*for(size_t i=0; i<denseInSig_t::NEURONS; ++i){
			cout << "BackboneOut[" << i << "]: " << denseInOutputs[i] << "  |  floating = " << float(denseInOutputs[i])*pow(2, denseInSig_t::OUTSHIFT) << endl;
		}


		for(size_t i=0; i<denseInSig_t::NEURONS; ++i){
			cout << "BackboneOutActivation[" << i << "]: " << backboneOut[i] << endl;
		}

		cout << "** ff1 evaluation" << endl;*/
		typename ff1_t::out_t ff1Out;
		typename ff1_t::out_t ff1ActivationOut;
		ff1.evaluate(ff1In, ff1Out);
		activation_tanh_optimal<resolution, ff1_t::OUTSHIFT>(ff1Out, ff1ActivationOut, ff1_t::NEURONS*ff1_t::INSIZE);

		/*for(size_t i=0; i<ff1_t::NEURONS; ++i){
			cout << "ff1Out[" << i << "]: " << ff1Out[i] << endl;
		}

		for(size_t i=0; i<ff1_t::NEURONS; ++i){
			cout << "ff1ActivationOut[" << i << "]: " << ff1ActivationOut[i] << endl;
		}


		cout << "** ff2 evaluation" << endl;*/
		typename ff2_t::out_t ff2Out;
		typename ff2_t::out_t ff2ActivationOut;
		ff2.evaluate(ff2In, ff2Out);
		activation_tanh_optimal<resolution, ff2_t::OUTSHIFT>(ff2Out, ff2ActivationOut, ff2_t::NEURONS*ff2_t::INSIZE);

		/*for(size_t i=0; i<ff2_t::NEURONS; ++i){
			cout << "ff2Out[" << i << "]: " << ff2Out[i] << endl;
		}

		for(size_t i=0; i<ff2_t::NEURONS; ++i){
			cout << "ff2ActivationOut[" << i << "]: " << ff2ActivationOut[i] << endl;
		}


		cout << "** ta evaluation" << endl;*/
		typename ta_t::out_t taOut;
		ta.evaluate(taIn, taOut);

		/*for(size_t i=0; i<ta_t::NEURONS; ++i){
			cout << "taOut[" << i << "]: " << taOut[i] << endl;
		}


		cout << "** tb evaluation" << endl;*/
		typename tb_t::out_t tbOut;
		tb.evaluate(tbIn, tbOut);

		/*for(size_t i=0; i<tb_t::NEURONS; ++i){
			cout << "tbOut[" << i << "]: " << tbOut[i] << endl;
		}*/

		// update states
		updateState(t_in, ff1ActivationOut, ff2ActivationOut, taOut, tbOut);
		// return results
		for(size_t i=0; i<units; ++i){
#pragma HLS UNROLL
			outputs[i] = states[i];
		}


	}

	void setStates(const T states[units]){
		for(size_t i=0; i<units; ++i){
#pragma HLS UNROLL
			this->states[i] = states[i];
		}

	}

	void getStates(T (&states)[units]) const{
		for(size_t i=0; i<units; ++i){
#pragma HLS UNROLL
			states[i] = this->states[i];
		}
	}

	void clearStates(){
		for(size_t i=0; i<units; ++i){
#pragma HLS UNROLL
			this->states[i] = 0;
		}
	}


};
