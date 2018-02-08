/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


value FUN_NATIVE (spatial) (
  value vInput_ptr, value vOutput_ptr,
  value vBatches, value vInput_cols, value vInput_rows, value vIn_channel,
  value vKernel_cols, value vKernel_rows,
  value vOutput_cols, value vOutput_rows,
  value vRow_stride,  value vCol_stride,
  value vPadding, value vRow_in_stride, value vCol_in_stride
) {
  struct caml_ba_array *IN = Caml_ba_array_val(vInput_ptr);
  struct caml_ba_array *OU = Caml_ba_array_val(vOutput_ptr);
  TYPE *input_ptr  = (TYPE *) IN->data;
  TYPE *output_ptr = (TYPE *) OU->data;

  int batches       = Long_val(vBatches);
  int input_cols    = Long_val(vInput_cols);
  int input_rows    = Long_val(vInput_rows);
  int in_channel    = Long_val(vIn_channel);
  int kernel_cols   = Long_val(vKernel_cols);
  int kernel_rows   = Long_val(vKernel_rows);
  int output_cols   = Long_val(vOutput_cols);
  int output_rows   = Long_val(vOutput_rows);
  int row_stride    = Long_val(vRow_stride);
  int col_stride    = Long_val(vCol_stride);
  int padding       = Long_val(vPadding);
  int row_in_stride = Long_val(vRow_in_stride);
  int col_in_stride = Long_val(vCol_in_stride);

  const int input_cri  = input_cols * input_rows * in_channel;
  const int input_ri   = input_rows * in_channel;
  const int output_cri = output_cols * output_rows * in_channel;
  const int output_ri  = output_rows * in_channel;

  TYPE pr, pc;
  if (padding == 1) {
    pr = 0.; pc = 0.;
  } else {
    pr = (row_stride * ( output_rows - 1) +
      kernel_rows - input_rows) / 2.;
    pc = (col_stride * ( output_cols - 1) +
      kernel_cols - input_cols) / 2.;
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
          TYPE acc = INITACC;
          int a, b;
          int c = 0;
          for (a = cstart; a < cend; ++a) {
            for (b = rstart; b < rend; ++b) {
              if (a >= 0 && a < input_cols &&
                  b >= 0 && b < input_rows) {
                int input_idx =
                  i * input_cri + a * input_ri + b * in_channel + l;
                TYPE t = *(input_ptr + input_idx);
                ACCFN (acc, t);
                c++;
              }
            }
          }

          int output_idx =
            i * output_cri + j * output_ri + k * in_channel + l;
          *(output_ptr + output_idx) = UPDATEFN (acc, c);
        }
      }
    }
  }

  return Val_unit;
}


value FUN_BYTE (spatial) (value * argv, int argn) {
  return FUN_NATIVE (spatial) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14]
  );
}


