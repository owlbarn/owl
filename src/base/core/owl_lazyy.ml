(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types

open Owl_graph


(* Functor of making a Lazy engine to execute a computation graph. *)

module Make (A : Ndarray_Algodiff) = struct

  include Owl_computation_graph.Make (A)


  let rec _eval_term x =
    if is_valid x = false then (
      let _ = match (get_operator x) with
        | Var          -> is_assigned x; Printf.printf "var"
        | Sin          -> _eval_map_0 x A.sin
        | _            -> Owl_log.warn "unknown"
      in
      validate x
    )

    (* [f] is pure, shape changes so always allocate mem, for [arr -> arr] *)
    and _eval_map_0 x f =
      let x_parent = (parents x).(0) in
      _eval_term x_parent;
      let a = (get_value x_parent).(0) |> value_to_arr |> f in
      set_value x [|arr_to_value a|]


  let eval_elt x = None


  let eval_arr x = arr_to_node x |> _eval_term


end
