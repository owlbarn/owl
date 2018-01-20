/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


// transpose x(m,n) and save to y(n,m)
void FUNCTION (ndarray_slicing) (struct slice_pair *p) {
  int d = p->dep;

  if (d == p->dim) {
    for (int i = 0; i < p->n[d]; i++) {
      *(((TYPE *) p->y) + p->posy) = *(((TYPE *) p->x) + p->posx);
      p->posx += p->incx[d];
      p->posy += p->incy[d];
    }
  }
  else {
    for (int i = 0; i < p->n[d]; i++) {
      p->posx = p->ofsx[d];
      p->posy = p->ofsy[d];
      p->dep += 1;
      FUNCTION (ndarray_slicing) (p);
      p->posx += p->incx[d];
      p->posy += p->incy[d];
    }
  }
}


void FUNCTION (ndarray_slicing_1) (struct slice_pair *p) {

}


#endif /* OWL_ENABLE_TEMPLATE */
