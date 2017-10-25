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
    | Add   of t * t
    | Sub   of t * t
    | Mul   of t * t
    | Div   of t * t
    | Add_S of t * elt
    | Sub_S of t * elt
    | Mul_S of t * elt
    | Div_S of t * elt
    | S_Add of elt * t
    | S_Sub of elt * t
    | S_Mul of elt * t
    | S_Div of elt * t
    | Sin   of t
    | Cos   of t
    | Sum   of t


  let unpack_operands = function
    | Noop         -> [| |]
    | Add (a, b)   -> [|a; b|]
    | Sub (a, b)   -> [|a; b|]
    | Mul (a, b)   -> [|a; b|]
    | Div (a, b)   -> [|a; b|]
    | Add_S (a, b) -> [|a|]
    | Sub_S (a, b) -> [|a|]
    | Mul_S (a, b) -> [|a|]
    | Div_S (a, b) -> [|a|]
    | S_Add (a, b) -> [|b|]
    | S_Sub (a, b) -> [|b|]
    | S_Mul (a, b) -> [|b|]
    | S_Div (a, b) -> [|b|]
    | Sin a        -> [|a|]
    | Cos a        -> [|a|]
    | Sum a        -> [|a|]


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


  let allocate_1 operands =
    let a = operands.(0) in
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
      | Noop         -> ()
      | Add (a, b)   -> _eval_map2 x A.add_ A.add
      | Sub (a, b)   -> _eval_map2 x A.sub_ A.sub
      | Mul (a, b)   -> _eval_map2 x A.mul_ A.mul
      | Div (a, b)   -> _eval_map2 x A.div_ A.div
      | Add_S (a, b) -> _eval_map3 x b A.add_scalar_
      | Sub_S (a, b) -> _eval_map3 x b A.sub_scalar_
      | Mul_S (a, b) -> _eval_map3 x b A.mul_scalar_
      | Div_S (a, b) -> _eval_map3 x b A.div_scalar_
      | S_Add (a, b) -> _eval_map4 x a A.scalar_add_
      | S_Sub (a, b) -> _eval_map4 x a A.scalar_sub_
      | S_Mul (a, b) -> _eval_map4 x a A.scalar_mul_
      | S_Div (a, b) -> _eval_map4 x a A.scalar_div_
      | Sin a        -> _eval_map1 x A.sin_
      | Cos a        -> _eval_map1 x A.cos_
      | Sum a        -> _eval_reduce x A.sum
    )

  (* [f] is inpure, for [arr -> arr] *)
  and _eval_map1 x f =
    let operands = unpack_operands x.op in
    _eval_term operands.(0);
    let a = allocate_1 operands in
    f a;
    x.outval <- [|a|]

  (* [f] is inpure and [g] is pure, for [arr -> arr -> arr] *)
  and _eval_map2 x f g =
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

  (* [f] is inpure, for [arr -> elt -> arr] *)
  and _eval_map3 x b f =
    let operands = unpack_operands x.op in
    _eval_term operands.(0);
    let a = allocate_1 operands in
    f a b;
    x.outval <- [|a|]

  (* [f] is inpure, for [elt -> add -> arr] *)
  and _eval_map4 x a f =
    let operands = unpack_operands x.op in
    _eval_term operands.(0);
    let b = allocate_1 operands in
    f a b;
    x.outval <- [|b|]

  (* [f] is always pure, for [arr -> elt] *)
  and _eval_reduce x f =
    let operands = unpack_operands x.op in
    _eval_term operands.(0);
    let a = operands.(0).outval.(0) in
    x.outval <- [|f a|]


  let of_ndarray x = make_t ~outval:[|x|] Noop


  let to_ndarray x =
    _eval_term x;
    x.outval.(0)


  (* math functions *)

  let add x y = make_t (Add (x, y))

  let sub x y = make_t (Sub (x, y))

  let mul x y = make_t (Mul (x, y))

  let div x y = make_t (Div (x, y))

  let add_scalar x a = make_t (Add_S (x, a))

  let sub_scalar x a = make_t (Sub_S (x, a))

  let mul_scalar x a = make_t (Mul_S (x, a))

  let div_scalar x a = make_t (Div_S (x, a))

  let scalar_add a x = make_t (S_Add (a, x))

  let scalar_sub a x = make_t (S_Sub (a, x))

  let scalar_mul a x = make_t (S_Mul (a, x))

  let scalar_div a x = make_t (S_Div (a, x))

  let sin x = make_t (Sin x)

  let cos x = make_t (Cos x)

  let sum ?axis x = make_t (Sum x)


end
