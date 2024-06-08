#include "model.h"
#include "LTC.h"
#include "dense.h"

constexpr size_t inSize = 1;

// LTC Params
constexpr DenseParams_t inSigParams = {.resolution=MODEL_RESOLUTION,
									   .neurons=LTC_DENSE_BACKBONE_0_SIG_UNITS,
									   .features=LTC_DENSE_BACKBONE_0_SIG_INFEATURES,
									   .inSize=1,
									   .inShift=LTC_DENSE_BACKBONE_0_SIG_INSIGSCALE,
									   .outShift=LTC_DENSE_BACKBONE_0_SIG_OUTNOACTIVATIONSCALE,
									   .weightShift=LTC_DENSE_BACKBONE_0_SIG_SW,
									   .biasShift=LTC_DENSE_BACKBONE_0_SIG_SB};

constexpr DenseParams_t inStateParams = {.resolution=MODEL_RESOLUTION,
										 .neurons=LTC_DENSE_BACKBONE_0_STATE_UNITS,
										 .features=LTC_DENSE_BACKBONE_0_STATE_INFEATURES,
										 .inSize=1,
										 .inShift=LTC_DENSE_BACKBONE_0_SIG_INSTATESCALE,
										 .outShift=LTC_DENSE_BACKBONE_0_STATE_OUTNOACTIVATIONSCALE,
										 .weightShift=LTC_DENSE_BACKBONE_0_STATE_SW,
										 .biasShift=LTC_DENSE_BACKBONE_0_STATE_SB};

constexpr DenseParams_t ff1Params = {.resolution=MODEL_RESOLUTION,
									 .neurons=LTC_FF1_UNITS,
									 .features=LTC_FF1_INFEATURES,
									 .inSize=1,
									 .inShift=LTC_FF1_INSCALE,
									 .outShift=LTC_FF1_OUTNOACTIVATIONSCALE,
									 .weightShift=LTC_FF1_SW,
									 .biasShift=LTC_FF1_SB};

constexpr DenseParams_t ff2Params = {.resolution=MODEL_RESOLUTION,
									 .neurons=LTC_FF2_UNITS,
									 .features=LTC_FF2_INFEATURES,
									 .inSize=1,
									 .inShift=LTC_FF2_INSCALE,
									 .outShift=LTC_FF2_OUTNOACTIVATIONSCALE,
									 .weightShift=LTC_FF2_SW,
									 .biasShift=LTC_FF2_SB};

constexpr DenseParams_t taParams = {.resolution=MODEL_RESOLUTION,
									.neurons=LTC_TA_UNITS,
									.features=LTC_TA_INFEATURES,
									.inSize=1,
									.inShift=LTC_TA_INSCALE,
									.outShift=LTC_TA_OUTNOACTIVATIONSCALE,
									.weightShift=LTC_TA_SW,
									.biasShift=LTC_TA_SB};

constexpr DenseParams_t tbParams = {.resolution=MODEL_RESOLUTION,
								    .neurons=LTC_TB_UNITS,
								    .features=LTC_TB_INFEATURES,
								    .inSize=1,
								    .inShift=LTC_TB_INSCALE,
								    .outShift=LTC_TB_OUTNOACTIVATIONSCALE,
								    .weightShift=LTC_TB_SW,
								    .biasShift=LTC_TB_SB};
// Dense Out Params
constexpr DenseParams_t denseOutParams = {.resolution=MODEL_RESOLUTION,
										  .neurons=DENSE_OUT_UNITS,
										  .features=DENSE_OUT_INFEATURES,
										  .inSize=1,
										  .inShift=DENSE_OUT_DENSE_OUT_INSCALE,
										  .outShift=DENSE_OUT_DENSE_OUT_OUTNOACTIVATIONSCALE,
										  .weightShift=DENSE_OUT_SW,
										  .biasShift=DENSE_OUT_SB};



