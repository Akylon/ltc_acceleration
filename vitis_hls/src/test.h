#pragma once


#define AP_INT_MAX_W 2048
#include "ap_int.h"


void test(const ap_int<8*64> inputs, ap_int<8*256> &outputs);
