#include "owl_core.h"
#include <string.h>
#define TYPE float

value stub_float32_ndarray_conv_spatial_native(
  value vInput_ptr, value vKernel_ptr, value vOutput_ptr,
  value vBatches, value vInput_cols, value vInput_rows, value vIn_channel,
  value vKernel_cols, value vKernel_rows,
  value vOutput_cols, value vOutput_rows, value vOut_channel,
  value vRow_stride,  value vCol_stride,
  value vPadding, value vRow_in_stride, value vCol_in_stride
){
  struct caml_ba_array *IN = Caml_ba_array_val(vInput_ptr);
  struct caml_ba_array *KE = Caml_ba_array_val(vKernel_ptr);
  struct caml_ba_array *OU = Caml_ba_array_val(vOutput_ptr);
  TYPE *input_ptr  = (TYPE *) IN->data;
  TYPE *kernel_ptr = (TYPE *) KE->data;
  TYPE *output_ptr = (TYPE *) OU->data;

  int batches       = Long_val(vBatches);
  int input_cols    = Long_val(vInput_cols);
  int input_rows    = Long_val(vInput_rows);
  int in_channel    = Long_val(vIn_channel);
  int kernel_cols   = Long_val(vKernel_cols);
  int kernel_rows   = Long_val(vKernel_rows);
  int output_cols   = Long_val(vOutput_cols);
  int output_rows   = Long_val(vOutput_rows);
  int out_channel   = Long_val(vOut_channel);
  int row_stride    = Long_val(vRow_stride);
  int col_stride    = Long_val(vCol_stride);
  int padding       = Long_val(vPadding);
  int row_in_stride = Long_val(vRow_in_stride);
  int col_in_stride = Long_val(vCol_in_stride);

  const int input_cri  = in_channel * input_rows * input_cols;
  const int input_ri   = in_channel * input_rows;
  const int kernel_rio = out_channel* in_channel * kernel_rows;
  const int kernel_io  = out_channel* in_channel;
  const int output_cri = out_channel * output_rows * output_cols;
  const int output_ri  = out_channel * output_rows;

  memset(output_ptr, 0.0, batches * output_cri * sizeof(TYPE));

  float pr, pc;
  if (padding == 1){
    pr = 0.; pc = 0.;
  } else {
    pr = (row_stride * ( output_rows - 1) +
      kernel_rows - input_rows) / 2.;
    pc = (col_stride * ( output_cols - 1) +
      kernel_cols - input_cols) / 2.;
    if (pr < 0) pr = 0.;
    if (pc < 0) pc = 0.;
  }

  const int ksize = kernel_cols * kernel_rows;

  for (int i = 0; i < batches; ++i) {
    for (int j = 0; j < output_cols; ++j) {
      for (int k = 0; k < output_rows; ++k) {

        const int cstart = j * col_stride - floor(pc);
        const int rstart = k * row_stride - floor(pr);
        const int cend   = cstart + kernel_cols;
        const int rend   = rstart + kernel_rows;

        for (int l = 0; l < out_channel; ++l) {
          TYPE sum = 0;

          for (int h = 0; h < in_channel; ++h) {
            int count = 0;
            TYPE conv_biopsy[ksize];
            TYPE kern_biopsy[ksize];
            //memset(conv_biopsy, 0, ksize * sizeof(TYPE));

            // Copy part of input data
            for (int a = cstart; a < cend; ++a) {
              for (int b = rstart; b < rend; ++b) {
                if (a >= 0 && a < input_cols &&
                    b >= 0 && b < input_rows) {
                  int input_idx =
                    i * input_cri + a * input_ri + b * in_channel + h;
                  *(conv_biopsy + count) = *(input_ptr + input_idx);
                } else {
                  *(conv_biopsy + count) = 0.0;
                }
                count++;
              }
            }

            // Copy part of kernel data
            count = 0;
            for (int a = 0; a < kernel_cols; ++a) {
              for (int b = 0; b < kernel_rows; ++b) {
                int kernel_index =
                  a * kernel_rio + b * kernel_io + h * out_channel + l;
                *(kern_biopsy + count) = *(kernel_ptr + kernel_index);
                count++;
              }
            }

            // matrix dot multiplication
            int t;
            TYPE sum_p = 0.0;
            for ( t = 0; t < ksize; t++){
                sum_p += conv_biopsy[t] * kern_biopsy[t];
            }
            sum += sum_p;

          }

          int output_idx =
            i * output_cri + j * output_ri + k * out_channel + l;
          *(output_ptr + output_idx) = sum;
        }
      }
    }
  }

  return Val_unit;
}


