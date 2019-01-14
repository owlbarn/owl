/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


// swap row i and row j in x(m,n)
void FUNCTION (c, swap_rows) (TYPE *x, int m, int n, int i, int j) {
  if (i != j) {
    TYPE * src = x + n * i;
    TYPE * dst = x + n * j;

    if (n >= OWL_OMP_THRESHOLD_DEFAULT) {
      #pragma omp parallel for schedule(static)
      for (int k = 0; k < n; k++) {
        TYPE t = *(src + k);
        *(src + k) = *(dst + k);
        *(dst + k) = t;
      }
    }
    else {
      for (int k = 0; k < n; k++) {
        TYPE t = *(src + k);
        *(src + k) = *(dst + k);
        *(dst + k) = t;
      }
    }
  }
}


// stub function of swap_rows
CAMLprim value FUNCTION (stub, swap_rows) (value vX, value vM, value vN, value vI, value vJ) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  int m = Long_val(vM);
  int n = Long_val(vN);
  int i = Long_val(vI);
  int j = Long_val(vJ);

  FUNCTION (c, swap_rows) (X_data, m, n, i, j);

  return Val_unit;
}


// swap column i and colum j in x(m,n)
void FUNCTION (c, swap_cols) (TYPE *x, int m, int n, int i, int j) {
  if (i != j) {
    TYPE * src = x + i;
    TYPE * dst = x + j;

    if (m >= OWL_OMP_THRESHOLD_DEFAULT) {
      #pragma omp parallel for schedule(static)
      for (int k = 0; k < m; k++) {
        int base = k * n;
        TYPE t = *(src + base);
        *(src + base) = *(dst + base);
        *(dst + base) = t;
      }
    }
    else {
      int base = 0;
      for (int k = 0; k < m; k++) {
        TYPE t = *(src + base);
        *(src + base) = *(dst + base);
        *(dst + base) = t;
        base += n;
      }
    }
  }
}


// stub function of swap_cols
CAMLprim value FUNCTION (stub, swap_cols) (value vX, value vM, value vN, value vI, value vJ) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  int m = Long_val(vM);
  int n = Long_val(vN);
  int i = Long_val(vI);
  int j = Long_val(vJ);

  FUNCTION (c, swap_cols) (X_data, m, n, i, j);

  return Val_unit;
}


// transpose x(m,n) and save to y(n,m)
void FUNCTION (c, transpose) (TYPE *x, TYPE *y, int m, int n) {
  int ofsx = 0;
  int ofsy = 0;

  if (m >= OWL_OMP_THRESHOLD_DEFAULT / 100) {
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        *(y + i + j * m) = *(x + j + i * n);
      }
    }
  }
  else {
    for (int i = 0; i < m; i++) {
      ofsy = i;
      for (int j = 0; j < n; j++) {
        *(y + ofsy) = *(x + ofsx);
        ofsy += m;
        ofsx += 1;
      }
    }
  }
}


// stub function of transpose
CAMLprim value FUNCTION (stub, transpose) (value vX, value vY) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *Y_data = (TYPE *) Y->data;

  FUNCTION (c, transpose) (X_data, Y_data, X->dim[0], X->dim[1]);

  return Val_unit;
}


// conjugate transpose x(m,n) and save to y(n,m)
void FUNCTION (c, ctranspose) (TYPE *x, TYPE *y, int m, int n) {
  int ofsx = 0;
  int ofsy = 0;

  if (m >= OWL_OMP_THRESHOLD_DEFAULT / 100) {
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        *(y + i + j * m) = CONJ_FUN(*(x + j + i * n));
      }
    }
  }
  else {
    for (int i = 0; i < m; i++) {
      ofsy = i;
      for (int j = 0; j < n; j++) {
        *(y + ofsy) = CONJ_FUN(*(x + ofsx));
        ofsy += m;
        ofsx += 1;
      }
    }
  }
}


// stub function of ctranspose
CAMLprim value FUNCTION (stub, ctranspose) (value vX, value vY) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *Y_data = (TYPE *) Y->data;

  FUNCTION (c, ctranspose) (X_data, Y_data, X->dim[0], X->dim[1]);

  return Val_unit;
}


#endif /* OWL_ENABLE_TEMPLATE */
