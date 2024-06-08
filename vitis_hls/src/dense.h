#ifndef DENSE_H
#define DENSE_H


#include "compileTimeFunctions.h"
#include <cstddef>
#include <cassert>

#include <iostream>
#include <ap_int.h>
using namespace std;

#include "ap_int.h"



struct DenseParams_t{
	const size_t resolution;
	const size_t neurons;
	const size_t features;
	const size_t inSize;
	const int inShift;
	const int outShift;
	const int weightShift;
	const int biasShift;
};

template<const DenseParams_t &params>
class Dense {
public:
	static constexpr size_t RESOLUTION = params.resolution;
	static constexpr size_t NEURONS = params.neurons;
	static constexpr size_t FEATURES = params.features;
	static constexpr size_t INSIZE = params.inSize;
	static constexpr int INSHIFT = params.inShift;
	static constexpr int OUTSHIFT = params.outShift;
	static constexpr int WSHIFT = params.weightShift;
	static constexpr int BSHIFT = params.biasShift;

	typedef ap_int<RESOLUTION> T;
	typedef ap_int<RESOLUTION> out_t[NEURONS*INSIZE];

private:
	const T *const weights;
	const T *const biases;


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
	Dense(const T weigths[FEATURES*NEURONS], const T biases[NEURONS]) :
			weights(weigths), biases(biases){

	}

	~Dense() {
	}

	/*
	 * :param inputs: const pointer of type T
	 * 		inputs must have length of numberOfFeatures*inSize
	 * 		inputs = {in0OfFeature0, in1OfFeature0, ..., in0OfFeature1, in1OfFeature1, ...}
	 * :param outputs: const pointer of type T
	 * 		outputs must have length of numberOfFeatures*inSize
	 * 		outputs = {out0OfFeature0, out1OfFeature0, ..., out0OfFeature1, out1OfFeature1, ...}
	 */
	void evaluate(const T *inputs, T *outputs) {
#pragma HLS PIPELINE off
		/*for(int i=0; i<17; ++i){
			cout << "inputs[" << i << "]=" << inputs[i] << endl;
		}*/

		constexpr int correction = INSHIFT+WSHIFT-BSHIFT;
		constexpr int wCorrection = correction >= 0 ? correction : 0;
		constexpr int bCorrection = correction >= 0 ? 0 : -correction;
		constexpr int outCorrection = correction >= 0 ? BSHIFT-OUTSHIFT : INSHIFT+WSHIFT-OUTSHIFT;

		static_assert(bCorrection>=0, "Bias correction must be positive or zero");
		static_assert(wCorrection>=0, "Weigth correction must be positive or zero");

		constexpr size_t prodWidth = RESOLUTION*2;
		constexpr size_t sumWidth = compile::getSumWidth(prodWidth, FEATURES); //(size_t)std::ceil(prodWidth+std::log2((double)nFeatures));
		constexpr size_t outWidth = RESOLUTION;
		constexpr size_t biasSumWidth = sumWidth+1+wCorrection+bCorrection;

		typedef ap_int<prodWidth> Prod_t;
		typedef ap_int<sumWidth> Sum_t;
		typedef ap_int<outWidth> Out_t;
		typedef ap_int<biasSumWidth> BiasSum_t;

		static_assert(sumWidth>=prodWidth, "sumWidth must be greater than prodWidth");

		const ap_int<sumWidth> clipUpperBoundary = (1LL<<(outWidth-1))-1;
		const ap_int<sumWidth> clipLowerBoundary = -clipUpperBoundary;

		Out_t result[INSIZE*NEURONS];
		Sum_t sum[INSIZE*NEURONS];
#pragma HLS ARRAY_PARTITION dim=1 type=complete variable=sum


		for(size_t i=0; i<INSIZE*NEURONS; ++i){
#pragma HLS UNROLL
			sum[i] = (Sum_t)0;
		}



		//for(size_t i=0; i<INSIZE; ++i){
//#pragma HLS UNROLL
		for(size_t feature=0; feature<FEATURES; ++feature){
//
//#pragma HLS UNROLL factor=16
#pragma HLS PIPELINE II=10
		for(size_t neuron=0; neuron<NEURONS; ++neuron){

			//#pragma HLS UNROLL factor=4

					Prod_t product = (Prod_t)inputs[feature] * (Prod_t)weights[feature + neuron*FEATURES]; //(Prod_t)inputs[i + feature*INSIZE] * (Prod_t)weights[feature + neuron*FEATURES];
					sum[neuron] += (Sum_t)product; //sum[i + INSIZE*neuron] += (Sum_t)product;

					// check product
					//assert(((long long)inputs[feature] * (long long)weights[feature + neuron*FEATURES]) < (1LL<<prodWidth));
					//assert(((long long)inputs[feature] * (long long)weights[feature + neuron*FEATURES]) > -(1LL<<prodWidth));
					// check sum
					//assert(((long long)sum[neuron] + (long long)product) < (1LL<<sumWidth));
					//assert(((long long)sum[neuron] + (long long)product) > -(1LL<<sumWidth));
				}
			}
	//	}


		// TODO: instead of using shift and truncation just use .range(HI, LO) from class ap_int to slice the vectors
		//for(size_t i=0; i<INSIZE; ++i){
//#pragma HLS UNROLL
			for(size_t neuron=0; neuron<NEURONS; ++neuron){
#pragma HLS UNROLL
//#pragma HLS PIPELINE

				BiasSum_t biasedSum = ((BiasSum_t)sum[neuron*INSIZE] << wCorrection) + ((BiasSum_t)biases[neuron] << bCorrection);
				BiasSum_t correctedSum = biasedSum << outCorrection;

				if(correctedSum > clipUpperBoundary){
					result[neuron] = clipUpperBoundary;
				}
				else if(correctedSum < clipLowerBoundary){
					result[neuron] = clipLowerBoundary;
				}
				else{
					result[neuron] = (Out_t)correctedSum; //TODO: current implementation just truncates. Mby change to rounding
				}


/*
				// check corrected sum
				assert(((long long)sum[neuron*INSIZE] << wCorrection) < (1LL<<biasSumWidth));
				assert(((long long)sum[neuron*INSIZE] << wCorrection) > -(1LL<<biasSumWidth));
				// check corrected bias
				assert(((long long)biases[neuron] << bCorrection) < (1LL<<biasSumWidth));
				assert(((long long)biases[neuron] << bCorrection) > -(1LL<<biasSumWidth));

				// check result
				if(outCorrection>=0){
					assert(((long long)biasedSum << outCorrection) < (1LL<<outWidth));
					assert(((long long)biasedSum << outCorrection) > -(1LL<<outWidth));
				}
				else{
					assert(((long long)biasedSum >> -outCorrection) < (1LL<<outWidth));
					assert(((long long)biasedSum >> -outCorrection) > -(1LL<<outWidth));
				}*/
			}
	//	}

		// pass result to output
		for(size_t i=0; i<INSIZE*NEURONS; ++i){
#pragma HLS UNROLL
			outputs[i] = result[i];
		}
	}

};

#endif
