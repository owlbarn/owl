/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


CAMLprim value FUN_NATIVE (spatial) (
  value vInput_ptr, value vKernel_ptr, value vOutput_ptr,
  value vBatches, value vInput_cols, value vInput_rows, value vIn_channel,
  value vKernel_cols, value vKernel_rows,
  value vOutput_cols, value vOutput_rows, value vOut_channel,
  value vRow_stride,  value vCol_stride,
  value vPadding, value vRow_in_stride, value vCol_in_stride
) {
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
  const int output_cr  = output_rows * output_cols;
  const int output_crb = output_rows * output_cols * batches;
  const int kernel_cri = kernel_cols * kernel_rows * in_channel;

  INIT;

  TYPE *inpt2d = (TYPE *) calloc(kernel_cri * output_crb, sizeof(TYPE));
  if (inpt2d == NULL) exit(1);

  memset(output_ptr, 0, batches * output_cri * sizeof(TYPE));

  int pr = 0, pc = 0;
  if (padding != 1){
    pr = (row_stride * ( output_rows - 1) + kernel_rows - input_rows) / 2;
    pc = (col_stride * ( output_cols - 1) + kernel_cols - input_cols) / 2;
    if (pr < 0) pr = 0;
    if (pc < 0) pc = 0;
  }

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

  GEMM(CblasRowMajor, CblasNoTrans, CblasNoTrans,
    output_crb, out_channel, kernel_cri, ALPHA,
    inpt2d, kernel_cri, kernel_ptr, out_channel,
    BETA, output_ptr, out_channel);

  free(inpt2d);

  return Val_unit;
}


CAMLprim value FUN_BYTE (spatial) (value * argv, int argn) {
  return FUN_NATIVE (spatial) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16]
  );
}


CAMLprim value FUN_NATIVE (spatial_backward_kernel) (
  value vInput_ptr, value vKernel_ptr, value vOutput_ptr,
  value vBatches, value vInput_cols, value vInput_rows, value vIn_channel,
  value vKernel_cols, value vKernel_rows,
  value vOutput_cols, value vOutput_rows, value vOut_channel,
  value vRow_stride,  value vCol_stride,
  value vRow_in_stride, value vCol_in_stride
) {
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
  const int output_ri  = out_channel * output_rows;
  const int output_cr  = output_rows * output_cols;
  const int output_crb = output_rows * output_cols * batches;
  const int kernel_cri = kernel_cols * kernel_rows * in_channel;

  INIT;

  TYPE *inpt2d = (TYPE *) calloc(kernel_cri * output_crb, sizeof(TYPE));
  if (inpt2d == NULL) exit(1);
  TYPE *kern2d = (TYPE *) calloc(kernel_cri * out_channel, sizeof(TYPE));
  if (kern2d == NULL) exit(1);

  memset(kernel_ptr, 0, kernel_cols * kernel_rio * sizeof(TYPE));

  int pad_rows = row_stride * (output_rows - 1) + kernel_rows - input_rows;
  int pad_cols = col_stride * (output_cols - 1) + kernel_cols - input_cols;
  int p_top  = pad_rows / 2;
  int p_left = pad_cols / 2;
  if (p_top  < 0) p_top  = 0;
  if (p_left < 0) p_left = 0;

  for (int i = 0; i < output_crb; ++i) {
    int bt = i / output_cr;
    int cr = i % output_cr;
    int c = cr / output_rows;
    int r = cr % output_rows;

    const int cstart = c * col_stride - p_left;
    const int rstart = r * row_stride - p_top;
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

  GEMM(CblasRowMajor, CblasTrans, CblasNoTrans,
    out_channel, kernel_cri, output_crb, ALPHA,
    output_ptr, out_channel, inpt2d, kernel_cri,
    BETA, kern2d, kernel_cri);

  int cnt = 0;
  for (int j = 0; j < kernel_cri; ++j) {
    for (int i = 0; i < out_channel; ++i) {
      kernel_ptr[cnt++] = kern2d[i * kernel_cri + j];
    }
  }

  free(inpt2d);
  free(kern2d);

  return Val_unit;
}


CAMLprim value FUN_BYTE (spatial_backward_kernel) (value * argv, int argn) {
  return FUN_NATIVE (spatial_backward_kernel) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15]
  );
}


