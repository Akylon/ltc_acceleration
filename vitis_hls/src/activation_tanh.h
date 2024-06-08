#pragma once

#include <stdio.h>
#include <ap_int.h>
#include <assert.h>
#include <cmath>
#include "quantOperations.h"
#include "compileTimeFunctions.h"

template <const size_t resolution, const int inShift>
void activation_tanh(const ap_int<resolution> *const in, ap_int<resolution> *const out, const size_t size){
	constexpr int conditionShift = inShift >= 0 ? 0 : -inShift;
	static_assert(conditionShift>=0, "Bound shift must be larger or equal zero");
	constexpr int upperBound = 1<<conditionShift;
	constexpr int lowerBound = -upperBound;

	typedef ap_int<resolution> T;


	for(size_t i=0; i<size; ++i){

		if(in[i]>= (T)upperBound){
			out[i] = (T)upperBound;
		}
		else if(in[i] <= (T)lowerBound){
			out[i] = (T)lowerBound;
		}
		else {
			out[i] = in[i];
		}
    };
};


template <const size_t resolution, const int inShift>
void activation_tanh_optimal(const ap_int<resolution> *const in, ap_int<resolution> *const out, const size_t size){
	typedef ap_int<resolution> T;
	static_assert(resolution>3, "resolution should be > 3. If <=3 required, than adjust slopeShift calculation.");

	constexpr double exactSlope = 0.7685370741482966;
	constexpr int slopeShift = 1-(int)resolution; // valid for resolution > 3
	constexpr double quantSlope = compile::round(exactSlope*compile::pow2<double>(-slopeShift));
	constexpr int slope_int = (int)quantSlope;
	const T slope = slope_int;

	constexpr double upperBound_float = 1/(compile::pow2<double>(inShift)*compile::pow2<double>(slopeShift)*quantSlope);

	constexpr int upperBound = (int)upperBound_float;
	constexpr int lowerBound = -upperBound;
	constexpr int outShift = 2-(int)resolution;
	constexpr int maxValue = 1<<-outShift;
	constexpr int minValue = -maxValue;

	static_assert(outShift<=0, "outShift must be <=0");
	static_assert(lowerBound<=0, "lower bound must be <=0");
	static_assert(upperBound>=0, "lower bound must be >=0");

/*
	cout << "inShift= " << inShift << endl;
	cout << "slopeShift= " << slopeShift << endl;
	cout << "upperBound_float= " << upperBound_float << endl;
	cout << "upperBound= " << upperBound << endl;
	cout << "slope= " << slope << endl;
*/
	for(size_t i=0; i<size; ++i){
#pragma HLS UNROLL

		if(in[i]> (T)upperBound){
			out[i] = (T)maxValue;
		}
		else if(in[i] < (T)lowerBound){
			out[i] = (T)minValue;
		}
		else {
			quantMul<resolution, resolution, inShift, slopeShift, outShift>(in[i], slope, out[i]);
		}
    };
};
