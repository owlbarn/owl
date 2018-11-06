/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifndef OWL_CORE_CONV_IMPL
#define OWL_CORE_CONV_IMPL

/*
 * Calculate the cache sizes and block sizes for convolution operations.
 * Code heavily inspired by Eigen (http://eigen.tuxfamily.org/).
 */

#define IM2COL_THRESHOLD 512 * 1024
#define ALIGN_SIZE 32 // for AVX address alignment


OWL_INLINE void query_cache_sizes_intel(int* l1p, int* l2p, int* l3p) {
  int cpuinfo[4];
  int l1 = 0, l2 = 0, l3 = 0;
  int cache_id = 0;
  int cache_type = 0;
  do {
    cpuinfo[0] = cpuinfo[1] = cpuinfo[2] = cpuinfo[3] = 0;
    CPUID(cpuinfo, 0x4, cache_id);
    cache_type = (cpuinfo[0] & 0x0F) >> 0;

    if(cache_type == 1 || cache_type == 3) {
      int cache_level = (cpuinfo[0] & 0xE0) >> 5;
      int ways        = (cpuinfo[1] & 0xFFC00000) >> 22;
      int partitions  = (cpuinfo[1] & 0x003FF000) >> 12;
      int line_size   = (cpuinfo[1] & 0x00000FFF) >>  0;
      int sets        = (cpuinfo[2]);

      int cache_size = (ways + 1) * (partitions + 1) * (line_size + 1) * (sets + 1);
      switch(cache_level) {
        case 1: l1 = cache_size; break;
        case 2: l2 = cache_size; break;
        case 3: l3 = cache_size; break;
        default: break;
      }
    }
    cache_id++;
  } while(cache_type > 0 && cache_id < 16);

  *l1p = l1; *l2p = l2; *l3p = l3;
  return;
}


OWL_INLINE void query_cache_sizes(int* l1p, int* l2p, int* l3p) {
  if (OWL_ARCH_i386 || OWL_ARCH_x86_64) {
    int cpuinfo[4];
    CPUID(cpuinfo, 0x0, 0);
    int highest_func = cpuinfo[1];
    if (highest_func >= 4)
      query_cache_sizes_intel(l1p, l2p, l3p);
    else {
      *l1p = 32 * 1024;
      *l2p = 256 * 1024;
      *l3p = 2048 * 1024;
    }
  } else {
    *l1p = 16 * 1024;
    *l2p = 512 * 1024;
    *l3p = 512 * 1024;
  }
}


// The effect of calculating block size according to cache sizes is yet to be
// proved here since we use OpenBLAS GEMM directly; also, note that we
// calculate `InputMatrix x KernelMatrix`, not the other way around.
void compute_block_sizes(int* kp, int* mp, int* np, int typesize) {
  int l1, l2, l3;
  query_cache_sizes(&l1, &l2, &l3);
  // set the cache sizes to small numbers when debugging

  int k = *kp;
  int m = *mp;
  int n = *np;

  if (fmaxf(k, fmaxf(m, n)) < 50) {
    return;
  }

  int nr = 4;
  int num_reg = 16;
  int mr = num_reg / (2 * nr) * typesize;
  int k_strip = 8;
  int k_div = (mr + nr) * typesize;
  int k_sub = mr * nr * typesize;

  const int max_kc = fmaxf(((l1 - k_sub) / k_div) & (~(k_strip - 1)), 1);
  const int old_k = k;

  if (k > max_kc) {
    k = (k % max_kc) == 0 ? max_kc
      : max_kc - k_strip * ((max_kc - 1 - (k % max_kc)) / (k_strip * (k / max_kc + 1)));
    //assert (old_k / k == old_k / max_kc);
  }

  int max_nc;
  const int actual_l2 = 1572864; // l3 for debug; otherwise 1572864
  const int lhs_bytes = m * k * typesize;
  const int rest_l1 = l1 - k_sub - lhs_bytes;
  if (rest_l1 >= nr * k * typesize) {
    max_nc = rest_l1 / (k * typesize);
  } else {
    max_nc = (3 * actual_l2) / (4 * max_kc * typesize);
  }

  int nc = (int) (fminf(actual_l2 / (2 * k * typesize), max_nc)) & (~(nr - 1));
  if (n > nc) {
    n = (n % nc == 0) ? nc : (nc - nr * ((nc - (n % nc)) / (nr * (n / nc + 1))));
  } else if (old_k == k) {
    int kn_size = k * n * typesize;
    int actual_lm = actual_l2;
    int max_mc = m;

    if (kn_size < 1024) {
      actual_lm = l1;
    } else if (l3 != 0 && kn_size <= 32768) {
      actual_lm = l2;
      max_mc = fminf(576, max_mc);
    }
    int mc = fminf(actual_lm / (3 * k * typesize), max_mc);
    if (mc > mr) {
      mc -= mc % mr;
    }
    else if (mc == 0) {
      *kp = k; *mp = m; *np = n;
      return;
    }
    m = (m % mc == 0) ? mc : (mc - mr * ((mc - (m % mc)) / (mr * (m / mc + 1))));
  }

  *kp = k; *mp = m; *np = n;
  return;
}

#endif /* OWL_CORE_CONV_IMPL */


#ifdef OWL_ENABLE_TEMPLATE

#ifdef AVX_PSIZE

/*
 * Fill in temporary input matrix from input tensor with vectorisation.
 * Currently only support AVX instruciton set.
 */

void ACX_FUN_LOAD (load_sub_matrix_fast, spatial) (
  TYPE* input_ptr, TYPE* output_ptr, int* cmk_ptr, int kc_strip, int k,
  int kernel_ri, int input_ri, int in_channel, int idx_base, int cstart,
  int rstart, int input_cols, int input_rows, short reverse_mode
) {
   // assume output_ptr is aligned; if in_channel % AVX_PSIZE == 0, the input
   // matrix can always be loaded consecutively by a step of AVX_PSIZE
  for (int ik = 0; ik < kc_strip; ik += AVX_PSIZE) {
    int kc  = (k + ik) / kernel_ri;
    int kri = (k + ik) - kc * kernel_ri;
    int kr  = kri / in_channel;
    int ki  = kri - kr * in_channel;

    int input_col = kc + cstart;
    int input_row = kr + rstart;

    if (input_col < input_cols && input_col >= 0 &&
      input_row < input_rows && input_row >= 0) {
      int input_index = idx_base + input_col * input_ri
        + input_row * in_channel + ki;
      if (reverse_mode == 0) {
        AVX_TYPE v = AVX_LOADU(input_ptr + input_index);
        AVX_STOREA(output_ptr + (*cmk_ptr), v);
      }
      else {
        AVX_TYPE v1 = AVX_LOADA(output_ptr + (*cmk_ptr));
        AVX_TYPE v2 = AVX_LOADU(input_ptr + input_index);
        AVX_TYPE v  = AVX_ADD(v1, v2);
        AVX_STOREU(input_ptr + input_index, v);
      }
    }

    *cmk_ptr += AVX_PSIZE;
  }
  return;
}


void ACX_FUN_LOAD (load_sub_matrix, spatial) (
  TYPE* input_ptr, TYPE* output_ptr, int* cmk_ptr, int kc_strip, int actual_kc,
  int k, int kernel_ri, int input_ri, int in_channel, int idx_base,
  int cstart, int rstart, int input_cols, int input_rows,
  int kernel_rows, short reverse_mode
){
  int ik = 0;
  // first, load `kc_strip` numbers with a step of AVX_PSIZE;
  // assume `kc_strip % AVX_PSIZE == 0`
  for ( ; ik < kc_strip; ik += AVX_PSIZE) {
    const int cr_set[2] = {(k + ik) / in_channel,
      (k + ik + AVX_PSIZE - 1) / in_channel};
    const int c_set[2] = {cr_set[0] / kernel_rows,
      cr_set[1] / kernel_rows};
    const int cols[2]  = {cstart + c_set[0], cstart + c_set[1]};

    // out of bounds; set the next AVX_PSIZE numbers to 0
    if (cols[0] >= input_cols || cols[1] < 0) {
      *cmk_ptr += AVX_PSIZE;
      continue;
    }
    else if (cols[0] == cols[1]) {
      const int r_set[2] = {cr_set[0] - c_set[0] * kernel_rows,
        cr_set[1] - c_set[1] * kernel_rows};
      const int rows[2]  = {rstart + r_set[0], rstart + r_set[1]};

      // out of bounds; set the next AVX_PSIZE numbers to 0
      if (rows[0] >= input_rows || rows[1] < 0) {
        *cmk_ptr += AVX_PSIZE;
        continue;
      }
      // next AVX_PSIZE numbers can be loaded consecutively
      else if (rows[0] >= 0 && rows[1] < input_rows) {
        int ki = k + ik - cr_set[0] * in_channel;
        int input_index = idx_base + cols[0] * input_ri
          + rows[0] * in_channel + ki;

        if (reverse_mode == 0) {
          AVX_TYPE v = AVX_LOADU(input_ptr + input_index);
          AVX_STOREU(output_ptr + (*cmk_ptr), v);
        }
        else {
          AVX_TYPE v1 = AVX_LOADU(output_ptr + (*cmk_ptr));
          AVX_TYPE v2 = AVX_LOADU(input_ptr + input_index);
          AVX_TYPE v  = AVX_ADD(v1, v2);
          AVX_STOREU(input_ptr + input_index, v);
        }

        *cmk_ptr += AVX_PSIZE;
        continue;
      }

    }

    // previous special cases do not apply; calculate input index one by one
    for (int ip = 0; ip < AVX_PSIZE; ip++) {
      int kc  = (k + ik + ip) / kernel_ri;
      int kri = (k + ik + ip) - kc * kernel_ri;
      int kr  = kri / in_channel;
      int ki  = kri - kr * in_channel;

      int input_col = kc + cstart;
      int input_row = kr + rstart;
      if (input_col < input_cols && input_col >= 0 &&
        input_row < input_rows && input_row >= 0) {
        int input_index = idx_base + input_col * input_ri
          + input_row * in_channel + ki;
        if (reverse_mode == 0)
          output_ptr[*cmk_ptr] = input_ptr[input_index];
        else
          input_ptr[input_index] += output_ptr[*cmk_ptr];
      }
      *cmk_ptr += 1;
    }
  }

  // second, load the rest `actual_kc - kc_strip` numbers
  for (; ik < actual_kc; ik++) {
    int kc  = (k + ik) / kernel_ri;
    int kri = (k + ik) - kc * kernel_ri;
    int kr  = kri / in_channel;
    int ki  = kri - kr * in_channel;

    int input_col = kc + cstart;
    int input_row = kr + rstart;
    if (input_col < input_cols && input_col >= 0 &&
      input_row < input_rows && input_row >= 0) {
      int input_index = idx_base + input_col * input_ri
        + input_row * in_channel + ki;
      if (reverse_mode == 0)
        output_ptr[*cmk_ptr] = input_ptr[input_index];
      else
        input_ptr[input_index] += output_ptr[*cmk_ptr];
    }
    *cmk_ptr += 1;
  }

  return;
}

