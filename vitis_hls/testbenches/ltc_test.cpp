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
										 .outShift=-3,
										 .weightShift=-5,
										 .biasShift=-3};

constexpr DenseParams_t ff1Params = {.resolution=modelResolution,
									 .neurons=3,
									 .features=2,
									 .inSize=1,
									 .inShift=-3,
									 .outShift=-3,
									 .weightShift=-3,
									 .biasShift=-6};

constexpr DenseParams_t ff2Params = {.resolution=modelResolution,
									 .neurons=3,
									 .features=2,
									 .inSize=1,
									 .inShift=-3,
									 .outShift=-5,
									 .weightShift=-7,
									 .biasShift=-8};

constexpr DenseParams_t taParams = {.resolution=modelResolution,
									.neurons=3,
									.features=2,
									.inSize=1,
									.inShift=-3,
									.outShift=-1,
									.weightShift=-7,
									.biasShift=0};

constexpr DenseParams_t tbParams = {.resolution=modelResolution,
								    .neurons=3,
								    .features=2,
								    .inSize=1,
								    .inShift=-3,
								    .outShift=2,
								    .weightShift=-1,
								    .biasShift=3};


bool ltc_test(){
	printHeader("LTC_test");
	bool result = false;
	ReportHandle handle;

	handle.init();
	handle.setTestName("some values test");

	// define backbone
	const ap_int<modelResolution> inSigBiases[inSigParams.neurons] = {64, -16};
	const ap_int<modelResolution> inSigWeights[inSigParams.neurons][inSigParams.features] = {{32, 64, 96},
																							{-32, -64, -96}};

	const ap_int<modelResolution> inStateBiases[inStateParams.neurons] = {32, -64};
	const ap_int<modelResolution> inStateWeights[inStateParams.neurons][inStateParams.features] = {{-32, -64, -96},
																								   {32, 64, 96}};

	// define ff1
	const ap_int<modelResolution> ff1Weights[ff1Params.neurons][ff1Params.features] = {{8, -24},
																					  {1, -1},
																					  {-8, 88}};
	const ap_int<modelResolution> ff1Biases[ff1Params.neurons] = {-64, -32, 64};


	// define ff2
	const ap_int<modelResolution> ff2Weights[ff2Params.neurons][ff2Params.features] = {{8, -32},
																					  {16, -16},
																					  {-32, -64}};
	const ap_int<modelResolution> ff2Biases[ff2Params.neurons] = {-32, 64, 32};


	// define ta
	const ap_int<modelResolution> taWeights[taParams.neurons][taParams.features] = {{-64, -8},
																					{32, 4},
																					{16, -32}};
	const ap_int<modelResolution> taBiases[taParams.neurons] = {32, -64, 0};


	// define tb
	const ap_int<modelResolution> tbWeights[tbParams.neurons][tbParams.features] = {{64, -1},
																				    {32, -2},
																				    {16, 16}};
	const ap_int<modelResolution> tbBiases[tbParams.neurons] = {-100, -50, -32};


	constexpr size_t ltcUnits = 3;
	constexpr int ltcOutShift = -6;
	constexpr int tShift = 0;

	ap_int<modelResolution> states[ltcUnits] = {0};
	LTC<modelResolution, tShift, ltcOutShift, ltcUnits, inSigParams, inStateParams, ff1Params, ff2Params, taParams, tbParams> ltc(*inSigWeights, inSigBiases, *inStateWeights, inStateBiases, *ff1Weights, ff1Biases, *ff2Weights, ff2Biases, *taWeights, taBiases, *tbWeights, tbBiases, states);

	const ap_int<modelResolution> sig[inSigParams.inSize*inSigParams.features] = {-96, 64, 32};
	ap_int<modelResolution> outputs[inSigParams.inSize*ltcUnits] = {0};
	const ap_int<modelResolution> t = 2;

	const ap_int<modelResolution> initStates[ltcUnits] = {64, 64, -16};

	ltc.setStates(initStates);
	ltc.evaluate(t, sig, outputs);


	const ap_int<modelResolution> expection[ltcUnits] = {64, 30, -64};


	handle.test_arr_equal(outputs, expection, ltcUnits);
	handle.print();
	result |= handle.getError();
	return result;
}
