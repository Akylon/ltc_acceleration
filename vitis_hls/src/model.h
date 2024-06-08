#pragma once
#define AP_INT_MAX_W 2048
#include <ap_int.h>

#include "../../model/data/model_quant_export/walker_relu_tanh_quant_config.h"

typedef ap_int<SIGNAL_INPUTLAYER_SIZE*MODEL_RESOLUTION> signal_t;
typedef ap_int<MODEL_RESOLUTION> timeIn_t;
typedef ap_int<DENSE_OUT_UNITS*MODEL_RESOLUTION> out_t;
typedef ap_int<MODEL_RESOLUTION*LTC_UNITS> states_t;


void model(const signal_t signalIn_reg, const timeIn_t timeIn_reg, out_t &output_reg, states_t &states);
void clearStates();
