module Make (Types : Owl_algodiff_types_sig.Sig) = struct
  include Types

  (* hepler functions of the core AD component *)

  let cmp_tag ai bi = if ai > bi then 1 else if ai < bi then -1 else 0

  let reset_zero = function
    | F _ -> F A.(float_to_elt 0.)
    | Arr ap ->
      A.reset ap;
      Arr ap
    | _ -> failwith "error: reset_zero"


  let primal = function
    | DF (ap, _, _) -> ap
    | DR (ap, _, _, _, _, _) -> ap
    | ap -> ap


  let rec primal' = function
    | DF (ap, _, _) -> primal' ap
    | DR (ap, _, _, _, _, _) -> primal' ap
    | ap -> ap


  let rec zero = function
    | F _ -> F A.(float_to_elt 0.)
    | Arr ap -> Arr A.(zeros (shape ap))
    | DF (ap, _, _) -> ap |> primal' |> zero
    | DR (ap, _, _, _, _, _) -> ap |> primal' |> zero


  let tangent = function
    | DF (_, at, _) -> at
    | DR _ -> failwith "error: no tangent for DR"
    | ap -> zero ap


  let adjref = function
    | DF _ -> failwith "error: no adjref for DF"
    | DR (_, at, _, _, _, _) -> at
    | ap -> ref (zero ap)


  let adjval = function
    | DF _ -> failwith "error: no adjval for DF"
    | DR (_, at, _, _, _, _) -> !at
    | ap -> zero ap


  let shape x =
    match primal' x with
    | Arr ap -> A.shape ap
    | _ -> failwith "error: AD.shape"


  let row_num x = (shape x).(0)
  let col_num x = (shape x).(1)

  let numel x =
    match primal' x with
    | Arr x -> A.numel x
    | _ -> failwith "error: AD.numel"


  let clip_by_value ~amin ~amax x =
    match primal' x with
    | Arr x -> Arr A.(clip_by_value ~amin ~amax x)
    | _ -> failwith "error: AD.clip_by_value"


  let clip_by_l2norm a x =
    match primal' x with
    | Arr x -> Arr A.(clip_by_l2norm a x)
    | _ -> failwith "error: AD.clip_by_l2norm"


  let copy_primal' x =
    match primal' x with
    | Arr ap -> Arr A.(copy ap)
    | _ -> failwith "error: AD.copy"


  let tile x reps =
    match primal' x with
    | Arr x -> Arr A.(tile x reps)
    | _ -> failwith "error: AD.tile"


  let repeat x reps =
    match primal' x with
    | Arr x -> Arr A.(repeat x reps)
    | _ -> failwith "error: AD.repeat"


  (* packing and unpacking functions *)

  let pack_elt x = F x

  let unpack_elt x =
    match primal x with
    | F x -> x
    | _ -> failwith "error: AD.unpack_elt"


  let pack_flt x = F A.(float_to_elt x)
  let _f x = F A.(float_to_elt x)

  (* shorcut for type conversion *)

  let unpack_flt x =
    match primal x with
    | F x -> A.elt_to_float x
    | _ -> failwith "error: AD.unpack_flt"


  let pack_arr x = Arr x

  let unpack_arr x =
    match primal x with
    | Arr x -> x
    | _ -> failwith "error: AD.unpack_arr"


  (* functions to report errors, help in debugging *)

  let deep_info x =
    match primal' x with
    | F a -> Printf.sprintf "F(%g)" A.(elt_to_float a)
    | Arr a ->
      Printf.sprintf "Arr(%s)" (A.shape a |> Owl_utils_array.to_string string_of_int)
    | _ -> "you should not have reached here!"


  let type_info x =
    match x with
    | F _a -> Printf.sprintf "[%s]" (deep_info x)
    | DF (ap, _at, ai) -> Printf.sprintf "[DF tag:%i ap:%s]" ai (deep_info ap)
    | DR (ap, _at, _ao, _af, ai, _) ->
      Printf.sprintf "[DR tag:%i ap:%s]" ai (deep_info ap)
    | _ -> Printf.sprintf "[%s]" (deep_info x)


  let error_binop op a b =
    let s0 = "#0:" ^ type_info a in
    let s1 = "#1:" ^ type_info b in
    failwith (op ^ " : " ^ s0 ^ ", " ^ s1)


  let error_uniop op a =
    let s = type_info a in
    failwith (op ^ " : " ^ s)


  (* single input single output operation *)
  let op_siso a ff fd df r =
    match a with
    | DF (ap, at, ai) ->
      let cp = fd ap in
      DF (cp, df cp ap at, ai)
    | DR (ap, _, _, _, ai, _) ->
      let cp = fd ap in
      DR (cp, ref (zero cp), r a, ref 0, ai, ref 0)
    | ap -> ff ap


  (* single input pair outputs operation *)
  and op_sipo a ff fd df r =
    match a with
    | DF (ap, at, ai) ->
      let cp1, cp2 = fd ap in
      DF (cp1, df cp1 ap at, ai), DF (cp2, df cp2 ap at, ai)
    | DR (ap, _, _, _, ai, _) ->
      let cp1, cp2 = fd ap in
      let ca1_ref = ref (zero cp1) in
      let ca2_ref = ref (zero cp2) in
      let cp1_ref = ref cp1 in
      let cp2_ref = ref cp2 in
      let tracker = ref 0 in
      (* tracker: int reference In reverse_reset, i keeps track of the number of times
         cp1 and cp2 has been called such that in reverse_push, we do not update the
         adjoint of ap before we've fully updated both ca1 and ca2 *)
      ( DR
          ( cp1
          , ca1_ref
          , r (a, (cp1_ref, cp2_ref), (ca1_ref, ca2_ref))
          , ref 0
          , ai
          , tracker )
      , DR
          ( cp2
          , ca2_ref
          , r (a, (cp1_ref, cp2_ref), (ca1_ref, ca2_ref))
          , ref 0
          , ai
          , tracker ) )
    | ap -> ff ap


  (* single input three outputs operation *)
  and op_sito a ff fd df r =
    match a with
    | DF (ap, at, ai) ->
      let cp1, cp2, cp3 = fd ap in
      DF (cp1, df cp1 ap at, ai), DF (cp2, df cp2 ap at, ai), DF (cp3, df cp3 ap at, ai)
    | DR (ap, _, _, _, ai, _) ->
      let cp1, cp2, cp3 = fd ap in
      let ca1_ref = ref (zero cp1) in
      let ca2_ref = ref (zero cp2) in
      let ca3_ref = ref (zero cp3) in
      let cp1_ref = ref cp1 in
      let cp2_ref = ref cp2 in
      let cp3_ref = ref cp3 in
      let tracker = ref 0 in
      ( DR
          ( cp1
          , ca1_ref
          , r (a, (cp1_ref, cp2_ref, cp3_ref), (ca1_ref, ca2_ref, ca3_ref))
          , ref 0
          , ai
          , tracker )
      , DR
          ( cp2
          , ca2_ref
          , r (a, (cp1_ref, cp2_ref, cp3_ref), (ca1_ref, ca2_ref, ca3_ref))
          , ref 0
          , ai
          , tracker )
      , DR
          ( cp3
          , ca3_ref
          , r (a, (cp1_ref, cp2_ref, cp3_ref), (ca1_ref, ca2_ref, ca3_ref))
          , ref 0
          , ai
          , tracker ) )
    | ap -> ff ap


  (* single input array outputs operation *)
  and op_siao a ff fd df r =
    match a with
    | DF (ap, at, ai) ->
      let cp_arr = fd ap in
      Array.map (fun cp -> DF (cp, df cp ap at, ai)) cp_arr
    | DR (ap, _, _, _, ai, _) ->
      let cp_arr = fd ap in
      let cp_arr_ref = Array.map (fun cp -> ref cp) cp_arr in
      let tracker = ref 0 in
      let ca_ref_arr = Array.map (fun cp -> ref (zero cp)) cp_arr in
      Array.map2
        (fun cp ca_ref ->
          DR (cp, ca_ref, r (a, cp_arr_ref, ca_ref_arr), ref 0, ai, tracker))
        cp_arr
        ca_ref_arr
    | ap -> ff ap


  (* pair input single output operation *)
  and op_piso a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d =
    match a, b with
    | F _ap, DF (bp, bt, bi) ->
      let cp = fd a bp in
      DF (cp, df_db cp bp bt, bi)
    | DF (ap, at, ai), F _bp ->
      let cp = fd ap b in
      DF (cp, df_da cp ap at, ai)
    | Arr _ap, DF (bp, bt, bi) ->
      let cp = fd a bp in
      DF (cp, df_db cp bp bt, bi)
    | DF (ap, at, ai), Arr _bp ->
      let cp = fd ap b in
      DF (cp, df_da cp ap at, ai)
    | F _ap, DR (bp, _, _, _, bi, _) ->
      let cp = fd a bp in
      DR (cp, ref (zero cp), r_c_d a b, ref 0, bi, ref 0)
    | DR (ap, _, _, _, ai, _), F _bp ->
      let cp = fd ap b in
      DR (cp, ref (zero cp), r_d_c a b, ref 0, ai, ref 0)
    | Arr _ap, DR (bp, _, _, _, bi, _) ->
      let cp = fd a bp in
      DR (cp, ref (zero cp), r_c_d a b, ref 0, bi, ref 0)
    | DR (ap, _, _, _, ai, _), Arr _bp ->
      let cp = fd ap b in
      DR (cp, ref (zero cp), r_d_c a b, ref 0, ai, ref 0)
    | DF (ap, at, ai), DR (bp, _, _, _, bi, _) ->
      (match cmp_tag ai bi with
      | 1 ->
        let cp = fd ap b in
        DF (cp, df_da cp ap at, ai)
      | -1 ->
        let cp = fd a bp in
        DR (cp, ref (zero cp), r_c_d a b, ref 0, bi, ref 0)
      | _ -> failwith "error: forward and reverse clash at the same level")
    | DR (ap, _, _, _, ai, _), DF (bp, bt, bi) ->
      (match cmp_tag ai bi with
      | -1 ->
        let cp = fd a bp in
        DF (cp, df_db cp bp bt, bi)
      | 1 ->
        let cp = fd ap b in
        DR (cp, ref (zero cp), r_d_c a b, ref 0, ai, ref 0)
      | _ -> failwith "error: forward and reverse clash at the same level")
    | DF (ap, at, ai), DF (bp, bt, bi) ->
      (match cmp_tag ai bi with
      | 0 ->
        let cp = fd ap bp in
        DF (cp, df_dab cp ap at bp bt, ai)
      | 1 ->
        let cp = fd ap b in
        DF (cp, df_da cp ap at, ai)
      | _ ->
        let cp = fd a bp in
        DF (cp, df_db cp bp bt, bi))
    | DR (ap, _, _, _, ai, _), DR (bp, _, _, _, bi, _) ->
      (match cmp_tag ai bi with
      | 0 ->
        let cp = fd ap bp in
        DR (cp, ref (zero cp), r_d_d a b, ref 0, ai, ref 0)
      | 1 ->
        let cp = fd ap b in
        DR (cp, ref (zero cp), r_d_c a b, ref 0, ai, ref 0)
      | _ ->
        let cp = fd a bp in
        DR (cp, ref (zero cp), r_c_d a b, ref 0, bi, ref 0))
    | a, b -> ff a b
end
