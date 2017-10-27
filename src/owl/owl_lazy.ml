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
    | Add     of t * t
    | Sub     of t * t
    | Mul     of t * t
    | Div     of t * t
    | Pow     of t * t
    | Atan2   of t * t
    | Hypot   of t * t
    | Fmod    of t * t
    | Min2    of t * t
    | Max2    of t * t
    | Add_S   of t * elt
    | Sub_S   of t * elt
    | Mul_S   of t * elt
    | Div_S   of t * elt
    | Pow_S   of t * elt
    | Atan2_S of t * elt
    | Fmod_S  of t * elt
    | S_Add   of elt * t
    | S_Sub   of elt * t
    | S_Mul   of elt * t
    | S_Div   of elt * t
    | S_Pow   of elt * t
    | S_Atan2 of elt * t
    | S_Fmod  of elt * t
    | Neg     of t
    | Conj    of t
    | Reci    of t
    | Signum  of t
    | Sqr     of t
    | Sqrt    of t
    | Cbrt    of t
    | Exp     of t
    | Exp2    of t
    | Exp10   of t
    | Expm1   of t
    | Log     of t
    | Log2    of t
    | Log10   of t
    | Log1p   of t
    | Sin     of t
    | Cos     of t
    | Tan     of t
    | Asin    of t
    | Acos    of t
    | Atan    of t
    | Sinh    of t
    | Cosh    of t
    | Tanh    of t
    | Asinh   of t
    | Acosh   of t
    | Atanh   of t
    | Floor   of t
    | Ceil    of t
    | Round   of t
    | Trunc   of t
    | Fix     of t
    | Sum     of t
    | Prod    of t


  let unpack_operands = function
    | Noop           -> [| |]
    | Add (a, b)     -> [|a; b|]
    | Sub (a, b)     -> [|a; b|]
    | Mul (a, b)     -> [|a; b|]
    | Div (a, b)     -> [|a; b|]
    | Pow (a, b)     -> [|a; b|]
    | Atan2 (a, b)   -> [|a; b|]
    | Hypot (a, b)   -> [|a; b|]
    | Fmod (a, b)    -> [|a; b|]
    | Min2 (a, b)    -> [|a; b|]
    | Max2 (a, b)    -> [|a; b|]
    | Add_S (a, b)   -> [|a|]
    | Sub_S (a, b)   -> [|a|]
    | Mul_S (a, b)   -> [|a|]
    | Div_S (a, b)   -> [|a|]
    | Pow_S (a, b)   -> [|a|]
    | Atan2_S (a, b) -> [|a|]
    | Fmod_S (a, b)  -> [|a|]
    | S_Add (a, b)   -> [|b|]
    | S_Sub (a, b)   -> [|b|]
    | S_Mul (a, b)   -> [|b|]
    | S_Div (a, b)   -> [|b|]
    | S_Pow (a, b)   -> [|b|]
    | S_Atan2 (a, b) -> [|b|]
    | S_Fmod (a, b)  -> [|b|]
    | Neg a          -> [|a|]
    | Conj a         -> [|a|]
    | Reci a         -> [|a|]
    | Signum a       -> [|a|]
    | Sqr a          -> [|a|]
    | Sqrt a         -> [|a|]
    | Cbrt a         -> [|a|]
    | Exp a          -> [|a|]
    | Exp2 a         -> [|a|]
    | Exp10 a        -> [|a|]
    | Expm1 a        -> [|a|]
    | Log a          -> [|a|]
    | Log2 a         -> [|a|]
    | Log10 a        -> [|a|]
    | Log1p a        -> [|a|]
    | Sin a          -> [|a|]
    | Cos a          -> [|a|]
    | Tan a          -> [|a|]
    | Asin a         -> [|a|]
    | Acos a         -> [|a|]
    | Atan a         -> [|a|]
    | Sinh a         -> [|a|]
    | Cosh a         -> [|a|]
    | Tanh a         -> [|a|]
    | Asinh a        -> [|a|]
    | Acosh a        -> [|a|]
    | Atanh a        -> [|a|]
    | Floor a        -> [|a|]
    | Ceil a         -> [|a|]
    | Round a        -> [|a|]
    | Trunc a        -> [|a|]
    | Fix a          -> [|a|]
    | Sum a          -> [|a|]
    | Prod a         -> [|a|]


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
      | Noop           -> ()
      | Add (a, b)     -> _eval_map2 x A.add_ A.add
      | Sub (a, b)     -> _eval_map2 x A.sub_ A.sub
      | Mul (a, b)     -> _eval_map2 x A.mul_ A.mul
      | Div (a, b)     -> _eval_map2 x A.div_ A.div
      | Pow (a, b)     -> _eval_map2 x A.pow_ A.pow
      | Atan2 (a, b)   -> _eval_map2 x A.atan2_ A.atan2
      | Hypot (a, b)   -> _eval_map2 x A.hypot_ A.hypot
      | Fmod (a, b)    -> _eval_map2 x A.fmod_ A.fmod
      | Min2 (a, b)    -> _eval_map2 x A.min2_ A.min2
      | Max2 (a, b)    -> _eval_map2 x A.max2_ A.max2
      | Add_S (a, b)   -> _eval_map3 x b A.add_scalar_
      | Sub_S (a, b)   -> _eval_map3 x b A.sub_scalar_
      | Mul_S (a, b)   -> _eval_map3 x b A.mul_scalar_
      | Div_S (a, b)   -> _eval_map3 x b A.div_scalar_
      | Pow_S (a, b)   -> _eval_map3 x b A.pow_scalar_
      | Atan2_S (a, b) -> _eval_map3 x b A.atan2_scalar_
      | Fmod_S (a, b)  -> _eval_map3 x b A.fmod_scalar_
      | S_Add (a, b)   -> _eval_map4 x a A.scalar_add_
      | S_Sub (a, b)   -> _eval_map4 x a A.scalar_sub_
      | S_Mul (a, b)   -> _eval_map4 x a A.scalar_mul_
      | S_Div (a, b)   -> _eval_map4 x a A.scalar_div_
      | S_Pow (a, b)   -> _eval_map4 x a A.scalar_pow_
      | S_Atan2 (a, b) -> _eval_map4 x a A.scalar_atan2_
      | S_Fmod (a, b)  -> _eval_map4 x a A.scalar_fmod_
      | Neg a          -> _eval_map1 x A.neg_
      | Conj a         -> _eval_map1 x A.conj_
      | Reci a         -> _eval_map1 x A.reci_
      | Signum a       -> _eval_map1 x A.signum_
      | Sqr a          -> _eval_map1 x A.sqr_
      | Sqrt a         -> _eval_map1 x A.sqrt_
      | Cbrt a         -> _eval_map1 x A.cbrt_
      | Exp a          -> _eval_map1 x A.exp_
      | Exp2 a         -> _eval_map1 x A.exp2_
      | Exp10 a        -> _eval_map1 x A.exp10_
      | Expm1 a        -> _eval_map1 x A.expm1_
      | Log a          -> _eval_map1 x A.log_
      | Log2 a         -> _eval_map1 x A.log2_
      | Log10 a        -> _eval_map1 x A.log10_
      | Log1p a        -> _eval_map1 x A.log1p_
      | Sin a          -> _eval_map1 x A.sin_
      | Cos a          -> _eval_map1 x A.cos_
      | Tan a          -> _eval_map1 x A.tan_
      | Asin a         -> _eval_map1 x A.asin_
      | Acos a         -> _eval_map1 x A.acos_
      | Atan a         -> _eval_map1 x A.atan_
      | Sinh a         -> _eval_map1 x A.sinh_
      | Cosh a         -> _eval_map1 x A.cosh_
      | Tanh a         -> _eval_map1 x A.tanh_
      | Asinh a        -> _eval_map1 x A.asinh_
      | Acosh a        -> _eval_map1 x A.acosh_
      | Atanh a        -> _eval_map1 x A.atanh_
      | Floor a        -> _eval_map1 x A.floor_
      | Ceil a         -> _eval_map1 x A.ceil_
      | Round a        -> _eval_map1 x A.round_
      | Trunc a        -> _eval_map1 x A.trunc_
      | Fix a          -> _eval_map1 x A.fix_
      | Sum a          -> _eval_reduce x A.sum
      | Prod a         -> _eval_reduce x A.prod
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


  let eval x = _eval_term x


  (* math functions *)

  let add x y = make_t (Add (x, y))

  let sub x y = make_t (Sub (x, y))

  let mul x y = make_t (Mul (x, y))

  let div x y = make_t (Div (x, y))

  let pow x y = make_t (Pow (x, y))

  let atan2 x y = make_t (Atan2 (x, y))

  let hypot x y = make_t (Hypot (x, y))

  let fmod x y = make_t (Fmod (x, y))

  let min2 x y = make_t (Min2 (x, y))

  let max2 x y = make_t (Max2 (x, y))

  let add_scalar x a = make_t (Add_S (x, a))

  let sub_scalar x a = make_t (Sub_S (x, a))

  let mul_scalar x a = make_t (Mul_S (x, a))

  let div_scalar x a = make_t (Div_S (x, a))

  let pow_scalar x a = make_t (Pow_S (x, a))

  let atan2_scalar x a = make_t (Atan2_S (x, a))

  let fmod_scalar x a = make_t (Fmod_S (x, a))

  let scalar_add a x = make_t (S_Add (a, x))

  let scalar_sub a x = make_t (S_Sub (a, x))

  let scalar_mul a x = make_t (S_Mul (a, x))

  let scalar_div a x = make_t (S_Div (a, x))

  let scalar_pow a x = make_t (S_Pow (a, x))

  let scalar_atan2 a x = make_t (S_Atan2 (a, x))

  let scalar_fmod a x = make_t (S_Fmod (a, x))

  let neg x = make_t (Neg x)

  let conj x = make_t (Conj x)

  let reci x = make_t (Reci x)

  let signum x = make_t (Signum x)

  let sqr x = make_t (Sqr x)

  let sqrt x = make_t (Sqrt x)

  let cbrt x = make_t (Cbrt x)

  let exp x = make_t (Exp x)

  let exp2 x = make_t (Exp2 x)

  let exp10 x = make_t (Exp10 x)

  let expm1 x = make_t (Expm1 x)

  let log x = make_t (Log x)

  let log2 x = make_t (Log2 x)

  let log10 x = make_t (Log10 x)

  let log1p x = make_t (Log1p x)

  let sin x = make_t (Sin x)

  let cos x = make_t (Cos x)

  let tan x = make_t (Tan x)

  let asin x = make_t (Asin x)

  let acos x = make_t (Acos x)

  let atan x = make_t (Atan x)

  let sinh x = make_t (Sinh x)

  let cosh x = make_t (Cosh x)

  let tanh x = make_t (Tanh x)

  let asinh x = make_t (Asinh x)

  let acosh x = make_t (Acosh x)

  let atanh x = make_t (Atanh x)

  let floor x = make_t (Floor x)

  let ceil x = make_t (Ceil x)

  let round x = make_t (Round x)

  let trunc x = make_t (Trunc x)

  let fix x = make_t (Fix x)

  let sum ?axis x = make_t (Sum x)

  let prod ?axis x = make_t (Prod x)


end
