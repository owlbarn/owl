module M = Owl_dense_real
module L = Owl_optimise

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

let test_kmeans () =
  let z3 = M.uniform 10000 8 in
  L.kmeans z3 3

let _ =
  let _ = Random.self_init () in
  let m, n = 5000, 5000 and c = 1 in
  print_endline (Bytes.make 60 '+');
  Printf.printf "| test matrix size: %i x %i    exps: %i\n" m n c;
  print_endline (Bytes.make 60 '-');
  (* let x, y = (M.random m n), (M.random m n) in
  test_op "pretty print    " c (fun () -> M.pprint x);
  test_op "load matrix    " c (fun () -> M.load "zmatrix.txt"); *)
  print_endline (Bytes.make 60 '+');
  test_kmeans ();
