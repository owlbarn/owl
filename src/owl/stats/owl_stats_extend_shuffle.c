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
