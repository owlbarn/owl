(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

module S = Pervasives


(* Functor of making AD module of different precisions *)

module Make
  (M : MatrixSig)
  (A : NdarraySig with type elt = M.elt and type arr = M.arr)
  = struct

  (* type definitions *)

  type arr = A.arr
  type mat = M.mat
  type elt = M.elt

  type t =
    | F   of float
    | Arr of arr
    | Mat of mat
    | DF  of t * t * int                            (* primal, tangent, tag *)
    | DR  of t * t ref * trace_op * int ref * int   (* primal, adjoint, op, fanout, tag *)
  and trace_op =
    | Noop
    | Add_D_D       of t * t
    | Add_D_C       of t * t
    | Add_C_D       of t * t
    | Sub_D_D       of t * t
    | Sub_D_C       of t * t
    | Sub_C_D       of t * t
    | Mul_D_D       of t * t
    | Mul_D_C       of t * t
    | Mul_C_D       of t * t
    | Div_D_D       of t * t
    | Div_D_C       of t * t
    | Div_C_D       of t * t
    | Pow_D_D       of t * t
    | Pow_D_C       of t * t
    | Pow_C_D       of t * t
    | Atan2_D_D     of t * t
    | Atan2_D_C     of t * t
    | Atan2_C_D     of t * t
    | Neg_D         of t
    | Abs_D         of t
    | Signum_D      of t
    | Floor_D       of t
    | Ceil_D        of t
    | Round_D       of t
    | Sqr_D         of t
    | Sqrt_D        of t
    | Log_D         of t
    | Log2_D        of t
    | Log10_D       of t
    | Exp_D         of t
    | Sin_D         of t
    | Cos_D         of t
    | Tan_D         of t
    | Sinh_D        of t
    | Cosh_D        of t
    | Tanh_D        of t
    | Asin_D        of t
    | Acos_D        of t
    | Atan_D        of t
    | Asinh_D       of t
    | Acosh_D       of t
    | Atanh_D       of t
    | Get_Item      of t * int * int
    | SetI_D_D      of t * int * int * t
    | SetI_D_C      of t * int * int * t
    | SetI_C_D      of t * int * int * t
    | AddI_D_D      of t * int * int * t
    | AddI_D_C      of t * int * int * t
    | AddI_C_D      of t * int * int * t
    | Get_Slice_D   of t * index list
    | Set_Slice_D_D of t * t * index list
    | Set_Slice_D_C of t * t * index list
    | Set_Slice_C_D of t * t * index list
    | Sum_D         of t
    | Sum__D        of t * int
    | Dot_D_D       of t * t
    | Dot_D_C       of t * t
    | Dot_C_D       of t * t
    | Trans_D       of t
    | L1Norm_D      of t
    | L2Norm_D      of t
    | L2NormS_D     of t
    | Sigmoid_D     of t
    | Relu_D        of t
    | Inv_D         of t
    | Add_Row_D_D   of t * t * int
    | Add_Row_D_C   of t * t * int
    | Add_Row_C_D   of t * t * int
    | Get_Row_D     of t * int
    | Of_Rows_D     of t array
    | Concat_D_D    of t * t * int
    | Concat_D_C    of t * t * int
    | Concat_C_D    of t * t * int
    | Conv1D_D_D    of t * t * int array
    | Conv1D_D_C    of t * t * int array
    | Conv1D_C_D    of t * t * int array
    | Conv2D_D_D    of t * t * int array
    | Conv2D_D_C    of t * t * int array
    | Conv2D_C_D    of t * t * int array
    | Conv3D_D_D    of t * t * int array
    | Conv3D_D_C    of t * t * int array
    | Conv3D_C_D    of t * t * int array
    | Reshape_D     of t
    | Mat2Arr_D     of t
    | Arr2Mat_D     of t
    | Maxpool1D_D   of t * padding * int array * int array
    | Maxpool2D_D   of t * padding * int array * int array
    | Avgpool1D_D   of t * padding * int array * int array
    | Avgpool2D_D   of t * padding * int array * int array


  (* generate global tags *)
  let _global_tag = ref 0
  let tag () = _global_tag := !_global_tag + 1; !_global_tag


  (* hepler functions of the core AD component *)

  let cmp_tag ai bi =
    if ai > bi then 1
    else if ai < bi then -1
    else 0

  let rec reset_zero = function
    | F _    -> F 0.
    | Arr ap -> A.reset ap; Arr ap
    | Mat ap -> M.reset ap; Mat ap
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
    | F _                     -> F 0.
    | Arr ap                  -> Arr A.(zeros (shape ap))
    | Mat ap                  -> Mat M.(zeros (row_num ap) (col_num ap))
    | DF (ap, at, ai)         -> ap |> primal' |> zero
    | DR (ap, at, ao, af, ai) -> ap |> primal' |> zero

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
    | Mat ap -> [|M.row_num ap; M.col_num ap|]
    | _      -> failwith "error: AD.shape"

  let mat_shape x =
    match (primal' x) with
    | Mat ap    -> M.shape ap
    | _         -> failwith "error: AD.mat_shape"

  let row_num x = x |> mat_shape |> fst

  let col_num x = x |> mat_shape |> snd

  let numel x =
    match primal' x with
    | Arr x -> A.numel x
    | Mat x -> M.numel x
    | _     -> failwith "error: AD.numel"

  let mat_create m n a =
    match primal a with
    | F a  -> Mat (M.create m n a)
    | _ -> failwith "error: AD.mat_create"

  let clip_by_l2norm a x =
    match primal' x with
    | Arr x -> Arr A.(clip_by_l2norm a x)
    | Mat x -> Mat M.(clip_by_l2norm a x)
    | _     -> failwith "error: AD.clip_by_l2norm"

  let tile x reps =
    match primal' x with
    | Arr x -> Arr A.(tile x reps)
    | Mat x -> Mat M.(tile x reps)
    | _     -> failwith "error: AD.tile"

  let repeat ?axis x reps =
    match primal' x with
    | Arr x -> Arr A.(repeat ?axis x reps)
    | Mat x -> Mat M.(repeat ?axis x reps)
    | _     -> failwith "error: AD.repeat"

  (* packing and unpacking functions *)

  let pack_arr x = Arr x

  let unpack_arr x =
    match (primal x) with
    | Arr x -> x
    | _     -> failwith "error: AD.unpack_arr"

  let pack_mat x = Mat x

  let unpack_mat x =
    match (primal x) with
    | Mat x -> x
    | _     -> failwith "error: AD.unpack_mat"

  let pack_flt x = F x

  let unpack_flt x =
    match (primal x) with
    | F x -> x
    | _   -> failwith "error: AD.unpack_elt"


  (* functions to report errors, help in debugging *)

  let type_info x =
    let idx2str idx = Array.(map string_of_int idx |> to_list) |> String.concat ","
    in
    let deep_info x = match primal' x with
      | F a   -> Printf.sprintf "(F %g)" a
      | Arr a -> Printf.sprintf "Arr(%s)" (A.shape a |> idx2str)
      | Mat a -> Printf.sprintf "Mat(%i,%i)" (M.row_num a) (M.col_num a)
      | _     -> "you should not have reached here!"
    in
    match x with
    | DF (ap, at, ai)         -> Printf.sprintf "[DF tag:%i ap:%s]" ai (deep_info ap)
    | DR (ap, at, ao, af, ai) -> Printf.sprintf "[DR tag:%i ap:%s]" ai (deep_info ap)
    | _                       -> Printf.sprintf "[%s]" (deep_info x)

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
      | F ap, DF (bp, bt, bi)                      -> let cp = fd a bp in DF (cp, (df_db cp bp bt), bi)
      | DF (ap, at, ai), F bp                      -> let cp = fd ap b in DF (cp, (df_da cp ap at), ai)
      | Arr ap, DF (bp, bt, bi)                    -> let cp = fd a bp in DF (cp, (df_db cp bp bt), bi)
      | DF (ap, at, ai), Arr bp                    -> let cp = fd ap b in DF (cp, (df_da cp ap at), ai)
      | Mat ap, DF (bp, bt, bi)                    -> let cp = fd a bp in DF (cp, (df_db cp bp bt), bi)
      | DF (ap, at, ai), Mat bp                    -> let cp = fd ap b in DF (cp, (df_da cp ap at), ai)
      | F ap, DR (bp, _, _, _, bi)                 -> let cp = fd a bp in DR (cp, ref (zero cp), r_c_d a b, ref 0, bi)
      | DR (ap, _, _, _, ai), F bp                 -> let cp = fd ap b in DR (cp, ref (zero cp), r_d_c a b, ref 0, ai)
      | Arr ap, DR (bp, _, _, _, bi)               -> let cp = fd a bp in DR (cp, ref (zero cp), r_c_d a b, ref 0, bi)
      | DR (ap, _, _, _, ai), Arr bp               -> let cp = fd ap b in DR (cp, ref (zero cp), r_d_c a b, ref 0, ai)
      | Mat ap, DR (bp, _, _, _, bi)               -> let cp = fd a bp in DR (cp, ref (zero cp), r_c_d a b, ref 0, bi)
      | DR (ap, _, _, _, ai), Mat bp               -> let cp = fd ap b in DR (cp, ref (zero cp), r_d_c a b, ref 0, ai)
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

    and ( + ) a b = add a b
    and add a b =
      let ff a b =
        match a, b with
        | F a, F b     -> F S.(a +. b)
        | F a, Arr b   -> Arr A.(scalar_add a b)
        | Arr a, F b   -> Arr A.(add_scalar a b)
        | Arr a, Arr b -> Arr A.(add a b)
        | F a, Mat b   -> Mat M.(scalar_add a b)
        | Mat a, F b   -> Mat M.(add_scalar a b)
        | Mat a, Mat b -> Mat M.(add a b)
        | _            -> error_binop "( + )" a b
      in
      let fd a b = a + b in
      let df_da cp ap at = at in
      let df_db cp bp bt = bt in
      let df_dab cp ap at bp bt = at + bt in
      let r_d_d a b = Add_D_D (a, b) in
      let r_d_c a b = Add_D_C (a, b) in
      let r_c_d a b = Add_C_D (a, b) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and ( - ) a b = sub a b
    and sub a b =
      let ff a b =
        match a, b with
        | F a, F b     -> F S.(a -. b)
        | F a, Arr b   -> Arr A.(scalar_sub a b)
        | Arr a, F b   -> Arr A.(sub_scalar a b)
        | Arr a, Arr b -> Arr A.(sub a b)
        | F a, Mat b   -> Mat M.(scalar_sub a b)
        | Mat a, F b   -> Mat M.(sub_scalar a b)
        | Mat a, Mat b -> Mat M.(sub a b)
        | _            -> error_binop "( - )" a b
      in
      let fd a b = a - b in
      let df_da cp ap at = at in
      let df_db cp bp bt = neg bt in
      let df_dab cp ap at bp bt = at - bt in
      let r_d_d a b = Sub_D_D (a, b) in
      let r_d_c a b = Sub_D_C (a, b) in
      let r_c_d a b = Sub_C_D (a, b) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and ( * ) a b = mul a b
    and mul a b =
      let ff a b =
        match a, b with
        | F a, F b     -> F S.(a *. b)
        | F a, Arr b   -> Arr A.(scalar_mul a b)
        | Arr a, F b   -> Arr A.(mul_scalar a b)
        | Arr a, Arr b -> Arr A.(mul a b)
        | F a, Mat b   -> Mat M.(scalar_mul a b)
        | Mat a, F b   -> Mat M.(mul_scalar a b)
        | Mat a, Mat b -> Mat M.(mul a b)
        | _            -> error_binop "( * )" a b
      in
      let fd a b = a * b in
      let df_da cp ap at = at * b in
      let df_db cp bp bt = a * bt in
      let df_dab cp ap at bp bt = (ap * bt) + (at * bp) in
      let r_d_d a b = Mul_D_D (a, b) in
      let r_d_c a b = Mul_D_C (a, b) in
      let r_c_d a b = Mul_C_D (a, b) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and ( / ) a b = div a b
    and div a b =
      let ff a b =
        match a, b with
        | F a, F b     -> F S.(a /. b)
        | F a, Arr b   -> Arr A.(scalar_div a b)
        | Arr a, F b   -> Arr A.(div_scalar a b)
        | Arr a, Arr b -> Arr A.(div a b)
        | F a, Mat b   -> Mat M.(scalar_div a b)
        | Mat a, F b   -> Mat M.(div_scalar a b)
        | Mat a, Mat b -> Mat M.(div a b)
        | _            -> error_binop "( / )" a b
      in
      let fd a b = a / b in
      let df_da cp ap at = at / b in
      let df_db cp bp bt = (neg bt) * cp / bp in
      let df_dab cp ap at bp bt = (at - bt * cp) / bp in
      let r_d_d a b = Div_D_D (a, b) in
      let r_d_c a b = Div_D_C (a, b) in
      let r_c_d a b = Div_C_D (a, b) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and ( ** ) a b = pow a b
    and pow a b =
      let ff a b =
        match a, b with
        | F a, F b     -> F S.(a ** b)
        | F a, Arr b   -> Arr A.(scalar_pow a b)
        | Arr a, F b   -> Arr A.(pow_scalar a b)
        | Arr a, Arr b -> Arr A.(pow a b)
        | F a, Mat b   -> Mat M.(scalar_pow a b)
        | Mat a, F b   -> Mat M.(pow_scalar a b)
        | Mat a, Mat b -> Mat M.(pow a b)
        | _            -> error_binop "( ** )" a b
      in
      let fd a b = a ** b in
      let df_da cp ap at = at * (ap ** (b - (F 1.))) * b in
      let df_db cp bp bt = bt * cp * (log a) in
      let df_dab cp ap at bp bt = (ap ** (bp - (F 1.))) * ((at * bp) + (ap * bt * log ap)) in
      let r_d_d a b = Pow_D_D (a, b) in
      let r_d_c a b = Pow_D_C (a, b) in
      let r_c_d a b = Pow_C_D (a, b) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and atan2 a b =
      let ff a b =
        match a, b with
        | F a, F b     -> F S.(atan2 a b)
        | F a, Arr b   -> Arr A.(scalar_atan2 a b)
        | Arr a, F b   -> Arr A.(atan2_scalar a b)
        | Arr a, Arr b -> Arr A.(atan2 a b)
        | F a, Mat b   -> Mat M.(scalar_atan2 a b)
        | Mat a, F b   -> Mat M.(atan2_scalar a b)
        | Mat a, Mat b -> Mat M.(atan2 a b)
        | _            -> error_binop "atan2" a b
      in
      let fd a b = atan2 a b in
      let df_da cp ap at = at * b / ((sqr ap) + (sqr b)) in
      let df_db cp bp bt = (neg bt) * a / ((sqr a) + (sqr bp)) in
      let df_dab cp ap at bp bt = ((at * bp) - (bt * ap)) / ((sqr ap) + (sqr bp)) in
      let r_d_d a b = Atan2_D_D (a, b) in
      let r_d_c a b = Atan2_D_C (a, b) in
      let r_c_d a b = Atan2_C_D (a, b) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and min2 a b = ((a + b) - abs (a - b)) / F 2.

    and max2 a b = ((a + b) + abs (b - a)) / F 2.

    and neg a =
      let ff = function
        | F a      -> F S.(0. -. a)
        | Arr a    -> Arr A.(neg a)
        | Mat a    -> Mat M.(neg a)
        | _        -> error_uniop "neg" a
      in
      let fd a = neg a in
      let df cp ap at = (F 0.) - at in
      let r a = Neg_D a in
      op_d_d a ff fd df r

    and abs a =
      let ff = function
        | F a      -> F Owl_maths.(abs a)
        | Arr a    -> Arr A.(abs a)
        | Mat a    -> Mat M.(abs a)
        | _        -> error_uniop "abs" a
      in
      let fd a = abs a in
      let df cp ap at = at * (signum ap) in
      let r a = Abs_D a in
      op_d_d a ff fd df r

    and signum a =
      let ff = function
        | F a      -> F Owl_maths.(signum a)
        | Arr a    -> Arr A.(signum a)
        | Mat a    -> Mat M.(signum a)
        | _        -> error_uniop "signum" a
      in
      let fd a = signum a in
      let df cp ap at = zero ap in
      let r a = Signum_D a in
      op_d_d a ff fd df r

    and floor a =
      let ff = function
        | F a      -> F Owl_maths.(floor a)
        | Arr a    -> Arr A.(floor a)
        | Mat a    -> Mat M.(floor a)
        | _        -> error_uniop "floor" a
      in
      let fd a = floor a in
      let df cp ap at = zero ap in
      let r a = Floor_D a in
      op_d_d a ff fd df r

    and ceil a =
      let ff = function
        | F a      -> F Owl_maths.(ceil a)
        | Arr a    -> Arr A.(ceil a)
        | Mat a    -> Mat M.(ceil a)
        | _        -> error_uniop "ceil" a
      in
      let fd a = ceil a in
      let df cp ap at = zero ap in
      let r a = Ceil_D a in
      op_d_d a ff fd df r

    and round a =
      let ff = function
        | F a      -> F Owl_maths.(round a)
        | Arr a    -> Arr A.(round a)
        | Mat a    -> Mat M.(round a)
        | _        -> error_uniop "round" a
      in
      let fd a = round a in
      let df cp ap at = zero ap in
      let r a = Round_D a in
      op_d_d a ff fd df r

    and sqr a =
      let ff = function
        | F a      -> F S.(a *. a)
        | Arr a    -> Arr A.(sqr a)
        | Mat a    -> Mat M.(sqr a)
        | _        -> error_uniop "sqr" a
      in
      let fd a = sqr a in
      let df cp ap at = (F 2.) * at * ap in
      let r a = Sqr_D a in
      op_d_d a ff fd df r

    and sqrt a =
      let ff = function
        | F a      -> F S.(sqrt a)
        | Arr a    -> Arr A.(sqrt a)
        | Mat a    -> Mat M.(sqrt a)
        | _        -> error_uniop "sqrt" a
      in
      let fd a = sqrt a in
      let df cp ap at = at / ((F 2.) * cp) in
      let r a = Sqrt_D a in
      op_d_d a ff fd df r

    and log a =
      let ff = function
        | F a      -> F S.(log a)
        | Arr a    -> Arr A.(log a)
        | Mat a    -> Mat M.(log a)
        | _        -> error_uniop "log" a
      in
      let fd a = log a in
      let df cp ap at = at / ap in
      let r a = Log_D a in
      op_d_d a ff fd df r

    and log2 a =
      let ff = function
        | F a      -> F Owl_maths.(log2 a)
        | Arr a    -> Arr A.(log2 a)
        | Mat a    -> Mat M.(log2 a)
        | _        -> error_uniop "log2" a
      in
      let fd a = log2 a in
      let df cp ap at = at / (ap * (F Owl_maths.log2e)) in
      let r a = Log2_D a in
      op_d_d a ff fd df r

    and log10 a =
      let ff = function
        | F a      -> F S.(log10 a)
        | Arr a    -> Arr A.(log10 a)
        | Mat a    -> Mat M.(log10 a)
        | _        -> error_uniop "log10" a
      in
      let fd a = log10 a in
      let df cp ap at = at / (ap * (F Owl_maths.log10e)) in
      let r a = Log10_D a in
      op_d_d a ff fd df r

    and exp a =
      let ff = function
        | F a      -> F S.(exp a)
        | Arr a    -> Arr A.(exp a)
        | Mat a    -> Mat M.(exp a)
        | _        -> error_uniop "exp" a
      in
      let fd a = exp a in
      let df cp ap at = at * cp in
      let r a = Exp_D a in
      op_d_d a ff fd df r

    and sin a =
      let ff = function
        | F a      -> F S.(sin a)
        | Arr a    -> Arr A.(sin a)
        | Mat a    -> Mat M.(sin a)
        | _        -> error_uniop "sin" a
      in
      let fd a = sin a in
      let df cp ap at = at * cos ap in
      let r a = Sin_D a in
      op_d_d a ff fd df r

    and cos a =
      let ff = function
        | F a      -> F S.(cos a)
        | Arr a    -> Arr A.(cos a)
        | Mat a    -> Mat M.(cos a)
        | _        -> error_uniop "cos" a
      in
      let fd a = cos a in
      let df cp ap at = neg (at * sin ap) in
      let r a = Cos_D a in
      op_d_d a ff fd df r

    and tan a =
      let ff = function
        | F a      -> F S.(tan a)
        | Arr a    -> Arr A.(tan a)
        | Mat a    -> Mat M.(tan a)
        | _        -> error_uniop "tan" a
      in
      let fd a = tan a in
      let df cp ap at = at / (sqr (cos ap)) in
      let r a = Tan_D a in
      op_d_d a ff fd df r

    and sinh a =
      let ff = function
        | F a      -> F S.(sinh a)
        | Arr a    -> Arr A.(sinh a)
        | Mat a    -> Mat M.(sinh a)
        | _        -> error_uniop "sinh" a
      in
      let fd a = sinh a in
      let df cp ap at = at * (cosh ap) in
      let r a = Sinh_D a in
      op_d_d a ff fd df r

    and cosh a =
      let ff = function
        | F a      -> F S.(cosh a)
        | Arr a    -> Arr A.(cosh a)
        | Mat a    -> Mat M.(cosh a)
        | _        -> error_uniop "cosh" a
      in
      let fd a = cosh a in
      let df cp ap at = at * (sinh ap) in
      let r a = Cosh_D a in
      op_d_d a ff fd df r

    and tanh a =
      let ff = function
        | F a      -> F S.(tanh a)
        | Arr a    -> Arr A.(tanh a)
        | Mat a    -> Mat M.(tanh a)
        | _        -> error_uniop "tanh" a
      in
      let fd a = tanh a in
      let df cp ap at = at / (sqr (cosh ap)) in
      let r a = Tanh_D a in
      op_d_d a ff fd df r

    and asin a =
      let ff = function
        | F a      -> F S.(asin a)
        | Arr a    -> Arr A.(asin a)
        | Mat a    -> Mat M.(asin a)
        | _        -> error_uniop "asin" a
      in
      let fd a = asin a in
      let df cp ap at = at / sqrt ((F 1.) - sqr ap) in
      let r a = Asin_D a in
      op_d_d a ff fd df r

    and acos a =
      let ff = function
        | F a      -> F S.(acos a)
        | Arr a    -> Arr A.(acos a)
        | Mat a    -> Mat M.(acos a)
        | _        -> error_uniop "acos" a
      in
      let fd a = acos a in
      let df cp ap at = (neg at) / sqrt ((F 1.) - sqr ap) in
      let r a = Acos_D a in
      op_d_d a ff fd df r

    and atan a =
      let ff = function
        | F a      -> F S.(atan a)
        | Arr a    -> Arr A.(atan a)
        | Mat a    -> Mat M.(atan a)
        | _        -> error_uniop "atan" a
      in
      let fd a = atan a in
      let df cp ap at = at / ((F 1.) + sqr ap) in
      let r a = Atan_D a in
      op_d_d a ff fd df r

    and asinh a =
      let ff = function
        | F a      -> F Owl_maths.(asinh a)
        | Arr a    -> Arr A.(asinh a)
        | Mat a    -> Mat M.(asinh a)
        | _        -> error_uniop "asinh" a
      in
      let fd a = asinh a in
      let df cp ap at = at / sqrt ((sqr ap) + (F 1.)) in
      let r a = Asinh_D a in
      op_d_d a ff fd df r

    and acosh a =
      let ff = function
        | F a      -> F Owl_maths.(acosh a)
        | Arr a    -> Arr A.(acosh a)
        | Mat a    -> Mat M.(acosh a)
        | _        -> error_uniop "acosh" a
      in
      let fd a = acosh a in
      let df cp ap at = at / sqrt ((sqr ap) - (F 1.)) in
      let r a = Acosh_D a in
      op_d_d a ff fd df r

    and atanh a =
      let ff = function
        | F a      -> F Owl_maths.(atanh a)
        | Arr a    -> Arr A.(atanh a)
        | Mat a    -> Mat M.(atanh a)
        | _        -> error_uniop "atanh" a
      in
      let fd a = atanh a in
      let df cp ap at = at / ((F 1.) - sqr ap) in
      let r a = Atanh_D a in
      op_d_d a ff fd df r

    and get_item a i j =
      match a with
      | Mat ap               -> F (M.get ap i j)
      | DF (ap, at, ai)      -> DF (get_item ap i j, get_item at i j, ai)
      | DR (ap, _, _, _, ai) -> DR (get_item ap i j, ref (F 0.), Get_Item (a, i, j), ref 0, ai)
      | _                    -> error_uniop "get_item" a

    and set_item a i j b =
      let ff a b = match a, b with
        | Mat a, F b        -> let aa = M.clone a in M.set aa i j b; Mat aa
        | _                 -> error_uniop "set_item" a
      in
      let fd a b = set_item a i j b in
      let df_da cp ap at = set_item at i j (F 0.) in
      let df_db cp bp bt = add_item (zero a) i j bt in
      let df_dab cp ap at bp bt = set_item at i j bt in
      let r_d_d a b = SetI_D_D (a, i, j, b) in
      let r_d_c a b = SetI_D_C (a, i, j, b) in
      let r_c_d a b = SetI_C_D (a, i, j, b) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and add_item a i j b =
      let ff a b = match a, b with
        | Mat a, F b        -> let aa = M.clone a in M.set aa i j S.((M.get aa i j) +. b); Mat aa
        | _                 -> error_binop "add_item" a b
      in
      let fd a b = add_item a i j b in
      let df_da cp ap at = at in
      let df_db cp bp bt = add_item (zero a) i j bt in
      let df_dab cp ap at bp bt = add_item at i j bt in
      let r_d_d a b = AddI_D_D (a, i, j, b) in
      let r_d_c a b = AddI_D_C (a, i, j, b) in
      let r_c_d a b = AddI_C_D (a, i, j, b) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and get_slice i a =
      let ff = function
        | Arr a    -> Arr A.(get_slice i a)
        | Mat a    -> Mat M.(get_slice i a)
        | _        -> error_uniop "slice" a
      in
      let fd a = get_slice i a in
      let df cp ap at = get_slice i at in
      let r a = Get_Slice_D (a, i) in
      op_d_d a ff fd df r

    and set_slice i a b =
      let ff a b =
        match a, b with
        | Arr a, Arr b -> let a = A.clone a in A.(set_slice i a b); Arr a
        | Mat a, Mat b -> let a = M.clone a in M.(set_slice i a b); Mat a
        | _            -> error_binop "set_slice" a b
      in
      let fd a b = set_slice i a b in
      let df_da cp ap at = set_slice i at (zero b) in
      let df_db cp bp bt = set_slice i (zero a) bt in
      let df_dab cp ap at bp bt = set_slice i at bt in
      let r_d_d a b = Set_Slice_D_D (a, b, i) in
      let r_d_c a b = Set_Slice_D_C (a, b, i) in
      let r_c_d a b = Set_Slice_C_D (a, b, i) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and sum a =
      let ff = function
        | Arr a    -> F A.(sum a)
        | Mat a    -> F M.(sum a)
        | _        -> error_uniop "sum" a
      in
      let fd a = sum a in
      let df cp ap at = sum at in
      let r a = Sum_D a in
      op_d_d a ff fd df r

    and sum_ ?(axis=0) a =
      let ff = function
        | Arr a    -> Arr A.(sum_ ~axis a)
        | Mat a    -> Mat M.(sum_ ~axis a)
        | _        -> error_uniop "sum_" a
      in
      let fd a = sum_ ~axis a in
      let df cp ap at = sum_ ~axis at in
      let r a = Sum__D (a, axis) in
      op_d_d a ff fd df r

    and average a = (sum a) / F (numel a |> float_of_int)

    and ( *@ ) a b = dot a b
    and dot a b =
      let ff a b =
        match a, b with
        | Mat a, Mat b       -> Mat M.(dot a b)
        | _                  -> error_binop "( *@ )" a b
      in
      let fd a b = a *@ b in
      let df_da cp ap at = at *@ b in
      let df_db cp bp bt = a *@ bt in
      let df_dab cp ap at bp bt = (ap *@ bt) + (at *@ bp) in
      let r_d_d a b = Dot_D_D (a, b) in
      let r_d_c a b = Dot_D_C (a, b) in
      let r_c_d a b = Dot_C_D (a, b) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and transpose a =
      let ff = function
        | Mat a    -> Mat M.(transpose a)
        | _        -> error_uniop "transpose" a
      in
      let fd a = transpose a in
      let df cp ap at = transpose at in
      let r a = Trans_D a in
      op_d_d a ff fd df r

    and l1norm a =
      let ff = function
        | Arr a    -> F A.(l1norm a)
        | Mat a    -> F M.(l1norm a)
        | _        -> error_uniop "l1norm" a
      in
      let fd a = l1norm a in
      let df cp ap at = at * (signum ap) in
      let r a = L1Norm_D a in
      op_d_d a ff fd df r

    and l2norm a =
      let ff = function
        | Arr a    -> F A.(l2norm a)
        | Mat a    -> F M.(l2norm a)
        | _        -> error_uniop "l2norm" a
      in
      let fd a = l2norm a in
      let df cp ap at = (ap * at) / cp in
      let r a = L2Norm_D a in
      op_d_d a ff fd df r

    and l2norm_sqr a =
      let ff = function
        | F a      -> F S.(a *. a)
        | Arr a    -> F A.(l2norm_sqr a)
        | Mat a    -> F M.(l2norm_sqr a)
        | _        -> error_uniop "l2norm_sqr" a
      in
      let fd a = l2norm_sqr a in
      let df cp ap at = (F 2.) * (ap * at) in
      let r a = L2NormS_D a in
      op_d_d a ff fd df r

    and sigmoid a =
      let ff = function
        | F a      -> F Owl_maths.(sigmoid a)
        | Arr a    -> Arr A.(sigmoid a)
        | Mat a    -> Mat M.(sigmoid a)
        | _        -> error_uniop "sigmoid" a
      in
      let fd a = sigmoid a in
      let df cp ap at = at * cp * (F 1. - cp) in
      let r a = Sigmoid_D a in
      op_d_d a ff fd df r

    and relu a =
      let ff = function
        | F a      -> F Owl_maths.(relu a)
        | Arr a    -> Arr A.(relu a)
        | Mat a    -> Mat M.(relu a)
        | _        -> error_uniop "relu" a
      in
      let fd a = relu a in
      let df cp ap at = at * (F 1. + (signum ap)) / (F 2.) in
      let r a = Relu_D a in
      op_d_d a ff fd df r

    and inv a =
      let ff = function
        | Mat a    -> Mat M.(inv a)
        | _        -> error_uniop "inv" a
      in
      let fd a = inv a in
      let df cp ap at = (neg cp) * at * cp in
      let r a = Inv_D a in
      op_d_d a ff fd df r

    and softplus x = log (F 1. + exp x)

    and softsign x = x / (F 1. + abs x)

    (* FIXME: use numerically stable version *)
    and softmax x =
      let c = F M.(max (unpack_mat x)) in
      let y = exp (x - c) in
      let a = sum y in
      y / a

    and cross_entropy x y = x * log y |> sum |> neg

    and add_row a b i =
      let ff a b =
        match a, b with
        | Mat a, Mat b       -> M.(copy_row_to (add (row a i) b) a i; Mat a)
        | _                  -> error_binop "add_row" a b
      in
      let fd a b = add_row a b i in
      let df_da cp ap at = at in
      let df_db cp bp bt = add_row (zero a) bt i in
      let df_dab cp ap at bp bt = add_row at bt i in
      let r_d_d a b = Add_Row_D_D (a, b, i) in
      let r_d_c a b = Add_Row_D_C (a, b, i) in
      let r_c_d a b = Add_Row_C_D (a, b, i) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and get_row a i =
      let ff = function
        | Mat a    -> Mat M.(row a i |> clone)
        | _        -> error_uniop "get_row" a
      in
      let fd a = get_row a i in
      let df cp ap at = get_row at i in
      let r a = Get_Row_D (a, i) in
      op_d_d a ff fd df r

    and to_rows a = Array.init (row_num a) (fun i -> get_row a i)

    and of_rows a =
      (* TODO: this can be further optimised by incorporating t array type as t *)
      match a.(0) with
      | Mat _               -> Array.map unpack_mat a |> M.of_rows |> pack_mat
      | DF (_, _, ai)       ->
        let ap = a |> Array.map (fun x -> x |> primal |> unpack_mat) |> M.of_rows |> pack_mat in
        let at = a |> Array.map (fun x -> x |> adjval |> unpack_mat) |> M.of_rows |> pack_mat in
        DF (ap, at, ai)
      | DR (_, _, _, _, ai) ->
        let ap = a |> Array.map (fun x -> x |> primal) in
        let cp = ap |> Array.map (fun x -> x |> unpack_mat) |> M.of_rows |> pack_mat in
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
      let df_da cp ap at = failwith "conv1d:df_da" in
      let df_db cp bp bt = failwith "conv1d:df_db" in
      let df_dab cp ap at bp bt = failwith "conv1d:df_dab" in
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
      let df_da cp ap at = at in
      let df_db cp bp bt = bt in
      let df_dab cp ap at bp bt = at + bt in
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
      let df_da cp ap at = at in
      let df_db cp bp bt = bt in
      let df_dab cp ap at bp bt = at + bt in
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

    and reshape a s =
      let ff = function
        | Arr a    -> Arr A.(reshape a s)
        | Mat a    -> Mat M.(reshape s.(0) s.(1) a)
        | _        -> error_uniop "reshape" a
      in
      let fd a = reshape a s in
      let df cp ap at = reshape at s in
      let r a = Reshape_D a in
      op_d_d a ff fd df r

    and flatten a = reshape a [|1; numel a|]

    and mat_to_arr a =
      let ff = function
        | Mat a    -> Arr M.(to_ndarray a)
        | _        -> error_uniop "mat_to_arr" a
      in
      let fd a = mat_to_arr a in
      let df cp ap at = mat_to_arr at in
      let r a = Mat2Arr_D a in
      op_d_d a ff fd df r

    and arr_to_mat a =
      let ff = function
        | Arr a    -> Mat M.(of_ndarray a)
        | _        -> error_uniop "arr_to_mat" a
      in
      let fd a = arr_to_mat a in
      let df cp ap at = arr_to_mat at in
      let r a = Arr2Mat_D a in
      op_d_d a ff fd df r

    (* a:input; b:kernel; s:stride *)
    and max_pool1d padding a b s =
      let ff = function
        | Arr a    -> Arr A.(max_pool1d ~padding a b s)
        | _        -> error_uniop "max_pool1d" a
      in
      let fd a = max_pool1d padding a b s in
      let df cp ap at = failwith "max_pool1d:df" in
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
      let df cp ap at = failwith "max_pool2d:df" in
      let r a = Maxpool2D_D (a, padding, b, s) in
      op_d_d a ff fd df r

    (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
    and max_pool2d_backward p a b s o =
      let a = unpack_arr a in
      let o = unpack_arr o in
      A.max_pool2d_backward p a b s o
      |> pack_arr

    (* a:input; b:kernel; s:stride *)
    and avg_pool1d padding a b s =
      let ff = function
        | Arr a    -> Arr A.(avg_pool1d ~padding a b s)
        | _        -> error_uniop "avg_pool1d" a
      in
      let fd a = avg_pool1d padding a b s in
      let df cp ap at = failwith "avg_pool1d:df" in
      let r a = Avgpool2D_D (a, padding, b, s) in
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
      let df cp ap at = failwith "avg_pool2d:df" in
      let r a = Avgpool2D_D (a, padding, b, s) in
      op_d_d a ff fd df r

    (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
    and avg_pool2d_backward p a b s o =
      let a = unpack_arr a in
      let o = unpack_arr o in
      A.avg_pool2d_backward p a b s o
      |> pack_arr

    and dropout ?(rate=0.5) ?seed a =
      let b = match (primal' a) with
        | Arr a -> Arr (A.bernoulli ~p:(1. -. rate) ?seed (A.shape a))
        | Mat a -> Mat (M.bernoulli ~p:(1. -. rate) ?seed (M.row_num a) (M.col_num a))
        | _     -> error_uniop "dropout" a
      in
      a * b

    and concat axis a b =
      let ff a b =
        match a, b with
        | Arr a, Arr b -> Arr A.(concatenate ~axis [|a; b|])
        | Mat a, Mat b -> Mat M.(concatenate ~axis [|a; b|])
        | _            -> error_binop "concat" a b
      in
      let fd a b = concat axis a b in
      let df_da cp ap at = concat axis at (zero b) in
      let df_db cp bp bt = concat axis (zero a) bt in
      let df_dab cp ap at bp bt = concat axis at bt in
      let r_d_d a b = Concat_D_D (a, b, axis) in
      let r_d_c a b = Concat_D_C (a, b, axis) in
      let r_c_d a b = Concat_C_D (a, b, axis) in
      op_d_d_d a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d

    and split axis parts a =
      let ff a =
        match a with
        | Arr a -> A.(split ~axis parts a) |> Array.map (fun x -> Arr x)
        | Mat a -> M.(split ~axis parts a) |> Array.map (fun x -> Mat x)
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
          | DR (ap, aa, ao, af, ai) -> (
            aa := reset_zero !aa;
            af := !af + 1;
            if !af = 1 then (
              match ao with
              | Noop                     -> reset t
              | Add_D_D (a, b)           -> reset (a :: b :: t)
              | Add_D_C (a, _)           -> reset (a :: t)
              | Add_C_D (_, b)           -> reset (b :: t)
              | Sub_D_D (a, b)           -> reset (a :: b :: t)
              | Sub_D_C (a, _)           -> reset (a :: t)
              | Sub_C_D (_, b)           -> reset (b :: t)
              | Mul_D_D (a, b)           -> reset (a :: b :: t)
              | Mul_D_C (a, _)           -> reset (a :: t)
              | Mul_C_D (_, b)           -> reset (b :: t)
              | Div_D_D (a, b)           -> reset (a :: b :: t)
              | Div_D_C (a, _)           -> reset (a :: t)
              | Div_C_D (_, b)           -> reset (b :: t)
              | Pow_D_D (a, b)           -> reset (a :: b :: t)
              | Pow_D_C (a, _)           -> reset (a :: t)
              | Pow_C_D (_, b)           -> reset (b :: t)
              | Atan2_D_D (a, b)         -> reset (a :: b :: t)
              | Atan2_D_C (a, _)         -> reset (a :: t)
              | Atan2_C_D (_, b)         -> reset (b :: t)
              | Neg_D a                  -> reset (a :: t)
              | Abs_D a                  -> reset (a :: t)
              | Signum_D a               -> reset (a :: t)
              | Floor_D a                -> reset (a :: t)
              | Ceil_D a                 -> reset (a :: t)
              | Round_D a                -> reset (a :: t)
              | Sqr_D a                  -> reset (a :: t)
              | Sqrt_D a                 -> reset (a :: t)
              | Log_D a                  -> reset (a :: t)
              | Log2_D a                 -> reset (a :: t)
              | Log10_D a                -> reset (a :: t)
              | Exp_D a                  -> reset (a :: t)
              | Sin_D a                  -> reset (a :: t)
              | Cos_D a                  -> reset (a :: t)
              | Tan_D a                  -> reset (a :: t)
              | Sinh_D a                 -> reset (a :: t)
              | Cosh_D a                 -> reset (a :: t)
              | Tanh_D a                 -> reset (a :: t)
              | Asin_D a                 -> reset (a :: t)
              | Acos_D a                 -> reset (a :: t)
              | Atan_D a                 -> reset (a :: t)
              | Asinh_D a                -> reset (a :: t)
              | Acosh_D a                -> reset (a :: t)
              | Atanh_D a                -> reset (a :: t)
              | Get_Item (a, _, _)       -> reset (a :: t)
              | SetI_D_D (a, _, _, b)    -> reset (a :: b :: t)
              | SetI_D_C (a, _, _, _)    -> reset (a :: t)
              | SetI_C_D (_, _, _, b)    -> reset (b :: t)
              | AddI_D_D (a, _, _, b)    -> reset (a :: b :: t)
              | AddI_D_C (a, _, _, _)    -> reset (a :: t)
              | AddI_C_D (_, _, _, b)    -> reset (b :: t)
              | Get_Slice_D (a, _)       -> reset (a :: t)
              | Set_Slice_D_D (a, b, _)  -> reset (a :: b :: t)
              | Set_Slice_D_C (a, _, _)  -> reset (a :: t)
              | Set_Slice_C_D (_, b, _)  -> reset (b :: t)
              | Sum_D a                  -> reset (a :: t)
              | Sum__D (a, _)            -> reset (a :: t)
              | Dot_D_D (a, b)           -> reset (a :: b :: t)
              | Dot_D_C (a, _)           -> reset (a :: t)
              | Dot_C_D (_, b)           -> reset (b :: t)
              | Trans_D a                -> reset (a :: t)
              | L1Norm_D a               -> reset (a :: t)
              | L2Norm_D a               -> reset (a :: t)
              | L2NormS_D a              -> reset (a :: t)
              | Sigmoid_D a              -> reset (a :: t)
              | Relu_D a                 -> reset (a :: t)
              | Inv_D a                  -> reset (a :: t)
              | Add_Row_D_D (a, b, _)    -> reset (a :: b :: t)
              | Add_Row_D_C (a, _, _)    -> reset (a :: t)
              | Add_Row_C_D (_, b, _)    -> reset (b :: t)
              | Get_Row_D (a, _)         -> reset (a :: t)
              | Of_Rows_D a              -> reset (List.append (Array.to_list a) t)
              | Conv1D_D_D (a, b, _)     -> reset (a :: b :: t)
              | Conv1D_D_C (a, _, _)     -> reset (a :: t)
              | Conv1D_C_D (_, b, _)     -> reset (b :: t)
              | Conv2D_D_D (a, b, _)     -> reset (a :: b :: t)
              | Conv2D_D_C (a, _, _)     -> reset (a :: t)
              | Conv2D_C_D (_, b, _)     -> reset (b :: t)
              | Conv3D_D_D (a, b, _)     -> reset (a :: b :: t)
              | Conv3D_D_C (a, _, _)     -> reset (a :: t)
              | Conv3D_C_D (_, b, _)     -> reset (b :: t)
              | Reshape_D a              -> reset (a :: t)
              | Mat2Arr_D a              -> reset (a :: t)
              | Arr2Mat_D a              -> reset (a :: t)
              | Maxpool1D_D (a, _, _, _) -> reset (a :: t)
              | Maxpool2D_D (a, _, _, _) -> reset (a :: t)
              | Avgpool1D_D (a, _, _, _) -> reset (a :: t)
              | Avgpool2D_D (a, _, _, _) -> reset (a :: t)
              | Concat_D_D (a, b, _)     -> reset (a :: b :: t)
              | Concat_D_C (a, _, _)     -> reset (a :: t)
              | Concat_C_D (_, b, _)     -> reset (b :: t)
              )
            else reset t
            )
          | _ -> reset t
        )
    in
    reset [x]


  let reverse_push v x =
    let open Maths in
    (* check adjoint a and its update v, ensure rank a >= rank v *)
    let _melt a v =
      match a, v with
      | F _, Mat v -> F (M.sum v)
      | Mat a, Mat v -> (
          (* check if this is due to previous broadcast operation *)
          (* FIXME: need to check full-shape, sum_cols if necessary *)
          match M.(shape a = shape v) with
          | true  -> Mat v
          | false -> Mat (M.sum_rows v)
        )
      | Arr a, Arr v -> (
          (* FIXME: only for simple case where broadcast at highest dimension *)
          match A.(shape a = shape v) with
          | true  -> Arr v
          | false -> Arr (A.sum_slices v)
        )
      | a, v -> v
    in
    let rec push xs =
      match xs with
      | [] -> ()
      | (v, x) :: t -> (
          match x with
          | DR (ap, aa, ao, af, ai) -> (
            let v = _melt !aa v in
            aa := Maths.(!aa + v);
            af := S.(!af - 1);
            if !af = 0 then (
              match ao with
              | Noop                     -> push t
              | Add_D_D (a, b)           -> push ((!aa, a) :: (!aa, b) :: t)
              | Add_D_C (a, _)           -> push ((!aa, a) :: t)
              | Add_C_D (_, b)           -> push ((!aa, b) :: t)
              | Sub_D_D (a, b)           -> push ((!aa, a) :: (neg !aa, b) :: t)
              | Sub_D_C (a, _)           -> push ((!aa, a) :: t)
              | Sub_C_D (_, b)           -> push ((neg !aa, b) :: t)
              | Mul_D_D (a, b)           -> push (((!aa * primal b), a) :: ((!aa * primal a), b) :: t)
              | Mul_D_C (a, b)           -> push (((!aa * b), a) :: t)
              | Mul_C_D (a, b)           -> push (((!aa * a), b) :: t)
              | Div_D_D (a, b)           -> push (((!aa / (primal b)), a) :: ((!aa * ((neg (primal a)) / ((primal b) * (primal b)))), b) :: t)
              | Div_D_C (a, b)           -> push (((!aa / b), a) :: t)
              | Div_C_D (a, b)           -> push (((!aa * ((neg a) / ((primal b) * (primal b)))), b) :: t)
              | Pow_D_D (a, b)           -> push (((!aa * ((primal a) ** ((primal b) - (F 1.))) * (primal b)), a) :: ((!aa * ((primal a) ** (primal b)) * log (primal a)), b) :: t)
              | Pow_D_C (a, b)           -> push (((!aa * ((primal a) ** (b - (F 1.))) * b), a) :: t)
              | Pow_C_D (a, b)           -> push (((!aa * (a ** (primal b)) * log a), b) :: t)
              | Atan2_D_D (a, b)         -> let d = (sqr (primal a)) + (sqr (primal b)) in push (((!aa * (primal b) / d), a) :: ((!aa * (neg (primal a)) / d), b) :: t)
              | Atan2_D_C (a, b)         -> push (((!aa * b / ((sqr (primal a)) + (sqr b))), a) :: t)
              | Atan2_C_D (a, b)         -> push (((!aa * (neg a) / ((sqr a) + (sqr (primal b)))), b) :: t)
              | Neg_D a                  -> push ((neg !aa, a) :: t)
              | Abs_D a                  -> push (((!aa * signum (primal a)), a) :: t)
              | Signum_D a               -> push ((zero a, a) :: t)
              | Floor_D a                -> push ((zero a, a) :: t)
              | Ceil_D a                 -> push ((zero a, a) :: t)
              | Round_D a                -> push ((zero a, a) :: t)
              | Sqr_D a                  -> push (((!aa * (primal a) * (F 2.)), a) :: t)
              | Sqrt_D a                 -> push (((!aa / ((F 2.) * ap)), a) :: t)
              | Log_D a                  -> push (((!aa / (primal a)), a) :: t)
              | Log2_D a                 -> push (((!aa / ((primal a) * (F Owl_maths.log2e))), a) :: t)
              | Log10_D a                -> push (((!aa / ((primal a) * (F Owl_maths.log10e))), a) :: t)
              | Exp_D a                  -> push (((!aa * ap), a) :: t)
              | Sin_D a                  -> push (((!aa * cos (primal a)), a) :: t)
              | Cos_D a                  -> push (((!aa * (neg (sin (primal a)))), a) :: t)
              | Tan_D a                  -> push (((!aa / (sqr (cos (primal a)))), a) :: t)
              | Sinh_D a                 -> push (((!aa * (cosh (primal a))), a) :: t)
              | Cosh_D a                 -> push (((!aa * (sinh (primal a))), a) :: t)
              | Tanh_D a                 -> push (((!aa / (sqr (cosh (primal a)))), a) :: t)
              | Asin_D a                 -> push (((!aa / sqrt ((F 1.) - sqr (primal a))), a) :: t)
              | Acos_D a                 -> push ((((neg !aa) / sqrt ((F 1.) - sqr (primal a))), a) :: t)
              | Atan_D a                 -> push (((!aa / ((F 1.) + sqr (primal a))), a) :: t)
              | Asinh_D a                -> push (((!aa / sqrt ((sqr (primal a)) + (F 1.))), a) :: t)
              | Acosh_D a                -> push (((!aa / sqrt ((sqr (primal a)) - (F 1.))), a) :: t)
              | Atanh_D a                -> push (((!aa / ((F 1.) - sqr (primal a))), a) :: t)
              | Get_Item (a, i, j)       -> (adjref a) := add_item (adjval a) i j !aa; push ((zero a, a) :: t)
              | SetI_D_D (a, i, j, b)    -> push ((set_item !aa i j (F 0.), a) :: (get_item !aa i j, b) :: t)
              | SetI_D_C (a, i, j, _)    -> push ((set_item !aa i j (F 0.), a) :: t)
              | SetI_C_D (_, i, j, b)    -> push ((get_item !aa i j, b) :: t)
              | AddI_D_D (a, i, j, b)    -> push ((!aa, a) :: (get_item !aa i j, b) :: t)
              | AddI_D_C (a, _, _, _)    -> push ((!aa, a) :: t)
              | AddI_C_D (_, i, j, b)    -> push ((get_item !aa i j, b) :: t)
              | Get_Slice_D (a, i)       -> push ((set_slice i (zero a) !aa, a) :: t)
              | Set_Slice_D_D (a, b, i)  -> push ((set_slice i !aa (zero b), a) :: (get_slice i !aa, b) :: t)
              | Set_Slice_D_C (a, b, i)  -> push ((set_slice i !aa (zero b), a) :: t)
              | Set_Slice_C_D (a, b, i)  -> push ((get_slice i !aa, b) :: t)
              | Sum_D a                  -> push ((((mat_create (row_num (primal a)) (col_num (primal a)) !aa)), a) :: t)
              (* TODO: SUM_D can be optimised to this | Sum_D a               -> push ((!aa, a) :: t) *)
              | Sum__D (a, i)            -> push ((repeat ~axis:i !aa (shape a).(i), a) :: t)
              | Dot_D_D (a, b)           -> push (((dot !aa (transpose (primal b))), a) :: ((dot (transpose (primal a)) !aa), b) :: t)
              | Dot_D_C (a, b)           -> push (((dot !aa (transpose b)), a) :: t)
              | Dot_C_D (a, b)           -> push (((dot (transpose a) !aa), b) :: t)
              | Trans_D a                -> push (((transpose !aa), a) :: t)
              | L1Norm_D a               -> push (((!aa * (signum (primal a))), a) :: t)
              | L2Norm_D a               -> push (((!aa / ap * (primal a)), a) :: t)
              | L2NormS_D a              -> push (((!aa * (F 2.) * (primal a)), a) :: t)
              | Sigmoid_D a              -> push (((!aa * ap * (F 1. - ap)), a) :: t)
              | Relu_D a                 -> push (((!aa * ((signum (primal a) + F 1.) / (F 2.))), a) :: t)
              | Inv_D a                  -> let dpt = transpose ap in push ((((neg dpt) * !aa * dpt), a) :: t)
              | Add_Row_D_D (a, b, i)    -> push ((!aa, a) :: (get_row !aa i, b) :: t)
              | Add_Row_D_C (a, b, i)    -> push ((!aa, a) :: t)
              | Add_Row_C_D (a, b, i)    -> push ((get_row !aa i, b) :: t)
              | Get_Row_D (a, i)         -> (adjref a) := add_row (adjval a) !aa i; push ((zero a, a) :: t)
              | Of_Rows_D a              -> push (t |> List.append (a |> Array.to_list |> List.mapi (fun i v -> (get_row !aa i, v))))
              | Conv1D_D_D (a, b, s)     -> push ((conv1d_backward_input a b s !aa, a) :: (conv1d_backward_kernel a b s !aa, b) :: t)
              | Conv1D_D_C (a, b, s)     -> push ((conv1d_backward_input a b s !aa, a) :: t)
              | Conv1D_C_D (a, b, s)     -> push ((conv1d_backward_kernel a b s !aa, b) :: t)
              | Conv2D_D_D (a, b, s)     -> push ((conv2d_backward_input a b s !aa, a) :: (conv2d_backward_kernel a b s !aa, b) :: t)
              | Conv2D_D_C (a, b, s)     -> push ((conv2d_backward_input a b s !aa, a) :: t)
              | Conv2D_C_D (a, b, s)     -> push ((conv2d_backward_kernel a b s !aa, b) :: t)
              | Conv3D_D_D (a, b, s)     -> push ((conv3d_backward_input a b s !aa, a) :: (conv3d_backward_kernel a b s !aa, b) :: t)
              | Conv3D_D_C (a, b, s)     -> push ((conv3d_backward_input a b s !aa, a) :: t)
              | Conv3D_C_D (a, b, s)     -> push ((conv3d_backward_kernel a b s !aa, b) :: t)
              | Reshape_D a              -> push ((reshape !aa (shape (primal a)), a) :: t)
              | Mat2Arr_D a              -> push ((arr_to_mat !aa, a) :: t)
              | Arr2Mat_D a              -> push ((mat_to_arr !aa, a) :: t)
              | Maxpool1D_D (a, p, d, s) -> push ((max_pool1d_backward p (primal a) d s !aa, a) :: t)
              | Maxpool2D_D (a, p, d, s) -> push ((max_pool2d_backward p (primal a) d s !aa, a) :: t)
              | Avgpool1D_D (a, p, d, s) -> push ((avg_pool2d_backward p (primal a) d s !aa, a) :: t)
              | Avgpool2D_D (a, p, d, s) -> push ((avg_pool2d_backward p (primal a) d s !aa, a) :: t)
              | Concat_D_D (a, b, i)     -> let s = split i [|(shape a).(i); (shape b).(i)|] !aa in push ((s.(0) ,a) :: (s.(1) ,b) :: t)
              | Concat_D_C (a, b, i)     -> let s = split i [|(shape a).(i); (shape b).(i)|] !aa in push ((s.(0) ,a) :: t)
              | Concat_C_D (a, b, i)     -> let s = split i [|(shape a).(i); (shape b).(i)|] !aa in push ((s.(1) ,b) :: t)
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
    let x = make_forward x (F 1.) (tag ()) in
    let y = f x in
    primal y, tangent y

  (* derivative of f (scalar -> scalar) at x, forward ad *)
  let diff f x = diff' f x |> snd

  (* gradient of f (vector -> scalar) at x, reverse ad *)
  let grad' f x =
    let x = make_reverse x (tag ()) in
    let y = f x in
    reverse_reset y;
    reverse_push (F 1.) y;
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
    let z = M.empty m n in
    (
      match m > n with
      | true  ->  (
          Array.init n (fun i ->
            let v = M.zeros 1 n in
            M.set v 0 i 1.;
            jacobianv f x (Mat v)
          )
          |> Array.iteri (fun i v ->
            match v with
            | Mat v -> M.copy_col_to (M.transpose v) z i
            | _     -> failwith "error: jacobian"
          );
        )
      | false -> (
          Array.init m (fun i ->
            let v = M.zeros 1 m in
            M.set v 0 i 1.;
            jacobianTv f x (Mat v)
          )
          |> Array.iteri (fun i v ->
            match v with
            | Mat v -> M.copy_row_to v z i
            | _     -> failwith "error: jacobian"
          );
        );
    );
    (y, Mat z)


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
  let laplacian f x = F (hessian f x |> unpack_mat |> M.trace)

  let laplacian' f x = f x, laplacian f x


  (* Wrapper for the Mat module *)

  module Mat = struct

    let empty m n = M.empty m n |> pack_mat

    let zeros m n = M.zeros m n |> pack_mat

    let ones m n = M.ones m n |> pack_mat

    let uniform ?scale m n = M.uniform ?scale m n |> pack_mat

    let gaussian ?sigma m n = M.gaussian ?sigma m n |> pack_mat

    let reset x = x |> unpack_mat |> M.reset

    let reshape m n x = Maths.reshape x [|m;n|]

    let shape x = M.shape (unpack_mat x)

    let row_num x = M.row_num (unpack_mat x)

    let col_num x = M.col_num (unpack_mat x)

    let numel x = numel x

    let row x i = Maths.get_row x i

    let get x i j = Maths.get_item x i j

    let set x i j a = Maths.set_item x i j a

    (* unary math operators *)

    let average x = Maths.average x

    (* binary math operators *)

    let add x y = Maths.add x y

    let sub x y = Maths.sub x y

    let mul x y = Maths.mul x y

    let div x y = Maths.div x y

    let dot x y = Maths.dot x y

    let clip_by_l2norm t x = M.clip_by_l2norm (unpack_flt t) (unpack_mat x) |> pack_mat

    (* FIXME: need to be call row fun *)
    let iteri_rows f x = M.iteri_rows (fun i v -> f i (pack_mat v)) (unpack_mat x)

    let iter2_rows f x y = M.iter2_rows (fun u v -> f (pack_mat u) (pack_mat v)) (unpack_mat x) (unpack_mat y)

    let iteri f x = x |> unpack_mat |> M.iteri f

    let mapi f x = x |> unpack_mat |> M.mapi f |> pack_mat

    let map_by_row f x = x |> Maths.to_rows |> Array.map f |> Maths.of_rows

    (* FIXME: severe *)
    let draw_rows ?replacement x c =
      let x', l = M.draw_rows ?replacement (unpack_mat x) c in
      pack_mat x', l

    (* FIXME: severe *)
    let draw_rows2 ?replacement x y c =
      let x', y', l = M.draw_rows2 ?replacement (unpack_mat x) (unpack_mat y) c in
      pack_mat x', pack_mat y', l

    let print x = M.print (unpack_mat x)

    let of_arrays x = M.of_arrays x |> pack_mat

  end


  (* Wrapper for the Arr module *)

  module Arr = struct

    let empty d = A.empty d |> pack_arr

    let zeros d = A.zeros d |> pack_arr

    let ones d = A.ones d |> pack_arr

    let uniform ?scale d = A.uniform ?scale d |> pack_arr

    let gaussian ?sigma d = A.gaussian ?sigma d |> pack_arr

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

    let print x = A.print (unpack_arr x)

  end


  (* TODO: consider visualisation *)
  let print_trace x =
    None


end



(* ends here *)
