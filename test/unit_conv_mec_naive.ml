(** Unit test for different Convolution implementations *)

open Owl_types

module N = Owl_dense_ndarray.S


module type CONV_IMPL = sig
  val owl_spatial_conv : ('a, 'b) Owl_dense_ndarray_generic.kind ->
    ('a, 'b) Owl_core_types.owl_arr_op22
  val owl_spatial_conv_backward_input :
    ('a, 'b) Owl_dense_ndarray_generic.kind ->
    ('a, 'b) Owl_core_types.owl_arr_op23
  val owl_spatial_conv_backward_kernel :
    ('a, 'b) Owl_dense_ndarray_generic.kind ->
    ('a, 'b) Owl_core_types.owl_arr_op23
  val owl_cuboid_conv : ('a, 'b) Owl_dense_ndarray_generic.kind ->
    ('a, 'b) Owl_core_types.owl_arr_op24
  val owl_cuboid_conv_backward_input :
    ('a, 'b) Owl_dense_ndarray_generic.kind ->
    ('a, 'b) Owl_core_types.owl_arr_op25
  val owl_cuboid_conv_backward_kernel :
    ('a, 'b) Owl_dense_ndarray_generic.kind ->
    ('a, 'b) Owl_core_types.owl_arr_op25
end


module MEC = struct
  let owl_spatial_conv = Owl_ndarray_conv._owl_spatial_conv_mec
  let owl_spatial_conv_backward_input =
    Owl_ndarray_conv._owl_spatial_conv_backward_input_mec
  let owl_spatial_conv_backward_kernel =
    Owl_ndarray_conv._owl_spatial_conv_backward_kernel_mec
  let owl_cuboid_conv = Owl_ndarray_conv._owl_cuboid_conv_mec
  let owl_cuboid_conv_backward_input =
    Owl_ndarray_conv._owl_cuboid_conv_backward_input_mec
  let owl_cuboid_conv_backward_kernel =
    Owl_ndarray_conv._owl_cuboid_conv_backward_kernel_mec
end


module NAIVE = struct
  let owl_spatial_conv = Owl_ndarray_conv._owl_spatial_conv_naive
  let owl_spatial_conv_backward_input =
    Owl_ndarray_conv._owl_spatial_conv_backward_input_naive
  let owl_spatial_conv_backward_kernel =
    Owl_ndarray_conv._owl_spatial_conv_backward_kernel_naive
  let owl_cuboid_conv = Owl_ndarray_conv._owl_cuboid_conv_naive
  let owl_cuboid_conv_backward_input =
    Owl_ndarray_conv._owl_cuboid_conv_backward_input_naive
  let owl_cuboid_conv_backward_kernel =
    Owl_ndarray_conv._owl_cuboid_conv_backward_kernel_naive
end


(** Functor to generate test module *)

