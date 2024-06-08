#include "quantMul_test.h"
#include "ReportHandle.h"
#include "../src/quantOperations.h"

bool quantMul_test(){
	bool result = false;
	ReportHandle handle;

	printHeader("quantMul_test");




	// case sW*sI > sb
	{
	handle.init();
	handle.setTestName("Test case: sw*si>sb");

	constexpr size_t nIn = 10;
	constexpr size_t nOut = 8;
	typedef ap_int<nIn> In_t;
	typedef ap_int<nOut> Out_t;

	constexpr int sIn1 = -3;
	constexpr int sIn2 = 2;
	constexpr int sOut = -2;


	const In_t in1[3] = {12, 18, 3};
	const In_t in2[3] = {-3, 3, -18};


	Out_t dut[2] = {0};
	const Out_t expected[3] = {-72, 108, -108};

	for(size_t i=0; i<3; ++i){
		quantMul<nIn, nOut, sIn1, sIn2, sOut>(in1[i], in2[i], dut[i]);

	}
	handle.test_arr_equal(dut, expected, 3);
	handle.print();
	result |= handle.getError();
	}

	return result;
}
