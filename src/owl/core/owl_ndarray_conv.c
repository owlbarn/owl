#include "owl_core.h"
#include <string.h>
#include <cblas.h>

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

  const int input_cri  = in_channel  * input_rows  * input_cols;
  const int input_ri   = in_channel  * input_rows;
  const int output_cri = out_channel * output_rows * output_cols;
  const int ksize = kernel_cols * kernel_rows;

  memset(output_ptr, 0, batches * output_cri * sizeof(TYPE));

  int pr = 0, pc = 0;
  if (padding != 1){
    pr = (row_stride * ( output_rows - 1) + kernel_rows - input_rows) / 2;
    pc = (col_stride * ( output_cols - 1) + kernel_cols - input_cols) / 2;
    if (pr < 0) pr = 0;
    if (pc < 0) pc = 0;
  }

  const int output_cr  = output_rows * output_cols;
  const int output_crb = output_rows * output_cols * batches;
  const int kernel_cri = kernel_cols * kernel_rows * in_channel;

  TYPE *inpt2d = (TYPE *) calloc(kernel_cri * output_crb, sizeof(TYPE));
  if (inpt2d == NULL) exit(1);

  // flatten each window from input; col major
  for (int i = 0; i < output_crb; ++i) {
    int bt = i / output_cr;
    int cr = i % output_cr;
    int c = cr / output_rows;
    int r = cr % output_rows;

    const int cstart = c * col_stride - pc;
    const int rstart = r * row_stride - pr;
    const int cend = cstart + kernel_cols;
    const int rend = rstart + kernel_rows;
    const int input_idx_base = bt * input_cri;

    int cnt = 0;
    for (int a = cstart; a < cend; ++a) {
      for (int b = rstart; b < rend; ++b) {
        for (int h = 0; h < in_channel; ++h) {
          if (a < input_cols && a >= 0 &&
              b < input_rows && b >= 0) {
            int input_idx =
               input_idx_base + a * input_ri + b * in_channel + h;
            inpt2d[i * kernel_cri + cnt] = input_ptr[input_idx];
          }
          ++cnt;
        }
      }
    }
  }

  cblas_sgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans,
    output_crb, out_channel, kernel_cri, 1,
    inpt2d, kernel_cri, kernel_ptr, out_channel,
    0, output_ptr, out_channel);

  free(inpt2d);

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

  const int input_cri  = in_channel  * input_rows  * input_cols;
  const int input_ri   = in_channel  * input_rows;
  const int kernel_rio = out_channel * in_channel  * kernel_rows;
  const int kernel_io  = out_channel * in_channel;
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
          int output_idx =
            i * output_cri + j * output_ri + k * out_channel + l;
          TYPE output_val = *(output_ptr + output_idx);

          for (int h = 0; h < in_channel; ++h) {
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


value stub_float32_ndarray_conv_spatial_backward_input_native(
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

  const int input_cri  = in_channel  * input_rows  * input_cols;
  const int input_ri   = in_channel  * input_rows;
  const int kernel_rio = out_channel * in_channel  * kernel_rows;
  const int kernel_io  = out_channel * in_channel;
  const int output_cri = out_channel * output_rows * output_cols;
  const int output_ri  = out_channel * output_rows;

  memset(input_ptr, 0, batches * input_cri * sizeof(TYPE));

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
          int output_idx =
            i * output_cri + j * output_ri + k * out_channel + l;
          TYPE output_val = *(output_ptr + output_idx);

          for (int h = 0; h < in_channel; ++h) {
            TYPE kernel_val = 0.;
            for (int a = cstart; a < cend; ++a) {
              for (int b = rstart; b < rend; ++b) {
                int kernel_index =
                  (a - cstart) * kernel_rio + (b - rstart) * kernel_io + h * out_channel + l;
                kernel_val = *(kernel_ptr + kernel_index);

                if (a >= 0 && a < input_cols &&
                    b >= 0 && b < input_rows) {
                  int input_idx =
                    i * input_cri + a * input_ri + b * in_channel + h;
                  *(input_ptr + input_idx) += output_val * kernel_val;
                }
              }
            }
          }
        }
      }
    }
  }

  return Val_unit;
}


