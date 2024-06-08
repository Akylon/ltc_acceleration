#pragma once

#include "compileTimeFunctions.h"
#include <ap_int.h>

template<const size_t inRes, const size_t outRes, const int inShift, const int outShift, const int wShift, const int bShift>
void biasedMulQuant(const ap_int<inRes> &in, const ap_int<inRes> &w, const ap_int<inRes> &b, ap_int<outRes> &out) {
		constexpr int correction = inShift+wShift-bShift;
		constexpr int wCorrection = correction >= 0 ? correction : 0;
		constexpr int bCorrection = correction >= 0 ? 0 : -correction;
		constexpr int outCorrection = correction >= 0 ? bShift-outShift : inShift+wShift-outShift;

		static_assert(bCorrection>=0);
		static_assert(wCorrection>=0);

		constexpr size_t prodWidth = resolution*2;
		constexpr size_t sumWidth = getSumWidth(prodWidth, features); //(size_t)std::ceil(prodWidth+std::log2((double)nFeatures));
		constexpr size_t outWidth = outRes;

		typedef ap_int<prodWidth> Prod_t;
		typedef ap_int<sumWidth> Sum_t;
		typedef ap_int<outWidth> Out_t;
		typedef ap_int<sumWidth+1+wCorrection+bCorrection> BiasSum_t;


		Prod_t product = (Prod_t)in * (Prod_t)weights[feature + neuron*features];
		Sum_t sum[i + inSize*neuron] += (Sum_t)product;
		Out_t result[i + neuron*inSize] = (Out_t)((((BiasSum_t)sum[i + neuron*inSize] << wCorrection) + ((BiasSum_t)biases[neuron] << bCorrection)) << outCorrection); //TODO: current implementation just truncates. Mby change to rounding

		// pass result to output
		out = result;

		/*cout << "--------------------------------" << endl;
		cout << "-- Dense call" << endl;
		cout << "sumScale= " << inShift+wShift << endl;
		cout << "biasScale= " << bShift << endl;
		cout << "wCorrection= " << wCorrection << endl;
		cout << "bCorrection= " << bCorrection << endl;
		cout << "outCorrection= " << outCorrection << endl;

		cout << "matrix multiplication" << endl;

		cout << "input=" << (Prod_t)inputs[i + feature*inSize] << endl;
		cout << "weight=" << (Prod_t)weights[feature + neuron*features] << endl;
		cout << "product= " << product << endl;
		cout << "sum= " << sum[i + neuron*inSize] << endl;
		cout << endl;

		cout << "add biases" << endl;

		cout << "neuron= " << neuron << endl;
		cout << "bias= " << (BiasSum_t)biases[neuron] << endl;*/

	}
