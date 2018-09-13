/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"
#include <assert.h>

// compare two numbers (real & complex & int)

int float32_cmp (const void * a, const void * b) {
  return ( *(float*)a < *(float*)b ? -1 : (*(float*)a > *(float*)b ? 1 : 0) );
}

int float64_cmp (const void * a, const void * b) {
  return ( *(double*)a < *(double*)b ? -1 : (*(double*)a > *(double*)b ? 1 : 0) );
}

int complex32_cmp (const void * a, const void * b) {
 return ( CLTF(*(_Complex float*)a,*(_Complex float*)b) ? -1 : (CGTF(*(_Complex float*)a,*(_Complex float*)b) ? 1 : 0) );
}

int complex64_cmp (const void * a, const void * b) {
 return ( CLT(*(_Complex double*)a,*(_Complex double*)b) ? -1 : (CGT(*(_Complex double*)a,*(_Complex double*)b) ? 1 : 0) );
}

int int8_cmp (const void * a, const void * b) {
  return ( *(int8_t*)a < *(int8_t*)b ? -1 : (*(int8_t*)a > *(int8_t*)b ? 1 : 0) );
}

int uint8_cmp (const void * a, const void * b) {
  return ( *(uint8_t*)a < *(uint8_t*)b ? -1 : (*(uint8_t*)a > *(uint8_t*)b ? 1 : 0) );
}

int int16_cmp (const void * a, const void * b) {
  return ( *(int16_t*)a < *(int16_t*)b ? -1 : (*(int16_t*)a > *(int16_t*)b ? 1 : 0) );
}

int uint16_cmp (const void * a, const void * b) {
  return ( *(uint16_t*)a < *(uint16_t*)b ? -1 : (*(uint16_t*)a > *(uint16_t*)b ? 1 : 0) );
}

int int32_cmp (const void * a, const void * b) {
  return ( *(int32_t*)a < *(int32_t*)b ? -1 : (*(int32_t*)a > *(int32_t*)b ? 1 : 0) );
}

int int64_cmp (const void * a, const void * b) {
  return ( *(int64_t*)a < *(int64_t*)b ? -1 : (*(int64_t*)a > *(int64_t*)b ? 1 : 0) );
}


// compare two numbers, used in qsort_r and argsort

int float32_cmp_r (const void * i, const void * j, const void * z) {
  float a = *((float*)z + (*(int64_t*)i));
  float b = *((float*)z + (*(int64_t*)j));
  return ( a < b ? -1 : (a > b ? 1 : 0) );
}

int float64_cmp_r (const void * i, const void * j, const void * z) {
  double a = *((double*)z + (*(int64_t*)i));
  double b = *((double*)z + (*(int64_t*)j));
  return ( a < b ? -1 : (a > b ? 1 : 0) );
}

int complex32_cmp_r (const void * i, const void * j, const void * z) {
  _Complex float a = *((_Complex float*)z + (*(int64_t*)i));
  _Complex float b = *((_Complex float*)z + (*(int64_t*)j));
  return ( CLTF(a,b) ? -1 : (CGTF(a,b) ? 1 : 0) );
}

int complex64_cmp_r (const void * i, const void * j, const void * z) {
  _Complex double a = *((_Complex double*)z + (*(int64_t*)i));
  _Complex double b = *((_Complex double*)z + (*(int64_t*)j));
  return ( CLT(a,b) ? -1 : (CGT(a,b) ? 1 : 0) );
}

int int8_cmp_r (const void * i, const void * j, const void * z) {
  int8_t a = *((int8_t*)z + (*(int64_t*)i));
  int8_t b = *((int8_t*)z + (*(int64_t*)j));
  return ( a < b ? -1 : (a > b ? 1 : 0) );
}

int uint8_cmp_r (const void * i, const void * j, const void * z) {
  uint8_t a = *((uint8_t*)z + (*(int64_t*)i));
  uint8_t b = *((uint8_t*)z + (*(int64_t*)j));
  return ( a < b ? -1 : (a > b ? 1 : 0) );
}

int int16_cmp_r (const void * i, const void * j, const void * z) {
  int16_t a = *((int16_t*)z + (*(int64_t*)i));
  int16_t b = *((int16_t*)z + (*(int64_t*)j));
  return ( a < b ? -1 : (a > b ? 1 : 0) );
}

