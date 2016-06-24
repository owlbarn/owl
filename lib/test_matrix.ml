module M = Matrix.Matrix

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
  let m, n = 5000, 5000 and c = 10 in
  print_endline (Bytes.make 60 '+');
  Printf.printf "| test matrix size: %i x %i    exps: %i\n" m n c;
  print_endline (Bytes.make 60 '-');
  (* test_op "random    " c (fun () -> M.random m n); *)
  (* test_op "sequential" c (fun () -> M.sequential m n); *)
  let x, y = (M.random m n), (M.random m n) in
  test_op "add       " c (fun () -> M.add x y);
  test_op "mul       " c (fun () -> M.mul x y);
  (* test_op "dot       " c (fun () -> M.dot x y); *)
  test_op "min       " c (fun () -> M.min x);
  test_op "min_col   " c (fun () -> M.min_col x);
  test_op "min_row   " c (fun () -> M.min_row x);
  test_op "sum       " c (fun () -> M.sum x);
  test_op "sum_cols  " c (fun () -> M.sum_cols x);
  test_op "sum_rows  " c (fun () -> M.sum_rows x);
  test_op "map       " c (fun () -> M.map ((+.) 1.) x);
  test_op "mapi      " c (fun () -> M.mapi (fun _ _ y -> y +. 1.) x);
  test_op "iter      " c (fun () -> M.iter ((+.) 1.) x);
  test_op "iteri     " c (fun () -> M.iteri (fun _ _ y -> y +. 1.) x);
  test_op "iteri_cols" c (fun () -> M.iteri_cols (fun i y -> ()) x);
  test_op "iter_cols " c (fun () -> M.iter_cols (fun y -> ()) x);
  test_op "iteri_rows" c (fun () -> M.iteri_rows (fun i y -> ()) x);
  test_op "iter_rows " c (fun () -> M.iter_rows (fun i y -> ()) x);
  test_op "for_all   " c (fun () -> M.for_all ((>) 10000.) x);
  test_op "transpose " c (fun () -> M.transpose x);
  print_endline (Bytes.make 60 '+');
