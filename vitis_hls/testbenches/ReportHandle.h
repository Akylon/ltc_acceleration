#pragma once

#include <cstddef>
#include <cstring>
#include <cstdio>

void printHeader(const char *const headerText);

class ReportHandle{
private:
	static constexpr size_t MAX_ERROR_TEXT_LENGTH = 128;
	static constexpr size_t MAX_TEST_NAME_LENGTH = 32;
	static constexpr size_t MAX_TEST_HEADER_LENGTH = 32;

	bool error;
	char testName[MAX_TEST_NAME_LENGTH];
	char errorText[MAX_ERROR_TEXT_LENGTH];

public:

	ReportHandle();

	const bool getError();
	const char * getErrorText();
	const char * getTestName();
	void clearError();
	void setErrorText(const char *const errorText);
	void setTestName(const char *const testName);
	void init();

	void print();

	void test_str_equal(const char *const dut, const char *const expection);
	void test_float_arr_almost_equal(const float *const dut, const float *const expection, size_t arr_size, const float tol, const bool useRelTol);
	void test_bool_equal(const bool dut, const bool expection);

	template<typename T>
	void test_arr_equal(const T *const dut, const T *const expection, size_t arr_size);
	template<typename T>
	void test_arr_not_equal(const T *const dut, const T *const expection, size_t arr_size);
};


template<typename T>
void ReportHandle::test_arr_equal(const T *const dut, const T *const expection, size_t arr_size){
	unsigned long long errorCount = 0;
    size_t firstErrorIndex = 0;

    for(size_t i=0; i<arr_size; ++i){
        if(dut[i] != expection[i]){
			if(errorCount==0){
				firstErrorIndex = i;
			}
			errorCount += 1;
        }
    }

    if(errorCount>0){
        this->error = true;
        char text[MAX_ERROR_TEXT_LENGTH] = "";
        snprintf(text, MAX_ERROR_TEXT_LENGTH, "From %lli values a total of %lli are wrong. First error is at %lli.", arr_size, errorCount, firstErrorIndex);
        setErrorText(text);
    }
}


template<typename T>
void ReportHandle::test_arr_not_equal(const T *const dut, const T *const expection, size_t arr_size){
	unsigned long long errorCount = 0;
    size_t firstErrorIndex = 0;

    for(size_t i=0; i<arr_size; ++i){
        if(dut[i] == expection[i]){
			if(errorCount==0){
				firstErrorIndex = i;
			}
			errorCount += 1;
        }
    }

    if(errorCount>0){
        this->error = true;
        char text[MAX_ERROR_TEXT_LENGTH] = "";
        snprintf(text, MAX_ERROR_TEXT_LENGTH, "From %lli values a total of %lli are wrong. First error is at %lli.", arr_size, errorCount, firstErrorIndex);
        setErrorText(text);
    }
}
