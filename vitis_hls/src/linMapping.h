#include <cstdint>


// A*x=b
template<typename T, const size_t rows, const size_t cols>
void linMapping(const T A[rows*cols], const T x[cols], T b[rows]){
	for(size_t row=0; row<rows; ++row){
		for(size_t col=0; col<cols; ++col){
			b[row] = A[col + row*cols] * x[col];
		}
	}
}
