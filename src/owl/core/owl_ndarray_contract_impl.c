/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


/******** contract one tensor ********/

void FUNCTION (c, contract_one_1) (struct contract_pair *p) {
  TYPE *x = (TYPE *) p->x;
  TYPE *y = (TYPE *) p->y;
  int d = p->dim - 2;
  int n = p->n[d];
  int posx = p->posx + p->ofsx[d];
  int posy = p->posy + p->ofsy[d];
  int incx = p->incx[d] + p->incx[d + 1];

  for (int i = 0; i < n; i++) {
    MAPFUN (*(x + posx), *(y + posy));
    posx += incx;
  }
}


// contract one ndarray
void FUNCTION (c, contract_one) (struct contract_pair *p) {
  if (p->dep == p->dim - 2)
    FUNCTION (c, contract_one_1) (p);
  else {
    int d = p->dep;
    int n = p->n[d];
    int incx = p->incx[d];
    int incy = p->incy[d];
    int save_posx = p->posx;
    int save_posy = p->posy;
    p->posx += p->ofsx[d];
    p->posy += p->ofsy[d];

    if (p->dep < p->drt) {
      // outer loop
      for (int i = 0; i < n; i++) {
        p->dep += 1;
        FUNCTION (c, contract_one) (p);
        p->dep -= 1;
        p->posx += incx;
        p->posy += incy;
      }
    }
    else {
      // inner loop
      incx += p->incx[d + 1];
      for (int i = 0; i < n; i++) {
        p->dep += 2;
        FUNCTION (c, contract_one) (p);
        p->dep -= 2;
        p->posx += incx;
      }
    }

    p->posx = save_posx;
    p->posy = save_posy;
  }
}


// stub function of contract_one
value FUNCTION (stub, contract_one) (value vX, value vY, value vA, value vB, value vN) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *Y_data = (TYPE *) Y->data;

  struct caml_ba_array *A = Caml_ba_array_val(vA);
  int *incx = (int *) A->data;

  struct caml_ba_array *B = Caml_ba_array_val(vB);
  int *incy = (int *) B->data;

  int N = Int32_val(vN);

  struct contract_pair * sp = calloc(1, sizeof(struct contract_pair));
  sp->dim = X->num_dims;
  sp->dep = 0;
  sp->drt = N;
  sp->n = X->dim;
  sp->x = X_data;
  sp->y = Y_data;
  sp->posx = 0;
  sp->posy = 0;
  sp->ofsx = calloc(sp->dim, sizeof(int));
  sp->ofsy = calloc(sp->dim, sizeof(int));
  sp->incx = incx;
  sp->incy = incy;

  FUNCTION (c, contract_one) (sp);

  free(sp->ofsx);
  free(sp->ofsy);
  free(sp);

  return Val_unit;
}


/******** contract two tensors ********/

void FUNCTION (c, contract_two_1) (struct contract_pair *p) {
  TYPE *x = (TYPE *) p->x;
  TYPE *y = (TYPE *) p->y;
  TYPE *z = (TYPE *) p->z;
  int d = p->dim - 1;
  int n = p->n[d];
  int posx = p->posx + p->ofsx[d];
  int posy = p->posy + p->ofsy[d];
  int posz = p->posz + p->ofsz[d];
  int incx = p->incx[d];
  int incy = p->incy[d];
  int incz = p->incz[d];

  for (int i = 0; i < n; i++) {
    *(x + posx) += *(y + posy) * *(z + posz);
    posx += incx;
    posy += incy;
    posz += incz;
  }
}


// contract two ndarrays
void FUNCTION (c, contract_two) (struct contract_pair *p) {
  if (p->dep == p->dim - 1)
    FUNCTION (c, contract_two_1) (p);
  else {
    int d = p->dep;
    int n = p->n[d];
    int incx = p->incx[d];
    int incy = p->incy[d];
    int incz = p->incz[d];
    int save_posx = p->posx;
    int save_posy = p->posy;
    int save_posz = p->posz;
    p->posx += p->ofsx[d];
    p->posy += p->ofsy[d];
    p->posz += p->ofsz[d];

    for (int i = 0; i < n; i++) {
      p->dep += 1;
      FUNCTION (c, contract_two) (p);
      p->dep -= 1;
      p->posx += incx;
      p->posy += incy;
      p->posz += incz;
    }

    p->posx = save_posx;
    p->posy = save_posy;
    p->posz = save_posz;
  }
}


// stub function of contract_one
value FUNCTION (stub, contract_two) (
  value vX, value vY, value vZ,
  value vA, value vB, value vC,
  value vD, value vN
  ) {
  CAMLparam3(vX, vY, vZ);
  CAMLxparam3(vA, vB, vC);
  CAMLxparam2(vD, vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *Y_data = (TYPE *) Y->data;

  struct caml_ba_array *Z = Caml_ba_array_val(vZ);
  TYPE *Z_data = (TYPE *) Z->data;

  struct caml_ba_array *A = Caml_ba_array_val(vA);
  int *incx = (int *) A->data;

  struct caml_ba_array *B = Caml_ba_array_val(vB);
  int *incy = (int *) B->data;

  struct caml_ba_array *C = Caml_ba_array_val(vC);
  int *incz = (int *) C->data;

  struct caml_ba_array *D = Caml_ba_array_val(vD);
  long *loops = (long *) D->data;

  int dim = Int32_val(vN);

  struct contract_pair * sp = calloc(1, sizeof(struct contract_pair));
  sp->dim = dim;
  sp->dep = 0;
  sp->n = loops;
  sp->x = X_data;
  sp->y = Y_data;
  sp->z = Z_data;
  sp->posx = 0;
  sp->posy = 0;
  sp->posz = 0;
  sp->ofsx = calloc(sp->dim, sizeof(int));
  sp->ofsy = calloc(sp->dim, sizeof(int));
  sp->ofsz = calloc(sp->dim, sizeof(int));
  sp->incx = incx;
  sp->incy = incy;
  sp->incz = incz;

  FUNCTION (c, contract_two) (sp);

  free(sp->ofsx);
  free(sp->ofsy);
  free(sp->ofsz);
  free(sp);

  return Val_unit;
}


value FUNCTION (stub, contract_two_byte) (value * argv, int __unused_argn) {
  return FUNCTION (stub, contract_two) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7]
  );
}


#endif /* OWL_ENABLE_TEMPLATE */
