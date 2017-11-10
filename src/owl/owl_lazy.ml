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
    | Add      of t * t
    | Sub      of t * t
    | Mul      of t * t
    | Div      of t * t
    | Pow      of t * t
    | Atan2    of t * t
    | Hypot    of t * t
    | Fmod     of t * t
    | Min2     of t * t
    | Max2     of t * t
    | Add_S    of t * elt
    | Sub_S    of t * elt
    | Mul_S    of t * elt
    | Div_S    of t * elt
    | Pow_S    of t * elt
    | Atan2_S  of t * elt
    | Fmod_S   of t * elt
    | S_Add    of elt * t
    | S_Sub    of elt * t
    | S_Mul    of elt * t
    | S_Div    of elt * t
    | S_Pow    of elt * t
    | S_Atan2  of elt * t
    | S_Fmod   of elt * t
    | Neg      of t
    | Conj     of t
    | Reci     of t
    | Signum   of t
    | Sqr      of t
    | Sqrt     of t
    | Cbrt     of t
    | Exp      of t
    | Exp2     of t
    | Exp10    of t
    | Expm1    of t
    | Log      of t
    | Log2     of t
    | Log10    of t
    | Log1p    of t
    | Sin      of t
    | Cos      of t
    | Tan      of t
    | Asin     of t
    | Acos     of t
    | Atan     of t
    | Sinh     of t
    | Cosh     of t
    | Tanh     of t
    | Asinh    of t
    | Acosh    of t
    | Atanh    of t
    | Floor    of t
    | Ceil     of t
    | Round    of t
    | Trunc    of t
    | Fix      of t
    | Erf      of t
    | Erfc     of t
    | Relu     of t
    | Softplus of t
    | Softsign of t
    | Softmax  of t
    | Sigmoid  of t
    | Sum      of t
    | Prod     of t
    | Min      of t
    | Max      of t
    | Mean     of t
    | Var      of t
    | Std      of t
    | L1norm   of t
    | L2norm   of t
    | Cumsum   of t
    | Cumprod  of t
    | Cummin   of t
    | Cummax   of t
    | Conv1D   of t * arr * int array * padding option
    | Conv2D   of t * arr * int array * padding option
    | Conv3D   of t * arr * int array * padding option
    | MaxPool1D of t * int array * int array * padding option
    | MaxPool2D of t * int array * int array * padding option
    | MaxPool3D of t * int array * int array * padding option
    | AvgPool1D of t * int array * int array * padding option
    | AvgPool2D of t * int array * int array * padding option
    | AvgPool3D of t * int array * int array * padding option
    | Copy     of t
    | Reshape  of t * int array
    | Tile     of t * int array
    | Repeat   of t * int option * int
    | Concat   of t array * int option
    | Split    of t * int option * int array
    | Item_I   of t * int (* select the ith item in an array *)


  let unpack_operands = function
    | Noop             -> [| |]
    | Add (a, b)       -> [|a; b|]
    | Sub (a, b)       -> [|a; b|]
    | Mul (a, b)       -> [|a; b|]
    | Div (a, b)       -> [|a; b|]
    | Pow (a, b)       -> [|a; b|]
    | Atan2 (a, b)     -> [|a; b|]
    | Hypot (a, b)     -> [|a; b|]
    | Fmod (a, b)      -> [|a; b|]
    | Min2 (a, b)      -> [|a; b|]
    | Max2 (a, b)      -> [|a; b|]
    | Add_S (a, b)     -> [|a|]
    | Sub_S (a, b)     -> [|a|]
    | Mul_S (a, b)     -> [|a|]
    | Div_S (a, b)     -> [|a|]
    | Pow_S (a, b)     -> [|a|]
    | Atan2_S (a, b)   -> [|a|]
    | Fmod_S (a, b)    -> [|a|]
    | S_Add (a, b)     -> [|b|]
    | S_Sub (a, b)     -> [|b|]
    | S_Mul (a, b)     -> [|b|]
    | S_Div (a, b)     -> [|b|]
    | S_Pow (a, b)     -> [|b|]
    | S_Atan2 (a, b)   -> [|b|]
    | S_Fmod (a, b)    -> [|b|]
    | Neg a            -> [|a|]
    | Conj a           -> [|a|]
    | Reci a           -> [|a|]
    | Signum a         -> [|a|]
    | Sqr a            -> [|a|]
    | Sqrt a           -> [|a|]
    | Cbrt a           -> [|a|]
    | Exp a            -> [|a|]
    | Exp2 a           -> [|a|]
    | Exp10 a          -> [|a|]
    | Expm1 a          -> [|a|]
    | Log a            -> [|a|]
    | Log2 a           -> [|a|]
    | Log10 a          -> [|a|]
    | Log1p a          -> [|a|]
    | Sin a            -> [|a|]
    | Cos a            -> [|a|]
    | Tan a            -> [|a|]
    | Asin a           -> [|a|]
    | Acos a           -> [|a|]
    | Atan a           -> [|a|]
    | Sinh a           -> [|a|]
    | Cosh a           -> [|a|]
    | Tanh a           -> [|a|]
    | Asinh a          -> [|a|]
    | Acosh a          -> [|a|]
    | Atanh a          -> [|a|]
    | Floor a          -> [|a|]
    | Ceil a           -> [|a|]
    | Round a          -> [|a|]
    | Trunc a          -> [|a|]
    | Fix a            -> [|a|]
    | Erf a            -> [|a|]
    | Erfc a           -> [|a|]
    | Relu a           -> [|a|]
    | Softplus a       -> [|a|]
    | Softsign a       -> [|a|]
    | Softmax a        -> [|a|]
    | Sigmoid a        -> [|a|]
    | Sum a            -> [|a|]
    | Prod a           -> [|a|]
    | Min a            -> [|a|]
    | Max a            -> [|a|]
    | Mean a           -> [|a|]
    | Var a            -> [|a|]
    | Std a            -> [|a|]
    | L1norm a         -> [|a|]
    | L2norm a         -> [|a|]
    | Cumsum a         -> [|a|]
    | Cumprod a        -> [|a|]
    | Cummin a         -> [|a|]
    | Cummax a         -> [|a|]
    | Conv1D (a, b, c, d) -> [|a|]
    | Conv2D (a, b, c, d) -> [|a|]
    | Conv3D (a, b, c, d) -> [|a|]
    | MaxPool1D (a, b, c, d) -> [|a|]
    | MaxPool2D (a, b, c, d) -> [|a|]
    | MaxPool3D (a, b, c, d) -> [|a|]
    | AvgPool1D (a, b, c, d) -> [|a|]
    | AvgPool2D (a, b, c, d) -> [|a|]
    | AvgPool3D (a, b, c, d) -> [|a|]
    | Copy a           -> [|a|]
    | Reshape (a, b)   -> [|a|]
    | Tile (a, b)      -> [|a|]
    | Repeat (a, b, c) -> [|a|]
    | Concat (a, b)    ->   a
    | Split (a, b, c)  -> [|a|]
    | Item_I (a, b)    -> [|a|]


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
      | Noop             -> ()
      | Add (a, b)       -> _eval_map2 x A.add_ A.add
      | Sub (a, b)       -> _eval_map2 x A.sub_ A.sub
      | Mul (a, b)       -> _eval_map2 x A.mul_ A.mul
      | Div (a, b)       -> _eval_map2 x A.div_ A.div
      | Pow (a, b)       -> _eval_map2 x A.pow_ A.pow
      | Atan2 (a, b)     -> _eval_map2 x A.atan2_ A.atan2
      | Hypot (a, b)     -> _eval_map2 x A.hypot_ A.hypot
      | Fmod (a, b)      -> _eval_map2 x A.fmod_ A.fmod
      | Min2 (a, b)      -> _eval_map2 x A.min2_ A.min2
      | Max2 (a, b)      -> _eval_map2 x A.max2_ A.max2
      | Add_S (a, b)     -> _eval_map3 x b A.add_scalar_
      | Sub_S (a, b)     -> _eval_map3 x b A.sub_scalar_
      | Mul_S (a, b)     -> _eval_map3 x b A.mul_scalar_
      | Div_S (a, b)     -> _eval_map3 x b A.div_scalar_
      | Pow_S (a, b)     -> _eval_map3 x b A.pow_scalar_
      | Atan2_S (a, b)   -> _eval_map3 x b A.atan2_scalar_
      | Fmod_S (a, b)    -> _eval_map3 x b A.fmod_scalar_
      | S_Add (a, b)     -> _eval_map4 x a A.scalar_add_
      | S_Sub (a, b)     -> _eval_map4 x a A.scalar_sub_
      | S_Mul (a, b)     -> _eval_map4 x a A.scalar_mul_
      | S_Div (a, b)     -> _eval_map4 x a A.scalar_div_
      | S_Pow (a, b)     -> _eval_map4 x a A.scalar_pow_
      | S_Atan2 (a, b)   -> _eval_map4 x a A.scalar_atan2_
      | S_Fmod (a, b)    -> _eval_map4 x a A.scalar_fmod_
      | Neg a            -> _eval_map1 x A.neg_
      | Conj a           -> _eval_map1 x A.conj_
      | Reci a           -> _eval_map1 x A.reci_
      | Signum a         -> _eval_map1 x A.signum_
      | Sqr a            -> _eval_map1 x A.sqr_
      | Sqrt a           -> _eval_map1 x A.sqrt_
      | Cbrt a           -> _eval_map1 x A.cbrt_
      | Exp a            -> _eval_map1 x A.exp_
      | Exp2 a           -> _eval_map1 x A.exp2_
      | Exp10 a          -> _eval_map1 x A.exp10_
      | Expm1 a          -> _eval_map1 x A.expm1_
      | Log a            -> _eval_map1 x A.log_
      | Log2 a           -> _eval_map1 x A.log2_
      | Log10 a          -> _eval_map1 x A.log10_
      | Log1p a          -> _eval_map1 x A.log1p_
      | Sin a            -> _eval_map1 x A.sin_
      | Cos a            -> _eval_map1 x A.cos_
      | Tan a            -> _eval_map1 x A.tan_
      | Asin a           -> _eval_map1 x A.asin_
      | Acos a           -> _eval_map1 x A.acos_
      | Atan a           -> _eval_map1 x A.atan_
      | Sinh a           -> _eval_map1 x A.sinh_
      | Cosh a           -> _eval_map1 x A.cosh_
      | Tanh a           -> _eval_map1 x A.tanh_
      | Asinh a          -> _eval_map1 x A.asinh_
      | Acosh a          -> _eval_map1 x A.acosh_
      | Atanh a          -> _eval_map1 x A.atanh_
      | Floor a          -> _eval_map1 x A.floor_
      | Ceil a           -> _eval_map1 x A.ceil_
      | Round a          -> _eval_map1 x A.round_
      | Trunc a          -> _eval_map1 x A.trunc_
      | Fix a            -> _eval_map1 x A.fix_
      | Erf a            -> _eval_map1 x A.erf_
      | Erfc a           -> _eval_map1 x A.erfc_
      | Relu a           -> _eval_map1 x A.relu_
      | Softplus a       -> _eval_map1 x A.softplus_
      | Softsign a       -> _eval_map1 x A.softsign_
      | Softmax a        -> _eval_map1 x A.softmax_
      | Sigmoid a        -> _eval_map1 x A.sigmoid_
      | Sum a            -> _eval_reduce x A.sum
      | Prod a           -> _eval_reduce x A.prod
      | Min a            -> _eval_reduce x A.min
      | Max a            -> _eval_reduce x A.max
      | Mean a           -> _eval_reduce x A.mean
      | Var a            -> _eval_reduce x A.var
      | Std a            -> _eval_reduce x A.std
      | L1norm a         -> _eval_reduce x A.l1norm
      | L2norm a         -> _eval_reduce x A.l2norm
      | Cumsum a         -> _eval_map1 x A.cumsum_
      | Cumprod a        -> _eval_map1 x A.cumprod_
      | Cummin a         -> _eval_map1 x A.cummin_
      | Cummax a         -> _eval_map1 x A.cummax_
      | Conv1D (a, b, c, d) -> _eval_map5 x (fun x -> A.conv1d ?padding:d x b c)
      | Conv2D (a, b, c, d) -> _eval_map5 x (fun x -> A.conv2d ?padding:d x b c)
      | Conv3D (a, b, c, d) -> _eval_map5 x (fun x -> A.conv3d ?padding:d x b c)
      | MaxPool1D (a, b, c, d) -> _eval_map5 x (fun x -> A.max_pool1d ?padding:d x b c)
      | MaxPool2D (a, b, c, d) -> _eval_map5 x (fun x -> A.max_pool2d ?padding:d x b c)
      | MaxPool3D (a, b, c, d) -> _eval_map5 x (fun x -> A.max_pool3d ?padding:d x b c)
      | AvgPool1D (a, b, c, d) -> _eval_map5 x (fun x -> A.avg_pool1d ?padding:d x b c)
      | AvgPool2D (a, b, c, d) -> _eval_map5 x (fun x -> A.avg_pool2d ?padding:d x b c)
      | AvgPool3D (a, b, c, d) -> _eval_map5 x (fun x -> A.avg_pool3d ?padding:d x b c)
      | Copy a           -> _eval_map1 x ignore
      | Reshape (a, b)   -> failwith "reshape: not implmented"
      | Tile (a, b)      -> _eval_map5 x (fun x -> A.tile x b)
      | Repeat (a, b, c) -> _eval_map5 x (fun x -> A.repeat ?axis:b x c)
      | Concat (a, b)    -> _eval_map6 x (fun x -> A.concatenate ?axis:b x)
      | Split (a, b, c)  -> _eval_map7 x (fun x -> A.split ?axis:b c x)
      | Item_I (a, b)    -> _item_i x b
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

  (* [f] is inpure, for [elt -> arr -> arr] *)
  and _eval_map4 x a f =
    let operands = unpack_operands x.op in
    _eval_term operands.(0);
    let b = allocate_1 operands in
    f a b;
    x.outval <- [|b|]

  (* [f] is pure, shape changes so always allocate mem, for [arr -> arr] *)
  and _eval_map5 x f =
    let operands = unpack_operands x.op in
    _eval_term operands.(0);
    let a = operands.(0).outval.(0) in
    x.outval <- [|f a|]

  (* [f] is pure, shape changes so always allocate mem, for [arr array -> arr] *)
  and _eval_map6 x f =
    let operands = unpack_operands x.op in
    let a = Array.map (fun x -> _eval_term x; x.outval.(0)) operands in
    x.outval <- [|f a|]

  (* [f] is pure, allocate mem, for [arr -> arr array] *)
  and _eval_map7 x f =
    let operands = unpack_operands x.op in
    _eval_term operands.(0);
    let a = operands.(0).outval.(0) in
    x.outval <- f a

  (* [f] is always pure, for [arr -> elt] *)
  and _eval_reduce x f =
    let operands = unpack_operands x.op in
    _eval_term operands.(0);
    let a = operands.(0).outval.(0) in
    x.outval <- [|f a|]

  (* get the specific output val of [x] for a given index *)
  and _item_i x i =
    let operands = unpack_operands x.op in
    _eval_term operands.(0);
    assert (i < Array.length operands.(0).outval);
    x.outval <- [|operands.(0).outval.(i)|]


  let of_ndarray x = make_t ~outval:[|x|] Noop


  let to_ndarray x =
    _eval_term x;
    x.outval.(0)


  let eval x = _eval_term x


  (* creation functions *)

  let empty d = A.empty d |> of_ndarray

  let zeros d = A.zeros d |> of_ndarray

  let ones d = A.ones d |> of_ndarray

  let uniform ?scale d = A.uniform ?scale d |> of_ndarray

  let gaussian ?sigma d = A.gaussian ?sigma d |> of_ndarray

  let bernoulli ?p ?seed d = A.bernoulli ?p ?seed d |> of_ndarray


  (* properties and manipulations *)

  let shape x = to_ndarray x |> A.shape

  let numel x = to_ndarray x |> A.numel

  let get x i = A.get (to_ndarray x) i

  let set x i a = A.set (to_ndarray x) i a

  let copy x = make_t (Copy x)

  let reset x = A.reset (to_ndarray x)

  let reshape x d = make_t (Reshape (x, d))

  let tile x reps = make_t (Tile (x, reps))

  let repeat ?axis x reps = make_t (Repeat (x, axis, reps))

  let concatenate ?axis x = make_t (Concat (x, axis))

  let split ?axis parts x =
    let t = make_t (Split (x, axis, parts)) in
    Array.mapi (fun i _ -> make_t (Item_I (t, i))) parts


  (* reduce to scalar *)

  let sum' x = to_ndarray x |> A.sum'

  let prod' x = to_ndarray x |> A.prod'

  let min' x = to_ndarray x |> A.min'

  let max' x = to_ndarray x |> A.max'

  let mean' x = to_ndarray x |> A.mean'

  let var' x = to_ndarray x |> A.var'

  let std' x = to_ndarray x |> A.std'

  let l1norm' x = to_ndarray x |> A.l1norm'

  let l2norm' x = to_ndarray x |> A.l2norm'

  let l2norm_sqr' x = to_ndarray x |> A.l2norm_sqr'


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

  let erf x = make_t (Erf x)

  let erfc x = make_t (Erfc x)

  let relu x = make_t (Relu x)

  let softplus x = make_t (Softplus x)

  let softsign x = make_t (Softsign x)

  let softmax x = make_t (Softmax x)

  let sigmoid x = make_t (Sigmoid x)

  let sum ?axis x = make_t (Sum x)

  let prod ?axis x = make_t (Prod x)

  let min ?axis x = make_t (Min x)

  let max ?axis x = make_t (Max x)

  let mean ?axis x = make_t (Mean x)

  let var ?axis x = make_t (Var x)

  let std ?axis x = make_t (Std x)

  let l1norm ?axis x = make_t (L1norm x)

  let l2norm ?axis x = make_t (L1norm x)

  let cumsum ?axis x = make_t (Cumsum x)

  let cumprod ?axis x = make_t (Cumprod x)

  let cummin ?axis x = make_t (Cummin x)

  let cummax ?axis x = make_t (Cummax x)

  let conv1d ?padding input kernel stride = make_t (Conv1D (input, kernel, stride, padding))

  let conv2d ?padding input kernel stride = make_t (Conv2D (input, kernel, stride, padding))

  let conv3d ?padding input kernel stride = make_t (Conv3D (input, kernel, stride, padding))

  let max_pool1d ?padding input kernel stride = make_t (MaxPool1D (input, kernel, stride, padding))

  let max_pool2d ?padding input kernel stride = make_t (MaxPool2D (input, kernel, stride, padding))

  let max_pool3d ?padding input kernel stride = make_t (MaxPool3D (input, kernel, stride, padding))

  let avg_pool1d ?padding input kernel stride = make_t (AvgPool1D (input, kernel, stride, padding))

  let avg_pool2d ?padding input kernel stride = make_t (AvgPool2D (input, kernel, stride, padding))

  let avg_pool3d ?padding input kernel stride = make_t (AvgPool3D (input, kernel, stride, padding))

end
