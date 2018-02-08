(* Owl's unit test module *)

let () =
  Alcotest.run "Owl" [
    "stats",                Unit_stats.test_set;
    "maths",                Unit_maths.test_set;
    "algodiff diff",        Unit_algodiff_diff.test_set;
    "algodiff grad",        Unit_algodiff_grad.test_set;
    "dense matrix",         Unit_dense_matrix.test_set;
    "dense ndarray",        Unit_dense_ndarray.test_set;
    "sparse matrix",        Unit_sparse_matrix.test_set;
    "sparse ndarray",       Unit_sparse_ndarray.test_set;
    "ndarray primitive",    Unit_ndarray_primitive.test_set;
    "lazy evaluation",      Unit_lazy.test_set;
    "linear algebra",       Unit_linalg.test_set;
    "slicing basic",        Unit_slicing_basic.test_set;
    "slicing fancy",        Unit_slicing_fancy.test_set;
    "pooling2d",            Unit_pool2d.test_set;
    "pooling3d",            Unit_pool3d.test_set;
    "conv2d",               Unit_conv2d.test_set;
    "conv3d",               Unit_conv3d.test_set;
    "base: algodiff diff",  Unit_base_algodiff_diff.test_set;
    "base: algodiff grad",  Unit_base_algodiff_grad.test_set;
    "base: slicing basic",  Unit_base_slicing_basic.test_set;
    "base: pooling2d",      Unit_base_pool2d.test_set;
    "base: pooling3d",      Unit_base_pool3d.test_set;
    "base: conv2d",         Unit_base_conv2d.test_set;
    "base: conv3d",         Unit_base_conv3d.test_set;
  ]
