/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


/******** contract one tensor ********/

void FUNCTION (c, contract_one_1) (struct contract_pair *p) {
  TYPE *x = (TYPE *) p->x;
  TYPE *y = (TYPE *) p->y;
  long d = p->dim - 2;
  long n = p->n[d];
  long posx = p->posx + p->ofsx[d];
  long posy = p->posy + p->ofsy[d];
  long incx = p->incx[d] + p->incx[d + 1];

  for (long i = 0; i < n; i++) {
    MAPFUN (*(x + posx), *(y + posy));
    posx += incx;
  }
}


// contract one ndarray
void FUNCTION (c, contract_one) (struct contract_pair *p) {
  if (p->dep == p->dim - 2)
    FUNCTION (c, contract_one_1) (p);
  else {
    long d = p->dep;
    long n = p->n[d];
    long incx = p->incx[d];
    long incy = p->incy[d];
    long save_posx = p->posx;
    long save_posy = p->posy;
    p->posx += p->ofsx[d];
    p->posy += p->ofsy[d];

    if (p->dep < p->drt) {
      // outer loop
      for (long i = 0; i < n; i++) {
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
      for (long i = 0; i < n; i++) {
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
CAMLprim value FUNCTION (stub, contract_one) (value vX, value vY, value vA, value vB, value vN) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *Y_data = (TYPE *) Y->data;

  struct caml_ba_array *A = Caml_ba_array_val(vA);
  long *incx = (long *) A->data;

  struct caml_ba_array *B = Caml_ba_array_val(vB);
  long *incy = (long *) B->data;

  long N = Int64_val(vN);

  struct contract_pair * cp = calloc(1, sizeof(struct contract_pair));
  cp->dim = X->num_dims;
  cp->dep = 0;
  cp->drt = N;
  cp->n = X->dim;
  cp->x = X_data;
  cp->y = Y_data;
  cp->posx = 0;
  cp->posy = 0;
  cp->ofsx = calloc(cp->dim, sizeof(long));
  cp->ofsy = calloc(cp->dim, sizeof(long));
  cp->incx = incx;
  cp->incy = incy;

  FUNCTION (c, contract_one) (cp);

  free(cp->ofsx);
  free(cp->ofsy);
  free(cp);

  return Val_unit;
}


/******** contract two tensors ********/

void FUNCTION (c, contract_two_1) (struct contract_pair *p) {
  TYPE *x = (TYPE *) p->x;
  TYPE *y = (TYPE *) p->y;
  TYPE *z = (TYPE *) p->z;
  long d = p->dim - 1;
  long n = p->n[d];
  long posx = p->posx + p->ofsx[d];
  long posy = p->posy + p->ofsy[d];
  long posz = p->posz + p->ofsz[d];
  long incx = p->incx[d];
  long incy = p->incy[d];
  long incz = p->incz[d];

  for (long i = 0; i < n; i++) {
    *(z + posz) += *(x + posx) * *(y + posy);
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
    long d = p->dep;
    long n = p->n[d];
    long incx = p->incx[d];
    long incy = p->incy[d];
    long incz = p->incz[d];
    long save_posx = p->posx;
    long save_posy = p->posy;
    long save_posz = p->posz;
    p->posx += p->ofsx[d];
    p->posy += p->ofsy[d];
    p->posz += p->ofsz[d];

    for (long i = 0; i < n; i++) {
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


// stub function of contract_two
CAMLprim value FUNCTION (stub, contract_two) (
  value vX, value vY, value vZ,
  value vA, value vB, value vC,
  value vD, value vN
  ) {
  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  TYPE *Y_data = (TYPE *) Y->data;

  struct caml_ba_array *Z = Caml_ba_array_val(vZ);
  TYPE *Z_data = (TYPE *) Z->data;

  struct caml_ba_array *A = Caml_ba_array_val(vA);
  long *incx = (long *) A->data;

  struct caml_ba_array *B = Caml_ba_array_val(vB);
  long *incy = (long *) B->data;

  struct caml_ba_array *C = Caml_ba_array_val(vC);
  long *incz = (long *) C->data;

  struct caml_ba_array *D = Caml_ba_array_val(vD);
  long *loops = (long *) D->data;

  long dim = Int64_val(vN);

  struct contract_pair * cp = calloc(1, sizeof(struct contract_pair));
  cp->dim = dim;
  cp->dep = 0;
  cp->n = loops;
  cp->x = X_data;
  cp->y = Y_data;
  cp->z = Z_data;
  cp->posx = 0;
  cp->posy = 0;
  cp->posz = 0;
  cp->ofsx = calloc(cp->dim, sizeof(long));
  cp->ofsy = calloc(cp->dim, sizeof(long));
  cp->ofsz = calloc(cp->dim, sizeof(long));
  cp->incx = incx;
  cp->incy = incy;
  cp->incz = incz;

  FUNCTION (c, contract_two) (cp);

  free(cp->ofsx);
  free(cp->ofsy);
  free(cp->ofsz);
  free(cp);

  return Val_unit;
}


CAMLprim value FUNCTION (stub, contract_two_byte) (value * argv, int __unused_argn) {
  return FUNCTION (stub, contract_two) (
    argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7]
  );
}


#endif /* OWL_ENABLE_TEMPLATE */
