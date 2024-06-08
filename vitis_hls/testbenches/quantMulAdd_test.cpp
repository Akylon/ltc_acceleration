#include "quantMulAdd_test.h"
#include "ReportHandle.h"
#include "../src/quantOperations.h"

bool quantMulAdd_test(){
	bool result = false;
	ReportHandle handle;

	printHeader("quantMulAdd_test");

	constexpr size_t n = 8;
	typedef ap_int<n> Model_t;


	// case sW*sI > sb
	{
	constexpr int sW = 3;
	constexpr int sI = -1;
	constexpr int sB = 0;
	constexpr int sOut = 9;


	handle.init();
	handle.setTestName("Test case: sw*si>sb");

	const Model_t input[2] = {127, -127};
	const Model_t w[2] = {127, 127};
	const Model_t b[2] = {127, -127};

	Model_t dut[2] = {0};
	const Model_t expected[2] = {126, -127};

	for(size_t i=0; i<2; ++i){
		quantMulAdd<n, n, sI, sOut, sW, sB>(input[i], dut[i], b[i], w[i]);

	}
	handle.test_arr_equal(dut, expected, 2);
	handle.print();
	result |= handle.getError();
	}



	// case sW*sI < sb and n>log2(sb/(sw*si)
	{
	constexpr int sW = 0;
	constexpr int sI = 0;
	constexpr int sB = 0;
	constexpr int sOut = 7;


	handle.init();
	handle.setTestName("Test case: sw*si<sb and n>log2(sb/(sw*si)");

	const Model_t input[2] = {127, -127};
	const Model_t w[2] = {127, 127};
	const Model_t b[2] = {127, -127};

	Model_t dut[2] = {0};
	const Model_t expected[2] = {127, -127};

	for(size_t i=0; i<2; ++i){
		quantMulAdd<n, n, sI, sOut, sW, sB>(input[i], dut[i], b[i], w[i]);

	}
	handle.test_arr_equal(dut, expected, 2);
	handle.print();
	result |= handle.getError();
	}



	// case sW*sI < sb and n<log2(sb/(sw*si)
	{
	constexpr int sW = -1;
	constexpr int sI = -2;
	constexpr int sB = 6;
	constexpr int sOut = 7;


	handle.init();
	handle.setTestName("Test case: sw*si<sb and n<log2(sb/(sw*si)");

	const Model_t input[2] = {127, -127};
	const Model_t w[2] = {127, 127};
	const Model_t b[2] = {127, -127};

	Model_t dut[2] = {0};
	const Model_t expected[2] = {79, -80};

	for(size_t i=0; i<2; ++i){
		quantMulAdd<n, n, sI, sOut, sW, sB>(input[i], dut[i], b[i], w[i]);

	}
	handle.test_arr_equal(dut, expected, 2);
	handle.print();
	result |= handle.getError();
	}

	return result;
}
