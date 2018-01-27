#!/usr/bin/env owl
#zoo "5ca2fdebb0ccb9ecee6f4331972a9087"

(* Performance test of a set of specific functions *)

open Bigarray

let _ = let conf = Gc.get () in Gc.(conf.verbose <- 0x80); Gc.set conf

let print_gc_stat () =
  Printf.printf "==================================\n";
  Gc.print_stat stdout;
  flush_all ()


(* prepare some data *)

let m, n = 5000, 20000 and c = 5
let x = Owl_dense_matrix_generic.uniform Float64 m n
let y = Owl_dense_matrix_generic.zeros Float64 m n

(* test some fun *)

(* TODO: compare test_00 and test_03, why? *)

let test_00 _ = Owl_dense_matrix_generic.abs x

let test_01 _ = Owl_dense_matrix_generic.neg x

let test_02 _ = Owl_dense_matrix_generic.iter (fun a -> ()) x

let test_03 _ = Owl_dense_matrix_generic.map (fun a -> 0.) x

let test_04 _ = Owl_dense_ndarray_generic.map (fun a -> 0.) x

let test_05 _ = Owl_dense_matrix_generic.is_zero y

let test_06 _ = Owl_dense_ndarray_generic.is_zero y

let test_07 _ = Owl_dense_matrix_generic.min x

let test_08 _ = Owl_dense_matrix_generic.minmax x

let test_09 _ = Owl_dense_matrix_generic.greater_equal x x

let test_10 _ = Owl_dense_matrix_generic.uniform float64 m n

let test_11 _ = Owl_dense_ndarray_generic.uniform float64 [|10;1000;10000|]

let test_12 _ = Owl_dense_matrix_generic.is_nonnegative x

let test_13 _ = Owl_dense_matrix_generic.is_nonpositive y

let test_14 _ = Owl_dense_ndarray_generic.nnz y

let test_15 _ = Owl_dense_matrix_generic.add_scalar x 2.

let test_16 _ = Owl_dense_matrix_generic.sigmoid x

let test_17 _ = Owl_dense_matrix_generic.l2norm x

let test_18 _ = Owl_dense_matrix_generic.l1norm x

let test_19 _ = Owl.Dense.Matrix.D.softmax x

let test_20 _ = Owl.Dense.Matrix.D.transpose x

(* compare the speed between 21 and 22 *)

let test_21 _ =
  for i = 1 to 10000 do
    let x = Owl.Dense.Matrix.Generic.empty Float64 1000 1000 in
    Owl.Dense.Matrix.Generic.fill x 0.;
    Gc.compact ()
  done

let test_22 _ =
  for i = 1 to 10000 do
    let x = Owl.Dense.Matrix.Generic.empty Float32 1000 1000 in
    Owl.Dense.Matrix.Generic.fill x 0.;
    Gc.compact ()
  done

let test_23 _ =
  let x = ref (Owl.Dense.Matrix.Generic.empty Float32 1000 1000) in
  for i = 1 to 10000 do
    print_gc_stat ();
    x := Owl.Dense.Matrix.Generic.empty Float32 1000 1000;
    Owl.Dense.Matrix.Generic.fill !x 0.;
    Gc.compact()
  done

let test_24 _ = Owl.Dense.Matrix.D.linspace 0. 100000000. 100000000

let test_25 _ = Owl_dense_matrix_generic.cast_d2s x

let test_26 _ =
  let x = Owl.Mat.uniform 1000 1000 in
  Owl.Linalg.D.eig x

let _ = Perf_common.test_op_each c test_26


(* ends here *)