int uint16_cmp_r (const void * i, const void * j, const void * z) {
  uint16_t a = *((uint16_t*)z + (*(int64_t*)i));
  uint16_t b = *((uint16_t*)z + (*(int64_t*)j));
  return ( a < b ? -1 : (a > b ? 1 : 0) );
}

int int32_cmp_r (const void * i, const void * j, const void * z) {
  int32_t a = *((int32_t*)z + (*(int64_t*)i));
  int32_t b = *((int32_t*)z + (*(int64_t*)j));
  return ( a < b ? -1 : (a > b ? 1 : 0) );
}

int int64_cmp_r (const void * i, const void * j, const void * z) {
  int64_t a = *((int64_t*)z + (*(int64_t*)i));
  int64_t b = *((int64_t*)z + (*(int64_t*)j));
  return ( a < b ? -1 : (a > b ? 1 : 0) );
}


// calculate the number of elements given a bigarray
int c_ndarray_numel (struct caml_ba_array *X) {
  int n = 1;

  for (int i = 0; i < X->num_dims; i ++)
    n *= X->dim[i];

  return n;
}


// calculate the stride of a given dimension of a bigarray
int c_ndarray_stride_dim (struct caml_ba_array *X, int d) {
  int s = 1;

  for (int i = X->num_dims - 1; i > d; i--)
    s *= X->dim[i];

  return s;
}


// calculate the slice size of a given dimension of a bigarray
int c_ndarray_slice_dim (struct caml_ba_array *X, int d) {
  int s = 1;

  for (int i = X->num_dims - 1; i >= d; i--)
    s *= X->dim[i];

  return s;
}


// calculate the stride size of all dimensions of a bigarray
void c_ndarray_stride (struct caml_ba_array *X, int *stride) {
  int i = X->num_dims - 1;
  *(stride + i) = 1;

  for ( ; i > 0; i--)
    *(stride + i - 1) = *(stride + i) * X->dim[i];
}


// calculate the slice size of all dimensions of a bigarray
void c_ndarray_slice (struct caml_ba_array *X, int *slice) {
  int i = X->num_dims - 1;
  *(slice + i) = X->dim[i];

  for (; i > 0; i--)
    *(slice + i - 1) = *(slice + i) * X->dim[i - 1];
}


/*
 * calculate the offset of each dimension in output based on a slice definition
 * the slice definition is a list (start,stop,step) triplets.
 *
 * Note that slice may encode information for fancy slicing. In case of L, the
 * stride remains the same.
 */
void c_slicing_stride (struct caml_ba_array *X, int64_t *slice, int *stride) {
  c_ndarray_stride(X, stride);

  for (int i = 0; i < X->num_dims; i++) {
    int64_t start = *(slice + 3 * i);
    int64_t step = *(slice + 3 * i + 2);
    *(stride + i) *= start < 0 ? 1 : step;
  }
}


/*
 * calculate the offset of each dimension in output based on a slice definition
 * the slice definition is a list (start,stop,step) triplets.
 *
 * Note that slice may encode information for fancy slicing. In case of L, we
 * set offset to zero since the elements in L will be used to calculate ofsx.
 */
void c_slicing_offset (struct caml_ba_array *X, int64_t *slice, int *offset) {
  c_ndarray_stride(X, offset);

  for (int i = 0; i < X->num_dims; i++) {
    int64_t start = *(slice + 3 * i);
    *(offset + i) *= start < 0 ? 0 : start;
  }
}

#define CPUID(abcd,func,id) __asm__ __volatile__ ("xchg{q}\t{%%}rbx, %q1; cpuid; xchg{q}\t{%%}rbx, %q1": "=a" (abcd[0]), "=&r" (abcd[1]), "=c" (abcd[2]), "=d" (abcd[3]) : "0" (func), "2" (id));

