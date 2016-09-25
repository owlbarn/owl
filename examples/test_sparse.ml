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
  let m, n = 5000, 5000 and c = 1 in
  print_endline (Bytes.make 60 '+');
  Printf.printf "| test matrix size: %i x %i    exps: %i\n" m n c;
  print_endline (Bytes.make 60 '-');
  let x, y = (M.uniform_int m n), (M.uniform_int m n) in
  test_op "col        " c (fun () -> M.col x (n-1));
  test_op "row        " c (fun () -> M.row x (m-1));
  test_op "cols       " c (fun () -> M.cols x [|1;2|]);
  test_op "rows       " c (fun () -> M.rows x [|1;2|]);
  test_op "map        " c (fun () -> M.map (fun y -> 0.) x);
  test_op "mapi       " c (fun () -> M.mapi (fun _ _ y -> 0.) x);
  test_op "iteri      " c (fun () -> M.iteri (fun _ _ y -> 0.) x);
  test_op "filter     " c (fun () -> M.filter (fun y -> false) x);
  test_op "fold       " c (fun () -> M.fold (fun y z -> ()) () x);
  test_op "for_all    " c (fun () -> M.for_all ((>) min_float) x);
  print_endline (Bytes.make 60 '+');
