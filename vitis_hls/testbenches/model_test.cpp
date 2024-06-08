#include "model_test.h"
#include "ReportHandle.h"
#include "../src/model.h"

#define AP_INT_MAX_W 2048
#include <ap_int.h>

#include <iostream>
using namespace std;



bool model_test(){
	printHeader("Model_test");
	bool result = false;
	ReportHandle handle;

	constexpr size_t modelResolution = 8;
	typedef ap_int<modelResolution> model_t;

	float sigScale = 8.0f; // 2**LTC_DENSE_BACKBONE_0_SIG_INSCALE

	const float sigIn_f[17] = {1.250874400138854980, 2.310836222022771835e-03, 3.947382792830467224e-03, -3.730112453922629356e-03, 4.001221153885126114e-03, 2.388361375778913498e-03, -2.620986197143793106e-03, 1.691619632765650749e-03, 4.450761713087558746e-03, 3.629133338108658791e-03, 4.599495325237512589e-03, -2.269585616886615753e-03, -1.738601480610668659e-03, -1.874414505437016487e-03, -6.571317207999527454e-04, 1.412279903888702393e-03, -1.450779032893478870e-03};
	model_t timeIn_arr[1] = {1};

	signal_t sigIn;
	timeIn_t timeIn = timeIn_arr[0];

	// quantisation
	model_t sigIn_arr[17];
	for(size_t i=0; i<17; ++i){
		sigIn_arr[i] = (model_t)(sigIn_f[i] * sigScale);
	}

	// data aggregation to passing structure
	for(size_t i=0; i<17; ++i){
		sigIn.range((i+1)*modelResolution-1, i*modelResolution) = sigIn_arr[i];
	}

	// print input structure
	for(size_t i=0; i<17; ++i){
		cout << "sigIn[" << i << "] = " << sigIn.range((i+1)*modelResolution-1, i*modelResolution) << endl;
	}


	// call model
	out_t output;
	states_t states;

	//debut_t debugPort;
	model(sigIn, timeIn, output, states);

	result |= states!= 0;

/*
	for(size_t i=0; i<debugSize; ++i){
		ap_int<8> temp = ap_int<8>(debugPort.range((i+1)*modelResolution-1, i*modelResolution)); //.range returns ap_uint
		cout << "debugPort[" << i << "] = " << temp << endl;
	}*/


	ap_int<8> dut[17];
	// print output structure
	for(size_t i=0; i<17; ++i){
		dut[i] = ap_int<8>(output.range((i+1)*modelResolution-1, i*modelResolution)); //.range returns ap_uint
		cout << "modelout[" << i << "] = " << ap_int<8>(output.range((i+1)*modelResolution-1, i*modelResolution)) << endl;
	}

	const ap_int<8> expected[17] = {10, -1, -3, -1, 3, -1, -4, 1, 6, -1, -4, 4, -9, 44, 14, -32, 35};

	handle.test_arr_equal(dut, expected, 17);
	handle.print();
	result |= handle.getError();
	return result;
}