#endif /* AVX_PSIZE */


/*
 * GEBP-based implementation. See Goto et.al [08] for detail.
 */

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
  const int kernel_cr  = kernel_cols * kernel_rows;
  const int kernel_ri  = kernel_rows * in_channel;

  memset(output_ptr, 0, batches * output_cri * sizeof(TYPE));
  INIT;

  int pr = 0, pc = 0;
  if (padding != 1) {
    pr = (row_stride * ( output_rows - 1) + kernel_rows - input_rows) / 2;
    pc = (col_stride * ( output_cols - 1) + kernel_cols - input_cols) / 2;
    if (pr < 0) pr = 0;
    if (pc < 0) pc = 0;
  }

  // if generated input matrix is small enough, use im2col implementation
  int mat_size = kernel_cri * output_crb;
  if (mat_size / kernel_cri == output_crb && mat_size < IM2COL_THRESHOLD) {
    TYPE *inpt2d = (TYPE *) calloc(mat_size, sizeof(TYPE));
    if (inpt2d == NULL) exit(1);

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

  int mc = output_crb;
  int kc = kernel_cri;
  int nc = out_channel;
  compute_block_sizes(&kc, &nc, &mc, sizeof(TYPE));

#ifdef AVX_PSIZE
  int fast_flag = (in_channel % AVX_PSIZE == 0);
  TYPE *temp_mk = NULL;
  if (posix_memalign((void**) &temp_mk, ALIGN_SIZE, mc * kc * sizeof(TYPE)))
    exit(1);
#else
  TYPE *temp_mk = (TYPE *) calloc(mc * kc, sizeof(TYPE));
  if (temp_mk == NULL) exit(1);
#endif
  TYPE *temp_kn = (TYPE *) calloc(nc * kc, sizeof(TYPE));
  if (temp_kn == NULL) exit(1);
  TYPE *temp_mn = (TYPE *) calloc(mc * nc, sizeof(TYPE));
  if (temp_mn == NULL) exit(1);

  for (int m = 0; m < output_crb; m += mc) {
    int actual_mc = fminf(m + mc, output_crb) - m;
    for (int k = 0; k < kernel_cri; k += kc) {
      memset(temp_mk, 0, mc * kc * sizeof(TYPE));
      int actual_kc = fminf(k + kc, kernel_cri) - k;
#ifdef AVX_PSIZE
      int kc_strip = (actual_kc / AVX_PSIZE) * AVX_PSIZE;
#endif

      // iterate along each row of the generated input matrix; processing four
      // rows in parallel with the help of e.g. OpenMP should be possible
      int cmk = 0;
      for (int im = 0; im < actual_mc; im += 1) {
        int b  = (m + im) / output_cr;
        int cr = (m + im) - b * output_cr;
        int c = cr / output_rows;
        int r = cr - c * output_rows;

        const int cstart = c * col_stride - pc;
        const int rstart = r * row_stride - pr;
        const int idx_base = b * input_cri;

        // fill in the sub input matrix
#ifdef AVX_PSIZE
        if (fast_flag) {
          ACX_FUN_LOAD (load_sub_matrix_fast, spatial) (
            input_ptr, temp_mk, &cmk, kc_strip, k, kernel_ri, input_ri,
            in_channel, idx_base, cstart, rstart, input_cols, input_rows, 0);
        }
        else {
          ACX_FUN_LOAD (load_sub_matrix, spatial) (
            input_ptr, temp_mk, &cmk, kc_strip, actual_kc,
            k, kernel_ri, input_ri, in_channel, idx_base,
            cstart, rstart, input_cols, input_rows, kernel_rows, 0);
        }
#else
        for (int ik = 0; ik < actual_kc; ik += 1) {
          int kc  = (k + ik) / kernel_ri;
          int kri = (k + ik) - kc * kernel_ri;
          int kr  = kri / in_channel;
          int ki  = kri - kr * in_channel;

          int input_col = kc + cstart;
          int input_row = kr + rstart;
          if (input_col < input_cols && input_col >= 0 &&
            input_row < input_rows && input_row >= 0) {
            int input_index = idx_base + input_col * input_ri
              + input_row * in_channel + ki;
            temp_mk[cmk] = input_ptr[input_index];
          }
          cmk++;
        }
#endif
      }

      int idx_kn_base = k * out_channel;
      for (int n = 0; n < out_channel; n += nc) {
        int actual_nc = fminf(n + nc, out_channel) - n;
        idx_kn_base += n;

        // fill in the kernel matrix
        int cnk = 0;
        for (int ik = 0; ik < actual_kc; ik++) {
          for (int jn = 0; jn < actual_nc; jn++) {
            int index_kn = idx_kn_base + ik * out_channel + jn;
            temp_kn[cnk++] = kernel_ptr[index_kn];
          }
        }

        GEMM(CblasRowMajor, CblasNoTrans, CblasNoTrans,
          actual_mc, actual_nc, actual_kc, ALPHA,
          temp_mk, actual_kc, temp_kn, actual_nc,
          BETA, temp_mn, actual_nc);

        int cmn = 0;
        for (int ix = 0; ix < actual_mc; ix++) {
          for (int iy = 0; iy < actual_nc; iy++) {
            int index_mn = (ix + m) * out_channel + (iy + n);
            output_ptr[index_mn] += temp_mn[cmn++];
          }
        }
      }
    }
  }

  free(temp_mk);
  free(temp_kn);
  free(temp_mn);

  return Val_unit;
}


CAMLprim value FUN_BYTE (spatial) (value * argv, int argn) {
  return FUN_NATIVE (spatial) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16]
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
  const int kernel_ri  = kernel_rows * in_channel;

  int pr = (row_stride * ( output_rows - 1) + kernel_rows - input_rows) / 2;
  int pc = (col_stride * ( output_cols - 1) + kernel_cols - input_cols) / 2;
  if (pr < 0) pr = 0;
  if (pc < 0) pc = 0;

  memset(input_ptr, 0, batches * input_cri * sizeof(TYPE));
  INIT;

  if (kernel_cri * output_crb < IM2COL_THRESHOLD) {
    TYPE *inpt2d = (TYPE *) calloc(kernel_cri * output_crb, sizeof(TYPE));
    if (inpt2d == NULL) exit(1);

    GEMM(CblasRowMajor, CblasNoTrans, CblasTrans,
      output_crb, kernel_cri, out_channel, ALPHA,
      output_ptr, out_channel, kernel_ptr, out_channel,
      BETA, inpt2d, kernel_cri);

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

  int mc = output_crb;
  int kc = kernel_cri;
  int nc = out_channel;
  compute_block_sizes(&mc, &kc, &nc, sizeof(TYPE));

#ifdef AVX_PSIZE
  int fast_flag = (in_channel % AVX_PSIZE == 0);
  TYPE *temp_mk = NULL;
  if (posix_memalign((void**) &temp_mk, ALIGN_SIZE, mc * kc * sizeof(TYPE)))
    exit(1);
#else
  TYPE *temp_mk = (TYPE *) calloc(mc * kc, sizeof(TYPE));
  if (temp_mk == NULL) exit(1);
#endif
  TYPE *temp_kn = (TYPE *) calloc(nc * kc, sizeof(TYPE));
  if (temp_kn == NULL) exit(1);
  TYPE *temp_mn = (TYPE *) calloc(mc * nc, sizeof(TYPE));
  if (temp_mn == NULL) exit(1);

  for (int m = 0; m < output_crb; m += mc) {
    int actual_mc = fminf(m + mc, output_crb) - m;
    int idx_mn_base = m * out_channel;

    for (int k = 0; k < kernel_cri; k += kc) {
      int actual_kc = fminf(k + kc, kernel_cri) - k;
      int idx_kn_base = k * out_channel;
#ifdef AVX_PSIZE
      int kc_strip = (actual_kc / AVX_PSIZE) * AVX_PSIZE;
#endif

      for (int n = 0; n < out_channel; n += nc) {
        int actual_nc = fminf(n + nc, out_channel) - n;
        idx_kn_base += n;
        idx_mn_base += n;

        int cnk = 0;
        for (int ik = 0; ik < actual_kc; ik++) {
          for (int jn = 0; jn < actual_nc; jn++) {
            int index_kn = idx_kn_base + ik * out_channel + jn;
            temp_kn[cnk++] = kernel_ptr[index_kn];
          }
        }

        int cmn = 0;
        for (int ix = 0; ix < actual_mc; ix++) {
          for (int iy = 0; iy < actual_nc; iy++) {
            int index_mn = idx_mn_base + ix * out_channel + iy;
            temp_mn[cmn++] = output_ptr[index_mn];
          }
        }

        GEMM(CblasRowMajor, CblasNoTrans, CblasTrans,
          actual_mc, actual_kc, actual_nc, ALPHA,
          temp_mn, actual_nc, temp_kn, actual_nc,
          BETA, temp_mk, actual_kc);

        int cmk = 0;
        for (int im = 0; im < actual_mc; im += 1) {
          int b  = (m + im) / output_cr;
          int cr = (m + im) - b * output_cr;
          int c = cr / output_rows;
          int r = cr - c * output_rows;

          const int cstart = c * col_stride - pc;
          const int rstart = r * row_stride - pr;
          int idx_mk_base = b * input_cri;

#ifdef AVX_PSIZE
          if (fast_flag) {
            ACX_FUN_LOAD (load_sub_matrix_fast, spatial) (
              input_ptr, temp_mk, &cmk, kc_strip, k, kernel_ri, input_ri,
              in_channel, idx_mk_base, cstart, rstart, input_cols, input_rows, 1);
          }
          else {
            ACX_FUN_LOAD (load_sub_matrix, spatial) (
              input_ptr, temp_mk, &cmk, kc_strip, actual_kc,
              k, kernel_ri, input_ri, in_channel, idx_mk_base,
              cstart, rstart, input_cols, input_rows, kernel_rows, 1);
          }
#else
          for (int ik = 0; ik < actual_kc; ik += 1) {
            int kc  = (k + ik) / kernel_ri;
            int kri = (k + ik) - kc * kernel_ri;
            int kr  = kri / in_channel;
            int ki  = kri - kr * in_channel;

            int input_col = kc + cstart;
            int input_row = kr + rstart;
            if (input_col < input_cols && input_col >= 0 &&
              input_row < input_rows && input_row >= 0) {
                int input_index = idx_mk_base + input_col * input_ri
                  + input_row * in_channel + ki;
                input_ptr[input_index] += temp_mk[cmk];
            }
            cmk++;
          }
#endif
        }
      }
    }
  }

  free(temp_mk);
  free(temp_kn);
  free(temp_mn);

  return Val_unit;
}


