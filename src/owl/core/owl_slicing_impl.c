/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef OWL_ENABLE_TEMPLATE


void FUNCTION (ndarray_slicing_1) (struct slice_pair *p) {
  TYPE *x = (TYPE *) p->x;
  TYPE *y = (TYPE *) p->y;
  int d = p->dim - 1;
  int n = p->n[d];
  int posx = p->posx + p->ofsx[d];
  int posy = p->posy + p->ofsy[d];
  int incx = p->incx[d];
  int incy = p->incy[d];

  for (int i = 0; i < n; i++) {
    *(y + posy) = *(x + posx);
    posx += incx;
    posy += incy;
  }
}


void FUNCTION (ndarray_slicing_2) (struct slice_pair *p) {
    TYPE *x = (TYPE *) p->x;
    TYPE *y = (TYPE *) p->y;
    int d0 = p->dim - 2;
    int d1 = p->dim - 1;
    int n0 = p->n[d0];
    int n1 = p->n[d1];
    int ofsx0 = p->ofsx[d0];
    int ofsy0 = p->ofsy[d0];
    int incx0 = p->incx[d0];
    int incy0 = p->incy[d0];
    int ofsx1 = p->ofsx[d1];
    int ofsy1 = p->ofsy[d1];
    int incx1 = p->incx[d1];
    int incy1 = p->incy[d1];

    int posx0 = p->posx + ofsx0;
    int posy0 = p->posy + ofsy0;
    int posx1;
    int posy1;

    for (int i0 = 0; i0 < n0; i0++) {
      posx1 = posx0 + ofsx1;
      posy1 = posy0 + ofsy1;

      for (int i1 = 0; i1 < n1; i1++) {
        *(y + posy1) = *(x + posx1);
        posx1 += incx1;
        posy1 += incy1;
      }

      posx0 += incx0;
      posy0 += incy0;
    }
}


void FUNCTION (ndarray_slicing_3) (struct slice_pair *p) {
  TYPE *x = (TYPE *) p->x;
  TYPE *y = (TYPE *) p->y;
  int d0 = p->dim - 3;
  int d1 = p->dim - 2;
  int d2 = p->dim - 1;
  int n0 = p->n[d0];
  int n1 = p->n[d1];
  int n2 = p->n[d2];
  int ofsx0 = p->ofsx[d0];
  int ofsy0 = p->ofsy[d0];
  int incx0 = p->incx[d0];
  int incy0 = p->incy[d0];
  int ofsx1 = p->ofsx[d1];
  int ofsy1 = p->ofsy[d1];
  int incx1 = p->incx[d1];
  int incy1 = p->incy[d1];
  int ofsx2 = p->ofsx[d2];
  int ofsy2 = p->ofsy[d2];
  int incx2 = p->incx[d2];
  int incy2 = p->incy[d2];

  int posx0 = p->posx + ofsx0;
  int posy0 = p->posy + ofsy0;
  int posx1;
  int posy1;
  int posx2;
  int posy2;

  for (int i0 = 0; i0 < n0; i0++) {
    posx1 = posx0 + ofsx1;
    posy1 = posy0 + ofsy1;

    for (int i1 = 0; i1 < n1; i1++) {
      posx2 = posx1 + ofsx2;
      posy2 = posy1 + ofsy2;

      for (int i2 = 0; i2 < n2; i2++) {
        *(y + posy2) = *(x + posx2);
        posx2 += incx2;
        posy2 += incy2;
      }

      posx1 += incx1;
      posy1 += incy1;
    }

    posx0 += incx0;
    posy0 += incy0;
  }
}


void FUNCTION (ndarray_slicing_4) (struct slice_pair *p) {
  TYPE *x = (TYPE *) p->x;
  TYPE *y = (TYPE *) p->y;
  int d0 = p->dim - 4;
  int d1 = p->dim - 3;
  int d2 = p->dim - 2;
  int d3 = p->dim - 1;
  int n0 = p->n[d0];
  int n1 = p->n[d1];
  int n2 = p->n[d2];
  int n3 = p->n[d3];
  int ofsx0 = p->ofsx[d0];
  int ofsy0 = p->ofsy[d0];
  int incx0 = p->incx[d0];
  int incy0 = p->incy[d0];
  int ofsx1 = p->ofsx[d1];
  int ofsy1 = p->ofsy[d1];
  int incx1 = p->incx[d1];
  int incy1 = p->incy[d1];
  int ofsx2 = p->ofsx[d2];
  int ofsy2 = p->ofsy[d2];
  int incx2 = p->incx[d2];
  int incy2 = p->incy[d2];
  int ofsx3 = p->ofsx[d3];
  int ofsy3 = p->ofsy[d3];
  int incx3 = p->incx[d3];
  int incy3 = p->incy[d3];

  int posx0 = p->posx + ofsx0;
  int posy0 = p->posy + ofsy0;
  int posx1;
  int posy1;
  int posx2;
  int posy2;
  int posx3;
  int posy3;

  for (int i0 = 0; i0 < n0; i0++) {
    posx1 = posx0 + ofsx1;
    posy1 = posy0 + ofsy1;

    for (int i1 = 0; i1 < n1; i1++) {
      posx2 = posx1 + ofsx2;
      posy2 = posy1 + ofsy2;

      for (int i2 = 0; i2 < n2; i2++) {
        posx3 = posx2 + ofsx3;
        posy3 = posy2 + ofsy3;

        for (int i3 = 0; i3 < n3; i3++) {
          *(y + posy3) = *(x + posx3);
          posx3 += incx3;
          posy3 += incy3;
        }

        posx2 += incx2;
        posy2 += incy2;
      }

      posx1 += incx1;
      posy1 += incy1;
    }

    posx0 += incx0;
    posy0 += incy0;
  }
}


// slice x based on the slice definition and save to y.
void FUNCTION (ndarray_slicing) (struct slice_pair *p) {

  if (p->dep == p->dim - 1)
    FUNCTION (ndarray_slicing_1) (p);
  else if (p->dep == p->dim - 2)
    FUNCTION (ndarray_slicing_2) (p);
  else if (p->dep == p->dim - 3)
    FUNCTION (ndarray_slicing_3) (p);
  else if (p->dep == p->dim - 4)
    FUNCTION (ndarray_slicing_4) (p);
  else {
    const int d = p->dep;
    const int save_posx = p->posx;
    const int save_posy = p->posy;
    p->posx += p->ofsx[d];
    p->posy += p->ofsy[d];

    for (int i = 0; i < p->n[d]; i++) {
      p->dep += 1;
      FUNCTION (ndarray_slicing) (p);
      p->dep -= 1;
      p->posx += p->incx[d];
      p->posy += p->incy[d];
    }

    p->posx = save_posx;
    p->posy = save_posy;
  }
}


#endif /* OWL_ENABLE_TEMPLATE */
