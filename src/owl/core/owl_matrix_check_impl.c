/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


// stub function for is_triu
value FUNCTION (stub, is_triu) (value vX) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  int m = X->dim[0];
  int n = X->dim[1];
  int k = m < n ? m : n;
  int ofsx = 0;

  for (int i = 0; i < k; i++) {
    for (int j = 0; j < i; j++) {
      if ( *(X_data + ofsx + j) != 0 )
        return Val_bool(0);
    }
    ofsx += n;
  }

  return Val_bool(1);
}


// stub function for is_triu
value FUNCTION (stub, is_tril) (value vX) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  int m = X->dim[0];
  int n = X->dim[1];
  int k = m < n ? m : n;
  int ofsx = 0;

  for (int i = 0; i < k; i++) {
    for (int j = i + 1; j < k; j++) {
      if ( *(X_data + ofsx + j) != 0 )
        return Val_bool(0);
    }
    ofsx += n;
  }

  return Val_bool(1);
}


// stub function for is_diag
value FUNCTION (stub, is_diag) (value vX) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  int m = X->dim[0];
  int n = X->dim[1];
  int ofsx = 0;

  for (int i = 0; i < m; i++) {
    for (int j = 0; j < n; j++) {
      if ( *(X_data + ofsx + j) != 0 ) {
        if (i != j)
          return Val_bool(0);
      }
    }
    ofsx += n;
  }

  return Val_bool(1);
}


// stub function for is_symmetric
value FUNCTION (stub, is_symmetric) (value vX) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  int m = X->dim[0];
  int n = X->dim[1];

  if (m != n) {
    return Val_bool(0);
  }
  else if (m == 1) {
    return Val_bool(1);
  }
  else {
    TYPE *x = X_data;
    TYPE *y = X_data;
    TYPE *ofsx = X_data + 1;
    TYPE *ofsy = X_data + n;

    for (int i = 0; i < n; i++) {
      x = ofsx;
      y = ofsy;
      for (int j = i + 1; j < n; j++) {
        if ( *x != *y )
          return Val_bool(0);
        x += 1;
        y += n;
      }
      ofsx += n + 1;
      ofsy += n + 1;
    }

    return Val_bool(1);
  }
}


#endif /* OWL_ENABLE_TEMPLATE */
