#!/usr/bin/env owl
#mod_use "perf_common.ml"

(* Performance test of Owl_sparse_ndarray module *)

open Bigarray

module M = Owl_sparse_ndarray_generic

let test_op s c op = Perf_common.test_op s c op

let _ =
  let _ = Random.self_init () in
  let m, n, o = 10, 1000, 10000 and c = 1 in
  let density = 0.00001 in
  print_endline (Bytes.make 60 '+');
  Printf.printf "| test ndarray size: %i x %i x %i    exps: %i\n" m n o c;
  print_endline (Bytes.make 60 '-');
  let x = M.uniform ~density Bigarray.Float64 [|m;n;o|] in
  let y = M.uniform ~density Bigarray.Float64 [|m;n;o|] in
  test_op "zeros             " c (fun () -> M.zeros Bigarray.Float64 [|m;n;o|]);
  test_op "uniform           " c (fun () -> M.uniform ~density Bigarray.Float64 [|m;n;o|]);
  test_op "min               " c (fun () -> M.min x);
  test_op "minmax            " c (fun () -> M.minmax x);
  test_op "abs               " c (fun () -> M.abs x);
  test_op "neg               " c (fun () -> M.neg x);
  test_op "sum               " c (fun () -> M.sum x);
  test_op "add x y           " c (fun () -> M.add x y);
  test_op "mul x y           " c (fun () -> M.mul x y);
  test_op "add_scalar        " c (fun () -> M.add_scalar x 0.5);
  test_op "mul_scalar        " c (fun () -> M.mul_scalar x 10.);
  test_op "is_zero           " c (fun () -> M.is_zero x);
  test_op "equal          " c (fun () -> M.equal x x);
  test_op "greater        " c (fun () -> M.greater x x);
  test_op "greater_equal  " c (fun () -> M.greater_equal x x);
  test_op "clone             " c (fun () -> M.clone x);
  test_op "iteri             " c (fun () -> M.iteri (fun i a -> ()) x);
  test_op "iter              " c (fun () -> M.iter (fun a -> ()) x);
  test_op "iteri (0,*,*)     " c (fun () -> M.iteri ~axis:[|Some 0; None; None|] (fun i a -> ()) x);
  test_op "iter (0,*,*)      " c (fun () -> M.iter ~axis:[|Some 0; None; None|] (fun a -> ()) x);
  test_op "iteri_nz          " c (fun () -> M.iteri_nz (fun i a -> ()) x);
  test_op "iter_nz           " c (fun () -> M.iter_nz (fun a -> ()) x);
  test_op "iteri_nz (0,*,*)  " c (fun () -> M.iteri_nz ~axis:[|Some 0; None; None|] (fun i a -> ()) x);
  test_op "iter_nz (0,*,*)   " c (fun () -> M.iter_nz ~axis:[|Some 0; None; None|] (fun a -> ()) x);
  test_op "mapi_nz           " c (fun () -> M.mapi_nz (fun i a -> a) x);
  test_op "map_nz            " c (fun () -> M.map_nz (fun a -> a) x);
  test_op "map_nz (sin)      " c (fun () -> M.map_nz (fun a -> sin a) x);
  test_op "map_nz (+1)       " c (fun () -> M.map_nz (fun a -> a +. 1.) x);
  print_endline (Bytes.make 60 '+');
