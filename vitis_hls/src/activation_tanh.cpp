#include "activation_tanh.h"
#include <math.h>

void activation_tanhf(const float *const x, float *const y, size_t size){
    while(size>0){
        --size;
        y[size] = tanhf(x[size]);
    };
};

void activation_tanh(const double *const x, double *const y, size_t size){
    while(size>0){
        --size;
        y[size] = tanh(x[size]);
    };
};

void activation_tanhl(const long double *const x, long double *const y, size_t size){
    while(size>0){
        --size;
        y[size] = tanhl(x[size]);
    };
};