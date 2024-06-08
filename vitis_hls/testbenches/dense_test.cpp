#include "ReportHandle.h"
#include "../src/dense.h"
#include "dense_test.h"

#include "ap_int.h"

constexpr size_t bitwidth = 8;
typedef ap_int<bitwidth> Model_t;


constexpr DenseParams_t params = {.resolution=bitwidth,
								  .neurons=4,
								  .features=3,
								  .inSize=1,
								  .inShift=-5,
							      .outShift=-1,
 	 	 	 	 	 	 	      .weightShift=-3,
								  .biasShift=-3};

bool dense_test(){
    printHeader("dense_test");
    bool result = false;

    ReportHandle handle;

    // no inscale test
    {
    constexpr size_t inSize = 1;
    constexpr size_t nFeatures = 3;
    constexpr size_t neurons = 4;

    handle.init();
    handle.setTestName("Array test");
    // actual input = {-2, 0, 1}
    const int inScale = -5;
    const Model_t input[nFeatures*inSize] = {-64, 0, 32};

    // actual weights =
    //{{-11, 2, 3},
    // {13, 4, -8},
    // {1, 3, 7},
    // {9, 2, -7}};
    const int wScale = -3;
    const Model_t weights[neurons*nFeatures] = {-88, 16, 24,
												 104, 32, -64,
												 8, 24, 56,
												 72, 16, -56};
    // actual biases = {10, -4, 3, -7}
    const int bScale = -3;
    const Model_t biases[neurons] = {80, -32, 24, -56};


    // actual expected = {35, -38, 8, -32};
    const int outScale = -1; // output must be shifted by one to the left. output = value*2
    const Model_t expected[neurons] = {70, -76, 16, -64};

    // call model
    Model_t dut[neurons] = {0};


    // check output
    Dense<params> dense(weights, biases);
    dense.evaluate(input, dut);

    handle.test_arr_equal(dut, expected, neurons);
    handle.print();
    result |= handle.getError();
    }
    return result;
}
