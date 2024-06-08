#include "ReportHandle.h"

#include <cmath>

using namespace std;

ReportHandle::ReportHandle(){
	init();
}

const bool ReportHandle::getError(){
	return error;
}

const char * ReportHandle::getErrorText(){
	return errorText;
}

const char * ReportHandle::getTestName(){
	return testName;
}

void ReportHandle::clearError(){
	error = false;
	strncpy(errorText, "", MAX_ERROR_TEXT_LENGTH);
}

void ReportHandle::setErrorText(const char *const errorText){
    strncpy(this->errorText, errorText, MAX_ERROR_TEXT_LENGTH);
}

void ReportHandle::setTestName(const char *const testName){
    strncpy(this->testName, testName, MAX_TEST_NAME_LENGTH);
}

void ReportHandle::init(){
    error = false;
    strncpy(errorText, "", MAX_ERROR_TEXT_LENGTH);
    strncpy(testName, "", MAX_TEST_NAME_LENGTH);
}

void printHeader(const char *const headerText){
    puts("****************");
    puts(headerText);
    puts("----------------");
}

void ReportHandle::print(){
    printf("-- %s\n", testName);
    if(error){
        printf("Test was unsuccessful!\n");
        printf("%s\n", errorText);
    }
    else{
        printf("Test was successful\n");
    }
    printf("\n");
}

void ReportHandle::test_str_equal(const char *const dut, const char *const expection){
    int result = strcmp(dut, expection);
    if(result!=0){
        error = true;
        setErrorText("Strings are not the same!");
    }
}

void ReportHandle::test_float_arr_almost_equal(const float *const dut, const float *const expection, const size_t arr_size, const float tol, const bool useRelTol){
    
    unsigned long long errorCount = 0;
    size_t firstErrorIndex = 0;
    float largestRelError = 0;
    bool firstErrorTooLarge = false;

    for(size_t i=0; i<arr_size; ++i){
        float error;
        if(useRelTol){
            error = fabs((dut[i]-expection[i])/expection[i]);
        }
        else{
            error = fabs(dut[i]-expection[i]);
        }

        if(error > tol){
            if(dut[i] > expection[i]){
                if(errorCount==0){
                    firstErrorTooLarge = true;
                    firstErrorIndex = i;
                }
                if(largestRelError<error){
                    largestRelError = error;
                }
                errorCount += 1;
            }
            else{
                if(errorCount==0){
                    firstErrorTooLarge = false;
                    firstErrorIndex = i;
                }
                if(largestRelError<error){
                    largestRelError = error;
                }
                errorCount += 1;
            }
        }
    }

    if(errorCount>0){
        this->error = true;
        char text[MAX_ERROR_TEXT_LENGTH] = "";
        if(firstErrorTooLarge){
            snprintf(text, MAX_ERROR_TEXT_LENGTH, "From %lli values a total of %lli are wrong. First error is at %lli and is > expectation! Largest error is %f.", arr_size, errorCount, firstErrorIndex, largestRelError);
        }
        else{
            snprintf(text, MAX_ERROR_TEXT_LENGTH, "From %lli values a total of %lli are wrong. First error is at %lli and is < expectation! Largest error is %f.", arr_size, errorCount, firstErrorIndex, largestRelError);
        }
        setErrorText(text);
    }
}

void ReportHandle::test_bool_equal(const bool dut, const bool expection){
    if(dut!=expection){
        error = true;
        setErrorText("Booleans are not the same!");
    }
}



