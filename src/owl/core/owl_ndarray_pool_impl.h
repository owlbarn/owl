/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


CAMLprim value FUN_NATIVE (spatial) (
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

  memset(output_ptr, 0, batches * output_cri * sizeof(TYPE));

  int pr = 0, pc = 0;
  if (padding != 1){
    pr = (row_stride * ( output_rows - 1) + kernel_rows - input_rows) / 2;
    pc = (col_stride * ( output_cols - 1) + kernel_cols - input_cols) / 2;
    if (pr < 0) pr = 0;
    if (pc < 0) pc = 0;
  }

  #ifdef _OPENMP
    #pragma omp parallel for schedule(static)
  #endif /* _OPENMP */
  for (int i = 0; i < batches; ++i) {
    const int input_idx_base = i * input_cri;
    const int output_idx_base_i = i * output_cri;
    for (int j = 0; j < output_cols; ++j) {
      const int output_idx_base_j = output_idx_base_i + j * output_ri;
      for (int k = 0; k < output_rows; ++k) {
        const int output_idx_base = output_idx_base_j + k * in_channel;

        const int cstart = j * col_stride - pc;
        const int rstart = k * row_stride - pr;
        const int cend   = cstart + kernel_cols;
        const int rend   = rstart + kernel_rows;

        for (int l = 0; l < in_channel; ++l) {
          TYPE acc = INITACC;
          int c = 0;
          for (int a = cstart; a < cend; ++a) {
            for (int b = rstart; b < rend; ++b) {
              if (a >= 0 && a < input_cols &&
                  b >= 0 && b < input_rows) {
                int input_idx =
                   input_idx_base + a * input_ri + b * in_channel + l;
                TYPE t = *(input_ptr + input_idx);
                ACCFN (acc, t);
                c++;
              }
            }
          }

          int output_idx = output_idx_base + l;
          *(output_ptr + output_idx) = UPDATEFN (acc, c);
        }
      }
    }
  }

  return Val_unit;
}


CAMLprim value FUN_BYTE (spatial) (value * argv, int argn) {
  return FUN_NATIVE (spatial) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14]
  );
}


CAMLprim value FUN_NATIVE (spatial_backward) (
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
  const int input_cri  = input_cols  * input_rows  * in_channel;
  const int input_ri   = input_rows  * in_channel;

  if (pad_cols < 0) pad_cols = 0;
  if (pad_rows < 0) pad_rows = 0;

  memset(input_backward_ptr, 0,
    batches * input_cols * input_rows * in_channel * sizeof(TYPE));

  #ifdef _OPENMP
    #pragma omp parallel for schedule(static)
  #endif /* _OPENMP */
  for (int i = 0; i < batches; ++i) {
    const int input_idx_base = i * input_cri;
    const int output_idx_base_i = i * output_cri;
    for (int j = 0; j < output_cols; ++j) {
      const int output_idx_base_j = output_idx_base_i + j * output_ri;
      for (int k = 0; k < output_rows; ++k) {
        const int output_idx_base = output_idx_base_j + k * in_channel;

        const int cstart = j * col_stride - pad_cols;
        const int rstart = k * row_stride - pad_rows;
        const int cend   = cstart + kernel_cols;
        const int rend   = rstart + kernel_rows;

        for (int l = 0; l < in_channel; ++l) {
          TYPE m;
          int output_idx = output_idx_base + l;
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
                  input_idx_base + a * input_ri + b * in_channel + l;
                idx[c++] = input_idx;

                #ifdef OWL_NDARRAY_MAX
                TYPE t = *(input_ptr + input_idx);
                if (PLT(acc,t)){
                  acc = t;
                  max_idx = input_idx;
                }
                #endif
              }
            }
          }

          #ifdef OWL_NDARRAY_AVG
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

  return Val_unit;
}


CAMLprim value FUN_BYTE (spatial_backward) (value * argv, int argn) {
  return FUN_NATIVE (spatial_backward) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14]
  );
}


