(* simple test - add a bunch of elements with skewed distribution to the sketch then count them *)
let simple_test_countmin eps del =
  let module CM = Owl_base.Countmin_sketch.Native in
  let s = CM.init eps del in
  for x = 1 to 30 do
    Printf.printf "expected count of %2d : %5d \n" x (10000 / x);
    for i = 1 to 10000 / x do
      CM.incr s x
    done
  done;
  for x = 1 to 30 do
    CM.count s x |> Printf.printf "count of %2d : %5d \n" x
  done


(* utilities for hashtable-based frequency table *)
let ht_count t x =
  match Hashtbl.find_opt t x with
  | Some c -> c
  | None -> 0


let ht_incr t x = Hashtbl.replace t x (ht_count t x + 1)

(* distribution sampling functions for testing *)
let unif_test a b _ = Owl.Stats.uniform_int_rvs ~a ~b
let binom_test n p _ = Owl.Stats.binomial_rvs ~n ~p

(* Test the countmin sketch by putting n samples from the function distr
 * into a sketch and into the hashtable-based naive frequency counter, then
 * comparing their outputs in a plot *)
let test_countmin_hashtbl distr eps del n =
  let module CM = Owl_base.Countmin_sketch.Native in
  let s = CM.init eps del in
  let t = Hashtbl.create n in
  for i = 1 to n do
    let v = distr () in
    CM.incr s v;
    ht_incr t v
  done;
  let foldfn v ct acc = (v, ct, CM.count s v) :: acc in
  let outputs =
    Hashtbl.fold foldfn t []
    |> List.sort (fun (_, a, _) (_, b, _) -> a - b)
    |> Array.of_list
  in
  let diffs =
    Array.map (fun (_, tct, sct) -> float_of_int (sct - tct) /. float_of_int tct) outputs
  in
  let diffs_mat = Owl.Mat.init_2d (Array.length diffs) 1 (fun i _ -> diffs.(i)) in
  let open Owl_plplot in
  let h = Plot.create "diffs.png" in
  Plot.histogram ~h ~bin:200 diffs_mat;
  Plot.output h;
  outputs, diffs

(* Test the k-heavy-hitters sketch by inserting n samples from the function distr
 * into the sketch and a hashtable-based naive frequency counter, then outputting
 * the lists of heavy hitters for comparison *)
let test_heavy_hitters distr k eps del n =
  let module HH = Owl_base.HeavyHitters_sketch.Native in
  let h = HH.init k eps del in
  let t = Hashtbl.create n in
  for i = 1 to n do
    let v = distr () in
    HH.add h v;
    ht_incr t v
  done;
  let hh_sketch = HH.get h in
  let foldfn v ct acc =
    if float_of_int ct > float_of_int n /. k then (v, ct) :: acc else acc
  in
  let hh_hashtbl = Hashtbl.fold foldfn t [] |> List.sort (fun (_, a) (_, b) -> b - a) in
  hh_sketch, hh_hashtbl

(* Check the memory usage of the countmin sketch. We do not expect any allocation to
 * take place after the INITIALIZE line. *)
let test_countmin_memory_usage distr eps del n oc =
  let open Printf in
  let module CM = Owl_base.Countmin_sketch.Native in
  fprintf oc "PARAMS: eps = %f, del = %f, n = %d\n" eps del n;
  fprintf oc "BEGIN: live_words = %d\n" (Gc.(stat ()).live_words);
  let s = CM.init eps del in
  fprintf oc "INITIALIZE: live_words = %d\n" (Gc.(stat ()).live_words);
  for i = 1 to n do
    CM.incr s (distr ());
    if i mod 1000 = 0 then
      fprintf oc "INCR %d: live_words = %d\n" i (Gc.(stat ()).live_words);
  done;
  for i = 1 to n do
    let v = distr () in
    let cv = CM.count s v in
    if i mod 1000 = 0 then
      fprintf oc "COUNT %d %d: live_words = %d\n" v cv (Gc.(stat ()).live_words);
  done;
  fprintf oc "COMPLETE: live_words = %d\n" (Gc.(stat ()).live_words)

let oc = open_out "countmin_memory_usage_native.log" ;;
test_countmin_memory_usage (binom_test 100 0.4) 0.0001 0.01 20000 oc ;;
close_out oc ;;

