(* TODO separate this into a different file *)
module Countmin_table_sig = struct 
  (* A module type for the tables used to implement the CountMin sketch. *)
  module type Sig = sig 
    (* the underlying table *)
    type t

    (* init l w generates a table with length l and width w, all counters initialized to 0 *)
    val init : int -> int -> t

    (* incr i j t increments the counter at length index i and width index j in table t *)
    val incr : int -> int -> t -> unit

    (* get i j t gets the value of the counter at length index i and width index j in table t*)
    val get : int -> int -> t -> int
  end

  (* Implementation of the CountMin sketch table using OCaml native arrays *)
  module Native_table : (Sig with type t = int array array) = struct
    type t = int array array

    let init l w = Array.make_matrix l w 0

    let incr i j t = t.(i).(j) <- t.(i).(j) + 1

    let get i j t = t.(i).(j)
  end

  (* Implementation of the CountMin sketch table using Owl ndarrays *)
  module Owl_table : (Sig with type t = Owl.Arr.arr) = struct  
    type t = Owl.Arr.arr

    let init l w = Owl.Arr.zeros [|l;w|]

    let incr i j t = Owl.Arr.set t [|i;j|] ((Owl.Arr.get t [|i;j|]) +. 1.)

    let get i j t = Owl.Arr.get t [|i;j|] |> int_of_float
  end
end

(* Functor to make the CountMin sketch using a specified underlying table *)
module Make (T : Countmin_table_sig.Sig) = struct
  (* the type of sketches *)
  type sketch = 
    {tbl : T.t ; 
     w : int ; 
     hash_fns : (int * int * int) array}

  (* the prime number to use for hashing *)
  let bigprime = (1 lsl 31) - 1

  (* Calculate (a*x + b) mod (2^31 - 1) *)
  let hash31 x a b =
    let result = (a * x) + b in
    ((result lsr 31) + result) land bigprime

  (* Initialize a sketch with l hash functions, each with w buckets *)
  let init_lw l w =
    let gen_rand_int _ = Owl.Stats.uniform_int_rvs ~a:0 ~b:bigprime in
    let gen_rand_pair i = (i, gen_rand_int (), gen_rand_int ()) in
    {tbl = T.init l w ;
     w = w ;
     hash_fns = Array.init l gen_rand_pair}

  (* Initialize a sketch with approximation ratio 1 + epsilon 
   * and failure probability delta *)
  let init epsilon delta =
    (* set l = log (1/delta) and w = 1/epsilon *)
    init_lw (Owl.Maths.(1. /. delta |> log2 |> ceil |> int_of_float))
            (Owl.Maths.(1. /. epsilon |> ceil |> int_of_float))
  
  (* increment the count of x in sketch s *)
  let incr s x = 
    let iterfn (i, ai, bi) = T.incr i ((hash31 x ai bi) mod s.w) s.tbl in
    Array.iter iterfn s.hash_fns

  (* get the current estimate of the count of x in sketch s *)
  let count s x = 
    let foldfn prv (i, ai, bi) =
      T.get i ((hash31 x ai bi) mod s.w) s.tbl |> min prv in
    Array.fold_left foldfn max_int s.hash_fns
end

module Countmin_native = Make(Countmin_table_sig.Native_table)
module Countmin_owl = Make(Countmin_table_sig.Owl_table)

(* simple test - add a bunch of elements with skewed distribution to the sketch then count them *)
let simple_test_countmin eps del =
  let module CM = Countmin_native in
  let s = CM.init eps del in
  for x = 1 to 30 do
    Printf.printf "expected count of %2d : %5d \n" x (10000 / x) ;
    for i = 1 to 10000 / x do
      CM.incr s x
    done
  done;
  for x = 1 to 30 do
    CM.count s x |> Printf.printf "count of %2d : %5d \n" x
  done

(* Test the Countmin sketch by putting n samples from the function distr
 * into a sketch and into the hashtable-based naive frequency counter, then
 * comparing their outputs *)
let test_countmin_hashtbl distr eps del n =
  let module CM = Countmin_native in 
  let ht_count t x = 
    match Hashtbl.find_opt t x with
    | Some c -> c
    | None -> 0 in
  let ht_incr t x = Hashtbl.replace t x ((ht_count t x) + 1) in
  let s = CM.init eps del in
  let t = Hashtbl.create n in
  for i = 1 to n do
    let v = distr () in
    CM.incr s v ; ht_incr t v
  done;
  let foldfn v ct lst = (v, ct, CM.count s v) :: lst in
  let outputs = Hashtbl.fold foldfn t [] |> List.sort (fun (a,_,_) (b,_,_) -> a - b) in
  let diffs = List.map (fun (_, tct, sct) -> (float_of_int (sct - tct)) /. (float_of_int tct)) outputs
    |> Array.of_list in
  let diffs_mat = 
    Owl.Mat.init_2d (Array.length diffs) 1 (fun i _ -> diffs.(i)) in
  let open Owl_plplot in
  let h = Plot.create "diffs.png" in
  Plot.histogram ~h ~bin:20 (diffs_mat) ;
  Plot.output h ;
  outputs, diffs
