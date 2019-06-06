module Make (Core : Owl_algodiff_core_sig.Sig) = struct
  open Core

  (* add function specifically for the reverse module *)
  let rec _reverse_add a b =
    let ff a b =
      match a, b with
      | F a, F b -> F A.Scalar.(add a b)
      | F a, Arr b -> Arr A.(scalar_add a b)
      | Arr a, F b -> Arr A.(add_scalar a b)
      | Arr a, Arr b -> Arr A.(add a b)
      | _ -> error_binop "( reverse_add )" a b
    in
    let fd a b = _reverse_add a b in
    let df_da _cp _ap at = at in
    let df_db _cp _bp bt = bt in
    let df_dab _cp _ap at _bp bt = _reverse_add at bt in
    let r_d_d a b =
      let adjoint _ap aa t = (!aa, a) :: (!aa, b) :: t in
      let register t = a :: b :: t in
      let label = "Reverse_Add_D_D", [ a; b ] in
      adjoint, register, label
    in
    let r_d_c a b =
      let adjoint _ap aa t = (!aa, a) :: t in
      let register t = a :: t in
      let label = "Reverse_Add_D_C", [ a; b ] in
      adjoint, register, label
    in
    let r_c_d a b =
      let adjoint _ap aa t = (!aa, b) :: t in
      let register t = b :: t in
      let label = "Reverse_Add_C_D", [ a; b ] in
      adjoint, register, label
    in
    op_piso a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d


  (* core of reverse mode functions *)

  let reverse_reset x =
    let rec reset xs =
      match xs with
      | [] -> ()
      | x :: t ->
        (match x with
        | DR (_cp, aa, (_, register, _), af, _ai, tracker) ->
          aa := reset_zero !aa;
          af := !af + 1;
          tracker := succ !tracker;
          if !af = 1 && !tracker = 1 then reset (register t) else reset t
        | _ -> reset t)
    in
    reset [ x ]


  let reverse_push =
    (* check adjoint a and its update v, ensure rank a >= rank v. This function fixes the
       inconsistent shapes between a and v by performing the inverse operation of the
       previous broadcasting function. Note that padding is on the left due to the expand
       function called in broadcasting. *)
    let _shrink a v =
      match a, v with
      | F _, Arr v -> F (A.sum' v)
      | Arr a, Arr v ->
        let shp_a = A.shape a in
        let shp_v = A.shape v in
        if shp_a <> shp_v
        then (
          let shp_a, shp_v = Owl_utils_array.align `Left 1 shp_a shp_v in
          let axis = Owl_utils_array.filter2_i ( <> ) shp_a shp_v in
          Arr (A.sum_reduce ~axis v))
        else Arr v
      | _a, v -> v
    in
    let rec push xs =
      match xs with
      | [] -> ()
      | (v, x) :: t ->
        (match x with
        | DR (cp, aa, (adjoint, _, _), af, _ai, tracker) ->
          let v = _shrink !aa v in
          aa := _reverse_add !aa v;
          (af := Pervasives.(!af - 1));
          if !af = 0 && !tracker = 1
          then push (adjoint cp aa t)
          else (
            tracker := pred !tracker;
            push t)
        | _ -> push t)
    in
    fun v x -> push [ v, x ]


  let reverse_prop v x =
    reverse_reset x;
    reverse_push v x
end
