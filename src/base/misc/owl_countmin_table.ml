(* A module type for the tables used to implement the CountMin sketch. *)
module type Sig = sig
  

  (** {6 Type definition} *)

  type t
  (** The type of count-min tables *)


  (** {6 Core functions} *)

  val init : int -> int -> t
  (** 
  ``init l w`` generates a table with length ``l`` and width ``w``,
  all counters initialized to 0.
  *)

  val incr : int -> int -> t -> unit
  (**
  ``incr i j t`` increments the counter at length index ``i`` 
  and width index ``j`` in table ``t``.
  *)

  val get : int -> int -> t -> int
  (**
  ``get i j t`` gets the value of the counter at length index ``i`` 
  and width index ``j`` in table ``t``.
  *)

  val clone : t -> t
  (**
  ``clone t`` returns a new table with the same contents as ``t``.
  *)

  val merge : t -> t -> t option
  (**
  ``merge t1 t2`` merges tables ``t1`` and ``t2`` element-wise.  If ``t1`` and ``t2``
  have the same dimensions, ``Some t`` is returned where each element of ``t`` is the 
  sum of the corresponding elements from ``t1`` and ``t2``.  Otherwise, returns ``None``.
  *)
end

(* Implementation of the CountMin sketch table using OCaml native arrays *)
module Native : Sig = struct
  type t = int array array

  let init l w = Array.make_matrix l w 0
  let incr i j t = t.(i).(j) <- t.(i).(j) + 1
  let get i j t = t.(i).(j)
  let clone = Array.map (Array.map (fun x -> x))
  let merge t1 t2 = 
    try
      Some (Array.map2 (Array.map2 (+)) t1 t2)
    with Invalid_argument _ -> None
end

(* Implementation of the CountMin sketch table using Owl ndarrays *)
module Owl : Sig = struct
  type t = Owl_base_dense_ndarray_s.arr

  let init l w = Owl_base_dense_ndarray_s.zeros [| l; w |]
  let incr i j t = Owl_base_dense_ndarray_s.(set t [| i; j |] (get t [| i; j |] +. 1.))
  let get i j t = Owl_base_dense_ndarray_s.get t [| i; j |] |> int_of_float
  let clone t = Owl_base_dense_ndarray_s.copy t
  let merge t1 t2 = 
    let open Owl_base_dense_ndarray_s in
    if shape t1 = shape t2 then Some (add t1 t2) else None
end