CAMLprim value FUN_NATIVE (spatial_backward_input) (
  value vInput_ptr, value vKernel_ptr, value vOutput_ptr,
  value vBatches, value vInput_cols, value vInput_rows, value vIn_channel,
  value vKernel_cols, value vKernel_rows,
  value vOutput_cols, value vOutput_rows, value vOut_channel,
  value vRow_stride,  value vCol_stride,
  value vRow_in_stride, value vCol_in_stride
) {
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
  const int output_ri  = out_channel * output_rows;
  const int output_cr  = output_rows * output_cols;
  const int output_crb = output_rows * output_cols * batches;
  const int kernel_cri = kernel_cols * kernel_rows * in_channel;

  INIT;

  TYPE *inpt2d = (TYPE *) calloc(kernel_cri * output_crb, sizeof(TYPE));
  if (inpt2d == NULL) exit(1);

  memset(input_ptr, 0, batches * input_cri * sizeof(TYPE));

  int pad_rows = row_stride * (output_rows - 1) + kernel_rows - input_rows;
  int pad_cols = col_stride * (output_cols - 1) + kernel_cols - input_cols;
  int p_top  = pad_rows / 2;
  int p_left = pad_cols / 2;
  if (p_top  < 0) p_top  = 0;
  if (p_left < 0) p_left = 0;

  GEMM(CblasRowMajor, CblasNoTrans, CblasTrans,
    output_crb, kernel_cri, out_channel, ALPHA,
    output_ptr, out_channel, kernel_ptr, out_channel,
    BETA, inpt2d, kernel_cri);

  for (int i = 0; i < output_crb; ++i) {
    int bt = i / output_cr;
    int cr = i % output_cr;
    int c = cr / output_rows;
    int r = cr % output_rows;

    const int cstart = c * col_stride - p_left;
    const int rstart = r * row_stride - p_top;
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
            input_ptr[input_idx] += inpt2d[i * kernel_cri + cnt];
          }
          ++cnt;
        }
      }
    }
  }

  free(inpt2d);

  return Val_unit;
}


CAMLprim value FUN_BYTE (spatial_backward_input) (value * argv, int argn) {
  return FUN_NATIVE (spatial_backward_input) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15]
  );
}


CAMLprim value FUN_NATIVE (cuboid) (
  value vInput, value vKernel, value vOutput,
  value vBatches, value vInput_cols, value vInput_rows,
  value vInput_dpts, value vIn_channel,
  value vKernel_cols, value vKernel_rows, value vKernel_dpts,
  value vOutput_cols, value vOutput_rows,
  value vOutput_dpts, value vOut_channel,
  value vDpt_stride, value vRow_stride,  value vCol_stride,
  value vPadding
) {
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
  const int output_crdo = out_channel * output_dpts * output_rows * output_cols;
  const int output_dr   = output_dpts * output_rows;
  const int output_drc  = output_dpts * output_rows * output_cols;
  const int output_drcb = output_dpts * output_rows * output_cols * batches;
  const int kernel_idrc = in_channel  * kernel_dpts * kernel_rows * kernel_cols;

  INIT;

  TYPE *inpt2d = (TYPE *) calloc(kernel_idrc * output_drcb, sizeof(TYPE));
  if (inpt2d == NULL) exit(1);

  memset(output_ptr, 0, batches * output_crdo * sizeof(TYPE));

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

  for (int i = 0; i < output_drcb; ++i) {
    int bt  = i / output_drc;
    int jkd = i % output_drc;
    int j   = jkd / output_dr;
    int kd  = jkd % output_dr;
    int k   = kd / output_dpts;
    int d   = kd % output_dpts;

    const int cstart = j * col_stride - pc;
    const int rstart = k * row_stride - pr;
    const int dstart = d * dpt_stride - pd;
    const int cend   = cstart + kernel_cols;
    const int rend   = rstart + kernel_rows;
    const int dend   = dstart + kernel_dpts;
    const int input_idx_base = bt * input_crdi;

    int cnt = 0;
    for (int a = cstart; a < cend; ++a) {
      for (int b = rstart; b < rend; ++b) {
        for (int c = dstart; c < dend; ++c) {
          for (int h = 0; h < in_channel; ++h) {
            if (a >= 0 && a < input_cols &&
                b >= 0 && b < input_rows &&
                c >= 0 && c < input_dpts) {
              int input_idx =
                input_idx_base + a * input_rdi + b * input_di +
                c * in_channel + h;
              inpt2d[i * kernel_idrc + cnt] = input_ptr[input_idx];
            }
            ++cnt;
          }
        }
      }
    }
  }

  GEMM(CblasRowMajor, CblasNoTrans, CblasNoTrans,
    output_drcb, out_channel, kernel_idrc, ALPHA,
    inpt2d, kernel_idrc, kernel_ptr, out_channel,
    BETA, output_ptr, out_channel);

  free(inpt2d);

  return Val_unit;
}


