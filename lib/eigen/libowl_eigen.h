
#ifdef __cplusplus
extern "C"
{
#endif

  // Eigen::SparseMatrix_d
  struct eigen_spmat_d {};

  struct eigen_spmat_d* c_eigen_spmat_d_new(int rows, int cols);
  int c_eigen_spmat_d_rows(struct eigen_spmat_d *m);
  int c_eigen_spmat_d_cols(struct eigen_spmat_d *m);

#ifdef __cplusplus
} // end extern "C"
#endif
