/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


// transpose a ndarray, i.e. permute the axis
void FUNCTION (c, transpose) (struct slice_pair *p) {
  if (p->dep == p->dim - 1)
    FUNCTION (c, transpose_1) (p);
  else {
    const int d = p->dep;
    const int n = p->n[d];
    const int incx = p->incx[d];
    const int incy = p->incy[d];
    const int save_posx = p->posx;
    const int save_posy = p->posy;
    p->posx += p->ofsx[d];
    p->posy += p->ofsy[d];

    for (int i = 0; i < n; i++) {
      p->dep += 1;
      FUNCTION (c, slice) (p);
      p->dep -= 1;
      p->posx += incx;
      p->posy += incy;
    }

    p->posx = save_posx;
    p->posy = save_posy;
  }
}


// stub function of transpose
value FUNCTION (stub, transpose) (struct slice_pair *p) {

  return Val_unit;
}


#endif /* OWL_ENABLE_TEMPLATE */
