#pragma once
#include "ap_int.h"


template<const size_t inRes, const size_t outRes, const int inShift, const int outShift, const int wShift, const int bShift>
void quantMulAdd(const ap_int<inRes> &in, ap_int<outRes> &out, const ap_int<inRes> &b, const ap_int<inRes> &w) {

	constexpr int correction = inShift+wShift-bShift;
	constexpr int wCorrection = correction >= 0 ? correction : 0;
	constexpr int bCorrection = correction >= 0 ? 0 : -correction;
	constexpr int outCorrection = correction >= 0 ? bShift-outShift : inShift+wShift-outShift;

	constexpr int prodShift = inShift + wShift;
	constexpr int prodWidth = inRes*2; //TODO: Even less bits can be used since -128 is not considered to be a valid value

	constexpr int sumWidthCase1 = prodWidth + correction + 1;
	constexpr int sumWidthCase2 = inRes >= -correction ? prodWidth + 1 : inRes - correction + 1;

	constexpr size_t sumWidth = prodShift>=bShift ? sumWidthCase1 : sumWidthCase2;
	constexpr size_t outWidth = outRes;

	typedef ap_int<prodWidth> Prod_t;
	typedef ap_int<sumWidth> Sum_t;
	typedef ap_int<outWidth> Out_t;


	static_assert(wCorrection>=0, "Weight correction must be larger or equal zero");
	static_assert(bCorrection>=0, "Bias correction must be larger or equal zero");
	static_assert(outCorrection<=0, "Out correction must be smaller or equal zero");


	// calculate matrix multiplication
	Prod_t product = (Prod_t)in * (Prod_t)w;


	Sum_t sum = ((Sum_t)product<<wCorrection) + ((Sum_t)b<<bCorrection);
	Out_t result = (Out_t)(sum<<outCorrection);


	// pass result to output
	out = result;

	/*
	cout << "-----------" << endl;
	cout << "multiplication" << endl;
	cout << "prod width= " << prodWidth << endl;
	cout << "input=" << (Prod_t)in << endl;
	cout << "weight=" << (Prod_t)w << endl;
	cout << "product= " << product << endl;
	cout << endl;

	cout << "add biases" << endl;
	cout << "sum width= " << sumWidth << endl;
	cout << "sB= " << bShift << endl;
	cout << "sW= " << wShift << endl;
	cout << "sI= " << inShift << endl;
	cout << "wCorrection= " << wCorrection << endl;
	cout << "bCorrection= " << bCorrection << endl;
	cout << "outCorrection= " << outCorrection << endl;
	cout << "bias= " << b << endl;
	cout << "product= " << product << endl;
	cout << "sum= " << sum<< endl;
	cout << endl;
	cout << "result= " << result << endl;
	cout << endl;
	*/
}

template<const size_t inRes, const size_t outRes, const int in1Shift, const int in2Shift, const int outShift>
void quantAdd(const ap_int<inRes> &in1, const ap_int<inRes> &in2, const ap_int<outRes> &out){
	constexpr int in1Correction = in1Shift >= in2Shift ? in1Shift-in2Shift : 0;
	constexpr int in2Correction = in1Shift >= in2Shift ? 0 : in2Shift-in1Shift;
	constexpr int outCorrection = in1Shift >= in2Shift ? in2Shift-outShift : in1Shift-outShift;

	static_assert(in1Correction>=0, "In1 correction must be larger or equal zero");
	static_assert(in2Correction>=0, "In2 correction must be larger or equal zero");
	static_assert(outCorrection<=0, "Out correction must be smaller or equal zero");

	typedef ap_int<inRes+1+in2Correction+in1Correction> sum_t;
	typedef ap_int<outRes> out_t;

	sum_t sum = ((sum_t)in1<<in1Correction) + ((sum_t)in2<<in2Correction);
	out = (out_t)(sum << outCorrection);
}


template<const size_t inRes, const size_t outRes, const int in1Shift, const int in2Shift, const int outShift>
void quantSub(const ap_int<inRes> &in1, const ap_int<inRes> &in2, ap_int<outRes> &out){
	constexpr int in1Correction = in1Shift >= in2Shift ? in1Shift-in2Shift : 0;
	constexpr int in2Correction = in1Shift >= in2Shift ? 0 : in2Shift-in1Shift;
	constexpr int outCorrection = in1Shift >= in2Shift ? in2Shift-outShift : in1Shift-outShift;

	static_assert(in1Correction>=0, "In1 correction must be larger or equal zero");
	static_assert(in2Correction>=0, "In2 correction must be larger or equal zero");
	static_assert(outCorrection<=0, "Out correction must be smaller or equal zero");

	typedef ap_int<inRes+1+in2Correction+in1Correction> sum_t;
	typedef ap_int<outRes> out_t;

	sum_t sum = ((sum_t)in1<<in1Correction) - ((sum_t)in2<<in2Correction);
	out = (out_t)(sum << outCorrection);
}

template<const size_t inRes, const size_t outRes, const int in1Shift, const int in2Shift, const int outShift>
void quantMul(const ap_int<inRes> &in1, const ap_int<inRes> &in2, ap_int<outRes> &out){
	constexpr int outCorrection = in1Shift + in2Shift - outShift;

	typedef ap_int<2*inRes> prod_t;
	typedef ap_int<outRes> out_t;

	prod_t prod = (prod_t)in1 * (prod_t)in2;
	//cout << "prod= " << prod << endl;
	//TODO: this condition can be solved at compile time.
	//if constexpr is not supported. std::enable_if will require twice the same implemantation with only slight differences
	if(outCorrection >= 0){
		out = (out_t)(prod << outCorrection);
	}
	else{
		out = (out_t)(prod >> -outCorrection);
	}

}


