(* helper functions for performance test *)


(* test one operation c times, output the mean time *)
let test_op s c op =
  let ttime = ref 0. in
  for i = 1 to c do
    Gc.compact ();
    let t0 = Unix.gettimeofday () in
    let _ = op () in
    let t1 = Unix.gettimeofday () in
    ttime := !ttime +. (t1 -. t0)
  done;
  ttime := !ttime /. (float_of_int c);
  Printf.printf "| %s :\t %.8fs \n" s !ttime;
  flush stdout


(* test one operation c time, output the used time in each evaluation *)
let test_op_each c op =
  Printf.printf "| test some fun %i times\n" c;
  let ttime = ref 0. in
  for i = 1 to c do
    Gc.compact ();
    let t0 = Unix.gettimeofday () in
    let _ = op () in
    let t1 = Unix.gettimeofday () in
    Printf.printf "| #%0i\t:\t %.8fs \n" i (t1 -. t0);
    flush stdout;
    ttime := !ttime +. (t1 -. t0)
  done;
  ttime := !ttime /. (float_of_int c);
  Printf.printf "| avg.\t:\t %.8fs \n" !ttime


(* more advanced test function *)
let test_advance_op ?(s="test") ?(c=10) ?(burn=0) ?(ts=`MS) op =
  let times = Utils.Stack.make () in

  for i = 1 to c do
    Gc.compact ();
    let t0 = Unix.gettimeofday () in
    let _ = op () in
    let t1 = Unix.gettimeofday () in
    if i > burn then Utils.Stack.push times (t1 -. t0)
  done;

  let times = Utils.Stack.to_array times |> Array.map (
    fun t -> match ts with
      | `S  -> t
      | `MS -> 1000. *. t
  )
  in
  let m_time = Stats.mean times in
  let s_time = Stats.std times in
  Printf.printf "| %s :\t mean = %.4f \t std = %.4f \n" s m_time s_time;
  flush stdout
