/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


void FUNCTION (c, slide) (
  TYPE *x, TYPE *y, int window, int step, int m, int n,
  int ofsx, int incx_m, int incx_n, int ofsy, int incy_m, int incy_n
) {

  for (int i = 0; i < m; i++) {
    start_x_n = start_x_m;
    start_y_n = start_y_m;

    for (int j = 0; j < n; j++) {
      MAPFN(start_x_n, start_y_n);
      start_x_n += incx_n;
      start_y_n += incy_n;
    }

    start_x_m += incx_m;
    start_y_m += incy_m;
  }




}


CAMLprim value FUNCTION (stub, slide) (value vX, value vM, value vN, value vI, value vJ) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  int m = Long_val(vM);
  int n = Long_val(vN);
  int i = Long_val(vI);
  int j = Long_val(vJ);

  // FUNCTION (c, slide) (X_data, m, n, i, j);

  return Val_unit;
}


#endif /* OWL_ENABLE_TEMPLATE */