inline void query_cache_sizes_intel_direct(int* l1p, int* l2p, int* l3p) {
  int abcd[4];
  int l1, l2, l3;
  l1 = l2 = l3 = 0;
  int cache_id = 0;
  int cache_type = 0;
  do {
    abcd[0] = abcd[1] = abcd[2] = abcd[3] = 0;
    CPUID(abcd, 0x4, cache_id);
    cache_type = (abcd[0] & 0x0F) >> 0;
    if(cache_type == 1 || cache_type == 3) // data or unified cache
    {
      int cache_level = (abcd[0] & 0xE0) >> 5;  // A[7:5]
      int ways        = (abcd[1] & 0xFFC00000) >> 22; // B[31:22]
      int partitions  = (abcd[1] & 0x003FF000) >> 12; // B[21:12]
      int line_size   = (abcd[1] & 0x00000FFF) >>  0; // B[11:0]
      int sets        = (abcd[2]);                    // C[31:0]

      int cache_size = (ways+1) * (partitions+1) * (line_size+1) * (sets+1);

      switch(cache_level)
      {
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

inline void query_cache_sizes_intel(int* l1, int* l2, int* l3, int max_std_funcs) {
  // if(max_std_funcs >= 4)
  query_cache_sizes_intel_direct(l1, l2, l3);
  // else
    //queryCacheSizes_intel_codes(l1, l2, l3);
}

inline void query_cache_sizes(int* l1p, int* l2p, int* l3p) {
  int abcd[4];
  const int GenuineIntel[] = {0x756e6547, 0x49656e69, 0x6c65746e};
  CPUID(abcd,0x0,0);
  int max_std_funcs = abcd[1];
  //if(cpuid_is_vendor(abcd,GenuineIntel))
  query_cache_sizes_intel(l1p, l2p, l3p, max_std_funcs);

  fprintf(stderr, "L1/L2/L3 size: %d, %d, %d\n", *l1p, *l2p, *l3p);
  return;
}


void compute_block_sizes(int* kp, int* mp, int* np, int typesize) {

  int l1 = 9 * 1024;
  int l2 = 32 * 1024;
  int l3 = 512 * 1024;

  query_cache_sizes(&l1, &l2, &l3);

  l1 = 9 * 1024;
  l2 = 32 * 1024;
  l3 = 512 * 1024;

  int k = *kp;
  int m = *mp;
  int n = *np;

  if (fmax(k, fmax(m, n)) < 48) {
    return;
  }

  int nr = 4;
  int mr = 2 * sizeof(void*); // Depends on env
  int k_peeling = 8;
  int k_div = (mr + nr) * typesize;
  int k_sub = mr * nr * typesize;

  const int max_kc = fmax(((l1 - k_sub) / k_div) & (~(k_peeling - 1)), 1);
  const int old_k = k;

  if (k > max_kc) {
    k = (k % max_kc) == 0 ? max_kc
      : max_kc - k_peeling * ((max_kc - 1 - (k % max_kc)) / (k_peeling * (k / max_kc + 1)));
    assert (old_k / k == old_k / max_kc);
  }

  int max_nc;
  const int actual_l2 = l3; // l3 for debug; 1572864 for other cases
  const int lhs_bytes = m * k * typesize;
  const int rest_l1 = l1 - k_sub - lhs_bytes;
  if (rest_l1 >= nr * typesize) {
    max_nc = rest_l1 / (k * typesize);
  } else {
    max_nc = (3 * actual_l2) / (4 * max_kc * typesize);
  }

  int nc = (int) (fmin(actual_l2 / (2 * k * typesize), max_nc)) & (~(nr - 1));
  if (n > nc) {
    n = (n % nc == 0) ? nc : (nc - nr * (nc - (n % nc)) / (nr * (n / nc + 1)));
  } else if (old_k == k) {
    int problem_size = k * n * typesize;
    int actual_lm = actual_l2;
    int max_mc = m;

    if (problem_size < 1024) {
      actual_lm = l1;
    } else if (l3 != 0 && problem_size <= 32768) {
      actual_lm = l2;
      max_mc = fmin(576, max_mc);
    }
    int mc = fmin(actual_lm / (3 * k * typesize), max_mc);
    if (mc > mr) {
      mc -= mc % mr;
    }
    else if (mc == 0) {
      *kp = k; *mp = m; *np = n;
      return;
    }
    m = (m % mc == 0) ? mc : (mc - mr * (mc - (m % mc)) / (mr * (m / mc + 1)));
  }

  fprintf(stderr, "calculated: k = %d, m = %d, n = %d\n", k, m, n);

  *kp = k; *mp = m; *np = n;
  return;
}
