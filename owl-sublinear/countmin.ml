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


(* Functor to make the CountMin sketch using different underlying tables *)

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
      let cur = T.get i ((hash31 x ai bi) mod s.w) s.tbl in
      min cur prv in
    Array.fold_left foldfn max_int s.hash_fns
end

module Countmin_native = Make(Countmin_table_sig.Native_table)
module Countmin_owl = Make(Countmin_table_sig.Owl_table)

(* simple test - add a bunch of elements to the sketch then count them *)
let testfn eps del =
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