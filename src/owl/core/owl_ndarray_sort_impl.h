/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifndef OWL_CORE_ARGSORT_IMPL
#define OWL_CORE_ARGSORT_IMPL


#include <assert.h>

#define SWAPINIT(a, es) swaptype = ((char *)a - (char *)0) % sizeof(long) || \
	es % sizeof(long) ? 2 : es == sizeof(long)? 0 : 1;

#define vecswap(a, b, n) if ((n) > 0) swapfunc((a), (b), (size_t)(n), swaptype)

#define swap(a, b)                                \
  if (swaptype == 0) {                            \
    long t = *(long *)(void *)(a);                \
		*(long *)(void *)(a) = *(long *)(void *)(b);  \
		*(long *)(void *)(b) = t;                     \
  } else                                          \
    swapfunc(a, b, es, swaptype)

static OWL_INLINE void swapfunc(char *a, char *b, size_t n, int swaptype) {
	if (swaptype <= 1)
		SWAPCODE(long, a, b, n)
	else
		SWAPCODE(char, a, b, n)
}

static OWL_INLINE char *med3(char *a, char *b, char *c, char *z,
  int (*cmp)(const void *, const void *, const void *)) {

	return cmp(a, b, z) < 0 ?
	       (cmp(b, c, z) < 0 ? b : (cmp(a, c, z) < 0 ? c : a ))
              :(cmp(b, c, z) > 0 ? b : (cmp(a, c, z) < 0 ? a : c ));
}

void owl_qsort_r(void *a, size_t n, size_t es, void *z,
  int (*cmp)(const void *, const void *, const void *)) {

	char *pa, *pb, *pc, *pd, *pl, *pm, *pn;
	size_t d, r, s;
	int swaptype, cmp_result;

	assert((a != NULL || n == 0 || es == 0) && (cmp != NULL));

loop:	SWAPINIT(a, es);
	if (n < 7) {
		for (pm = (char *) a + es; pm < (char *) a + n * es; pm += es)
			for (pl = pm; pl > (char *) a && cmp(pl - es, pl, z) > 0; pl -= es)
				swap(pl, pl - es);
		return;
	}
	pm = (char *) a + (n / 2) * es;
	if (n > 7) {
		pl = (char *) a;
		pn = (char *) a + (n - 1) * es;
		if (n > 40) {
			d = (n / 8) * es;
			pl = med3(pl, pl + d, pl + 2 * d, z, cmp);
			pm = med3(pm - d, pm, pm + d, z, cmp);
			pn = med3(pn - 2 * d, pn - d, pn, z, cmp);
		}
		pm = med3(pl, pm, pn, z, cmp);
	}
	swap(a, pm);
	pa = pb = (char *) a + es;

	pc = pd = (char *) a + (n - 1) * es;
	for (;;) {
		while (pb <= pc && (cmp_result = cmp(pb, a, z)) <= 0) {
			if (cmp_result == 0) {
				swap(pa, pb);
				pa += es;
			}
			pb += es;
		}
		while (pb <= pc && (cmp_result = cmp(pc, a, z)) >= 0) {
			if (cmp_result == 0) {
				swap(pc, pd);
				pd -= es;
			}
			pc -= es;
		}
		if (pb > pc)
			break;
		swap(pb, pc);
		pb += es;
		pc -= es;
	}

	pn = (char *) a + n * es;
	r = OWL_MIN(pa - (char *) a, pb - pa);
	vecswap(a, pb - r, r);
	r = OWL_MIN((size_t)(pd - pc), pn - pd - es);
	vecswap(pb, pn - r, r);

	r = pb - pa;
	s = pd - pc;
	if (r < s) {
		if (s > es) {
			if (r > es)
				owl_qsort_r(a, r / es, es, z, cmp);
			a = pn - s;
			n = s / es;
			goto loop;
		}
	} else {
		if (r > es) {
			if (s > es)
				owl_qsort_r(pn - s, s / es, es, z, cmp);
			n = r / es;
			goto loop;
		}
	}
}


#endif /* OWL_CORE_ARGSORT_IMPL */



#ifdef OWL_ENABLE_TEMPLATE


CAMLprim value FUNCTION (stub, sort) (value vN, value vX)
{
  CAMLparam2(vN, vX);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  caml_release_runtime_system();  /* Allow other threads */

  qsort(X_data, N, sizeof(TYPE), CMPFN1);

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}


CAMLprim value FUNCTION (stub, argsort) (value vN, value vX, value vY)
{
  CAMLparam2(vN, vX);
  int N = Long_val(vN);

  struct caml_ba_array *X = Caml_ba_array_val(vX);
  TYPE *X_data = (TYPE *) X->data;

  struct caml_ba_array *Y = Caml_ba_array_val(vY);
  int64_t *Y_data = (int64_t *) Y->data;

  caml_release_runtime_system();  /* Allow other threads */

  owl_qsort_r(Y_data, N, sizeof(int64_t), X_data, CMPFN2);

  caml_acquire_runtime_system();  /* Disallow other threads */

  CAMLreturn(Val_unit);
}


#endif /* OWL_ENABLE_TEMPLATE */
