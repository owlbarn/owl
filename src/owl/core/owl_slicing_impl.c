/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


// slice x based on the slice definition and save to y.
void FUNCTION (ndarray_slicing) (struct slice_pair *p) {
  const int d = p->dep;
  const int _posx = p->posx;
  const int _posy = p->posy;
  p->posx += p->ofsx[d];
  p->posy += p->ofsy[d];

  if (d == p->dim - 1) {
    for (int i = 0; i < p->n[d]; i++) {
      //printf("i:%i dep:%i n:%li posx:%i ofsx:%i incx:%i posy:%i ofsy:%i incy:%i\n",
      //  i, p->dep, p->n[d], p->posx, p->ofsx[d], p->incx[d], p->posy, p->ofsy[d], p->incy[d]);
      *(((TYPE *) p->y) + p->posy) = *(((TYPE *) p->x) + p->posx);
      p->posx += p->incx[d];
      p->posy += p->incy[d];
    }
  }
  else {
    for (int i = 0; i < p->n[d]; i++) {
      p->dep += 1;
      FUNCTION (ndarray_slicing) (p);
      p->dep -= 1;
      p->posx += p->incx[d];
      p->posy += p->incy[d];
    }
  }

  p->posx = _posx;
  p->posy = _posy;
}


void FUNCTION (ndarray_slicing_1) (struct slice_pair *p) {
  TYPE *x = (TYPE *) p->x;
  TYPE *y = (TYPE *) p->y;
  int d = p->dim - 1;
  int n = p->n[d];
  int posx = p->posx + p->ofsx[d];
  int posy = p->posy + p->ofsy[d];
  int incx = p->incx[d];
  int incy = p->incy[d]

  for (int i = 0; i < n; i++) {
    *(y + posy) = *(x + posx);
    posx += incx;
    posy += incy;
  }
}


void FUNCTION (ndarray_slicing_2) (struct slice_pair *p) {

}


void FUNCTION (ndarray_slicing_3) (struct slice_pair *p) {

}


#endif /* OWL_ENABLE_TEMPLATE */
