(* Performance test of a set of specific functions *)

open Bigarray

let c_mat_to_array2d x = Obj.magic (Bigarray.genarray_of_array2 x)

let array2d_to_c_mat x = Bigarray.array2_of_genarray (Obj.magic x)

(* prepare some data *)

let m, n = 5000, 20000 and c = 3
let x = Owl_dense_matrix.uniform Float64 m n
let y = Owl_dense_matrix.zeros Float64 m n

(* test some fun *)

(* TODO: compare test_00 and test_03, why? *)

let test_00 _ = Owl_dense_matrix.abs x

let test_01 _ = Owl_dense_matrix.neg x

let test_02 _ = Owl_dense_matrix.iter (fun a -> ()) x

let test_03 _ = Owl_dense_matrix.map (fun a -> 0.) x

let test_04 _ =
  let x = c_mat_to_array2d x in
  Owl_dense_ndarray.map (fun a -> 0.) x

let test_05 _ = Owl_dense_matrix.is_zero y

let test_06 _ =
  let y = c_mat_to_array2d y in
  Owl_dense_ndarray.is_zero y

let test_07 _ = Owl_dense_matrix.min x

let test_08 _ = Owl_dense_matrix.minmax x

let test_09 _ = Owl_dense_matrix.equal_or_greater x x

let test_10 _ = Owl_dense_matrix.uniform float64 m n

let test_11 _ = Owl_dense_ndarray.uniform float64 [|10;1000;10000|]

let _ = Perf_common.test_op_each c test_10
