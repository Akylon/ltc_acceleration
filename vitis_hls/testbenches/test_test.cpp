#include "test_test.h"
#include "ReportHandle.h"
#include "../src/test.h"

#define AP_INT_MAX_W 2048
#include <ap_int.h>

#include <iostream>
using namespace std;


bool test_test(){
	printHeader("test_test");
	bool result = false;
	ReportHandle handle;

	constexpr size_t modelResolution = 8;
	typedef ap_int<modelResolution> model_t;

	float sigScale = 8.0f; // 2**LTC_DENSE_BACKBONE_0_SIG_INSCALE

	const float sigIn_f[64] = {0};//{1.250874400138854980, 2.310836222022771835e-03, 3.947382792830467224e-03, -3.730112453922629356e-03, 4.001221153885126114e-03, 2.388361375778913498e-03, -2.620986197143793106e-03, 1.691619632765650749e-03, 4.450761713087558746e-03, 3.629133338108658791e-03, 4.599495325237512589e-03, -2.269585616886615753e-03, -1.738601480610668659e-03, -1.874414505437016487e-03, -6.571317207999527454e-04, 1.412279903888702393e-03, -1.450779032893478870e-03};


	// quantisation
	model_t sigIn_arr[64];
	for(size_t i=0; i<64; ++i){
		sigIn_arr[i] = (model_t)(sigIn_f[i] * sigScale);
		cout << "sigIn_arr" << i << "]=" << sigIn_arr[i] << endl;
	}


	// call model
	ap_int<8*256> output;
	ap_int<8*64> inputs;

	for(size_t i=0; i<64; ++i){
		inputs.range((i+1)*8-1, 8*i) = sigIn_arr[i];
	}

	for(size_t i=0; i<64; ++i){
		cout << "inputs[" << i << "]=" << inputs.range((i+1)*8-1, 8*i) << endl;;
	}

	cout << "inputs=" << inputs << endl;

	//debut_t debugPort;
	test(inputs, output);

	/*for(size_t i=0; i<debugSize; ++i){
		ap_int<8> temp = ap_int<8>(debugPort.range((i+1)*modelResolution-1, i*modelResolution)); //.range returns ap_uint
		cout << "debugPort[" << i << "] = " << temp << endl;
	}*/


	ap_int<8> dut[256];
	for(size_t i=0; i<256; ++i){
		dut[i] = output.range((i+1)*8-1, 8*i);
		cout << "dut[" << i << "] = " << dut[i] << endl;
	}


	const ap_int<8> expected[256] = {11, 0, -3, -1, 3, -1, -3, -2, 6, 2, -9, 15, -37, 52, 5, -32, 70};

	handle.test_arr_equal(dut, expected, 256);
	result |= handle.getError();
	result = false;
	return result;
}
