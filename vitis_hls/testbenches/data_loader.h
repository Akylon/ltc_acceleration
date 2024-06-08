#pragma once

#include <cstdint>
#include <cstdbool>

bool load_float_matrix(const char *const path, float *const matrix, const size_t rows, const size_t cols);
bool store_float_matrix(const char *const path, const float *const matrix, const size_t rows, const size_t cols);
bool store_int_matrix(const char *const path, const int *const matrix, const size_t rows, const size_t cols);