value stub_float32_ndarray_conv_spatial_backward_input_bytecode(value * argv, int argn) {
  return stub_float32_ndarray_conv_spatial_backward_input_native(
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15]
  );
}


value stub_float32_ndarray_conv_cuboid_native(
  value vInput, value vKernel, value vOutput,
  value vBatches, value vInput_cols, value vInput_rows,
  value vInput_dpts, value vIn_channel,
  value vKernel_cols, value vKernel_rows, value vKernel_dpts,
  value vOutput_cols, value vOutput_rows,
  value vOutput_dpts, value vOut_channel,
  value vDpt_stride, value vRow_stride,  value vCol_stride,
  value vPadding
){
  struct caml_ba_array *IN = Caml_ba_array_val(vInput);
  struct caml_ba_array *KE = Caml_ba_array_val(vKernel);
  struct caml_ba_array *OU = Caml_ba_array_val(vOutput);
  TYPE *input_ptr  = (TYPE *) IN->data;
  TYPE *kernel_ptr = (TYPE *) KE->data;
  TYPE *output_ptr = (TYPE *) OU->data;

  int batches     = Long_val(vBatches);
  int input_cols  = Long_val(vInput_cols);
  int input_rows  = Long_val(vInput_rows);
  int input_dpts  = Long_val(vInput_dpts);
  int in_channel  = Long_val(vIn_channel);
  int kernel_cols = Long_val(vKernel_cols);
  int kernel_rows = Long_val(vKernel_rows);
  int kernel_dpts = Long_val(vKernel_dpts);
  int output_cols = Long_val(vOutput_cols);
  int output_rows = Long_val(vOutput_rows);
  int output_dpts = Long_val(vOutput_dpts);
  int out_channel = Long_val(vOut_channel);
  int dpt_stride  = Long_val(vDpt_stride);
  int row_stride  = Long_val(vRow_stride);
  int col_stride  = Long_val(vCol_stride);
  int padding     = Long_val(vPadding);

  const int input_crdi  = in_channel  * input_dpts * input_rows * input_cols;
  const int input_rdi   = in_channel  * input_dpts * input_rows;
  const int input_di    = in_channel  * input_dpts;
  const int kernel_rdio = out_channel * in_channel * kernel_dpts * kernel_rows;
  const int kernel_dio  = out_channel * in_channel * kernel_dpts;
  const int kernel_io   = out_channel * in_channel;
  const int output_crdo = out_channel * output_dpts * output_rows * output_cols;
  const int output_rdo  = out_channel * output_dpts * output_rows;
  const int output_do   = out_channel * output_dpts;

  //memset(output_ptr, 0, batches * output_crdo * sizeof(TYPE));

  int pd, pr, pc;
  if (padding == 1) {
    pc = 0; pr = 0; pd = 0;
  } else {
    int pad_cols = col_stride * (output_cols - 1) + kernel_cols - input_cols;
    int pad_rows = row_stride * (output_rows - 1) + kernel_rows - input_rows;
    int pad_dpts = dpt_stride * (output_dpts - 1) + kernel_dpts - input_dpts;
    pc = pad_cols / 2; if (pc < 0) pc = 0;
    pr = pad_rows / 2; if (pr < 0) pr = 0;
    pd = pad_dpts / 2; if (pd < 0) pd = 0;
  }

  for (int i = 0; i < batches; ++i) {
    const int input_idx_base = i * input_crdi;
    for (int j = 0; j < output_cols; ++j) {
      for (int k = 0; k < output_rows; ++k) {
        for (int d = 0; d < output_dpts; ++d) {
          const int output_idx_base =
            i * output_crdo +
            j * output_rdo +
            k * output_do +
            d * out_channel;

          const int cstart = j * col_stride - pc;
          const int rstart = k * row_stride - pr;
          const int dstart = d * dpt_stride - pd;
          const int cend   = cstart + kernel_cols;
          const int rend   = rstart + kernel_rows;
          const int dend   = dstart + kernel_dpts;

          for (int l = 0; l < out_channel; ++l) {
            TYPE sum = 0.;
            int output_idx = output_idx_base + l;

            for (int h = 0; h < in_channel; ++h) {
              for (int a = cstart; a < cend; ++a) {
                for (int b = rstart; b < rend; ++b) {
                  for (int c = dstart; c < dend; ++c) {
                    TYPE input_val, kernel_val;
                    if (a >= 0 && a < input_cols &&
                        b >= 0 && b < input_rows &&
                        c >= 0 && c < input_dpts) {
                      int input_idx =
                        input_idx_base + a * input_rdi + b * input_di +
                        c * in_channel + h;
                      input_val = *(input_ptr + input_idx);
                    } else {
                      input_val = 0;
                    }

                    int kernel_index =
                      (a - cstart) * kernel_rdio +
                      (b - rstart) * kernel_dio +
                      (c - dstart) * kernel_io +
                      h * out_channel + l;
                    kernel_val = *(kernel_ptr + kernel_index);

                    sum += input_val * kernel_val;
                  }
                }
              }
            }

            *(output_ptr + output_idx) =  sum;
          }
        }
      }
    }
  }
  return Val_unit;
}