value FUN_NATIVE (spatial_backward) (
  value vInput, value vOutput_back, value vInput_back,
  value vBatches, value vInput_cols, value vInput_rows, value vIn_channel,
  value vKernel_cols, value vKernel_rows,
  value vOutput_cols, value vOutput_rows,
  value vRow_stride,  value vCol_stride,
  value vPad_rows, value vPad_cols
) {
  struct caml_ba_array *IN  = Caml_ba_array_val(vInput);
  struct caml_ba_array *OUB = Caml_ba_array_val(vOutput_back);
  struct caml_ba_array *INB = Caml_ba_array_val(vInput_back);
  TYPE *input_ptr = (TYPE *) IN->data;
  TYPE *output_backward_ptr = (TYPE *) OUB->data;
  TYPE *input_backward_ptr  = (TYPE *) INB->data;

  int batches       = Long_val(vBatches);
  int input_cols    = Long_val(vInput_cols);
  int input_rows    = Long_val(vInput_rows);
  int in_channel    = Long_val(vIn_channel);
  int kernel_cols   = Long_val(vKernel_cols);
  int kernel_rows   = Long_val(vKernel_rows);
  int output_cols   = Long_val(vOutput_cols);
  int output_rows   = Long_val(vOutput_rows);
  int row_stride    = Long_val(vRow_stride);
  int col_stride    = Long_val(vCol_stride);
  int pad_rows      = Long_val(vPad_rows);
  int pad_cols      = Long_val(vPad_cols);

  const int ksize      = kernel_cols * kernel_rows;
  const int output_cri = output_cols * output_rows * in_channel;
  const int output_ri  = output_rows * in_channel;
  const int input_cri  = input_cols * input_rows * in_channel;
  const int input_ri   = input_rows * in_channel;

  if (pad_cols < 0) pad_cols = 0;
  if (pad_rows < 0) pad_rows = 0;

  memset(input_backward_ptr, 0,
    batches * input_cols * input_rows * in_channel * sizeof(TYPE));

  int i, j, k, l;
  for (i = 0; i < batches; ++i) {
    for (j = 0; j < output_cols; ++j) {
      for (k = 0; k < output_rows; ++k) {

        const int cstart = j * col_stride - pad_cols;
        const int rstart = k * row_stride - pad_rows;
        const int cend   = cstart + kernel_cols;
        const int rend   = rstart + kernel_rows;

        for (l = 0; l < in_channel; ++l) {
          TYPE m;
          int output_idx =
            i * output_cri  + j * output_ri + k * in_channel + l;
          m = *(output_backward_ptr + output_idx);

          int idx[ksize];
          memset(idx, 0, ksize * sizeof(int));

          TYPE acc = INITACC;
          int max_idx = 0;
          int c = 0;
          for (int a = cstart; a < cend; ++a) {
            for (int b = rstart; b < rend; ++b) {
              if (a >= 0 && a < input_cols &&
                  b >= 0 && b < input_rows) {
                int input_idx =
                  i * input_cri + a * input_ri + b * in_channel + l;
                idx[c++] = input_idx;

                #ifdef OWL_TENSOR_MAX
                TYPE t = *(input_ptr + input_idx);
                if (acc < t){
                  acc = t;
                  max_idx = input_idx;
                }
                #endif
              }
            }
          }

          #ifdef OWL_TENSOR_AVG
          for (int i = 0; i < c; i++) {
            *(input_backward_ptr + idx[i]) += UPDATEFN (m, c);
          }
          #else
          *(input_backward_ptr + max_idx) += UPDATEFN (m, c);
          #endif
        }
      }
    }
  }
}


value FUN_BYTE (spatial_backward) (value * argv, int argn) {
  return FUN_NATIVE (spatial_backward) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14]
  );
}


