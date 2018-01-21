/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


// transpose x(m,n) and save to y(n,m)
void FUNCTION (c, fancy) (struct fancy_pair *p) {
}


// stub function
value FUNCTION (stub, fancy) (value vX, value vY) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *Y_data = (TYPE *) Y->data;

  MAPFUN (X_data, Y_data);

  return Val_unit;
}


#endif /* OWL_ENABLE_TEMPLATE */