CAMLprim value FUN_NATIVE (cuboid) (
  value vInput, value vOutput,
  value vBatches, value vInput_cols, value vInput_rows,
  value vInput_dpts, value vIn_channel,
  value vKernel_cols, value vKernel_rows, value vKernel_dpts,
  value vOutput_cols, value vOutput_rows, value vOutput_dpts,
  value vDpt_stride, value vRow_stride,  value vCol_stride,
  value vPadding
) {
  struct caml_ba_array *IN = Caml_ba_array_val(vInput);
  struct caml_ba_array *OU = Caml_ba_array_val(vOutput);
  TYPE *input_ptr  = (TYPE *) IN->data;
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
  int dpt_stride  = Long_val(vDpt_stride);
  int row_stride  = Long_val(vRow_stride);
  int col_stride  = Long_val(vCol_stride);
  int padding     = Long_val(vPadding);

  const int output_crdi = output_cols * output_rows * output_dpts * in_channel;
  const int output_rdi  = output_rows * output_dpts * in_channel;
  const int output_di   = output_dpts * in_channel;
  const int input_crdi  = input_cols * input_rows * input_dpts * in_channel;
  const int input_rdi   = input_rows * input_dpts * in_channel;
  const int input_di    = input_dpts * in_channel;

  memset(output_ptr, 0, batches * output_crdi * sizeof(TYPE));

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

  #ifdef _OPENMP
    #pragma omp parallel for schedule(static)
  #endif /* _OPENMP */
  for (int i = 0; i < batches; ++i) {
    const int input_idx_base = i * input_crdi;
    const int output_idx_base_i = i * output_crdi;
    for (int j = 0; j < output_cols; ++j) {
      const int output_idx_base_j = output_idx_base_i + j * output_rdi;
      for (int k = 0; k < output_rows; ++k) {
        const int output_idx_base_k = output_idx_base_j + k * output_di;
        for (int d = 0; d < output_dpts; ++d) {
          const int output_idx_base = output_idx_base_k + d * in_channel;

          const int cstart = j * col_stride - pc;
          const int rstart = k * row_stride - pr;
          const int dstart = d * dpt_stride - pd;
          const int cend   = cstart + kernel_cols;
          const int rend   = rstart + kernel_rows;
          const int dend   = dstart + kernel_dpts;

          for (int l = 0; l < in_channel; ++l) {
            TYPE acc = INITACC;
            int counter = 0;
            for (int a = cstart; a < cend; ++a) {
              for (int b = rstart; b < rend; ++b) {
                for (int c = dstart; c < dend; ++c){
                  if (a >= 0 && a < input_cols &&
                      b >= 0 && b < input_rows &&
                      c >= 0 && c < input_dpts) {
                    int input_idx =
                      input_idx_base + a * input_rdi + b * input_di +
                      c * in_channel + l;
                    TYPE t = *(input_ptr + input_idx);
                    ACCFN (acc, t);
                    counter++;
                  }
                }
              }
            }

            int output_idx = output_idx_base + l;
            *(output_ptr + output_idx) = UPDATEFN (acc, counter);
          }
        }
      }
    }
  }

  return Val_unit;
}


CAMLprim value FUN_BYTE (cuboid) (value * argv, int argn) {
  return FUN_NATIVE (cuboid) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16]
  );
}


CAMLprim value FUN_NATIVE (cuboid_backward) (
  value vInput, value vOutput_back, value vInput_back,
  value vBatches, value vInput_cols, value vInput_rows,
  value vInput_dpts, value vIn_channel,
  value vKernel_cols, value vKernel_rows, value vKernel_dpts,
  value vOutput_cols, value vOutput_rows, value vOutput_dpts,
  value vCol_stride, value vRow_stride, value vDpt_stride,
  value vPadding
) {
  struct caml_ba_array *IN  = Caml_ba_array_val(vInput);
  struct caml_ba_array *OUB = Caml_ba_array_val(vOutput_back);
  struct caml_ba_array *INB = Caml_ba_array_val(vInput_back);
  TYPE *input_ptr = (TYPE *) IN->data;
  TYPE *output_backward_ptr = (TYPE *) OUB->data;
  TYPE *input_backward_ptr  = (TYPE *) INB->data;

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
  int col_stride  = Long_val(vCol_stride);
  int row_stride  = Long_val(vRow_stride);
  int dpt_stride  = Long_val(vDpt_stride);
  int padding     = Long_val(vPadding);

  const int ksize       = kernel_cols * kernel_rows * kernel_dpts;
  const int output_crdi = output_cols * output_rows * output_dpts * in_channel;
  const int output_rdi  = output_rows * output_dpts * in_channel;
  const int output_di   = output_dpts * in_channel;
  const int input_crdi  = input_cols * input_rows * input_dpts * in_channel;
  const int input_rdi   = input_rows * input_dpts * in_channel;
  const int input_di    = input_dpts * in_channel;

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

  memset(input_backward_ptr, 0, batches * input_crdi * sizeof(TYPE));

  #ifdef _OPENMP
    #pragma omp parallel for schedule(static)
  #endif /* _OPENMP */
  for (int i = 0; i < batches; ++i) {
    const int input_idx_base = i * input_crdi;
    const int output_idx_base_i = i * output_crdi;
    for (int j = 0; j < output_cols; ++j) {
      const int output_idx_base_j = output_idx_base_i + j * output_rdi;
      for (int k = 0; k < output_rows; ++k) {
        const int output_idx_base_k = output_idx_base_j + k * output_di;
        for (int d = 0; d < output_dpts; ++d) {
          const int output_idx_base = output_idx_base_k + d * in_channel;

          const int cstart = j * col_stride - pc;
          const int rstart = k * row_stride - pr;
          const int dstart = d * dpt_stride - pd;
          const int cend   = cstart + kernel_cols;
          const int rend   = rstart + kernel_rows;
          const int dend   = dstart + kernel_dpts;

          for (int l = 0; l < in_channel; ++l) {
            TYPE m;
            int output_idx = output_idx_base + l;
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
                      c >= 0 && c < input_dpts) {
                    int input_idx =
                      input_idx_base + a * input_rdi + b * input_di +
                      c * in_channel + l;
                    idx[counter++] = input_idx;

                    #ifdef OWL_NDARRAY_MAX
                    TYPE t = *(input_ptr + input_idx);
                    if (PLT(acc,t)){
                      acc = t;
                      max_idx = input_idx;
                    }
                    #endif
                  }
                }
              }
            }

            #ifdef OWL_NDARRAY_AVG
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

  return Val_unit;
}


CAMLprim value FUN_BYTE (cuboid_backward) (value * argv, int argn) {
  return FUN_NATIVE (cuboid_backward) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16], argv[17]
  );
}

