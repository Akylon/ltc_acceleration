#pragma once

template <typename T>
void activation_relu(const T *const in, T *const out, const size_t size){
	for(size_t i=0; i<size; ++i){
#pragma HLS UNROLL
        out[i] = in[i]>= (T)0 ? in[i] : (T)0;
    };
};