CAMLprim value FUN_BYTE (cuboid) (value * argv, int argn) {
  return FUN_NATIVE (cuboid) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16], argv[17], argv[18]
  );
}


CAMLprim value FUN_NATIVE (cuboid_backward_kernel) (
  value vInput, value vKernel, value vOutput,
  value vBatches, value vInput_cols, value vInput_rows,
  value vInput_dpts, value vIn_channel,
  value vKernel_cols, value vKernel_rows, value vKernel_dpts,
  value vOutput_cols, value vOutput_rows,
  value vOutput_dpts, value vOut_channel,
  value vDpt_stride, value vRow_stride,  value vCol_stride
) {
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
  const int output_dr   = output_dpts * output_rows;
  const int output_drc  = output_dpts * output_rows * output_cols;
  const int output_drcb = output_dpts * output_rows * output_cols * batches;
  const int kernel_idrc = in_channel  * kernel_dpts * kernel_rows * kernel_cols;

  INIT;

  TYPE *inpt2d = (TYPE *) calloc(kernel_idrc * output_drcb, sizeof(TYPE));
  if (inpt2d == NULL) exit(1);
  TYPE *kern2d = (TYPE *) calloc(kernel_idrc * out_channel, sizeof(TYPE));
  if (kern2d == NULL) exit(1);

  memset(kernel_ptr, 0, kernel_cols * kernel_rdio * sizeof(TYPE));

  int pd, pr, pc;
  int pad_cols = col_stride * (output_cols - 1) + kernel_cols - input_cols;
  int pad_rows = row_stride * (output_rows - 1) + kernel_rows - input_rows;
  int pad_dpts = dpt_stride * (output_dpts - 1) + kernel_dpts - input_dpts;
  pc = pad_cols / 2; if (pc < 0) pc = 0;
  pr = pad_rows / 2; if (pr < 0) pr = 0;
  pd = pad_dpts / 2; if (pd < 0) pd = 0;

  for (int i = 0; i < output_drcb; ++i) {
    int bt  = i / output_drc;
    int jkd = i % output_drc;
    int j   = jkd / output_dr;
    int kd  = jkd % output_dr;
    int k   = kd / output_dpts;
    int d   = kd % output_dpts;

    const int cstart = j * col_stride - pc;
    const int rstart = k * row_stride - pr;
    const int dstart = d * dpt_stride - pd;
    const int cend   = cstart + kernel_cols;
    const int rend   = rstart + kernel_rows;
    const int dend   = dstart + kernel_dpts;
    const int input_idx_base = bt * input_crdi;

    int cnt = 0;
    for (int a = cstart; a < cend; ++a) {
      for (int b = rstart; b < rend; ++b) {
        for (int c = dstart; c < dend; ++c) {
          for (int h = 0; h < in_channel; ++h) {
            if (a >= 0 && a < input_cols &&
                b >= 0 && b < input_rows &&
                c >= 0 && c < input_dpts) {
              int input_idx =
                input_idx_base + a * input_rdi + b * input_di +
                c * in_channel + h;
              inpt2d[i * kernel_idrc + cnt] = input_ptr[input_idx];
            }
            ++cnt;
          }
        }
      }
    }
  }

  GEMM(CblasRowMajor, CblasTrans, CblasNoTrans,
    out_channel, kernel_idrc, output_drcb, ALPHA,
    output_ptr, out_channel, inpt2d, kernel_idrc,
    BETA, kern2d, kernel_idrc);

  int cnt = 0;
  for (int j = 0; j < kernel_idrc; ++j) {
    for (int i = 0; i < out_channel; ++i) {
      kernel_ptr[cnt++] = kern2d[i * kernel_idrc + j];
    }
  }

  free(inpt2d);
  free(kern2d);

  return Val_unit;
}


