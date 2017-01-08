/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef __cplusplus
extern "C"
{
#endif

  #define INDEX long long


  /**************************** SparseMatrix_S ****************************/

  struct c_spmat_s {};

  struct c_spmat_s* c_eigen_spmat_s_new(INDEX rows, INDEX cols);
  void c_eigen_spmat_s_delete(struct c_spmat_s *m);
  struct c_spmat_s* c_eigen_spmat_s_eye(INDEX m);
  INDEX c_eigen_spmat_s_rows(struct c_spmat_s *m);
  INDEX c_eigen_spmat_s_cols(struct c_spmat_s *m);
  INDEX c_eigen_spmat_s_nnz(struct c_spmat_s *m);
  float c_eigen_spmat_s_get(struct c_spmat_s *m, INDEX i, INDEX j);
  void c_eigen_spmat_s_set(struct c_spmat_s *m, INDEX i, INDEX j, float x);
  void c_eigen_spmat_s_reset(struct c_spmat_s *m);
  int c_eigen_spmat_s_is_compressed(struct c_spmat_s *m);
  void c_eigen_spmat_s_compress(struct c_spmat_s *m);
  void c_eigen_spmat_s_uncompress(struct c_spmat_s *m);
  void c_eigen_spmat_s_reshape(struct c_spmat_s *m, INDEX rows, INDEX cols);
  void c_eigen_spmat_s_prune(struct c_spmat_s *m, float ref, float eps);
  float* c_eigen_spmat_s_valueptr(struct c_spmat_s *m, INDEX *l);
  INDEX* c_eigen_spmat_s_innerindexptr(struct c_spmat_s *m);
  INDEX* c_eigen_spmat_s_outerindexptr(struct c_spmat_s *m);
  struct c_spmat_s* c_eigen_spmat_s_clone(struct c_spmat_s *m);
  struct c_spmat_s* c_eigen_spmat_s_row(struct c_spmat_s *m, INDEX i);
  struct c_spmat_s* c_eigen_spmat_s_col(struct c_spmat_s *m, INDEX i);
  struct c_spmat_s* c_eigen_spmat_s_transpose(struct c_spmat_s *m);
  struct c_spmat_s* c_eigen_spmat_s_adjoint(struct c_spmat_s *m);
  struct c_spmat_s* c_eigen_spmat_s_diagonal(struct c_spmat_s *m);
  float c_eigen_spmat_s_trace(struct c_spmat_s *m);
  int c_eigen_spmat_s_is_zero(struct c_spmat_s *m);
  int c_eigen_spmat_s_is_positive(struct c_spmat_s *m);
  int c_eigen_spmat_s_is_negative(struct c_spmat_s *m);
  int c_eigen_spmat_s_is_nonpositive(struct c_spmat_s *m);
  int c_eigen_spmat_s_is_nonnegative(struct c_spmat_s *m);
  int c_eigen_spmat_s_is_equal(struct c_spmat_s *m0, struct c_spmat_s *m1);
  int c_eigen_spmat_s_is_unequal(struct c_spmat_s *m0, struct c_spmat_s *m1);
  int c_eigen_spmat_s_is_greater(struct c_spmat_s *m0, struct c_spmat_s *m1);
  int c_eigen_spmat_s_is_smaller(struct c_spmat_s *m0, struct c_spmat_s *m1);
  int c_eigen_spmat_s_equal_or_greater(struct c_spmat_s *m0, struct c_spmat_s *m1);
  int c_eigen_spmat_s_equal_or_smaller(struct c_spmat_s *m0, struct c_spmat_s *m1);
  struct c_spmat_s* c_eigen_spmat_s_add(struct c_spmat_s *m0, struct c_spmat_s *m1);
  struct c_spmat_s* c_eigen_spmat_s_sub(struct c_spmat_s *m0, struct c_spmat_s *m1);
  struct c_spmat_s* c_eigen_spmat_s_mul(struct c_spmat_s *m0, struct c_spmat_s *m1);
  struct c_spmat_s* c_eigen_spmat_s_div(struct c_spmat_s *m0, struct c_spmat_s *m1);
  struct c_spmat_s* c_eigen_spmat_s_dot(struct c_spmat_s *m0, struct c_spmat_s *m1);
  struct c_spmat_s* c_eigen_spmat_s_add_scalar(struct c_spmat_s *m, float a);
  struct c_spmat_s* c_eigen_spmat_s_sub_scalar(struct c_spmat_s *m, float a);
  struct c_spmat_s* c_eigen_spmat_s_mul_scalar(struct c_spmat_s *m, float a);
  struct c_spmat_s* c_eigen_spmat_s_div_scalar(struct c_spmat_s *m, float a);
  struct c_spmat_s* c_eigen_spmat_s_min2(struct c_spmat_s *m0, struct c_spmat_s *m1);
  struct c_spmat_s* c_eigen_spmat_s_max2(struct c_spmat_s *m0, struct c_spmat_s *m1);
  float c_eigen_spmat_s_sum(struct c_spmat_s *m);
  float c_eigen_spmat_s_min(struct c_spmat_s *m);
  float c_eigen_spmat_s_max(struct c_spmat_s *m);
  struct c_spmat_s* c_eigen_spmat_s_abs(struct c_spmat_s *m);
  struct c_spmat_s* c_eigen_spmat_s_neg(struct c_spmat_s *m);
  struct c_spmat_s* c_eigen_spmat_s_sqrt(struct c_spmat_s *m);
  void c_eigen_spmat_s_print(struct c_spmat_s *m);


  /**************************** SparseMatrix_D ****************************/

  struct c_spmat_d {};

  struct c_spmat_d* c_eigen_spmat_d_new(INDEX rows, INDEX cols);
  void c_eigen_spmat_d_delete(struct c_spmat_d *m);
  struct c_spmat_d* c_eigen_spmat_d_eye(INDEX m);
  INDEX c_eigen_spmat_d_rows(struct c_spmat_d *m);
  INDEX c_eigen_spmat_d_cols(struct c_spmat_d *m);
  INDEX c_eigen_spmat_d_nnz(struct c_spmat_d *m);
  double c_eigen_spmat_d_get(struct c_spmat_d *m, INDEX i, INDEX j);
  void c_eigen_spmat_d_set(struct c_spmat_d *m, INDEX i, INDEX j, double x);
  void c_eigen_spmat_d_reset(struct c_spmat_d *m);
  int c_eigen_spmat_d_is_compressed(struct c_spmat_d *m);
  void c_eigen_spmat_d_compress(struct c_spmat_d *m);
  void c_eigen_spmat_d_uncompress(struct c_spmat_d *m);
  void c_eigen_spmat_d_reshape(struct c_spmat_d *m, INDEX rows, INDEX cols);
  void c_eigen_spmat_d_prune(struct c_spmat_d *m, double ref, double eps);
  double* c_eigen_spmat_d_valueptr(struct c_spmat_d *m, INDEX *l);
  INDEX* c_eigen_spmat_d_innerindexptr(struct c_spmat_d *m);
  INDEX* c_eigen_spmat_d_outerindexptr(struct c_spmat_d *m);
  struct c_spmat_d* c_eigen_spmat_d_clone(struct c_spmat_d *m);
  struct c_spmat_d* c_eigen_spmat_d_row(struct c_spmat_d *m, INDEX i);
  struct c_spmat_d* c_eigen_spmat_d_col(struct c_spmat_d *m, INDEX i);
  struct c_spmat_d* c_eigen_spmat_d_transpose(struct c_spmat_d *m);
  struct c_spmat_d* c_eigen_spmat_d_adjoint(struct c_spmat_d *m);
  struct c_spmat_d* c_eigen_spmat_d_diagonal(struct c_spmat_d *m);
  double c_eigen_spmat_d_trace(struct c_spmat_d *m);
  int c_eigen_spmat_d_is_zero(struct c_spmat_d *m);
  int c_eigen_spmat_d_is_positive(struct c_spmat_d *m);
  int c_eigen_spmat_d_is_negative(struct c_spmat_d *m);
  int c_eigen_spmat_d_is_nonpositive(struct c_spmat_d *m);
  int c_eigen_spmat_d_is_nonnegative(struct c_spmat_d *m);
  int c_eigen_spmat_d_is_equal(struct c_spmat_d *m0, struct c_spmat_d *m1);
  int c_eigen_spmat_d_is_unequal(struct c_spmat_d *m0, struct c_spmat_d *m1);
  int c_eigen_spmat_d_is_greater(struct c_spmat_d *m0, struct c_spmat_d *m1);
  int c_eigen_spmat_d_is_smaller(struct c_spmat_d *m0, struct c_spmat_d *m1);
  int c_eigen_spmat_d_equal_or_greater(struct c_spmat_d *m0, struct c_spmat_d *m1);
  int c_eigen_spmat_d_equal_or_smaller(struct c_spmat_d *m0, struct c_spmat_d *m1);
  struct c_spmat_d* c_eigen_spmat_d_add(struct c_spmat_d *m0, struct c_spmat_d *m1);
  struct c_spmat_d* c_eigen_spmat_d_sub(struct c_spmat_d *m0, struct c_spmat_d *m1);
  struct c_spmat_d* c_eigen_spmat_d_mul(struct c_spmat_d *m0, struct c_spmat_d *m1);
  struct c_spmat_d* c_eigen_spmat_d_div(struct c_spmat_d *m0, struct c_spmat_d *m1);
  struct c_spmat_d* c_eigen_spmat_d_dot(struct c_spmat_d *m0, struct c_spmat_d *m1);
  struct c_spmat_d* c_eigen_spmat_d_add_scalar(struct c_spmat_d *m, double a);
  struct c_spmat_d* c_eigen_spmat_d_sub_scalar(struct c_spmat_d *m, double a);
  struct c_spmat_d* c_eigen_spmat_d_mul_scalar(struct c_spmat_d *m, double a);
  struct c_spmat_d* c_eigen_spmat_d_div_scalar(struct c_spmat_d *m, double a);
  struct c_spmat_d* c_eigen_spmat_d_min2(struct c_spmat_d *m0, struct c_spmat_d *m1);
  struct c_spmat_d* c_eigen_spmat_d_max2(struct c_spmat_d *m0, struct c_spmat_d *m1);
  double c_eigen_spmat_d_sum(struct c_spmat_d *m);
  double c_eigen_spmat_d_min(struct c_spmat_d *m);
  double c_eigen_spmat_d_max(struct c_spmat_d *m);
  struct c_spmat_d* c_eigen_spmat_d_abs(struct c_spmat_d *m);
  struct c_spmat_d* c_eigen_spmat_d_neg(struct c_spmat_d *m);
  struct c_spmat_d* c_eigen_spmat_d_sqrt(struct c_spmat_d *m);
  void c_eigen_spmat_d_print(struct c_spmat_d *m);


  /**************************** SparseMatrix_C ****************************/

  struct c_spmat_c {};


  /**************************** SparseMatrix_Z ****************************/

  struct c_spmat_z {};



#ifdef __cplusplus
} // end extern "C"
#endif
