(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>

 * Core nested automatic differentiation algorithm and differentiation API
 * ported from DiffSharp (http://diffsharp.github.io), copyright (c) 2014-2016
 * National University of Ireland Maynooth (Atilim Gunes Baydin), 2014-2018
 * National University of Ireland Maynooth (Barak A. Pearlmutter
 * <barak@pearlmutter.net>), 2016-2018 University of Oxford (Atilim Gunes
 * Baydin <gunes@robots.ox.ac.uk>), 2017-2018 Microsoft Research Cambridge
 * (Don Syme <dsyme@microsoft.com>
 *)

open Owl_types


(* Functor of making AD module of different precisions *)

module Make
    (A : Owl_types_ndarray_algodiff.Sig)
= struct

  module A = A

  (* type definitions *)

  type t =
    | F   of A.elt
    | Arr of A.arr
    | Pair of t * t  (* to allow for computations that return more than one thing, e.g. QR *)
    | DF  of t * t * int                            (* primal, tangent, tag *)
    | DR  of t * t ref * trace_op * int ref * int   (* primal, adjoint, op, fanout, tag *)
  and trace_op =
    | Noop
    | Add_D_D        of t * t
    | Add_D_C        of t * t
    | Add_C_D        of t * t
    | Sub_D_D        of t * t
    | Sub_D_C        of t * t
    | Sub_C_D        of t * t
    | Mul_D_D        of t * t
    | Mul_D_C        of t * t
    | Mul_C_D        of t * t
    | Div_D_D        of t * t
    | Div_D_C        of t * t
    | Div_C_D        of t * t
    | Pow_D_D        of t * t
    | Pow_D_C        of t * t
    | Pow_C_D        of t * t
    | Atan2_D_D      of t * t
    | Atan2_D_C      of t * t
    | Atan2_C_D      of t * t
    | Neg_D          of t
    | Abs_D          of t
    | Signum_D       of t
    | Floor_D        of t
    | Ceil_D         of t
    | Round_D        of t
    | Sqr_D          of t
    | Sqrt_D         of t
    | Log_D          of t
    | Log2_D         of t
    | Log10_D        of t
    | Exp_D          of t
    | Sin_D          of t
    | Cos_D          of t
    | Tan_D          of t
    | Sinh_D         of t
    | Cosh_D         of t
    | Tanh_D         of t
    | Asin_D         of t
    | Acos_D         of t
    | Atan_D         of t
    | Asinh_D        of t
    | Acosh_D        of t
    | Atanh_D        of t
    | Get_Item       of t * int * int
    | SetI_D_D       of t * int * int * t
    | SetI_D_C       of t * int * int * t
    | SetI_C_D       of t * int * int * t
    | AddI_D_D       of t * int * int * t
    | AddI_D_C       of t * int * int * t
    | AddI_C_D       of t * int * int * t
    | Get_Slice_D    of t * int list list
    | Set_Slice_D_D  of t * t * int list list
    | Set_Slice_D_C  of t * t * int list list
    | Set_Slice_C_D  of t * t * int list list
    | Sum_D          of t
    | Sum__D         of t * int
    | Sum___D        of t * int array
    | Dot_D_D        of t * t
    | Dot_D_C        of t * t
    | Dot_C_D        of t * t
    | Trans_D        of t
    | L1Norm_D       of t
    | L2Norm_D       of t
    | L2NormS_D      of t
    | Sigmoid_D      of t
    | Relu_D         of t
    | Inv_D          of t
    | QR_D           of t
    | Lyapunov_D_D   of t * t
    | Lyapunov_C_D   of t * t
    | Lyapunov_D_C   of t * t
    | Diag_D         of int * t
    | Tril_D         of int * t
    | Triu_D         of int * t
    | Trace_D        of t
    | Add_Row_D_D    of t * t * int
    | Add_Row_D_C    of t * t * int
    | Add_Row_C_D    of t * t * int
    | Get_Row_D      of t * int
    | Of_Rows_D      of t array
    | Concat_D_D     of t * t * int
    | Concat_D_C     of t * t * int
    | Concat_C_D     of t * t * int
    | Conv1D_D_D     of t * t * int array
    | Conv1D_D_C     of t * t * int array
    | Conv1D_C_D     of t * t * int array
    | Conv2D_D_D     of t * t * int array
    | Conv2D_D_C     of t * t * int array
    | Conv2D_C_D     of t * t * int array
    | Conv3D_D_D     of t * t * int array
    | Conv3D_D_C     of t * t * int array
    | Conv3D_C_D     of t * t * int array
    | Di_Conv1D_D_D  of t * t * int array * int array
    | Di_Conv1D_D_C  of t * t * int array * int array
    | Di_Conv1D_C_D  of t * t * int array * int array
    | Di_Conv2D_D_D  of t * t * int array * int array
    | Di_Conv2D_D_C  of t * t * int array * int array
    | Di_Conv2D_C_D  of t * t * int array * int array
    | Di_Conv3D_D_D  of t * t * int array * int array
    | Di_Conv3D_D_C  of t * t * int array * int array
    | Di_Conv3D_C_D  of t * t * int array * int array
    | Tr_Conv1D_D_D  of t * t * int array
    | Tr_Conv1D_D_C  of t * t * int array
    | Tr_Conv1D_C_D  of t * t * int array
    | Tr_Conv2D_D_D  of t * t * int array
    | Tr_Conv2D_D_C  of t * t * int array
    | Tr_Conv2D_C_D  of t * t * int array
    | Tr_Conv3D_D_D  of t * t * int array
    | Tr_Conv3D_D_C  of t * t * int array
    | Tr_Conv3D_C_D  of t * t * int array
    | Reshape_D      of t
    | Maxpool1D_D    of t * padding * int array * int array
    | Maxpool2D_D    of t * padding * int array * int array
    | Maxpool3D_D    of t * padding * int array * int array
    | Avgpool1D_D    of t * padding * int array * int array
    | Avgpool2D_D    of t * padding * int array * int array
    | Avgpool3D_D    of t * padding * int array * int array
    | UpSampling2D_D of t * int array
    | PAD_D          of t * int list list


  (* generate global tags *)
  let _global_tag = ref 0

  let tag () = _global_tag := !_global_tag + 1; !_global_tag


  (* hepler functions of the core AD component *)

  let cmp_tag ai bi =
    if ai > bi then 1
    else if ai < bi then -1
    else 0

  let rec reset_zero = function
    | F _    -> F A.(float_to_elt 0.)
    | Arr ap -> A.reset ap; Arr ap
    | Pair (ap, bp) -> Pair (reset_zero ap, reset_zero bp)
    | _      -> failwith "error: reset_zero"

  let primal = function
    | DF (ap, _, _)       -> ap
    | DR (ap, _, _, _, _) -> ap
    | ap                  -> ap

  let rec primal' = function
    | DF (ap, _, _)       -> primal' ap
    | DR (ap, _, _, _, _) -> primal' ap
    | ap                  -> ap

  let rec zero = function
    | F _                     -> F A.(float_to_elt 0.)
    | Arr ap                  -> Arr A.(zeros (shape ap))
    | Pair (a, b)             -> Pair (zero a, zero b)
    | DF (ap, _, _)           -> ap |> primal' |> zero
    | DR (ap, _, _, _, _)     -> ap |> primal' |> zero

  let tangent = function
    | DF (_, at, _) -> at
    | DR _          -> failwith "error: no tangent for DR"
    | ap            -> zero ap

  let adjref = function
    | DF _                -> failwith "error: no adjref for DF"
    | DR (_, at, _, _, _) -> at
    | ap                  -> ref (zero ap)

  let adjval = function
    | DF _                -> failwith "error: no adjval for DF"
    | DR (_, at, _, _, _) -> !at
    | ap                  -> zero ap

  let shape x =
    match (primal' x) with
    | Arr ap -> A.shape ap
    | _      -> failwith "error: AD.shape"

  let row_num x = (shape x).(0)

  let col_num x = (shape x).(1)

  let numel x =
    match primal' x with
    | Arr x -> A.numel x
    | _     -> failwith "error: AD.numel"

  let clip_by_value ~amin ~amax x =
    match primal' x with
    | Arr x -> Arr A.(clip_by_value ~amin ~amax x)
    | _     -> failwith "error: AD.clip_by_value"

  let clip_by_l2norm a x =
    match primal' x with
    | Arr x -> Arr A.(clip_by_l2norm a x)
    | _     -> failwith "error: AD.clip_by_l2norm"

  let copy_primal' x =
    match (primal' x) with
    | Arr ap -> Arr A.(copy ap)
    | _      -> failwith "error: AD.copy"

  let tile x reps =
    match primal' x with
    | Arr x -> Arr A.(tile x reps)
    | _     -> failwith "error: AD.tile"

  let repeat x reps =
    match primal' x with
    | Arr x -> Arr A.(repeat x reps)
    | _     -> failwith "error: AD.repeat"

  (* packing and unpacking functions *)

  let pack_elt x = F x

  let unpack_elt x =
    match (primal x) with
    | F x -> x
    | _   -> failwith "error: AD.unpack_elt"

  let pack_flt x = F A.(float_to_elt x)

  let _f x = F A.(float_to_elt x) (* shorcut for type conversion *)

  let unpack_flt x =
    match (primal x) with
    | F x -> A.elt_to_float x
    | _   -> failwith "error: AD.unpack_flt"

  let pack_arr x = Arr x

  let unpack_arr x =
    match (primal x) with
    | Arr x -> x
    | _     -> failwith "error: AD.unpack_arr"


  (* functions to report errors, help in debugging *)

  let deep_info x = match primal' x with
    | F a   -> Printf.sprintf "F(%g)" A.(elt_to_float a)
    | Arr a -> Printf.sprintf "Arr(%s)" (A.shape a |> Owl_utils_array.to_string string_of_int)
    | _     -> "you should not have reached here!"

  let type_info x = match x with
    | F _a                       -> Printf.sprintf "[%s]" (deep_info x)
    | DF (ap, _at, ai)           -> Printf.sprintf "[DF tag:%i ap:%s]" ai (deep_info ap)
    | DR (ap, _at, _ao, _af, ai) -> Printf.sprintf "[DR tag:%i ap:%s]" ai (deep_info ap)
    | _                          -> Printf.sprintf "[%s]" (deep_info x)

  let error_binop op a b =
    let s0 = "#0:" ^ (type_info a) in
    let s1 = "#1:" ^ (type_info b) in
    failwith (op ^ " : " ^ s0 ^ ", " ^ s1)

  let error_uniop op a =
    let s = type_info a in
    failwith (op ^ " : " ^ s)


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
      | F _ap, DF (bp, bt, bi)                      -> let cp = fd a bp in DF (cp, (df_db cp bp bt), bi)
      | DF (ap, at, ai), F _bp                      -> let cp = fd ap b in DF (cp, (df_da cp ap at), ai)
      | Arr _ap, DF (bp, bt, bi)                    -> let cp = fd a bp in DF (cp, (df_db cp bp bt), bi)
      | DF (ap, at, ai), Arr _bp                    -> let cp = fd ap b in DF (cp, (df_da cp ap at), ai)
      | F _ap, DR (bp, _, _, _, bi)                 -> let cp = fd a bp in DR (cp, ref (zero cp), r_c_d a b, ref 0, bi)
      | DR (ap, _, _, _, ai), F _bp                 -> let cp = fd ap b in DR (cp, ref (zero cp), r_d_c a b, ref 0, ai)
      | Arr _ap, DR (bp, _, _, _, bi)               -> let cp = fd a bp in DR (cp, ref (zero cp), r_c_d a b, ref 0, bi)
      | DR (ap, _, _, _, ai), Arr _bp               -> let cp = fd ap b in DR (cp, ref (zero cp), r_d_c a b, ref 0, ai)
      | DF (ap, at, ai), DR (bp, _, _, _, bi)       -> (
          match cmp_tag ai bi with
          | 1  -> let cp = fd ap b in DF (cp, df_da cp ap at, ai)
          | -1 -> let cp = fd a bp in DR (cp, ref (zero cp), r_c_d a b, ref 0, bi)
          | _  -> failwith "error: forward and reverse clash at the same level"
        )
      | DR (ap, _, _, _, ai), DF (bp, bt, bi)       -> (
          match cmp_tag ai bi with
          | -1 -> let cp = fd a bp in DF (cp, df_db cp bp bt, bi)
          | 1  -> let cp = fd ap b in DR (cp, ref (zero cp), r_d_c a b, ref 0, ai)
          | _  -> failwith "error: forward and reverse clash at the same level"
        )
      | DF (ap, at, ai), DF (bp, bt, bi)            -> (
          match cmp_tag ai bi with
          | 0 -> let cp = fd ap bp in DF (cp, (df_dab cp ap at bp bt), ai)
          | 1 -> let cp = fd ap b  in DF (cp, (df_da cp ap at), ai)
          | _ -> let cp = fd a bp  in DF (cp, (df_db cp bp bt), bi)
        )
      | DR (ap, _, _, _, ai), DR (bp, _, _, _, bi)  -> (
          match cmp_tag ai bi with
          | 0 -> let cp = fd ap bp in DR (cp, ref (zero cp), r_d_d a b, ref 0, ai)
          | 1 -> let cp = fd ap b  in DR (cp, ref (zero cp), r_d_c a b, ref 0, ai)
          | _ -> let cp = fd a bp  in DR (cp, ref (zero cp), r_c_d a b, ref 0, bi)
        )
      | a, b                                        -> ff a b

    and ( + ) a b = add a b
    and add a b =
      let ff a b =
        match a, b with
        | F a, F b     -> F A.Scalar.(add a b)
        | F a, Arr b   -> Arr A.(scalar_add a b)
        | Arr a, F b   -> Arr A.(add_scalar a b)
        | Arr a, Arr b -> Arr A.(add a b)
        | _            -> error_binop "( + )" a b
      in
      let fd a b = a + b in
      let df_da _cp _ap at = at in
      let df_db _cp _bp bt = bt in
      let df_dab _cp _ap at _bp bt = at + bt in
      let r_d_d a b = Add_D_D (a, b) in
      let r_d_c a b = Add_D_C (a, b) in
      let r_c_d a b = Add_C_D (a, b) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and ( - ) a b = sub a b
    and sub a b =
      let ff a b =
        match a, b with
        | F a, F b     -> F A.Scalar.(sub a b)
        | F a, Arr b   -> Arr A.(scalar_sub a b)
        | Arr a, F b   -> Arr A.(sub_scalar a b)
        | Arr a, Arr b -> Arr A.(sub a b)
        | _            -> error_binop "( - )" a b
      in
      let fd a b = a - b in
      let df_da _cp _ap at = at in
      let df_db _cp _bp bt = neg bt in
      let df_dab _cp _ap at _bp bt = at - bt in
      let r_d_d a b = Sub_D_D (a, b) in
      let r_d_c a b = Sub_D_C (a, b) in
      let r_c_d a b = Sub_C_D (a, b) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and ( * ) a b = mul a b
    and mul a b =
      let ff a b =
        match a, b with
        | F a, F b     -> F A.Scalar.(mul a b)
        | F a, Arr b   -> Arr A.(scalar_mul a b)
        | Arr a, F b   -> Arr A.(mul_scalar a b)
        | Arr a, Arr b -> Arr A.(mul a b)
        | _            -> error_binop "( * )" a b
      in
      let fd a b = a * b in
      let df_da _cp _ap at = at * b in
      let df_db _cp _bp bt = a * bt in
      let df_dab _cp ap at bp bt = (ap * bt) + (at * bp) in
      let r_d_d a b = Mul_D_D (a, b) in
      let r_d_c a b = Mul_D_C (a, b) in
      let r_c_d a b = Mul_C_D (a, b) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and ( / ) a b = div a b
    and div a b =
      let ff a b =
        match a, b with
        | F a, F b     -> F A.Scalar.(div a b)
        | F a, Arr b   -> Arr A.(scalar_div a b)
        | Arr a, F b   -> Arr A.(div_scalar a b)
        | Arr a, Arr b -> Arr A.(div a b)
        | _            -> error_binop "( / )" a b
      in
      let fd a b = a / b in
      let df_da _cp _ap at = at / b in
      let df_db cp bp bt = (neg bt) * cp / bp in
      let df_dab cp _ap at bp bt = (at - bt * cp) / bp in
      let r_d_d a b = Div_D_D (a, b) in
      let r_d_c a b = Div_D_C (a, b) in
      let r_c_d a b = Div_C_D (a, b) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and ( ** ) a b = pow a b
    and pow a b =
      let ff a b =
        match a, b with
        | F a, F b     -> F A.Scalar.(pow a b)
        | F a, Arr b   -> Arr A.(scalar_pow a b)
        | Arr a, F b   -> Arr A.(pow_scalar a b)
        | Arr a, Arr b -> Arr A.(pow a b)
        | _            -> error_binop "( ** )" a b
      in
      let fd a b = a ** b in
      let df_da _cp ap at = at * (ap ** (b - (pack_flt 1.))) * b in
      let df_db cp _bp bt = bt * cp * (log a) in
      let df_dab _cp ap at bp bt = (ap ** (bp - (pack_flt 1.))) * ((at * bp) + (ap * bt * log ap)) in
      let r_d_d a b = Pow_D_D (a, b) in
      let r_d_c a b = Pow_D_C (a, b) in
      let r_c_d a b = Pow_C_D (a, b) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and atan2 a b =
      let ff a b =
        match a, b with
        | F a, F b     -> F A.Scalar.(atan2 a b)
        | F a, Arr b   -> Arr A.(scalar_atan2 a b)
        | Arr a, F b   -> Arr A.(atan2_scalar a b)
        | Arr a, Arr b -> Arr A.(atan2 a b)
        | _            -> error_binop "atan2" a b
      in
      let fd a b = atan2 a b in
      let df_da _cp ap at = at * b / ((sqr ap) + (sqr b)) in
      let df_db _cp bp bt = (neg bt) * a / ((sqr a) + (sqr bp)) in
      let df_dab _cp ap at bp bt = ((at * bp) - (bt * ap)) / ((sqr ap) + (sqr bp)) in
      let r_d_d a b = Atan2_D_D (a, b) in
      let r_d_c a b = Atan2_D_C (a, b) in
      let r_c_d a b = Atan2_C_D (a, b) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and min2 a b = ((a + b) - abs (a - b)) / (pack_flt 2.)

    and max2 a b = ((a + b) + abs (b - a)) / (pack_flt 2.)

    and neg a =
      let ff = function
        | F a      -> F A.Scalar.(neg a)
        | Arr a    -> Arr A.(neg a)
        | _        -> error_uniop "neg" a
      in
      let fd a = neg a in
      let df _cp _ap at = (pack_flt 0.) - at in
      let r a = Neg_D a in
      op_d_d a ff fd df r

    and abs a =
      let ff = function
        | F a      -> F A.Scalar.(abs a)
        | Arr a    -> Arr A.(abs a)
        | _        -> error_uniop "abs" a
      in
      let fd a = abs a in
      let df _cp ap at = at * (signum ap) in
      let r a = Abs_D a in
      op_d_d a ff fd df r

    and signum a =
      let ff = function
        | F a      -> F A.Scalar.(signum a)
        | Arr a    -> Arr A.(signum a)
        | _        -> error_uniop "signum" a
      in
      let fd a = signum a in
      let df _cp ap _at = zero ap in
      let r a = Signum_D a in
      op_d_d a ff fd df r

    and floor a =
      let ff = function
        | F a      -> F A.Scalar.(floor a)
        | Arr a    -> Arr A.(floor a)
        | _        -> error_uniop "floor" a
      in
      let fd a = floor a in
      let df _cp ap _at = zero ap in
      let r a = Floor_D a in
      op_d_d a ff fd df r

    and ceil a =
      let ff = function
        | F a      -> F A.Scalar.(ceil a)
        | Arr a    -> Arr A.(ceil a)
        | _        -> error_uniop "ceil" a
      in
      let fd a = ceil a in
      let df _cp ap _at = zero ap in
      let r a = Ceil_D a in
      op_d_d a ff fd df r

    and round a =
      let ff = function
        | F a      -> F A.Scalar.(round a)
        | Arr a    -> Arr A.(round a)
        | _        -> error_uniop "round" a
      in
      let fd a = round a in
      let df _cp ap _at = zero ap in
      let r a = Round_D a in
      op_d_d a ff fd df r

    and sqr a =
      let ff = function
        | F a      -> F A.Scalar.(sqr a)
        | Arr a    -> Arr A.(sqr a)
        | _        -> error_uniop "sqr" a
      in
      let fd a = sqr a in
      let df _cp ap at = (pack_flt 2.) * at * ap in
      let r a = Sqr_D a in
      op_d_d a ff fd df r

    and sqrt a =
      let ff = function
        | F a      -> F A.Scalar.(sqrt a)
        | Arr a    -> Arr A.(sqrt a)
        | _        -> error_uniop "sqrt" a
      in
      let fd a = sqrt a in
      let df cp _ap at = at / ((pack_flt 2.) * cp) in
      let r a = Sqrt_D a in
      op_d_d a ff fd df r

    and log a =
      let ff = function
        | F a      -> F A.Scalar.(log a)
        | Arr a    -> Arr A.(log a)
        | _        -> error_uniop "log" a
      in
      let fd a = log a in
      let df _cp ap at = at / ap in
      let r a = Log_D a in
      op_d_d a ff fd df r

    and log2 a =
      let ff = function
        | F a      -> F A.Scalar.(log2 a)
        | Arr a    -> Arr A.(log2 a)
        | _        -> error_uniop "log2" a
      in
      let fd a = log2 a in
      let df _cp ap at = at / (ap * (pack_flt Owl_const.log2e)) in
      let r a = Log2_D a in
      op_d_d a ff fd df r

    and log10 a =
      let ff = function
        | F a      -> F A.Scalar.(log10 a)
        | Arr a    -> Arr A.(log10 a)
        | _        -> error_uniop "log10" a
      in
      let fd a = log10 a in
      let df _cp ap at = at / (ap * (pack_flt Owl_const.log10e)) in
      let r a = Log10_D a in
      op_d_d a ff fd df r

    and exp a =
      let ff = function
        | F a      -> F A.Scalar.(exp a)
        | Arr a    -> Arr A.(exp a)
        | _        -> error_uniop "exp" a
      in
      let fd a = exp a in
      let df cp _ap at = at * cp in
      let r a = Exp_D a in
      op_d_d a ff fd df r

    and sin a =
      let ff = function
        | F a      -> F A.Scalar.(sin a)
        | Arr a    -> Arr A.(sin a)
        | _        -> error_uniop "sin" a
      in
      let fd a = sin a in
      let df _cp ap at = at * cos ap in
      let r a = Sin_D a in
      op_d_d a ff fd df r

    and cos a =
      let ff = function
        | F a      -> F A.Scalar.(cos a)
        | Arr a    -> Arr A.(cos a)
        | _        -> error_uniop "cos" a
      in
      let fd a = cos a in
      let df _cp ap at = neg (at * sin ap) in
      let r a = Cos_D a in
      op_d_d a ff fd df r

    and tan a =
      let ff = function
        | F a      -> F A.Scalar.(tan a)
        | Arr a    -> Arr A.(tan a)
        | _        -> error_uniop "tan" a
      in
      let fd a = tan a in
      let df _cp ap at = at / (sqr (cos ap)) in
      let r a = Tan_D a in
      op_d_d a ff fd df r

    and sinh a =
      let ff = function
        | F a      -> F A.Scalar.(sinh a)
        | Arr a    -> Arr A.(sinh a)
        | _        -> error_uniop "sinh" a
      in
      let fd a = sinh a in
      let df _cp ap at = at * (cosh ap) in
      let r a = Sinh_D a in
      op_d_d a ff fd df r

    and cosh a =
      let ff = function
        | F a      -> F A.Scalar.(cosh a)
        | Arr a    -> Arr A.(cosh a)
        | _        -> error_uniop "cosh" a
      in
      let fd a = cosh a in
      let df _cp ap at = at * (sinh ap) in
      let r a = Cosh_D a in
      op_d_d a ff fd df r

    and tanh a =
      let ff = function
        | F a      -> F A.Scalar.(tanh a)
        | Arr a    -> Arr A.(tanh a)
        | _        -> error_uniop "tanh" a
      in
      let fd a = tanh a in
      let df _cp ap at = at / (sqr (cosh ap)) in
      let r a = Tanh_D a in
      op_d_d a ff fd df r

    and asin a =
      let ff = function
        | F a      -> F A.Scalar.(asin a)
        | Arr a    -> Arr A.(asin a)
        | _        -> error_uniop "asin" a
      in
      let fd a = asin a in
      let df _cp ap at = at / sqrt ((pack_flt 1.) - sqr ap) in
      let r a = Asin_D a in
      op_d_d a ff fd df r

    and acos a =
      let ff = function
        | F a      -> F A.Scalar.(acos a)
        | Arr a    -> Arr A.(acos a)
        | _        -> error_uniop "acos" a
      in
      let fd a = acos a in
      let df _cp ap at = (neg at) / sqrt ((pack_flt 1.) - sqr ap) in
      let r a = Acos_D a in
      op_d_d a ff fd df r

    and atan a =
      let ff = function
        | F a      -> F A.Scalar.(atan a)
        | Arr a    -> Arr A.(atan a)
        | _        -> error_uniop "atan" a
      in
      let fd a = atan a in
      let df _cp ap at = at / ((pack_flt 1.) + sqr ap) in
      let r a = Atan_D a in
      op_d_d a ff fd df r

    and asinh a =
      let ff = function
        | F a      -> F A.Scalar.(asinh a)
        | Arr a    -> Arr A.(asinh a)
        | _        -> error_uniop "asinh" a
      in
      let fd a = asinh a in
      let df _cp ap at = at / sqrt ((sqr ap) + (pack_flt 1.)) in
      let r a = Asinh_D a in
      op_d_d a ff fd df r

    and acosh a =
      let ff = function
        | F a      -> F A.Scalar.(acosh a)
        | Arr a    -> Arr A.(acosh a)
        | _        -> error_uniop "acosh" a
      in
      let fd a = acosh a in
      let df _cp ap at = at / sqrt ((sqr ap) - (pack_flt 1.)) in
      let r a = Acosh_D a in
      op_d_d a ff fd df r

    and atanh a =
      let ff = function
        | F a      -> F A.Scalar.(atanh a)
        | Arr a    -> Arr A.(atanh a)
        | _        -> error_uniop "atanh" a
      in
      let fd a = atanh a in
      let df _cp ap at = at / ((pack_flt 1.) - sqr ap) in
      let r a = Atanh_D a in
      op_d_d a ff fd df r

    and get_item a i j =
      match a with
      | Arr ap               -> F (A.get ap [|i;j|])
      | DF (ap, at, ai)      -> DF (get_item ap i j, get_item at i j, ai)
      | DR (ap, _, _, _, ai) -> DR (get_item ap i j, ref (pack_flt 0.), Get_Item (a, i, j), ref 0, ai)
      | _                    -> error_uniop "get_item" a

    and set_item a i j b =
      let ff a b = match a, b with
        | Arr a, F b        -> let aa = A.copy a in A.set aa [|i;j|] b; Arr aa
        | _                 -> error_uniop "set_item" a
      in
      let fd a b = set_item a i j b in
      let df_da _cp _ap at = set_item at i j (pack_flt 0.) in
      let df_db _cp _bp bt = add_item (zero a) i j bt in
      let df_dab _cp _ap at _bp bt = set_item at i j bt in
      let r_d_d a b = SetI_D_D (a, i, j, b) in
      let r_d_c a b = SetI_D_C (a, i, j, b) in
      let r_c_d a b = SetI_C_D (a, i, j, b) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and add_item a i j b =
      let ff a b = match a, b with
        | Arr a, F b        -> let aa = A.copy a in A.set aa [|i;j|] A.Scalar.(add (A.get aa [|i;j|]) b); Arr aa
        | _                 -> error_binop "add_item" a b
      in
      let fd a b = add_item a i j b in
      let df_da _cp _ap at = at in
      let df_db _cp _bp bt = add_item (zero a) i j bt in
      let df_dab _cp _ap at _bp bt = add_item at i j bt in
      let r_d_d a b = AddI_D_D (a, i, j, b) in
      let r_d_c a b = AddI_D_C (a, i, j, b) in
      let r_c_d a b = AddI_C_D (a, i, j, b) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and get_slice i a =
      let ff = function
        | Arr a    -> Arr A.(get_slice i a)
        | _        -> error_uniop "slice" a
      in
      let fd a = get_slice i a in
      let df _cp _ap at = get_slice i at in
      let r a = Get_Slice_D (a, i) in
      op_d_d a ff fd df r

    and set_slice i a b =
      let ff a b =
        match a, b with
        | Arr a, Arr b -> let a = A.copy a in A.(set_slice i a b); Arr a
        | _            -> error_binop "set_slice" a b
      in
      let fd a b = set_slice i a b in
      let df_da _cp _ap at = set_slice i at (zero b) in
      let df_db _cp _bp bt = set_slice i (zero a) bt in
      let df_dab _cp _ap at _bp bt = set_slice i at bt in
      let r_d_d a b = Set_Slice_D_D (a, b, i) in
      let r_d_c a b = Set_Slice_D_C (a, b, i) in
      let r_c_d a b = Set_Slice_C_D (a, b, i) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and sum' a =
      let ff = function
        | F a      -> F a
        | Arr a    -> F A.(sum' a)
        | _        -> error_uniop "sum" a
      in
      let fd a = sum' a in
      let df _cp _ap at = sum' at in
      let r a = Sum_D a in
      op_d_d a ff fd df r

    and sum ?(axis=(-1)) a =
      let ff = function
        | F a      -> F a
        | Arr a    -> Arr A.(sum ~axis a)
        | _        -> error_uniop "sum" a
      in
      let fd a = sum ~axis a in
      let df _cp _ap at = sum ~axis at in
      let r a = Sum__D (a, axis) in
      op_d_d a ff fd df r

    and sum_reduce ?(axis=[|0|]) a =
      let ff = function
        | F a      -> F a
        | Arr x    -> Arr A.(sum_reduce ~axis x)
        | _        -> error_uniop "sum_reduce" a
      in
      let fd a = sum_reduce ~axis a in
      let df _cp _ap at = sum_reduce ~axis at in
      let r a = Sum___D (a, axis) in
      op_d_d a ff fd df r

    and mean a = (sum' a) / F (numel a |> float_of_int |> A.float_to_elt)

    and ( *@ ) a b = dot a b
    and dot a b =
      let ff a b =
        match a, b with
        | Arr a, Arr b       -> Arr A.(dot a b)
        | _                  -> error_binop "( *@ )" a b
      in
      let fd a b = a *@ b in
      let df_da _cp _ap at = at *@ b in
      let df_db _cp _bp bt = a *@ bt in
      let df_dab _cp ap at bp bt = (ap *@ bt) + (at *@ bp) in
      let r_d_d a b = Dot_D_D (a, b) in
      let r_d_c a b = Dot_D_C (a, b) in
      let r_c_d a b = Dot_C_D (a, b) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and transpose a =
      let ff = function
        | Arr a    -> Arr A.(transpose a)
        | _        -> error_uniop "transpose" a
      in
      let fd a = transpose a in
      let df _cp _ap at = transpose at in
      let r a = Trans_D a in
      op_d_d a ff fd df r

    and l1norm' a =
      let ff = function
        | Arr a    -> F A.(l1norm' a)
        | _        -> error_uniop "l1norm'" a
      in
      let fd a = l1norm' a in
      let df _cp ap at = at * (signum ap) in
      let r a = L1Norm_D a in
      op_d_d a ff fd df r

    and l2norm' a =
      let ff = function
        | Arr a    -> F A.(l2norm' a)
        | _        -> error_uniop "l2norm'" a
      in
      let fd a = l2norm' a in
      let df cp ap at = (ap * at) / cp in
      let r a = L2Norm_D a in
      op_d_d a ff fd df r

    and l2norm_sqr' a =
      let ff = function
        | F a      -> F A.Scalar.(sqr a)
        | Arr a    -> F A.(l2norm_sqr' a)
        | _        -> error_uniop "l2norm_sqr'" a
      in
      let fd a = l2norm_sqr' a in
      let df _cp ap at = (pack_flt 2.) * (ap * at) in
      let r a = L2NormS_D a in
      op_d_d a ff fd df r

    and sigmoid a =
      let ff = function
        | F a      -> F A.Scalar.(sigmoid a)
        | Arr a    -> Arr A.(sigmoid a)
        | _        -> error_uniop "sigmoid" a
      in
      let fd a = sigmoid a in
      let df cp _ap at = at * cp * ((pack_flt 1.) - cp) in
      let r a = Sigmoid_D a in
      op_d_d a ff fd df r

    and relu a =
      let ff = function
        | F a      -> F A.Scalar.(relu a)
        | Arr a    -> Arr A.(relu a)
        | _        -> error_uniop "relu" a
      in
      let fd a = relu a in
      let df _cp ap at = at * ((pack_flt 1.) + (signum ap)) / (pack_flt 2.) in
      let r a = Relu_D a in
      op_d_d a ff fd df r

    and diag ?(k=0) a = 
      let ff = function
        | Arr a    -> Arr A.(diag ~k a |> copy)
        | _        -> error_uniop "diag" a
      in
      let fd a = diag ~k a in
      let df _cp _ap at = diag ~k at in
      let r a = Diag_D (k, a) in
      op_d_d a ff fd df r

    and trace a = 
      let ff = function
        | Arr a     -> F A.(trace a)
        | _         -> error_uniop "trace" a 
      in
      let fd a = trace a in
      let df _cp _ap at = trace at in
      let r a = Trace_D a in
      op_d_d a ff fd df r

    and triu ?(k=0) a = 
      let ff = function
        | Arr a    -> Arr A.(triu ~k a |> copy)
        | _        -> error_uniop "triu" a
      in
      let fd a = triu ~k a in
      let df _cp _ap at = triu ~k at in
      let r a = Triu_D (k, a) in
      op_d_d a ff fd df r

    and tril ?(k=0) a = 
      let ff = function
        | Arr a    -> Arr A.(tril ~k a |> copy)
        | _        -> error_uniop "tril" a
      in
      let fd a = tril ~k a in
      let df _cp _ap _at = tril ~k a in
      let r a = Tril_D (k, a) in
      op_d_d a ff fd df r

    and inv a =
      let ff = function
        | Arr a    -> Arr A.(inv a)
        | _        -> error_uniop "inv" a
      in
      let fd a = inv a in
      let df cp _ap at = (neg cp) * at * cp in
      let r a = Inv_D a in
      op_d_d a ff fd df r

    and qr a = 
      let ff = function
        | Arr a -> let q, r = A.(qr a) in Pair (Arr q, Arr r)
        | _     -> error_uniop "qr" a
      in
      let fd a = qr a in
      let df _cp _ap _at = raise Owl_exception.NOT_IMPLEMENTED in
      let r a = QR_D a in
      op_d_d a ff fd df r 

    and qr_backward a aa ap = 
      let q, r = match ap with
        | Pair (q, r) -> q, r
        | _ -> error_uniop "qr" a in
      let qbar, rbar = match aa with
        | Pair (qbar, rbar) -> qbar, rbar 
        | _ -> error_uniop "qr" a in
      let qt = transpose q and qbart = transpose qbar in
      let rt = transpose r and rbart = transpose rbar in
      let rinvt = r *@ (inv (rt *@ r)) in (* transpose of the left moore-penrose pseudoinverse *)
      let middle = tril ~k:(-1) ( (r*@rbart) - (rbar*@rt) + (qt*@qbar) - (qbart*@q) ) in
      (q*@(rbar + (middle*@rinvt))) + ((qbar - (q*@(qt*@qbar)))*@rinvt) 

    and lyapunov a q =
      let ff a q =
        match a, q with
        | Arr a, Arr q       -> Arr A.(lyapunov a q)
        | _                  -> error_binop "lyapunov" a q
      in
      let fd a q = lyapunov a q in
      let df_da _cp _ap _at = raise Owl_exception.NOT_IMPLEMENTED in
      let df_dq _cp _qp _qt = raise Owl_exception.NOT_IMPLEMENTED in
      let df_daq _cp _ap _at _qp _qt = raise Owl_exception.NOT_IMPLEMENTED in
      let r_d_d a q = Lyapunov_D_D (a, q) in
      let r_d_c a q = Lyapunov_D_C (a, q) in
      let r_c_d a q = Lyapunov_C_D (a, q) in
      op_d_d_d a q ff fd df_da df_dq df_daq r_d_d r_d_c r_c_d

    and lyapunov_backward_a a aa ap = (pack_flt 2.) * (lyapunov (transpose a) (neg aa)) *@ ap

    and lyapunov_backward_q a aa = lyapunov (transpose a) aa 

    and lyapunov_backward_aq a aa ap = 
      let s = lyapunov (transpose a) (neg aa) in
      s, (pack_flt 2.) * s *@ ap

    and softplus x = log ((pack_flt 1.) + exp x)

    and softsign x = x / ((pack_flt 1.) + abs x)

    and softmax ?(axis=(-1)) x =
      let c = Arr A.(max ~axis (unpack_arr x)) in
      let y = exp (x - c) in
      let a = sum ~axis y in
      y / a

    and cross_entropy x y = x * log y |> sum' |> neg

    and add_row a b i =
      let ff a b =
        match a, b with
        | Arr a, Arr b       -> A.(copy_row_to (add (row a i) b) a i; Arr a)
        | _                  -> error_binop "add_row" a b
      in
      let fd a b = add_row a b i in
      let df_da _cp _ap at = at in
      let df_db _cp _bp bt = add_row (zero a) bt i in
      let df_dab _cp _ap at _bp bt = add_row at bt i in
      let r_d_d a b = Add_Row_D_D (a, b, i) in
      let r_d_c a b = Add_Row_D_C (a, b, i) in
      let r_c_d a b = Add_Row_C_D (a, b, i) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and get_row a i =
      let ff = function
        | Arr a    -> Arr A.(row a i |> copy)
        | _        -> error_uniop "get_row" a
      in
      let fd a = get_row a i in
      let df _cp _ap at = get_row at i in
      let r a = Get_Row_D (a, i) in
      op_d_d a ff fd df r

    and to_rows a = Array.init (row_num a) (fun i -> get_row a i)

    and of_rows a =
      (* TODO: this can be further optimised by incorporating t array type as t *)
      match a.(0) with
      | Arr _               -> Array.map unpack_arr a |> A.of_rows |> pack_arr
      | DF (_, _, ai)       ->
        let ap = a |> Array.map (fun x -> x |> primal |> unpack_arr) |> A.of_rows |> pack_arr in
        let at = a |> Array.map (fun x -> x |> adjval |> unpack_arr) |> A.of_rows |> pack_arr in
        DF (ap, at, ai)
      | DR (_, _, _, _, ai) ->
        let ap = a |> Array.map (fun x -> x |> primal) in
        let cp = ap |> Array.map (fun x -> x |> unpack_arr) |> A.of_rows |> pack_arr in
        DR (cp, ref (zero cp), Of_Rows_D a, ref 0, ai)
      | _                  -> error_uniop "of_rows a.(0)" a.(0)

    (* NOTE: these fucntions are for neural network. There are many restrictions
       at the moment. E.g. they do not support higher-order derivatives, and some
       do not support forward mode, so use them when you know what you are doing.
    *)

    (* a:input; b:kernel; s:stride *)
    and conv1d ?padding a b s =
      let ff a b =
        match a, b with
        | Arr a, Arr b -> Arr A.(conv1d ?padding a b s)
        | _            -> error_binop "conv1d" a b
      in
      let fd a b = conv1d ?padding a b s in
      (* FIXME: df_da, df_db, df_dab are not correct ... do not use *)
      let df_da _cp _ap _at = failwith "conv1d:df_da" in
      let df_db _cp _bp _bt = failwith "conv1d:df_db" in
      let df_dab _cp _ap _at _bp _bt = failwith "conv1d:df_dab" in
      let r_d_d a b = Conv1D_D_D (a, b, s) in
      let r_d_c a b = Conv1D_D_C (a, b, s) in
      let r_c_d a b = Conv1D_C_D (a, b, s) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    (* a:input; b:kernel; s:stride; o:output' *)
    and conv1d_backward_input a b s o =
      let a = unpack_arr a in
      let b = unpack_arr b in
      let o = unpack_arr o in
      A.conv1d_backward_input a b s o
      |> pack_arr

    (* a:input; b:kernel; s:stride; o:output' *)
    and conv1d_backward_kernel a b s o =
      let a = unpack_arr a in
      let b = unpack_arr b in
      let o = unpack_arr o in
      A.conv1d_backward_kernel a b s o
      |> pack_arr

    (* a:input; b:kernel; s:stride *)
    and conv2d ?padding a b s =
      let ff a b =
        match a, b with
        | Arr a, Arr b -> Arr A.(conv2d ?padding a b s)
        | _            -> error_binop "conv2d" a b
      in
      let fd a b = conv2d ?padding a b s in
      (* FIXME: df_da, df_db, df_dab are not correct ... do not use *)
      let df_da _cp _ap at = at in
      let df_db _cp _bp bt = bt in
      let df_dab _cp _ap at _bp bt = at + bt in
      let r_d_d a b = Conv2D_D_D (a, b, s) in
      let r_d_c a b = Conv2D_D_C (a, b, s) in
      let r_c_d a b = Conv2D_C_D (a, b, s) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    (* a:input; b:kernel; s:stride; o:output' *)
    and conv2d_backward_input a b s o =
      let a = unpack_arr a in
      let b = unpack_arr b in
      let o = unpack_arr o in
      A.conv2d_backward_input a b s o
      |> pack_arr

    (* a:input; b:kernel; s:stride; o:output' *)
    and conv2d_backward_kernel a b s o =
      let a = unpack_arr a in
      let b = unpack_arr b in
      let o = unpack_arr o in
      A.conv2d_backward_kernel a b s o
      |> pack_arr

    (* a:input; b:kernel; s:stride *)
    and conv3d ?padding a b s =
      let ff a b =
        match a, b with
        | Arr a, Arr b -> Arr A.(conv3d ?padding a b s)
        | _            -> error_binop "conv3d" a b
      in
      let fd a b = conv3d ?padding a b s in
      (* FIXME: df_da, df_db, df_dab are not correct ... do not use *)
      let df_da _cp _ap at = at in
      let df_db _cp _bp bt = bt in
      let df_dab _cp _ap at _bp bt = at + bt in
      let r_d_d a b = Conv3D_D_D (a, b, s) in
      let r_d_c a b = Conv3D_D_C (a, b, s) in
      let r_c_d a b = Conv3D_C_D (a, b, s) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    (* a:input; b:kernel; s:stride; o:output' *)
    and conv3d_backward_input a b s o =
      let a = unpack_arr a in
      let b = unpack_arr b in
      let o = unpack_arr o in
      A.conv3d_backward_input a b s o
      |> pack_arr

    (* a:input; b:kernel; s:stride; o:output' *)
    and conv3d_backward_kernel a b s o =
      let a = unpack_arr a in
      let b = unpack_arr b in
      let o = unpack_arr o in
      A.conv3d_backward_kernel a b s o
      |> pack_arr

    (* a:input; b:kernel; s:stride; r:rate *)
    and dilated_conv1d ?padding a b s r =
      let ff a b =
        match a, b with
        | Arr a, Arr b -> Arr A.(dilated_conv1d ?padding a b s r)
        | _            -> error_binop "dilated_conv1d" a b
      in
      let fd a b = dilated_conv1d ?padding a b s r in
      (* FIXME: df_da, df_db, df_dab are not correct ... do not use *)
      let df_da _cp _ap at = at in
      let df_db _cp _bp bt = bt in
      let df_dab _cp _ap at _bp bt = at + bt in
      let r_d_d a b = Di_Conv1D_D_D (a, b, s, r) in
      let r_d_c a b = Di_Conv1D_D_C (a, b, s, r) in
      let r_c_d a b = Di_Conv1D_C_D (a, b, s, r) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    (* a:input; b:kernel; o:output'; s:stride; r:rate *)
    and dilated_conv1d_backward_input a b s r o =
      let a = unpack_arr a in
      let b = unpack_arr b in
      let o = unpack_arr o in
      A.dilated_conv1d_backward_input a b s r o
      |> pack_arr

    (* a:input; b:kernel; o:output'; s:stride; r:rate *)
    and dilated_conv1d_backward_kernel a b s r o =
      let a = unpack_arr a in
      let b = unpack_arr b in
      let o = unpack_arr o in
      A.dilated_conv1d_backward_kernel a b s r o
      |> pack_arr

    (* a:input; b:kernel; s:stride; r:rate *)
    and dilated_conv2d ?padding a b s r =
      let ff a b =
        match a, b with
        | Arr a, Arr b -> Arr A.(dilated_conv2d ?padding a b s r)
        | _            -> error_binop "dilated_conv2d" a b
      in
      let fd a b = dilated_conv2d ?padding a b s r in
      (* FIXME: df_da, df_db, df_dab are not correct ... do not use *)
      let df_da _cp _ap at = at in
      let df_db _cp _bp bt = bt in
      let df_dab _cp _ap at _bp bt = at + bt in
      let r_d_d a b = Di_Conv2D_D_D (a, b, s, r) in
      let r_d_c a b = Di_Conv2D_D_C (a, b, s, r) in
      let r_c_d a b = Di_Conv2D_C_D (a, b, s, r) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    (* a:input; b:kernel; o:output'; s:stride; r:rate *)
    and dilated_conv2d_backward_input a b s r o =
      let a = unpack_arr a in
      let b = unpack_arr b in
      let o = unpack_arr o in
      A.dilated_conv2d_backward_input a b s r o
      |> pack_arr

    (* a:input; b:kernel; o:output'; s:stride; r:rate *)
    and dilated_conv2d_backward_kernel a b s r o =
      let a = unpack_arr a in
      let b = unpack_arr b in
      let o = unpack_arr o in
      A.dilated_conv2d_backward_kernel a b s r o
      |> pack_arr

    (* a:input; b:kernel; s:stride; r:rate *)
    and dilated_conv3d ?padding a b s r =
      let ff a b =
        match a, b with
        | Arr a, Arr b -> Arr A.(dilated_conv3d ?padding a b s r)
        | _            -> error_binop "dilated_conv3d" a b
      in
      let fd a b = dilated_conv3d ?padding a b s r in
      (* FIXME: df_da, df_db, df_dab are not correct ... do not use *)
      let df_da _cp _ap at = at in
      let df_db _cp _bp bt = bt in
      let df_dab _cp _ap at _bp bt = at + bt in
      let r_d_d a b = Di_Conv3D_D_D (a, b, s, r) in
      let r_d_c a b = Di_Conv3D_D_C (a, b, s, r) in
      let r_c_d a b = Di_Conv3D_C_D (a, b, s, r) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    (* a:input; b:kernel; o:output'; s:stride; r:rate *)
    and dilated_conv3d_backward_input a b s r o =
      let a = unpack_arr a in
      let b = unpack_arr b in
      let o = unpack_arr o in
      A.dilated_conv3d_backward_input a b s r o
      |> pack_arr

    (* a:input; b:kernel; o:output'; s:stride; r:rate *)
    and dilated_conv3d_backward_kernel a b s r o =
      let a = unpack_arr a in
      let b = unpack_arr b in
      let o = unpack_arr o in
      A.dilated_conv3d_backward_kernel a b s r o
      |> pack_arr

    (* a:input; b:kernel; s:stride *)
    and transpose_conv1d ?padding a b s =
      let ff a b =
        match a, b with
        | Arr a, Arr b -> Arr A.(transpose_conv1d ?padding a b s)
        | _            -> error_binop "transpose_conv1d" a b
      in
      let fd a b = transpose_conv1d ?padding a b s in
      (* FIXME: df_da, df_db, df_dab are not correct ... do not use *)
      let df_da _cp _ap at = at in
      let df_db _cp _bp bt = bt in
      let df_dab _cp _ap at _bp bt = at + bt in
      let r_d_d a b = Tr_Conv1D_D_D (a, b, s) in
      let r_d_c a b = Tr_Conv1D_D_C (a, b, s) in
      let r_c_d a b = Tr_Conv1D_C_D (a, b, s) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    (* a:input; b:kernel; s:stride; o:output' *)
    and transpose_conv1d_backward_input a b s o =
      let a = unpack_arr a in
      let b = unpack_arr b in
      let o = unpack_arr o in
      A.transpose_conv1d_backward_input a b s o
      |> pack_arr

    (* a:input; b:kernel; s:stride; o:output' *)
    and transpose_conv1d_backward_kernel a b s o =
      let a = unpack_arr a in
      let b = unpack_arr b in
      let o = unpack_arr o in
      A.transpose_conv1d_backward_kernel a b s o
      |> pack_arr

    (* a:input; b:kernel; s:stride *)
    and transpose_conv2d ?padding a b s =
      let ff a b =
        match a, b with
        | Arr a, Arr b -> Arr A.(transpose_conv2d ?padding a b s)
        | _            -> error_binop "transpose_conv2d" a b
      in
      let fd a b = transpose_conv2d ?padding a b s in
      (* FIXME: df_da, df_db, df_dab are not correct ... do not use *)
      let df_da _cp _ap at = at in
      let df_db _cp _bp bt = bt in
      let df_dab _cp _ap at _bp bt = at + bt in
      let r_d_d a b = Tr_Conv2D_D_D (a, b, s) in
      let r_d_c a b = Tr_Conv2D_D_C (a, b, s) in
      let r_c_d a b = Tr_Conv2D_C_D (a, b, s) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    (* a:input; b:kernel; s:stride; o:output' *)
    and transpose_conv2d_backward_input a b s o =
      let a = unpack_arr a in
      let b = unpack_arr b in
      let o = unpack_arr o in
      A.transpose_conv2d_backward_input a b s o
      |> pack_arr

    (* a:input; b:kernel; s:stride; o:output' *)
    and transpose_conv2d_backward_kernel a b s o =
      let a = unpack_arr a in
      let b = unpack_arr b in
      let o = unpack_arr o in
      A.transpose_conv2d_backward_kernel a b s o
      |> pack_arr

    (* a:input; b:kernel; s:stride *)
    and transpose_conv3d ?padding a b s =
      let ff a b =
        match a, b with
        | Arr a, Arr b -> Arr A.(transpose_conv3d ?padding a b s)
        | _            -> error_binop "transpose_conv3d" a b
      in
      let fd a b = transpose_conv3d ?padding a b s in
      (* FIXME: df_da, df_db, df_dab are not correct ... do not use *)
      let df_da _cp _ap at = at in
      let df_db _cp _bp bt = bt in
      let df_dab _cp _ap at _bp bt = at + bt in
      let r_d_d a b = Tr_Conv3D_D_D (a, b, s) in
      let r_d_c a b = Tr_Conv3D_D_C (a, b, s) in
      let r_c_d a b = Tr_Conv3D_C_D (a, b, s) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    (* a:input; b:kernel; s:stride; o:output' *)
    and transpose_conv3d_backward_input a b s o =
      let a = unpack_arr a in
      let b = unpack_arr b in
      let o = unpack_arr o in
      A.transpose_conv3d_backward_input a b s o
      |> pack_arr

    (* a:input; b:kernel; s:stride; o:output' *)
    and transpose_conv3d_backward_kernel a b s o =
      let a = unpack_arr a in
      let b = unpack_arr b in
      let o = unpack_arr o in
      A.transpose_conv3d_backward_kernel a b s o
      |> pack_arr

    and reshape a s =
      let ff = function
        | Arr a    -> Arr A.(reshape a s)
        | _        -> error_uniop "reshape" a
      in
      let fd a = reshape a s in
      let df _cp _ap at = reshape at s in
      let r a = Reshape_D a in
      op_d_d a ff fd df r

    and flatten a = reshape a [|1; numel a|]

    (* a:input; b:kernel; s:stride *)
    and max_pool1d padding a b s =
      let ff = function
        | Arr a    -> Arr A.(max_pool1d ~padding a b s)
        | _        -> error_uniop "max_pool1d" a
      in
      let fd a = max_pool1d padding a b s in
      let df _cp _ap _at = failwith "max_pool1d:df" in
      let r a = Maxpool1D_D (a, padding, b, s) in
      op_d_d a ff fd df r

    (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
    and max_pool1d_backward p a b s o =
      let a = unpack_arr a in
      let o = unpack_arr o in
      A.max_pool1d_backward p a b s o
      |> pack_arr

    (* a:input; b:kernel; s:stride *)
    and max_pool2d padding a b s =
      let ff = function
        | Arr a    -> Arr A.(max_pool2d ~padding a b s)
        | _        -> error_uniop "max_pool2d" a
      in
      let fd a = max_pool2d padding a b s in
      let df _cp _ap _at = failwith "max_pool2d:df" in
      let r a = Maxpool2D_D (a, padding, b, s) in
      op_d_d a ff fd df r

    (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
    and max_pool2d_backward p a b s o =
      let a = unpack_arr a in
      let o = unpack_arr o in
      A.max_pool2d_backward p a b s o
      |> pack_arr

    (* a:input; b:kernel; s:stride *)
    and max_pool3d padding a b s =
      let ff = function
        | Arr a    -> Arr A.(max_pool3d ~padding a b s)
        | _        -> error_uniop "max_pool3d" a
      in
      let fd a = max_pool3d padding a b s in
      let df _cp _ap _at = failwith "max_pool3d:df" in
      let r a = Maxpool3D_D (a, padding, b, s) in
      op_d_d a ff fd df r

    (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
    and max_pool3d_backward p a b s o =
      let a = unpack_arr a in
      let o = unpack_arr o in
      A.max_pool3d_backward p a b s o
      |> pack_arr

    (* a:input; b:kernel; s:stride *)
    and avg_pool1d padding a b s =
      let ff = function
        | Arr a    -> Arr A.(avg_pool1d ~padding a b s)
        | _        -> error_uniop "avg_pool1d" a
      in
      let fd a = avg_pool1d padding a b s in
      let df _cp _ap _at = failwith "avg_pool1d:df" in
      let r a = Avgpool1D_D (a, padding, b, s) in
      op_d_d a ff fd df r

    (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
    and avg_pool1d_backward p a b s o =
      let a = unpack_arr a in
      let o = unpack_arr o in
      A.avg_pool1d_backward p a b s o
      |> pack_arr

    (* a:input; b:kernel; s:stride *)
    and avg_pool2d padding a b s =
      let ff = function
        | Arr a    -> Arr A.(avg_pool2d ~padding a b s)
        | _        -> error_uniop "avg_pool2d" a
      in
      let fd a = avg_pool2d padding a b s in
      let df _cp _ap _at = failwith "avg_pool2d:df" in
      let r a = Avgpool2D_D (a, padding, b, s) in
      op_d_d a ff fd df r

    (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
    and avg_pool2d_backward p a b s o =
      let a = unpack_arr a in
      let o = unpack_arr o in
      A.avg_pool2d_backward p a b s o
      |> pack_arr

    (* a:input; b:kernel; s:stride *)
    and avg_pool3d padding a b s =
      let ff = function
        | Arr a    -> Arr A.(avg_pool3d ~padding a b s)
        | _        -> error_uniop "avg_pool3d" a
      in
      let fd a = avg_pool3d padding a b s in
      let df _cp _ap _at = failwith "avg_pool3d:df" in
      let r a = Avgpool3D_D (a, padding, b, s) in
      op_d_d a ff fd df r

    (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
    and avg_pool3d_backward p a b s o =
      let a = unpack_arr a in
      let o = unpack_arr o in
      A.avg_pool3d_backward p a b s o
      |> pack_arr

    (* a:input; s:size *)
    and upsampling2d a s =
      let ff = function
        | Arr a    -> Arr A.(upsampling2d a s)
        | _        -> error_uniop "upsampling2d" a
      in
      let fd a = upsampling2d a s in
      let df _cp _ap _at = failwith "upsampling2d:df" in
      let r a = UpSampling2D_D (a, s) in
      op_d_d a ff fd df r

    (* a:input; s:size; o:output' *)
    and upsampling2d_backward a s o =
      let a = unpack_arr a in
      let o = unpack_arr o in
      A.upsampling2d_backward a s o
      |> pack_arr

    (* v: padded value; p:padding index; a:input *)
    and pad ?v p a =
      let ff = function
        | Arr a -> Arr A.(pad ?v p a)
        | _     -> error_uniop "pad" a
      in
      let fd = pad p in
      let df _cp _ap _at = failwith "pad:df" in
      let r a = PAD_D (a, p) in
      op_d_d a ff fd df r

    (* TODO: sources required to confirm this backward op *)
    (* o:outut'; p: padding index *)
    and pad_backward o p =
      (* assume p is full legal index for pad operation *)
      let o  = unpack_arr o in
      let os = A.shape o in
      let q  = Owl_utils.llss2aarr p in
      Array.iteri (fun i x ->
          x.(1) <- Pervasives.(os.(i) - 1 - x.(1));
        ) q;
      let q = Owl_utils.aarr2llss q in
      A.(get_slice q o) |> pack_arr

    and dropout ?(rate=0.5) a =
      let p = A.float_to_elt (1. -. rate) in
      let b = match (primal' a) with
        | Arr a -> Arr (A.bernoulli ~p (A.shape a))
        | _     -> error_uniop "dropout" a
      in
      a * b

    and concat axis a b =
      let ff a b =
        match a, b with
        | Arr a, Arr b -> Arr A.(concatenate ~axis [|a; b|])
        | _            -> error_binop "concat" a b
      in
      let fd a b = concat axis a b in
      let df_da _cp _ap at = concat axis at (zero b) in
      let df_db _cp _bp bt = concat axis (zero a) bt in
      let df_dab _cp _ap at _bp bt = concat axis at bt in
      let r_d_d a b = Concat_D_D (a, b, axis) in
      let r_d_c a b = Concat_D_C (a, b, axis) in
      let r_c_d a b = Concat_C_D (a, b, axis) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and split axis parts a =
      let ff a =
        match a with
        | Arr a -> A.(split ~axis parts a) |> Array.map (fun x -> Arr x)
        | _     -> error_uniop "split" a
      in
      ff a

    (* TODO: trace and diag functions ... *)

  end


  (* core of the reverse mode *)

  let reverse_reset x =
    let rec reset xs =
      match xs with
      | [] -> ()
      | x :: t -> (
          match x with
          | DR (_ap, aa, ao, af, _ai) -> (
              aa := reset_zero !aa;
              af := !af + 1;
              if !af = 1 then (
                match ao with
                | Noop                       -> reset t
                | Add_D_D (a, b)             -> reset (a :: b :: t)
                | Add_D_C (a, _)             -> reset (a :: t)
                | Add_C_D (_, b)             -> reset (b :: t)
                | Sub_D_D (a, b)             -> reset (a :: b :: t)
                | Sub_D_C (a, _)             -> reset (a :: t)
                | Sub_C_D (_, b)             -> reset (b :: t)
                | Mul_D_D (a, b)             -> reset (a :: b :: t)
                | Mul_D_C (a, _)             -> reset (a :: t)
                | Mul_C_D (_, b)             -> reset (b :: t)
                | Div_D_D (a, b)             -> reset (a :: b :: t)
                | Div_D_C (a, _)             -> reset (a :: t)
                | Div_C_D (_, b)             -> reset (b :: t)
                | Pow_D_D (a, b)             -> reset (a :: b :: t)
                | Pow_D_C (a, _)             -> reset (a :: t)
                | Pow_C_D (_, b)             -> reset (b :: t)
                | Atan2_D_D (a, b)           -> reset (a :: b :: t)
                | Atan2_D_C (a, _)           -> reset (a :: t)
                | Atan2_C_D (_, b)           -> reset (b :: t)
                | Neg_D a                    -> reset (a :: t)
                | Abs_D a                    -> reset (a :: t)
                | Signum_D a                 -> reset (a :: t)
                | Floor_D a                  -> reset (a :: t)
                | Ceil_D a                   -> reset (a :: t)
                | Round_D a                  -> reset (a :: t)
                | Sqr_D a                    -> reset (a :: t)
                | Sqrt_D a                   -> reset (a :: t)
                | Log_D a                    -> reset (a :: t)
                | Log2_D a                   -> reset (a :: t)
                | Log10_D a                  -> reset (a :: t)
                | Exp_D a                    -> reset (a :: t)
                | Sin_D a                    -> reset (a :: t)
                | Cos_D a                    -> reset (a :: t)
                | Tan_D a                    -> reset (a :: t)
                | Sinh_D a                   -> reset (a :: t)
                | Cosh_D a                   -> reset (a :: t)
                | Tanh_D a                   -> reset (a :: t)
                | Asin_D a                   -> reset (a :: t)
                | Acos_D a                   -> reset (a :: t)
                | Atan_D a                   -> reset (a :: t)
                | Asinh_D a                  -> reset (a :: t)
                | Acosh_D a                  -> reset (a :: t)
                | Atanh_D a                  -> reset (a :: t)
                | Get_Item (a, _, _)         -> reset (a :: t)
                | SetI_D_D (a, _, _, b)      -> reset (a :: b :: t)
                | SetI_D_C (a, _, _, _)      -> reset (a :: t)
                | SetI_C_D (_, _, _, b)      -> reset (b :: t)
                | AddI_D_D (a, _, _, b)      -> reset (a :: b :: t)
                | AddI_D_C (a, _, _, _)      -> reset (a :: t)
                | AddI_C_D (_, _, _, b)      -> reset (b :: t)
                | Get_Slice_D (a, _)         -> reset (a :: t)
                | Set_Slice_D_D (a, b, _)    -> reset (a :: b :: t)
                | Set_Slice_D_C (a, _, _)    -> reset (a :: t)
                | Set_Slice_C_D (_, b, _)    -> reset (b :: t)
                | Sum_D a                    -> reset (a :: t)
                | Sum__D (a, _)              -> reset (a :: t)
                | Sum___D (a, _)             -> reset (a :: t)
                | Dot_D_D (a, b)             -> reset (a :: b :: t)
                | Dot_D_C (a, _)             -> reset (a :: t)
                | Dot_C_D (_, b)             -> reset (b :: t)
                | Trans_D a                  -> reset (a :: t)
                | L1Norm_D a                 -> reset (a :: t)
                | L2Norm_D a                 -> reset (a :: t)
                | L2NormS_D a                -> reset (a :: t)
                | Sigmoid_D a                -> reset (a :: t)
                | Relu_D a                   -> reset (a :: t)
                | Inv_D a                    -> reset (a :: t)
                | QR_D a                     -> reset (a :: t)
                | Lyapunov_D_D (a, q)        -> reset (a :: q :: t)
                | Lyapunov_D_C (a, _)        -> reset (a :: t)
                | Lyapunov_C_D (_, q)        -> reset (q :: t)
                | Diag_D (_, a)              -> reset (a :: t)
                | Triu_D (_, a)              -> reset (a :: t)
                | Tril_D (_, a)              -> reset (a :: t)
                | Trace_D a                  -> reset (a :: t)
                | Add_Row_D_D (a, b, _)      -> reset (a :: b :: t)
                | Add_Row_D_C (a, _, _)      -> reset (a :: t)
                | Add_Row_C_D (_, b, _)      -> reset (b :: t)
                | Get_Row_D (a, _)           -> reset (a :: t)
                | Of_Rows_D a                -> reset (List.append (Array.to_list a) t)
                | Conv1D_D_D (a, b, _)       -> reset (a :: b :: t)
                | Conv1D_D_C (a, _, _)       -> reset (a :: t)
                | Conv1D_C_D (_, b, _)       -> reset (b :: t)
                | Conv2D_D_D (a, b, _)       -> reset (a :: b :: t)
                | Conv2D_D_C (a, _, _)       -> reset (a :: t)
                | Conv2D_C_D (_, b, _)       -> reset (b :: t)
                | Conv3D_D_D (a, b, _)       -> reset (a :: b :: t)
                | Conv3D_D_C (a, _, _)       -> reset (a :: t)
                | Conv3D_C_D (_, b, _)       -> reset (b :: t)
                | Di_Conv1D_D_D (a, b, _, _) -> reset (a :: b :: t)
                | Di_Conv1D_D_C (a, _, _, _) -> reset (a :: t)
                | Di_Conv1D_C_D (_, b, _, _) -> reset (b :: t)
                | Di_Conv2D_D_D (a, b, _, _) -> reset (a :: b :: t)
                | Di_Conv2D_D_C (a, _, _, _) -> reset (a :: t)
                | Di_Conv2D_C_D (_, b, _, _) -> reset (b :: t)
                | Di_Conv3D_D_D (a, b, _, _) -> reset (a :: b :: t)
                | Di_Conv3D_D_C (a, _, _, _) -> reset (a :: t)
                | Di_Conv3D_C_D (_, b, _, _) -> reset (b :: t)
                | Tr_Conv1D_D_D (a, b, _)    -> reset (a :: b :: t)
                | Tr_Conv1D_D_C (a, _, _)    -> reset (a :: t)
                | Tr_Conv1D_C_D (_, b, _)    -> reset (b :: t)
                | Tr_Conv2D_D_D (a, b, _)    -> reset (a :: b :: t)
                | Tr_Conv2D_D_C (a, _, _)    -> reset (a :: t)
                | Tr_Conv2D_C_D (_, b, _)    -> reset (b :: t)
                | Tr_Conv3D_D_D (a, b, _)    -> reset (a :: b :: t)
                | Tr_Conv3D_D_C (a, _, _)    -> reset (a :: t)
                | Tr_Conv3D_C_D (_, b, _)    -> reset (b :: t)
                | Reshape_D a                -> reset (a :: t)
                | Maxpool1D_D (a, _, _, _)   -> reset (a :: t)
                | Maxpool2D_D (a, _, _, _)   -> reset (a :: t)
                | Maxpool3D_D (a, _, _, _)   -> reset (a :: t)
                | Avgpool1D_D (a, _, _, _)   -> reset (a :: t)
                | Avgpool2D_D (a, _, _, _)   -> reset (a :: t)
                | Avgpool3D_D (a, _, _, _)   -> reset (a :: t)
                | UpSampling2D_D (a, _)      -> reset (a :: t)
                | PAD_D (a, _)               -> reset (a :: t)
                | Concat_D_D (a, b, _)       -> reset (a :: b :: t)
                | Concat_D_C (a, _, _)       -> reset (a :: t)
                | Concat_C_D (_, b, _)       -> reset (b :: t)
              )
              else reset t
            )
          | _ -> reset t
        )
    in
    reset [x]


  (* check adjoint a and its update v, ensure rank a >= rank v. This function
     fixes the inconsistent shapes between a and v by performing the inverse
     operation of the previous broadcasting function. Note that padding is on
     the left due to the expand function called in broadcasting. *)
  let _shrink a v =
    match a, v with
    | F _, Arr v   -> F (A.sum' v)
    | Arr a, Arr v -> (
        let shp_a = A.shape a in
        let shp_v = A.shape v in
        if shp_a <> shp_v then (
          let shp_a, shp_v = Owl_utils_array.align `Left 1 shp_a shp_v in
          let axis = Owl_utils_array.filter2_i ( <> ) shp_a shp_v in
          Arr (A.sum_reduce ~axis v)
        )
        else Arr v
      )
    | _a, v         -> v


  let reverse_push v x =
    let open Maths in
    let rec push xs =
      match xs with
      | []          -> ()
      | (v, x) :: t -> (
          match x with
          | DR (ap, aa, ao, af, _ai) -> (
              let v = _shrink !aa v in
              aa := Maths.(!aa + v);
              af := Pervasives.(!af - 1);
              if !af = 0 then (
                match ao with
                | Noop                       -> push t
                | Add_D_D (a, b)             -> push ((!aa, a) :: (!aa, b) :: t)
                | Add_D_C (a, _)             -> push ((!aa, a) :: t)
                | Add_C_D (_, b)             -> push ((!aa, b) :: t)
                | Sub_D_D (a, b)             -> push ((!aa, a) :: (neg !aa, b) :: t)
                | Sub_D_C (a, _)             -> push ((!aa, a) :: t)
                | Sub_C_D (_, b)             -> push ((neg !aa, b) :: t)
                | Mul_D_D (a, b)             -> push (((!aa * primal b), a) :: ((!aa * primal a), b) :: t)
                | Mul_D_C (a, b)             -> push (((!aa * b), a) :: t)
                | Mul_C_D (a, b)             -> push (((!aa * a), b) :: t)
                | Div_D_D (a, b)             -> push (((!aa / (primal b)), a) :: ((!aa * ((neg (primal a)) / ((primal b) * (primal b)))), b) :: t)
                | Div_D_C (a, b)             -> push (((!aa / b), a) :: t)
                | Div_C_D (a, b)             -> push (((!aa * ((neg a) / ((primal b) * (primal b)))), b) :: t)
                | Pow_D_D (a, b)             -> push (((!aa * ((primal a) ** ((primal b) - (pack_flt 1.))) * (primal b)), a) :: ((!aa * ((primal a) ** (primal b)) * log (primal a)), b) :: t)
                | Pow_D_C (a, b)             -> push (((!aa * ((primal a) ** (b - (pack_flt 1.))) * b), a) :: t)
                | Pow_C_D (a, b)             -> push (((!aa * (a ** (primal b)) * log a), b) :: t)
                | Atan2_D_D (a, b)           -> let d = (sqr (primal a)) + (sqr (primal b)) in push (((!aa * (primal b) / d), a) :: ((!aa * (neg (primal a)) / d), b) :: t)
                | Atan2_D_C (a, b)           -> push (((!aa * b / ((sqr (primal a)) + (sqr b))), a) :: t)
                | Atan2_C_D (a, b)           -> push (((!aa * (neg a) / ((sqr a) + (sqr (primal b)))), b) :: t)
                | Neg_D a                    -> push ((neg !aa, a) :: t)
                | Abs_D a                    -> push (((!aa * signum (primal a)), a) :: t)
                | Signum_D a                 -> push ((zero a, a) :: t)
                | Floor_D a                  -> push ((zero a, a) :: t)
                | Ceil_D a                   -> push ((zero a, a) :: t)
                | Round_D a                  -> push ((zero a, a) :: t)
                | Sqr_D a                    -> push (((!aa * (primal a) * (pack_flt 2.)), a) :: t)
                | Sqrt_D a                   -> push (((!aa / ((pack_flt 2.) * ap)), a) :: t)
                | Log_D a                    -> push (((!aa / (primal a)), a) :: t)
                | Log2_D a                   -> push (((!aa / ((primal a) * (pack_flt Owl_const.log2e))), a) :: t)
                | Log10_D a                  -> push (((!aa / ((primal a) * (pack_flt Owl_const.log10e))), a) :: t)
                | Exp_D a                    -> push (((!aa * ap), a) :: t)
                | Sin_D a                    -> push (((!aa * cos (primal a)), a) :: t)
                | Cos_D a                    -> push (((!aa * (neg (sin (primal a)))), a) :: t)
                | Tan_D a                    -> push (((!aa / (sqr (cos (primal a)))), a) :: t)
                | Sinh_D a                   -> push (((!aa * (cosh (primal a))), a) :: t)
                | Cosh_D a                   -> push (((!aa * (sinh (primal a))), a) :: t)
                | Tanh_D a                   -> push (((!aa / (sqr (cosh (primal a)))), a) :: t)
                | Asin_D a                   -> push (((!aa / sqrt ((pack_flt 1.) - sqr (primal a))), a) :: t)
                | Acos_D a                   -> push ((((neg !aa) / sqrt ((pack_flt 1.) - sqr (primal a))), a) :: t)
                | Atan_D a                   -> push (((!aa / ((pack_flt 1.) + sqr (primal a))), a) :: t)
                | Asinh_D a                  -> push (((!aa / sqrt ((sqr (primal a)) + (pack_flt 1.))), a) :: t)
                | Acosh_D a                  -> push (((!aa / sqrt ((sqr (primal a)) - (pack_flt 1.))), a) :: t)
                | Atanh_D a                  -> push (((!aa / ((pack_flt 1.) - sqr (primal a))), a) :: t)
                | Get_Item (a, i, j)         -> push ((set_item (zero a) i j (sum' !aa), a) :: t)
                | SetI_D_D (a, i, j, b)      -> push ((set_item !aa i j (pack_flt 0.), a) :: (get_item !aa i j, b) :: t)
                | SetI_D_C (a, i, j, _)      -> push ((set_item !aa i j (pack_flt 0.), a) :: t)
                | SetI_C_D (_, i, j, b)      -> push ((get_item !aa i j, b) :: t)
                | AddI_D_D (a, i, j, b)      -> push ((!aa, a) :: (get_item !aa i j, b) :: t)
                | AddI_D_C (a, _, _, _)      -> push ((!aa, a) :: t)
                | AddI_C_D (_, i, j, b)      -> push ((get_item !aa i j, b) :: t)
                | Get_Slice_D (a, i)         -> push ((set_slice i (zero a) !aa, a) :: t)
                | Set_Slice_D_D (a, b, i)    -> push ((set_slice i !aa (zero b), a) :: (get_slice i !aa, b) :: t)
                | Set_Slice_D_C (a, b, i)    -> push ((set_slice i !aa (zero b), a) :: t)
                | Set_Slice_C_D (_a, b, i)   -> push ((get_slice i !aa, b) :: t)
                | Sum_D a                    -> push ((!aa, a) :: t)
                | Sum__D (a, i)              -> let s = shape a in let reps = Array.(make (length s) 1) in reps.(i) <- s.(i); push ((repeat !aa reps, a) :: t)
                | Sum___D (a, i)             -> let s = shape a in let reps = Array.(make (length s) 1) in Array.iter (fun j -> reps.(j) <- s.(j)) i; push ((repeat !aa reps, a) :: t)
                | Dot_D_D (a, b)             -> push (((dot !aa (transpose (primal b))), a) :: ((dot (transpose (primal a)) !aa), b) :: t)
                | Dot_D_C (a, b)             -> push (((dot !aa (transpose b)), a) :: t)
                | Dot_C_D (a, b)             -> push (((dot (transpose a) !aa), b) :: t)
                | Trans_D a                  -> push (((transpose !aa), a) :: t)
                | L1Norm_D a                 -> push (((!aa * (signum (primal a))), a) :: t)
                | L2Norm_D a                 -> push (((!aa / ap * (primal a)), a) :: t)
                | L2NormS_D a                -> push (((!aa * (pack_flt 2.) * (primal a)), a) :: t)
                | Sigmoid_D a                -> push (((!aa * ap * ((pack_flt 1.) - ap)), a) :: t)
                | Relu_D a                   -> push (((!aa * ((signum (primal a) + (pack_flt 1.)) / (pack_flt 2.))), a) :: t)
                | Inv_D a                    -> let dpt = transpose ap in push ((((neg dpt) * !aa * dpt), a) :: t)
                | QR_D a                     -> push ((qr_backward a !aa ap, a) :: t) 
                | Lyapunov_D_D (a, _)        -> let abar, qbar = lyapunov_backward_aq a !aa ap in push ( (abar, a) :: (qbar, a) :: t) 
                | Lyapunov_D_C (a, _)        -> push (((lyapunov_backward_a a !aa ap), a) :: t)
                | Lyapunov_C_D (a, _)        -> push (((lyapunov_backward_q a !aa), a) :: t)
                | Diag_D (k, a) -> 
                  let m = col_num a in 
                  let l = Pervasives.(m - k) in
                  let rec accu i a_ = 
                    if i < l then accu (succ i) (set_item a_ i Pervasives.(k + i) (get_item !aa 0 i)) 
                    else a_ in
                  let abar = accu 0 (zero a) in 
                  push ((abar, a) :: t)
                | Triu_D (k, a)              -> push ((tril ~k:(pred k) !aa, a) :: t)
                | Tril_D (k, a)              -> push ((triu ~k:(succ k) !aa, a) :: t)
                | Trace_D a                  -> 
                  let m = col_num a in 
                  let rec accu i a_ = 
                    if i < m then accu (succ i) (set_item a_ i i !aa )
                    else a_ in
                  let abar = accu 0 (zero a) in
                  push ((abar,a) :: t)
                | Add_Row_D_D (a, b, i)      -> push ((!aa, a) :: (get_row !aa i, b) :: t)
                | Add_Row_D_C (a, _b, _i)    -> push ((!aa, a) :: t)
                | Add_Row_C_D (_a, b, i)     -> push ((get_row !aa i, b) :: t)
                | Get_Row_D (a, i)           -> (adjref a) := add_row (adjval a) !aa i; push ((zero a, a) :: t)
                | Of_Rows_D a                -> push (t |> List.append (a |> Array.to_list |> List.mapi (fun i v -> (get_row !aa i, v))))
                | Conv1D_D_D (a, b, s)       -> push ((conv1d_backward_input a b s !aa, a) :: (conv1d_backward_kernel a b s !aa, b) :: t)
                | Conv1D_D_C (a, b, s)       -> push ((conv1d_backward_input a b s !aa, a) :: t)
                | Conv1D_C_D (a, b, s)       -> push ((conv1d_backward_kernel a b s !aa, b) :: t)
                | Conv2D_D_D (a, b, s)       -> push ((conv2d_backward_input a b s !aa, a) :: (conv2d_backward_kernel a b s !aa, b) :: t)
                | Conv2D_D_C (a, b, s)       -> push ((conv2d_backward_input a b s !aa, a) :: t)
                | Conv2D_C_D (a, b, s)       -> push ((conv2d_backward_kernel a b s !aa, b) :: t)
                | Conv3D_D_D (a, b, s)       -> push ((conv3d_backward_input a b s !aa, a) :: (conv3d_backward_kernel a b s !aa, b) :: t)
                | Conv3D_D_C (a, b, s)       -> push ((conv3d_backward_input a b s !aa, a) :: t)
                | Conv3D_C_D (a, b, s)       -> push ((conv3d_backward_kernel a b s !aa, b) :: t)
                | Di_Conv1D_D_D (a, b, s, r) -> push ((dilated_conv1d_backward_input a b s r !aa, a) :: (dilated_conv1d_backward_kernel a b s r !aa, b) :: t)
                | Di_Conv1D_D_C (a, b, s, r) -> push ((dilated_conv1d_backward_input a b s r !aa, a) :: t)
                | Di_Conv1D_C_D (a, b, s, r) -> push ((dilated_conv1d_backward_kernel a b s r !aa, b) :: t)
                | Di_Conv2D_D_D (a, b, s, r) -> push ((dilated_conv2d_backward_input a b s r !aa, a) :: (dilated_conv2d_backward_kernel a b s r !aa, b) :: t)
                | Di_Conv2D_D_C (a, b, s, r) -> push ((dilated_conv2d_backward_input a b s r !aa, a) :: t)
                | Di_Conv2D_C_D (a, b, s, r) -> push ((dilated_conv2d_backward_kernel a b s r !aa, b) :: t)
                | Di_Conv3D_D_D (a, b, s, r) -> push ((dilated_conv3d_backward_input a b s r !aa, a) :: (dilated_conv3d_backward_kernel a b s r !aa, b) :: t)
                | Di_Conv3D_D_C (a, b, s, r) -> push ((dilated_conv3d_backward_input a b s r !aa, a) :: t)
                | Di_Conv3D_C_D (a, b, s, r) -> push ((dilated_conv3d_backward_kernel a b s r !aa, b) :: t)
                | Tr_Conv1D_D_D (a, b, s)    -> push ((transpose_conv1d_backward_input a b s !aa, a) :: (transpose_conv1d_backward_kernel a b s !aa, b) :: t)
                | Tr_Conv1D_D_C (a, b, s)    -> push ((transpose_conv1d_backward_input a b s !aa, a) :: t)
                | Tr_Conv1D_C_D (a, b, s)    -> push ((transpose_conv1d_backward_kernel a b s !aa, b) :: t)
                | Tr_Conv2D_D_D (a, b, s)    -> push ((transpose_conv2d_backward_input a b s !aa, a) :: (transpose_conv2d_backward_kernel a b s !aa, b) :: t)
                | Tr_Conv2D_D_C (a, b, s)    -> push ((transpose_conv2d_backward_input a b s !aa, a) :: t)
                | Tr_Conv2D_C_D (a, b, s)    -> push ((transpose_conv2d_backward_kernel a b s !aa, b) :: t)
                | Tr_Conv3D_D_D (a, b, s)    -> push ((transpose_conv3d_backward_input a b s !aa, a) :: (transpose_conv3d_backward_kernel a b s !aa, b) :: t)
                | Tr_Conv3D_D_C (a, b, s)    -> push ((transpose_conv3d_backward_input a b s !aa, a) :: t)
                | Tr_Conv3D_C_D (a, b, s)    -> push ((transpose_conv3d_backward_kernel a b s !aa, b) :: t)
                | Reshape_D a                -> push ((reshape !aa (shape (primal a)), a) :: t)
                | Maxpool1D_D (a, p, d, s)   -> push ((max_pool1d_backward p (primal a) d s !aa, a) :: t)
                | Maxpool2D_D (a, p, d, s)   -> push ((max_pool2d_backward p (primal a) d s !aa, a) :: t)
                | Maxpool3D_D (a, p, d, s)   -> push ((max_pool3d_backward p (primal a) d s !aa, a) :: t)
                | Avgpool1D_D (a, p, d, s)   -> push ((avg_pool1d_backward p (primal a) d s !aa, a) :: t)
                | Avgpool2D_D (a, p, d, s)   -> push ((avg_pool2d_backward p (primal a) d s !aa, a) :: t)
                | Avgpool3D_D (a, p, d, s)   -> push ((avg_pool3d_backward p (primal a) d s !aa, a) :: t)
                | UpSampling2D_D (a, s)      -> push ((upsampling2d_backward (primal a) s !aa, a) :: t)
                | PAD_D (a, p)               -> push ((pad_backward !aa p, a) :: t)
                | Concat_D_D (a, b, i)       -> let s = split i [|(shape a).(i); (shape b).(i)|] !aa in push ((s.(0) ,a) :: (s.(1) ,b) :: t)
                | Concat_D_C (a, b, i)       -> let s = split i [|(shape a).(i); (shape b).(i)|] !aa in push ((s.(0) ,a) :: t)
                | Concat_C_D (a, b, i)       -> let s = split i [|(shape a).(i); (shape b).(i)|] !aa in push ((s.(1) ,b) :: t)
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
    let x = make_forward x (pack_flt 1.) (tag ()) in
    let y = f x in
    primal y, tangent y

  (* derivative of f (scalar -> scalar) at x, forward ad *)
  let diff f x = diff' f x |> snd

  (* gradient of f (vector -> scalar) at x, reverse ad *)
  let grad' f x =
    let x = make_reverse x (tag ()) in
    let y = f x in
    reverse_reset y;
    reverse_push (pack_flt 1.) y;
    primal y, x |> adjval

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
    primal y, x |> adjval |> primal

  (* transposed jacobian vector product of f (vector -> vector) at x along v, backward ad *)
  let jacobianTv f x v = jacobianTv' f x v |> snd

  (* jacobian of f (vector -> vector) at x, both x and y are row vectors, also return the original value *)
  let jacobian' f x =
    let y = f x |> primal in
    let m = col_num y in
    let n = col_num x in
    let z = A.empty [|m;n|] in
    (
      match m > n with
      | true  ->  (
          Array.init n (fun i ->
              let v = A.zeros [|1;n|] in
              A.(set v [|0;i|] (float_to_elt 1.));
              jacobianv f x (Arr v)
            )
          |> Array.iteri (fun i v ->
              match v with
              | Arr v -> A.copy_col_to (A.transpose v) z i
              | _     -> failwith "error: jacobian"
            );
        )
      | false -> (
          Array.init m (fun i ->
              let v = A.zeros [|1;m|] in
              A.(set v [|0;i|] (float_to_elt 1.));
              jacobianTv f x (Arr v)
            )
          |> Array.iteri (fun i v ->
              match v with
              | Arr v -> A.copy_row_to v z i
              | _     -> failwith "error: jacobian"
            );
        );
    );
    (y, Arr z)


  (* jacobian of f *)
  let jacobian f x = jacobian' f x |> snd

  (* gradient, hessian of f (vector -> scalar) at [x] *)
  let gradhessian f x = jacobian' (grad f) x

  (* original value, gradient, and hessian *)
  let gradhessian' f x =
    let g, h = gradhessian f x in
    f x, g, h

  (* hessian of f *)
  let hessian f x = (f |> grad |> jacobian) x

  (* original value and hessian of f *)
  let hessian' f x = f x, hessian f x

  (* original value, gradient-vector product, hessian-vector product *)
  let gradhessianv' f x v =
    let gv, hv = grad' (fun y -> jacobianv f y v) x in
    f x, gv, hv

  (* gradient-vector product and hessian-vector product *)
  let gradhessianv f x v =
    let _, gv, hv = gradhessianv' f x v in
    gv, hv

  (* original value and hessian-vector product *)
  let hessianv' f x v =
    let fv, _, hv = gradhessianv' f x v in
    fv, hv

  (* hessian-vector *)
  let hessianv f x v =
    let _, _, hv = gradhessianv' f x v in
    hv

  (* laplacian of f *)
  let laplacian f x = F (hessian f x |> unpack_arr |> A.trace)

  let laplacian' f x = f x, laplacian f x


  (* Wrapper for the Mat module *)

  module Mat = struct

    let empty m n = A.empty [|m;n|] |> pack_arr

    let zeros m n = A.zeros [|m;n|] |> pack_arr

    let ones m n = A.ones [|m;n|] |> pack_arr

    let uniform ?a ?b m n = A.uniform ?a ?b [|m;n|] |> pack_arr

    let gaussian ?mu ?sigma m n = A.gaussian ?mu ?sigma [|m;n|] |> pack_arr

    let reset x = x |> unpack_arr |> A.reset

    let reshape m n x = Maths.reshape x [|m;n|]

    let shape x = let s = A.shape (unpack_arr x) in s.(0), s.(1)

    let row_num x = (unpack_arr x |> A.shape).(0)

    let col_num x = (unpack_arr x |> A.shape).(1)

    let numel x = numel x

    let row x i = Maths.get_row x i

    let get x i j = Maths.get_item x i j

    let set x i j a = Maths.set_item x i j a

    (* unary math operators *)

    let mean x = Maths.mean x

    (* binary math operators *)

    let add x y = Maths.add x y

    let sub x y = Maths.sub x y

    let mul x y = Maths.mul x y

    let div x y = Maths.div x y

    let dot x y = Maths.dot x y

    let map_by_row f x = x |> Maths.to_rows |> Array.map f |> Maths.of_rows

    let print x = A.print (unpack_arr x)

    let of_arrays x = A.of_arrays x |> pack_arr

  end


  (* Wrapper for the Arr module *)

  module Arr = struct

    let empty d = A.empty d |> pack_arr

    let zeros d = A.zeros d |> pack_arr

    let ones d = A.ones d |> pack_arr

    let uniform ?a ?b d = A.uniform ?a ?b d |> pack_arr

    let gaussian ?mu ?sigma d = A.gaussian ?mu ?sigma d |> pack_arr

    let reset x = x |> unpack_arr |> A.reset

    let reshape x s = Maths.reshape x s

    let shape x = A.shape (unpack_arr x)

    let numel x = numel x

    (* binary math operators *)

    let add x y = Maths.add x y

    let sub x y = Maths.sub x y

    let mul x y = Maths.mul x y

    let div x y = Maths.div x y

    let dot x y = Maths.dot x y

  end


  (* _traverse_trace and its related functions are used to convert the
     computation graph generated in backward mode into human-readable format.
     You can make your own convert function to generate needed format.
  *)
  let _traverse_trace x =
    (* init variables for tracking nodes and indices *)
    let nodes = Hashtbl.create 512 in
    let index = ref 0 in
    (* local function to traverse the nodes *)
    let rec push tlist =
      match tlist with
      | []       -> ()
      | hd :: tl ->
        if Hashtbl.mem nodes hd = false then (
          let op, prev =
            match hd with
            | DR (_ap, _aa, ao, _af, _ai) -> (
                match ao with
                | Noop                         -> "Noop", []
                | Add_D_D (a, b)               -> "Add_D_D", [a; b]
                | Add_D_C (a, b)               -> "Add_D_C", [a; b]
                | Add_C_D (a, b)               -> "Add_C_D", [a; b]
                | Sub_D_D (a, b)               -> "Sub_D_D", [a; b]
                | Sub_D_C (a, b)               -> "Sub_D_C", [a; b]
                | Sub_C_D (a, b)               -> "Sub_C_D", [a; b]
                | Mul_D_D (a, b)               -> "Mul_D_D", [a; b]
                | Mul_D_C (a, b)               -> "Mul_D_C", [a; b]
                | Mul_C_D (a, b)               -> "Mul_C_D", [a; b]
                | Div_D_D (a, b)               -> "Div_D_D", [a; b]
                | Div_D_C (a, b)               -> "Div_D_C", [a; b]
                | Div_C_D (a, b)               -> "Div_C_D", [a; b]
                | Pow_D_D (a, b)               -> "Pow_D_D", [a; b]
                | Pow_D_C (a, b)               -> "Pow_D_C", [a; b]
                | Pow_C_D (a, b)               -> "Pow_C_D", [a; b]
                | Atan2_D_D (a, b)             -> "Atan2_D_D", [a; b]
                | Atan2_D_C (a, b)             -> "Atan2_D_C", [a; b]
                | Atan2_C_D (a, b)             -> "Atan2_C_D", [a; b]
                | Neg_D a                      -> "Neg_D", [ a ]
                | Abs_D a                      -> "Abs_D", [ a ]
                | Signum_D a                   -> "Signum_D", [ a ]
                | Floor_D a                    -> "Floor_D", [ a ]
                | Ceil_D a                     -> "Ceil_D", [ a ]
                | Round_D a                    -> "Round_D", [ a ]
                | Sqr_D a                      -> "Sqr_D", [ a ]
                | Sqrt_D a                     -> "Sqrt_D", [ a ]
                | Log_D a                      -> "Log_D", [ a ]
                | Log2_D a                     -> "Log2_D", [ a ]
                | Log10_D a                    -> "Log10_D", [ a ]
                | Exp_D a                      -> "Exp_D", [ a ]
                | Sin_D a                      -> "Sin_D", [ a ]
                | Cos_D a                      -> "Cos_D", [ a ]
                | Tan_D a                      -> "Tan_D", [ a ]
                | Sinh_D a                     -> "Sinh_D", [ a ]
                | Cosh_D a                     -> "Cosh_D", [ a ]
                | Tanh_D a                     -> "Tanh_D", [ a ]
                | Asin_D a                     -> "Asin_D", [ a ]
                | Acos_D a                     -> "Acos_D", [ a ]
                | Atan_D a                     -> "Atan_D", [ a ]
                | Asinh_D a                    -> "Asinh_D", [ a ]
                | Acosh_D a                    -> "Acosh_D", [ a ]
                | Atanh_D a                    -> "Atanh_D", [ a ]
                | Get_Item (a, _i, _j)         -> "Get_Item", [ a ]
                | SetI_D_D (a, _i, _j, b)      -> "SetI_D_D", [a; b]
                | SetI_D_C (a, _i, _j, b)      -> "SetI_D_C", [a; b]
                | SetI_C_D (a, _i, _j, b)      -> "SetI_C_D", [a; b]
                | AddI_D_D (a, _i, _j, b)      -> "AddI_D_D", [a; b]
                | AddI_D_C (a, _i, _j, b)      -> "AddI_D_C", [a; b]
                | AddI_C_D (a, _i, _j, b)      -> "AddI_C_D", [a; b]
                | Get_Slice_D (a, _i)          -> "Get_Slice_D", [ a ]
                | Set_Slice_D_D (a, b, _i)     -> "Set_Slice_D_D", [a; b]
                | Set_Slice_D_C (a, b, _i)     -> "Set_Slice_D_C", [a; b]
                | Set_Slice_C_D (a, b, _i)     -> "Set_Slice_C_D", [a; b]
                | Sum_D a                      -> "Sum_D", [ a ]
                | Sum__D (a, _i)               -> "Sum__D", [ a ]
                | Sum___D (a, _i)              -> "Sum___D", [ a ]
                | Dot_D_D (a, b)               -> "Dot_D_D", [a; b]
                | Dot_D_C (a, b)               -> "Dot_D_C", [a; b]
                | Dot_C_D (a, b)               -> "Dot_C_D", [a; b]
                | Trans_D a                    -> "Trans_D", [ a ]
                | L1Norm_D a                   -> "L1Norm_D", [ a ]
                | L2Norm_D a                   -> "L2Norm_D", [ a ]
                | L2NormS_D a                  -> "L2NormS_D", [ a ]
                | Sigmoid_D a                  -> "Sigmoid_D", [ a ]
                | Relu_D a                     -> "Relu_D", [ a ]
                | Inv_D a                      -> "Inv_D", [ a ]
                | QR_D a                       -> "QR_D", [ a ]
                | Lyapunov_D_D (a, q)          -> "Lyapunov_D_D", [ a; q ]
                | Lyapunov_C_D (a, q)          -> "Lyapunov_C_D", [ a; q ]
                | Lyapunov_D_C (a, q)          -> "Lyapunov_D_C", [ a; q ]
                | Diag_D (_, a)                -> "Diag_D", [ a ] 
                | Tril_D (_, a)                -> "Tril_D", [ a ] 
                | Triu_D (_, a)                -> "Triu_D", [ a ] 
                | Trace_D a                    -> "Trace_D", [ a ] 
                | Add_Row_D_D (a, b, _i)       -> "Add_Row_D_D", [a; b]
                | Add_Row_D_C (a, b, _i)       -> "Add_Row_D_C", [a; b]
                | Add_Row_C_D (a, b, _i)       -> "Add_Row_C_D", [a; b]
                | Get_Row_D (a, _i)            -> "Get_Row_D", [ a ]
                | Of_Rows_D a                  -> "Of_Rows_D", (Array.to_list a)
                | Conv1D_D_D (a, b, _s)        -> "Conv1D_D_D", [a; b]
                | Conv1D_D_C (a, b, _s)        -> "Conv1D_D_C", [a; b]
                | Conv1D_C_D (a, b, _s)        -> "Conv1D_C_D", [a; b]
                | Conv2D_D_D (a, b, _s)        -> "Conv2D_D_D", [a; b]
                | Conv2D_D_C (a, b, _s)        -> "Conv2D_D_C", [a; b]
                | Conv2D_C_D (a, b, _s)        -> "Conv2D_C_D", [a; b]
                | Conv3D_D_D (a, b, _s)        -> "Conv3D_D_D", [a; b]
                | Conv3D_D_C (a, b, _s)        -> "Conv3D_D_C", [a; b]
                | Conv3D_C_D (a, b, _s)        -> "Conv3D_C_D", [a; b]
                | Di_Conv1D_D_D (a, b, _s, _r) -> "Di_Conv1D_D_D", [a; b]
                | Di_Conv1D_D_C (a, b, _s, _r) -> "Di_Conv1D_D_C", [a; b]
                | Di_Conv1D_C_D (a, b, _s, _r) -> "Di_Conv1D_C_D", [a; b]
                | Di_Conv2D_D_D (a, b, _s, _r) -> "Di_Conv2D_D_D", [a; b]
                | Di_Conv2D_D_C (a, b, _s, _r) -> "Di_Conv2D_D_C", [a; b]
                | Di_Conv2D_C_D (a, b, _s, _r) -> "Di_Conv2D_C_D", [a; b]
                | Di_Conv3D_D_D (a, b, _s, _r) -> "Di_Conv3D_D_D", [a; b]
                | Di_Conv3D_D_C (a, b, _s, _r) -> "Di_Conv3D_D_C", [a; b]
                | Di_Conv3D_C_D (a, b, _s, _r) -> "Di_Conv3D_C_D", [a; b]
                | Tr_Conv1D_D_D (a, b, _s)     -> "Tr_Conv1D_D_D", [a; b]
                | Tr_Conv1D_D_C (a, b, _s)     -> "Tr_Conv1D_D_C", [a; b]
                | Tr_Conv1D_C_D (a, b, _s)     -> "Tr_Conv1D_C_D", [a; b]
                | Tr_Conv2D_D_D (a, b, _s)     -> "Tr_Conv2D_D_D", [a; b]
                | Tr_Conv2D_D_C (a, b, _s)     -> "Tr_Conv2D_D_C", [a; b]
                | Tr_Conv2D_C_D (a, b, _s)     -> "Tr_Conv2D_C_D", [a; b]
                | Tr_Conv3D_D_D (a, b, _s)     -> "Tr_Conv3D_D_D", [a; b]
                | Tr_Conv3D_D_C (a, b, _s)     -> "Tr_Conv3D_D_C", [a; b]
                | Tr_Conv3D_C_D (a, b, _s)     -> "Tr_Conv3D_C_D", [a; b]
                | Reshape_D a                  -> "Reshape_D", [ a ]
                | Maxpool1D_D (a, _p, _d, _s)  -> "Maxpool1D_D", [ a ]
                | Maxpool2D_D (a, _p, _d, _s)  -> "Maxpool2D_D", [ a ]
                | Maxpool3D_D (a, _p, _d, _s)  -> "Maxpool3D_D", [ a ]
                | Avgpool1D_D (a, _p, _d, _s)  -> "Avgpool1D_D", [ a ]
                | Avgpool2D_D (a, _p, _d, _s)  -> "Avgpool2D_D", [ a ]
                | Avgpool3D_D (a, _p, _d, _s)  -> "Avgpool3D_D", [ a ]
                | UpSampling2D_D (a, _s)       -> "UpSampling2D_D", [ a ]
                | PAD_D (a, _p)                -> "PAD_D", [ a ]
                | Concat_D_D (a, b, _i)        -> "Concat_D_D", [a; b]
                | Concat_D_C (a, b, _i)        -> "Concat_D_C", [a; b]
                | Concat_C_D (a, b, _i)        -> "Concat_C_D", [a; b]
              )
            | F _a                     -> Printf.sprintf "Const", []
            | Arr _a                   -> Printf.sprintf "Const", []
            | Pair (_,_)                   -> Printf.sprintf "Const", []
            | DF (_, _, _)            -> Printf.sprintf "DF", []
          in
          (* check if the node has been visited before *)
          Hashtbl.add nodes hd (!index, op, prev);
          index := !index + 1;
          push (prev @ tl);
        )
        else push tl
    in
    (* iterate the graph then return the hash table *)
    push x; nodes


  (* convert graph to terminal output *)
  let _convert_terminal_output nodes =
    Hashtbl.fold (fun v (v_id, v_op, v_prev) s0 ->
        let v_ts = type_info v in
        s0 ^ List.fold_left (fun s1 u ->
            let u_id, u_op, _ = Hashtbl.find nodes u in
            let u_ts = type_info u in
            s1 ^ Printf.sprintf "{ i:%i o:%s t:%s } -> { i:%i o:%s t:%s }\n"
              u_id u_op u_ts v_id v_op v_ts
          ) "" v_prev
      ) nodes ""


  (* convert graph to dot file output *)
  let _convert_dot_output nodes =
    let network = Hashtbl.fold (fun _v (v_id, _v_op, v_prev) s0 ->
        s0 ^ List.fold_left (fun s1 u ->
            let u_id, _u_op, _ = Hashtbl.find nodes u in
            s1 ^ Printf.sprintf "\t%i -> %i;\n" u_id v_id
          ) "" v_prev
      ) nodes ""
    in
    let attrs = Hashtbl.fold (fun v (v_id, v_op, _v_prev) s0 ->
        if v_op = "Const" then
          s0 ^ Printf.sprintf "%i [ label=\"#%i | { %s | %s }\" fillcolor=gray, style=filled ];\n"
            v_id v_id v_op (deep_info v)
        else
          s0 ^ Printf.sprintf "%i [ label=\"#%i | { %s | %s }\" ];\n"
            v_id v_id v_op (deep_info v)
      ) nodes ""
    in
    network ^ attrs


  let to_trace nodes = _traverse_trace nodes |> _convert_terminal_output


  let to_dot nodes =
    _traverse_trace nodes
    |> _convert_dot_output
    |> Printf.sprintf "digraph CG {\nnode [shape=record];\n%s}"


  let pp_num formatter x = Format.fprintf formatter "%s" (type_info x)


end



(* ends here *)