value stub_float32_ndarray_conv_spatial_bytecode(value * argv, int argn) {
  return stub_float32_ndarray_conv_spatial_native(
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15], argv[16]
  );
}


value stub_float32_ndarray_conv_spatial_backward_kernel_native(
  value vInput_ptr, value vKernel_ptr, value vOutput_ptr,
  value vBatches, value vInput_cols, value vInput_rows, value vIn_channel,
  value vKernel_cols, value vKernel_rows,
  value vOutput_cols, value vOutput_rows, value vOut_channel,
  value vRow_stride,  value vCol_stride,
  value vRow_in_stride, value vCol_in_stride
){
  struct caml_ba_array *IN = Caml_ba_array_val(vInput_ptr);
  struct caml_ba_array *KE = Caml_ba_array_val(vKernel_ptr);
  struct caml_ba_array *OU = Caml_ba_array_val(vOutput_ptr);
  TYPE *input_ptr  = (TYPE *) IN->data;
  TYPE *kernel_ptr = (TYPE *) KE->data;
  TYPE *output_ptr = (TYPE *) OU->data;

  int batches       = Long_val(vBatches);
  int input_cols    = Long_val(vInput_cols);
  int input_rows    = Long_val(vInput_rows);
  int in_channel    = Long_val(vIn_channel);
  int kernel_cols   = Long_val(vKernel_cols);
  int kernel_rows   = Long_val(vKernel_rows);
  int output_cols   = Long_val(vOutput_cols);
  int output_rows   = Long_val(vOutput_rows);
  int out_channel   = Long_val(vOut_channel);
  int row_stride    = Long_val(vRow_stride);
  int col_stride    = Long_val(vCol_stride);
  int row_in_stride = Long_val(vRow_in_stride);
  int col_in_stride = Long_val(vCol_in_stride);

  const int input_cri  = in_channel * input_rows * input_cols;
  const int input_ri   = in_channel * input_rows;
  const int kernel_rio = out_channel* in_channel * kernel_rows;
  const int kernel_io  = out_channel* in_channel;
  const int output_cri = out_channel * output_rows * output_cols;
  const int output_ri  = out_channel * output_rows;

  memset(kernel_ptr, 0, kernel_cols * kernel_rio * sizeof(TYPE));

  int pad_rows = row_stride * (output_rows - 1) + kernel_rows - input_rows;
  int pad_cols = col_stride * (output_cols - 1) + kernel_cols - input_cols;
  int p_top  = pad_rows / 2;
  int p_left = pad_cols / 2;
  if (p_top  < 0) p_top  = 0;
  if (p_left < 0) p_left = 0;

  for (int i = 0; i < batches; ++i) {
    for (int j = 0; j < output_cols; ++j) {
      for (int k = 0; k < output_rows; ++k) {

        const int cstart = j * col_stride - p_left;
        const int rstart = k * row_stride - p_top;
        const int cend   = cstart + kernel_cols;
        const int rend   = rstart + kernel_rows;

        for (int l = 0; l < out_channel; ++l) {
          for (int h = 0; h < in_channel; ++h) {
            int output_idx =
              i * output_cri + j * output_ri + k * out_channel + l;
            TYPE output_val = *(output_ptr + output_idx);

            TYPE input_val = 0.;
            for (int a = cstart; a < cend; ++a) {
              for (int b = rstart; b < rend; ++b) {
                if (a >= 0 && a < input_cols &&
                    b >= 0 && b < input_rows) {
                  int input_idx =
                    i * input_cri + a * input_ri + b * in_channel + h;
                  input_val = *(input_ptr + input_idx);
                } else {
                  input_val = 0.0;
                }

                int kernel_index =
                  (a - cstart) * kernel_rio + (b - rstart) * kernel_io + h * out_channel + l;

                *(kernel_ptr + kernel_index) += output_val * input_val;
              }
            }
          }
        }
      }
    }
  }

  return Val_unit;

}

value stub_float32_ndarray_conv_spatial_backward_kernel_bytecode(value * argv, int argn) {
  return stub_float32_ndarray_conv_spatial_backward_kernel_native(
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15]
  );
}
