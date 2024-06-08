#include "ReportHandle.h"
#include "../src/activation_tanh.h"
#include "ap_int.h"

bool tanh_optimal_test(){
    printHeader("tanh_optimal_test");
    bool result = false;

    ReportHandle handle;

    {
		handle.init();
		handle.setTestName("negative inShift test");
		const int inShift = -5;
		const size_t inSize = 11;
		const ap_int<8> input[inSize] = {64, 42, 41, 31, 13, 0, -13, -31, -41, -42, -64};
		ap_int<8> dut[inSize] = {0};
		const ap_int<8> expected[inSize] = {64, 64, 62, 47, 19, 0, -20, -48, -63, -64, -64};

		activation_tanh_optimal<8, inShift>(input, dut, inSize);

		handle.test_arr_equal(dut, expected, inSize);
		handle.print();
		result |= handle.getError();
    }


    {
		handle.init();
		handle.setTestName("positive inShift test");
		const int inShift = 1;
		const size_t inSize = 7;
		const ap_int<8> input[inSize] = {64, 2, 1, 0, -1, -2, -64};
		ap_int<8> dut[inSize] = {0};
		const ap_int<8> expected[inSize] = {64, 64, 64, 0, -64, -64, -64};

		activation_tanh_optimal<8, inShift>(input, dut, inSize);

		handle.test_arr_equal(dut, expected, inSize);
		handle.print();
		result |= handle.getError();
	}

    return result;
}