CAMLprim value FUN_BYTE (cuboid_backward_kernel) (value * argv, int argn) {
  return FUN_NATIVE (cuboid_backward_kernel) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16], argv[17]
  );
}


CAMLprim value FUN_NATIVE (cuboid_backward_input) (
  value vInput, value vKernel, value vOutput,
  value vBatches, value vInput_cols, value vInput_rows,
  value vInput_dpts, value vIn_channel,
  value vKernel_cols, value vKernel_rows, value vKernel_dpts,
  value vOutput_cols, value vOutput_rows,
  value vOutput_dpts, value vOut_channel,
  value vDpt_stride, value vRow_stride,  value vCol_stride
) {
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
  const int output_dr   = output_dpts * output_rows;
  const int output_drc  = output_dpts * output_rows * output_cols;
  const int output_drcb = output_dpts * output_rows * output_cols * batches;
  const int kernel_idrc = in_channel  * kernel_dpts * kernel_rows * kernel_cols;

  INIT;

  TYPE *inpt2d = (TYPE *) calloc(kernel_idrc * output_drcb, sizeof(TYPE));
  if (inpt2d == NULL) exit(1);

  memset(input_ptr, 0, batches * input_crdi * sizeof(TYPE));

  int pd, pr, pc;
  int pad_cols = col_stride * (output_cols - 1) + kernel_cols - input_cols;
  int pad_rows = row_stride * (output_rows - 1) + kernel_rows - input_rows;
  int pad_dpts = dpt_stride * (output_dpts - 1) + kernel_dpts - input_dpts;
  pc = pad_cols / 2; if (pc < 0) pc = 0;
  pr = pad_rows / 2; if (pr < 0) pr = 0;
  pd = pad_dpts / 2; if (pd < 0) pd = 0;

  GEMM(CblasRowMajor, CblasNoTrans, CblasTrans,
    output_drcb, kernel_idrc, out_channel, ALPHA,
    output_ptr, out_channel, kernel_ptr, out_channel,
    BETA, inpt2d, kernel_idrc);

  for (int i = 0; i < output_drcb; ++i) {
    int bt  = i / output_drc;
    int jkd = i % output_drc;
    int j   = jkd / output_dr;
    int kd  = jkd % output_dr;
    int k   = kd / output_dpts;
    int d   = kd % output_dpts;

    const int cstart = j * col_stride - pc;
    const int rstart = k * row_stride - pr;
    const int dstart = d * dpt_stride - pd;
    const int cend   = cstart + kernel_cols;
    const int rend   = rstart + kernel_rows;
    const int dend   = dstart + kernel_dpts;
    const int input_idx_base = bt * input_crdi;

    int cnt = 0;
    for (int a = cstart; a < cend; ++a) {
      for (int b = rstart; b < rend; ++b) {
        for (int c = dstart; c < dend; ++c) {
          for (int h = 0; h < in_channel; ++h) {
            if (a >= 0 && a < input_cols &&
                b >= 0 && b < input_rows &&
                c >= 0 && c < input_dpts) {
              int input_idx =
                input_idx_base + a * input_rdi + b * input_di +
                c * in_channel + h;
              input_ptr[input_idx] += inpt2d[i * kernel_idrc + cnt];
            }
            ++cnt;
          }
        }
      }
    }
  }

  free(inpt2d);

  return Val_unit;
}


CAMLprim value FUN_BYTE (cuboid_backward_input) (value * argv, int argn) {
  return FUN_NATIVE (cuboid_backward_input) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16], argv[17]
  );
}


