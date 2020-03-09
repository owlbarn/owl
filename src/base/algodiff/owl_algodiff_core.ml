(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module Make (A : Owl_types_ndarray_algodiff.Sig) = struct
  include Owl_algodiff_types.Make (A)
  module A = A

  (* generate global tags *)
  let _global_tag = ref 0

  let tag () =
    _global_tag := !_global_tag + 1;
    !_global_tag


  (* helper functions of the core AD component *)

  let reset_zero = function
    | F _    -> F A.(float_to_elt 0.)
    | Arr ap ->
      A.reset ap;
      Arr ap
    | _      -> failwith "error: reset_zero"


  let primal = function
    | DF (ap, _, _)          -> ap
    | DR (ap, _, _, _, _, _) -> ap
    | ap                     -> ap


  let rec primal' = function
    | DF (ap, _, _)          -> primal' ap
    | DR (ap, _, _, _, _, _) -> primal' ap
    | ap                     -> ap


  let rec zero = function
    | F _                    -> F A.(float_to_elt 0.)
    | Arr ap                 -> Arr A.(zeros (shape ap))
    | DF (ap, _, _)          -> ap |> primal' |> zero
    | DR (ap, _, _, _, _, _) -> ap |> primal' |> zero


  let tangent = function
    | DF (_, at, _) -> at
    | DR _          -> failwith "error: no tangent for DR"
    | ap            -> zero ap


  let adjref = function
    | DF _                   -> failwith "error: no adjref for DF"
    | DR (_, at, _, _, _, _) -> at
    | ap                     -> ref (zero ap)


  let adjval = function
    | DF _                   -> failwith "error: no adjval for DF"
    | DR (_, at, _, _, _, _) -> !at
    | ap                     -> zero ap


  let shape x =
    match primal' x with
    | F _    -> [||]
    | Arr ap -> A.shape ap
    | _      -> failwith "error: AD.shape"


  let rec is_float x =
    match x with
    | Arr _ -> false
    | F _   -> true
    | DF _  -> is_float (primal' x)
    | DR _  -> is_float (primal' x)


  let rec is_arr x =
    match x with
    | Arr _ -> false
    | F _   -> true
    | DF _  -> is_arr (primal' x)
    | DR _  -> is_arr (primal' x)


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
    match primal' x with
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
    match primal x with
    | F x -> x
    | _   -> failwith "error: AD.unpack_elt"


  let pack_flt x = F A.(float_to_elt x)

  let _f x = F A.(float_to_elt x)

  (* shorcut for type conversion *)

  let unpack_flt x =
    match primal x with
    | F x -> A.elt_to_float x
    | _   -> failwith "error: AD.unpack_flt"


  let pack_arr x = Arr x

  let unpack_arr x =
    match primal x with
    | Arr x -> x
    | _     -> failwith "error: AD.unpack_arr"


  (* functions to report errors, help in debugging *)

  let deep_info x =
    match primal' x with
    | F a   -> Printf.sprintf "F(%g)" A.(elt_to_float a)
    | Arr a ->
      Printf.sprintf "Arr(%s)" (A.shape a |> Owl_utils_array.to_string string_of_int)
    | _     -> "you should not have reached here!"


  let type_info x =
    match x with
    | F _a                          -> Printf.sprintf "[%s]" (deep_info x)
    | DF (ap, _at, ai)              -> Printf.sprintf "[DF tag:%i ap:%s]" ai (deep_info ap)
    | DR (ap, _at, _ao, _af, ai, _) ->
      Printf.sprintf "[DR tag:%i ap:%s]" ai (deep_info ap)
    | _                             -> Printf.sprintf "[%s]" (deep_info x)


  let error_binop op a b =
    let s0 = "#0:" ^ type_info a in
    let s1 = "#1:" ^ type_info b in
    failwith (op ^ " : " ^ s0 ^ ", " ^ s1)


  let error_uniop op a =
    let s = type_info a in
    failwith (op ^ " : " ^ s)
end
