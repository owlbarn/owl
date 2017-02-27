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
  | Add_D_D   of t * t
  | Add_D_C   of t * t
  | Add_C_D   of t * t
  | Sub_D_D   of t * t
  | Sub_D_C   of t * t
  | Sub_C_D   of t * t
  | Mul_D_D   of t * t
  | Mul_D_C   of t * t
  | Mul_C_D   of t * t
  | Div_D_D   of t * t
  | Div_D_C   of t * t
  | Div_C_D   of t * t
  | Pow_D_D   of t * t
  | Pow_D_C   of t * t
  | Pow_C_D   of t * t
  | Atan2_D_D of t * t
  | Atan2_D_C of t * t
  | Atan2_C_D of t * t
  | Neg_D     of t
  | Abs_D     of t
  | Signum_D  of t
  | Floor_D   of t
  | Ceil_D    of t
  | Round_D   of t
  | Sqr_D     of t
  | Sqrt_D    of t
  | Log_D     of t
  | Log2_D    of t
  | Log10_D   of t
  | Exp_D     of t
  | Sin_D     of t
  | Cos_D     of t
  | Tan_D     of t
  | Sinh_D    of t
  | Cosh_D    of t
  | Tanh_D    of t
  | Asin_D    of t
  | Acos_D    of t
  | Atan_D    of t
  | Asinh_D   of t
  | Acosh_D   of t
  | Atanh_D   of t
  | Item      of t * int * int
  | AddI_D_D  of t * int * int * t
  | AddI_D_C  of t * int * int * t
  | AddI_C_D  of t * int * int * t
  | Sum_D     of t
  | Dot_D_D   of t * t
  | Dot_D_C   of t * t
  | Dot_C_D   of t * t
  | Trans_D   of t
  | L1Norm_D  of t
  | L2Norm_D  of t
  | L2NormS_D of t
  | Sigmoid_D of t
  | Relu_D    of t
  | Inv_D     of t


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

let row_num x = shape x |> fst

let col_num x = shape x |> snd

