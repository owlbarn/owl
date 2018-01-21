/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


// transpose x(m,n) and save to y(n,m)
void FUNCTION (c, transpose) (TYPE *x, TYPE *y, int m, int n) {
  int ofsx = 0;
  int ofsy = 0;

  for (int i = 0; i < m; i++) {
    ofsy = i;
    for (int j = 0; j < n; j++) {
      *(y + ofsy) = *(x + ofsx);
      ofsy += m;
      ofsx += 1;
    }
  }
}


// stub function
value FUNCTION (stub, transpose) (value vX, value vY) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *Y_data = (TYPE *) Y->data;

  FUNCTION (c, transpose) (X_data, Y_data, X->dim[0], X->dim[1]);

  return Val_unit;
}


#endif /* OWL_ENABLE_TEMPLATE */
