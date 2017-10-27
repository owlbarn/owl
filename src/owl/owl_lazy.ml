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
    | Sin of t
    | Cos of t


  let unpack_operands = function
    | Noop       -> [| |]
    | Add (a, b) -> [|a; b|]
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
    else A.clone a.outval.(0)


  (* FIXME: broadcast *)
  let allocate_2 op =
    let operands = unpack_operands op in
    let a = operands.(0) in
    let b = operands.(1) in
    let mem =
      if a.refnum = 1 then a.outval.(0)
      else A.clone a.outval.(0)
    in
    mem, b.outval.(0)


  (* recursively evaluate an expression *)

  let rec _eval_term x =
    if Array.length x.outval = 0 then (
      match x.op with
      | Noop       -> ()
      | Add (a, b) -> (_eval_term a; _eval_term b; let c_val, d_val = allocate_2 x.op in x.outval <- [|c_val|]; A.add_ c_val d_val)
      | Sin a      -> (_eval_term a; let a_val = allocate_1 x.op in x.outval <- [|a_val|]; A.sin_ a_val)
      | Cos a      -> (_eval_term a; let a_val = allocate_1 x.op in x.outval <- [|a_val|]; A.cos_ a_val)

    )


  let of_ndarray x = make_t ~outval:[|x|] Noop


  (* math functions *)

  let add x y = make_t (Add (x, y))

  let sin x = make_t (Sin x)

  let cos x = make_t (Cos x)


end
