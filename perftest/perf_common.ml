(* helper functions for performance test *)

let test_op s c op =
  let ttime = ref 0. in
  for i = 1 to c do
    Gc.compact ();
    let t0 = Unix.gettimeofday () in
    let _ = op () in
    let t1 = Unix.gettimeofday () in
    ttime := !ttime +. (t1 -. t0)
  done;
  let _ = ttime := !ttime /. (float_of_int c) in
  Printf.printf "| %s :\t %.4fs \n" s !ttime;
  flush stdout
