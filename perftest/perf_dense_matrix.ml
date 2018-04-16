#!/usr/bin/env owl
#zoo "5ca2fdebb0ccb9ecee6f4331972a9087"
(* Performance test of Owl_dense_matrix module *)

open Bigarray

module M = Owl.Dense.Matrix.Generic

let test_op s c op = Perf_common.test_op s c op

let _ =
  Random.self_init ();
  let m, n = 5000, 20000 and c = 1 in
  print_endline (String.make 60 '+');
  Printf.printf "| test matrix size: %i x %i    exps: %i\n" m n c;
  print_endline (String.make 60 '-');
  let x, y = (M.uniform Float64 m n), (M.uniform Float64 m n) in
  test_op "empty             " c (fun () -> M.empty Float64 m n);
  test_op "zeros             " c (fun () -> M.zeros Float64 m n);
  test_op "col               " c (fun () -> M.col x (n-1));
  test_op "row               " c (fun () -> M.row x (m-1));
  test_op "cols              " c (fun () -> M.cols x [|1;2|]);
  test_op "rows              " c (fun () -> M.rows x [|1;2|]);
  test_op "map               " c (fun () -> M.map (fun y -> 0.) x);
  test_op "mapi              " c (fun () -> M.mapi (fun _ y -> 0.) x);
  test_op "iter              " c (fun () -> M.iter (fun y -> ()) x);
  test_op "iteri             " c (fun () -> M.iteri (fun _ y -> ()) x);
  test_op "iter_cols         " c (fun () -> M.iter_cols (fun y -> ()) x);
  test_op "iteri_cols        " c (fun () -> M.iteri_cols (fun i y -> ()) x);
  test_op "iter_rows         " c (fun () -> M.iter_rows (fun y -> ()) x);
  test_op "iteri_rows        " c (fun () -> M.iteri_rows (fun i y -> ()) x);
  test_op "filter            " c (fun () -> M.filter (fun y -> false) x);
  test_op "filteri           " c (fun () -> M.filteri (fun _ y -> false) x);
  test_op "fold              " c (fun () -> M.fold (fun y z -> 0.) 0. x);
  test_op "fold_cols         " c (fun () -> M.fold_cols (fun y z -> ()) () x);
  test_op "fold_rows         " c (fun () -> M.fold_rows (fun y z -> ()) () x);
  test_op "for_all           " c (fun () -> M.for_all ((>) min_float) x);
  test_op "add               " c (fun () -> M.add x y);
  test_op "sub               " c (fun () -> M.sub x y);
  test_op "mul               " c (fun () -> M.mul x y);
  test_op "div               " c (fun () -> M.div x y);
  test_op "dot               " 0 (fun () -> ());
  test_op "add_scalar        " c (fun () -> M.add_scalar x 1.);
  test_op "mul_scalar        " c (fun () -> M.mul_scalar x 1.);
  test_op "abs               " c (fun () -> M.abs x);
  test_op "neg               " c (fun () -> M.neg x);
  test_op "sum               " c (fun () -> M.sum x);
  test_op "sum_cols          " c (fun () -> M.sum_cols x);
  test_op "sum_rows          " c (fun () -> M.sum_rows x);
  test_op "min               " c (fun () -> M.min x);
  test_op "min_i             " c (fun () -> M.min_i x);
  test_op "min_cols          " c (fun () -> M.min_cols x);
  test_op "min_rows          " c (fun () -> M.min_rows x);
  test_op "mean              " c (fun () -> M.mean x);
  test_op "avg_col           " c (fun () -> M.mean_cols x);
  test_op "avg_row           " c (fun () -> M.mean_rows x);
  test_op "equal             " c (fun () -> M.equal x x);
  test_op "greater           " c (fun () -> M.greater x x);
  test_op "greater_equal     " c (fun () -> M.greater_equal x x);
  test_op "diag              " c (fun () -> M.diag x);
  test_op "transpose         " c (fun () -> M.transpose x);
  test_op "copy              " c (fun () -> M.copy x);
  test_op "@=                " c (fun () -> M.concat_vertical x y);
  test_op "@||               " c (fun () -> M.concat_horizontal x y);
  test_op "draw_cols         " c (fun () -> M.draw_cols x 1000);
  test_op "draw_rows         " c (fun () -> M.draw_rows x 1000);
  test_op "save              " c (fun () -> M.save x "test_matrix0.tmp");
  test_op "load              " c (fun () -> M.load Float64 "test_matrix0.tmp");
  test_op "save_txt          " 0 (fun () -> M.save_txt x "test_matrix1.tmp");
  test_op "load_txt          " 0 (fun () -> M.load_txt Float64 "test_matrix1.tmp");
  test_op "uniform           " c (fun () -> M.uniform Float64 m n);
  test_op "gaussian          " c (fun () -> M.gaussian Float64 m n);
  test_op "sequential        " c (fun () -> M.sequential Float64 m n);
  print_endline (String.make 60 '+');
