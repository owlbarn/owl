
open Bigarray

(* prepare some data *)

let m, n = 5000, 20000 and c = 10
let x = Owl_dense_matrix.uniform Float64 m n
let y = Owl_dense_matrix.uniform Float64 m n

(* test some fun *)

let test_00 () = Owl_dense_matrix.abs x

let test_01 () = Owl_dense_matrix.neg x

let test_02 () = Owl_dense_matrix.iter (fun a -> ()) x

let _ = Perf_common.test_op_each c test_02
