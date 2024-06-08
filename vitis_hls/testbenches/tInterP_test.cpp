#include "ltc_test.h"
#include "ReportHandle.h"
#include "../src/LTC.h"

#include <ap_int.h>

constexpr size_t modelResolution = 8;


constexpr DenseParams_t inSigParams = {.resolution=modelResolution,
									   .neurons=2,
									   .features=3,
									   .inSize=1,
									   .inShift=-5,
									   .outShift=-3,
									   .weightShift=-5,
									   .biasShift=-4};

constexpr DenseParams_t inStateParams = {.resolution=modelResolution,
										 .neurons=2,
										 .features=3,
										 .inSize=1,
										 .inShift=-6,
										 .outShift=-2,
										 .weightShift=-5,
										 .biasShift=-1};

constexpr DenseParams_t ff1Params = {.resolution=modelResolution,
									 .neurons=1,
									 .features=2,
									 .inSize=1,
									 .inShift=-1,
									 .outShift=-6,
									 .weightShift=-5,
									 .biasShift=-6};

constexpr DenseParams_t ff2Params = {.resolution=modelResolution,
									 .neurons=1,
									 .features=2,
									 .inSize=1,
									 .inShift=-1,
									 .outShift=-6,
									 .weightShift=-4,
									 .biasShift=-7};

constexpr DenseParams_t taParams = {.resolution=modelResolution,
									.neurons=1,
									.features=2,
									.inSize=1,
									.inShift=-1,
									.outShift=2,
									.weightShift=-7,
									.biasShift=0};

constexpr DenseParams_t tbParams = {.resolution=modelResolution,
								    .neurons=1,
								    .features=2,
								    .inSize=1,
								    .inShift=-1,
								    .outShift=-3,
								    .weightShift=0-1,
								    .biasShift=3};

constexpr DenseParams_t ff1ParamsReasonable = {.resolution=modelResolution,
									 .neurons=1,
									 .features=2,
									 .inSize=1,
									 .inShift=-1,
									 .outShift=-6,
									 .weightShift=-5,
									 .biasShift=-6};

constexpr DenseParams_t ff2ParamsReasonable = {.resolution=modelResolution,
									 .neurons=1,
									 .features=2,
									 .inSize=1,
									 .inShift=-1,
									 .outShift=-4,
									 .weightShift=-4,
									 .biasShift=-7};

constexpr DenseParams_t taParamsReasonable = {.resolution=modelResolution,
									.neurons=1,
									.features=2,
									.inSize=1,
									.inShift=-1,
									.outShift=-8,
									.weightShift=-7,
									.biasShift=0};

constexpr DenseParams_t tbParamsReasonable = {.resolution=modelResolution,
								    .neurons=1,
								    .features=2,
								    .inSize=1,
								    .inShift=-1,
								    .outShift=-5,
								    .weightShift=0-1,
								    .biasShift=3};


