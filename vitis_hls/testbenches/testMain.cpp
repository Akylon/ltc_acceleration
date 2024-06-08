#include <cstdio>
#include "ReportHandle.h"
#include <unistd.h>

#include "reportHandle_test.h"
#include "sigmoid_test.h"
#include "dense_test.h"
#include "ltc_test.h"
#include "tanh_test.h"
#include "quantMulAdd_test.h"
#include "quantMul_test.h"
#include "tInterP_test.h"
#include "tanh_optimal_test.h"
#include "model_test.h"
#include "export_validation_data.h"


int main(){
#if defined(__STDC_VERSION__)
    printf("C-compiler version: %li\n\n", __STDC_VERSION__);

#endif

    bool result = false;
    char workingDir[256] = {0};
    getcwd(workingDir, 256);
    printf("Working Directory: %s\n", workingDir);

    result |= reportHandle_test();
    result |= quantMulAdd_test();
    result |= quantMul_test();
    result |= quantMulAdd_test();
    result |= dense_test();
    result |= sigmoid_test();
    result |= tanh_test();
    result |= tanh_optimal_test();
    result |= tInterP_test();
    result |= ltc_test();

    result |= model_test(); // this test does only work for a specific set of weights. If the model is retrained, then the weights differ slightly, which invalidates the test



    // Export data for furhter analysis. Only uncomment if needed, since it takes forever.
    /*
    printHeader("Test Overview");

    if(result){
        printf("Not all tests ran successfully!\n");
    }
    else{
        printf("All tests ran successfully!\n\n");

        printf("Export Validation Data\n");
		export_validation_data();
    }
    */
    return result;
}
