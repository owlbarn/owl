module Make_Ops (Core : Owl_algodiff_core_sig.Sig) = struct
  open Core
  module Builder = Owl_algodiff_ops_builder.Make_Ops_Builder (Core)
  open Builder

  module Maths = struct
    let rec noop = ()

    (* single input single output operations *)
    and neg a =
      build_siso
        (module struct
          let label = "neg"
          let ff_f a = F A.Scalar.(neg a)
          let ff_arr a = Arr A.(neg a)
          let df _cp _ap at = pack_flt 0. - at
          let dr _ap aa = neg aa
        end
        : Siso)
        a


    and abs a =
      let ff = function
        | F a -> F A.Scalar.(abs a)
        | Arr a -> Arr A.(abs a)
        | _ -> error_uniop "abs" a
      in
      let fd a = abs a in
      let df _cp ap at = at * signum ap in
      let r a =
        let reverse _ap aa t = (!aa * signum (primal a), a) :: t in
        let input t = a :: t in
        let label = "Abs_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and signum a =
      let ff = function
        | F a -> F A.Scalar.(signum a)
        | Arr a -> Arr A.(signum a)
        | _ -> error_uniop "signum" a
      in
      let fd a = signum a in
      let df _cp ap _at = zero ap in
      let r a =
        let reverse _ap _aa t = (zero a, a) :: t in
        let input t = a :: t in
        let label = "Signum_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and floor a =
      let ff = function
        | F a -> F A.Scalar.(floor a)
        | Arr a -> Arr A.(floor a)
        | _ -> error_uniop "floor" a
      in
      let fd a = floor a in
      let df _cp ap _at = zero ap in
      let r a =
        let reverse _ap _aa t = (zero a, a) :: t in
        let input t = a :: t in
        let label = "Floor_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and ceil a =
      let ff = function
        | F a -> F A.Scalar.(ceil a)
        | Arr a -> Arr A.(ceil a)
        | _ -> error_uniop "ceil" a
      in
      let fd a = ceil a in
      let df _cp ap _at = zero ap in
      let r a =
        let reverse _ap _aa t = (zero a, a) :: t in
        let input t = a :: t in
        let label = "Ceil_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and round a =
      let ff = function
        | F a -> F A.Scalar.(round a)
        | Arr a -> Arr A.(round a)
        | _ -> error_uniop "round" a
      in
      let fd a = round a in
      let df _cp ap _at = zero ap in
      let r a =
        let reverse _ap _aa t = (zero a, a) :: t in
        let input t = a :: t in
        let label = "Round_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and sqr a =
      let ff = function
        | F a -> F A.Scalar.(sqr a)
        | Arr a -> Arr A.(sqr a)
        | _ -> error_uniop "sqr" a
      in
      let fd a = sqr a in
      let df _cp ap at = pack_flt 2. * at * ap in
      let r a =
        let reverse _ap aa t = (!aa * primal a * pack_flt 2., a) :: t in
        let input t = a :: t in
        let label = "Sqr_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and sqrt a =
      let ff = function
        | F a -> F A.Scalar.(sqrt a)
        | Arr a -> Arr A.(sqrt a)
        | _ -> error_uniop "sqrt" a
      in
      let fd a = sqrt a in
      let df cp _ap at = at / (pack_flt 2. * cp) in
      let r a =
        let reverse ap aa t = (!aa / (pack_flt 2. * ap), a) :: t in
        let input t = a :: t in
        let label = "Sqrt_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and log a =
      let ff = function
        | F a -> F A.Scalar.(log a)
        | Arr a -> Arr A.(log a)
        | _ -> error_uniop "log" a
      in
      let fd a = log a in
      let df _cp ap at = at / ap in
      let r a =
        let reverse _ap aa t = (!aa / primal a, a) :: t in
        let input t = a :: t in
        let label = "Log_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and log2 a =
      let ff = function
        | F a -> F A.Scalar.(log2 a)
        | Arr a -> Arr A.(log2 a)
        | _ -> error_uniop "log2" a
      in
      let fd a = log2 a in
      let df _cp ap at = at / (ap * pack_flt Owl_const.log2e) in
      let r a =
        let reverse _ap aa t = (!aa / (primal a * pack_flt Owl_const.log2e), a) :: t in
        let input t = a :: t in
        let label = "Log2_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and log10 a =
      let ff = function
        | F a -> F A.Scalar.(log10 a)
        | Arr a -> Arr A.(log10 a)
        | _ -> error_uniop "log10" a
      in
      let fd a = log10 a in
      let df _cp ap at = at / (ap * pack_flt Owl_const.log10e) in
      let r a =
        let reverse _ap aa t = (!aa / (primal a * pack_flt Owl_const.log10e), a) :: t in
        let input t = a :: t in
        let label = "Log10_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and exp a =
      let ff = function
        | F a -> F A.Scalar.(exp a)
        | Arr a -> Arr A.(exp a)
        | _ -> error_uniop "exp" a
      in
      let fd a = exp a in
      let df cp _ap at = at * cp in
      let r a =
        let reverse ap aa t = (!aa * ap, a) :: t in
        let input t = a :: t in
        let label = "Exp_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and sin a =
      let ff = function
        | F a -> F A.Scalar.(sin a)
        | Arr a -> Arr A.(sin a)
        | _ -> error_uniop "sin" a
      in
      let fd a = sin a in
      let df _cp ap at = at * cos ap in
      let r a =
        let reverse _ap aa t = (!aa * cos (primal a), a) :: t in
        let input t = a :: t in
        let label = "Sin_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and cos a =
      let ff = function
        | F a -> F A.Scalar.(cos a)
        | Arr a -> Arr A.(cos a)
        | _ -> error_uniop "cos" a
      in
      let fd a = cos a in
      let df _cp ap at = neg (at * sin ap) in
      let r a =
        let reverse _ap aa t = (!aa * neg (sin (primal a)), a) :: t in
        let input t = a :: t in
        let label = "Cos_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and tan a =
      let ff = function
        | F a -> F A.Scalar.(tan a)
        | Arr a -> Arr A.(tan a)
        | _ -> error_uniop "tan" a
      in
      let fd a = tan a in
      let df _cp ap at = at / sqr (cos ap) in
      let r a =
        let reverse _ap aa t = (!aa / sqr (cos (primal a)), a) :: t in
        let input t = a :: t in
        let label = "Tan_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and sinh a =
      let ff = function
        | F a -> F A.Scalar.(sinh a)
        | Arr a -> Arr A.(sinh a)
        | _ -> error_uniop "sinh" a
      in
      let fd a = sinh a in
      let df _cp ap at = at * cosh ap in
      let r a =
        let reverse _ap aa t = (!aa * cosh (primal a), a) :: t in
        let input t = a :: t in
        let label = "Sinh_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and cosh a =
      let ff = function
        | F a -> F A.Scalar.(cosh a)
        | Arr a -> Arr A.(cosh a)
        | _ -> error_uniop "cosh" a
      in
      let fd a = cosh a in
      let df _cp ap at = at * sinh ap in
      let r a =
        let reverse _ap aa t = (!aa * sinh (primal a), a) :: t in
        let input t = a :: t in
        let label = "Cosh_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and tanh a =
      let ff = function
        | F a -> F A.Scalar.(tanh a)
        | Arr a -> Arr A.(tanh a)
        | _ -> error_uniop "tanh" a
      in
      let fd a = tanh a in
      let df _cp ap at = at / sqr (cosh ap) in
      let r a =
        let reverse _ap aa t = (!aa / sqr (cosh (primal a)), a) :: t in
        let input t = a :: t in
        let label = "Tanh_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and asin a =
      let ff = function
        | F a -> F A.Scalar.(asin a)
        | Arr a -> Arr A.(asin a)
        | _ -> error_uniop "asin" a
      in
      let fd a = asin a in
      let df _cp ap at = at / sqrt (pack_flt 1. - sqr ap) in
      let r a =
        let reverse _ap aa t = (!aa / sqrt (pack_flt 1. - sqr (primal a)), a) :: t in
        let input t = a :: t in
        let label = "Asin_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and acos a =
      let ff = function
        | F a -> F A.Scalar.(acos a)
        | Arr a -> Arr A.(acos a)
        | _ -> error_uniop "acos" a
      in
      let fd a = acos a in
      let df _cp ap at = neg at / sqrt (pack_flt 1. - sqr ap) in
      let r a =
        let reverse _ap aa t = (neg !aa / sqrt (pack_flt 1. - sqr (primal a)), a) :: t in
        let input t = a :: t in
        let label = "Acos_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and atan a =
      let ff = function
        | F a -> F A.Scalar.(atan a)
        | Arr a -> Arr A.(atan a)
        | _ -> error_uniop "atan" a
      in
      let fd a = atan a in
      let df _cp ap at = at / (pack_flt 1. + sqr ap) in
      let r a =
        let reverse _ap aa t = (!aa / (pack_flt 1. + sqr (primal a)), a) :: t in
        let input t = a :: t in
        let label = "Atan_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and asinh a =
      let ff = function
        | F a -> F A.Scalar.(asinh a)
        | Arr a -> Arr A.(asinh a)
        | _ -> error_uniop "asinh" a
      in
      let fd a = asinh a in
      let df _cp ap at = at / sqrt (sqr ap + pack_flt 1.) in
      let r a =
        let reverse _ap aa t = (!aa / sqrt (sqr (primal a) + pack_flt 1.), a) :: t in
        let input t = a :: t in
        let label = "Asinh_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and acosh a =
      let ff = function
        | F a -> F A.Scalar.(acosh a)
        | Arr a -> Arr A.(acosh a)
        | _ -> error_uniop "acosh" a
      in
      let fd a = acosh a in
      let df _cp ap at = at / sqrt (sqr ap - pack_flt 1.) in
      let r a =
        let reverse _ap aa t = (!aa / sqrt (sqr (primal a) - pack_flt 1.), a) :: t in
        let input t = a :: t in
        let label = "Acosh_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and atanh a =
      let ff = function
        | F a -> F A.Scalar.(atanh a)
        | Arr a -> Arr A.(atanh a)
        | _ -> error_uniop "atanh" a
      in
      let fd a = atanh a in
      let df _cp ap at = at / (pack_flt 1. - sqr ap) in
      let r a =
        let reverse _ap aa t = (!aa / (pack_flt 1. - sqr (primal a)), a) :: t in
        let input t = a :: t in
        let label = "Atanh_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    (* pair inputs single output operations *)
    and ( + ) a b = add a b

    and add a b =
      build_piso
        (module struct
          let label = "add"
          let ff_aa a b = F A.Scalar.(add a b)
          let ff_ab a b = Arr A.(scalar_add a b)
          let ff_ba a b = Arr A.(add_scalar a b)
          let ff_bb a b = Arr A.(add a b)
          let df_da _cp _ap at = at
          let df_db _cp _bp bt = bt
          let df_dab _cp _ap at _bp bt = at + bt
          let dr_ab _ap aa = aa, aa
          let dr_a _ap aa = aa
          let dr_b _ap aa = aa
        end
        : Piso)
        a
        b


    and ( - ) a b = sub a b

    and sub a b =
      build_piso
        (module struct
          let label = "sub"
          let ff_aa a b = F A.Scalar.(sub a b)
          let ff_ab a b = Arr A.(scalar_sub a b)
          let ff_ba a b = Arr A.(sub_scalar a b)
          let ff_bb a b = Arr A.(sub a b)
          let df_da _cp _ap at = at
          let df_db _cp _bp bt = bt
          let df_dab _cp _ap at _bp bt = at - bt
          let dr_ab _ap aa = aa, neg aa
          let dr_a _ap aa = aa
          let dr_b _ap aa = neg aa
        end
        : Piso)
        a
        b


    and ( * ) a b = mul a b

    and mul a b =
      build_piso
        (module struct
          let label = "mul"
          let ff_aa a b = F A.Scalar.(mul a b)
          let ff_ab a b = Arr A.(scalar_mul a b)
          let ff_ba a b = Arr A.(mul_scalar a b)
          let ff_bb a b = Arr A.(mul a b)
          let df_da _cp _ap at = at * b
          let df_db _cp _bp bt = a * bt
          let df_dab _cp ap at bp bt = (ap * bt) + (at * bp)
          let dr_ab _cp aa = aa * primal b, aa * primal a
          let dr_a _ap aa = aa * primal b
          let dr_b _ap aa = aa * primal a
        end
        : Piso)
        a
        b


    and ( / ) a b = div a b

    and div a b =
      let ff a b =
        match a, b with
        | F a, F b -> F A.Scalar.(div a b)
        | F a, Arr b -> Arr A.(scalar_div a b)
        | Arr a, F b -> Arr A.(div_scalar a b)
        | Arr a, Arr b -> Arr A.(div a b)
        | _ -> error_binop "( / )" a b
      in
      let fd a b = a / b in
      let df_da _cp _ap at = at / b in
      let df_db cp bp bt = neg bt * cp / bp in
      let df_dab cp _ap at bp bt = (at - (bt * cp)) / bp in
      let r_d_d a b =
        let reverse _ap aa t =
          (!aa / primal b, a) :: (!aa * (neg (primal a) / (primal b * primal b)), b) :: t
        in
        let input t = a :: b :: t in
        let label = "Div_D_D", [ a; b ] in
        reverse, input, label
      in
      let r_d_c a b =
        let reverse _ap aa t = (!aa / primal b, a) :: t in
        let input t = a :: t in
        let label = "Div_D_C", [ a; b ] in
        reverse, input, label
      in
      let r_c_d a b =
        let reverse _ap aa t =
          (!aa * (neg (primal a) / (primal b * primal b)), b) :: t
        in
        let input t = b :: t in
        let label = "Div_C_D", [ a; b ] in
        reverse, input, label
      in
      op_p_s a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d


    and ( ** ) a b = pow a b

    and pow a b =
      let ff a b =
        match a, b with
        | F a, F b -> F A.Scalar.(pow a b)
        | F a, Arr b -> Arr A.(scalar_pow a b)
        | Arr a, F b -> Arr A.(pow_scalar a b)
        | Arr a, Arr b -> Arr A.(pow a b)
        | _ -> error_binop "( ** )" a b
      in
      let fd a b = a ** b in
      let df_da _cp ap at = at * (ap ** (b - pack_flt 1.)) * b in
      let df_db cp _bp bt = bt * cp * log a in
      let df_dab _cp ap at bp bt =
        (ap ** (bp - pack_flt 1.)) * ((at * bp) + (ap * bt * log ap))
      in
      let r_d_d a b =
        let reverse _ap aa t =
          (!aa * (primal a ** (primal b - pack_flt 1.)) * primal b, a)
          :: (!aa * (primal a ** primal b) * log (primal a), b)
          :: t
        in
        let input t = a :: b :: t in
        let label = "Pow_D_D", [ a; b ] in
        reverse, input, label
      in
      let r_d_c a b =
        let reverse _ap aa t =
          (!aa * (primal a ** (primal b - pack_flt 1.)) * primal b, a) :: t
        in
        let input t = a :: t in
        let label = "Pow_D_C", [ a; b ] in
        reverse, input, label
      in
      let r_c_d a b =
        let reverse _ap aa t = (!aa * (primal a ** primal b) * log (primal a), b) :: t in
        let input t = b :: t in
        let label = "Pow_C_D", [ a; b ] in
        reverse, input, label
      in
      op_p_s a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d


    and atan2 a b =
      let ff a b =
        match a, b with
        | F a, F b -> F A.Scalar.(atan2 a b)
        | F a, Arr b -> Arr A.(scalar_atan2 a b)
        | Arr a, F b -> Arr A.(atan2_scalar a b)
        | Arr a, Arr b -> Arr A.(atan2 a b)
        | _ -> error_binop "atan2" a b
      in
      let fd a b = atan2 a b in
      let df_da _cp ap at = at * b / (sqr ap + sqr b) in
      let df_db _cp bp bt = neg bt * a / (sqr a + sqr bp) in
      let df_dab _cp ap at bp bt = ((at * bp) - (bt * ap)) / (sqr ap + sqr bp) in
      let r_d_d a b =
        let reverse _ap aa t =
          let d = sqr (primal a) + sqr (primal b) in
          (!aa * primal b / d, a) :: (!aa * neg (primal a) / d, b) :: t
        in
        let input t = a :: b :: t in
        let label = "Atan2_D_D", [ a; b ] in
        reverse, input, label
      in
      let r_d_c a b =
        let reverse _ap aa t =
          let d = sqr (primal a) + sqr (primal b) in
          (!aa * primal b / d, a) :: t
        in
        let input t = a :: t in
        let label = "Atan2_D_C", [ a; b ] in
        reverse, input, label
      in
      let r_c_d a b =
        let reverse _ap aa t =
          let d = sqr (primal a) + sqr (primal b) in
          (!aa * neg (primal a) / d, b) :: t
        in
        let input t = b :: t in
        let label = "Atan2_C_D", [ a; b ] in
        reverse, input, label
      in
      op_p_s a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d


    and min2 a b = (a + b - abs (a - b)) / pack_flt 2.
    and max2 a b = (a + b + abs (b - a)) / pack_flt 2.

    and get_item a i j =
      match a with
      | Arr ap -> F (A.get ap [| i; j |])
      | DF (ap, at, ai) -> DF (get_item ap i j, get_item at i j, ai)
      | DR (ap, _, _, _, ai, _) ->
        let reverse _ap aa t = (set_item (zero a) i j (sum' !aa), a) :: t in
        let input t = a :: t in
        let label = "Get_Item", [ a ] in
        DR (get_item ap i j, ref (pack_flt 0.), (reverse, input, label), ref 0, ai, ref 0)
      | _ -> error_uniop "get_item" a


    and set_item a i j b =
      let ff a b =
        match a, b with
        | Arr a, F b ->
          let aa = A.copy a in
          A.set aa [| i; j |] b;
          Arr aa
        | _ -> error_uniop "set_item" a
      in
      let fd a b = set_item a i j b in
      let df_da _cp _ap at = set_item at i j (pack_flt 0.) in
      let df_db _cp _bp bt = add_item (zero a) i j bt in
      let df_dab _cp _ap at _bp bt = set_item at i j bt in
      let r_d_d a b =
        let reverse _ap aa t =
          (set_item !aa i j (pack_flt 0.), a) :: (get_item !aa i j, b) :: t
        in
        let input t = a :: b :: t in
        let label = "SetI_D_D", [ a; b ] in
        reverse, input, label
      in
      let r_d_c a b =
        let reverse _ap aa t = (set_item !aa i j (pack_flt 0.), a) :: t in
        let input t = a :: t in
        let label = "SetI_D_C", [ a; b ] in
        reverse, input, label
      in
      let r_c_d a b =
        let reverse _ap aa t = (get_item !aa i j, b) :: t in
        let input t = b :: t in
        let label = "SetI_C_D", [ a; b ] in
        reverse, input, label
      in
      op_p_s a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d


    and add_item a i j b =
      let ff a b =
        match a, b with
        | Arr a, F b ->
          let aa = A.copy a in
          A.set aa [| i; j |] A.Scalar.(add (A.get aa [| i; j |]) b);
          Arr aa
        | _ -> error_binop "add_item" a b
      in
      let fd a b = add_item a i j b in
      let df_da _cp _ap at = at in
      let df_db _cp _bp bt = add_item (zero a) i j bt in
      let df_dab _cp _ap at _bp bt = add_item at i j bt in
      let r_d_d a b =
        let reverse _ap aa t = (!aa, a) :: (get_item !aa i j, b) :: t in
        let input t = a :: b :: t in
        let label = "AddI_D_D", [ a; b ] in
        reverse, input, label
      in
      let r_d_c a b =
        let reverse _ap aa t = (!aa, a) :: t in
        let input t = a :: t in
        let label = "AddI_D_C", [ a; b ] in
        reverse, input, label
      in
      let r_c_d a b =
        let reverse _ap aa t = (get_item !aa i j, b) :: t in
        let input t = b :: t in
        let label = "AddI_C_D", [ a; b ] in
        reverse, input, label
      in
      op_p_s a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d


    and get_slice i a =
      let ff = function
        | Arr a -> Arr A.(get_slice i a)
        | _ -> error_uniop "slice" a
      in
      let fd a = get_slice i a in
      let df _cp _ap at = get_slice i at in
      let r a =
        let reverse _ap aa t = (set_slice i (zero a) !aa, a) :: t in
        let input t = a :: t in
        let label = "Get_Slice_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and set_slice i a b =
      let ff a b =
        match a, b with
        | Arr a, Arr b ->
          let a = A.copy a in
          A.(set_slice i a b);
          Arr a
        | _ -> error_binop "set_slice" a b
      in
      let fd a b = set_slice i a b in
      let df_da _cp _ap at = set_slice i at (zero b) in
      let df_db _cp _bp bt = set_slice i (zero a) bt in
      let df_dab _cp _ap at _bp bt = set_slice i at bt in
      let r_d_d a b =
        let reverse _ap aa t =
          (set_slice i !aa (zero b), a) :: (get_slice i !aa, b) :: t
        in
        let input t = a :: b :: t in
        let label = "Set_Slice_D_D", [ a; b ] in
        reverse, input, label
      in
      let r_d_c a b =
        let reverse _ap aa t = (set_slice i !aa (zero b), a) :: t in
        let input t = a :: t in
        let label = "Set_Slice_D_C", [ a; b ] in
        reverse, input, label
      in
      let r_c_d a b =
        let reverse _ap aa t = (get_slice i !aa, b) :: t in
        let input t = b :: t in
        let label = "Set_Slice_C_D", [ a; b ] in
        reverse, input, label
      in
      op_p_s a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d


    and sum' a =
      let ff = function
        | F a -> F a
        | Arr a -> F A.(sum' a)
        | _ -> error_uniop "sum" a
      in
      let fd a = sum' a in
      let df _cp _ap at = sum' at in
      let r a =
        let reverse _ap aa t = (!aa, a) :: t in
        let input t = a :: t in
        let label = "Sum_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and sum ?(axis = -1) a =
      let ff = function
        | F a -> F a
        | Arr a -> Arr A.(sum ~axis a)
        | _ -> error_uniop "sum" a
      in
      let fd a = sum ~axis a in
      let df _cp _ap at = sum ~axis at in
      let r a =
        let reverse _ap aa t =
          let s = shape a in
          let reps = Array.(make (length s) 1) in
          reps.(axis) <- s.(axis);
          (repeat !aa reps, a) :: t
        in
        let input t = a :: t in
        let label = "Sum_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and sum_reduce ?(axis = [| 0 |]) a =
      let ff = function
        | F a -> F a
        | Arr x -> Arr A.(sum_reduce ~axis x)
        | _ -> error_uniop "sum_reduce" a
      in
      let fd a = sum_reduce ~axis a in
      let df _cp _ap at = sum_reduce ~axis at in
      let r a =
        let reverse _ap aa t =
          let s = shape a in
          let reps = Array.(make (length s) 1) in
          Array.iter (fun j -> reps.(j) <- s.(j)) axis;
          (repeat !aa reps, a) :: t
        in
        let input t = a :: t in
        let label = "Sum__D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and mean a = sum' a / F (numel a |> float_of_int |> A.float_to_elt)
    and ( *@ ) a b = dot a b

    and dot a b =
      let ff a b =
        match a, b with
        | Arr a, Arr b -> Arr A.(dot a b)
        | _ -> error_binop "( *@ )" a b
      in
      let fd a b = a *@ b in
      let df_da _cp _ap at = at *@ b in
      let df_db _cp _bp bt = a *@ bt in
      let df_dab _cp ap at bp bt = (ap *@ bt) + (at *@ bp) in
      let r_d_d a b =
        let reverse _ap aa t =
          (dot !aa (transpose (primal b)), a) :: (dot (transpose (primal a)) !aa, b) :: t
        in
        let input t = a :: b :: t in
        let label = "Dot_D_D", [ a; b ] in
        reverse, input, label
      in
      let r_d_c a b =
        let reverse _ap aa t = (dot !aa (transpose (primal b)), a) :: t in
        let input t = a :: t in
        let label = "Dot_D_C", [ a; b ] in
        reverse, input, label
      in
      let r_c_d a b =
        let reverse _ap aa t = (dot (transpose (primal a)) !aa, b) :: t in
        let input t = b :: t in
        let label = "Dot_C_D", [ a; b ] in
        reverse, input, label
      in
      op_p_s a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d


    and transpose a =
      let ff = function
        | Arr a -> Arr A.(transpose a)
        | _ -> error_uniop "transpose" a
      in
      let fd a = transpose a in
      let df _cp _ap at = transpose at in
      let r a =
        let reverse _ap aa t = (transpose !aa, a) :: t in
        let input t = a :: t in
        let label = "Trans_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and l1norm' a =
      let ff = function
        | Arr a -> F A.(l1norm' a)
        | _ -> error_uniop "l1norm'" a
      in
      let fd a = l1norm' a in
      let df _cp ap at = at * signum ap in
      let r a =
        let reverse _ap aa t = (!aa * signum (primal a), a) :: t in
        let input t = a :: t in
        let label = "L1Norm_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and l2norm' a =
      let ff = function
        | Arr a -> F A.(l2norm' a)
        | _ -> error_uniop "l2norm'" a
      in
      let fd a = l2norm' a in
      let df cp ap at = ap * at / cp in
      let r a =
        let reverse ap aa t = (!aa / ap * primal a, a) :: t in
        let input t = a :: t in
        let label = "L2Norm_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and l2norm_sqr' a =
      let ff = function
        | F a -> F A.Scalar.(sqr a)
        | Arr a -> F A.(l2norm_sqr' a)
        | _ -> error_uniop "l2norm_sqr'" a
      in
      let fd a = l2norm_sqr' a in
      let df _cp ap at = pack_flt 2. * (ap * at) in
      let r a =
        let reverse _ap aa t = (!aa * pack_flt 2. * primal a, a) :: t in
        let input t = a :: t in
        let label = "L2NormS_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and sigmoid a =
      let ff = function
        | F a -> F A.Scalar.(sigmoid a)
        | Arr a -> Arr A.(sigmoid a)
        | _ -> error_uniop "sigmoid" a
      in
      let fd a = sigmoid a in
      let df cp _ap at = at * cp * (pack_flt 1. - cp) in
      let r a =
        let reverse ap aa t = (!aa * ap * (pack_flt 1. - ap), a) :: t in
        let input t = a :: t in
        let label = "Sigmoid_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and relu a =
      let ff = function
        | F a -> F A.Scalar.(relu a)
        | Arr a -> Arr A.(relu a)
        | _ -> error_uniop "relu" a
      in
      let fd a = relu a in
      let df _cp ap at = at * (pack_flt 1. + signum ap) / pack_flt 2. in
      let r a =
        let reverse _ap aa t =
          (!aa * ((signum (primal a) + pack_flt 1.) / pack_flt 2.), a) :: t
        in
        let input t = a :: t in
        let label = "Relu_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and diag ?(k = 0) a =
      let ff = function
        | Arr a -> Arr A.(diag ~k a |> copy)
        | _ -> error_uniop "diag" a
      in
      let fd a = diag ~k a in
      let df _cp _ap at = diag ~k at in
      let r a =
        let reverse _ap aa t =
          let m = col_num a in
          let l = Pervasives.(m - k) in
          let rec accu i a_ =
            if i < l
            then accu (succ i) (set_item a_ i Pervasives.(k + i) (get_item !aa 0 i))
            else a_
          in
          let abar = accu 0 (zero a) in
          (abar, a) :: t
        in
        let input t = a :: t in
        let label = "Diag_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and diagm ?(k = 0) a =
      let ff = function
        | Arr a -> Arr A.(diagm ~k a |> copy)
        | _ -> error_uniop "diagm" a
      in
      let fd a = diagm ~k a in
      let df _cp _ap at = diagm ~k at in
      let r a =
        let reverse _ap aa t = (diag ~k !aa, a) :: t in
        let input t = a :: t in
        let label = "Diagm_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and trace a =
      let ff = function
        | Arr a -> F A.(trace a)
        | _ -> error_uniop "trace" a
      in
      let fd a = trace a in
      let df _cp _ap at = trace at in
      let r a =
        let reverse _ap aa t =
          let m = col_num a in
          let abar = !aa * diagm (pack_arr A.(ones [| 1; m |])) in
          (abar, a) :: t
        in
        let input t = a :: t in
        let label = "Trace_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and triu ?(k = 0) a =
      let ff = function
        | Arr a -> Arr A.(triu ~k a |> copy)
        | _ -> error_uniop "triu" a
      in
      let fd a = triu ~k a in
      let df _cp _ap at = triu ~k at in
      let r a =
        let reverse _ap aa t = (triu ~k !aa, a) :: t in
        let input t = a :: t in
        let label = "Triu_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and tril ?(k = 0) a =
      let ff = function
        | Arr a -> Arr A.(tril ~k a |> copy)
        | _ -> error_uniop "tril" a
      in
      let fd a = tril ~k a in
      let df _cp _ap _at = tril ~k a in
      let r a =
        let reverse _ap aa t = (tril ~k !aa, a) :: t in
        let input t = a :: t in
        let label = "Tril_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and inv a =
      let ff = function
        | Arr a -> Arr A.(inv a)
        | _ -> error_uniop "inv" a
      in
      let fd a = inv a in
      let df cp _ap at = neg cp * at * cp in
      let r a =
        let reverse ap aa t =
          let dpt = transpose ap in
          (neg dpt *@ !aa *@ dpt, a) :: t
        in
        let input t = a :: t in
        let label = "Inv_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and softplus x = log (pack_flt 1. + exp x)
    and softsign x = x / (pack_flt 1. + abs x)

    and softmax ?(axis = -1) x =
      let c = Arr A.(max ~axis (unpack_arr x)) in
      let y = exp (x - c) in
      let a = sum ~axis y in
      y / a


    and cross_entropy x y = x * log y |> sum' |> neg

    and add_row a b i =
      let ff a b =
        match a, b with
        | Arr a, Arr b ->
          A.(
            copy_row_to (add (row a i) b) a i;
            Arr a)
        | _ -> error_binop "add_row" a b
      in
      let fd a b = add_row a b i in
      let df_da _cp _ap at = at in
      let df_db _cp _bp bt = add_row (zero a) bt i in
      let df_dab _cp _ap at _bp bt = add_row at bt i in
      let r_d_d a b =
        let reverse _ap aa t = (!aa, a) :: (get_row !aa i, b) :: t in
        let input t = a :: b :: t in
        let label = "Add_Row_D_D", [ a; b ] in
        reverse, input, label
      in
      let r_d_c a b =
        let reverse _ap aa t = (!aa, a) :: t in
        let input t = a :: t in
        let label = "Add_Row_D_C", [ a; b ] in
        reverse, input, label
      in
      let r_c_d a b =
        let reverse _ap aa t = (get_row !aa i, b) :: t in
        let input t = b :: t in
        let label = "Add_Row_C_D", [ a; b ] in
        reverse, input, label
      in
      op_p_s a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d


    and get_row a i =
      let ff = function
        | Arr a -> Arr A.(row a i |> copy)
        | _ -> error_uniop "get_row" a
      in
      let fd a = get_row a i in
      let df _cp _ap at = get_row at i in
      let r a =
        let reverse _ap aa t =
          adjref a := add_row (adjval a) !aa i;
          (zero a, a) :: t
        in
        let input t = a :: t in
        let label = "Get_Row_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and to_rows a = Array.init (row_num a) (fun i -> get_row a i)

    and of_rows a =
      (* TODO: this can be further optimised by incorporating t array type as t *)
      match a.(0) with
      | Arr _ -> Array.map unpack_arr a |> A.of_rows |> pack_arr
      | DF (_, _, ai) ->
        let ap =
          a |> Array.map (fun x -> x |> primal |> unpack_arr) |> A.of_rows |> pack_arr
        in
        let at =
          a |> Array.map (fun x -> x |> tangent |> unpack_arr) |> A.of_rows |> pack_arr
        in
        DF (ap, at, ai)
      | DR (_, _, _, _, ai, _) ->
        let ap = a |> Array.map (fun x -> x |> primal) in
        let cp = ap |> Array.map (fun x -> x |> unpack_arr) |> A.of_rows |> pack_arr in
        let reverse _ap aa t =
          t |> List.append (a |> Array.to_list |> List.mapi (fun i v -> get_row !aa i, v))
        in
        let input t = List.append (Array.to_list a) t in
        let label = "Of_Rows_D", Array.to_list a in
        DR (cp, ref (zero cp), (reverse, input, label), ref 0, ai, ref 0)
      | _ -> error_uniop "of_rows a.(0)" a.(0)


    and of_arrays a =
      (* mode: 0 constant, 1 reverse, 2 tangent *)
      let mode = ref 0 in
      let idxs = ref [] in
      let ai_ref = ref 0 in
      let cp =
        Array.mapi
          (fun i xs ->
            Array.mapi
              (fun j x ->
                match x, !mode with
                | F _, _ -> unpack_elt x
                | DR (_, _, _, _, ai, _), 0 ->
                  ai_ref := ai;
                  mode := 1;
                  idxs := (i, j) :: !idxs;
                  unpack_elt x
                | DR (_, _, _, _, ai, _), 1 ->
                  ai_ref := ai;
                  idxs := (i, j) :: !idxs;
                  unpack_elt x
                | DF (_, _, ai), 0 ->
                  ai_ref := ai;
                  mode := 1;
                  idxs := (i, j) :: !idxs;
                  unpack_elt x
                | DF (_, _, ai), 2 ->
                  ai_ref := ai;
                  mode := 2;
                  unpack_elt x
                | _, _ -> error_uniop "of_arrays: inconsistent array" x)
              xs)
          a
        |> A.of_arrays
        |> pack_arr
      in
      match !mode with
      | 0 -> cp
      | 1 ->
        let idxs = List.rev !idxs in
        let reverse _ap aa t =
          let aa_arrays = to_arrays !aa in
          t |> List.append (idxs |> List.map (fun (i, j) -> aa_arrays.(i).(j), a.(i).(j)))
        in
        let input t = List.(append (map (fun (i, j) -> a.(i).(j)) idxs) t) in
        let label = "Of_Arrays_D", List.map (fun (i, j) -> a.(i).(j)) idxs in
        DR (cp, ref (zero cp), (reverse, input, label), ref 0, !ai_ref, ref 0)
      | 2 ->
        let at =
          a
          |> Array.map (Array.map (fun x -> x |> tangent |> unpack_elt))
          |> A.of_arrays
          |> pack_arr
        in
        DF (cp, at, !ai_ref)
      | _ -> error_uniop "of_arrays" a.(0).(0)


    and to_arrays a =
      Array.init (row_num a) (fun i -> Array.init (col_num a) (fun j -> get_item a i j))


    and reshape a s =
      let ff = function
        | Arr a -> Arr A.(reshape a s)
        | _ -> error_uniop "reshape" a
      in
      let fd a = reshape a s in
      let df _cp _ap at = reshape at s in
      let r a =
        let reverse _ap aa t = (reshape !aa (shape (primal a)), a) :: t in
        let input t = a :: t in
        let label = "Reshape_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and flatten a = reshape a [| 1; numel a |]

    and concat axis a b =
      let ff a b =
        match a, b with
        | Arr a, Arr b -> Arr A.(concatenate ~axis [| a; b |])
        | _ -> error_binop "concat" a b
      in
      let fd a b = concat axis a b in
      let df_da _cp _ap at = concat axis at (zero b) in
      let df_db _cp _bp bt = concat axis (zero a) bt in
      let df_dab _cp _ap at _bp bt = concat axis at bt in
      let r_d_d a b =
        let reverse _ap aa t =
          let s = split ~axis [| (shape a).(axis); (shape b).(axis) |] !aa in
          (s.(0), a) :: (s.(1), b) :: t
        in
        let input t = a :: b :: t in
        let label = "Concat_D_D", [ a; b ] in
        reverse, input, label
      in
      let r_d_c a b =
        let reverse _ap aa t =
          let s = split ~axis [| (shape a).(axis); (shape b).(axis) |] !aa in
          (s.(0), a) :: t
        in
        let input t = a :: t in
        let label = "Concat_D_C", [ a; b ] in
        reverse, input, label
      in
      let r_c_d a b =
        let reverse _ap aa t =
          let s = split ~axis [| (shape a).(axis); (shape b).(axis) |] !aa in
          (s.(1), b) :: t
        in
        let input t = b :: t in
        let label = "Concat_C_D", [ a; b ] in
        reverse, input, label
      in
      op_p_s a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d


    and split ~axis parts a =
      let ff a =
        match a with
        | Arr a -> A.(split ~axis parts a) |> Array.map (fun x -> Arr x)
        | _ -> error_uniop "split" a
      in
      let fd a = split ~axis parts a in
      let df _cp _ap _at = raise Owl_exception.NOT_IMPLEMENTED in
      let r (a, _cp_arr, aa_arr) =
        let reverse _ap _aa t =
          (concatenate ~axis (Array.map (fun aa -> !aa) aa_arr), a) :: t
        in
        let input t = a :: t in
        let label = "Split_D", [ a ] in
        reverse, input, label
      in
      op_s_m a ff fd df r


    and concatenate ~axis a =
      (* mode: 0 constant, 1 reverse, 2 tangent *)
      let mode = ref 0 in
      let idxs = ref [] in
      let ai_ref = ref 0 in
      let cp =
        Array.mapi
          (fun i x ->
            match x, !mode with
            | Arr _, _ -> unpack_arr x
            | DR (_, _, _, _, ai, _), 0 ->
              ai_ref := ai;
              idxs := i :: !idxs;
              mode := 1;
              unpack_arr x
            | DR (_, _, _, _, ai, _), 1 ->
              ai_ref := ai;
              idxs := i :: !idxs;
              unpack_arr x
            | DF (_, _, ai), 0 ->
              ai_ref := ai;
              unpack_arr x
            | DF (_, _, ai), 2 ->
              ai_ref := ai;
              unpack_arr x
            | _ -> error_uniop "concatenate: inconsistent array" x)
          a
        |> A.concatenate ~axis
        |> pack_arr
      in
      match !mode with
      | 0 -> cp
      | 1 ->
        let idxs = List.rev !idxs in
        let reverse _ap aa t =
          let aa_arr = split ~axis (Array.map (fun x -> (shape x).(axis)) a) !aa in
          t |> List.(append (map (fun i -> aa_arr.(i), a.(i)) idxs))
        in
        let input t = List.append List.(map (fun i -> a.(i)) idxs) t in
        let label = "Concatenate_D", List.(map (fun i -> a.(i)) idxs) in
        DR (cp, ref (zero cp), (reverse, input, label), ref 0, !ai_ref, ref 0)
      | 2 ->
        let at =
          a
          |> Array.map (fun x -> x |> tangent |> unpack_arr)
          |> A.concatenate ~axis
          |> pack_arr
        in
        DF (cp, at, !ai_ref)
      | _ -> error_uniop "concatenate" a.(0)


    and init_2d n_rows n_cols f =
      Array.init n_rows (fun i -> Array.init n_cols (fun j -> f i j)) |> of_arrays
  end

  module Linalg = struct
    open Maths

    let rec noop _ = ()
    and inv = Maths.inv

    and logdet a =
      let ff = function
        | Arr a -> F A.(logdet a)
        | _ -> error_uniop "logdet" a
      in
      let fd a = logdet a in
      let df _cp ap at = trace (transpose (inv ap) *@ at) in
      let r a =
        let reverse _ap aa t = (!aa * transpose (inv (primal a)), a) :: t in
        let input t = a :: t in
        let label = "Logdet_D", [ a ] in
        reverse, input, label
      in
      op_s_s a ff fd df r


    and copyltu x = tril x + transpose (tril ~k:(-1) x)
    and copyutl x = triu x + transpose (triu ~k:1 x)

    and chol =
      let _chol_forward cp at upper =
        let inv_cp = inv cp in
        let tr_inv_cp = transpose inv_cp in
        if upper
        then (
          let x = tr_inv_cp *@ transpose at *@ inv_cp in
          let m = pack_flt 0.5 * tril (triu x) in
          transpose cp *@ (m + triu ~k:1 x))
        else (
          let x = inv_cp *@ at *@ tr_inv_cp in
          let m = pack_flt 0.5 * tril (triu x) in
          cp *@ (m + tril ~k:(-1) x))
      in
      let _chol_backward o aa upper =
        if upper
        then (
          let x = linsolve ~typ:`u o (copyutl (aa *@ transpose o)) in
          let x = linsolve ~typ:`u o (transpose x) in
          pack_flt 0.5 * transpose x)
        else (
          let x = linsolve ~trans:true ~typ:`l o (copyltu (transpose o *@ aa)) in
          let x = linsolve ~trans:true ~typ:`l o (transpose x) in
          pack_flt 0.5 * transpose x)
      in
      fun ?(upper = true) a ->
        build_siso
          (module struct
            let label = "chol"
            let ff_f a = error_uniop "chol" (pack_elt a)
            let ff_arr a = Arr A.(chol ~upper a)
            let df cp _ap at = _chol_forward cp at upper
            let dr ap aa = _chol_backward ap aa upper
          end
          : Siso)
          a


    and qr =
      let _qr_backward (o1, o2) (aa1, aa2) =
        let q = !o1
        and r = !o2
        and qbar = !aa1
        and rbar = !aa2 in
        let m = (rbar *@ transpose r) - (transpose q *@ qbar) in
        linsolve r (transpose (qbar + (q *@ copyutl m))) |> transpose
      in
      fun a ->
        let ff = function
          | Arr a ->
            let q, r = A.(qr a) in
            Arr q, Arr r
          | _ -> error_uniop "qr" a
        in
        let fd a = qr a in
        let df _cp _ap _at = raise Owl_exception.NOT_IMPLEMENTED in
        let r (a, o, aa) =
          let reverse _ap _aa t = (_qr_backward o aa, a) :: t in
          let input t = a :: t in
          let label = "QR_D", [ a ] in
          reverse, input, label
        in
        op_s_p a ff fd df r


    and lq =
      let _lq_backward (o1, o2) (aa1, aa2) =
        let l = !o1
        and q = !o2
        and lbar = !aa1
        and qbar = !aa2 in
        let m = (transpose l *@ lbar) - (qbar *@ transpose q) in
        linsolve ~trans:true ~typ:`l l (qbar + (copyltu m *@ q))
      in
      fun a ->
        let ff = function
          | Arr a ->
            let l, q = A.(lq a) in
            Arr l, Arr q
          | _ -> error_uniop "lq" a
        in
        let fd a = lq a in
        let df _cp _ap _at = raise Owl_exception.NOT_IMPLEMENTED in
        let r (a, o, aa) =
          let reverse _ap _aa t = (_lq_backward o aa, a) :: t in
          let input t = a :: t in
          let label = "LQ_D", [ a ] in
          reverse, input, label
        in
        op_s_p a ff fd df r


    and svd =
      let _svd_backward (o1, o2, o3) (aa1, aa2, aa3) thin =
        let u, s, vt = !o1, !o2, !o3
        and ubar, sbar, vbart = !aa1, !aa2, !aa3 in
        let ut = transpose u
        and v = transpose vt in
        let ubart = transpose ubar
        and vbar = transpose vbart in
        let eye n = A.(ones [| 1; n |]) |> pack_arr |> diagm in
        let e_m = eye (row_num u) in
        let e_n = eye (row_num v) in
        let k = row_num vt in
        let f =
          let s2 = sqr s in
          pack_arr
            A.(
              init_nd [| k; k |] (fun idx ->
                  let i = idx.(0)
                  and j = idx.(1) in
                  if i = j
                  then float_to_elt 0.
                  else (
                    let s2_i = get_item s2 0 i |> unpack_flt in
                    let s2_j = get_item s2 0 j |> unpack_flt in
                    1. /. (s2_j -. s2_i) |> float_to_elt)))
        in
        let inv_s = pack_flt 1. / s in
        if thin
        then
          (u * sbar *@ vt)
          + (((u *@ (f * ((ut *@ ubar) - (ubart *@ u))) * s)
             + ((e_m - (u *@ ut)) *@ ubar * inv_s))
            *@ vt)
          + (u
            *@ ((transpose s * (f * ((vt *@ vbar) - (vbart *@ v))) *@ vt)
               + (transpose inv_s * vbart *@ (e_n - (v *@ vt)))))
        else raise Owl_exception.NOT_IMPLEMENTED
      in
      fun ?(thin = true) a ->
        let ff = function
          | Arr a ->
            let u, s, vt = A.(svd ~thin a) in
            Arr u, Arr s, Arr vt
          | _ -> error_uniop "svd" a
        in
        let fd a = svd ~thin a in
        let df _cp _ap _at = raise Owl_exception.NOT_IMPLEMENTED in
        let r (a, o, aa) =
          let reverse _ap _aa t = (_svd_backward o aa thin, a) :: t in
          let input t = a :: t in
          let label = "SVD_D", [ a ] in
          reverse, input, label
        in
        op_s_t a ff fd df r


    and lyapunov =
      let _lyapunov_backward_a a aa ap =
        let s = lyapunov (transpose a) (neg aa) in
        pack_flt 2. * s *@ ap
      in
      let _lyapunov_backward_q a aa = neg (lyapunov (transpose a) (neg aa)) in
      let _lyapunov_backward_aq a aa ap =
        let s = lyapunov (transpose a) (neg aa) in
        pack_flt 2. * s *@ ap, neg s
      in
      fun a q ->
        let ff a q =
          match a, q with
          | Arr a, Arr q -> Arr A.(lyapunov a q)
          | _ -> error_binop "lyapunov" a q
        in
        let fd a q = lyapunov a q in
        let df_da cp ap at = lyapunov ap (neg ((at *@ cp) + (cp *@ transpose at))) in
        let df_dq _cp _qp qt = lyapunov a (neg qt) in
        let df_daq cp ap at _qp qt =
          lyapunov ap (neg ((at *@ cp) + (cp *@ transpose at))) + lyapunov ap (neg qt)
        in
        let r_d_d a b =
          let reverse ap aa t =
            let abar, qbar = _lyapunov_backward_aq (primal a) !aa ap in
            (abar, a) :: (qbar, q) :: t
          in
          let input t = a :: b :: t in
          let label = "Lyapunov_D_D", [ a; b ] in
          reverse, input, label
        in
        let r_d_c a b =
          let reverse ap aa t = (_lyapunov_backward_a (primal a) !aa ap, a) :: t in
          let input t = a :: t in
          let label = "Lyapunov_D_C", [ a; b ] in
          reverse, input, label
        in
        let r_c_d a b =
          let reverse _ap aa t = (_lyapunov_backward_q (primal a) !aa, q) :: t in
          let input t = b :: t in
          let label = "Lyapunov_C_D", [ a; b ] in
          reverse, input, label
        in
        op_p_s a q ff fd df_da df_dq df_daq r_d_d r_d_c r_c_d


    and discrete_lyapunov =
      let _discrete_lyapunov_backward_a a aa ap =
        let s = discrete_lyapunov (transpose a) aa in
        pack_flt 2. * s *@ a *@ ap
      in
      let _discrete_lyapunov_backward_q a aa = discrete_lyapunov (transpose a) aa in
      let _discrete_lyapunov_backward_aq a aa ap =
        let s = discrete_lyapunov (transpose a) aa in
        pack_flt 2. * s *@ a *@ ap, s
      in
      fun ?(solver = `default) a q ->
        let ff a q =
          match a, q with
          | Arr a, Arr q -> Arr A.(discrete_lyapunov ~solver a q)
          | _ -> error_binop "discrete_lyapunov" a q
        in
        let fd a q = discrete_lyapunov ~solver a q in
        let df_da cp ap at =
          discrete_lyapunov ap ((ap *@ cp *@ transpose at) + (at *@ cp *@ transpose a))
        in
        let df_dq _cp _qp qt = discrete_lyapunov a qt in
        let df_daq cp ap at _qp qt =
          discrete_lyapunov ap ((ap *@ cp *@ transpose at) + (at *@ cp *@ transpose a))
          + discrete_lyapunov ap qt
        in
        let r_d_d a b =
          let reverse ap aa t =
            let abar, qbar = _discrete_lyapunov_backward_aq (primal a) !aa ap in
            (abar, a) :: (qbar, q) :: t
          in
          let input t = a :: b :: t in
          let label = "Discrete_Lyapunov_D_D", [ a; b ] in
          reverse, input, label
        in
        let r_d_c a b =
          let reverse ap aa t =
            (_discrete_lyapunov_backward_a (primal a) !aa ap, a) :: t
          in
          let input t = a :: t in
          let label = "Discrete_Lyapunov_D_C", [ a; b ] in
          reverse, input, label
        in
        let r_c_d a b =
          let reverse _ap aa t =
            (_discrete_lyapunov_backward_q (primal a) !aa, q) :: t
          in
          let input t = b :: t in
          let label = "Discrete_Lyapunov_C_D", [ a; b ] in
          reverse, input, label
        in
        op_p_s a q ff fd df_da df_dq df_daq r_d_d r_d_c r_c_d


    and ( /@ ) a b = linsolve ~trans:false ~typ:`n a b

    and linsolve =
      let _linsolve_backward_b trans typ a cbar =
        linsolve ~trans:(not trans) ~typ (primal a) cbar
      in
      let _linsolve_backward_a trans typ cp bbar =
        let abar = neg bbar *@ transpose cp in
        let abar = if trans then transpose abar else abar in
        match typ with
        | `n -> abar
        | `u -> triu abar
        | `l -> tril abar
      in
      fun ?(trans = false) ?(typ = `n) a b ->
        let ff a b =
          match a, b with
          | Arr a, Arr b -> Arr A.(linsolve ~trans ~typ a b)
          | _ -> error_binop "linsolve" a b
        in
        let fd a b = linsolve ~trans ~typ a b in
        let df_da cp ap at =
          linsolve ~trans ap (if trans then neg (transpose at) *@ cp else neg at *@ cp)
        in
        let df_db _cp _bp bt = linsolve ~trans a bt in
        let df_dab cp ap at _bp bt =
          linsolve
            ~trans
            ap
            (if trans then bt - (transpose at *@ cp) else bt - (at *@ cp))
        in
        let r_d_d a b =
          let reverse ap aa t =
            let bbar = _linsolve_backward_b trans typ a !aa in
            let abar = _linsolve_backward_a trans typ ap bbar in
            (abar, a) :: (bbar, b) :: t
          in
          let input t = a :: b :: t in
          let label = "Linsolve_D_D", [ a; b ] in
          reverse, input, label
        in
        let r_d_c a b =
          let reverse ap aa t =
            let bbar = _linsolve_backward_b trans typ a !aa in
            let abar = _linsolve_backward_a trans typ ap bbar in
            (abar, a) :: t
          in
          let input t = a :: t in
          let label = "Linsolve_D_C", [ a; b ] in
          reverse, input, label
        in
        let r_c_d a b =
          let reverse _ap aa t = (_linsolve_backward_b trans typ a !aa, b) :: t in
          let input t = b :: t in
          let label = "Linsolve_C_D", [ a; b ] in
          reverse, input, label
        in
        op_p_s a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d
  end

  (* neural network module: for specialised neural network operations *)
  module NN = struct
    open Maths

    (* NOTE: these fucntions are for neural network. There are many restrictions at the
       moment. E.g. they do not support higher-order derivatives, and some do not support
       forward mode, so use them when you know what you are doing. *)

    let rec noop _ = ()

    and dropout ?(rate = 0.5) a =
      let p = A.float_to_elt (1. -. rate) in
      let b =
        match primal' a with
        | Arr a -> Arr (A.bernoulli ~p (A.shape a))
        | _ -> error_uniop "dropout" a
      in
      a * b


    (* a:input; b:kernel; s:stride *)
    and conv1d =
      (* a:input; b:kernel; s:stride; o:output' *)
      let conv1d_backward_input a b s o =
        let a = unpack_arr a in
        let b = unpack_arr b in
        let o = unpack_arr o in
        A.conv1d_backward_input a b s o |> pack_arr
      in
      (* a:input; b:kernel; s:stride; o:output' *)
      let conv1d_backward_kernel a b s o =
        let a = unpack_arr a in
        let b = unpack_arr b in
        let o = unpack_arr o in
        A.conv1d_backward_kernel a b s o |> pack_arr
      in
      fun ?padding a b s ->
        let ff a b =
          match a, b with
          | Arr a, Arr b -> Arr A.(conv1d ?padding a b s)
          | _ -> error_binop "conv1d" a b
        in
        let fd a b = conv1d ?padding a b s in
        (* FIXME: df_da, df_db, df_dab are not correct ... do not use *)
        let df_da _cp _ap at = at in
        let df_db _cp _bp bt = bt in
        let df_dab _cp _ap at _bp bt = at + bt in
        let r_d_d a b =
          let reverse _ap aa t =
            (conv1d_backward_input a b s !aa, a)
            :: (conv1d_backward_kernel a b s !aa, b)
            :: t
          in
          let input t = a :: b :: t in
          let label = "Conv1D_D_D", [ a; b ] in
          reverse, input, label
        in
        let r_d_c a b =
          let reverse _ap aa t = (conv1d_backward_input a b s !aa, a) :: t in
          let input t = a :: t in
          let label = "Conv1D_D_C", [ a; b ] in
          reverse, input, label
        in
        let r_c_d a b =
          let reverse _ap aa t = (conv1d_backward_kernel a b s !aa, b) :: t in
          let input t = b :: t in
          let label = "Conv1D_C_D", [ a; b ] in
          reverse, input, label
        in
        op_p_s a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d


    (* a:input; b:kernel; s:stride *)
    and conv2d =
      (* a:input; b:kernel; s:stride; o:output' *)
      let conv2d_backward_input a b s o =
        let a = unpack_arr a in
        let b = unpack_arr b in
        let o = unpack_arr o in
        A.conv2d_backward_input a b s o |> pack_arr
      in
      (* a:input; b:kernel; s:stride; o:output' *)
      let conv2d_backward_kernel a b s o =
        let a = unpack_arr a in
        let b = unpack_arr b in
        let o = unpack_arr o in
        A.conv2d_backward_kernel a b s o |> pack_arr
      in
      fun ?padding a b s ->
        let ff a b =
          match a, b with
          | Arr a, Arr b -> Arr A.(conv2d ?padding a b s)
          | _ -> error_binop "conv2d" a b
        in
        let fd a b = conv2d ?padding a b s in
        (* FIXME: df_da, df_db, df_dab are not correct ... do not use *)
        let df_da _cp _ap at = at in
        let df_db _cp _bp bt = bt in
        let df_dab _cp _ap at _bp bt = at + bt in
        let r_d_d a b =
          let reverse _ap aa t =
            (conv2d_backward_input a b s !aa, a)
            :: (conv2d_backward_kernel a b s !aa, b)
            :: t
          in
          let input t = a :: b :: t in
          let label = "Conv2D_D_D", [ a; b ] in
          reverse, input, label
        in
        let r_d_c a b =
          let reverse _ap aa t = (conv2d_backward_input a b s !aa, a) :: t in
          let input t = a :: t in
          let label = "Conv2D_D_C", [ a; b ] in
          reverse, input, label
        in
        let r_c_d a b =
          let reverse _ap aa t = (conv2d_backward_kernel a b s !aa, b) :: t in
          let input t = b :: t in
          let label = "Conv2D_C_D", [ a; b ] in
          reverse, input, label
        in
        op_p_s a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d


    (* a:input; b:kernel; s:stride *)
    and conv3d =
      (* a:input; b:kernel; s:stride; o:output' *)
      let conv3d_backward_input a b s o =
        let a = unpack_arr a in
        let b = unpack_arr b in
        let o = unpack_arr o in
        A.conv3d_backward_input a b s o |> pack_arr
      (* a:input; b:kernel; s:stride; o:output' *)
      and conv3d_backward_kernel a b s o =
        let a = unpack_arr a in
        let b = unpack_arr b in
        let o = unpack_arr o in
        A.conv3d_backward_kernel a b s o |> pack_arr
      in
      fun ?padding a b s ->
        let ff a b =
          match a, b with
          | Arr a, Arr b -> Arr A.(conv3d ?padding a b s)
          | _ -> error_binop "conv3d" a b
        in
        let fd a b = conv3d ?padding a b s in
        (* FIXME: df_da, df_db, df_dab are not correct ... do not use *)
        let df_da _cp _ap at = at in
        let df_db _cp _bp bt = bt in
        let df_dab _cp _ap at _bp bt = at + bt in
        let r_d_d a b =
          let reverse _ap aa t =
            (conv3d_backward_input a b s !aa, a)
            :: (conv3d_backward_kernel a b s !aa, b)
            :: t
          in
          let input t = a :: b :: t in
          let label = "Conv3D_D_D", [ a; b ] in
          reverse, input, label
        in
        let r_d_c a b =
          let reverse _ap aa t = (conv3d_backward_input a b s !aa, a) :: t in
          let input t = a :: t in
          let label = "Conv3D_D_C", [ a; b ] in
          reverse, input, label
        in
        let r_c_d a b =
          let reverse _ap aa t = (conv3d_backward_kernel a b s !aa, b) :: t in
          let input t = b :: t in
          let label = "Conv3D_C_D", [ a; b ] in
          reverse, input, label
        in
        op_p_s a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d


    (* a:input; b:kernel; s:stride; r:rate *)
    and dilated_conv1d =
      (* a:input; b:kernel; o:output'; s:stride; r:rate *)
      let dilated_conv1d_backward_input a b s r o =
        let a = unpack_arr a in
        let b = unpack_arr b in
        let o = unpack_arr o in
        A.dilated_conv1d_backward_input a b s r o |> pack_arr
      (* a:input; b:kernel; o:output'; s:stride; r:rate *)
      and dilated_conv1d_backward_kernel a b s r o =
        let a = unpack_arr a in
        let b = unpack_arr b in
        let o = unpack_arr o in
        A.dilated_conv1d_backward_kernel a b s r o |> pack_arr
      in
      fun ?padding a b s r ->
        let ff a b =
          match a, b with
          | Arr a, Arr b -> Arr A.(dilated_conv1d ?padding a b s r)
          | _ -> error_binop "dilated_conv1d" a b
        in
        let fd a b = dilated_conv1d ?padding a b s r in
        (* FIXME: df_da, df_db, df_dab are not correct ... do not use *)
        let df_da _cp _ap at = at in
        let df_db _cp _bp bt = bt in
        let df_dab _cp _ap at _bp bt = at + bt in
        let r_d_d a b =
          let reverse _ap aa t =
            (dilated_conv1d_backward_input a b s r !aa, a)
            :: (dilated_conv1d_backward_kernel a b s r !aa, b)
            :: t
          in
          let input t = a :: b :: t in
          let label = "Di_Conv1D_D_D", [ a; b ] in
          reverse, input, label
        in
        let r_d_c a b =
          let reverse _ap aa t = (dilated_conv1d_backward_input a b s r !aa, a) :: t in
          let input t = a :: t in
          let label = "Di_Conv1D_D_C", [ a; b ] in
          reverse, input, label
        in
        let r_c_d a b =
          let reverse _ap aa t = (dilated_conv1d_backward_kernel a b s r !aa, b) :: t in
          let input t = b :: t in
          let label = "Di_Conv1D_C_D", [ a; b ] in
          reverse, input, label
        in
        op_p_s a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d


    (* a:input; b:kernel; s:stride; r:rate *)
    and dilated_conv2d =
      (* a:input; b:kernel; o:output'; s:stride; r:rate *)
      let dilated_conv2d_backward_input a b s r o =
        let a = unpack_arr a in
        let b = unpack_arr b in
        let o = unpack_arr o in
        A.dilated_conv2d_backward_input a b s r o |> pack_arr
      (* a:input; b:kernel; o:output'; s:stride; r:rate *)
      and dilated_conv2d_backward_kernel a b s r o =
        let a = unpack_arr a in
        let b = unpack_arr b in
        let o = unpack_arr o in
        A.dilated_conv2d_backward_kernel a b s r o |> pack_arr
      in
      fun ?padding a b s r ->
        let ff a b =
          match a, b with
          | Arr a, Arr b -> Arr A.(dilated_conv2d ?padding a b s r)
          | _ -> error_binop "dilated_conv2d" a b
        in
        let fd a b = dilated_conv2d ?padding a b s r in
        (* FIXME: df_da, df_db, df_dab are not correct ... do not use *)
        let df_da _cp _ap at = at in
        let df_db _cp _bp bt = bt in
        let df_dab _cp _ap at _bp bt = at + bt in
        let r_d_d a b =
          let reverse _ap aa t =
            (dilated_conv2d_backward_input a b s r !aa, a)
            :: (dilated_conv2d_backward_kernel a b s r !aa, b)
            :: t
          in
          let input t = a :: b :: t in
          let label = "Di_Conv2D_D_D", [ a; b ] in
          reverse, input, label
        in
        let r_d_c a b =
          let reverse _ap aa t = (dilated_conv2d_backward_input a b s r !aa, a) :: t in
          let input t = a :: t in
          let label = "Di_Conv2D_D_C", [ a; b ] in
          reverse, input, label
        in
        let r_c_d a b =
          let reverse _ap aa t = (dilated_conv2d_backward_kernel a b s r !aa, b) :: t in
          let input t = b :: t in
          let label = "Di_Conv2D_C_D", [ a; b ] in
          reverse, input, label
        in
        op_p_s a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d


    (* a:input; b:kernel; s:stride; r:rate *)
    and dilated_conv3d =
      (* a:input; b:kernel; o:output'; s:stride; r:rate *)
      let dilated_conv3d_backward_input a b s r o =
        let a = unpack_arr a in
        let b = unpack_arr b in
        let o = unpack_arr o in
        A.dilated_conv3d_backward_input a b s r o |> pack_arr
      (* a:input; b:kernel; o:output'; s:stride; r:rate *)
      and dilated_conv3d_backward_kernel a b s r o =
        let a = unpack_arr a in
        let b = unpack_arr b in
        let o = unpack_arr o in
        A.dilated_conv3d_backward_kernel a b s r o |> pack_arr
      in
      fun ?padding a b s r ->
        let ff a b =
          match a, b with
          | Arr a, Arr b -> Arr A.(dilated_conv3d ?padding a b s r)
          | _ -> error_binop "dilated_conv3d" a b
        in
        let fd a b = dilated_conv3d ?padding a b s r in
        (* FIXME: df_da, df_db, df_dab are not correct ... do not use *)
        let df_da _cp _ap at = at in
        let df_db _cp _bp bt = bt in
        let df_dab _cp _ap at _bp bt = at + bt in
        let r_d_d a b =
          let reverse _ap aa t =
            (dilated_conv3d_backward_input a b s r !aa, a)
            :: (dilated_conv3d_backward_kernel a b s r !aa, b)
            :: t
          in
          let input t = a :: b :: t in
          let label = "Di_Conv3D_D_D", [ a; b ] in
          reverse, input, label
        in
        let r_d_c a b =
          let reverse _ap aa t = (dilated_conv3d_backward_input a b s r !aa, a) :: t in
          let input t = a :: t in
          let label = "Di_Conv3D_D_C", [ a; b ] in
          reverse, input, label
        in
        let r_c_d a b =
          let reverse _ap aa t = (dilated_conv3d_backward_kernel a b s r !aa, b) :: t in
          let input t = b :: t in
          let label = "Di_Conv3D_C_D", [ a; b ] in
          reverse, input, label
        in
        op_p_s a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d


    (* a:input; b:kernel; s:stride *)
    and transpose_conv1d =
      (* a:input; b:kernel; s:stride; o:output' *)
      let transpose_conv1d_backward_input a b s o =
        let a = unpack_arr a in
        let b = unpack_arr b in
        let o = unpack_arr o in
        A.transpose_conv1d_backward_input a b s o |> pack_arr
      (* a:input; b:kernel; s:stride; o:output' *)
      and transpose_conv1d_backward_kernel a b s o =
        let a = unpack_arr a in
        let b = unpack_arr b in
        let o = unpack_arr o in
        A.transpose_conv1d_backward_kernel a b s o |> pack_arr
      in
      fun ?padding a b s ->
        let ff a b =
          match a, b with
          | Arr a, Arr b -> Arr A.(transpose_conv1d ?padding a b s)
          | _ -> error_binop "transpose_conv1d" a b
        in
        let fd a b = transpose_conv1d ?padding a b s in
        (* FIXME: df_da, df_db, df_dab are not correct ... do not use *)
        let df_da _cp _ap at = at in
        let df_db _cp _bp bt = bt in
        let df_dab _cp _ap at _bp bt = at + bt in
        let r_d_d a b =
          let reverse _ap aa t =
            (transpose_conv1d_backward_input a b s !aa, a)
            :: (transpose_conv1d_backward_kernel a b s !aa, b)
            :: t
          in
          let input t = a :: b :: t in
          let label = "Tr_Conv1D_D_D", [ a; b ] in
          reverse, input, label
        in
        let r_d_c a b =
          let reverse _ap aa t = (transpose_conv1d_backward_input a b s !aa, a) :: t in
          let input t = a :: t in
          let label = "Tr_Conv1D_D_C", [ a; b ] in
          reverse, input, label
        in
        let r_c_d a b =
          let reverse _ap aa t = (transpose_conv1d_backward_kernel a b s !aa, b) :: t in
          let input t = b :: t in
          let label = "Tr_Conv1D_C_D", [ a; b ] in
          reverse, input, label
        in
        op_p_s a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d


    (* a:input; b:kernel; s:stride *)
    and transpose_conv2d =
      (* a:input; b:kernel; s:stride; o:output' *)
      let transpose_conv2d_backward_input a b s o =
        let a = unpack_arr a in
        let b = unpack_arr b in
        let o = unpack_arr o in
        A.transpose_conv2d_backward_input a b s o |> pack_arr
      (* a:input; b:kernel; s:stride; o:output' *)
      and transpose_conv2d_backward_kernel a b s o =
        let a = unpack_arr a in
        let b = unpack_arr b in
        let o = unpack_arr o in
        A.transpose_conv2d_backward_kernel a b s o |> pack_arr
      in
      fun ?padding a b s ->
        let ff a b =
          match a, b with
          | Arr a, Arr b -> Arr A.(transpose_conv2d ?padding a b s)
          | _ -> error_binop "transpose_conv2d" a b
        in
        let fd a b = transpose_conv2d ?padding a b s in
        (* FIXME: df_da, df_db, df_dab are not correct ... do not use *)
        let df_da _cp _ap at = at in
        let df_db _cp _bp bt = bt in
        let df_dab _cp _ap at _bp bt = at + bt in
        let r_d_d a b =
          let reverse _ap aa t =
            (transpose_conv2d_backward_input a b s !aa, a)
            :: (transpose_conv2d_backward_kernel a b s !aa, b)
            :: t
          in
          let input t = a :: b :: t in
          let label = "Tr_Conv2D_D_D", [ a; b ] in
          reverse, input, label
        in
        let r_d_c a b =
          let reverse _ap aa t = (transpose_conv2d_backward_input a b s !aa, a) :: t in
          let input t = a :: t in
          let label = "Tr_Conv2D_D_C", [ a; b ] in
          reverse, input, label
        in
        let r_c_d a b =
          let reverse _ap aa t = (transpose_conv2d_backward_kernel a b s !aa, b) :: t in
          let input t = b :: t in
          let label = "Tr_Conv2D_C_D", [ a; b ] in
          reverse, input, label
        in
        op_p_s a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d


    (* a:input; b:kernel; s:stride *)
    and transpose_conv3d =
      (* a:input; b:kernel; s:stride; o:output' *)
      let transpose_conv3d_backward_input a b s o =
        let a = unpack_arr a in
        let b = unpack_arr b in
        let o = unpack_arr o in
        A.transpose_conv3d_backward_input a b s o |> pack_arr
      (* a:input; b:kernel; s:stride; o:output' *)
      and transpose_conv3d_backward_kernel a b s o =
        let a = unpack_arr a in
        let b = unpack_arr b in
        let o = unpack_arr o in
        A.transpose_conv3d_backward_kernel a b s o |> pack_arr
      in
      fun ?padding a b s ->
        let ff a b =
          match a, b with
          | Arr a, Arr b -> Arr A.(transpose_conv3d ?padding a b s)
          | _ -> error_binop "transpose_conv3d" a b
        in
        let fd a b = transpose_conv3d ?padding a b s in
        (* FIXME: df_da, df_db, df_dab are not correct ... do not use *)
        let df_da _cp _ap at = at in
        let df_db _cp _bp bt = bt in
        let df_dab _cp _ap at _bp bt = at + bt in
        let r_d_d a b =
          let reverse _ap aa t =
            (transpose_conv3d_backward_input a b s !aa, a)
            :: (transpose_conv3d_backward_kernel a b s !aa, b)
            :: t
          in
          let input t = a :: b :: t in
          let label = "Tr_Conv3D_D_D", [ a; b ] in
          reverse, input, label
        in
        let r_d_c a b =
          let reverse _ap aa t = (transpose_conv3d_backward_input a b s !aa, a) :: t in
          let input t = a :: t in
          let label = "Tr_Conv3D_D_C", [ a; b ] in
          reverse, input, label
        in
        let r_c_d a b =
          let reverse _ap aa t = (transpose_conv3d_backward_kernel a b s !aa, b) :: t in
          let input t = b :: t in
          let label = "Tr_Conv3D_C_D", [ a; b ] in
          reverse, input, label
        in
        op_p_s a b ff fd df_da df_db df_dab r_d_d r_d_c r_c_d


    (* a:input; b:kernel; s:stride *)
    and max_pool1d =
      (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
      let max_pool1d_backward p a b s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.max_pool1d_backward p a b s o |> pack_arr
      in
      fun padding a b s ->
        let ff = function
          | Arr a -> Arr A.(max_pool1d ~padding a b s)
          | _ -> error_uniop "max_pool1d" a
        in
        let fd a = max_pool1d padding a b s in
        let df _cp _ap _at = failwith "max_pool1d:df" in
        let r a =
          let reverse _ap aa t =
            (max_pool1d_backward padding (primal a) b s !aa, a) :: t
          in
          let input t = a :: t in
          let label = "Maxpool1D_D", [ a ] in
          reverse, input, label
        in
        op_s_s a ff fd df r


    (* a:input; b:kernel; s:stride *)
    and max_pool2d =
      (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
      let max_pool2d_backward p a b s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.max_pool2d_backward p a b s o |> pack_arr
      in
      fun padding a b s ->
        let ff = function
          | Arr a -> Arr A.(max_pool2d ~padding a b s)
          | _ -> error_uniop "max_pool2d" a
        in
        let fd a = max_pool2d padding a b s in
        let df _cp _ap _at = failwith "max_pool2d:df" in
        let r a =
          let reverse _ap aa t =
            (max_pool2d_backward padding (primal a) b s !aa, a) :: t
          in
          let input t = a :: t in
          let label = "Maxpool2D_D", [ a ] in
          reverse, input, label
        in
        op_s_s a ff fd df r


    (* a:input; b:kernel; s:stride *)
    and max_pool3d =
      (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
      let max_pool3d_backward p a b s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.max_pool3d_backward p a b s o |> pack_arr
      in
      fun padding a b s ->
        let ff = function
          | Arr a -> Arr A.(max_pool3d ~padding a b s)
          | _ -> error_uniop "max_pool3d" a
        in
        let fd a = max_pool3d padding a b s in
        let df _cp _ap _at = failwith "max_pool3d:df" in
        let r a =
          let reverse _ap aa t =
            (max_pool3d_backward padding (primal a) b s !aa, a) :: t
          in
          let input t = a :: t in
          let label = "Maxpool3D_D", [ a ] in
          reverse, input, label
        in
        op_s_s a ff fd df r


    (* a:input; b:kernel; s:stride *)
    and avg_pool1d =
      (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
      let avg_pool1d_backward p a b s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.avg_pool1d_backward p a b s o |> pack_arr
      in
      fun padding a b s ->
        let ff = function
          | Arr a -> Arr A.(avg_pool1d ~padding a b s)
          | _ -> error_uniop "avg_pool1d" a
        in
        let fd a = avg_pool1d padding a b s in
        let df _cp _ap _at = failwith "avg_pool1d:df" in
        let r a =
          let reverse _ap aa t =
            (avg_pool1d_backward padding (primal a) b s !aa, a) :: t
          in
          let input t = a :: t in
          let label = "Avgpool1D_D", [ a ] in
          reverse, input, label
        in
        op_s_s a ff fd df r


    (* a:input; b:kernel; s:stride *)
    and avg_pool2d =
      (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
      let avg_pool2d_backward p a b s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.avg_pool2d_backward p a b s o |> pack_arr
      in
      fun padding a b s ->
        let ff = function
          | Arr a -> Arr A.(avg_pool2d ~padding a b s)
          | _ -> error_uniop "avg_pool2d" a
        in
        let fd a = avg_pool2d padding a b s in
        let df _cp _ap _at = failwith "avg_pool2d:df" in
        let r a =
          let reverse _ap aa t =
            (avg_pool2d_backward padding (primal a) b s !aa, a) :: t
          in
          let input t = a :: t in
          let label = "Avgpool2D_D", [ a ] in
          reverse, input, label
        in
        op_s_s a ff fd df r


    (* a:input; b:kernel; s:stride *)
    and avg_pool3d =
      (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
      let avg_pool3d_backward p a b s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.avg_pool3d_backward p a b s o |> pack_arr
      in
      fun padding a b s ->
        let ff = function
          | Arr a -> Arr A.(avg_pool3d ~padding a b s)
          | _ -> error_uniop "avg_pool3d" a
        in
        let fd a = avg_pool3d padding a b s in
        let df _cp _ap _at = failwith "avg_pool3d:df" in
        let r a =
          let reverse _ap aa t =
            (avg_pool3d_backward padding (primal a) b s !aa, a) :: t
          in
          let input t = a :: t in
          let label = "Avgpool3D_D", [ a ] in
          reverse, input, label
        in
        op_s_s a ff fd df r


    (* a:input; s:size *)
    and upsampling2d =
      (* a:input; s:size; o:output' *)
      let upsampling2d_backward a s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.upsampling2d_backward a s o |> pack_arr
      in
      fun a s ->
        let ff = function
          | Arr a -> Arr A.(upsampling2d a s)
          | _ -> error_uniop "upsampling2d" a
        in
        let fd a = upsampling2d a s in
        let df _cp _ap _at = failwith "upsampling2d:df" in
        let r a =
          let reverse _ap aa t = (upsampling2d_backward (primal a) s !aa, a) :: t in
          let input t = a :: t in
          let label = "UpSampling2D_D", [ a ] in
          reverse, input, label
        in
        op_s_s a ff fd df r


    (* v: padded value; p:padding index; a:input *)
    and pad =
      (* TODO: sources required to confirm this backward op *)
      (* o:outut'; p: padding index *)
      let pad_backward o p =
        (* assume p is full legal index for pad operation *)
        let o = unpack_arr o in
        let os = A.shape o in
        let q = Owl_utils.llss2aarr p in
        Array.iteri (fun i x -> x.(1) <- Pervasives.(os.(i) - 1 - x.(1))) q;
        let q = Owl_utils.aarr2llss q in
        A.(get_slice q o) |> pack_arr
      in
      fun ?v p a ->
        let ff = function
          | Arr a -> Arr A.(pad ?v p a)
          | _ -> error_uniop "pad" a
        in
        let fd = pad p in
        let df _cp _ap _at = failwith "pad:df" in
        let r a =
          let reverse _ap aa t = (pad_backward !aa p, a) :: t in
          let input t = a :: t in
          let label = "PAD_D", [ a ] in
          reverse, input, label
        in
        op_s_s a ff fd df r
  end

  module Mat = struct
    let empty m n = A.empty [| m; n |] |> pack_arr
    let zeros m n = A.zeros [| m; n |] |> pack_arr
    let eye n = A.eye n |> pack_arr
    let ones m n = A.ones [| m; n |] |> pack_arr
    let uniform ?a ?b m n = A.uniform ?a ?b [| m; n |] |> pack_arr
    let gaussian ?mu ?sigma m n = A.gaussian ?mu ?sigma [| m; n |] |> pack_arr
    let reset x = x |> unpack_arr |> A.reset
    let reshape m n x = Maths.reshape x [| m; n |]

    let shape x =
      let s = A.shape (unpack_arr x) in
      s.(0), s.(1)


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
end