void model(const signal_t signalIn_reg, const timeIn_t timeIn_reg, out_t &output_reg, states_t &states){
#pragma HLS TOP name=model
#pragma HLS INTERFACE mode=ap_none port=states

//#pragma HLS DATAFLOW
#pragma HLS INTERFACE mode=s_axilite port=signalIn_reg
#pragma HLS INTERFACE mode=s_axilite port=timeIn_reg
#pragma HLS INTERFACE mode=s_axilite port=output_reg
#pragma HLS INTERFACE mode=s_axilite port=return
//#pragma HLS PIPELINE

#pragma HLS reset variable=LTC_STATES

#pragma HLS BIND_STORAGE variable=LTC_DENSE_BACKBONE_0_SIG_WEIGHTS type=rom_np impl=bram
#pragma HLS BIND_STORAGE variable=LTC_DENSE_BACKBONE_0_STATE_WEIGHTS type=rom_np impl=bram
#pragma HLS BIND_STORAGE variable=LTC_FF1_WEIGHTS type=rom_np impl=bram
#pragma HLS BIND_STORAGE variable=LTC_FF2_WEIGHTS type=rom_np impl=bram
#pragma HLS BIND_STORAGE variable=LTC_TA_WEIGHTS type=rom_np impl=bram
#pragma HLS BIND_STORAGE variable=LTC_TB_WEIGHTS type=rom_np impl=bram

#pragma HLS ARRAY_PARTITION factor=128 type=block variable=LTC_DENSE_BACKBONE_0_SIG_WEIGHTS
#pragma HLS ARRAY_PARTITION factor=128 type=block variable=LTC_DENSE_BACKBONE_0_STATE_WEIGHTS
/*
#pragma HLS ARRAY_PARTITION factor=32 type=block variable=LTC_FF1_WEIGHTS
#pragma HLS ARRAY_PARTITION factor=32 type=block variable=LTC_FF2_WEIGHTS
#pragma HLS ARRAY_PARTITION factor=32 type=block variable=LTC_TA_WEIGHTS
#pragma HLS ARRAY_PARTITION factor=32 type=block variable=LTC_TB_WEIGHTS
*/
/*
#pragma HLS ARRAY_RESHAPE type=complete variable=LTC_DENSE_BACKBONE_0_STATE_BIASES
#pragma HLS ARRAY_RESHAPE type=complete variable=LTC_DENSE_BACKBONE_0_SIG_BIASES
#pragma HLS ARRAY_RESHAPE type=complete variable=LTC_FF1_BIASES
#pragma HLS ARRAY_RESHAPE type=complete variable=LTC_FF2_BIASES
#pragma HLS ARRAY_RESHAPE type=complete variable=LTC_TA_BIASES
#pragma HLS ARRAY_RESHAPE type=complete variable=LTC_TB_BIASES
*/


	states_t statesTemp;
	for(size_t i=0; i<LTC_UNITS; ++i){
	#pragma HLS UNROLL
		statesTemp.range(MODEL_RESOLUTION*(i+1)-1, i*MODEL_RESOLUTION) = LTC_STATES[i];
	}
	states = statesTemp;


	modelData_t signalIn[SIGNAL_INPUTLAYER_SIZE];
	modelData_t time_In[TIME_INPUTLAYER_SIZE];
	modelData_t output[DENSE_OUT_UNITS];

	// restructure the input to an array for easier handling
	for(size_t i=0; i<SIGNAL_INPUTLAYER_SIZE; ++i){
#pragma HLS UNROLL
		signalIn[i] = signalIn_reg.range((i+1)*MODEL_RESOLUTION-1, i*MODEL_RESOLUTION);
	}

	for(size_t i=0; i<TIME_INPUTLAYER_SIZE; ++i){
#pragma HLS UNROLL
		time_In[i] = timeIn_reg.range((i+1)*MODEL_RESOLUTION-1, i*MODEL_RESOLUTION);
	}


	// create LTC layer
	constexpr int time_scale = 0;
	constexpr int ltc_outshift = -6;
	LTC<MODEL_RESOLUTION, time_scale, ltc_outshift, LTC_UNITS, inSigParams, inStateParams, ff1Params, ff2Params, taParams, tbParams> ltc(LTC_DENSE_BACKBONE_0_SIG_WEIGHTS, LTC_DENSE_BACKBONE_0_SIG_BIASES,
																																		LTC_DENSE_BACKBONE_0_STATE_WEIGHTS, LTC_DENSE_BACKBONE_0_STATE_BIASES,
																																		LTC_FF1_WEIGHTS, LTC_FF1_BIASES,
																																		LTC_FF2_WEIGHTS, LTC_FF2_BIASES,
																																		LTC_TA_WEIGHTS, LTC_TA_BIASES,
																																		LTC_TB_WEIGHTS, LTC_TB_BIASES,
																																		LTC_STATES);
	// create Dense layer
	Dense<denseOutParams> outDense(DENSE_OUT_WEIGHTS, DENSE_OUT_BIASES);
	ap_int<MODEL_RESOLUTION> ltcOut[LTC_UNITS];

	// inference
	ltc.evaluate(time_In[0], signalIn, ltcOut);
	outDense.evaluate(ltcOut, output);


	// pass outputs
	out_t tempOut; // this variable prevents hls to synthesise output_reg as read and write register
	for(size_t i=0; i<DENSE_OUT_UNITS; ++i){
#pragma HLS UNROLL
		tempOut.range((i+1)*MODEL_RESOLUTION-1, i*MODEL_RESOLUTION) = output[i];
	}
	output_reg = tempOut;
}


void clearStates(){
	for(size_t i=0; i<LTC_UNITS; ++i){
		LTC_STATES[i] = 0;
	}
}




