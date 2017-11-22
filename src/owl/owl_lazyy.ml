(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

module S = Pervasives


(* Functor of making Lazy module of different number types *)

module Make
  (A : InpureSig)
  = struct

  (* type definitions *)

  type state = Valid | Invalid

  type value =
    | Var
    | Elt of A.elt
    | Arr of A.arr

  type node = {
    mutable op    : op;
    mutable prev  : node array;
    mutable next  : node array;
    mutable state : state;
    mutable value : value array;
  }
  and op =
    | Noop
    | Fun00 of (A.arr -> A.arr)
    | Fun01 of (A.arr -> unit)
    | Fun02 of (A.arr -> A.arr -> unit) * (A.arr -> A.arr -> A.arr)
    | Fun03 of (A.arr -> A.elt -> unit)
    | Fun04 of (A.elt -> A.arr -> unit)
    | Fun05 of (A.arr array -> A.arr)
    | Fun06 of (A.arr -> A.arr array)
    | ItemI of int (* select the ith item in an array *)


  let node ?(prev=[||]) ?(next=[||]) ?(state=Invalid) ?(value=[||]) op = {
    op;
    prev;
    next;
    state;
    value;
  }


  let connect parents children =
    Array.iter (fun parent ->
      Array.iter (fun child ->
        if Array.memq child parent.next = false then
          parent.next <- (Array.append parent.next [|child|]);
        if Array.memq parent child.prev = false then
          child.prev <- (Array.append child.prev [|parent|])
      ) children
    ) parents


  let unpack_arr = function Arr x -> x | _ -> failwith "owl_lazy: unpack_arr"

  let unpack_elt = function Elt x -> x | _ -> failwith "owl_lazy: unpack_elt"

  let refnum x = Array.length x.next

  let allocate_1 x =
    let value = unpack_arr x.value.(0) in
    if refnum x = 1 then value
    else A.copy value


  let rec _eval_term x =
    if Array.length x.value = 0 then (
      match x.op with
      | Noop         -> ()
      | Fun00 f      -> ()
      | Fun01 f      -> ()
      | Fun02 (f, g) -> ()
      | Fun03 f      -> ()
      | Fun04 f      -> ()
      | Fun05 f      -> ()
      | Fun06 f      -> ()
      | ItemI i      -> ()
    )

    (* [f] is inpure, for [arr -> arr] *)
    (*and _eval_map1 x f =
      let operand = unpack_arr x.op in
      _eval_term operands.(0);
      let a = allocate_1 operands in
      f a;
      x.outval <- [|a|]*)


  let add x y =
    let z = node (Fun02 (A.add_, A.add)) in
    connect [|x|] [|z|];
    connect [|y|] [|z|];
    z


  let sin x =
    let y = node (Fun01 A.sin_) in
    connect [|x|] [|y|];
    y




end
