#pragma once
#include <cstddef>

namespace compile{

///
/// \brief A helper function to calculate the ceiled logarithm of a value during compile time.
///
/// The idea of this recursion has been found on stackoverflow: https://stackoverflow.com/a/23782326
///
constexpr size_t ceilLog2(size_t x)
{
	return x < 2 ? x : 1+ceilLog2(x >> 1);
}

///
/// \brief A helper function that calculates the width of a solution vector form a sum with N summands and bitWidth number of bits.
///
constexpr size_t getSumWidth(size_t bitWidth, size_t N){
	return bitWidth + ceilLog2(N);
}


///
/// \breif A helper function that rounds the input value
///
template<typename T>
constexpr T round(const T in){
	long long roundedInt = static_cast<long long>(in+0.5f);
	return static_cast<T>(roundedInt);
}


///
/// \brief A helper function that calculates the integer power of 2
///
template<typename T>
constexpr T pow2(const int exponent){
	// naive implementation. One could directly alter the exponent of the floating point representation
	const T base = 2;
	T result = 1;
	if(exponent>=0){
		unsigned int boundarie = exponent;
		for(unsigned int i=0; i<boundarie; ++i){
			result *= base;
		}
	}
	else{
		unsigned int boundarie = -exponent;
		for(unsigned int i=0; i<boundarie; ++i){
			result /= base;
		}
	}
	return result;
}



};
