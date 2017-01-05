/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifdef __cplusplus
extern "C"
{
#endif


  /**************************** SparseMatrix_D ****************************/

  struct c_spmat_d {};

  struct c_spmat_d* c_eigen_spmat_d_new(int rows, int cols);
  void c_eigen_spmat_d_delete(struct c_spmat_d *m);
  struct c_spmat_d* c_eigen_spmat_d_eye(int m);
  int c_eigen_spmat_d_rows(struct c_spmat_d *m);
  int c_eigen_spmat_d_cols(struct c_spmat_d *m);
  int c_eigen_spmat_d_nnz(struct c_spmat_d *m);
  double c_eigen_spmat_d_get(struct c_spmat_d *m, int i, int j);
  void c_eigen_spmat_d_set(struct c_spmat_d *m, int i, int j, double x);
  void c_eigen_spmat_d_reset(struct c_spmat_d *m);
  int c_eigen_spmat_d_is_compressed(struct c_spmat_d *m);
  void c_eigen_spmat_d_compress(struct c_spmat_d *m);
  void c_eigen_spmat_d_uncompress(struct c_spmat_d *m);
  void c_eigen_spmat_d_reshape(struct c_spmat_d *m, int rows, int cols);
  struct c_spmat_d* c_eigen_spmat_d_clone(struct c_spmat_d *m);
  struct c_spmat_d* c_eigen_spmat_d_row(struct c_spmat_d *m, int i);
  struct c_spmat_d* c_eigen_spmat_d_transpose(struct c_spmat_d *m);
  void c_eigen_spmat_d_print(struct c_spmat_d *m);

#ifdef __cplusplus
} // end extern "C"
#endif