CAMLprim value FUN_BYTE (spatial_backward_input) (value * argv, int argn) {
  return FUN_NATIVE (spatial_backward_input) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15]
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
  const int kernel_ri  = kernel_rows * in_channel;

  int pr = (row_stride * ( output_rows - 1) + kernel_rows - input_rows) / 2;
  int pc = (col_stride * ( output_cols - 1) + kernel_cols - input_cols) / 2;
  if (pr < 0) pr = 0;
  if (pc < 0) pc = 0;

  memset(kernel_ptr, 0, kernel_cols * kernel_rio * sizeof(TYPE));
  INIT;

  if (kernel_cri * output_crb < IM2COL_THRESHOLD) {
    TYPE *inpt2d = (TYPE *) calloc(kernel_cri * output_crb, sizeof(TYPE));
    if (inpt2d == NULL) exit(1);
    TYPE *kern2d = (TYPE *) calloc(kernel_cri * out_channel, sizeof(TYPE));
    if (kern2d == NULL) exit(1);

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

  int mc = output_crb;
  int kc = kernel_cri;
  int nc = out_channel;
  compute_block_sizes(&mc, &kc, &nc, sizeof(TYPE));

#ifdef AVX_PSIZE
  int fast_flag = (in_channel % AVX_PSIZE == 0);
  TYPE *temp_mk = NULL;
  if (posix_memalign((void**) &temp_mk, ALIGN_SIZE, mc * kc * sizeof(TYPE)))
    exit(1);
#else
  TYPE *temp_mk = (TYPE *) calloc(mc * kc, sizeof(TYPE));
  if (temp_mk == NULL) exit(1);
#endif
  TYPE *temp_kn = (TYPE *) calloc(nc * kc, sizeof(TYPE));
  if (temp_kn == NULL) exit(1);
  TYPE *temp_mn = (TYPE *) calloc(mc * nc, sizeof(TYPE));
  if (temp_mn == NULL) exit(1);

  for (int m = 0; m < output_crb; m += mc) {
    int actual_mc = fminf(m + mc, output_crb) - m;
    int idx_mn_base = m * out_channel;

    for (int k = 0; k < kernel_cri; k += kc) {
      int actual_kc = fminf(k + kc, kernel_cri) - k;
      int idx_kn_base = k * out_channel;
      memset(temp_mk, 0, mc * kc * sizeof(TYPE));
#ifdef AVX_PSIZE
      int kc_strip = (actual_kc / AVX_PSIZE) * AVX_PSIZE;
#endif

      int cmk = 0;
      for (int im = 0; im < actual_mc; im += 1) {
        int b  = (m + im) / output_cr;
        int cr = (m + im) - b * output_cr;
        int c = cr / output_rows;
        int r = cr - c * output_rows;

        const int cstart = c * col_stride - pc;
        const int rstart = r * row_stride - pr;
        const int idx_mk_base = b * input_cri;

#ifdef AVX_PSIZE
        if (fast_flag) {
          ACX_FUN_LOAD (load_sub_matrix_fast, spatial) (
            input_ptr, temp_mk, &cmk, kc_strip, k, kernel_ri, input_ri,
            in_channel, idx_mk_base, cstart, rstart, input_cols, input_rows, 0);
        }
        else {
          ACX_FUN_LOAD (load_sub_matrix, spatial) (
            input_ptr, temp_mk, &cmk, kc_strip, actual_kc,
            k, kernel_ri, input_ri, in_channel, idx_mk_base,
            cstart, rstart, input_cols, input_rows, kernel_rows, 0);
        }
#else
        for (int ik = 0; ik < actual_kc; ik += 1) {
          int kc  = (k + ik) / kernel_ri;
          int kri = (k + ik) - kc * kernel_ri;
          int kr  = kri / in_channel;
          int ki  = kri - kr * in_channel;

          int input_col = kc + cstart;
          int input_row = kr + rstart;
          if (input_col < input_cols && input_col >= 0 &&
            input_row < input_rows && input_row >= 0) {
            int input_index = idx_mk_base + input_col * input_ri
              + input_row * in_channel + ki;
            temp_mk[cmk] = input_ptr[input_index];
          }
          cmk++;
        }
#endif
      }

      for (int n = 0; n < out_channel; n += nc) {
        int actual_nc = fminf(n + nc, out_channel) - n;
        idx_mn_base += n;
        idx_kn_base += n;

        int cmn = 0;
        for (int ix = 0; ix < actual_mc; ix++) {
          for (int iy = 0; iy < actual_nc; iy++) {
            int index_mn = idx_mn_base + ix * out_channel + iy;
            temp_mn[cmn++] = output_ptr[index_mn];
          }
        }

        memset(temp_kn, 0, nc * kc * sizeof(TYPE));

        GEMM(CblasRowMajor, CblasTrans, CblasNoTrans,
          actual_nc, actual_kc, actual_mc, ALPHA,
          temp_mn, actual_nc, temp_mk, actual_kc,
          BETA, temp_kn, actual_kc);

        int cnk = 0;
        for (int jn = 0; jn < actual_nc; jn++) {
          for (int ik = 0; ik < actual_kc; ik++) {
            int index_kn = idx_kn_base + ik * out_channel + jn;
            kernel_ptr[index_kn] = temp_kn[cnk++];
          }
        }
      }
    }
  }

  free(temp_mk);
  free(temp_kn);
  free(temp_mn);

  return Val_unit;
}


CAMLprim value FUN_BYTE (spatial_backward_kernel) (value * argv, int argn) {
  return FUN_NATIVE (spatial_backward_kernel) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15]
  );
}


/*
 * im2col implementation
 */

CAMLprim value FUN_NATIVE (spatial_im2col) (
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

  TYPE *inpt2d = (TYPE *) calloc(kernel_cri * output_crb, sizeof(TYPE));
  if (inpt2d == NULL) exit(1);

  memset(output_ptr, 0, batches * output_cri * sizeof(TYPE));

  INIT;

  int pr = 0, pc = 0;
  if (padding != 1) {
    pr = (row_stride * ( output_rows - 1) + kernel_rows - input_rows) / 2;
    pc = (col_stride * ( output_cols - 1) + kernel_cols - input_cols) / 2;
    if (pr < 0) pr = 0;
    if (pc < 0) pc = 0;
  }

  #ifdef _OPENMP
    #pragma omp parallel for schedule(static)
  #endif /* _OPENMP */
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


CAMLprim value FUN_BYTE (spatial_im2col) (value * argv, int argn) {
  return FUN_NATIVE (spatial_im2col) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16]
  );
}


CAMLprim value FUN_NATIVE (spatial_backward_kernel_im2col) (
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

  int pr = (row_stride * ( output_rows - 1) + kernel_rows - input_rows) / 2;
  int pc = (col_stride * ( output_cols - 1) + kernel_cols - input_cols) / 2;
  if (pr < 0) pr = 0;
  if (pc < 0) pc = 0;

  #ifdef _OPENMP
    #pragma omp parallel for schedule(static)
  #endif /* _OPENMP */

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


CAMLprim value FUN_BYTE (spatial_backward_kernel_im2col) (value * argv, int argn) {
  return FUN_NATIVE (spatial_backward_kernel_im2col) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15]
  );
}


CAMLprim value FUN_NATIVE (spatial_backward_input_im2col) (
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

  TYPE *inpt2d = (TYPE *) calloc(kernel_cri * output_crb, sizeof(TYPE));
  if (inpt2d == NULL) exit(1);

  memset(input_ptr, 0, batches * input_cri * sizeof(TYPE));

  INIT;

  int pr = (row_stride * ( output_rows - 1) + kernel_rows - input_rows) / 2;
  int pc = (col_stride * ( output_cols - 1) + kernel_cols - input_cols) / 2;
  if (pr < 0) pr = 0;
  if (pc < 0) pc = 0;

  GEMM(CblasRowMajor, CblasNoTrans, CblasTrans,
    output_crb, kernel_cri, out_channel, ALPHA,
    output_ptr, out_channel, kernel_ptr, out_channel,
    BETA, inpt2d, kernel_cri);

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


CAMLprim value FUN_BYTE (spatial_backward_input_im2col) (value * argv, int argn) {
  return FUN_NATIVE (spatial_backward_input_im2col) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15]
  );
}


CAMLprim value FUN_NATIVE (cuboid_im2col) (
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

  TYPE *inpt2d = (TYPE *) calloc(kernel_idrc * output_drcb, sizeof(TYPE));
  if (inpt2d == NULL) exit(1);

  memset(output_ptr, 0, batches * output_crdo * sizeof(TYPE));

  INIT;

  int pd = 0, pr = 0, pc = 0;
  if (padding != 1) {
    pc = (col_stride * (output_cols - 1) + kernel_cols - input_cols) / 2;
    pr = (row_stride * (output_rows - 1) + kernel_rows - input_rows) / 2;
    pd = (dpt_stride * (output_dpts - 1) + kernel_dpts - input_dpts) / 2;
    if (pc < 0) pc = 0;
    if (pr < 0) pr = 0;
    if (pd < 0) pd = 0;
  }

  #ifdef _OPENMP
    #pragma omp parallel for schedule(static)
  #endif /* _OPENMP */

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


CAMLprim value FUN_BYTE (cuboid_im2col) (value * argv, int argn) {
  return FUN_NATIVE (cuboid_im2col) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16], argv[17], argv[18]
  );
}


CAMLprim value FUN_NATIVE (cuboid_backward_kernel_im2col) (
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

  int pc = (col_stride * (output_cols - 1) + kernel_cols - input_cols) / 2;
  int pr = (row_stride * (output_rows - 1) + kernel_rows - input_rows) / 2;
  int pd = (dpt_stride * (output_dpts - 1) + kernel_dpts - input_dpts) / 2;
  if (pc < 0) pc = 0;
  if (pr < 0) pr = 0;
  if (pd < 0) pd = 0;

  #ifdef _OPENMP
    #pragma omp parallel for schedule(static)
  #endif /* _OPENMP */

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


CAMLprim value FUN_BYTE (cuboid_backward_kernel_im2col) (value * argv, int argn) {
  return FUN_NATIVE (cuboid_backward_kernel_im2col) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16], argv[17]
  );
}


