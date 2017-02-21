(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module S = Pervasives
module M = Owl_dense_real

type mat = Owl_dense_real.mat

(* type definitions *)

type t =
  | Float  of float
  | Matrix of mat
  | DF     of t * t * int                            (* primal, tangent, tag *)
  | DR     of t * t ref * trace_op * int ref * int   (* primal, adjoint, op, fanout, tag *)
and trace_op =
  | Noop
  | Add_D_D  of t * t
  | Add_D_C  of t * t
  | Add_C_D  of t * t
  | Sub_D_D  of t * t
  | Sub_D_C  of t * t
  | Sub_C_D  of t * t
  | Mul_D_D  of t * t
  | Mul_D_C  of t * t
  | Mul_C_D  of t * t
  | Div_D_D  of t * t
  | Div_D_C  of t * t
  | Div_C_D  of t * t
  | Pow_D_D  of t * t
  | Pow_D_C  of t * t
  | Pow_C_D  of t * t
  | Neg_D    of t
  | Abs_D    of t
  | Signum_D of t
  | Square_D of t
  | Sqrt_D   of t
  | Log_D    of t
  | Log2_D   of t
  | Log10_D  of t
  | Exp_D    of t
  | Sin_D    of t
  | Cos_D    of t
  | Tan_D    of t
  | Sinh_D   of t
  | Cosh_D   of t
  | Tanh_D   of t
  | Item     of t * int * int
  | AddI_D_D of t * int * int * t
  | AddI_D_C of t * int * int * t
  | AddI_C_D of t * int * int * t


let _global_tag = ref 0
let tag () = _global_tag := !_global_tag + 1; !_global_tag

(* FIXME *)
let cmp_tag ai bi =
  if ai > bi then 1
  else if ai < bi then -1
  else 0

let rec zero = function
  | Float _                 -> Float 0.
  | Matrix ap               -> Matrix M.(zeros (row_num ap) (col_num ap))
  | DF (ap, at, ai)         -> DF ((zero ap), (zero at), ai)  (* FIXME: need to check *)
  | DR (ap, at, ao, af, ai) -> DR ((zero ap), ref (zero !at), Noop, ref !af, ai)

let rec one = function
  | Float _         -> Float 1.
  | DF (ap, at, ai) -> DF ((one ap), (zero at), ai)
  | _               -> failwith "error: one : unknown type"

let primal = function
  | DF (ap, _, _)       -> ap
  | DR (ap, _, _, _, _) -> ap
  | ap                  -> ap

let tangent = function
  | DF (_, at, _) -> at
  | DR _          -> failwith "error: no tangent for DR"
  | ap            -> zero ap

let adjoint = function
  | DF _                -> failwith "error: no adjoint for DF"
  | DR (_, at, _, _, _) -> at
  | ap                  -> ref (zero ap)

let shape = function
  | Matrix ap -> M.shape ap
  | _         -> failwith "error: shape"

(* overload operators *)

module Maths = struct

  let rec noop _ = ()

  and op_d_d a ff fd df r =
    match a with
    | DF (ap, at, ai)      -> let cp = fd ap in DF (cp, (df cp ap at), ai)
    | DR (ap, _, _, _, ai) -> let cp = fd ap in DR (cp, ref (zero cp), r a, ref 0, ai)
    | ap                   -> ff ap

  and op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d =
    match a, b with
    | Float ap, DF (bp, bt, bi)                  -> let cp = fd a bp in DF (cp, (df_db cp bp bt), bi)
    | DF (ap, at, ai), Float bp                  -> let cp = fd ap b in DF (cp, (df_da cp ap at), ai)
    | Matrix ap, DF (bp, bt, bi)                 -> let cp = fd a bp in DF (cp, (df_db cp bp bt), bi)
    | DF (ap, at, ai), Matrix bp                 -> let cp = fd ap b in DF (cp, (df_da cp ap at), ai)
    | Float ap, DR (bp, _, _, _, bi)             -> let cp = fd a bp in DR (cp, ref (zero cp), r_c_d a b, ref 0, bi)
    | DR (ap, _, _, _, ai), Float bp             -> let cp = fd ap b in DR (cp, ref (zero cp), r_d_c a b, ref 0, ai)
    | Matrix ap, DR (bp, _, _, _, bi)            -> let cp = fd a bp in DR (cp, ref (zero cp), r_c_d a b, ref 0, bi)
    | DR (ap, _, _, _, ai), Matrix bp            -> let cp = fd ap b in DR (cp, ref (zero cp), r_d_c a b, ref 0, ai)
    | DF (ap, at, ai), DR (bp, _, _, _, bi)      -> (
        match cmp_tag ai bi with
        | 1  -> let cp = fd ap b in DF (cp, df_da cp ap at, ai)
        | -1 -> let cp = fd a bp in DR (cp, ref (zero cp), r_c_d a b, ref 0, bi)
        | _  -> failwith "error: forward and reverse clash at the same level"
      )
    | DR (ap, _, _, _, ai), DF (bp, bt, bi)      -> (
        match cmp_tag ai bi with
        | -1 -> let cp = fd a bp in DF (cp, df_db cp bp bt, bi)
        | 1  -> let cp = fd ap b in DR (cp, ref (zero cp), r_d_c a b, ref 0, ai)
        | _  -> failwith "error: forward and reverse clash at the same level"
      )
    | DF (ap, at, ai), DF (bp, bt, bi)           -> (
        match cmp_tag ai bi with
        | 0 -> let cp = fd ap bp in DF (cp, (df_dab cp ap at bp bt), ai)
        | 1 -> let cp = fd ap b  in DF (cp, (df_da cp ap at), ai)
        | _ -> let cp = fd a bp  in DF (cp, (df_db cp bp bt), bi)
      )
    | DR (ap, _, _, _, ai), DR (bp, _, _, _, bi) -> (
        match cmp_tag ai bi with
        | 0 -> let cp = fd ap bp in DR (cp, ref (zero cp), r_d_d a b, ref 0, ai)
        | 1 -> let cp = fd ap b  in DR (cp, ref (zero cp), r_d_c a b, ref 0, ai)
        | _ -> let cp = fd a bp  in DR (cp, ref (zero cp), r_c_d a b, ref 0, bi)
      )
    | a, b                                       -> ff a b

  and ( +. ) a b = add a b
  and add a b =
    let ff a b =
      match a, b with
      | Float a, Float b   -> Float S.(a +. b)
      | Float a, Matrix b  -> Matrix M.(a $+ b)
      | Matrix a, Float b  -> Matrix M.(a +$ b)
      | Matrix a, Matrix b -> Matrix M.(a +@ b)
      | _                  -> failwith "error: add: ff"
    in
    let fd a b = a +. b in
    let df_da cp ap at = at in
    let df_db cp bp bt = bt in
    let df_dab cp ap at bp bt = at +. bt in
    let r_d_d a b = Add_D_D (a, b) in
    let r_d_c a b = Add_D_C (a, b) in
    let r_c_d a b = Add_C_D (a, b) in
    op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

  and ( -. ) a b = sub a b
  and sub a b =
    let ff a b =
      match a, b with
      | Float a, Float b   -> Float S.(a -. b)
      | Float a, Matrix b  -> Matrix M.(a $- b)
      | Matrix a, Float b  -> Matrix M.(a -$ b)
      | Matrix a, Matrix b -> Matrix M.(a -@ b)
      | _                  -> failwith "error: sub: ff"
    in
    let fd a b = a -. b in
    let df_da cp ap at = at in
    let df_db cp bp bt = Float 0. -. bt in
    let df_dab cp ap at bp bt = at -. bt in
    let r_d_d a b = Sub_D_D (a, b) in
    let r_d_c a b = Sub_D_C (a, b) in
    let r_c_d a b = Sub_C_D (a, b) in
    op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

  and ( *. ) a b = mul a b
  and mul a b =
    let ff a b =
      match a, b with
      | Float a, Float b   -> Float S.(a *. b)
      | Float a, Matrix b  -> Matrix M.(a $* b)
      | Matrix a, Float b  -> Matrix M.(a *$ b)
      | Matrix a, Matrix b -> Matrix M.(a *@ b)
      | _                  -> failwith "error: mul: ff"
    in
    let fd a b = a *. b in
    let df_da cp ap at = at *. b in
    let df_db cp bp bt = a *. bt in
    let df_dab cp ap at bp bt = (ap *. bt) +. (at *. bp) in
    let r_d_d a b = Mul_D_D (a, b) in
    let r_d_c a b = Mul_D_C (a, b) in
    let r_c_d a b = Mul_C_D (a, b) in
    op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

  and ( /. ) a b = div a b
  and div a b =
    let ff a b =
      match a, b with
      | Float a, Float b   -> Float S.(a /. b)
      | Float a, Matrix b  -> Matrix M.(a $/ b)
      | Matrix a, Float b  -> Matrix M.(a /$ b)
      | Matrix a, Matrix b -> Matrix M.(a /@ b)
      | _                  -> failwith "error: div: ff"
    in
    let fd a b = a /. b in
    let df_da cp ap at = at /. b in
    let df_db cp bp bt = (Float 0.) -. (bt *. cp /. bp) in
    let df_dab cp ap at bp bt = (at -. bt *. cp) /. bp in
    let r_d_d a b = Div_D_D (a, b) in
    let r_d_c a b = Div_D_C (a, b) in
    let r_c_d a b = Div_C_D (a, b) in
    op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

  and ( ** ) a b = pow a b
  and pow a b =
    let ff a b =
      match a, b with
      | Float a, Float b   -> Float S.(a ** b)
      | Float a, Matrix b  -> Matrix M.(pow0 a b)
      | Matrix a, Float b  -> Matrix M.(pow1 a b)
      | Matrix a, Matrix b -> Matrix M.(pow a b)
      | _                  -> failwith "error: pow: ff"
    in
    let fd a b = a ** b in
    let df_da cp ap at = at *. (ap ** (b -. (Float 1.))) *. b in
    let df_db cp bp bt = bt *. cp *. (log a) in
    let df_dab cp ap at bp bt = (ap ** (bp -. (Float 1.))) *. ((at *. bp) +. (ap *. bt *. log ap)) in
    let r_d_d a b = Pow_D_D (a, b) in
    let r_d_c a b = Pow_D_C (a, b) in
    let r_c_d a b = Pow_C_D (a, b) in
    op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

  and neg a =
    let ff = function
      | Float a  -> Float S.(0. -. a)
      | Matrix a -> Matrix M.(neg a)
      | _        -> failwith "error: neg: ff"
    in
    let fd a = neg a in
    let df cp ap at = (Float 0.) -. at in
    let r a = Neg_D a in
    op_d_d a ff fd df r

  and abs a =
    let ff = function
      | Float a  -> Float Owl_maths.(abs a)
      | Matrix a -> Matrix M.(abs a)
      | _        -> failwith "error: abs: ff"
    in
    let fd a = abs a in
    let df cp ap at = at *. (signum ap) in
    let r a = Abs_D a in
    op_d_d a ff fd df r

  and signum a =
    let ff = function
      | Float a  -> Float Owl_maths.(signum a)
      | Matrix a -> Matrix M.(signum a)
      | _        -> failwith "error: signum: ff"
    in
    let fd a = signum a in
    let df cp ap at = zero ap in
    let r a = Signum_D a in
    op_d_d a ff fd df r

  and square a =
    let ff = function
      | Float a  -> Float S.(a *. a)
      | Matrix a -> Matrix M.(a *@ a)
      | _        -> failwith "error: square: ff"
    in
    let fd a = square a in
    let df cp ap at = (Float 2.) *. at *. ap in
    let r a = Square_D a in
    op_d_d a ff fd df r

  and sqrt a =
    let ff = function
      | Float a  -> Float S.(sqrt a)
      | Matrix a -> Matrix M.(sqrt a)
      | _        -> failwith "error: sqrt: ff"
    in
    let fd a = sqrt a in
    let df cp ap at = at /. ((Float 2.) *. cp) in
    let r a = Sqrt_D a in
    op_d_d a ff fd df r

  and log a =
    let ff = function
      | Float a  -> Float S.(log a)
      | Matrix a -> Matrix M.(log a)
      | _        -> failwith "error: log: ff"
    in
    let fd a = log a in
    let df cp ap at = at /. ap in
    let r a = Log_D a in
    op_d_d a ff fd df r

  and log2 a =
    let ff = function
      | Float a  -> Float Owl_maths.(log2 a)
      | Matrix a -> Matrix M.(log2 a)
      | _        -> failwith "error: log2: ff"
    in
    let fd a = log2 a in
    let df cp ap at = at /. (ap *. (Float Owl_maths.log2e)) in
    let r a = Log2_D a in
    op_d_d a ff fd df r

  and log10 a =
    let ff = function
      | Float a  -> Float S.(log10 a)
      | Matrix a -> Matrix M.(log10 a)
      | _        -> failwith "error: log10: ff"
    in
    let fd a = log10 a in
    let df cp ap at = at /. (ap *. (Float Owl_maths.log10e)) in
    let r a = Log10_D a in
    op_d_d a ff fd df r

  and exp a =
    let ff = function
      | Float a  -> Float S.(exp a)
      | Matrix a -> Matrix M.(exp a)
      | _        -> failwith "error: exp: ff"
    in
    let fd a = exp a in
    let df cp ap at = at *. cp in
    let r a = Exp_D a in
    op_d_d a ff fd df r

  and sin a =
    let ff = function
      | Float a  -> Float S.(sin a)
      | Matrix a -> Matrix M.(sin a)
      | _        -> failwith "error: sin: ff"
    in
    let fd a = sin a in
    let df cp ap at = at *. cos ap in
    let r a = Sin_D a in
    op_d_d a ff fd df r

  and cos a =
    let ff = function
      | Float a  -> Float S.(cos a)
      | Matrix a -> Matrix M.(cos a)
      | _        -> failwith "error: cos: ff"
    in
    let fd a = cos a in
    let df cp ap at = Float 0. -. (at *. sin ap) in
    let r a = Cos_D a in
    op_d_d a ff fd df r

  and tan a =
    let ff = function
      | Float a  -> Float S.(tan a)
      | Matrix a -> Matrix M.(tan a)
      | _        -> failwith "error: tan: ff"
    in
    let fd a = tan a in
    let df cp ap at = at /. (square (cos ap)) in
    let r a = Tan_D a in
    op_d_d a ff fd df r

  and sinh a =
    let ff = function
      | Float a  -> Float S.(sinh a)
      | Matrix a -> Matrix M.(sinh a)
      | _        -> failwith "error: sinh: ff"
    in
    let fd a = sinh a in
    let df cp ap at = at *. (cosh ap) in
    let r a = Sinh_D a in
    op_d_d a ff fd df r

  and cosh a =
    let ff = function
      | Float a  -> Float S.(cosh a)
      | Matrix a -> Matrix M.(cosh a)
      | _        -> failwith "error: cosh: ff"
    in
    let fd a = cosh a in
    let df cp ap at = at *. (sinh ap) in
    let r a = Cosh_D a in
    op_d_d a ff fd df r

  and tanh a =
    let ff = function
      | Float a  -> Float S.(tanh a)
      | Matrix a -> Matrix M.(tanh a)
      | _        -> failwith "error: tanh: ff"
    in
    let fd a = tanh a in
    let df cp ap at = at /. (square (cosh ap)) in
    let r a = Tanh_D a in
    op_d_d a ff fd df r

  and item a i j =
    match a with
    | Matrix ap            -> Float (M.get ap i j)
    | DF (ap, at, ai)      -> DF (item ap i j, item at i j, ai)
    | DR (ap, _, _, _, ai) -> DR (item ap i j, ref (Float 0.), Item (a, i, j), ref 0, ai)
    | _                    -> failwith "error: item"

  and add_item a i j b =
    let ff a b = match a, b with
      | Matrix a, Float b -> let aa = M.clone a in aa.{i,j} <- S.(aa.{i,j} +. b); Matrix aa
      | _                 -> failwith "error: add_item: ff"
    in
    let fd a b = add_item a i j b in
    let df_da cp ap at = at in
    let df_db cp bp bt = add_item (zero a) i j bt in
    let df_dab cp ap at bp bt = add_item at i j bt in
    let r_d_d a b = AddI_D_D (a, i, j, b) in
    let r_d_c a b = AddI_D_C (a, i, j, b) in
    let r_c_d a b = AddI_C_D (a, i, j, b) in
    op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

end


(* core of the reverse mode *)

let reverse_reset x =
  let rec reset xs =
    match xs with
    | [] -> ()
    | x :: t -> (
        match x with
        | DR (ap, aa, ao, af, ai) -> (
          aa := zero !aa;
          af := !af + 1;
          if !af = 1 then (
            match ao with
            | Add_D_D (a, b)        -> reset (a :: b :: t)
            | Add_D_C (a, _)        -> reset (a :: t)
            | Add_C_D (_, b)        -> reset (b :: t)
            | Sub_D_D (a, b)        -> reset (a :: b :: t)
            | Sub_D_C (a, _)        -> reset (a :: t)
            | Sub_C_D (_, b)        -> reset (b :: t)
            | Mul_D_D (a, b)        -> reset (a :: b :: t)
            | Mul_D_C (a, _)        -> reset (a :: t)
            | Mul_C_D (_, b)        -> reset (b :: t)
            | Div_D_D (a, b)        -> reset (a :: b :: t)
            | Div_D_C (a, _)        -> reset (a :: t)
            | Div_C_D (_, b)        -> reset (b :: t)
            | Pow_D_D (a, b)        -> reset (a :: b :: t)
            | Pow_D_C (a, _)        -> reset (a :: t)
            | Pow_C_D (_, b)        -> reset (b :: t)
            | Neg_D a               -> reset (a :: t)
            | Abs_D a               -> reset (a :: t)
            | Signum_D a            -> reset (a :: t)
            | Square_D a            -> reset (a :: t)
            | Sqrt_D a              -> reset (a :: t)
            | Log_D a               -> reset (a :: t)
            | Log2_D a              -> reset (a :: t)
            | Log10_D a             -> reset (a :: t)
            | Exp_D a               -> reset (a :: t)
            | Sin_D a               -> reset (a :: t)
            | Cos_D a               -> reset (a :: t)
            | Tan_D a               -> reset (a :: t)
            | Sinh_D a              -> reset (a :: t)
            | Cosh_D a              -> reset (a :: t)
            | Tanh_D a              -> reset (a :: t)
            | Item (a, _, _)        -> reset (a :: t)
            | AddI_D_D (a, _, _, b) -> reset (a :: b :: t)
            | AddI_D_C (a, _, _, _) -> reset (a :: t)
            | AddI_C_D (_, _, _, b) -> reset (b :: t)
            | _                     -> reset t
            )
          else reset t
          )
        | _ -> reset t
      )
  in
  reset [x]

let reverse_push v x =
  let open Maths in
  let rec push xs =
    match xs with
    | [] -> ()
    | (v, x) :: t -> (
        match x with
        | DR (ap, aa, ao, af, ai) -> (
          aa := Maths.(!aa +. v);
          af := !af - 1;
          if !af = 0 then (
            match ao with
            | Add_D_D (a, b)        -> push ((!aa, a) :: (!aa, b) :: t)
            | Add_D_C (a, _)        -> push ((!aa, a) :: t)
            | Add_C_D (_, b)        -> push ((!aa, b) :: t)
            | Sub_D_D (a, b)        -> push ((!aa, a) :: (Float 0. -. !aa, b) :: t)
            | Sub_D_C (a, _)        -> push ((!aa, a) :: t)
            | Sub_C_D (_, b)        -> push ((Float 0. -. !aa, b) :: t)
            | Mul_D_D (a, b)        -> push (((!aa *. primal b), a) :: ((!aa *. primal a), b) :: t)
            | Mul_D_C (a, b)        -> push (((!aa *. b), a) :: t)
            | Mul_C_D (a, b)        -> push (((!aa *. a), b) :: t)
            | Div_D_D (a, b)        -> push (((!aa /. (primal b)), a) :: ((!aa *. ((Float 0. -. (primal a)) /. ((primal b) *. (primal b)))), b) :: t)
            | Div_D_C (a, b)        -> push (((!aa /. b), a) :: t)
            | Div_C_D (a, b)        -> push (((!aa *. ((Float 0. -. (primal a)) /. ((primal b) *. (primal b)))), b) :: t)
            | Pow_D_D (a, b)        -> push (((!aa *. ((primal a) ** ((primal b) -. (Float 1.))) *. (primal b)), a) :: ((!aa *. ((primal a) ** (primal b)) *. log (primal a)), b) :: t)
            | Pow_D_C (a, b)        -> push (((!aa *. ((primal a) ** (b -. (Float 1.))) *. b), a) :: t)
            | Pow_C_D (a, b)        -> push (((!aa *. (a ** (primal b)) *. log a), b) :: t)
            | Neg_D a               -> push (((Float 0.) -. !aa, a) :: t)
            | Abs_D a               -> push (((!aa *. signum (primal a)), a) :: t)
            | Signum_D a            -> push ((zero a, a) :: t)
            | Square_D a            -> push (((!aa *. (primal a) *. (Float 2.)), a) :: t)
            | Sqrt_D a              -> push (((!aa /. ((Float 2.) *. ap)), a) :: t)
            | Log_D a               -> push (((!aa /. (primal a)), a) :: t)
            | Log2_D a              -> push (((!aa /. ((primal a) *. (Float Owl_maths.log2e))), a) :: t)
            | Log10_D a             -> push (((!aa /. ((primal a) *. (Float Owl_maths.log10e))), a) :: t)
            | Exp_D a               -> push (((!aa *. ap), a) :: t)
            | Sin_D a               -> push (((!aa *. cos (primal a)), a) :: t)
            | Cos_D a               -> push (((!aa *. (Float 0. -. sin (primal a))), a) :: t)
            | Tan_D a               -> push (((!aa /. (square (cos (primal a)))), a) :: t)
            | Sinh_D a              -> push (((!aa *. (cosh (primal a))), a) :: t)
            | Cosh_D a              -> push (((!aa *. (sinh (primal a))), a) :: t)
            | Tanh_D a              -> push (((!aa /. (square (cosh (primal a)))), a) :: t)
            | Item (a, i, j)        -> (adjoint a) := add_item !(adjoint a) i j !aa; push ((zero a, a) :: t)
            | AddI_D_D (a, i, j, b) -> push ((!aa, a) :: (item !aa i j, b) :: t)
            | AddI_D_C (a, _, _, _) -> push ((!aa, a) :: t)
            | AddI_C_D (_, i, j, b) -> push ((item !aa i j, b) :: t)
            | _                     -> push t
            )
          else push t
          )
        | _ -> push t
      )
  in
  push [(v, x)]


(* convenient wrappers *)

let make_forward p t i = DF (p, t, i)

let make_reverse p i = DR (p, ref (zero p), Noop, ref 0, i)

(* derivative of f (scalar -> scalr) at x, forward ad *)
let diff' f x =
  let x = make_forward x (one x) (tag ()) in
  let y = f x in
  primal y, tangent y

(* derivative of f (scalar -> scalr) at x, forward ad *)
let diff f x = diff' f x |> snd

(* gradient of f (vector -> scalar) at x, reverse ad *)
let grad' f x =
  let x = make_reverse x (tag ()) in
  let y = f x in
  reverse_reset y;
  reverse_push (Float 1.) y;
  primal y, !(x |> adjoint) |> primal

(* gradient of f (vector -> scalar) at x, reverse ad *)
let grad f x = grad' f x |> snd

(* jacobian vector product of f (vector -> vector) at x along v, forward ad *)
let jacobianv' f x v =
  let x = make_forward x v (tag ()) in
  let y = f x in
  primal y, tangent y

(* jacobian vector product of f (vector -> vector) at x along v, forward ad *)
let jacobianv f x v = jacobianv' f x v |> snd

(* jacobian of f (vector -> vector) at x *)
let jacobian f x =
  let y = f x |> primal in
  let m = shape y |> fst in
  let b = M.eye m in
  Array.init m (fun i ->
    let v = Matrix (M.col b i) in
    jacobianv f x v
  )
  |> Array.iteri (fun i v ->
    match v with
    | Matrix v -> M.copy_col_to v b i
    | _ -> failwith "error: jacobian"
  );
  Matrix b



(* ends here *)
