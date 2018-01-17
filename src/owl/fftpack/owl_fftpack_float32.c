/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#define Treal float

#include "fftpack.c"


/** Owl's interface function **/


void float32_fftpack_cffti(int n, Treal wsave[]) {
  if (n == 1) return;
  int iw1 = 2 * n;
  int iw2 = iw1 + 2 * n;
  cffti1(n, wsave + iw1, (int*) (wsave + iw2));
}


void float32_fftpack_cfftf(int n, Treal c[], Treal wsave[]) {
  if (n == 1) return;
  int iw1 = 2 * n;
  int iw2 = iw1 + 2 * n;
  cfftf1(n, c, wsave, wsave + iw1, (int*) (wsave + iw2), -1);
}


void float32_fftpack_cfftb(int n, Treal c[], Treal wsave[]) {
  if (n == 1) return;
  int iw1 = 2 * n;
  int iw2 = iw1 + 2 * n;
  cfftf1(n, c, wsave, wsave + iw1, (int*) (wsave + iw2), +1);
}


void float32_fftpack_rffti(int n, Treal wsave[]) {
  if (n == 1) return;
  rffti1(n, wsave + n, (int*) (wsave + 2 * n));
}


void float32_fftpack_rfftf(int n, Treal r[], Treal wsave[]) {
  if (n == 1) return;
  rfftf1(n, r, wsave, wsave + n, (int*) (wsave + 2 * n));
}


void float32_fftpack_rfftb(int n, Treal r[], Treal wsave[]) {
  if (n == 1) return;
  rfftb1(n, r, wsave, wsave + n, (int*) (wsave + 2 * n));
}
