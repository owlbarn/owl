/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


// transpose x(m,n) and save to y(n,m)
void FUNCTION (matrix_transpose) (TYPE * x, TYPE * y, int m, int n) {
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


#endif /* OWL_ENABLE_TEMPLATE */