CAMLprim value FUN_NATIVE (cuboid_backward_input_im2col) (
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

  TYPE *inpt2d = (TYPE *) calloc(kernel_idrc * output_drcb, sizeof(TYPE));
  if (inpt2d == NULL) exit(1);

  memset(input_ptr, 0, batches * input_crdi * sizeof(TYPE));

  INIT;

  int pc = (col_stride * (output_cols - 1) + kernel_cols - input_cols) / 2;
  int pr = (row_stride * (output_rows - 1) + kernel_rows - input_rows) / 2;
  int pd = (dpt_stride * (output_dpts - 1) + kernel_dpts - input_dpts) / 2;
  if (pc < 0) pc = 0;
  if (pr < 0) pr = 0;
  if (pd < 0) pd = 0;

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


CAMLprim value FUN_BYTE (cuboid_backward_input_im2col) (value * argv, int argn) {
  return FUN_NATIVE (cuboid_backward_input_im2col) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16], argv[17]
  );
}


/*
 *  memory-efficient implementation
 */

CAMLprim value FUN_NATIVE (spatial_mec) (
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

  const int input_cri   = in_channel  * input_rows  * input_cols;
  const int input_ri    = input_rows * in_channel;
  const int output_cri  = out_channel * output_rows * output_cols;
  const int kernel_cri  = kernel_cols * kernel_rows * in_channel;
  const int kernel_rio  = kernel_rows * in_channel  * out_channel;
  const int kernel_io   = in_channel  * out_channel;
  const int padded_input_rows = kernel_rows + (output_rows - 1) * row_stride;
  const int output_bco  = out_channel * output_cols * batches;
  const int inpt2d_cols = padded_input_rows * kernel_cols * in_channel;
  const int inpt2d_rows = batches * output_cols;
  const int inpt2d_step = inpt2d_rows * kernel_cols * in_channel * row_stride;

  TYPE *inpt2d = (TYPE *) calloc(inpt2d_cols * inpt2d_rows, sizeof(TYPE));
  if (inpt2d == NULL) exit(1);
  TYPE *kern2d = (TYPE *) calloc(kernel_cri * out_channel, sizeof(TYPE));
  if (kern2d == NULL) exit(1);
  TYPE *output2d = (TYPE *) calloc(batches * output_cri, sizeof(TYPE));
  if (output2d == NULL) exit(1);

  memset(output_ptr, 0, batches * output_cri * sizeof(TYPE));

  INIT;

  int pr = 0, pc = 0;
  if (padding != 1) {
    pr = (row_stride * ( output_rows - 1) + kernel_rows - input_rows) / 2;
    pc = (col_stride * ( output_cols - 1) + kernel_cols - input_cols) / 2;
    if (pr < 0) pr = 0;
    if (pc < 0) pc = 0;
  }

  int cnt = 0;
  int kidx = 0;
  for (int o = 0; o < out_channel; ++o) {
    for (int r = 0; r < kernel_rows; ++r) {
      for (int c = 0; c < kernel_cols; ++c) {
        for (int i = 0; i < in_channel; ++i) {
          kidx = c * kernel_rio + r * kernel_io + i * out_channel + o;
          kern2d[cnt++] = kernel_ptr[kidx];
        }
      }
    }
  }

  for (int i = 0; i < inpt2d_rows; ++i) {
    int bt = i / output_cols;
    int c =  i % output_cols;

    const int cstart = c * col_stride - pc;
    const int cend   = cstart + kernel_cols;
    const int rstart = 0 - pr;
    const int rend   = rstart + padded_input_rows;

    int counter = 0;
    for (int a = rstart; a < rend; ++a) {
      for (int b = cstart; b < cend; ++b) {
        for (int h = 0; h < in_channel; ++h) {
          if (b < input_cols && b >= 0 &&
              a < input_rows && a >= 0) {
            int input_idx = bt * input_cri + b * input_ri + a * in_channel + h;
            inpt2d[counter * inpt2d_rows + i] = input_ptr[input_idx];
          }
          counter++;
        }
      }
    }
  }

  for (int i = 0; i < output_rows; ++i) {
    GEMM(CblasColMajor, CblasNoTrans, CblasNoTrans,
      inpt2d_rows, out_channel, kernel_cri, ALPHA,
      inpt2d + inpt2d_step * i, inpt2d_rows, kern2d, kernel_cri,
      BETA, output2d + output_bco * i, inpt2d_rows);
  }

  cnt = 0;
  for (int j = 0; j < inpt2d_rows; ++j) {
    for (int i = 0; i < output_rows * out_channel; ++i) {
      output_ptr[cnt++] = output2d[i * inpt2d_rows + j];
    }
  }

  free(inpt2d);
  free(kern2d);
  free(output2d);

  return Val_unit;
}


CAMLprim value FUN_BYTE (spatial_mec) (value * argv, int argn) {
  return FUN_NATIVE (spatial_mec) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16]
  );
}


CAMLprim value FUN_NATIVE (spatial_backward_kernel_mec) (
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

  const int input_cri   = in_channel  * input_rows  * input_cols;
  const int input_ri    = in_channel  * input_rows;
  const int output_ri   = out_channel * output_rows;
  const int output_cr   = output_rows * output_cols;
  const int output_ro   = output_rows * out_channel;
  const int output_crb  = output_rows * output_cols * batches;
  const int kernel_io   = in_channel  * out_channel;
  const int kernel_rio  = kernel_rows * in_channel  * out_channel;
  const int kernel_cri  = kernel_cols * kernel_rows * in_channel;
  const int padded_input_rows = kernel_rows + (output_rows - 1) * row_stride;
  const int output_bco  = out_channel * output_cols * batches;
  const int inpt2d_cols = padded_input_rows * kernel_cols * in_channel;
  const int inpt2d_rows = batches * output_cols;
  const int inpt2d_step = batches * output_cols * kernel_cols * in_channel * row_stride;

  TYPE *inpt2d = (TYPE *) calloc(inpt2d_cols * inpt2d_rows, sizeof(TYPE));
  if (inpt2d == NULL) exit(1);
  TYPE *kern2d = (TYPE *) calloc(kernel_cri * out_channel, sizeof(TYPE));
  if (kern2d == NULL) exit(1);
  TYPE *output2d = (TYPE *) calloc(output_crb * out_channel, sizeof(TYPE));
  if (output2d == NULL) exit(1);

  memset(kernel_ptr, 0, kernel_cols * kernel_rio * sizeof(TYPE));

  INIT;

  int pr = (row_stride * ( output_rows - 1) + kernel_rows - input_rows) / 2;
  int pc = (col_stride * ( output_cols - 1) + kernel_cols - input_cols) / 2;
  if (pr < 0) pr = 0;
  if (pc < 0) pc = 0;

  for (int i = 0; i < inpt2d_rows; ++i) {
    int bt = i / output_cols;
    int c =  i % output_cols;

    const int cstart = c * col_stride - pc;
    const int cend   = cstart + kernel_cols;
    const int rstart = 0 - pr;
    const int rend   = rstart + padded_input_rows;

    int counter = 0;
    for (int a = rstart; a < rend; ++a) {
      for (int b = cstart; b < cend; ++b) {
        for (int h = 0; h < in_channel; ++h) {
          if (b < input_cols && b >= 0 &&
              a < input_rows && a >= 0) {
            int input_idx =
              bt * input_cri + b * input_ri + a * in_channel + h;
            inpt2d[counter * inpt2d_rows + i] = input_ptr[input_idx];
          }
          counter++;
        }
      }
    }
  }

  int cnt = 0;
  for (int j = 0; j < inpt2d_rows; ++j) {
    for (int i = 0; i < output_ro; ++i) {
      output2d[i * inpt2d_rows + j] = output_ptr[cnt++];
    }
  }

  for (int i = 0; i < output_rows; ++i) {
    GEMM(CblasColMajor, CblasTrans, CblasNoTrans,
      out_channel, kernel_cri, inpt2d_rows, ALPHA,
      output2d + output_bco * i, inpt2d_rows,
      inpt2d + inpt2d_step * i, inpt2d_rows,
      ALPHA, kern2d, out_channel);
  }

  cnt = 0;
  int kidx = 0;
  for (int r = 0; r < kernel_rows; ++r) {
    for (int c = 0; c < kernel_cols; ++c) {
      for (int i = 0; i < in_channel; ++i) {
        for (int o = 0; o < out_channel; ++o) {
          kidx = c * kernel_rio + r * kernel_io + i * out_channel + o;
          kernel_ptr[kidx] = kern2d[cnt++];
        }
      }
    }
  }

  free(inpt2d);
  free(kern2d);
  free(output2d);

  return Val_unit;
}


CAMLprim value FUN_BYTE (spatial_backward_kernel_mec) (value * argv, int argn) {
  return FUN_NATIVE (spatial_backward_kernel_mec) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15]
  );
}