value FUN_NATIVE (cuboid) (
  value vInput, value vOutput,
  value vBatches, value vInput_cols, value vInput_rows,
  value vInput_depth, value vIn_channel,
  value vKernel_cols, value vKernel_rows, value vKernel_depth,
  value vOutput_cols, value vOutput_rows, value vOutput_depth,
  value vDepth_stride, value vRow_stride,  value vCol_stride,
  value vPadding
) {
  struct caml_ba_array *IN = Caml_ba_array_val(vInput);
  struct caml_ba_array *OU = Caml_ba_array_val(vOutput);
  TYPE *input_ptr  = (TYPE *) IN->data;
  TYPE *output_ptr = (TYPE *) OU->data;

  int batches       = Long_val(vBatches);
  int input_cols    = Long_val(vInput_cols);
  int input_rows    = Long_val(vInput_rows);
  int input_depth   = Long_val(vInput_depth);
  int in_channel    = Long_val(vIn_channel);
  int kernel_cols   = Long_val(vKernel_cols);
  int kernel_rows   = Long_val(vKernel_rows);
  int kernel_depth  = Long_val(vKernel_depth);
  int output_cols   = Long_val(vOutput_cols);
  int output_rows   = Long_val(vOutput_rows);
  int output_depth  = Long_val(vOutput_depth);
  int depth_stride  = Long_val(vDepth_stride);
  int row_stride    = Long_val(vRow_stride);
  int col_stride    = Long_val(vCol_stride);
  int padding       = Long_val(vPadding);

  const int output_crdi = output_cols * output_rows * output_depth * in_channel;
  const int output_rdi  = output_rows * output_depth * in_channel;
  const int output_di   = output_depth * in_channel;
  const int input_crdi  = input_cols * input_rows * input_depth * in_channel;
  const int input_rdi   = input_rows * input_depth * in_channel
  const int input_di    = input_depth * in_channel

  TYPE pr, pc, pd;
  if (padding == 1){
    pr = 0.; pc = 0.; pd = 0.;
  } else {
    pr = (row_stride * ( output_rows - 1) +
      kernel_rows - input_rows) / 2.;
    pc = (col_stride * ( output_cols - 1) +
      kernel_cols - input_cols) / 2.;
    pd = (depth_stride * ( output_cols - 1) +
      kernel_depth - input_depth) / 2.;
    if (pr < 0) pr = 0.;
    if (pc < 0) pc = 0.;
    if (pd < 0) pd = 0.;
  }

  for (int i = 0; i < batches; ++i) {
    for (int j = 0; j < output_cols; ++j) {
      for (int k = 0; k < output_rows; ++k) {
        for (int d = 0; d < output_depth; ++d) {

          const int cstart = j * col_stride   - floor(pc);
          const int rstart = k * row_stride   - floor(pr);
          const int dstart = d * depth_stride - floor(pd);
          const int cend   = cstart + kernel_cols;
          const int rend   = rstart + kernel_rows;
          const int dend   = dstart + kernel_depth;

          for (int l = 0; l < in_channel; ++l) {
            TYPE acc = INITACC;
            int counter = 0;
            for (int a = cstart; a < cend; ++a) {
              for (int b = rstart; b < rend; ++b) {
                for (int c = dstart; c < dend; ++c){
                  if (a >= 0 && a < input_cols &&
                      b >= 0 && b < input_rows &&
                      c >= 0 && c < input_depth) {
                    int input_idx =
                      i * input_crdi + a * input_rdi + b * input_di +
                      c * in_channel + l;
                    TYPE t = *(input_ptr + input_idx);
                    ACCFN (acc, t);
                    counter++;
                  }
                }
              }
            }

            int output_idx =
              i * output_crdi + j * output_rdi + k * output_di +
              d * in_channel + l;
            *(output_ptr + output_idx) = UPDATEFN (acc, counter);
          }
        }
      }
    }
  }

  return Val_unit;
}


value FUN_BYTE (cuboid) (value * argv, int argn) {
  return FUN_NATIVE (cuboid) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16]
  );
}


