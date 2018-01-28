#include <stdio.h>
#include <math.h>


#include "ctypes_cstubs_internals.h"

typedef float tensor_elt;

void c_tensor_s_spatial_avg_pooling (
  tensor_elt* input_ptr, tensor_elt* output_ptr,
  int batches, int input_cols, int input_rows, int in_channel,
  int kernel_cols, int kernel_rows, int output_cols, int output_rows,
  int row_stride, int col_stride, int padding, int row_in_stride, int col_in_stride
)
{
  float pr, pc;
  if (padding == 1){ // Valid
    pr = 0.; pc = 0.;
  } else { // Same
    pr = (row_stride * ( output_rows - 1) +
      kernel_rows - input_rows) / 2.;
    pc = (col_stride * ( output_cols - 1) +
      kernel_cols - input_cols) / 2.;
    // kernel smaller than stride
    if (pr < 0) pr = 0.;
    if (pc < 0) pc = 0.;
  }

  int i, j, k, l;
  for (i = 0; i < batches; ++i) {
    for (j = 0; j < output_cols; ++j) {
      for (k = 0; k < output_rows; ++k) {

        const int cstart = j * col_stride - floor(pc);
        const int rstart = k * row_stride - floor(pr);
        const int cend   = cstart + kernel_cols;
        const int rend   = rstart + kernel_rows;

        for (l = 0; l < in_channel; ++l) {
          tensor_elt sum = 0.;
          int c = 0;
          int a, b;

          for (a = cstart; a < cend; ++a) {
            for (b = rstart; b < rend; ++b) {
              if (a >= 0 && a < input_cols &&
                  b >= 0 && b < input_rows) {
                int input_idx =
                  i * (input_cols * input_rows * in_channel) +
                  a * (input_rows * in_channel) +
                  b * in_channel +
                  l;
                sum += *(input_ptr + input_idx);
                c++;
              }
            }
          }

          int output_idx =
            i * (output_cols * output_rows * in_channel) +
            j * (output_rows * in_channel) +
            k * in_channel +
            l;
          *(output_ptr + output_idx) = sum / c;
        }
      }
    }
  }

  return;
}

/*

void c_tensor_s_spatial_max_pooling(
  tensor_elt* input_ptr, tensor_elt* output_ptr,
  int batches, int input_cols, int input_rows, int in_channel,
  int kernel_cols, int kernel_rows, int output_cols, int output_rows,
  int row_stride, int col_stride, int padding, int row_in_stride, int col_in_stride
)
{
  float pr, pc;
  if (padding == 1){ // Valid
    pr = 0.; pc = 0.;
  } else { // Same
    pr = (row_stride * ( output_rows - 1) +
      kernel_rows - input_rows) / 2.;
    pc = (col_stride * ( output_cols - 1) +
      kernel_cols - input_cols) / 2.;
    // kernel smaller than stride
    if (pr < 0) pr = 0.;
    if (pc < 0) pc = 0.;
  }

  int i, j, k, l;
  for (i = 0; i < batches; ++i) {
    for (j = 0; j < output_cols; ++j) {
      for (k = 0; k < output_rows; ++k) {

        const int cstart = j * col_stride - floor(pc);
        const int rstart = k * row_stride - floor(pr);
        const int cend   = cstart + kernel_cols;
        const int rend   = rstart + kernel_rows;

        for (l = 0; l < in_channel; ++l) {
          tensor_elt max = -INFINITY;
          int a, b;
          for (a = cstart; a < cend; ++a) {
            for (b = rstart; b < rend; ++b) {
              if (a >= 0 && a < input_cols &&
                  b >= 0 && b < input_rows) {
                int input_idx =
                  i * (input_cols * input_rows * in_channel) +
                  a * (input_rows * in_channel) +
                  b * in_channel +
                  l;
                if (max < *(input_ptr + input_idx)){
                  max = *(input_ptr + input_idx);
                }
              }
            }
          }

          int output_idx =
            i * (output_cols * output_rows * in_channel) +
            j * (output_rows * in_channel) +
            k * in_channel +
            l;
          *(output_ptr + output_idx) = max;
        }
      }
    }
  }

  return;
}

int min(int a, int b){
  return (a < b)? a : b;
}

void c_tensor_s_spatial_avg_pooling_backward(
  tensor_elt* input_backward_ptr, tensor_elt* output_backward_ptr,
  int batches, int input_cols, int input_rows, int in_channel,
  int kernel_cols, int kernel_rows, int output_cols, int output_rows,
  int row_stride, int col_stride, int pad_rows, int pad_cols
){
  int kernel_size = kernel_cols * kernel_rows;
  int b, w, h;
  for (b = 0; b < batches; ++b) {
    for (w = 0; w < input_cols; ++w) {
      for (h = 0; h < input_rows; ++h) {
        const int wpad = w + pad_cols;
        const int hpad = h + pad_rows;
        const int w_start = (wpad < kernel_cols) ? 0 : (wpad - kernel_cols) / col_stride + 1;
        const int w_end = min(wpad / col_stride + 1, output_cols);
        const int h_start = (hpad < kernel_rows) ? 0 : (hpad - kernel_rows) / row_stride + 1;
        const int h_end = min(hpad / row_stride + 1, output_rows);

        const int in_index_base =
          b * (input_cols * input_rows * in_channel) +
          w * (input_rows * in_channel) +
          h * in_channel;

        int pw, ph, pc;
        tensor_elt sum = 0.;
        for (pw = w_start; pw < w_end; ++pw) {
          for (ph = h_start; pw < h_end; ++ph) {
            const int out_index_base =
              b  * (output_cols * output_rows * in_channel) +
              pw * (output_rows * in_channel) +
              ph * in_channel;
            for (pc = 0; pc < in_channel; ++pc) {
              sum += *(output_backward_ptr + out_index_base + pc);
            }
          }
        }

        for (pc = 0; pc < in_channel; ++pc) {
          *(input_backward_ptr + in_index_base + pc) = sum / kernel_size;
        }
      }
    }
  }

  return;
}



void c_tensor_add(value arr, value x)
{
  int x = Long_val(x);
  float* x53 = CTYPES_ADDR_OF_FATPTR(arr);
  return;
}

*/
