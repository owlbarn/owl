(* utilities for hashtable-based frequency table *)
let ht_count t x =
  match Hashtbl.find_opt t x with
  | Some c -> c
  | None -> 0

let ht_incr t x = Hashtbl.replace t x (ht_count t x + 1)

(* distribution sampling functions for testing *)
let unif_test a b _ = Owl.Stats.uniform_int_rvs ~a ~b
let binom_test n p _ = Owl.Stats.binomial_rvs ~n ~p

(* time one run of function f on input x *)
let time f x =
  Gc.compact ();
  let t0 = Unix.gettimeofday () in
  let ans = f x in
  let t = (Unix.gettimeofday ()) -. t0 in
  ans, t

(* time n iterations of operation op with input from inp *)
let time_n n op inp = 
  let ttime = ref 0. in
  for i = 1 to n do
    Gc.compact ();
    let inpv = inp () in
    let t0 = Unix.gettimeofday () in
    let _ = op inpv in
    let t1 = Unix.gettimeofday () in
    ttime := !ttime +. (t1 -. t0)
  done;
  !ttime

module CM = Owl_base.Countmin_sketch.Native
module HH = Owl_base.HeavyHitters_sketch.Native

let test_countmin_memory_usage distr eps del n oc =
  let open Printf in
  fprintf oc "PARAMS: eps = %f, del = %f, n = %d\n" eps del n; flush oc;
  let init_lws = Gc.(stat ()).live_words in
  fprintf oc "BEGIN: live_words = %d\n" init_lws; flush oc;
  let s = CM.init ~epsilon:eps ~delta:del in
  let cur_lws = (Gc.(stat ()).live_words) in
  fprintf oc "INITIALIZE: live_words = %d, additional = %d\n" cur_lws (cur_lws - init_lws); flush oc;
  for i = 1 to n do
    CM.incr s (distr ());
    if i mod (n / 10) = 0 then
      let cur_lws = (Gc.(stat ()).live_words) in
      fprintf oc "INCR %d: live_words = %d, additional = %d\n" i cur_lws (cur_lws - init_lws); flush oc;
  done;
  for i = 1 to n do
    ignore (CM.count s (distr ()));
    if i mod (n / 10) = 0 then
      let cur_lws = (Gc.(stat ()).live_words) in
      fprintf oc "COUNT %d: live_words = %d, additional = %d\n" i cur_lws (cur_lws - init_lws); flush oc;
  done;
  let cur_lws = (Gc.(stat ()).live_words) in
  fprintf oc "COMPLETE: live_words = %d, additional = %d\n" cur_lws (cur_lws - init_lws); flush oc

let test_countmin_performance distr eps del n oc =
  let open Printf in
  fprintf oc "BEGIN TIME PROFILING--------------\n"; flush oc;
  fprintf oc "PARAMS: eps = %f, del = %f, n = %d\n" eps del n; flush oc;
  let s, t_init = time (fun _ -> CM.init ~epsilon:eps ~delta:del) () in
  fprintf oc "init time = %f\n" t_init; flush oc;
  let t_incr = time_n n (fun v -> CM.incr s v) distr in
  fprintf oc "time to incr %d elements = %f (average time per add = %f)\n" 
    n t_incr (t_incr /. (float_of_int n)); flush oc;
  let t_count = time_n n (fun v -> CM.count s v) distr in
  fprintf oc "time to count %d elements = %f (average time per count = %f)\n" 
    n t_count (t_count /. (float_of_int n)); flush oc;
  fprintf oc "\n\nBEGIN MEMORY PROFILING--------------\n"; flush oc;
  test_countmin_memory_usage distr eps del n oc


let test_heavyhitters_memory_usage distr k eps del n oc =
  let open Printf in
  fprintf oc "PARAMS: eps = %f, del = %f, n = %d\n" eps del n; flush oc;
  let init_lws = Gc.(stat ()).live_words in
  fprintf oc "BEGIN: live_words = %d\n" init_lws; flush oc;
  let h = HH.init ~k ~epsilon:eps ~delta:del in
  let cur_lws = (Gc.(stat ()).live_words) in
  fprintf oc "INITIALIZE: live_words = %d, additional = %d\n" cur_lws (cur_lws - init_lws); flush oc;
  for i = 1 to n do
    HH.add h (distr ());
    if i mod (n / 10) = 0 then
      let cur_lws = (Gc.(stat ()).live_words) in
      fprintf oc "INCR %d: live_words = %d, additional = %d\n" i cur_lws (cur_lws - init_lws); flush oc;
  done;
  ignore (HH.get h);
  let cur_lws = (Gc.(stat ()).live_words) in
  fprintf oc "GET: live_words = %d, additional = %d\n" cur_lws (cur_lws - init_lws); flush oc

let test_heavyhitters_performance distr k eps del n oc =
  let open Printf in
  fprintf oc "BEGIN TIME PROFILING--------------\n"; flush oc;
  fprintf oc "PARAMS: k = %f, eps = %f, del = %f, n = %d\n" k eps del n; flush oc;
  let h, t_init = time (fun _ -> HH.init ~k ~epsilon:eps ~delta:del) () in
  fprintf oc "init time = %f\n" t_init; flush oc;
  let t_incr = time_n n (fun v -> HH.add h v) distr in
  fprintf oc "time to add %d elements = %f (average time per add = %f)\n" 
    n t_incr (t_incr /. (float_of_int n)); flush oc;
  let t_get = time_n n (fun _ -> HH.get h) (fun () -> ()) in
  fprintf oc "time to get heavy hitters %d times = %f (average time per count = %f)\n" 
    n t_get (t_get /. (float_of_int n)); flush oc;
  fprintf oc "\n\nBEGIN MEMORY PROFILING--------------\n"; flush oc;
  test_heavyhitters_memory_usage distr k eps del n oc

let oc = open_out "countmin_performance_native.log" ;;
test_countmin_performance (binom_test 100 0.4) 0.001 0.001 100000 oc ;;
close_out oc ;;

let oc = open_out "heavyhitters_performance_native.log" ;;
test_heavyhitters_performance (binom_test 100 0.4) 10.0 0.001 0.01 100000 oc ;;
close_out oc ;;
