/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


// stub function for pmap
value FUNCTION (stub, pmap) (value vF, value vX, value vY) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *Y_data = (TYPE *) Y->data;

  int N = c_ndarray_numel(X);

  for (int i = 0; i < N; i++) {
    //*(Y_data + i) = caml_callback(vF, *(X_data + i));
    printf("i:%i start\n", i);
    caml_callback(vF, caml_copy_double(*(X_data + i)));
    printf("i:%i end\n", i);
  }

  return Val_unit;
}


#endif /* OWL_ENABLE_TEMPLATE */
