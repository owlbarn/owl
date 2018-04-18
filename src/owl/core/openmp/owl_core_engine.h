/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifndef OWL_CORE_ENGINE_H
#define OWL_CORE_ENGINE_H


// threshold of the ndarray size to trigger openmp
#define OWL_OPENMP_THRESHOLD 100000


#ifdef _OPENMP
  // choose OpenMP engine
  #define OWL_NDARRAY_MATHS_CMP  "owl_ndarray_maths_cmp_omp.h"
  #define OWL_NDARRAY_MATHS_MAP  "owl_ndarray_maths_map_omp.h"
  #define OWL_NDARRAY_MATHS_FOLD "owl_ndarray_maths_fold_omp.h"

#else
  // choose CPU engine
  #define OWL_NDARRAY_MATHS_CMP  "owl_ndarray_maths_cmp.h"
  #define OWL_NDARRAY_MATHS_MAP  "owl_ndarray_maths_map.h"
  #define OWL_NDARRAY_MATHS_FOLD "owl_ndarray_maths_fold.h"

#endif  /* _OPENMP */


#endif  /* OWL_CORE_ENGINE_H */
