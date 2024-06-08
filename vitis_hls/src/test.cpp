#include "test.h"
#include <cstddef>
#include "dense.h"
#include "../../model/data/model_quant_export/walker_relu_tanh_quant_config.h"

constexpr DenseParams_t inStateParams = {.resolution=MODEL_RESOLUTION,
										 .neurons=LTC_DENSE_BACKBONE_0_STATE_UNITS,
										 .features=LTC_DENSE_BACKBONE_0_STATE_INFEATURES,
										 .inSize=1,
										 .inShift=LTC_DENSE_BACKBONE_0_SIG_INSTATESCALE,
										 .outShift=LTC_DENSE_BACKBONE_0_STATE_OUTNOACTIVATIONSCALE,
										 .weightShift=LTC_DENSE_BACKBONE_0_STATE_SW,
										 .biasShift=LTC_DENSE_BACKBONE_0_STATE_SB};


void test(const ap_int<8*64> inputs, ap_int<8*256> &outputs){
/*
#pragma HLS reset variable=LTC_STATES
#pragma HLS ARRAY_RESHAPE dim=1 factor=2 type=block variable=LTC_DENSE_BACKBONE_0_SIG_WEIGHTS
#pragma HLS ARRAY_RESHAPE dim=1 type=complete variable=LTC_DENSE_BACKBONE_0_STATE_WEIGHTS
#pragma HLS ARRAY_RESHAPE dim=2 factor=4 type=block variable=LTC_FF1_WEIGHTS
#pragma HLS ARRAY_RESHAPE dim=2 factor=4 type=block variable=LTC_FF2_WEIGHTS
#pragma HLS ARRAY_RESHAPE dim=2 factor=4 type=block variable=LTC_TA_WEIGHTS
#pragma HLS ARRAY_RESHAPE dim=2 factor=4 type=block variable=LTC_TB_WEIGHTS*/

	Dense<inStateParams> dense(*LTC_DENSE_BACKBONE_0_STATE_WEIGHTS, LTC_DENSE_BACKBONE_0_STATE_BIASES);
	ap_int<8> tempOutputs[256];

	ap_int<8> tempInputs[64];

	for(int i=0; i<64; ++i){
		tempInputs[i] = inputs.range((i+1)*8-1, 8*i);
		cout << "tempInputs[" << i << "]=" << tempInputs[i] << endl;
	}




	dense.evaluate(tempInputs, tempOutputs);

	for(int i=0; i<256; ++i){
		cout << "tempOutputs[" << i << "]=" << tempOutputs[i] << endl;
	}

	ap_int<8*256> outs;

	for(int i=0; i<256; ++i){
		outs.range((i+1)*8-1, 8*i) = tempOutputs[i];
	}

	for(int i=0; i<256; ++i){
		cout << "outs[" << i << "]=" << (ap_int<8>)(outs.range((i+1)*8-1, 8*i)) << endl;
	}


	outputs = outs;

}