value FUN_NATIVE (cuboid_backward) (
  value vInput, value vOutput_back, value vInput_back,
  value vBatches, value vInput_cols, value vInput_rows,
  value vInput_depth, value vIn_channel,
  value vKernel_cols, value vKernel_rows, value vKernel_depth,
  value vOutput_cols, value vOutput_rows, value vOutput_depth,
  value vCol_stride, value vRow_stride, value vDepth_stride,
  value vPadding
) {
  struct caml_ba_array *IN  = Caml_ba_array_val(vInput);
  struct caml_ba_array *OUB = Caml_ba_array_val(vOutput_back);
  struct caml_ba_array *INB = Caml_ba_array_val(vInput_back);
  TYPE *input_ptr = (TYPE *) IN->data;
  TYPE *output_backward_ptr = (TYPE *) OUB->data;
  TYPE *input_backward_ptr  = (TYPE *) INB->data;

  int batches       = Long_val(vBatches);
  int input_cols    = Long_val(vInput_cols);
  int input_rows    = Long_val(vInput_rows);
  int input_depth   = Long_val(vInput_depth);
  int in_channel    = Long_val(vIn_channel);
  int kernel_cols   = Long_val(vKernel_cols);
  int kernel_rows   = Long_val(vKernel_rows);
  int kernel_depth  = Long_val(vKernel_depth);
  int output_cols   = Long_val(vOutput_cols);
  int output_rows   = Long_val(vOutput_rows);
  int output_depth  = Long_val(vOutput_depth);
  int col_stride    = Long_val(vCol_stride);
  int row_stride    = Long_val(vRow_stride);
  int depth_stride  = Long_val(vDepth_stride);
  int padding       = Long_val(vPadding);

  const int ksize       = kernel_cols * kernel_rows * kernel_depth;
  const int output_crdi = output_cols * output_rows * output_depth * in_channel;
  const int output_rdi  = output_rows * output_depth * in_channel;
  const int output_di   = output_depth * in_channel;
  const int input_crdi  = input_cols * input_rows * input_depth * in_channel;
  const int input_rdi   = input_rows * input_depth * in_channel
  const int input_di    = input_depth * in_channel

  float pad_rows, pad_cols, pad_depth;
  if (padding == 1){
    pad_rows = 0.; pad_cols = 0.; pad_depth = 0.;
  } else {
    pad_rows = (row_stride * ( output_rows - 1) +
      kernel_rows - input_rows) / 2.;
    pad_cols = (col_stride * ( output_cols - 1) +
      kernel_cols - input_cols) / 2.;
    pad_depth = (depth_stride * ( output_depth - 1) +
      kernel_depth - input_depth) / 2.;
    if (pad_cols < 0)  pad_cols  = 0.;
    if (pad_rows < 0)  pad_rows  = 0.;
    if (pad_depth < 0) pad_depth = 0.;
  }

  memset(input_backward_ptr, 0,
    batches * input_cols * input_rows *
    input_depth * in_channel * sizeof(TYPE));

  for (int i = 0; i < batches; ++i) {
    for (int j = 0; j < output_cols; ++j) {
      for (int k = 0; k < output_rows; ++k) {
        for (int d = 0; d < output_depth; ++d) {

          const int cstart = j * col_stride   - floor(pad_cols);
          const int rstart = k * row_stride   - floor(pad_rows);
          const int dstart = d * depth_stride - floor(pad_depth);
          const int cend   = cstart + kernel_cols;
          const int rend   = rstart + kernel_rows;
          const int dend   = dstart + kernel_depth;

          for (int l = 0; l < in_channel; ++l) {
            TYPE m;
            int output_idx =
              i * output_crdi + j * output_rdi + k * output_di +
              d * in_channel + l;
            m = *(output_backward_ptr + output_idx);

            int idx[ksize];
            memset(idx, 0, ksize * sizeof(int));

            TYPE acc = INITACC;
            int max_idx = 0;
            int counter = 0;
            for (int a = cstart; a < cend; ++a) {
              for (int b = rstart; b < rend; ++b) {
                for (int c = dstart; c < dend; ++c) {
                  if (a >= 0 && a < input_cols &&
                      b >= 0 && b < input_rows &&
                      c >= 0 && c < input_depth) {
                    int input_idx =
                      i * input_crdi + a * input_rdi + b * input_di +
                      c * in_channel + l;
                    idx[counter++] = input_idx;

                    #ifdef OWL_TENSOR_MAX
                    TYPE t = *(input_ptr + input_idx);
                    if (acc < t){
                      acc = t;
                      max_idx = input_idx;
                    }
                    #endif
                  }
                }
              }
            }

            #ifdef OWL_TENSOR_AVG
            for (int i = 0; i < counter; i++) {
              *(input_backward_ptr + idx[i]) += UPDATEFN (m, counter);
            }
            #else
            *(input_backward_ptr + max_idx) += UPDATEFN (m, counter);
            #endif
          }
        }
      }
    }
  }
}


value FUN_BYTE (cuboid_backward) (value * argv, int argn) {
  return FUN_NATIVE (cuboid_backward) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16], argv[17]
  );
}


#endif /* OWL_ENABLE_TEMPLATE */