#ifdef OWL_NDARRAY_MAX

CAMLprim value FUN_NATIVE (spatial_arg) (
  value vInput_ptr, value vOutput_ptr, value vArgmax_ptr,
  value vBatches, value vInput_cols, value vInput_rows, value vIn_channel,
  value vKernel_cols, value vKernel_rows,
  value vOutput_cols, value vOutput_rows,
  value vRow_stride,  value vCol_stride,
  value vPad_rows, value vPad_cols
) {
  struct caml_ba_array *IN = Caml_ba_array_val(vInput_ptr);
  struct caml_ba_array *OU = Caml_ba_array_val(vOutput_ptr);
  struct caml_ba_array *AG = Caml_ba_array_val(vArgmax_ptr);
  TYPE *input_ptr  = (TYPE *) IN->data;
  TYPE *output_ptr = (TYPE *) OU->data;
  int64_t *argmax_ptr = (int64_t *) AG->data;

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

  if (pad_rows < 0) pad_rows = 0.;
  if (pad_cols < 0) pad_cols = 0.;

  const int input_cri  = input_cols * input_rows * in_channel;
  const int input_ri   = input_rows * in_channel;
  const int output_cri = output_cols * output_rows * in_channel;
  const int output_ri  = output_rows * in_channel;

  memset(output_ptr, 0, batches * output_cri * sizeof(TYPE));
  memset(argmax_ptr, 0, batches * output_cri * sizeof(int64_t));

  #ifdef _OPENMP
    #pragma omp parallel for schedule(static)
  #endif /* _OPENMP */
  for (int i = 0; i < batches; ++i) {
    const int input_idx_base = i * input_cri;
    const int output_idx_base_i = i * output_cri;
    for (int j = 0; j < output_cols; ++j) {
      const int output_idx_base_j = output_idx_base_i + j * output_ri;
      for (int k = 0; k < output_rows; ++k) {
        const int output_idx_base = output_idx_base_j + k * in_channel;

        const int cstart = j * col_stride - pad_cols;
        const int rstart = k * row_stride - pad_rows;
        const int cend   = cstart + kernel_cols;
        const int rend   = rstart + kernel_rows;

        for (int l = 0; l < in_channel; ++l) {
          TYPE acc = INITACC;
          int max_idx = -1;
          int c = 0;
          for (int a = cstart; a < cend; ++a) {
            for (int b = rstart; b < rend; ++b) {
              if (a >= 0 && a < input_cols &&
                  b >= 0 && b < input_rows) {
                int input_idx =
                  input_idx_base + a * input_ri + b * in_channel + l;
                TYPE t = *(input_ptr + input_idx);
                if (PLT(acc,t)){
                  acc = t;
                  max_idx = input_idx;
                }
                c++;
              }
            }
          }

          int output_idx = output_idx_base + l;
          *(output_ptr + output_idx) = acc;
          *(argmax_ptr + output_idx) = (int64_t) max_idx;
        }
      }
    }
  }

  return Val_unit;
}


CAMLprim value FUN_BYTE (spatial_arg) (value * argv, int argn) {
  return FUN_NATIVE (spatial_arg) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14]
  );
}


#endif /* OWL_NDARRAY_MAX */


#endif /* OWL_ENABLE_TEMPLATE */
