(* Performance test of a set of specific functions *)

open Bigarray

let c_mat_to_array2d x = Obj.magic (Bigarray.genarray_of_array2 x)

let array2d_to_c_mat x = Bigarray.array2_of_genarray (Obj.magic x)

let _ = let conf = Gc.get () in Gc.(conf.verbose <- 0x80); Gc.set conf

let print_gc_stat () =
  Printf.printf "==================================\n";
  Gc.print_stat stdout;
  flush_all ()


(* prepare some data *)

let m, n = 5000, 20000 and c = 5
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

let test_12 _ = Owl_dense_matrix.is_nonnegative x

let test_13 _ = Owl_dense_matrix.is_nonpositive y

let test_14 _ = Owl_dense_ndarray.nnz (Owl_dense_matrix.to_ndarray y)

let test_15 _ = Owl_dense_matrix.add_scalar x 2.

let test_16 _ = Owl_dense_matrix.sigmoid x

let test_17 _ = Owl_dense_matrix.l2norm x

let test_18 _ = Owl_dense_matrix.l1norm x

let test_19 _ = Owl_dense_real.softmax x

let test_20 _ = Owl_dense_real.transpose x

(* compare the speed between 21 and 22 *)

let test_21 _ =
  for i = 1 to 10000 do
    let x = Owl.Mat.empty 1000 1000 in
    Array2.fill x 0.;
    Gc.compact ()
  done

let test_22 _ =
  for i = 1 to 10000 do
    let x = Array2.create Float32 C_layout 1000 1000 in
    Array2.fill x 0.;
    Gc.compact ()
  done

let test_23 _ =
  let x = ref (Array2.create Float32 C_layout 1000 1000) in
  for i = 1 to 10000 do
    print_gc_stat ();
    x := Array2.create Float32 C_layout 1000 1000;
    Array2.fill !x 0.;
    Gc.compact()
  done

let test_24 _ = Owl_dense_real.ssqr_diff x y

let _ = Perf_common.test_op_each c test_24

(* ends here *)
