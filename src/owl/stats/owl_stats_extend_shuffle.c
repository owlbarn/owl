/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_stats.h"


static inline void owl_stats_swap (void* base, int size, int i, int j) {
  register char* a = size * i + (char*) base;
  register char* b = size * j + (char*) base;

  if (i == j)
    return;

  for (register int s = size; s > 0; s--) {
    char tmp = *a;
    *a++ = *b;
    *b++ = tmp;
  }
}


static inline void owl_stats_copy (void* dest, int i, void* src, int j, int size) {
  register char* a = size * i + (char*) dest ;
  register char* b = size * j + (char*) src ;

  for (register int s = size; s > 0; s--)
    *a++ = *b++;
}


// shuffle n elements and each has size size
void owl_stats_shuffle (void* base, int n, int size) {
  for (int i = n - 1; i > 0; i--) {
    int j = sfmt_f64_1 * (i + 1);
    owl_stats_swap(base, size, i, j) ;
  }
}


// choose k out of n elements from src and save to dst
void owl_stats_choose (void* dst, int k, void* src, int n, int size) {
  int i, j = 0;

  for (i = 0; i < n && j < k; i++) {
    if ((n - i) * sfmt_f64_1 < k - j) {
      owl_stats_copy(dst, j, src, i, size);
      j++;
    }
  }
}


// sample k out of n elements from src and save to dst, with replacement
void owl_stats_sample (void* dst, int k, void* src, int n, int size) {
  int i, j = 0;

  for (i = 0; i < k; i++) {
    j = sfmt_f64_1 * n;
    owl_stats_copy(dst, i, src, j, size);
  }
}
