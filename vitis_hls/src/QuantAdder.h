#pragma once

#include <ap_int.h>
#include <iostream>
#include <assert.h>
using namespace std;

template<const size_t resolution, const int shiftA, const int shiftB, const int outShift>
void QuantAdd(const ap_int<resolution> * const A, const ap_int<resolution> * const B, ap_int<resolution> * const out, const size_t size){
	constexpr int AConversion = shiftA >= shiftB ? shiftA-shiftB : 0;
	constexpr int BConversion = shiftA >= shiftB ? 0 : shiftB-shiftA;
	constexpr int outConversion = shiftA >= shiftB ? outShift-shiftB : outShift-shiftA;
	assert(AConversion >=0);
	assert(BConversion >=0);
	assert(outConversion >=0);

	typedef ap_int<resolution+1+AConversion+BConversion> sumRes_t;


	/*cout << "ACorrection" << AConversion << endl;
	cout << "BCorrection" << BConversion << endl;
	cout << "outCorrection" << outConversion << endl;*/

	for(size_t i=0; i<size; ++i){
#pragma HLS UNROLL
		sumRes_t sum, a, b;
		a = (sumRes_t)A[i]<<AConversion;
		b = (sumRes_t)B[i]<<BConversion;
		sum = a+b;
		sum = sum>>outConversion;
		out[i] = (ap_int<resolution>)sum;
		//cout << "quant add out = " << out[i] << endl;
	}
}