CAMLprim value FUN_NATIVE (spatial_backward_input_mec) (
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

  const int input_cri   = in_channel  * input_rows  * input_cols;
  const int input_ri    = in_channel  * input_rows;
  const int output_ri   = out_channel * output_rows;
  const int output_cr   = output_rows * output_cols;
  const int output_ro   = output_rows * out_channel;
  const int output_crb  = output_rows * output_cols * batches;
  const int kernel_io   = in_channel  * out_channel;
  const int kernel_rio  = kernel_rows * in_channel  * out_channel;
  const int kernel_cri  = kernel_cols * kernel_rows * in_channel;
  const int padded_input_rows = kernel_rows + (output_rows - 1) * row_stride;
  const int output_bco  = out_channel * output_cols * batches;
  const int inpt2d_cols = padded_input_rows * kernel_cols * in_channel;
  const int inpt2d_rows = batches * output_cols;
  const int inpt2d_step = batches * output_cols * kernel_cols * in_channel * row_stride;

  TYPE *inpt2d = (TYPE *) calloc(inpt2d_cols * inpt2d_rows, sizeof(TYPE));
  if (inpt2d == NULL) exit(1);
  TYPE *kern2d = (TYPE *) calloc(kernel_cri * out_channel, sizeof(TYPE));
  if (kern2d == NULL) exit(1);
  TYPE *output2d = (TYPE *) calloc(output_crb * out_channel, sizeof(TYPE));
  if (output2d == NULL) exit(1);

  memset(input_ptr, 0, batches * input_cri * sizeof(TYPE));

  INIT;

  int pr = (row_stride * ( output_rows - 1) + kernel_rows - input_rows) / 2;
  int pc = (col_stride * ( output_cols - 1) + kernel_cols - input_cols) / 2;
  if (pr < 0) pr = 0;
  if (pc < 0) pc = 0;

  int cnt = 0;
  for (int j = 0; j < inpt2d_rows; ++j) {
    for (int i = 0; i < output_ro; ++i) {
      output2d[i * inpt2d_rows + j] = output_ptr[cnt++];
    }
  }

  cnt = 0;
  int kidx = 0;
  for (int o = 0; o < out_channel; ++o) {
    for (int r = 0; r < kernel_rows; ++r) {
      for (int c = 0; c < kernel_cols; ++c) {
        for (int i = 0; i < in_channel; ++i) {
          kidx = c * kernel_rio + r * kernel_io + i * out_channel + o;
          kern2d[cnt++] = kernel_ptr[kidx];
        }
      }
    }
  }

  for (int i = 0; i < output_rows; ++i) {
    GEMM(CblasColMajor, CblasNoTrans, CblasTrans,
      inpt2d_rows, kernel_cri, out_channel, ALPHA,
      output2d + output_bco * i, inpt2d_rows,
      kern2d, kernel_cri, ALPHA,
      inpt2d + inpt2d_step * i, inpt2d_rows);
  }

  for (int i = 0; i < inpt2d_rows; ++i) {
    int bt = i / output_cols;
    int c =  i % output_cols;

    const int cstart = c * col_stride - pc;
    const int cend = cstart + kernel_cols;
    const int rstart = 0 - pr;
    const int rend   = rstart + padded_input_rows;
    const int input_idx_base = bt * input_cri;

    int counter = 0;
    for (int a = rstart; a < rend; ++a) {
      for (int b = cstart; b < cend; ++b) {
        for (int h = 0; h < in_channel; ++h) {
          if (b < input_cols && b >= 0 &&
              a < input_rows && a >= 0) {
            int input_idx = input_idx_base + b * input_ri + a * in_channel + h;
            input_ptr[input_idx] += inpt2d[counter * inpt2d_rows + i];
          }
          counter++;
        }
      }
    }
  }

  free(inpt2d);
  free(kern2d);
  free(output2d);

  return Val_unit;
}


CAMLprim value FUN_BYTE (spatial_backward_input_mec) (value * argv, int argn) {
  return FUN_NATIVE (spatial_backward_input_mec) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15]
  );
}


CAMLprim value FUN_NATIVE (cuboid_mec) (
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
  const int output_rdo  = out_channel * output_dpts * output_rows;
  const int output_dr   = output_dpts * output_rows;
  const int output_drc  = output_dpts * output_rows * output_cols;
  const int output_drcb = output_dpts * output_rows * output_cols * batches;
  const int kernel_idrc = in_channel  * kernel_dpts * kernel_rows * kernel_cols;
  const int kernel_rdio = kernel_rows * kernel_dpts * in_channel  * out_channel;
  const int kernel_dio  = kernel_dpts * in_channel  * out_channel;
  const int kernel_io   = in_channel  * out_channel;
  const int padded_input_rows = kernel_rows + (output_rows - 1) * row_stride;
  const int output_bcdo = out_channel * output_cols * output_dpts * batches;
  const int inpt2d_cols = padded_input_rows * kernel_cols * kernel_dpts * in_channel;
  const int inpt2d_rows = batches * output_cols * output_dpts;
  const int inpt2d_step = inpt2d_rows * kernel_cols * kernel_dpts * in_channel * row_stride;

  INIT;

  int pd = 0, pr = 0, pc = 0;
  if (padding != 1) {
    pc = (col_stride * (output_cols - 1) + kernel_cols - input_cols) / 2;
    pr = (row_stride * (output_rows - 1) + kernel_rows - input_rows) / 2;
    pd = (dpt_stride * (output_dpts - 1) + kernel_dpts - input_dpts) / 2;
    if (pc < 0) pc = 0;
    if (pr < 0) pr = 0;
    if (pd < 0) pd = 0;
  }

  TYPE *inpt2d = (TYPE *) calloc(inpt2d_cols * inpt2d_rows, sizeof(TYPE));
  if (inpt2d == NULL) exit(1);
  TYPE *kern2d = (TYPE *) calloc(kernel_idrc * out_channel, sizeof(TYPE));
  if (kern2d == NULL) exit(1);
  TYPE *output2d = (TYPE *) calloc(output_drcb * out_channel, sizeof(TYPE));
  if (output2d == NULL) exit(1);
  memset(output_ptr, 0, output_drcb * out_channel * sizeof(TYPE));

  int cnt = 0;
  int kidx = 0;
  for (int o = 0; o < out_channel; ++o) {
    for (int r = 0; r < kernel_rows; ++r) {
      for (int c = 0; c < kernel_cols; ++c) {
        for (int d = 0; d < kernel_dpts; ++d) {
          for (int i = 0; i < in_channel; ++i) {
            kidx = c * kernel_rdio + r * kernel_dio +
              d * kernel_io + i * out_channel + o;
            kern2d[cnt++] = kernel_ptr[kidx];
          }
        }
      }
    }
  }

  const int rstart = 0 - pr;
  const int rend   = rstart + padded_input_rows;
  for (int i = 0; i < inpt2d_rows; ++i) {
    int bt = i / (output_cols * output_dpts);
    int cd = i % (output_cols * output_dpts);
    int ct  = cd / output_dpts;
    int dt  = cd % output_dpts;

    const int cstart = ct * col_stride - pc;
    const int dstart = dt * dpt_stride - pd;
    const int cend   = cstart + kernel_cols;
    const int dend   = dstart + kernel_dpts;
    const int input_idx_base = bt * input_crdi;

    int cnt = 0;
    for (int r = rstart; r < rend; ++r) {
      for (int c = cstart; c < cend; ++c) {
        for (int d = dstart; d < dend; ++d) {
          for (int h = 0; h < in_channel; ++h) {
            if (c >= 0 && c < input_cols &&
                r >= 0 && r < input_rows &&
                d >= 0 && d < input_dpts) {
              int input_idx = input_idx_base + c * input_rdi +
                r * input_di + d * in_channel + h;
              inpt2d[cnt * inpt2d_rows + i] += input_ptr[input_idx];
            }
            ++cnt;
          }
        }
      }
    }
  }

  for (int i = 0; i < output_rows; ++i) {
    GEMM(CblasColMajor, CblasNoTrans, CblasNoTrans,
      inpt2d_rows, out_channel, kernel_idrc, ALPHA,
      inpt2d + inpt2d_step * i, inpt2d_rows, kern2d, kernel_idrc,
      BETA, output2d + output_bcdo * i, inpt2d_rows);
  }

  cnt = 0;
  int oidx = 0;
    for (int r = 0; r < output_rows; ++r) {
      for (int o = 0; o < out_channel; ++o) {
        for (int b = 0; b < batches; ++b) {
        for (int c = 0; c < output_cols; ++c) {
          for (int d = 0; d < output_dpts; ++d) {
            oidx = b * output_crdo + c * output_rdo +
              r * output_dpts * out_channel + d * out_channel + o;
            output_ptr[oidx] = output2d[cnt++];
          }
        }
      }
    }
  }

  free(inpt2d);
  free(kern2d);
  free(output2d);

  return Val_unit;
}


CAMLprim value FUN_BYTE (cuboid_mec) (value * argv, int argn) {
  return FUN_NATIVE (cuboid_mec) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16], argv[17], argv[18]
  );
}


CAMLprim value FUN_NATIVE (cuboid_backward_kernel_mec) (
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
  const int output_crdo = out_channel * output_dpts * output_rows * output_cols;
  const int output_rdo  = out_channel * output_dpts * output_rows;
  const int output_dr   = output_dpts * output_rows;
  const int output_drc  = output_dpts * output_rows * output_cols;
  const int output_drcb = output_dpts * output_rows * output_cols * batches;
  const int kernel_idrc = in_channel  * kernel_dpts * kernel_rows * kernel_cols;
  const int kernel_rdio = kernel_rows * kernel_dpts * in_channel  * out_channel;
  const int kernel_dio  = kernel_dpts * in_channel  * out_channel;
  const int kernel_io   = in_channel  * out_channel;
  const int padded_input_rows = kernel_rows + (output_rows - 1) * row_stride;
  const int output_bcdo = out_channel * output_cols * output_dpts * batches;
  const int inpt2d_cols = padded_input_rows * kernel_cols * kernel_dpts * in_channel;
  const int inpt2d_rows = batches * output_cols * output_dpts;
  const int inpt2d_step = inpt2d_rows * kernel_cols * kernel_dpts * in_channel * row_stride;

  TYPE *inpt2d = (TYPE *) calloc(inpt2d_cols * inpt2d_rows, sizeof(TYPE));
  if (inpt2d == NULL) exit(1);
  TYPE *kern2d = (TYPE *) calloc(kernel_idrc * out_channel, sizeof(TYPE));
  if (kern2d == NULL) exit(1);
  TYPE *output2d = (TYPE *) calloc(output_drcb * out_channel, sizeof(TYPE));
  if (output2d == NULL) exit(1);

  memset(kernel_ptr, 0, kernel_idrc * out_channel * sizeof(TYPE));

  INIT;

  int pc = (col_stride * (output_cols - 1) + kernel_cols - input_cols) / 2;
  int pr = (row_stride * (output_rows - 1) + kernel_rows - input_rows) / 2;
  int pd = (dpt_stride * (output_dpts - 1) + kernel_dpts - input_dpts) / 2;
  if (pc < 0) pc = 0;
  if (pr < 0) pr = 0;
  if (pd < 0) pd = 0;

  int cnt;
  const int rstart = 0 - pr;
  const int rend   = rstart + padded_input_rows;
  for (int i = 0; i < inpt2d_rows; ++i) {
    int bt = i / (output_cols * output_dpts);
    int cd = i % (output_cols * output_dpts);
    int ct  = cd / output_dpts;
    int dt  = cd % output_dpts;

    const int cstart = ct * col_stride - pc;
    const int dstart = dt * dpt_stride - pd;
    const int cend   = cstart + kernel_cols;
    const int dend   = dstart + kernel_dpts;
    const int input_idx_base = bt * input_crdi;

    cnt = 0;
    for (int r = rstart; r < rend; ++r) {
      for (int c = cstart; c < cend; ++c) {
        for (int d = dstart; d < dend; ++d) {
          for (int h = 0; h < in_channel; ++h) {
            if (c >= 0 && c < input_cols &&
                r >= 0 && r < input_rows &&
                d >= 0 && d < input_dpts) {
              int input_idx = input_idx_base + c * input_rdi +
                r * input_di + d * in_channel + h;
              inpt2d[cnt * inpt2d_rows + i] += input_ptr[input_idx];
            }
            ++cnt;
          }
        }
      }
    }
  }

  cnt = 0;
  int oidx = 0;
  for (int r = 0; r < output_rows; ++r) {
    for (int o = 0; o < out_channel; ++o) {
      for (int b = 0; b < batches; ++b) {
        for (int c = 0; c < output_cols; ++c) {
          for (int d = 0; d < output_dpts; ++d) {
            oidx = b * output_crdo + c * output_rdo +
              r * output_dpts * out_channel + d * out_channel + o;
            output2d[cnt++] = output_ptr[oidx];
          }
        }
      }
    }
  }

  for (int i = 0; i < output_rows; ++i) {
    GEMM(CblasColMajor, CblasTrans, CblasNoTrans,
      out_channel, kernel_idrc, inpt2d_rows, ALPHA,
      output2d + output_bcdo * i, inpt2d_rows,
      inpt2d + inpt2d_step * i, inpt2d_rows,
      ALPHA, kern2d, out_channel);
  }

  cnt = 0;
  int kidx = 0;

  for (int r = 0; r < kernel_rows; ++r) {
    for (int c = 0; c < kernel_cols; ++c) {
      for (int d = 0; d < kernel_dpts; ++d) {
        for (int i = 0; i < in_channel; ++i) {
          for (int o = 0; o < out_channel; ++o) {
            kidx = c * kernel_rdio + r * kernel_dio +
              d * kernel_io + i * out_channel + o;
            kernel_ptr[kidx] = kern2d[cnt++];
          }
        }
      }
    }
  }

  free(inpt2d);
  free(kern2d);
  free(output2d);

  return Val_unit;
}


