#include "ReportHandle.h"
#include "../src/activation_sigmoid.h"
#include "sigmoid_test.h"

#include "ap_int.h"

#include <iostream>
using namespace std;

constexpr size_t bitwidth = 8;
typedef ap_int<bitwidth> Model_t;

bool sigmoid_test(){
    printHeader("sigmoid_test");
    bool result = false;

    ReportHandle handle;

    // 1D array test
    {
		constexpr int scaleIn = -4;

		handle.init();
		handle.setTestName("1D Array test");
		const Model_t input[5] = {-64, -32, 0, 16, 48};
		Model_t dut[5] = {0};
		const Model_t expected[5] = {0, 10, 32, 42, 64};
		activation_sigmoid<bitwidth, bitwidth, scaleIn>(input, dut, 5);
		handle.test_arr_equal(dut, expected, 5);
		handle.print();
		result |= handle.getError();
    }


    {
		handle.init();
		handle.setTestName("quantSigmoid_test");

		constexpr int shifts[5] = 	 {0,  -1,  -2,  1,  2};

		const Model_t input[6][5] = {{-4, -7, -13, -2, -2},
									 {-3, -6, -12, -1, -1},
									 {-2, -5, -11, -0, -0},
									 { 2,  5,  11,  0,  0},
									 { 3,  6,  12,  1,  1},
									 { 4,  7,  13,  2,  2}};

		const Model_t expected[6][5] = {{ 0,  0,  0,  0,  0},
										{ 0,  0,  0, 10,  0},
										{10,  5,  2, 32, 32},
										{53, 58, 61, 32, 32},
										{63, 63, 63, 53, 64},
										{64, 64, 64, 64, 64}};

		Model_t dut[6][5];


		for(size_t i=0; i<6; ++i){
			quantSigmoid<bitwidth, bitwidth, shifts[0]>(input[i][0], dut[i][0]);
			quantSigmoid<bitwidth, bitwidth, shifts[1]>(input[i][1], dut[i][1]);
			quantSigmoid<bitwidth, bitwidth, shifts[2]>(input[i][2], dut[i][2]);
			quantSigmoid<bitwidth, bitwidth, shifts[3]>(input[i][3], dut[i][3]);
			quantSigmoid<bitwidth, bitwidth, shifts[4]>(input[i][4], dut[i][4]);
		}

		/*for(size_t row=0; row<6; ++row){
			for(size_t col=0; col<5; ++col){
				cout << dut[row][col] << ", ";
			}
			cout << endl;
		}*/

		handle.test_arr_equal(*dut, *expected, 30);
		handle.print();
		result |= handle.getError();
	}


    {
		handle.init();
		handle.setTestName("quantSigmoidPosResolution_test");

		constexpr int shifts[5] =    {0,  -1,  -2,  1,  2};

		const Model_t input[6][5] = {{-4, -7, -13, -3, -2},
									 {-3, -6, -12, -2, -1},
									 {-2, -5, -11, -1, -0},
									 { 2,  5,  11,  1,  0},
									 { 3,  6,  12,  2,  1},
									 { 4,  7,  13,  3,  2}};

		const ap_int<bitwidth+1> expected[6][5] = {{ 0,  0,  0,  0,  0},
												   { 0,  0,  0, 0,  0},
												   {21,  10,  5, 21, 64},
												   {106, 117, 122, 106, 64},
												   {127, 127, 127, 128, 128},
												   {128, 128, 128, 128, 128}};

		ap_int<bitwidth+1> dut[6][5];


		for(size_t i=0; i<6; ++i){
			quantSigmoid<bitwidth, bitwidth+1, shifts[0]>(input[i][0], dut[i][0]);
			quantSigmoid<bitwidth, bitwidth+1, shifts[1]>(input[i][1], dut[i][1]);
			quantSigmoid<bitwidth, bitwidth+1, shifts[2]>(input[i][2], dut[i][2]);
			quantSigmoid<bitwidth, bitwidth+1, shifts[3]>(input[i][3], dut[i][3]);
			quantSigmoid<bitwidth, bitwidth+1, shifts[4]>(input[i][4], dut[i][4]);
		}

		handle.test_arr_equal(*dut, *expected, 30);
		handle.print();
		result |= handle.getError();
	}

    {
		handle.init();
		handle.setTestName("quantSigmoidNegResolution_test");

		constexpr int shifts[5] = {0, -1, -2, 1, 2};
		const Model_t input[6][5] = {{-4, -7, -13, -3, -2},
									 {-3, -6, -12, -2, -1},
									 {-2, -5, -11, -1, -0},
									 { 2,  5,  11,  1,  0},
									 { 3,  6,  12,  2,  1},
									 { 4,  7,  13,  3,  2}};
		const ap_int<bitwidth-1> expected[6][5] = {{ 0,  0,  0,  0,  0},
												  { 0,  0,  0, 0,  0},
												  { 5,  2,  1, 5, 16},
												  {26, 29, 30, 26, 16},
												  {31, 31, 31, 32, 32},
												  {32, 32, 32, 32, 32}};

		const ap_int<bitwidth-1> wrongExpected[6][5] = {{ 1,  2,  3,  4,  5},
													    { 1,  1,  1, 6,  1},
													    { 4,  4,  -1, 11, 17},
													    {25, 28, 31, 21, 15},
													    {32, 32, 32, 25, 31},
													    {31, 31, 31, 31, 31}};

		ap_int<bitwidth-1> dut[6][5];


		for(size_t i=0; i<6; ++i){
			quantSigmoid<bitwidth, bitwidth-1, shifts[0]>(input[i][0], dut[i][0]);
			quantSigmoid<bitwidth, bitwidth-1, shifts[1]>(input[i][1], dut[i][1]);
			quantSigmoid<bitwidth, bitwidth-1, shifts[2]>(input[i][2], dut[i][2]);
			quantSigmoid<bitwidth, bitwidth-1, shifts[3]>(input[i][3], dut[i][3]);
			quantSigmoid<bitwidth, bitwidth-1, shifts[4]>(input[i][4], dut[i][4]);
		}

		handle.test_arr_equal(*dut, *expected, 30);
		result |= handle.getError();
		handle.print();

		handle.init();
		handle.setTestName("quantSigmoidFalseCheck");
		handle.test_arr_not_equal(*dut, *wrongExpected, 30);
		handle.print();
		result |= handle.getError();
	}

    return result;
}
