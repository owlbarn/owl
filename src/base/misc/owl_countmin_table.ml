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
module Native : Sig = struct
  type t = int array array

  let init l w = Array.make_matrix l w 0
  let incr i j t = t.(i).(j) <- t.(i).(j) + 1
  let get i j t = t.(i).(j)
end

(* Implementation of the CountMin sketch table using Owl ndarrays *)
module Owl : Sig = struct
  type t = Owl_base_dense_ndarray_s.arr

  let init l w = Owl_base_dense_ndarray_s.zeros [| l; w |]
  let incr i j t = Owl_base_dense_ndarray_s.(set t [| i; j |] (get t [| i; j |] +. 1.))
  let get i j t = Owl_base_dense_ndarray_s.get t [| i; j |] |> int_of_float
end