CAMLprim value FUN_NATIVE (spatial_transpose) (
  value vInput_ptr, value vKernel_ptr, value vOutput_ptr,
  value vBatches, value vInput_cols, value vInput_rows, value vIn_channel,
  value vKernel_cols, value vKernel_rows,
  value vOutput_cols, value vOutput_rows, value vOut_channel,
  value vRow_stride,  value vCol_stride,
  value vPadding, value vRow_in_stride, value vCol_in_stride
) {
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
  const int output_cr  = output_rows * output_cols;
  const int output_crb = output_rows * output_cols * batches;
  const int kernel_cri = kernel_cols * kernel_rows * in_channel;
  const int input_crb  = input_rows  * input_cols  * batches;
  const int input_cr   = input_rows  * input_cols;
  const int output_ri  = in_channel  * output_rows;

  INIT;

  int pad_rows = row_stride * (input_rows - 1) + kernel_rows - output_rows;
  int pad_cols = col_stride * (input_cols - 1) + kernel_cols - output_cols;
  int p_top  = pad_rows / 2;
  int p_left = pad_cols / 2;
  if (p_top  <= 0) p_top  = kernel_rows - 1;
  if (p_left <= 0) p_left = kernel_cols - 1;

  TYPE *inpt2d = (TYPE *) calloc(kernel_cri * output_crb, sizeof(TYPE));
  if (inpt2d == NULL) exit(1);

  const int ext_input_cols = input_cols + (input_cols - 1) * (col_stride - 1);
  const int ext_input_rows = input_rows + (input_rows - 1) * (row_stride - 1);
  const int ext_input_cri = ext_input_cols * ext_input_rows * in_channel;
  const int ext_input_ri  = ext_input_rows * in_channel;
  const int ext_input_crb = ext_input_cols * ext_input_rows * batches;
  const int ext_input_cr  = ext_input_cols * ext_input_rows;

  TYPE *ext_inp = (TYPE *) calloc(batches * ext_input_cols * ext_input_rows
    * in_channel, sizeof(TYPE));
  if (ext_inp == NULL) exit(1);

  int idx_old = 0;
  for (int b = 0; b < batches; ++b){
    for (int c = 0; c < input_cols; c++){
      for (int r = 0; r < input_rows; r++){
        for (int i = 0; i < in_channel; i++) {
          int cx = col_stride * c;
          int rx = row_stride * r;
          int idx = b * ext_input_cri + cx * ext_input_ri + rx * in_channel + i;
          ext_inp[idx] = input_ptr[idx_old++];
        }
      }
    }
  }

  for (int i = 0; i < output_crb; ++i) {
    int bt = i / output_cr;
    int cr = i % output_cr;
    int c = cr / output_rows;
    int r = cr % output_rows;

    const int cstart = c - p_left;
    const int rstart = r - p_top;
    const int cend = cstart + kernel_cols;
    const int rend = rstart + kernel_rows;
    const int input_idx_base = bt * output_cri;

    int cnt = 0;
    TYPE sum = 0;
    for (int a = cstart; a < cend; ++a) {
      for (int b = rstart; b < rend; ++b) {
        for (int h = 0; h < in_channel; ++h) {
          if (a < ext_input_cols && a >= 0 &&
              b < ext_input_rows && b >= 0 &&
              a % col_stride == 0 &&
              b % row_stride == 0) {
            int input_idx =
               input_idx_base + a * ext_input_ri + b * in_channel + h;
            inpt2d[i * kernel_cri + cnt] += ext_inp[input_idx];
          }
          ++cnt;
        }
      }
    }
  }

  GEMM(CblasRowMajor, CblasNoTrans, CblasNoTrans,
    output_crb, out_channel, kernel_cri, ALPHA,
    inpt2d, kernel_cri, kernel_ptr, out_channel,
    BETA, output_ptr, out_channel);

  free(inpt2d);
  free(ext_inp);

  return Val_unit;
}


CAMLprim value FUN_BYTE (spatial_transpose) (value * argv, int argn) {
  return FUN_NATIVE (spatial_transpose) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16]
  );
}


#endif /* OWL_ENABLE_TEMPLATE */
