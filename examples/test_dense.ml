module M = Owl_dense_real

let test_op s c op =
  let ttime = ref 0. in
  for i = 1 to c do
    let t0 = Unix.gettimeofday () in
    let _ = op () in
    let t1 = Unix.gettimeofday () in
    ttime := !ttime +. (t1 -. t0)
  done;
  let _ = ttime := !ttime /. (float_of_int c) in
  Printf.printf "| %s :\t %.4fs \n" s !ttime;
  flush stdout

let _ =
  let _ = Random.self_init () in
  let m, n = 5000, 5000 and c = 1 in
  print_endline (Bytes.make 60 '+');
  Printf.printf "| test matrix size: %i x %i    exps: %i\n" m n c;
  print_endline (Bytes.make 60 '-');
  let x, y = (M.uniform m n), (M.uniform m n) in
  test_op "col        " c (fun () -> M.col x (n-1));
  test_op "row        " c (fun () -> M.row x (m-1));
  test_op "cols       " c (fun () -> M.cols x [|1;2|]);
  test_op "rows       " c (fun () -> M.rows x [|1;2|]);
  test_op "map        " c (fun () -> M.map (fun y -> 0.) x);
  test_op "mapi       " c (fun () -> M.mapi (fun _ _ y -> 0.) x);
  test_op "iter       " c (fun () -> M.iter (fun y -> 0.) x);
  test_op "iteri      " c (fun () -> M.iteri (fun _ _ y -> 0.) x);
  test_op "iter_cols  " c (fun () -> M.iter_cols (fun y -> ()) x);
  test_op "iteri_cols " c (fun () -> M.iteri_cols (fun i y -> ()) x);
  test_op "iter_rows  " c (fun () -> M.iter_rows (fun i y -> ()) x);
  test_op "iteri_rows " c (fun () -> M.iteri_rows (fun i y -> ()) x);
  test_op "filter     " c (fun () -> M.filter (fun y -> false) x);
  test_op "filteri    " c (fun () -> M.filteri (fun i j y -> false) x);
  test_op "fold       " c (fun () -> M.fold (fun y z -> ()) () x);
  test_op "fold_cols  " c (fun () -> M.fold_cols (fun y z -> ()) () x);
  test_op "fold_rows  " c (fun () -> M.fold_rows (fun y z -> ()) () x);
  test_op "for_all    " c (fun () -> M.for_all ((>) min_float) x);
  test_op "add        " c (fun () -> M.add x y);
  test_op "sub        " c (fun () -> M.sub x y);
  test_op "mul        " c (fun () -> M.mul x y);
  test_op "div        " c (fun () -> M.div x y);
  test_op "dot        " 0 (fun () -> M.dot x y);
  test_op "+$         " c (fun () -> M.(x +$ 1.));
  test_op "*$         " c (fun () -> M.(x *$ 1.));
  test_op "abs        " c (fun () -> M.abs x);
  test_op "neg        " c (fun () -> M.neg x);
  test_op "sum        " c (fun () -> M.sum x);
  test_op "sum_cols   " c (fun () -> M.sum_cols x);
  test_op "sum_rows   " c (fun () -> M.sum_rows x);
  test_op "min        " c (fun () -> M.min x);
  test_op "min_cols   " c (fun () -> M.min_cols x);
  test_op "min_rows   " c (fun () -> M.min_rows x);
  test_op "average    " c (fun () -> M.average x);
  test_op "avg_col    " c (fun () -> M.average_cols x);
  test_op "avg_row    " c (fun () -> M.average_rows x);
  test_op "=@         " c (fun () -> M.(x =@ y));
  test_op ">@         " c (fun () -> M.(x >@ y));
  test_op ">=@        " c (fun () -> M.(x >=@ y));
  test_op "diag       " c (fun () -> M.diag x);
  test_op "transpose  " c (fun () -> M.transpose x);
  test_op "clone      " c (fun () -> M.clone x);
  test_op "@=         " c (fun () -> M.(x @= y));
  test_op "@||        " c (fun () -> M.(x @|| y));
  test_op "draw_cols  " c (fun () -> M.draw_cols x 1000);
  test_op "draw_rows  " c (fun () -> M.draw_rows x 1000);
  test_op "save       " c (fun () -> M.save x "test_matrix0.tmp");
  test_op "load       " c (fun () -> M.load "test_matrix0.tmp");
  test_op "save_txt   " c (fun () -> M.save_txt x "test_matrix1.tmp");
  test_op "load_txt   " c (fun () -> M.load_txt "test_matrix1.tmp");
  test_op "zeros      " c (fun () -> M.zeros m n);
  test_op "uniform_int" c (fun () -> M.uniform_int m n);
  test_op "uniform    " c (fun () -> M.uniform m n);
  test_op "gaussian   " c (fun () -> M.gaussian m n);
  test_op "sequential " c (fun () -> M.sequential m n);
  print_endline (Bytes.make 60 '+');