value stub_float32_ndarray_conv_cuboid_bytecode(value * argv, int argn) {
  return stub_float32_ndarray_conv_cuboid_native(
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15], argv[16], argv[17], argv[18]
  );
}


value stub_float32_ndarray_conv_cuboid_backward_kernel_native(
  value vInput, value vKernel, value vOutput,
  value vBatches, value vInput_cols, value vInput_rows,
  value vInput_dpts, value vIn_channel,
  value vKernel_cols, value vKernel_rows, value vKernel_dpts,
  value vOutput_cols, value vOutput_rows,
  value vOutput_dpts, value vOut_channel,
  value vDpt_stride, value vRow_stride,  value vCol_stride
){
  struct caml_ba_array *IN = Caml_ba_array_val(vInput);
  struct caml_ba_array *KE = Caml_ba_array_val(vKernel);
  struct caml_ba_array *OU = Caml_ba_array_val(vOutput);
  TYPE *input_ptr  = (TYPE *) IN->data;
  TYPE *kernel_ptr = (TYPE *) KE->data;
  TYPE *output_ptr = (TYPE *) OU->data;

  int batches     = Long_val(vBatches);
  int input_cols  = Long_val(vInput_cols);
  int input_rows  = Long_val(vInput_rows);
  int input_dpts  = Long_val(vInput_dpts);
  int in_channel  = Long_val(vIn_channel);
  int kernel_cols = Long_val(vKernel_cols);
  int kernel_rows = Long_val(vKernel_rows);
  int kernel_dpts = Long_val(vKernel_dpts);
  int output_cols = Long_val(vOutput_cols);
  int output_rows = Long_val(vOutput_rows);
  int output_dpts = Long_val(vOutput_dpts);
  int out_channel = Long_val(vOut_channel);
  int dpt_stride  = Long_val(vDpt_stride);
  int row_stride  = Long_val(vRow_stride);
  int col_stride  = Long_val(vCol_stride);

  const int input_crdi  = in_channel  * input_dpts * input_rows * input_cols;
  const int input_rdi   = in_channel  * input_dpts * input_rows;
  const int input_di    = in_channel  * input_dpts;
  const int kernel_rdio = out_channel * in_channel * kernel_dpts * kernel_rows;
  const int kernel_dio  = out_channel * in_channel * kernel_dpts;
  const int kernel_io   = out_channel * in_channel;
  const int output_crdo = out_channel * output_dpts * output_rows * output_cols;
  const int output_rdo  = out_channel * output_dpts * output_rows;
  const int output_do   = out_channel * output_dpts;

  memset(kernel_ptr, 0, kernel_cols * kernel_rdio * sizeof(TYPE));

  int pd, pr, pc;
  int pad_cols = col_stride * (output_cols - 1) + kernel_cols - input_cols;
  int pad_rows = row_stride * (output_rows - 1) + kernel_rows - input_rows;
  int pad_dpts = dpt_stride * (output_dpts - 1) + kernel_dpts - input_dpts;
  pc = pad_cols / 2; if (pc < 0) pc = 0;
  pr = pad_rows / 2; if (pr < 0) pr = 0;
  pd = pad_dpts / 2; if (pd < 0) pd = 0;

  for (int i = 0; i < batches; ++i) {
    const int input_idx_base = i * input_crdi;
    for (int j = 0; j < output_cols; ++j) {
      for (int k = 0; k < output_rows; ++k) {
        for (int d = 0; d < output_dpts; ++d) {
          const int output_idx_base =
            i * output_crdo +
            j * output_rdo +
            k * output_do +
            d * out_channel;

          const int cstart = j * col_stride - pc;
          const int rstart = k * row_stride - pr;
          const int dstart = d * dpt_stride - pd;
          const int cend   = cstart + kernel_cols;
          const int rend   = rstart + kernel_rows;
          const int dend   = dstart + kernel_dpts;

          for (int l = 0; l < out_channel; ++l) {
            int output_idx = output_idx_base + l;
            TYPE output_val = *(output_ptr + output_idx);
            for (int h = 0; h < in_channel; ++h) {
              for (int a = cstart; a < cend; ++a) {
                for (int b = rstart; b < rend; ++b) {
                  for (int c = dstart; c < dend; ++c) {
                    TYPE input_val;
                    if (a >= 0 && a < input_cols &&
                        b >= 0 && b < input_rows &&
                        c >= 0 && c < input_dpts) {
                      int input_idx =
                        input_idx_base + a * input_rdi + b * input_di +
                        c * in_channel + h;
                      input_val = *(input_ptr + input_idx);
                    } else {
                      input_val = 0;
                    }

                    int kernel_index =
                      (a - cstart) * kernel_rdio +
                      (b - rstart) * kernel_dio +
                      (c - dstart) * kernel_io +
                      h * out_channel + l;

                    *(kernel_ptr + kernel_index) += output_val * input_val;
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  return Val_unit;
}


value stub_float32_ndarray_conv_cuboid_backward_kernel_bytecode(value * argv, int argn) {
  return stub_float32_ndarray_conv_cuboid_backward_kernel_native(
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15], argv[16], argv[17]
  );
}

value stub_float32_ndarray_conv_cuboid_backward_input_native(
  value vInput, value vKernel, value vOutput,
  value vBatches, value vInput_cols, value vInput_rows,
  value vInput_dpts, value vIn_channel,
  value vKernel_cols, value vKernel_rows, value vKernel_dpts,
  value vOutput_cols, value vOutput_rows,
  value vOutput_dpts, value vOut_channel,
  value vDpt_stride, value vRow_stride,  value vCol_stride
){
  struct caml_ba_array *IN = Caml_ba_array_val(vInput);
  struct caml_ba_array *KE = Caml_ba_array_val(vKernel);
  struct caml_ba_array *OU = Caml_ba_array_val(vOutput);
  TYPE *input_ptr  = (TYPE *) IN->data;
  TYPE *kernel_ptr = (TYPE *) KE->data;
  TYPE *output_ptr = (TYPE *) OU->data;

  int batches     = Long_val(vBatches);
  int input_cols  = Long_val(vInput_cols);
  int input_rows  = Long_val(vInput_rows);
  int input_dpts  = Long_val(vInput_dpts);
  int in_channel  = Long_val(vIn_channel);
  int kernel_cols = Long_val(vKernel_cols);
  int kernel_rows = Long_val(vKernel_rows);
  int kernel_dpts = Long_val(vKernel_dpts);
  int output_cols = Long_val(vOutput_cols);
  int output_rows = Long_val(vOutput_rows);
  int output_dpts = Long_val(vOutput_dpts);
  int out_channel = Long_val(vOut_channel);
  int dpt_stride  = Long_val(vDpt_stride);
  int row_stride  = Long_val(vRow_stride);
  int col_stride  = Long_val(vCol_stride);

  const int input_crdi  = in_channel  * input_dpts * input_rows * input_cols;
  const int input_rdi   = in_channel  * input_dpts * input_rows;
  const int input_di    = in_channel  * input_dpts;
  const int kernel_rdio = out_channel * in_channel * kernel_dpts * kernel_rows;
  const int kernel_dio  = out_channel * in_channel * kernel_dpts;
  const int kernel_io   = out_channel * in_channel;
  const int output_crdo = out_channel * output_dpts * output_rows * output_cols;
  const int output_rdo  = out_channel * output_dpts * output_rows;
  const int output_do   = out_channel * output_dpts;

  memset(input_ptr, 0, batches * input_crdi * sizeof(TYPE));

  int pd, pr, pc;
  int pad_cols = col_stride * (output_cols - 1) + kernel_cols - input_cols;
  int pad_rows = row_stride * (output_rows - 1) + kernel_rows - input_rows;
  int pad_dpts = dpt_stride * (output_dpts - 1) + kernel_dpts - input_dpts;
  pc = pad_cols / 2; if (pc < 0) pc = 0;
  pr = pad_rows / 2; if (pr < 0) pr = 0;
  pd = pad_dpts / 2; if (pd < 0) pd = 0;

  for (int i = 0; i < batches; ++i) {
    const int input_idx_base = i * input_crdi;
    for (int j = 0; j < output_cols; ++j) {
      for (int k = 0; k < output_rows; ++k) {
        for (int d = 0; d < output_dpts; ++d) {
          const int output_idx_base =
            i * output_crdo +
            j * output_rdo +
            k * output_do +
            d * out_channel;

          const int cstart = j * col_stride - pc;
          const int rstart = k * row_stride - pr;
          const int dstart = d * dpt_stride - pd;
          const int cend   = cstart + kernel_cols;
          const int rend   = rstart + kernel_rows;
          const int dend   = dstart + kernel_dpts;

          for (int l = 0; l < out_channel; ++l) {
            int output_idx = output_idx_base + l;
            TYPE output_val = *(output_ptr + output_idx);
            for (int h = 0; h < in_channel; ++h) {
              TYPE kernel_val;
              for (int a = cstart; a < cend; ++a) {
                for (int b = rstart; b < rend; ++b) {
                  for (int c = dstart; c < dend; ++c) {
                    int kernel_index =
                      (a - cstart) * kernel_rdio +
                      (b - rstart) * kernel_dio +
                      (c - dstart) * kernel_io +
                      h * out_channel + l;
                    kernel_val = *(kernel_ptr + kernel_index);

                    if (a >= 0 && a < input_cols &&
                        b >= 0 && b < input_rows &&
                        c >= 0 && c < input_dpts) {
                      int input_idx =
                        input_idx_base + a * input_rdi + b * input_di +
                        c * in_channel + h;
                      *(input_ptr + input_idx) += output_val * kernel_val;
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  return Val_unit;
}


value stub_float32_ndarray_conv_cuboid_backward_input_bytecode(value * argv, int argn) {
  return stub_float32_ndarray_conv_cuboid_backward_input_native(
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15], argv[16], argv[17]
  );
}
