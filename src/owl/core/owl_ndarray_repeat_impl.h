/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


void FUNCTION (c, repeat) (
  TYPE *x, TYPE *y, int m, int n, int o,
  int ofsx_m, int incx_m, int incx_n, int incy_m, int incy_n
) {

  TYPE *start_x_m = x;
  TYPE *start_x_n = x;
  TYPE *start_y_m = y;
  TYPE *start_y_n = y;

  for (int i = 0; i < m; i++) {
    start_x_n = start_x_m + ofsx_m;
    start_y_n = start_y_m;

    for (int j = 0; j < n; j++) {

      for (int k = 0; k < o; k++) {
        *(start_y_n + k) = *(start_x_n + k);
      }

      start_x_n += incx_n;
      start_y_n += incy_n;
    }

    start_x_m += incx_m;
    start_y_m += incy_m;
  }

}


CAMLprim value FUNCTION (stub, repeat_native) (
  value vX, value vY, value vM, value vN, value vO,
  value vOFSX_M, value vINCX_M, value vINCX_N, value vINCY_M, value vINCY_N
) {

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *Y_data = (TYPE *) Y->data;

  int m = Long_val(vM);
  int n = Long_val(vN);
  int o = Long_val(vO);
  int ofsx_m = Long_val(vOFSX_M);
  int incx_m = Long_val(vINCX_M);
  int incx_n = Long_val(vINCX_N);
  int incy_m = Long_val(vINCY_M);
  int incy_n = Long_val(vINCY_N);

  FUNCTION (c, repeat) (X_data, Y_data, m, n, o, ofsx_m, incx_m, incx_n, incy_m, incy_n);

  return Val_unit;
}


CAMLprim value FUNCTION (stub, repeat_byte) (value * argv, int argn) {
  return FUNCTION (stub, repeat_native) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7],
    argv[8], argv[9]
  );

  return Val_unit;
}


#endif /* OWL_ENABLE_TEMPLATE */
