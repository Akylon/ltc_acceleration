#include "export_validation_data.h"

#include <cstdio>
#include <cstddef>
#include <cmath>

#include "../src/model.h"
#include "assert.h"
#include "data_loader.h"
#include "cassert"

#include <iostream>
using namespace std;

#define LTC_UNITS_DEF 64
#define SEQUENCE_LENGTH 64
#define DENSE_OUT_UNITS_DEF 17
#define SIGNAL_INPUTLAYER_SIZE_DEF 17


#define NUMBER_OF_DATASETS 1936

void quantise(){

}


void export_validation_data(){
	// process dataset and export results
	for(size_t dataset=0; dataset<NUMBER_OF_DATASETS; ++dataset){
		// import data
		printf("*********************************\n");
		printf("Call model with dateset %lli\n", dataset);

		float t_in_sequence[SEQUENCE_LENGTH];
		char t_path[256];
		sprintf(t_path, "../../../../../model/data/walker_relu_tanh_checkpoint/float_validation/ltc/blackbox/ltc_t_input_%lli.txt", dataset);
		assert(load_float_matrix(t_path, t_in_sequence, SEQUENCE_LENGTH, 1));

		float sig_in_sequence[SEQUENCE_LENGTH][SIGNAL_INPUTLAYER_SIZE_DEF];
		char sig_path[256];
		sprintf(sig_path, "../../../../../model/data/walker_relu_tanh_checkpoint/float_validation/ltc/blackbox/ltc_sig_input_%lli.txt", dataset);
		assert(load_float_matrix(sig_path, *sig_in_sequence, SEQUENCE_LENGTH, SIGNAL_INPUTLAYER_SIZE_DEF));


		// inference
		clearStates();
		printf("Starting, Inference of dataset\n");
		int model_out[SEQUENCE_LENGTH][DENSE_OUT_UNITS_DEF] = {{0}};
		for(size_t i=0; i<SEQUENCE_LENGTH; ++i){
			constexpr float sigConversionFactor = pow(2, -(float)LTC_DENSE_BACKBONE_0_SIG_INSIGSCALE);
			signal_t sigIn;
			timeIn_t timeIn;

			// quantise data
			//cout << "sigConversionFactor = " << sigConversionFactor << endl;
			modelData_t sigIn_arr[SIGNAL_INPUTLAYER_SIZE_DEF];
			for(size_t j=0; j<SIGNAL_INPUTLAYER_SIZE_DEF; ++j){
				sigIn_arr[j] = (modelData_t)(sig_in_sequence[i][j] * sigConversionFactor);
				//cout << "prod = " << sig_in_sequence[i][j] * sigConversionFactor << endl;
				//cout << "sig_in_sequence = " << sig_in_sequence[i][j] << endl;
			}

			timeIn = (timeIn_t)t_in_sequence[i];

			// data aggregation to passing structure
			for(size_t j=0; j<SIGNAL_INPUTLAYER_SIZE_DEF; ++j){
				sigIn.range((j+1)*MODEL_RESOLUTION-1, j*MODEL_RESOLUTION) = sigIn_arr[j];
				//cout << "sigIn_arr[" << j << "] = " << sigIn_arr[j] << endl;
			}
			/*cout << "sigIn = " << sigIn << endl;
			cout << "timeIn = " << timeIn << endl;*/

			// call model
			out_t output;
			states_t states;

			model(sigIn, timeIn, output, states);

			// data aggregation to passing structure
			for(size_t j=0; j<DENSE_OUT_UNITS_DEF; ++j){
				model_out[i][j] = ap_int<8>(output.range((j+1)*MODEL_RESOLUTION-1, j*MODEL_RESOLUTION));
				//printf("model_out = %d\n", model_out[i][j]);
			}
			//printf("output = %d\n", output);

		}
		printf("Finished inference\n");



		// export results
		printf("Starting Export\n");
		char out_path[256] = "../validation_data/model/cModel_out.txt";
		sprintf(out_path, "../../../../validation_data/model/cModel_out_%lli.txt", dataset);
		assert(store_int_matrix(out_path, *model_out, SEQUENCE_LENGTH, DENSE_OUT_UNITS_DEF));
	printf("Finished Export\n");
	}
	printf("Model execution completed\n");
}
