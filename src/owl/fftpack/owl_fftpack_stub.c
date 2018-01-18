/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */


#ifdef Treal

#include "fftpack.c"


/** Owl's interface function to FFTPACK **/


void FFTPACK_CFFTI (int n, Treal wsave[]) {
  if (n == 1) return;
  int iw1 = 2 * n;
  int iw2 = iw1 + 2 * n;
  cffti1(n, wsave + iw1, (int*) (wsave + iw2));
}


void FFTPACK_CFFTF (int n, Treal c[], Treal wsave[]) {
  if (n == 1) return;
  int iw1 = 2 * n;
  int iw2 = iw1 + 2 * n;
  cfftf1(n, c, wsave, wsave + iw1, (int*) (wsave + iw2), -1);
}


void FFTPACK_CFFTB (int n, Treal c[], Treal wsave[]) {
  if (n == 1) return;
  int iw1 = 2 * n;
  int iw2 = iw1 + 2 * n;
  cfftf1(n, c, wsave, wsave + iw1, (int*) (wsave + iw2), +1);
}


void FFTPACK_RFFTI (int n, Treal wsave[]) {
  if (n == 1) return;
  rffti1(n, wsave + n, (int*) (wsave + 2 * n));
}


void FFTPACK_RFFTF (int n, Treal r[], Treal wsave[]) {
  if (n == 1) return;
  rfftf1(n, r, wsave, wsave + n, (int*) (wsave + 2 * n));
}


void FFTPACK_RFFTB(int n, Treal r[], Treal wsave[]) {
  if (n == 1) return;
  rfftb1(n, r, wsave, wsave + n, (int*) (wsave + 2 * n));
}


/** Helper functions **/


// uppack from halfcomplex x to complex y
static OWL_INLINE void halfcomplex_unpack (int n, Treal* x, int ofsx, int incx, _Complex Treal* y, int ofsy, int incy) {
  int i;
  *(y + ofsy) = *(x + ofsx) + 0 * I;

  for (i = 1; i < n - i; i++) {
    ofsx += incx + incx;
    ofsy += incy;
    Treal re = *(x + ofsx - incx);
    Treal im = *(x + ofsx);
    *(y + ofsy) = re + im * I;
  }

  if (i == n - i)
    *(y + ofsy + incy) = *(x + ofsx + incx) + 0 * I;
}


// pack from complex x to halfcomplex y
static OWL_INLINE void halfcomplex_pack (int n, _Complex Treal* x, int ofsx, int incx, Treal* y, int ofsy, int incy) {
  int i;
  *(y + ofsy) = creal(*(x + ofsx));

  for (i = 1; i < n - i; i++) {
    ofsx += incx;
    ofsy += incy + incy;
    *(y + ofsy - incy) = creal(*(x + ofsx));
    *(y + ofsy) = cimag(*(x + ofsx));
  }

  if (i == n - i)
    *(y + ofsy + incy) = creal(*(x + ofsx + incx));
}


/** Owl's stub functions **/


value STUB_CFFTF (value vX, value vY, value vD) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  _Complex Treal *X_data = (_Complex Treal *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  _Complex Treal *Y_data = (_Complex Treal *) Y->data;

  int d = Long_val(vD);
  int n = X->dim[d];
  size_t ws_sz = 4 * n * sizeof(Treal);
  size_t fc_sz = (MAXFAC + 2) * sizeof(int);
  void* wsave = malloc(ws_sz + fc_sz);
  void* data = malloc(2 * n * sizeof(Treal));

  int stdx = owl_ndarray_stride_size(X, d);
  int slcx = owl_ndarray_slice_size(X,d);
  int stdy = owl_ndarray_stride_size(Y, d);
  int slcy = owl_ndarray_slice_size(Y,d);
  int m = owl_ndarray_numel(X) / slcx;

  FFTPACK_CFFTI(n, wsave);

  int ofsx = 0;
  int ofsy = 0;

  for (int i = 0; i < m; i ++) {
    for (int j = 0; j < stdx; j++) {
      COMPLEX_COPY(n, X_data, ofsx + j, stdx, data, 0, 1);
      FFTPACK_CFFTF(n, (Treal*) data, wsave);
      COMPLEX_COPY(n, data, 0, 1, Y_data, ofsy + j, stdy);
    }
    ofsx += slcx;
    ofsy += slcy;
  }

  free(wsave);
  free(data);

  return Val_unit;
}