module Make (I : CONV_IMPL) = struct

  include N

  let conv2d ?(padding=SAME) input kernel stride =
    let input_shp = shape input in
    let batches = input_shp.(0) in
    let input_cols = input_shp.(1) in
    let input_rows = input_shp.(2) in
    let in_channel = input_shp.(3) in

    let kernel_shp = shape kernel in
    let kernel_cols = kernel_shp.(0) in
    let kernel_rows = kernel_shp.(1) in
    let out_channel = kernel_shp.(3) in

    let col_stride = stride.(0) in
    let row_stride = stride.(1) in
    let col_in_stride = 1 in
    let row_in_stride = 1 in

    let output_cols, output_rows =
      Owl_utils_infer_shape.calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
    in
    let output = empty [|batches; output_cols; output_rows; out_channel|] in

    let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

    I.owl_spatial_conv (Owl_dense_ndarray.Generic.kind input)
      input kernel output batches input_cols input_rows in_channel
      kernel_cols kernel_rows output_cols output_rows out_channel
      row_stride col_stride pad_typ row_in_stride col_in_stride;

    output


  let conv2d_backward_input input kernel stride output' =
    let input_shp = shape input in
    let batches = input_shp.(0) in
    let input_cols = input_shp.(1) in
    let input_rows = input_shp.(2) in
    let in_channel = input_shp.(3) in

    let kernel_shp = shape kernel in
    let kernel_cols = kernel_shp.(0) in
    let kernel_rows = kernel_shp.(1) in
    let out_channel = kernel_shp.(3) in

    let output_shp = shape output' in
    let output_cols = output_shp.(1) in
    let output_rows = output_shp.(2) in

    let col_stride = stride.(0) in
    let row_stride = stride.(1) in
    let col_in_stride = 1 in
    let row_in_stride = 1 in

    let input' = empty (shape input) in

    I.owl_spatial_conv_backward_input
      (Owl_dense_ndarray.Generic.kind input')
      input' kernel output' batches input_cols input_rows in_channel
      kernel_cols kernel_rows output_cols output_rows out_channel
      row_stride col_stride row_in_stride col_in_stride;

    input'


  let conv2d_backward_kernel input kernel stride output' =
    let input_shp = shape input in
    let batches = input_shp.(0) in
    let input_cols = input_shp.(1) in
    let input_rows = input_shp.(2) in
    let in_channel = input_shp.(3) in

    let kernel_shp = shape kernel in
    let kernel_cols = kernel_shp.(0) in
    let kernel_rows = kernel_shp.(1) in
    let out_channel = kernel_shp.(3) in

    let output_shp = shape output' in
    let output_cols = output_shp.(1) in
    let output_rows = output_shp.(2) in

    let col_stride = stride.(0) in
    let row_stride = stride.(1) in
    let col_in_stride = 1 in
    let row_in_stride = 1 in

    let kernel' = empty (shape kernel) in

    I.owl_spatial_conv_backward_kernel
      (Owl_dense_ndarray.Generic.kind input)
      input kernel' output' batches input_cols input_rows in_channel
      kernel_cols kernel_rows output_cols output_rows out_channel
      row_stride col_stride row_in_stride col_in_stride;

    kernel'


  let conv3d ?(padding=SAME) input kernel stride =
    let input_shp = shape input in
    let batches = input_shp.(0) in
    let input_cols = input_shp.(1) in
    let input_rows = input_shp.(2) in
    let input_dpts = input_shp.(3) in
    let in_channel = input_shp.(4) in

    let kernel_shp = shape kernel in
    let kernel_cols = kernel_shp.(0) in
    let kernel_rows = kernel_shp.(1) in
    let kernel_dpts = kernel_shp.(2) in
    let out_channel = kernel_shp.(4) in

    let col_stride = stride.(0) in
    let row_stride = stride.(1) in
    let dpt_stride = stride.(2) in

    let output_cols, output_rows, output_dpts =
      Owl_utils_infer_shape.calc_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols kernel_rows kernel_dpts row_stride col_stride dpt_stride
    in
    let output = empty [|batches; output_cols; output_rows; output_dpts; out_channel|] in

    let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

    I.owl_cuboid_conv
      (Owl_dense_ndarray.Generic.kind input)
      input kernel output batches
      input_cols input_rows input_dpts in_channel
      kernel_cols kernel_rows kernel_dpts
      output_cols output_rows output_dpts out_channel
      dpt_stride row_stride col_stride pad_typ;

    output


  let conv3d_backward_input input kernel stride output' =
    let input_shp = shape input in
    let batches = input_shp.(0) in
    let input_cols = input_shp.(1) in
    let input_rows = input_shp.(2) in
    let input_dpts = input_shp.(3) in
    let in_channel = input_shp.(4) in

    let kernel_shp = shape kernel in
    let kernel_cols = kernel_shp.(0) in
    let kernel_rows = kernel_shp.(1) in
    let kernel_dpts = kernel_shp.(2) in
    let out_channel = kernel_shp.(4) in

    let output_shp = shape output' in
    let output_cols = output_shp.(1) in
    let output_rows = output_shp.(2) in
    let output_dpts =  output_shp.(3) in

    let col_stride = stride.(0) in
    let row_stride = stride.(1) in
    let dpt_stride = stride.(2) in

    let input' = empty (shape input) in

    I.owl_cuboid_conv_backward_input
      (Owl_dense_ndarray.Generic.kind input')
      input' kernel output' batches
      input_cols input_rows input_dpts in_channel
      kernel_cols kernel_rows kernel_dpts
      output_cols output_rows output_dpts out_channel
      dpt_stride row_stride col_stride;

    input'


  let conv3d_backward_kernel input kernel stride output' =
    let input_shp = shape input in
    let batches = input_shp.(0) in
    let input_cols = input_shp.(1) in
    let input_rows = input_shp.(2) in
    let input_dpts = input_shp.(3) in
    let in_channel = input_shp.(4) in

    let kernel_shp = shape kernel in
    let kernel_cols = kernel_shp.(0) in
    let kernel_rows = kernel_shp.(1) in
    let kernel_dpts = kernel_shp.(2) in
    let out_channel = kernel_shp.(4) in

    let output_shp = shape output' in
    let output_cols = output_shp.(1) in
    let output_rows = output_shp.(2) in
    let output_dpts =  output_shp.(3) in

    let col_stride = stride.(0) in
    let row_stride = stride.(1) in
    let dpt_stride = stride.(2) in

    let kernel' = empty (shape kernel) in

    I.owl_cuboid_conv_backward_kernel
      (Owl_dense_ndarray.Generic.kind input)
      input kernel' output' batches
      input_cols input_rows input_dpts in_channel
      kernel_cols kernel_rows kernel_dpts
      output_cols output_rows output_dpts out_channel
      dpt_stride row_stride col_stride;

    kernel'

end

(** Test memory-efficient convolution implementation *)

module TEST_MEC = Make (MEC)
module Conv2D_MEC = Unit_conv2d_generic.Make (TEST_MEC)
module Conv3D_MEC = Unit_conv3d_generic.Make (TEST_MEC)

(** Test naive convolution implementation *)

module TEST_NAIVE = Make (NAIVE)
module Conv2D_NAIVE = Unit_conv2d_generic.Make (TEST_NAIVE)
module Conv3D_NAIVE = Unit_conv3d_generic.Make (TEST_NAIVE)