bool tInterP_test(){
	printHeader("tInterP_test");
	bool result = false;
	ReportHandle handle;
	{
		handle.init();
		handle.setTestName("maxVals Test");
		// define backbone
		const ap_int<modelResolution> inSigBiases[inSigParams.neurons] = {64, -16};
		const ap_int<modelResolution> inSigWeights[inSigParams.neurons][inSigParams.features] = {{32, 64, 96},
																								{-32, -64, -96}};

		const ap_int<modelResolution> inStateBiases[inStateParams.neurons] = {32, -64};
		const ap_int<modelResolution> inStateWeights[inStateParams.neurons][inStateParams.features] = {{-32, -64, -96},
																									   {32, 64, 96}};

		// define ff1
		const ap_int<modelResolution> ff1Weights[ff1Params.neurons][ff1Params.features] = {{32, -96}};
		const ap_int<modelResolution> ff1Biases[ff1Params.neurons] = {-64};


		// define ff2
		const ap_int<modelResolution> ff2Weights[ff2Params.neurons][ff2Params.features] = {{16, 32}};
		const ap_int<modelResolution> ff2Biases[ff2Params.neurons] = {64};


		// define ta
		const ap_int<modelResolution> taWeights[taParams.neurons][taParams.features] = {{-64, -8}};
		const ap_int<modelResolution> taBiases[taParams.neurons] = {32};


		// define tb
		const ap_int<modelResolution> tbWeights[tbParams.neurons][tbParams.features] = {{64, -1}};
		const ap_int<modelResolution> tbBiases[tbParams.neurons] = {-100};

		// create dut
		constexpr size_t ltcUnits = 1;
		constexpr int ltcOutShift = 0;
		constexpr int tShift = 0;
		ap_int<modelResolution> states[ltcUnits] = {0};

		LTC<modelResolution, tShift, ltcOutShift, ltcUnits, inSigParams, inStateParams, ff1Params, ff2Params, taParams, tbParams> ltc(*inSigWeights, inSigBiases, *inStateWeights, inStateBiases, *ff1Weights, ff1Biases, *ff2Weights, ff2Biases, *taWeights, taBiases, *tbWeights, tbBiases, states);

		// init dut
		const ap_int<modelResolution> initStates[ltcUnits] = {0};
		ltc.setStates(initStates);

		// prepare test data
		const ap_int<modelResolution> ff1Out[ff1Params.neurons] = {64};
		const ap_int<modelResolution> ff2Out[ff2Params.neurons] = {64};
		const ap_int<modelResolution> taOut[taParams.neurons] = {127};
		const ap_int<modelResolution> tbOut[tbParams.neurons] = {127};
		const ap_int<modelResolution> t = 127;

		const ap_int<modelResolution> expected[1] = {64};

		// call dut
		ltc.updateState(t, ff1Out, ff2Out, taOut, tbOut);

		ap_int<modelResolution> resStates[1];
		ltc.getStates(resStates);

		// evaluate results
		handle.test_arr_equal(resStates, expected, 1);
		handle.print();
		result |= handle.getError();
	}

	// ************************************************************************************

	{
		handle.init();
		handle.setTestName("minVals Test");
		// define backbone
		const ap_int<modelResolution> inSigBiases[inSigParams.neurons] = {64, -16};
		const ap_int<modelResolution> inSigWeights[inSigParams.neurons][inSigParams.features] = {{32, 64, 96},
																								{-32, -64, -96}};

		const ap_int<modelResolution> inStateBiases[inStateParams.neurons] = {32, -64};
		const ap_int<modelResolution> inStateWeights[inStateParams.neurons][inStateParams.features] = {{-32, -64, -96},
																									   {32, 64, 96}};

		// define ff1
		const ap_int<modelResolution> ff1Weights[ff1Params.neurons][ff1Params.features] = {{32, -96}};
		const ap_int<modelResolution> ff1Biases[ff1Params.neurons] = {-64};


		// define ff2
		const ap_int<modelResolution> ff2Weights[ff2Params.neurons][ff2Params.features] = {{16, 32}};
		const ap_int<modelResolution> ff2Biases[ff2Params.neurons] = {64};


		// define ta
		const ap_int<modelResolution> taWeights[taParams.neurons][taParams.features] = {{-64, -8}};
		const ap_int<modelResolution> taBiases[taParams.neurons] = {32};


		// define tb
		const ap_int<modelResolution> tbWeights[tbParams.neurons][tbParams.features] = {{64, -1}};
		const ap_int<modelResolution> tbBiases[tbParams.neurons] = {-100};

		// create dut
		constexpr size_t ltcUnits = 1;
		constexpr int ltcOutShift = 0;
		constexpr int tShift = 0;
		ap_int<modelResolution> states[ltcUnits] = {0};

		LTC<modelResolution, tShift, ltcOutShift, ltcUnits, inSigParams, inStateParams, ff1Params, ff2Params, taParams, tbParams> ltc(*inSigWeights, inSigBiases, *inStateWeights, inStateBiases, *ff1Weights, ff1Biases, *ff2Weights, ff2Biases, *taWeights, taBiases, *tbWeights, tbBiases, states);

		// init dut
		const ap_int<modelResolution> initStates[ltcUnits] = {0};
		ltc.setStates(initStates);

		// prepare test data
		const ap_int<modelResolution> ff1Out[ff1Params.neurons] = {-64};
		const ap_int<modelResolution> ff2Out[ff2Params.neurons] = {-64};
		const ap_int<modelResolution> taOut[taParams.neurons] = {-127};
		const ap_int<modelResolution> tbOut[tbParams.neurons] = {-127};
		const ap_int<modelResolution> t = -127;

		const ap_int<modelResolution> expected[1] = {-64};

		// call dut
		ltc.updateState(t, ff1Out, ff2Out, taOut, tbOut);

		ap_int<modelResolution> resStates[1];
		ltc.getStates(resStates);

		// evaluate results
		handle.test_arr_equal(resStates, expected, 1);
		handle.print();
		result |= handle.getError();
	}

	// ************************************************************************************

	{
		handle.init();
		handle.setTestName("reasonable Test");
		// define backbone
		const ap_int<modelResolution> inSigBiases[inSigParams.neurons] = {64, -16};
		const ap_int<modelResolution> inSigWeights[inSigParams.neurons][inSigParams.features] = {{32, 64, 96},
																								{-32, -64, -96}};

		const ap_int<modelResolution> inStateBiases[inStateParams.neurons] = {32, -64};
		const ap_int<modelResolution> inStateWeights[inStateParams.neurons][inStateParams.features] = {{-32, -64, -96},
																									   {32, 64, 96}};

		// define ff1
		const ap_int<modelResolution> ff1Weights[ff1Params.neurons][ff1Params.features] = {{32, -96}};
		const ap_int<modelResolution> ff1Biases[ff1Params.neurons] = {-64};


		// define ff2
		const ap_int<modelResolution> ff2Weights[ff2Params.neurons][ff2Params.features] = {{16, 32}};
		const ap_int<modelResolution> ff2Biases[ff2Params.neurons] = {64};


		// define ta
		const ap_int<modelResolution> taWeights[taParams.neurons][taParams.features] = {{-64, -8}};
		const ap_int<modelResolution> taBiases[taParams.neurons] = {32};


		// define tb
		const ap_int<modelResolution> tbWeights[tbParams.neurons][tbParams.features] = {{64, -1}};
		const ap_int<modelResolution> tbBiases[tbParams.neurons] = {-100};

		// create dut
		constexpr size_t ltcUnits = 1;
		constexpr int ltcOutShift = 0;
		constexpr int tShift = -6;
		ap_int<modelResolution> states[ltcUnits] = {0};

		LTC<modelResolution, tShift, ltcOutShift, ltcUnits, inSigParams, inStateParams, ff1ParamsReasonable, ff2ParamsReasonable, taParamsReasonable, tbParamsReasonable> ltc(*inSigWeights, inSigBiases, *inStateWeights, inStateBiases, *ff1Weights, ff1Biases, *ff2Weights, ff2Biases, *taWeights, taBiases, *tbWeights, tbBiases, states);

		// init dut
		const ap_int<modelResolution> initStates[ltcUnits] = {0};
		ltc.setStates(initStates);

		// prepare test data
		const ap_int<modelResolution> ff1Out[ff1Params.neurons] = {32};
		const ap_int<modelResolution> ff2Out[ff2Params.neurons] = {-48};
		const ap_int<modelResolution> taOut[taParams.neurons] = {-12};
		const ap_int<modelResolution> tbOut[tbParams.neurons] = {6};
		const ap_int<modelResolution> t = 64;

		const ap_int<modelResolution> expected[1] = {-11};

		// call dut
		ltc.updateState(t, ff1Out, ff2Out, taOut, tbOut);

		ap_int<modelResolution> resStates[1];
		ltc.getStates(resStates);

		// evaluate results
		handle.test_arr_equal(resStates, expected, 1);
		handle.print();
		result |= handle.getError();
	}


	return result;
}
