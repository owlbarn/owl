(* utilities for hashtable-based frequency table *)
let ht_count t x =
  match Hashtbl.find_opt t x with
  | Some c -> c
  | None -> 0

let ht_incr t x = Hashtbl.replace t x (ht_count t x + 1)

(* distribution sampling functions for testing *)
let unif_test a b _ = Owl.Stats.uniform_int_rvs ~a ~b
let binom_test n p _ = Owl.Stats.binomial_rvs ~n ~p

module CM = Owl_base.Countmin_sketch.Owl

(* Check the memory usage of the countmin sketch. We do not expect any allocation to
 * take place after the INITIALIZE line. *)
let test_countmin_memory_usage distr eps del n oc =
  let open Printf in
  fprintf oc "PARAMS: eps = %f, del = %f, n = %d\n" eps del n;
  fprintf oc "BEGIN: live_words = %d\n" (Gc.(stat ()).live_words);
  let s = CM.init eps del in
  fprintf oc "INITIALIZE: live_words = %d\n" (Gc.(stat ()).live_words);
  for i = 1 to n do
    CM.incr s (distr ());
    if i mod (n / 10) = 0 then
      fprintf oc "INCR %d: live_words = %d\n" i (Gc.(stat ()).live_words);
  done;
  for i = 1 to n do
    ignore (CM.count s (distr ()));
    if i mod (n / 10) = 0 then
      fprintf oc "COUNT %d: live_words = %d\n" i (Gc.(stat ()).live_words);
  done;
  fprintf oc "COMPLETE: live_words = %d\n" (Gc.(stat ()).live_words)

let time f x =
  let t0 = Unix.gettimeofday () in
  let ans = f x in
  let t = (Unix.gettimeofday ()) -. t0 in
  ans, t

let test_countmin_performance distr eps del n oc =
  let open Printf in
  fprintf oc "BEGIN TIME PROFILING--------------\n";
  fprintf oc "PARAMS: eps = %f, del = %f, n = %d\n" eps del n;
  let s, t_init = time (fun _ -> CM.init ~epsilon:eps ~delta:del) () in
  fprintf oc "init time = %f\n" t_init;
  let incrfn () = for i = 1 to n do CM.incr s (distr ()) done in
  let _, t_incr = time incrfn () in
  fprintf oc "time to incr %d elements = %f (average time per add = %f)\n" 
    n t_incr (t_incr /. (float_of_int n));
  let countfn () = for i = 1 to n do ignore (CM.count s (distr ())) done in
  let _, t_count = time countfn () in
  fprintf oc "time to count %d elements = %f (average time per count = %f)\n" 
    n t_count (t_count /. (float_of_int n));
  fprintf oc "\n\nBEGIN MEMORY PROFILING--------------\n";
  test_countmin_memory_usage distr eps del n oc

let test_heavyhitters_performance distr k eps del n oc =
  let module HH = Owl_base.HeavyHitters_sketch.Native in
  let open Printf in
  fprintf oc "BEGIN TIME PROFILING--------------\n";
  fprintf oc "PARAMS: k = %f, eps = %f, del = %f, n = %d\n" k eps del n;
  let h, t_init = time (fun _ -> HH.init ~k ~epsilon:eps ~delta:del) () in
  fprintf oc "init time = %f\n" t_init;
  let incrfn () = for i = 1 to n do HH.add h (distr ()) done in
  let _, t_incr = time incrfn () in
  fprintf oc "time to add %d elements = %f (average time per add = %f)\n" 
    n t_incr (t_incr /. (float_of_int n));
  let getfn () = for i = 1 to n do ignore (HH.get h) done in
  let _, t_get = time getfn () in
  fprintf oc "time to get heavy hitters %d times = %f (average time per count = %f)\n" 
    n t_get (t_get /. (float_of_int n));
  fprintf oc "\n\nBEGIN MEMORY PROFILING--------------\n"
  (* test_countmin_memory_usage distr eps del n oc *)

(* let oc = open_out "countmin_performance_owl.log" ;;
test_countmin_performance (binom_test 100 0.4) 0.0001 0.01 1000000 oc ;;
close_out oc ;; *)

let oc = open_out "heavyhitters_performance_native.log" ;;
test_heavyhitters_performance (binom_test 100 0.4) 10.0 0.0001 0.01 1000000 oc ;;
close_out oc ;;
