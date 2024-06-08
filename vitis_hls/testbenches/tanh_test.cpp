#include "ReportHandle.h"
#include "../src/activation_tanh.h"
#include "ap_int.h"

bool tanh_test(){
    printHeader("tanh_test");
    bool result = false;

    ReportHandle handle;

    // 1D array test
    {
    handle.init();
    handle.setTestName("1D Array test");
    const int inShift = -5;
    const size_t inSize = 9;
    const ap_int<8> input[inSize] = {64, 33, 32, 31, 0, -31, -32, -33, -8};
    ap_int<8> dut[inSize] = {0};
    const ap_int<8> expected[inSize] = {32, 32, 32, 31, 0, -31, -32, -32, -8};
    activation_tanh<8, inShift>(input, dut, inSize);
    handle.test_arr_equal(dut, expected, inSize);
    handle.print();
    result |= handle.getError();
    }

    // 2D array test
    {
    handle.init();
    handle.setTestName("2D Array test");
    const int inShift = 0;
    const ap_int<8>  input[3][2] = {{-62, 0},
								   {1, 2},
								   {-1, -2}};
    ap_int<8>  dut[3][2] = {{0}};
    const ap_int<8>  expected[3][2] = {{-1, 0},
									  {1, 1},
									  {-1, -1}};
    activation_tanh<8, inShift>(*input, *dut, 6);
    handle.test_arr_equal(*dut, *expected, 2*3);
    handle.print();
    result |= handle.getError();
    }
    return result;
}
