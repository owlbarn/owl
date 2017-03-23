(* Performance test of Owl_sparse_matrix module *)

open Bigarray

module M = Owl_sparse_matrix_generic

let test_op s c op = Perf_common.test_op s c op

let _ =
  let _ = Random.self_init () in
  let m, n = 2500, 2500 and c = 1 in
  print_endline (Bytes.make 60 '+');
  Printf.printf "| test matrix size: %i x %i    exps: %i\n" m n c;
  print_endline (Bytes.make 60 '-');
  let x, y = (M.uniform Float64 m n), (M.uniform Float64 m n) in
  let z = M.add x x in
  test_op "zeros             " c (fun () -> M.zeros Float64 m n);
  test_op "ones              " c (fun () -> M.ones Float64 m n);
  test_op "eye               " c (fun () -> M.eye Float64 m);
  test_op "binary            " c (fun () -> M.binary Float64 m n);
  test_op "uniform           " c (fun () -> M.uniform Float64 m n);
  test_op "nnz_rows          " c (fun () -> M.nnz_rows z);
  test_op "row_num_nz        " c (fun () -> M.row_num_nz z);
  (* test_op "triplet:crs       " c (fun () -> M._triplet2crs y); *)
  test_op "clone             " c (fun () -> M.clone z);
  test_op "col               " c (fun () -> M.col x (n-1));
  test_op "row               " c (fun () -> M.row x (m-1));
  (*test_op "cols              " c (fun () -> M.cols x [|1;2|]); *)
  (*test_op "rows              " c (fun () -> M.rows x [|1;2|]); *)
  test_op "mapi              " c (fun () -> M.mapi (fun _ _ y -> 0.) x);
  test_op "mapi_nz           " c (fun () -> M.mapi_nz (fun _ _ y -> 1.) x);
  test_op "iteri             " c (fun () -> M.iteri (fun _ _ y -> ()) x);
  test_op "iteri_nz          " c (fun () -> M.iteri_nz (fun _ _ y -> ()) x);
  test_op "filter            " c (fun () -> M.filter (fun y -> false) x);
  test_op "filter_nz         " c (fun () -> M.filter_nz (fun y -> false) x);
  test_op "fold              " c (fun () -> M.fold (fun y z -> y +. z) 0. x);
  test_op "fold_nz           " c (fun () -> M.fold_nz (fun y z -> y +. z) 0. x);
  test_op "for_all           " c (fun () -> M.for_all ((>) infinity) x);
  test_op "iteri_rows        " c (fun () -> M.iteri_rows (fun _ y -> ()) x);
  test_op "iteri_rows_nz     " c (fun () -> M.iteri_rows_nz (fun _ y -> ()) x);
  test_op "iteri_cols        " c (fun () -> M.iteri_cols (fun _ y -> ()) x);
  test_op "iteri_cols_nz     " c (fun () -> M.iteri_cols_nz (fun _ y -> ()) x);
  test_op "mapi_rows         " c (fun () -> M.mapi_rows (fun _ _ -> 0.) x);
  test_op "mapi_cols         " c (fun () -> M.mapi_cols (fun _ _ -> 0.) x);
  test_op "mul_scalar        " c (fun () -> M.mul_scalar x 1.);
  test_op "div_scalar        " c (fun () -> M.div_scalar x 1.);
  test_op "add               " c (fun () -> M.add x y);
  test_op "sub               " c (fun () -> M.sub x y);
  test_op "mul               " c (fun () -> M.mul x y);
  test_op "div               " c (fun () -> M.div x y);
  test_op "dot               " c (fun () -> M.dot x y);
  test_op "abs               " c (fun () -> M.abs x);
  test_op "neg               " c (fun () -> M.neg x);
  test_op "sum               " c (fun () -> M.sum x);
  test_op "average           " c (fun () -> M.average x);
  test_op "sum_rows          " c (fun () -> M.sum_rows x);
  test_op "average_rows      " c (fun () -> M.average_rows x);
  (*test_op "minmax            " c (fun () -> M.minmax x);*)
  test_op "is_zero           " c (fun () -> M.is_zero x);
  test_op "is_negative       " c (fun () -> M.is_negative x);
  test_op "is_positive       " c (fun () -> M.is_positive x);
  test_op "is_equal          " c (fun () -> M.is_equal x x);
  test_op "equal_or_greater  " c (fun () -> M.equal_or_greater x x);
  test_op "is_greater        " c (fun () -> M.is_greater x x);
  test_op "to_dense          " c (fun () -> M.to_dense x);
  test_op "draw_rows         " c (fun () -> M.draw_rows x 1000);
  test_op "draw_cols         " c (fun () -> M.draw_cols x 1000);
  test_op "shuffle_rows      " c (fun () -> M.shuffle_rows x);
  test_op "shuffle           " c (fun () -> M.shuffle x);
  test_op "save              " c (fun () -> M.save x "zsparse.tmp");
  test_op "load              " c (fun () -> M.load Float64 "zsparse.tmp");
  print_endline (Bytes.make 60 '+');