value STUB_CFFTB (value vX, value vY, value vD) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  _Complex Treal *X_data = (_Complex Treal *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  _Complex Treal *Y_data = (_Complex Treal *) Y->data;

  int d = Long_val(vD);
  int n = X->dim[d];
  size_t ws_sz = 4 * n * sizeof(Treal);
  size_t fc_sz = (MAXFAC + 2) * sizeof(int);
  void* wsave = malloc(ws_sz + fc_sz);
  void* data = malloc(2 * n * sizeof(Treal));

  int stdx = owl_ndarray_stride_size(X, d);
  int slcx = owl_ndarray_slice_size(X,d);
  int stdy = owl_ndarray_stride_size(Y, d);
  int slcy = owl_ndarray_slice_size(Y,d);
  int m = owl_ndarray_numel(X) / slcx;

  FFTPACK_CFFTI(n, wsave);

  int ofsx = 0;
  int ofsy = 0;

  for (int i = 0; i < m; i ++) {
    for (int j = 0; j < stdx; j++) {
      COMPLEX_COPY(n, X_data, ofsx + j, stdx, data, 0, 1);
      FFTPACK_CFFTB(n, (Treal*) data, wsave);
      COMPLEX_COPY(n, data, 0, 1, Y_data, ofsy + j, stdy);
    }
    ofsx += slcx;
    ofsy += slcy;
  }

  free(wsave);
  free(data);

  return Val_unit;
}


value STUB_RFFTF (value vX, value vY, value vD) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  Treal *X_data = (Treal *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  _Complex Treal *Y_data = (_Complex Treal *) Y->data;

  int d = Long_val(vD);
  int n = X->dim[d];
  size_t ws_sz = 2 * n * sizeof(Treal);
  size_t fc_sz = (MAXFAC + 2) * sizeof(int);
  void* wsave = malloc(ws_sz + fc_sz);
  void* data = malloc(n * sizeof(Treal));

  int stdx = owl_ndarray_stride_size(X, d);
  int slcx = owl_ndarray_slice_size(X,d);
  int stdy = owl_ndarray_stride_size(Y, d);
  int slcy = owl_ndarray_slice_size(Y,d);
  int m = owl_ndarray_numel(X) / slcx;

  FFTPACK_RFFTI(n, wsave);

  int ofsx = 0;
  int ofsy = 0;

  for (int i = 0; i < m; i ++) {
    for (int j = 0; j < stdx; j++) {
      REAL_COPY(n, X_data, ofsx + j, stdx, data, 0, 1);
      FFTPACK_RFFTF(n, (Treal*) data, wsave);
      halfcomplex_unpack(n, data, 0, 1, Y_data, ofsy + j, stdy);
    }
    ofsx += slcx;
    ofsy += slcy;
  }

  free(wsave);
  free(data);

  return Val_unit;
}


value STUB_RFFTB (value vX, value vY, value vD) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  _Complex Treal *X_data = (_Complex Treal *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  Treal *Y_data = (Treal *) Y->data;

  int d = Long_val(vD);
  int n = Y->dim[d];
  size_t ws_sz = 2 * n * sizeof(Treal);
  size_t fc_sz = (MAXFAC + 2) * sizeof(int);
  void* wsave = malloc(ws_sz + fc_sz);
  void* data = malloc(n * sizeof(_Complex Treal));

  int stdx = owl_ndarray_stride_size(X, d);
  int slcx = owl_ndarray_slice_size(X,d);
  int stdy = owl_ndarray_stride_size(Y, d);
  int slcy = owl_ndarray_slice_size(Y,d);
  int m = owl_ndarray_numel(X) / slcx;

  FFTPACK_RFFTI(n, wsave);

  int ofsx = 0;
  int ofsy = 0;

  for (int i = 0; i < m; i ++) {
    for (int j = 0; j < stdx; j++) {
      halfcomplex_pack(n, X_data, ofsx + j, stdx, data, 0, 1);
      FFTPACK_RFFTB(n, (Treal*) data, wsave);
      REAL_COPY(n, (Treal*) data, 0, 1, Y_data, ofsy + j, stdy);
    }
    ofsx += slcx;
    ofsy += slcy;
  }

  free(wsave);
  free(data);

  return Val_unit;
}


#endif //Treal
