
open Bigarray

(* prepare some data *)

let m, n = 5000, 20000 and c = 10
let x = Owl_dense_matrix.uniform Float64 m n
let y = Owl_dense_matrix.zeros Float64 m n

(* test some fun *)

(* TODO: compare test_00 and test_03, why? *)

let test_00 _ = Owl_dense_matrix.abs x

let test_01 _ = Owl_dense_matrix.neg x

let test_02 _ = Owl_dense_matrix.iter (fun a -> ()) x

let test_03 _ = Owl_dense_matrix.map (fun a -> 0.) x

let test_04 _ =
  let x = Owl_dense_common.matrix_to_array2d x in
  Owl_dense_ndarray.map (fun a -> 0.) x

let test_05 _ = Owl_dense_matrix.is_zero y

let test_06 _ =
  let y = Owl_dense_common.matrix_to_array2d y in
  Owl_dense_ndarray.is_zero y

let test_07 _ = Owl_dense_matrix.min x

let _ = Perf_common.test_op_each c test_06
