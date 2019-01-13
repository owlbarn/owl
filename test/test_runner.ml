(* Owl's unit test module *)

let () =
  Alcotest.run "Owl" [
    "stats_rvs",            Unit_stats_rvs.test_set;
    "stats",                Unit_stats.test_set;
    "maths",                Unit_maths.test_set;
    "graph",                Unit_graph.test_set;
    "multimap",             Unit_multimap.test_set;
    "algodiff diff",        Unit_algodiff_diff.test_set;
    "algodiff grad",        Unit_algodiff_grad.test_set;
    "dense matrix",         Unit_dense_matrix.test_set;
    "dense ndarray",        Unit_dense_ndarray.test_set;
    "sparse matrix",        Unit_sparse_matrix.test_set;
    "sparse ndarray",       Unit_sparse_ndarray.test_set;
    "ndarray primitive",    Unit_ndarray_primitive.test_set;
    "ndarray core",         Unit_ndarray_core.test_set;
    "lazy evaluation",      Unit_lazy.test_set;
    "linear algebra",       Unit_linalg.test_set;
    "slicing basic",        Unit_slicing_basic.test_set;
    "slicing fancy",        Unit_slicing_fancy.test_set;
    "pooling2d",            Unit_pool2d.test_set;
    "pooling3d",            Unit_pool3d.test_set;
    "conv2d",               Unit_conv2d.test_set;
    "conv3d",               Unit_conv3d.test_set;
    "conv2d_mec",           Unit_conv_mec_naive.Conv2D_MEC.test_set;
    "conv3d_mec",           Unit_conv_mec_naive.Conv3D_MEC.test_set;
    "conv2d_naive",         Unit_conv_mec_naive.Conv2D_NAIVE.test_set;
    "conv3d_naive",         Unit_conv_mec_naive.Conv3D_NAIVE.test_set;
    "dilated_conv2d",       Unit_dilated_conv2d.test_set;
    "dilated_conv3d",       Unit_dilated_conv3d.test_set;
    "transpose_conv2d",     Unit_transpose_conv2d.test_set;
    "transpose_conv3d",     Unit_transpose_conv3d.test_set;
    "upsampling",           Unit_upsampling.test_set;
    "learning rate",        Unit_learning_rate.test_set;
    "base: algodiff diff",  Unit_base_algodiff_diff.test_set;
    "base: algodiff grad",  Unit_base_algodiff_grad.test_set;
    "base: slicing basic",  Unit_base_slicing_basic.test_set;
    "base: pooling2d",      Unit_base_pool2d.test_set;
    "base: pooling3d",      Unit_base_pool3d.test_set;
    "base: conv2d",         Unit_base_conv2d.test_set;
    "base: conv3d",         Unit_base_conv3d.test_set;
    "base: upsampling",     Unit_base_upsampling.test_set;
    "base: view",           Unit_view.test_set;
    "base: maths_root",     Unit_maths_root.test_set;
    "base: complex",        Unit_base_complex.test_set;
    "base: ndarray core",   Unit_base_ndarray_core.test_set;
    "algodiff matrix",      Unit_algodiff_matrix.test_set;
  ]
