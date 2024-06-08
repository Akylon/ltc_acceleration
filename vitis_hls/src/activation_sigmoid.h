#pragma once

#include <stdio.h>
#include <ap_int.h>


template<const size_t inRes, const size_t outRes, const int inShift>
void activation_sigmoid(const ap_int<inRes> *const x, ap_int<outRes> *const y, const size_t size){

	constexpr int outShift = -(int)inRes+2; //resolution-2 since out range=[0;1]
	constexpr int bShift = -1;
	constexpr int wShift = inRes>2 ? -3 : -2;
	constexpr int maxOut = (1<<-outShift);

	constexpr int correction = wShift+inShift-bShift;
	constexpr int wCorrection = correction >= 0 ? correction : 0;
	constexpr int bCorrection = correction >= 0 ? 0 : -correction;
	constexpr int outCorrection = correction >= 0 ? bShift : inShift+wShift;

	typedef ap_int<inRes> model_t;
	typedef ap_int<2*inRes> prod_t;
	typedef ap_int<2*inRes+1+bCorrection+wCorrection> sum_t;

	static_assert(bCorrection >= 0, "Bias correction must be larger or equal zero");
	static_assert(wCorrection >= 0, "Weight correction must be larger or equal zero");

	// If input range larger than [-3, 3], then clipping required, else no clipping.
	const model_t upperBound = 3<<-inShift;
	const model_t lowerBound = -1*(3<<-inShift);

	for(size_t i=0; i<size; ++i){

		const model_t w = inRes>2 ? (model_t)(1/3.0f*((float)(1<<inRes))) : (model_t)0;
		const model_t b = (model_t)(1<<(inRes-2));

		// clipping
		if(x[i] <= lowerBound){
			y[i] = 0;
		}
		else if(x[i] >= upperBound){
			y[i] = maxOut;
		}
		else{
			const prod_t prodOut = (prod_t)w*(prod_t)x[i];
			const sum_t sumOut = ((sum_t)prodOut<<wCorrection) + ((sum_t)b<<bCorrection);
			y[i] = (ap_int<outRes>)(sumOut << outCorrection);
		}
	}
}



template<const size_t inRes, const size_t outRes, const int inShift>
void quantSigmoid(const ap_int<inRes> &x, ap_int<outRes> &y){

	constexpr int outShift = 2-(int)outRes; //resolution-2 since out range=[0;1]
	//constexpr int bShift = 2-(int)inRes;
	//constexpr int wShift = (int)inRes>2 ? -(int)inRes : 0; // if inRes>2 then w=0
	constexpr long long maxOut = outShift>=0 ? 1LL<<outShift : 1LL<<-outShift;

	constexpr int wCorrection = inShift >= 2 ? inShift-2 : 0;
	constexpr int bCorrection = inShift >= 2 ? 0 : 2-inShift;
	constexpr int outCorrection = inShift >= 2 ? (int)outRes-(int)inRes-1 : inShift+(int)outRes-(int)inRes-3;

	constexpr int wSumWidth = 2*inRes+wCorrection+1; // #bits required to store w value after summation
	constexpr int bSumWidth = inRes+bCorrection+1; // #bits required to store w value after summation

	constexpr int sumWidth = wSumWidth>= bSumWidth ? wSumWidth : bSumWidth; // check which width can fit both
	constexpr int prodWidth = 2*inRes;

	typedef ap_int<inRes> model_t;
	typedef ap_int<prodWidth> prod_t;
	typedef ap_int<sumWidth> sum_t;

	static_assert(bCorrection >= 0, "Bias correction must be larger or equal zero");
	static_assert(wCorrection >= 0, "Weight correction must be larger or equal zero");

	// If input range larger than [-3, 3], then clipping required, else no clipping.
	// if inshift >= 0 then rounding is required. It is achieved by adding 2**inShift-1 to 3 => 2+1<<inShift
	constexpr unsigned int upperBound_int = inShift>=0 ? (unsigned int)(3)>>inShift : (unsigned int)(3)<<-inShift;
	const model_t upperBound = (model_t)upperBound_int;
	const model_t lowerBound = -upperBound;

	const model_t w = inRes>2 ? (model_t)(((double)(1<<inRes))/3.0f) : (model_t)0; // if inRes>2 then w=0 else 1/3*2**inRes
	const model_t b = (model_t)(1<<(inRes-2));


	//cout << "Bounds= [" << lowerBound << "; " << upperBound << "]" << endl;

	// clipping
	if(x < lowerBound){
		y = 0;
		/*cout << "-----" << endl;
		cout << "LB" << endl;
		cout << "x= " << x << endl;
		cout << "inShift= " << inShift << endl;
		cout << "y= " << y << endl;
		cout << "-----" << endl;*/
	}
	else if(x > upperBound){
		y = maxOut;
		/*cout << "-----" << endl;
		cout << "maxOut= " << maxOut << endl;
		cout << "UB" << endl;
		cout << "x= " << x << endl;
		cout << "inShift= " << inShift << endl;
		cout << "y= " << y << endl;
		cout << "-----" << endl;*/
	}
	else{
		const prod_t prodOut = (prod_t)w*(prod_t)x;
		const sum_t sumOut = ((sum_t)prodOut<<wCorrection) + ((sum_t)b<<bCorrection);
		y = (ap_int<outRes>)(sumOut << outCorrection);

		/*cout << "-----" << endl;
		cout << "w= " << w << endl;
		cout << "wShift= " << wShift  << endl;
		cout << "x= " << x << endl;
		cout << "inShift= " << inShift << endl;
		cout << "prod= " << prodOut << endl;
		cout << "prodShift= " << wShift+inShift << endl;
		cout << "b= " << b << endl;
		cout << "bShift= " << bShift  << endl;
		cout << "sum= " << sumOut << endl;
		cout << "sumShift= " << outCorrection - outShift << endl;
		cout << "y= " << y << endl;
		cout << "outCor= " << outCorrection << endl;
		cout << "outShift= " << outShift << endl;
		cout << "-----" << endl;
		cout << "bCorrection" << bCorrection << endl;
		cout << "wCorrection" << wCorrection << endl;
		cout << "-----" << endl;*/

	}
	//cout << endl;
}