let mat_create m n a =
  match (primal a) with
  | Float a  -> Matrix (M.create m n a)
  | _ -> failwith "error: mat_create"


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
    let df_db cp bp bt = neg bt in
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
    let df_db cp bp bt = (neg bt) *. cp /. bp in
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

  and atan2 a b =
    let ff a b =
      match a, b with
      | Float a, Float b   -> Float S.(atan2 a b)
      | Float a, Matrix b  -> Matrix M.(atan20 a b)
      | Matrix a, Float b  -> Matrix M.(atan21 a b)
      | Matrix a, Matrix b -> Matrix M.(atan2 a b)
      | _                  -> failwith "error: atan2: ff"
    in
    let fd a b = atan2 a b in
    let df_da cp ap at = at *. b /. ((sqr ap) +. (sqr b)) in
    let df_db cp bp bt = (neg bt) *. a /. ((sqr a) +. (sqr bp)) in
    let df_dab cp ap at bp bt = ((at *. bp) -. (bt *. ap)) /. ((sqr ap) +. (sqr bp)) in
    let r_d_d a b = Atan2_D_D (a, b) in
    let r_d_c a b = Atan2_D_C (a, b) in
    let r_c_d a b = Atan2_C_D (a, b) in
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

  and floor a =
    let ff = function
      | Float a  -> Float Owl_maths.(floor a)
      | Matrix a -> Matrix M.(floor a)
      | _        -> failwith "error: floor: ff"
    in
    let fd a = floor a in
    let df cp ap at = zero ap in
    let r a = Floor_D a in
    op_d_d a ff fd df r

  and ceil a =
    let ff = function
      | Float a  -> Float Owl_maths.(ceil a)
      | Matrix a -> Matrix M.(ceil a)
      | _        -> failwith "error: ceil: ff"
    in
    let fd a = ceil a in
    let df cp ap at = zero ap in
    let r a = Ceil_D a in
    op_d_d a ff fd df r

  and round a =
    let ff = function
      | Float a  -> Float Owl_maths.(round a)
      | Matrix a -> Matrix M.(round a)
      | _        -> failwith "error: round: ff"
    in
    let fd a = round a in
    let df cp ap at = zero ap in
    let r a = Round_D a in
    op_d_d a ff fd df r

  and sqr a =
    let ff = function
      | Float a  -> Float S.(a *. a)
      | Matrix a -> Matrix M.(sqr a)
      | _        -> failwith "error: sqr: ff"
    in
    let fd a = sqr a in
    let df cp ap at = (Float 2.) *. at *. ap in
    let r a = Sqr_D a in
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
    let df cp ap at = neg (at *. sin ap) in
    let r a = Cos_D a in
    op_d_d a ff fd df r

  and tan a =
    let ff = function
      | Float a  -> Float S.(tan a)
      | Matrix a -> Matrix M.(tan a)
      | _        -> failwith "error: tan: ff"
    in
    let fd a = tan a in
    let df cp ap at = at /. (sqr (cos ap)) in
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
    let df cp ap at = at /. (sqr (cosh ap)) in
    let r a = Tanh_D a in
    op_d_d a ff fd df r

  and asin a =
    let ff = function
      | Float a  -> Float S.(asin a)
      | Matrix a -> Matrix M.(asin a)
      | _        -> failwith "error: asin: ff"
    in
    let fd a = asin a in
    let df cp ap at = at /. sqrt ((Float 1.) -. sqr ap) in
    let r a = Asin_D a in
    op_d_d a ff fd df r

  and acos a =
    let ff = function
      | Float a  -> Float S.(acos a)
      | Matrix a -> Matrix M.(acos a)
      | _        -> failwith "error: acos: ff"
    in
    let fd a = acos a in
    let df cp ap at = (neg at) /. sqrt ((Float 1.) -. sqr ap) in
    let r a = Acos_D a in
    op_d_d a ff fd df r

  and atan a =
    let ff = function
      | Float a  -> Float S.(atan a)
      | Matrix a -> Matrix M.(atan a)
      | _        -> failwith "error: atan: ff"
    in
    let fd a = atan a in
    let df cp ap at = at /. ((Float 1.) +. sqr ap) in
    let r a = Atan_D a in
    op_d_d a ff fd df r

  and asinh a =
    let ff = function
      | Float a  -> Float Owl_maths.(asinh a)
      | Matrix a -> Matrix M.(asinh a)
      | _        -> failwith "error: asinh: ff"
    in
    let fd a = asinh a in
    let df cp ap at = at /. sqrt ((sqr ap) +. (Float 1.)) in
    let r a = Asinh_D a in
    op_d_d a ff fd df r

  and acosh a =
    let ff = function
      | Float a  -> Float Owl_maths.(acosh a)
      | Matrix a -> Matrix M.(acosh a)
      | _        -> failwith "error: acosh: ff"
    in
    let fd a = acosh a in
    let df cp ap at = at /. sqrt ((sqr ap) -. (Float 1.)) in
    let r a = Acosh_D a in
    op_d_d a ff fd df r

  and atanh a =
    let ff = function
      | Float a  -> Float Owl_maths.(atanh a)
      | Matrix a -> Matrix M.(atanh a)
      | _        -> failwith "error: atanh: ff"
    in
    let fd a = atanh a in
    let df cp ap at = at /. ((Float 1.) -. sqr ap) in
    let r a = Atanh_D a in
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

  and sum a =
    let ff = function
      | Matrix a -> Float M.(sum a)
      | _        -> failwith "error: sum: ff"
    in
    let fd a = sum a in
    let df cp ap at = sum at in
    let r a = Sum_D a in
    op_d_d a ff fd df r

  and ( $@ ) a b = dot a b
  and dot a b =
    let ff a b =
      match a, b with
      | Matrix a, Matrix b -> Matrix M.(a $@ b)
      | _                  -> failwith "error: dot: ff"
    in
    let fd a b = a $@ b in
    let df_da cp ap at = at $@ b in
    let df_db cp bp bt = a $@ bt in
    let df_dab cp ap at bp bt = (ap $@ bt) +. (at $@ bp) in
    let r_d_d a b = Dot_D_D (a, b) in
    let r_d_c a b = Dot_D_C (a, b) in
    let r_c_d a b = Dot_C_D (a, b) in
    op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

  and transpose a =
    let ff = function
      | Matrix a -> Matrix M.(transpose a)
      | _        -> failwith "error: transpose: ff"
    in
    let fd a = transpose a in
    let df cp ap at = transpose at in
    let r a = Trans_D a in
    op_d_d a ff fd df r

  and l1norm a =
    let ff = function
      | Matrix a -> Float M.(l1norm a)
      | _        -> failwith "error: l1norm: ff"
    in
    let fd a = l1norm a in
    let df cp ap at = at *. (signum ap) in
    let r a = L1Norm_D a in
    op_d_d a ff fd df r

  and l2norm a =
    let ff = function
      | Matrix a -> Float M.(l2norm a)
      | _        -> failwith "error: l2norm: ff"
    in
    let fd a = l2norm a in
    let df cp ap at = (ap *. at) /. cp in
    let r a = L2Norm_D a in
    op_d_d a ff fd df r


  and l2norm_sqr a =
    let ff = function
      | Float a  -> Float S.(a *. a)
      | Matrix a -> Float M.(l2norm_sqr a)
      | _        -> failwith "error: l2norm_sqr: ff"
    in
    let fd a = l2norm_sqr a in
    let df cp ap at = (Float 2.) *. (ap *. at) in
    let r a = L2NormS_D a in
    op_d_d a ff fd df r

  and sigmoid a =
    let ff = function
      | Float a  -> Float Owl_maths.(sigmoid a)
      | Matrix a -> Matrix M.(sigmoid a)
      | _        -> failwith "error: sigmoid: ff"
    in
    let fd a = sigmoid a in
    let df cp ap at = at *. cp *. (Float 1. -. cp) in
    let r a = Sigmoid_D a in
    op_d_d a ff fd df r

  (* and sigmoid a = (Float 1.) /. (Float 1. +. (exp (neg a))) *)

  and relu a =
    let ff = function
      | Float a  -> Float Owl_maths.(relu a)
      | Matrix a -> Matrix M.(relu a)
      | _        -> failwith "error: relu: ff"
    in
    let fd a = relu a in
    let df cp ap at = at *. (Float 1. +. (signum ap)) /. (Float 2.) in
    let r a = Relu_D a in
    op_d_d a ff fd df r

  and inv a =
    let ff = function
      | Matrix a -> Matrix Owl_linalg.(inv a)
      | _        -> failwith "error: inv: ff"
    in
    let fd a = inv a in
    let df cp ap at = (neg cp) *. at *. cp in
    let r a = Inv_D a in
    op_d_d a ff fd df r

  and softplus x = log (Float 1. +. exp x)

  and softsign x = x /. (Float 1. +. abs x)

  (* FIXME: use numerically stable version *)
  and softmax x =
    let y = exp x in
    let a = sum y in
    y /. a

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
            | Atan2_D_D (a, b)      -> reset (a :: b :: t)
            | Atan2_D_C (a, _)      -> reset (a :: t)
            | Atan2_C_D (_, b)      -> reset (b :: t)
            | Neg_D a               -> reset (a :: t)
            | Abs_D a               -> reset (a :: t)
            | Signum_D a            -> reset (a :: t)
            | Floor_D a             -> reset (a :: t)
            | Ceil_D a              -> reset (a :: t)
            | Round_D a             -> reset (a :: t)
            | Sqr_D a               -> reset (a :: t)
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
            | Asin_D a              -> reset (a :: t)
            | Acos_D a              -> reset (a :: t)
            | Atan_D a              -> reset (a :: t)
            | Asinh_D a             -> reset (a :: t)
            | Acosh_D a             -> reset (a :: t)
            | Atanh_D a             -> reset (a :: t)
            | Item (a, _, _)        -> reset (a :: t)
            | AddI_D_D (a, _, _, b) -> reset (a :: b :: t)
            | AddI_D_C (a, _, _, _) -> reset (a :: t)
            | AddI_C_D (_, _, _, b) -> reset (b :: t)
            | Sum_D a               -> reset (a :: t)
            | Dot_D_D (a, b)        -> reset (a :: b :: t)
            | Dot_D_C (a, _)        -> reset (a :: t)
            | Dot_C_D (_, b)        -> reset (b :: t)
            | Trans_D a             -> reset (a :: t)
            | L1Norm_D a            -> reset (a :: t)
            | L2Norm_D a            -> reset (a :: t)
            | L2NormS_D a           -> reset (a :: t)
            | Sigmoid_D a           -> reset (a :: t)
            | Relu_D a              -> reset (a :: t)
            | Inv_D a               -> reset (a :: t)
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
  (* check the types of adjoint a and its update, transform v if necessary *)
  let _melt a v =
    match a, v with
    | Float _, Matrix v -> Float (M.sum v)
    | a, v -> v
  in
  let rec push xs =
    match xs with
    | [] -> ()
    | (v, x) :: t -> (
        match x with
        | DR (ap, aa, ao, af, ai) -> (
          let v = _melt !aa v in
          aa := Maths.(!aa +. v);
          af := !af - 1;
          if !af = 0 then (
            match ao with
            | Add_D_D (a, b)        -> push ((!aa, a) :: (!aa, b) :: t)
            | Add_D_C (a, _)        -> push ((!aa, a) :: t)
            | Add_C_D (_, b)        -> push ((!aa, b) :: t)
            | Sub_D_D (a, b)        -> push ((!aa, a) :: (neg !aa, b) :: t)
            | Sub_D_C (a, _)        -> push ((!aa, a) :: t)
            | Sub_C_D (_, b)        -> push ((neg !aa, b) :: t)
            | Mul_D_D (a, b)        -> push (((!aa *. primal b), a) :: ((!aa *. primal a), b) :: t)
            | Mul_D_C (a, b)        -> push (((!aa *. b), a) :: t)
            | Mul_C_D (a, b)        -> push (((!aa *. a), b) :: t)
            | Div_D_D (a, b)        -> push (((!aa /. (primal b)), a) :: ((!aa *. ((neg (primal a)) /. ((primal b) *. (primal b)))), b) :: t)
            | Div_D_C (a, b)        -> push (((!aa /. b), a) :: t)
            | Div_C_D (a, b)        -> push (((!aa *. ((neg a) /. ((primal b) *. (primal b)))), b) :: t)
            | Pow_D_D (a, b)        -> push (((!aa *. ((primal a) ** ((primal b) -. (Float 1.))) *. (primal b)), a) :: ((!aa *. ((primal a) ** (primal b)) *. log (primal a)), b) :: t)
            | Pow_D_C (a, b)        -> push (((!aa *. ((primal a) ** (b -. (Float 1.))) *. b), a) :: t)
            | Pow_C_D (a, b)        -> push (((!aa *. (a ** (primal b)) *. log a), b) :: t)
            | Atan2_D_D (a, b)      -> let d = (sqr (primal a)) +. (sqr (primal b)) in push (((!aa *. (primal b) /. d), a) :: ((!aa *. (neg (primal a)) /. d), b) :: t)
            | Atan2_D_C (a, b)      -> push (((!aa *. b /. ((sqr (primal a)) +. (sqr b))), a) :: t)
            | Atan2_C_D (a, b)      -> push (((!aa *. (neg a) /. ((sqr a) +. (sqr (primal b)))), b) :: t)
            | Neg_D a               -> push ((neg !aa, a) :: t)
            | Abs_D a               -> push (((!aa *. signum (primal a)), a) :: t)
            | Signum_D a            -> push ((zero a, a) :: t)
            | Floor_D a             -> push ((zero a, a) :: t)
            | Ceil_D a              -> push ((zero a, a) :: t)
            | Round_D a             -> push ((zero a, a) :: t)
            | Sqr_D a               -> push (((!aa *. (primal a) *. (Float 2.)), a) :: t)
            | Sqrt_D a              -> push (((!aa /. ((Float 2.) *. ap)), a) :: t)
            | Log_D a               -> push (((!aa /. (primal a)), a) :: t)
            | Log2_D a              -> push (((!aa /. ((primal a) *. (Float Owl_maths.log2e))), a) :: t)
            | Log10_D a             -> push (((!aa /. ((primal a) *. (Float Owl_maths.log10e))), a) :: t)
            | Exp_D a               -> push (((!aa *. ap), a) :: t)
            | Sin_D a               -> push (((!aa *. cos (primal a)), a) :: t)
            | Cos_D a               -> push (((!aa *. (Float 0. -. sin (primal a))), a) :: t)
            | Tan_D a               -> push (((!aa /. (sqr (cos (primal a)))), a) :: t)
            | Sinh_D a              -> push (((!aa *. (cosh (primal a))), a) :: t)
            | Cosh_D a              -> push (((!aa *. (sinh (primal a))), a) :: t)
            | Tanh_D a              -> push (((!aa /. (sqr (cosh (primal a)))), a) :: t)
            | Asin_D a              -> push (((!aa /. sqrt ((Float 1.) -. sqr (primal a))), a) :: t)
            | Acos_D a              -> push ((((neg !aa) /. sqrt ((Float 1.) -. sqr (primal a))), a) :: t)
            | Atan_D a              -> push (((!aa /. ((Float 1.) +. sqr (primal a))), a) :: t)
            | Asinh_D a             -> push (((!aa /. sqrt ((sqr (primal a)) +. (Float 1.))), a) :: t)
            | Acosh_D a             -> push (((!aa /. sqrt ((sqr (primal a)) -. (Float 1.))), a) :: t)
            | Atanh_D a             -> push (((!aa /. ((Float 1.) -. sqr (primal a))), a) :: t)
            | Item (a, i, j)        -> (adjoint a) := add_item !(adjoint a) i j !aa; push ((zero a, a) :: t)
            | AddI_D_D (a, i, j, b) -> push ((!aa, a) :: (item !aa i j, b) :: t)
            | AddI_D_C (a, _, _, _) -> push ((!aa, a) :: t)
            | AddI_C_D (_, i, j, b) -> push ((item !aa i j, b) :: t)
            | Sum_D a               -> push ((((mat_create (row_num (primal a)) (col_num (primal a)) !aa)), a) :: t)
            | Dot_D_D (a, b)        -> push (((dot !aa (transpose (primal b))), a) :: ((dot (transpose (primal a)) !aa), b) :: t)
            | Dot_D_C (a, b)        -> push (((dot !aa (transpose b)), a) :: t)
            | Dot_C_D (a, b)        -> push (((dot (transpose a) !aa), b) :: t)
            | Trans_D a             -> push (((transpose !aa), a) :: t)
            | L1Norm_D a            -> push (((!aa *. (signum (primal a))), a) :: t)
            | L2Norm_D a            -> push (((!aa /. ap *. (primal a)), a) :: t)
            | L2NormS_D a           -> push (((!aa *. (Float 2.) *. (primal a)), a) :: t)
            | Sigmoid_D a           -> push (((!aa *. ap *. (Float 1. -. ap)), a) :: t)
            | Relu_D a              -> push (((!aa *. ((signum (primal a) +. Float 1.) /. (Float 2.))), a) :: t)
            | Inv_D a               -> let dpt = transpose ap in push ((((neg dpt) *. !aa *. dpt), a) :: t)
            | _                     -> push t
            )
          else push t
          )
        | _ -> push t
      )
  in
  push [(v, x)]

