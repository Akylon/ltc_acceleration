#include "ReportHandle.h"

bool reportHandle_test(){
    printHeader("bool reportHandle_test");
    bool result = false;

    ReportHandle handle;

    handle.init();
    handle.test_bool_equal(handle.getError(), false);


    handle.setTestName("Init test: error");
    handle.print();
    
    handle.test_str_equal(handle.getErrorText(), "");

    handle.setTestName("Init test: errorText");
    handle.print();
    
    handle.init();
    handle.test_str_equal(handle.getTestName(), "");

    handle.setTestName("Init test: testName");
    handle.print();
    
    handle.setTestName("Set errorText test");
    handle.setErrorText("Test Error");
    handle.test_str_equal(handle.getErrorText(), "Test Error");

    handle.print();

    return result;
}
