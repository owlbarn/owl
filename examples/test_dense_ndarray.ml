(* Performance test of Owl_dense_ndarray module *)

module M = Owl_dense_ndarray

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
  let m, n, o = 100, 1000, 1000 and c = 1 in
  print_endline (Bytes.make 60 '+');
  Printf.printf "| test ndarray size: %i x %i x %i    exps: %i\n" m n o c;
  print_endline (Bytes.make 60 '-');
  let x = M.create Bigarray.Float64 [|m;n;o|] 1. in
  let y = M.create Bigarray.Float64 [|m;n;o|] 2. in
  test_op "slice_left        " c (fun () -> M.slice_left x [|0|]);
  test_op "slice             " c (fun () -> M.slice [|Some 0; None; None|] x);
  print_endline (Bytes.make 60 '+');