let reverse_prop v x =
  reverse_reset x;
  reverse_push v x


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

(* transposed jacobian vector product of f (vector -> vector) at x along v, backward ad *)
let jacobianTv' f x v =
  let x = make_reverse x (tag ()) in
  let y = f x in
  reverse_reset y;
  reverse_push v y;
  primal y, !(x |> adjoint) |> primal

(* transposed jacobian vector product of f (vector -> vector) at x along v, backward ad *)
let jacobianTv f x v = jacobianTv' f x v |> snd

(* jacobian of f (vector -> vector) at x, both x and y are row vectors. *)
let jacobian f x =
  (* FIXME *)
  let y = f x |> primal |> Maths.transpose in
  let m = row_num y in
  let n = col_num x in
  let z = M.empty m n in
  if m > n then (
    let b = M.eye n in
    Array.init n (fun i ->
      let v = Matrix (M.col b i) in
      jacobianv f x v
    )
    |> Array.iteri (fun i v ->
      match v with
      | Matrix v -> M.copy_col_to v z i
      | _ -> failwith "error: jacobian"
    );
  )
  else (
    let b = M.eye m in
    Array.init m (fun i ->
      let v = Matrix (M.row b i) in
      jacobianTv f x v
    )
    |> Array.iteri (fun i v ->
      match v with
      | Matrix v -> M.copy_row_to v z i
      | _ -> failwith "error: jacobian"
    );
  );
  z

let print_trace x =
  None

(* ends here *)
