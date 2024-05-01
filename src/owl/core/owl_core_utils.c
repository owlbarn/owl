/*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 */

#include "owl_core.h"


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
int64_t c_ndarray_numel (struct caml_ba_array *X) {
  int64_t n = 1;

  for (int i = 0; i < X->num_dims; i ++)
    n *= X->dim[i];

  return n;
}


// calculate the stride of a given dimension of a bigarray
int64_t c_ndarray_stride_dim (struct caml_ba_array *X, int d) {
  int64_t s = 1;

  for (int i = X->num_dims - 1; i > d; i--)
    s *= X->dim[i];

  return s;
}


// calculate the slice size of a given dimension of a bigarray
int64_t c_ndarray_slice_dim (struct caml_ba_array *X, int d) {
  int64_t s = 1;

  for (int i = X->num_dims - 1; i >= d; i--)
    s *= X->dim[i];

  return s;
}


// calculate the stride size of all dimensions of a bigarray
void c_ndarray_stride (struct caml_ba_array *X, int64_t *stride) {
  int64_t i = X->num_dims - 1;
  *(stride + i) = 1;

  for ( ; i > 0; i--)
    *(stride + i - 1) = *(stride + i) * X->dim[i];
}


// calculate the slice size of all dimensions of a bigarray
void c_ndarray_slice (struct caml_ba_array *X, int64_t *slice) {
  int64_t i = X->num_dims - 1;
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
void c_slicing_stride (struct caml_ba_array *X, int64_t *slice, int64_t *stride) {
  c_ndarray_stride(X, stride);

  for (int64_t i = 0; i < X->num_dims; i++) {
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
void c_slicing_offset (struct caml_ba_array *X, int64_t *slice, int64_t *offset) {
  c_ndarray_stride(X, offset);

  for (int64_t i = 0; i < X->num_dims; i++) {
    int64_t start = *(slice + 3 * i);
    *(offset + i) *= start < 0 ? 0 : start;
  }
}


/*
 * calculate the L1/L2/L3 cache sizes of CPU. Default values are used if the
 * vendor is not supported.
 *
 * Code heavily inspired by Eigen (http://eigen.tuxfamily.org/).
 */

#if defined(__arm__) || defined(__aarch64__)
void query_cache_sizes(int* l1p, int* l2p, int* l3p) {
  *l1p = 16 * 1024;
  *l2p = 512 * 1024;
  *l3p = 512 * 1024;
}
#else
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

  if (l1 == 0) l1 = 32 * 1024;
  if (l2 == 0) l2 = 256 * 1024;
  if (l3 == 0) l3 = 2048 * 1024;

  *l1p = l1; *l2p = l2; *l3p = l3;
  return;
}


OWL_INLINE void query_cache_sizes_amd(int* l1p, int* l2p, int* l3p) {
  int cpuinfo[4];
  int l1 = 0, l2 = 0, l3 = 0;
  cpuinfo[0] = cpuinfo[1] = cpuinfo[2] = cpuinfo[3] = 0;
  CPUID(cpuinfo, 0x80000005, 0);
  l1 = (cpuinfo[2] >> 24) * 1024;
  cpuinfo[0] = cpuinfo[1] = cpuinfo[2] = cpuinfo[3] = 0;
  CPUID(cpuinfo, 0x80000006, 0);
  l2 = (cpuinfo[2] >> 16) * 1024;
  l3 = ((cpuinfo[3] & 0xFFFC000) >> 18) * 512 * 1024;
  *l1p = l1; *l2p = l2; *l3p = l3;
  return;
}


OWL_INLINE int cpu_is_amd(int* cpuinfo) {
  int amd1[] = {0x68747541, 0x69746e65, 0x444d4163};
  int amd2[] = {0x69444d41, 0x74656273, 0x21726574};
  int is_amd1 = cpuinfo[1] == amd1[0] && cpuinfo[3] == amd1[1]
    && cpuinfo[2] == amd1[2];
  int is_amd2 = cpuinfo[1] == amd2[0] && cpuinfo[3] == amd2[1]
    && cpuinfo[2] == amd2[2];
  return (is_amd1 || is_amd2);
}


void query_cache_sizes(int* l1p, int* l2p, int* l3p) {
  if (OWL_ARCH_i386 || OWL_ARCH_x86_64) {
    int cpuinfo[4];
    CPUID(cpuinfo, 0x0, 0);

    if (cpu_is_amd(cpuinfo)) {
      query_cache_sizes_amd(l1p, l2p, l3p);
      return;
    }

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
#endif
