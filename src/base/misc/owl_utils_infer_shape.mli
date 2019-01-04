(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


val require_broadcasting : int array -> int array -> bool

val calc_conv2d_output_shape : padding -> int -> int -> int -> int -> int -> int -> int * int

val calc_transpose_conv2d_output_shape : padding -> int -> int -> int -> int -> int -> int -> int * int

val calc_conv2d_padding : int -> int -> int -> int -> int -> int -> int -> int -> int * int * int * int

val calc_conv1d_output_shape : padding -> int -> int -> int -> int

val calc_transpose_conv1d_output_shape : padding -> int -> int -> int -> int

val calc_conv3d_output_shape : padding -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int * int * int

val calc_transpose_conv3d_output_shape : padding -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int * int * int

val calc_conv3d_padding : int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int * int * int * int * int * int

val broadcast1 : int array -> int array -> int array

val broadcast2 : int array -> int array -> int array -> int array

val broadcast1_stride : int array -> int array -> int array * int array

val fold : int array -> int -> int array

val tile : int array -> int array -> int array

val repeat : int array -> int array -> int array

val concatenate : int array array -> int -> int array

val split : int array -> int -> int array -> int array array

val draw : 'a array -> int -> 'a -> 'a array

val reduce : int array -> int array -> int array

val conv2d : int array -> padding -> int array -> int array -> int array

val conv1d : int array -> padding -> int array -> int array -> int array

val conv3d : int array -> padding -> int array -> int array -> int array

val dilated_conv2d : int array -> padding -> int array -> int array -> int array -> int array

val dilated_conv1d : int array -> padding -> int array -> int array -> int array -> int array

val dilated_conv3d : int array -> padding -> int array -> int array -> int array -> int array

val transpose_conv2d : int array -> padding -> int array -> int array -> int array

val transpose_conv1d : int array -> padding -> int array -> int array -> int array

val transpose_conv3d : int array -> padding -> int array -> int array -> int array

val pool2d : int array -> padding -> int array -> int array -> int array

val upsampling2d : int array -> int array -> int array

val transpose : 'a array -> int array -> 'a array

val dot : 'a array -> 'a array -> 'a array

val onehot : 'a array -> 'a -> 'a array
