#include "data_loader.h"

#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <cassert>

#define MAX_LINE_SIZE 2048

// TODO: adjust data format to binary representation of IEEE 754 32bit float. strtoul() could be useful there
bool load_float_matrix(const char *const path, float *const matrix, const size_t rows, const size_t cols){
  assert(cols<=MAX_LINE_SIZE/2); // this does not include all problems, because one float number can be stored with multiple characters. As an upper limit each number requires 2 characters (number, space)

  char buffer[MAX_LINE_SIZE];
  FILE *fptr;
  printf("Try opening file %s\n", path);
  fptr = fopen(path, "r");
  if(fptr == NULL){
    printf("Could not open %s\n\n", path);
    return false;
  }
  printf("Opened file %s\n", path);

  for(size_t row=0; row<rows; ++row){
    const size_t offset = row*cols;
    char *bufPtr = buffer;

    fgets(buffer, MAX_LINE_SIZE, fptr);

    for(size_t col=0; col<cols; ++col){
      if(bufPtr==NULL || *bufPtr == '\n'){
        if(fclose(fptr)==0){
          printf("Closed file %s\n", path);
        }
        printf("Unsuitable matrix in file %s\n\n", path);
        return false;
      }
      matrix[col + offset] = strtof(bufPtr, &bufPtr);
    }
  }

  if(fclose(fptr)==0){
    printf("Closed file %s\n", path);
  }
  printf("Read matrix successfully\n\n");
  return true;
}



bool store_float_matrix(const char *const path, const float *const matrix, const size_t rows, const size_t cols){
  assert(cols<=MAX_LINE_SIZE/2); // this does not include all problems, because one float number can be stored with multiple characters. As an upper limit each number requires 2 characters (number, space)


  FILE *fptr;
  printf("Try opening file %s\n", path);
  fptr = fopen(path, "w");
  if(fptr == NULL){
    printf("Could not open %s\n\n", path);
    return false;
  }
  printf("Opened file %s\n", path);


  char buffer[MAX_LINE_SIZE] = {0};
  char line[MAX_LINE_SIZE] = {0};
  for(size_t row=0; row<rows; ++row){
    const size_t offset = row*cols;
    for(size_t col=0; col<cols; ++col){
      sprintf(buffer, "%.18e", matrix[offset + col]);
      strncat(line, buffer, MAX_LINE_SIZE-1);
      if(col < cols-1){
        strncat(line, " ", MAX_LINE_SIZE-1);
      }
    }
    if(row<rows-1){
      strncat(line, "\n", MAX_LINE_SIZE-1);
    }
    fputs(line, fptr);
    line[0] = '\0';
  }

  if(fclose(fptr)==0){
    printf("Closed file %s\n", path);
  }
  printf("Wrote matrix successfully\n\n");
  return true;
}


bool store_int_matrix(const char *const path, const int *const matrix, const size_t rows, const size_t cols){
  assert(cols<=MAX_LINE_SIZE/2); // this does not include all problems, because one float number can be stored with multiple characters. As an upper limit each number requires 2 characters (number, space)


  FILE *fptr;
  printf("Try opening file %s\n", path);
  fptr = fopen(path, "w");
  if(fptr == NULL){
    printf("Could not open %s\n\n", path);
    return false;
  }
  printf("Opened file %s\n", path);


  char buffer[MAX_LINE_SIZE] = {0};
  char line[MAX_LINE_SIZE] = {0};
  for(size_t row=0; row<rows; ++row){
    const size_t offset = row*cols;
    for(size_t col=0; col<cols; ++col){
      sprintf(buffer, "%d", matrix[offset + col]);
      strncat(line, buffer, MAX_LINE_SIZE-1);
      if(col < cols-1){
        strncat(line, " ", MAX_LINE_SIZE-1);
      }
    }
    if(row<rows-1){
      strncat(line, "\n", MAX_LINE_SIZE-1);
    }
    fputs(line, fptr);
    line[0] = '\0';
  }

  if(fclose(fptr)==0){
    printf("Closed file %s\n", path);
  }
  printf("Wrote matrix successfully\n\n");
  return true;
}
