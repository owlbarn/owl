/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


// Level 1 optimisation
void FUNCTION (c, transpose_1) (struct slice_pair *p) {
  TYPE *x = (TYPE *) p->x;
  TYPE *y = (TYPE *) p->y;
  int d = p->dim - 1;
  int n = p->n[d];
  int posx = p->posx + p->ofsx[d];
  int posy = p->posy + p->ofsy[d];
  int incx = p->incx[d];
  int incy = p->incy[d];

  for (int i = 0; i < n; i++) {
    printf ("posx:%i, incx:%i, posy:%i, incy:%i\n", posx, incx, posy, incy);
    MAPFUN (*(x + posx), *(y + posy));
    posx += incx;
    posy += incy;
  }
}
#include <stdio.h>
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
      FUNCTION (c, transpose) (p);
      p->dep -= 1;
      p->posx += incx;
      p->posy += incy;
    }

    p->posx = save_posx;
    p->posy = save_posy;
  }
}


// stub function of transpose
value FUNCTION (stub, transpose) (value vX, value vY, value vA, value vB) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *Y_data = (TYPE *) Y->data;

  struct caml_ba_array *A = Caml_ba_array_val(vA);
  int *incx = (int *) A->data;

  struct caml_ba_array *B = Caml_ba_array_val(vB);
  int *incy = (int *) B->data;

  struct slice_pair * sp = calloc(1, sizeof(struct slice_pair));
  sp->dim = X->num_dims;
  sp->dep = 0;
  sp->n = X->dim;
  sp->x = X_data;
  sp->y = Y_data;
  sp->posx = 0;
  sp->posy = 0;
  sp->ofsx = calloc(sp->dim, sizeof(int));
  sp->ofsy = calloc(sp->dim, sizeof(int));
  sp->incx = incx;
  sp->incy = incy;

  FUNCTION (c, transpose) (sp);

  free(sp->ofsx);
  free(sp->ofsy);
  free(sp);

  return Val_unit;
}



#endif /* OWL_ENABLE_TEMPLATE */
