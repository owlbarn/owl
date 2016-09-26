module M = Sparse

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
  let m, n = 2500, 2500 and c = 1 in
  print_endline (Bytes.make 60 '+');
  Printf.printf "| test matrix size: %i x %i    exps: %i\n" m n c;
  print_endline (Bytes.make 60 '-');
  let x, y = (M.uniform_int m n), (M.uniform_int m n) in
  let z = M.add x x in
  test_op "empty      " c (fun () -> M.empty m n);
  test_op "eye        " c (fun () -> M.eye m);
  test_op "uniform    " 1 (fun () -> M.uniform m n);
  test_op "clone trt  " c (fun () -> M.clone x);
  test_op "clone csc  " c (fun () -> M.clone z);
  test_op "col        " c (fun () -> M.col x (n-1));
  test_op "row        " c (fun () -> M.row x (m-1));
  test_op "cols       " c (fun () -> M.cols x [|1;2|]);
  test_op "rows       " c (fun () -> M.rows x [|1;2|]);
  test_op "map        " 1 (fun () -> M.map (fun y -> 0.) x);
  test_op "mapi       " 1 (fun () -> M.mapi (fun _ _ y -> 0.) x);
  test_op "iteri      " 1 (fun () -> M.iteri (fun _ _ y -> 0.) x);
  test_op "iteri_nz   " 1 (fun () -> M.iteri_nz (fun _ _ y -> ()) x);
  test_op "filter     " 1 (fun () -> M.filter (fun y -> false) x);
  test_op "fold       " 1 (fun () -> M.fold (fun y z -> ()) () x);
  test_op "for_all    " c (fun () -> M.for_all ((>) min_float) x);
  test_op "iteri_rows " c (fun () -> M.iteri_rows (fun _ y -> ()) x);
  test_op "iteri_cols " c (fun () -> M.iteri_cols (fun _ y -> ()) x);
  test_op "mapi_rows  " c (fun () -> M.mapi_rows (fun _ _ -> M.uniform 1 100) x);
  test_op "mapi_cols  " c (fun () -> M.mapi_cols (fun _ _ -> M.uniform 100 1) x);
  print_endline (Bytes.make 60 '+');
