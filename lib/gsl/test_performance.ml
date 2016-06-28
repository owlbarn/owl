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
  let _ = Random.self_init () in
  let m, n = 5000, 5000 and c = 5 in
  print_endline (Bytes.make 60 '+');
  Printf.printf "| test matrix size: %i x %i    exps: %i\n" m n c;
  print_endline (Bytes.make 60 '-');
  let x, y = (M.sequential m n), (M.sequential m n) in
  test_op "empty     " c (fun () -> M.empty m n);
  test_op "zeros     " c (fun () -> M.zeros m n);
  test_op "sequential" c (fun () -> M.sequential m n);
  test_op "col       " c (fun () -> M.col x (n-1));
  test_op "row       " c (fun () -> M.row x (m-1));
  test_op "map       " c (fun () -> M.map (fun y -> y +. 1.) x);
  test_op "mapi      " c (fun () -> M.mapi (fun _ _ y -> y +. 1.) x);
  test_op "iter      " c (fun () -> M.iter (fun y -> y +. 1.) x);
  test_op "iteri     " c (fun () -> M.iteri (fun _ _ y -> y +. 1.) x);
  test_op "iteri_cols" c (fun () -> M.iteri_cols (fun i y -> ()) x);
  test_op "iter_cols " c (fun () -> M.iter_cols (fun y -> ()) x);
  test_op "iteri_rows" c (fun () -> M.iteri_rows (fun i y -> ()) x);
  test_op "iter_rows " c (fun () -> M.iter_rows (fun i y -> ()) x);
  test_op "filteri   " c (fun () -> M.filteri (fun i j y -> false) x);
  test_op "filter    " c (fun () -> M.filter (fun y -> false) x);
  test_op "for_all   " c (fun () -> M.for_all ((>) 10000.) x);
  print_endline (Bytes.make 60 '+');
