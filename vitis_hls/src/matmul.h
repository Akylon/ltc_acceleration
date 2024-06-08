#include <cstdint>
#include <array>

typedef union {
    float fp_num;
    uint32_t raw_bits;
    struct {
        uint32_t mant : 23;
        uint32_t bexp : 8;
        uint32_t sign : 1;
    };
} float_num_t;

typedef union {
    double fp_num;
    uint64_t raw_bits;
    struct {
        uint64_t mant : 52;
        uint64_t bexp : 11;
        uint64_t sign : 1;
    };
} double_num_t;


template<typename T, const size_t rows, const size_t cols>
union MatrixRMajor_u{
	T matrix_1d[rows*cols];
	T matrix_2d[rows][cols];
};

template<typename T, const size_t rows, const size_t cols>
union MatrixCMajor_u{
	T matrix_1d[rows*cols];
	T matrix_2d[cols][rows];
};


template<typename T, const size_t rows, const size_t cols>
class MatrixCMajor_t{
public:
	MatrixCMajor_u<T, rows, cols> matrix;

	MatrixCMajor_t(){
	}

	inline const size_t getRows(){
		return rows;
	}

	inline const size_t getCols(){
		return cols;
	}
};

template<typename T, const size_t rows, const size_t cols>
class MatrixRMajor_t{
public:
	MatrixRMajor_u<T, rows, cols> matrix;

	MatrixRMajor_t(){
	}

	inline const size_t getRows(){
		return rows;
	}

	inline const size_t getCols(){
		return cols;
	}
};


template<typename T, const size_t rows_A, const size_t cols_A>
void matmul(MatrixCMajor_t<T, rows_A, cols_A> &A, MatrixRMajor_t<T, cols_A, rows_A> &B){

}


