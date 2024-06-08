#ifndef MATMUL_QUANT_H
#define MATMUL_QUANT_H

#include <cstddef>
#include <ap_int.h>

#include <iostream>
using namespace std;

template<typename T, const size_t sumLength, const size_t wShift,
		const size_t bShift, const size_t outShift>
void matmul(const T *a, const T *w, T *c, const T *b,
		const size_t aNumberOfRows, const size_t aNumberOfColumns,
		const size_t bNumberOfColumns) {
	/* :info matmul implements a 2D matrix multiplication c = W*A + b
	 * :param a: pointer of type T
	 * 			Array must have length of aNumberOfRows*aNumberOfColumns. The inputs are stored in array pointed to by a.
	 * 			a = {in0Feature0, in1Feature0, ..., in0Feature1, in1Feature1, ...}
	 * :param w: pointer of type T
	 * 			Array must have length of aNumberOfColumns*bNumberOfColumns. The matrix weights are stored in array pointed to by w.
	 * 			w = {w0Feature0, w1Feature0, ..., w0Feature1, w1Feature1, ...}
	 * :param c: pointer of type T
	 * 			Array must have length of aNumberOfRows*bNumberOfColumns. The result is stored in array pointed to by c.
	 * 			c = {out0Feature0, out1Feature0, ..., out0Feature1, out1Feature1, ...}
	 * 			c = a*W
	 */
	//Produkt bitLength is double inputlen
	const size_t inLen = sizeof(T) * 8;
	const size_t prodLen = 2 * inLen;
	constexpr size_t wLen = sumLength + wShift; // bitlen of shifted weighted sum
	constexpr size_t bLen = sumLength + bShift; // bitlen of shifted bias

#pragma HLS INLINE
	for (size_t k = 0; k < aNumberOfRows; ++k) { // iterate through rows of a
		for (size_t j = 0; j < bNumberOfColumns; ++j) { // iterate through columns of w
#pragma HLS UNROLL
			ap_int<sumLength> ci = 0;
			for (size_t i = 0; i < aNumberOfColumns; ++i) { // iterate through columns of a
#pragma HLS UNROLL

				ap_int<prodLen> prod = (ap_int<prodLen> ) a[k * aNumberOfColumns + i] * (ap_int<prodLen> ) w[i * bNumberOfColumns + j];
				ci += prod;
			}

#ifndef __SYNTHESIS__
				if (outShift < 0) {
					std::cout
							<< "Warning outshift in matmul is smaller than 0! undefined behavior!!!!!!!!!!!"
							<< std::endl;
				}
				if (bShift < 0) {
					std::cout
							<< "Warning biasShift in matmul is smaller than 0! undefined behavior!!!!!!!!!!!"
							<< std::endl;
				}
				if (wShift < 0) {
					std::cout
							<< "Warning weightshift is smaller than 0 undefined behavior!"
							<< std::endl;
					}
#endif

			T shiftedOut;
			if (wLen > bLen) {
				ap_int<wLen> shiftedSum;
				shiftedSum = (((ap_int<wLen> ) ci) << wShift)
						+ (ap_int<wLen> ) b[k]
						+ ((ap_int<wLen> ) 1 << (outShift - 1));
				shiftedSum = shiftedSum >> outShift;

				//overflow protection
				if (shiftedSum >= (1 << (inLen - 1))) {
					shiftedSum = (1 << (inLen - 1)) - 1;
				}
				//underflow protection
				if (shiftedSum < -(1 << (inLen - 1))) {
					shiftedSum = -(1 << (inLen - 1));
				}
				shiftedOut = (T) shiftedSum;

			} else {
				ap_int<bLen> shiftedSum;
				shiftedSum = (ap_int<bLen> ) ci
						+ (((ap_int<bLen> ) b[k]) << bShift)
						+ ((ap_int<bLen> ) 1 << (outShift - 1));
				shiftedSum = shiftedSum >> outShift;

				//overflow protection
				if (shiftedSum >= (1 << (inLen - 1))) {
					shiftedSum = (1 << (inLen - 1)) - 1;
				}
				//underflow protection
				if (shiftedSum < -(1 << (inLen - 1))) {
					shiftedSum = -(1 << (inLen - 1));
				}
				shiftedOut = (T) shiftedSum;
			}

			c[k * bNumberOfColumns + j] = shiftedOut;
		}
	}
}

#endif