CAMLprim value FUN_BYTE (cuboid_backward_kernel_mec) (value * argv, int argn) {
  return FUN_NATIVE (cuboid_backward_kernel_mec) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16], argv[17]
  );
}


CAMLprim value FUN_NATIVE (cuboid_backward_input_mec) (
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
  const int output_crdo = out_channel * output_dpts * output_rows * output_cols;
  const int output_rdo  = out_channel * output_dpts * output_rows;
  const int output_dr   = output_dpts * output_rows;
  const int output_drc  = output_dpts * output_rows * output_cols;
  const int output_drcb = output_dpts * output_rows * output_cols * batches;
  const int kernel_idrc = in_channel  * kernel_dpts * kernel_rows * kernel_cols;
  const int kernel_rdio = kernel_rows * kernel_dpts * in_channel  * out_channel;
  const int kernel_dio  = kernel_dpts * in_channel  * out_channel;
  const int kernel_io   = in_channel  * out_channel;
  const int padded_input_rows = kernel_rows + (output_rows - 1) * row_stride;
  const int output_bcdo  = out_channel * output_cols * output_dpts * batches;
  const int inpt2d_cols = padded_input_rows * kernel_cols * kernel_dpts * in_channel;
  const int inpt2d_rows = batches * output_cols * output_dpts;
  const int inpt2d_step = inpt2d_rows * kernel_cols * kernel_dpts * in_channel * row_stride;

  TYPE *inpt2d = (TYPE *) calloc(inpt2d_cols * inpt2d_rows, sizeof(TYPE));
  if (inpt2d == NULL) exit(1);
  TYPE *kern2d = (TYPE *) calloc(kernel_idrc * out_channel, sizeof(TYPE));
  if (kern2d == NULL) exit(1);
  TYPE *output2d = (TYPE *) calloc(output_drcb * out_channel, sizeof(TYPE));
  if (output2d == NULL) exit(1);

  memset(input_ptr, 0, batches * input_crdi * sizeof(TYPE));

  INIT;

  int pc = (col_stride * (output_cols - 1) + kernel_cols - input_cols) / 2;
  int pr = (row_stride * (output_rows - 1) + kernel_rows - input_rows) / 2;
  int pd = (dpt_stride * (output_dpts - 1) + kernel_dpts - input_dpts) / 2;
  if (pc < 0) pc = 0;
  if (pr < 0) pr = 0;
  if (pd < 0) pd = 0;

  int cnt = 0;
  int oidx = 0;
  for (int r = 0; r < output_rows; ++r) {
    for (int o = 0; o < out_channel; ++o) {
      for (int b = 0; b < batches; ++b) {
        for (int c = 0; c < output_cols; ++c) {
          for (int d = 0; d < output_dpts; ++d) {
            oidx = b * output_crdo + c * output_rdo +
              r * output_dpts * out_channel + d * out_channel + o;
            output2d[cnt++] = output_ptr[oidx];
          }
        }
      }
    }
  }

  cnt = 0;
  int kidx = 0;
  for (int o = 0; o < out_channel; ++o) {
    for (int r = 0; r < kernel_rows; ++r) {
      for (int c = 0; c < kernel_cols; ++c) {
        for (int d = 0; d < kernel_dpts; ++d) {
          for (int i = 0; i < in_channel; ++i) {
            kidx = c * kernel_rdio + r * kernel_dio +
              d * kernel_io + i * out_channel + o;
            kern2d[cnt++] = kernel_ptr[kidx];
          }
        }
      }
    }
  }

  for (int i = 0; i < output_rows; ++i) {
    GEMM(CblasColMajor, CblasNoTrans, CblasTrans,
      inpt2d_rows, kernel_idrc, out_channel, ALPHA,
      output2d + output_bcdo * i, inpt2d_rows,
      kern2d, kernel_idrc, ALPHA,
      inpt2d + inpt2d_step * i, inpt2d_rows);
  }

  const int rstart = 0 - pr;
  const int rend   = rstart + padded_input_rows;
  for (int i = 0; i < inpt2d_rows; ++i) {
    int bt = i / (output_cols * output_dpts);
    int cd = i % (output_cols * output_dpts);
    int ct  = cd / output_dpts;
    int dt  = cd % output_dpts;

    const int cstart = ct * col_stride - pc;
    const int dstart = dt * dpt_stride - pd;
    const int cend   = cstart + kernel_cols;
    const int dend   = dstart + kernel_dpts;
    const int input_idx_base = bt * input_crdi;

    int cnt = 0;
    for (int r = rstart; r < rend; ++r) {
      for (int c = cstart; c < cend; ++c) {
        for (int d = dstart; d < dend; ++d) {
          for (int h = 0; h < in_channel; ++h) {
            if (c >= 0 && c < input_cols &&
                r >= 0 && r < input_rows &&
                d >= 0 && d < input_dpts) {
              int input_idx = input_idx_base + c * input_rdi +
                r * input_di + d * in_channel + h;
              input_ptr[input_idx] += inpt2d[cnt * inpt2d_rows + i];
            }
            ++cnt;
          }
        }
      }
    }
  }

  free(inpt2d);
  free(kern2d);
  free(output2d);

  return Val_unit;
}


CAMLprim value FUN_BYTE (cuboid_backward_input_mec) (value * argv, int argn) {
  return FUN_NATIVE (cuboid_backward_input_mec) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16], argv[17]
  );
}


/*
 * naive implementation
 */

CAMLprim value FUN_NATIVE (spatial_naive) (
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
  const int output_ri  = out_channel * output_rows;
  const int output_crb = output_rows * output_cols * batches;
  const int kernel_cri = kernel_cols * kernel_rows * in_channel;
  const int kernel_rio = out_channel * in_channel  * kernel_rows;
  const int kernel_io  = out_channel * in_channel;
  const int ksize      = kernel_cols * kernel_rows;

  memset(output_ptr, 0, batches * output_cri * sizeof(TYPE));

  INIT;

  int pr = 0, pc = 0;
  if (padding != 1) {
    pr = (row_stride * ( output_rows - 1) + kernel_rows - input_rows) / 2;
    pc = (col_stride * ( output_cols - 1) + kernel_cols - input_cols) / 2;
    if (pr < 0) pr = 0;
    if (pc < 0) pc = 0;
  }

  for (int i = 0; i < batches; ++i) {
    const int input_idx_base = i * input_cri;
    for (int j = 0; j < output_cols; ++j) {
      for (int k = 0; k < output_rows; ++k) {
        const int output_idx_base = i * output_cri + j * output_ri + k * out_channel;
        const int cstart = j * col_stride - pc;
        const int rstart = k * row_stride - pr;
        const int cend   = cstart + kernel_cols;
        const int rend   = rstart + kernel_rows;

        for (int l = 0; l < out_channel; ++l) {
          TYPE sum = 0.;
          for (int h = 0; h < in_channel; ++h) {
            TYPE input_val, kernel_val;
            for (int a = cstart; a < cend; ++a) {
              for (int b = rstart; b < rend; ++b) {
                if (a >= 0 && a < input_cols &&
                    b >= 0 && b < input_rows) {
                  int input_idx =
                     input_idx_base + a * input_ri + b * in_channel + h;
                  input_val = *(input_ptr + input_idx);
                } else {
                  input_val = 0.;
                }

                int kernel_index =
                  (a - cstart) * kernel_rio + (b - rstart) * kernel_io + h * out_channel + l;
                kernel_val = *(kernel_ptr + kernel_index);

                sum += input_val * kernel_val;
              }
            }
          }
          int output_idx = output_idx_base + l;
          *(output_ptr + output_idx) = sum;
        }
      }
    }
  }

  return Val_unit;
}


CAMLprim value FUN_BYTE (spatial_naive) (value * argv, int argn) {
  return FUN_NATIVE (spatial_naive) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16]
  );
}


