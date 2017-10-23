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

  type arr = A.arr
  type elt = A.elt

  type t = {
    mutable op     : op;
    mutable refnum : int;
    mutable outval : arr array;
  }
  and op =
    | Noop
    | Add of t * t
    | Sub of t * t
    | Mul of t * t
    | Div of t * t
    | Sin of t
    | Cos of t


  let unpack_operands = function
    | Noop       -> [| |]
    | Add (a, b) -> [|a; b|]
    | Sub (a, b) -> [|a; b|]
    | Mul (a, b) -> [|a; b|]
    | Div (a, b) -> [|a; b|]
    | Sin a      -> [|a|]
    | Cos a      -> [|a|]


  let inc_operand_refnum x =
    let operands = unpack_operands x in
    let s = Owl_utils.Stack.make () in
    Array.iter (fun a ->
      (* avoid increasing twice for the same operand *)
      if Owl_utils.Stack.memq s a = false then (
        Owl_utils.Stack.push s a;
        a.refnum <- a.refnum + 1
      )
    ) operands


  let make_t ?(outval=[||]) ?(refnum=0) op =
    inc_operand_refnum op;
    {
      op;
      refnum;
      outval;
    }


  let allocate_1 op =
    let a = (unpack_operands op).(0) in
    if a.refnum = 1 then a.outval.(0)
    else A.copy a.outval.(0)


  let allocate_2 operands =
    let a = operands.(0) in
    let b = operands.(1) in
    let a_val = a.outval.(0) in
    let b_val = b.outval.(0) in
    let a_shp = A.shape a_val in
    let b_shp = A.shape b_val in
    if a_shp = b_shp then (
      if a.refnum = 1 then Some (a_val, b_val)
      else if b.refnum = 1 then Some (b_val, a_val)
      else Some (A.copy a_val, b_val)
    )
    else if Owl_utils.array_greater_eqaul a_shp b_shp && a.refnum = 1 then Some (a_val, b_val)
    else if Owl_utils.array_greater_eqaul b_shp a_shp && b.refnum = 1 then Some (b_val, a_val)
    else None


  (* recursively evaluate an expression *)

  let rec _eval_term x =
    if Array.length x.outval = 0 then (
      match x.op with
      | Noop       -> ()
      | Add (a, b) -> _eval_2 x A.add_ A.add
      | Sub (a, b) -> _eval_2 x A.sub_ A.sub
      | Mul (a, b) -> _eval_2 x A.mul_ A.mul
      | Div (a, b) -> _eval_2 x A.div_ A.div
      | Sin a      -> _eval_1 x A.sin_
      | Cos a      -> _eval_1 x A.cos_

    )

  (* [f] is inpure *)
  and _eval_1 x f =
    let operands = unpack_operands x.op in
    _eval_term operands.(0);
    let a = operands.(0).outval.(0) in
    f a;
    x.outval <- [|a|]

  (* [f] is inpure and [g] is pure *)
  and _eval_2 x f g =
    let operands = unpack_operands x.op in
    _eval_term operands.(0);
    _eval_term operands.(1);
    let a = operands.(0).outval.(0) in
    let b = operands.(1).outval.(0) in
    let c = match allocate_2 operands with
      | Some (p, q) -> f p q; p    (* in-place function, p will be written *)
      | None        -> g a b       (* pure function without touching a and b *)
    in
    x.outval <- [|c|]


  let of_ndarray x = make_t ~outval:[|x|] Noop


  (* math functions *)

  let add x y = make_t (Add (x, y))

  let sub x y = make_t (Sub (x, y))

  let mul x y = make_t (Mul (x, y))

  let div x y = make_t (Div (x, y))

  let sin x = make_t (Sin x)

  let cos x = make_t (Cos x)


end