CAMLprim value FUN_NATIVE (spatial_backward_kernel_naive) (
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
  const int kernel_io  = out_channel * in_channel;
  const int output_cri = out_channel * output_rows * output_cols;
  const int output_ri  = out_channel * output_rows;

  memset(kernel_ptr, 0, kernel_cols * kernel_rio * sizeof(TYPE));

  INIT;

  int pr = (row_stride * (output_rows - 1) + kernel_rows - input_rows) / 2;
  int pc = (col_stride * (output_cols - 1) + kernel_cols - input_cols) / 2;
  if (pr < 0) pr = 0;
  if (pc < 0) pc = 0;

  for (int i = 0; i < batches; ++i) {
    for (int j = 0; j < output_cols; ++j) {
      for (int k = 0; k < output_rows; ++k) {

        const int cstart = j * col_stride - pc;
        const int rstart = k * row_stride - pr;
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
                  input_val = 0.;
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


CAMLprim value FUN_BYTE (spatial_backward_kernel_naive) (value * argv, int argn) {
  return FUN_NATIVE (spatial_backward_kernel_naive) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15]
  );
}


CAMLprim value FUN_NATIVE (spatial_backward_input_naive) (
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
  const int kernel_io  = out_channel * in_channel;
  const int output_cri = out_channel * output_rows * output_cols;
  const int output_ri  = out_channel * output_rows;

  memset(input_ptr, 0, batches * input_cri * sizeof(TYPE));

  INIT;

  int pr = (row_stride * (output_rows - 1) + kernel_rows - input_rows) / 2;
  int pc = (col_stride * (output_cols - 1) + kernel_cols - input_cols) / 2;
  if (pr < 0) pr = 0;
  if (pc < 0) pc = 0;

  for (int i = 0; i < batches; ++i) {
    for (int j = 0; j < output_cols; ++j) {
      for (int k = 0; k < output_rows; ++k) {

        const int cstart = j * col_stride - pc;
        const int rstart = k * row_stride - pr;
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


CAMLprim value FUN_BYTE (spatial_backward_input_naive) (value * argv, int argn) {
  return FUN_NATIVE (spatial_backward_input_naive) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15]
  );
}


CAMLprim value FUN_NATIVE (cuboid_naive) (
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
  const int kernel_rdio = out_channel * in_channel * kernel_dpts * kernel_rows;
  const int kernel_dio  = out_channel * in_channel * kernel_dpts;
  const int kernel_io   = out_channel * in_channel;
  const int output_crdo = out_channel * output_dpts * output_rows * output_cols;
  const int output_rdo  = out_channel * output_dpts * output_rows;
  const int output_do   = out_channel * output_dpts;

  INIT;

  int pd = 0, pr = 0, pc = 0;
  if (padding != 1) {
    pc = (col_stride * (output_cols - 1) + kernel_cols - input_cols) / 2;
    pr = (row_stride * (output_rows - 1) + kernel_rows - input_rows) / 2;
    pd = (dpt_stride * (output_dpts - 1) + kernel_dpts - input_dpts) / 2;
    if (pc < 0) pc = 0;
    if (pr < 0) pr = 0;
    if (pd < 0) pd = 0;
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
                      input_val = 0.;
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


CAMLprim value FUN_BYTE (cuboid_naive) (value * argv, int argn) {
  return FUN_NATIVE (cuboid_naive) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15], argv[16], argv[17], argv[18]
  );
}


CAMLprim value FUN_NATIVE (cuboid_backward_kernel_naive) (
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
  const int kernel_dio  = out_channel * in_channel * kernel_dpts;
  const int kernel_io   = out_channel * in_channel;
  const int output_crdo = out_channel * output_dpts * output_rows * output_cols;
  const int output_rdo  = out_channel * output_dpts * output_rows;
  const int output_do   = out_channel * output_dpts;

  memset(kernel_ptr, 0, kernel_cols * kernel_rdio * sizeof(TYPE));

  INIT;

  int pc = (col_stride * (output_cols - 1) + kernel_cols - input_cols) / 2;
  int pr = (row_stride * (output_rows - 1) + kernel_rows - input_rows) / 2;
  int pd = (dpt_stride * (output_dpts - 1) + kernel_dpts - input_dpts) / 2;
  if (pc < 0) pc = 0;
  if (pr < 0) pr = 0;
  if (pd < 0) pd = 0;

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
                    TYPE input_val = 0.;
                    if (a >= 0 && a < input_cols &&
                        b >= 0 && b < input_rows &&
                        c >= 0 && c < input_dpts) {
                      int input_idx =
                        input_idx_base + a * input_rdi + b * input_di +
                        c * in_channel + h;
                      input_val = *(input_ptr + input_idx);
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


CAMLprim value FUN_BYTE (cuboid_backward_kernel_naive) (value * argv, int argn) {
  return FUN_NATIVE (cuboid_backward_kernel_naive) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15], argv[16], argv[17]
  );
}


CAMLprim value FUN_NATIVE (cuboid_backward_input_naive) (
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
  const int kernel_dio  = out_channel * in_channel * kernel_dpts;
  const int kernel_io   = out_channel * in_channel;
  const int output_crdo = out_channel * output_dpts * output_rows * output_cols;
  const int output_rdo  = out_channel * output_dpts * output_rows;
  const int output_do   = out_channel * output_dpts;

  memset(input_ptr, 0, batches * input_crdi * sizeof(TYPE));

  INIT;

  int pc = (col_stride * (output_cols - 1) + kernel_cols - input_cols) / 2;
  int pr = (row_stride * (output_rows - 1) + kernel_rows - input_rows) / 2;
  int pd = (dpt_stride * (output_dpts - 1) + kernel_dpts - input_dpts) / 2;
  if (pc < 0) pc = 0;
  if (pr < 0) pr = 0;
  if (pd < 0) pd = 0;

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


CAMLprim value FUN_BYTE (cuboid_backward_input_naive) (value * argv, int argn) {
  return FUN_NATIVE (cuboid_backward_input_naive) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15], argv[16], argv[17]
  );
}


/*
 * dilated convolution
 */

CAMLprim value FUN_NATIVE (dilated_spatial_im2col) (
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

  int kernel_cols_up = kernel_cols + (kernel_cols - 1) * (col_in_stride - 1);
  int kernel_rows_up = kernel_rows + (kernel_rows - 1) * (row_in_stride - 1);

  int pr = 0, pc = 0;
  if (padding != 1) {
    pr = (row_stride * ( output_rows - 1) + kernel_rows_up - input_rows) / 2;
    pc = (col_stride * ( output_cols - 1) + kernel_cols_up - input_cols) / 2;
    if (pr < 0) pr = 0;
    if (pc < 0) pc = 0;
  }

  #ifdef _OPENMP
    #pragma omp parallel for schedule(static)
  #endif /* _OPENMP */
  for (int i = 0; i < output_crb; ++i) {
    int bt = i / output_cr;
    int cr = i % output_cr;
    int c = cr / output_rows;
    int r = cr % output_rows;

    const int cstart = c * col_stride - pc;
    const int rstart = r * row_stride - pr;
    const int cend = cstart + kernel_cols_up;
    const int rend = rstart + kernel_rows_up;
    const int input_idx_base = bt * input_cri;

    int cnt = 0;
    for (int a = cstart; a < cend; a += col_in_stride) {
      for (int b = rstart; b < rend; b += row_in_stride) {
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


CAMLprim value FUN_BYTE (dilated_spatial_im2col) (value * argv, int argn) {
  return FUN_NATIVE (dilated_spatial_im2col) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16]
  );
}


CAMLprim value FUN_NATIVE (dilated_spatial_backward_kernel_im2col) (
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

  int kernel_cols_up = kernel_cols + (kernel_cols - 1) * (col_in_stride - 1);
  int kernel_rows_up = kernel_rows + (kernel_rows - 1) * (row_in_stride - 1);

  int pad_rows = row_stride * (output_rows - 1) + kernel_rows_up - input_rows;
  int pad_cols = col_stride * (output_cols - 1) + kernel_cols_up - input_cols;
  int p_top  = pad_rows / 2;
  int p_left = pad_cols / 2;
  if (p_top  < 0) p_top  = 0;
  if (p_left < 0) p_left = 0;

  #ifdef _OPENMP
    #pragma omp parallel for schedule(static)
  #endif /* _OPENMP */
  for (int i = 0; i < output_crb; ++i) {
    int bt = i / output_cr;
    int cr = i % output_cr;
    int c = cr / output_rows;
    int r = cr % output_rows;

    const int cstart = c * col_stride - p_left;
    const int rstart = r * row_stride - p_top;
    const int cend = cstart + kernel_cols_up;
    const int rend = rstart + kernel_rows_up;
    const int input_idx_base = bt * input_cri;

    int cnt = 0;
    for (int a = cstart; a < cend; a += col_in_stride) {
      for (int b = rstart; b < rend; b += row_in_stride) {
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


CAMLprim value FUN_BYTE (dilated_spatial_backward_kernel_im2col) (value * argv, int argn) {
  return FUN_NATIVE (dilated_spatial_backward_kernel_im2col) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15]
  );
}


CAMLprim value FUN_NATIVE (dilated_spatial_backward_input_im2col) (
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

  int kernel_cols_up = kernel_cols + (kernel_cols - 1) * (col_in_stride - 1);
  int kernel_rows_up = kernel_rows + (kernel_rows - 1) * (row_in_stride - 1);

  int pad_rows = row_stride * (output_rows - 1) + kernel_rows_up - input_rows;
  int pad_cols = col_stride * (output_cols - 1) + kernel_cols_up - input_cols;
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
    const int cend = cstart + kernel_cols_up;
    const int rend = rstart + kernel_rows_up;
    const int input_idx_base = bt * input_cri;

    int cnt = 0;
    for (int a = cstart; a < cend; a += col_in_stride) {
      for (int b = rstart; b < rend; b += row_in_stride) {
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


CAMLprim value FUN_BYTE (dilated_spatial_backward_input_im2col) (value * argv, int argn) {
  return FUN_NATIVE (dilated_spatial_backward_input_im2col) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14], argv[15]
  );
}


CAMLprim value FUN_NATIVE (dilated_cuboid_im2col) (
  value vInput, value vKernel, value vOutput,
  value vBatches, value vInput_cols, value vInput_rows,
  value vInput_dpts, value vIn_channel,
  value vKernel_cols, value vKernel_rows, value vKernel_dpts,
  value vOutput_cols, value vOutput_rows,
  value vOutput_dpts, value vOut_channel,
  value vDpt_stride, value vRow_stride,  value vCol_stride,
  value vDpt_in_stride, value vRow_in_stride,  value vCol_in_stride,
  value vPadding
) {
  struct caml_ba_array *IN = Caml_ba_array_val(vInput);
  struct caml_ba_array *KE = Caml_ba_array_val(vKernel);
  struct caml_ba_array *OU = Caml_ba_array_val(vOutput);
  TYPE *input_ptr  = (TYPE *) IN->data;
  TYPE *kernel_ptr = (TYPE *) KE->data;
  TYPE *output_ptr = (TYPE *) OU->data;

  int batches       = Long_val(vBatches);
  int input_cols    = Long_val(vInput_cols);
  int input_rows    = Long_val(vInput_rows);
  int input_dpts    = Long_val(vInput_dpts);
  int in_channel    = Long_val(vIn_channel);
  int kernel_cols   = Long_val(vKernel_cols);
  int kernel_rows   = Long_val(vKernel_rows);
  int kernel_dpts   = Long_val(vKernel_dpts);
  int output_cols   = Long_val(vOutput_cols);
  int output_rows   = Long_val(vOutput_rows);
  int output_dpts   = Long_val(vOutput_dpts);
  int out_channel   = Long_val(vOut_channel);
  int dpt_stride    = Long_val(vDpt_stride);
  int row_stride    = Long_val(vRow_stride);
  int col_stride    = Long_val(vCol_stride);
  int dpt_in_stride = Long_val(vDpt_in_stride);
  int row_in_stride = Long_val(vRow_in_stride);
  int col_in_stride = Long_val(vCol_in_stride);
  int padding       = Long_val(vPadding);

  const int input_crdi  = in_channel  * input_dpts * input_rows * input_cols;
  const int input_rdi   = in_channel  * input_dpts * input_rows;
  const int input_di    = in_channel  * input_dpts;
  const int output_crdo = out_channel * output_dpts * output_rows * output_cols;
  const int output_dr   = output_dpts * output_rows;
  const int output_drc  = output_dpts * output_rows * output_cols;
  const int output_drcb = output_dpts * output_rows * output_cols * batches;
  const int kernel_idrc = in_channel  * kernel_dpts * kernel_rows * kernel_cols;

  TYPE *inpt2d = (TYPE *) calloc(kernel_idrc * output_drcb, sizeof(TYPE));
  if (inpt2d == NULL) exit(1);

  memset(output_ptr, 0, batches * output_crdo * sizeof(TYPE));

  INIT;

  int kernel_cols_up = kernel_cols + (kernel_cols - 1) * (col_in_stride - 1);
  int kernel_rows_up = kernel_rows + (kernel_rows - 1) * (row_in_stride - 1);
  int kernel_dpts_up = kernel_dpts + (kernel_dpts - 1) * (dpt_in_stride - 1);

  int pd = 0, pr = 0, pc = 0;
  if (padding != 1) {
    pc = (col_stride * (output_cols - 1) + kernel_cols_up - input_cols) / 2;
    pr = (row_stride * (output_rows - 1) + kernel_rows_up - input_rows) / 2;
    pd = (dpt_stride * (output_dpts - 1) + kernel_dpts_up - input_dpts) / 2;
    if (pc < 0) pc = 0;
    if (pr < 0) pr = 0;
    if (pd < 0) pd = 0;
  }

  #ifdef _OPENMP
    #pragma omp parallel for schedule(static)
  #endif /* _OPENMP */

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
    const int cend   = cstart + kernel_cols_up;
    const int rend   = rstart + kernel_rows_up;
    const int dend   = dstart + kernel_dpts_up;
    const int input_idx_base = bt * input_crdi;

    int cnt = 0;
    for (int a = cstart; a < cend; a += col_in_stride) {
      for (int b = rstart; b < rend; b += row_in_stride) {
        for (int c = dstart; c < dend; c += dpt_in_stride) {
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


CAMLprim value FUN_BYTE (dilated_cuboid_im2col) (value * argv, int argn) {
  return FUN_NATIVE (dilated_cuboid_im2col) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16], argv[17], argv[18], argv[19], argv[20], argv[21]
  );
}


CAMLprim value FUN_NATIVE (dilated_cuboid_backward_kernel_im2col) (
  value vInput, value vKernel, value vOutput,
  value vBatches, value vInput_cols, value vInput_rows,
  value vInput_dpts, value vIn_channel,
  value vKernel_cols, value vKernel_rows, value vKernel_dpts,
  value vOutput_cols, value vOutput_rows,
  value vOutput_dpts, value vOut_channel,
  value vDpt_stride, value vRow_stride,  value vCol_stride,
  value vDpt_in_stride, value vRow_in_stride,  value vCol_in_stride
) {
  struct caml_ba_array *IN = Caml_ba_array_val(vInput);
  struct caml_ba_array *KE = Caml_ba_array_val(vKernel);
  struct caml_ba_array *OU = Caml_ba_array_val(vOutput);
  TYPE *input_ptr  = (TYPE *) IN->data;
  TYPE *kernel_ptr = (TYPE *) KE->data;
  TYPE *output_ptr = (TYPE *) OU->data;

  int batches       = Long_val(vBatches);
  int input_cols    = Long_val(vInput_cols);
  int input_rows    = Long_val(vInput_rows);
  int input_dpts    = Long_val(vInput_dpts);
  int in_channel    = Long_val(vIn_channel);
  int kernel_cols   = Long_val(vKernel_cols);
  int kernel_rows   = Long_val(vKernel_rows);
  int kernel_dpts   = Long_val(vKernel_dpts);
  int output_cols   = Long_val(vOutput_cols);
  int output_rows   = Long_val(vOutput_rows);
  int output_dpts   = Long_val(vOutput_dpts);
  int out_channel   = Long_val(vOut_channel);
  int dpt_stride    = Long_val(vDpt_stride);
  int row_stride    = Long_val(vRow_stride);
  int col_stride    = Long_val(vCol_stride);
  int dpt_in_stride = Long_val(vDpt_in_stride);
  int row_in_stride = Long_val(vRow_in_stride);
  int col_in_stride = Long_val(vCol_in_stride);

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

  int kernel_cols_up = kernel_cols + (kernel_cols - 1) * (col_in_stride - 1);
  int kernel_rows_up = kernel_rows + (kernel_rows - 1) * (row_in_stride - 1);
  int kernel_dpts_up = kernel_dpts + (kernel_dpts - 1) * (dpt_in_stride - 1);

  int pc = (col_stride * (output_cols - 1) + kernel_cols_up - input_cols) / 2;
  int pr = (row_stride * (output_rows - 1) + kernel_rows_up - input_rows) / 2;
  int pd = (dpt_stride * (output_dpts - 1) + kernel_dpts_up - input_dpts) / 2;
  if (pc < 0) pc = 0;
  if (pr < 0) pr = 0;
  if (pd < 0) pd = 0;

  #ifdef _OPENMP
    #pragma omp parallel for schedule(static)
  #endif /* _OPENMP */

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
    const int cend   = cstart + kernel_cols_up;
    const int rend   = rstart + kernel_rows_up;
    const int dend   = dstart + kernel_dpts_up;
    const int input_idx_base = bt * input_crdi;

    int cnt = 0;
    for (int a = cstart; a < cend; a += col_in_stride) {
      for (int b = rstart; b < rend; b += row_in_stride) {
        for (int c = dstart; c < dend; c += dpt_in_stride) {
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


CAMLprim value FUN_BYTE (dilated_cuboid_backward_kernel_im2col) (value * argv, int argn) {
  return FUN_NATIVE (dilated_cuboid_backward_kernel_im2col) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16], argv[17], argv[18], argv[19], argv[20]
  );
}


CAMLprim value FUN_NATIVE (dilated_cuboid_backward_input_im2col) (
  value vInput, value vKernel, value vOutput,
  value vBatches, value vInput_cols, value vInput_rows,
  value vInput_dpts, value vIn_channel,
  value vKernel_cols, value vKernel_rows, value vKernel_dpts,
  value vOutput_cols, value vOutput_rows,
  value vOutput_dpts, value vOut_channel,
  value vDpt_stride, value vRow_stride, value vCol_stride,
  value vDpt_in_stride, value vRow_in_stride, value vCol_in_stride
) {
  struct caml_ba_array *IN = Caml_ba_array_val(vInput);
  struct caml_ba_array *KE = Caml_ba_array_val(vKernel);
  struct caml_ba_array *OU = Caml_ba_array_val(vOutput);
  TYPE *input_ptr  = (TYPE *) IN->data;
  TYPE *kernel_ptr = (TYPE *) KE->data;
  TYPE *output_ptr = (TYPE *) OU->data;

  int batches       = Long_val(vBatches);
  int input_cols    = Long_val(vInput_cols);
  int input_rows    = Long_val(vInput_rows);
  int input_dpts    = Long_val(vInput_dpts);
  int in_channel    = Long_val(vIn_channel);
  int kernel_cols   = Long_val(vKernel_cols);
  int kernel_rows   = Long_val(vKernel_rows);
  int kernel_dpts   = Long_val(vKernel_dpts);
  int output_cols   = Long_val(vOutput_cols);
  int output_rows   = Long_val(vOutput_rows);
  int output_dpts   = Long_val(vOutput_dpts);
  int out_channel   = Long_val(vOut_channel);
  int dpt_stride    = Long_val(vDpt_stride);
  int row_stride    = Long_val(vRow_stride);
  int col_stride    = Long_val(vCol_stride);
  int dpt_in_stride = Long_val(vDpt_in_stride);
  int row_in_stride = Long_val(vRow_in_stride);
  int col_in_stride = Long_val(vCol_in_stride);

  const int input_crdi  = in_channel  * input_dpts * input_rows * input_cols;
  const int input_rdi   = in_channel  * input_dpts * input_rows;
  const int input_di    = in_channel  * input_dpts;
  const int output_dr   = output_dpts * output_rows;
  const int output_drc  = output_dpts * output_rows * output_cols;
  const int output_drcb = output_dpts * output_rows * output_cols * batches;
  const int kernel_idrc = in_channel  * kernel_dpts * kernel_rows * kernel_cols;

  TYPE *inpt2d = (TYPE *) calloc(kernel_idrc * output_drcb, sizeof(TYPE));
  if (inpt2d == NULL) exit(1);

  memset(input_ptr, 0, batches * input_crdi * sizeof(TYPE));

  INIT;

  int kernel_cols_up = kernel_cols + (kernel_cols - 1) * (col_in_stride - 1);
  int kernel_rows_up = kernel_rows + (kernel_rows - 1) * (row_in_stride - 1);
  int kernel_dpts_up = kernel_dpts + (kernel_dpts - 1) * (dpt_in_stride - 1);

  int pc = (col_stride * (output_cols - 1) + kernel_cols_up - input_cols) / 2;
  int pr = (row_stride * (output_rows - 1) + kernel_rows_up - input_rows) / 2;
  int pd = (dpt_stride * (output_dpts - 1) + kernel_dpts_up - input_dpts) / 2;
  if (pc < 0) pc = 0;
  if (pr < 0) pr = 0;
  if (pd < 0) pd = 0;

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
    const int cend   = cstart + kernel_cols_up;
    const int rend   = rstart + kernel_rows_up;
    const int dend   = dstart + kernel_dpts_up;
    const int input_idx_base = bt * input_crdi;

    int cnt = 0;
    for (int a = cstart; a < cend; a += col_in_stride) {
      for (int b = rstart; b < rend; b += row_in_stride) {
        for (int c = dstart; c < dend; c += dpt_in_stride) {
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


CAMLprim value FUN_BYTE (dilated_cuboid_backward_input_im2col) (value * argv, int argn) {
  return FUN_NATIVE (dilated_cuboid_backward_input_im2col) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14],
    argv[15], argv[16], argv[17], argv[18], argv[19], argv[20]
  );
}


#endif /* OWL_ENABLE_TEMPLATE */
