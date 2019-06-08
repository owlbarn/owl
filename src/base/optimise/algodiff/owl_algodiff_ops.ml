(* Below the variable naming convention is based on c = f(a), where f is the operation we
   are defining. Therefore we use `cp` to denote the primal of the output, `ca` as the
   adjoin of the output, `ap` as the primal of the input, and `at` as the tangent at the
   input. *)

module Make (Core : Owl_algodiff_core_sig.Sig) = struct
  open Core
  module Builder = Owl_algodiff_ops_builder.Make (Core)
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
          let dr _a _cp ca = neg !ca
        end
        : Siso)
        a


    and abs a =
      build_siso
        (module struct
          let label = "abs"
          let ff_f a = F A.Scalar.(abs a)
          let ff_arr a = Arr A.(abs a)
          let df _cp ap at = at * signum ap
          let dr a _cp ca = !ca * signum (primal a)
        end
        : Siso)
        a


    and signum a =
      build_siso
        (module struct
          let label = "signum"
          let ff_f a = F A.Scalar.(signum a)
          let ff_arr a = Arr A.(signum a)
          let df _cp ap _at = zero ap
          let dr a _cp _ca = zero a
        end
        : Siso)
        a


    and floor a =
      build_siso
        (module struct
          let label = "floor"
          let ff_f a = F A.Scalar.(floor a)
          let ff_arr a = Arr A.(floor a)
          let df _cp ap _at = zero ap
          let dr a _cp _ca = zero a
        end
        : Siso)
        a


    and ceil a =
      build_siso
        (module struct
          let label = "ceil"
          let ff_f a = F A.Scalar.(ceil a)
          let ff_arr a = Arr A.(ceil a)
          let df _cp ap _at = zero ap
          let dr a _cp _ca = zero a
        end
        : Siso)
        a


    and round a =
      build_siso
        (module struct
          let label = "round"
          let ff_f a = F A.Scalar.(round a)
          let ff_arr a = Arr A.(round a)
          let df _cp ap _at = zero ap
          let dr a _cp _ca = zero a
        end
        : Siso)
        a


    and sqr a =
      build_siso
        (module struct
          let label = "sqr"
          let ff_f a = F A.Scalar.(sqr a)
          let ff_arr a = Arr A.(sqr a)
          let df _cp ap at = pack_flt 2. * at * ap
          let dr a _cp ca = !ca * primal a * pack_flt 2.
        end
        : Siso)
        a


    and sqrt a =
      build_siso
        (module struct
          let label = "sqrt"
          let ff_f a = F A.Scalar.(sqrt a)
          let ff_arr a = Arr A.(sqrt a)
          let df cp _ap at = at / (pack_flt 2. * cp)
          let dr _a cp ca = !ca / (pack_flt 2. * cp)
        end
        : Siso)
        a


    and log a =
      build_siso
        (module struct
          let label = "log"
          let ff_f a = F A.Scalar.(log a)
          let ff_arr a = Arr A.(log a)
          let df _cp ap at = at / ap
          let dr a _cp ca = !ca / primal a
        end
        : Siso)
        a


    and log2 a =
      build_siso
        (module struct
          let label = "log2"
          let ff_f a = F A.Scalar.(log2 a)
          let ff_arr a = Arr A.(log2 a)
          let df _cp ap at = at / (ap * pack_flt Owl_const.log2e)
          let dr a _cp ca = !ca / (primal a * pack_flt Owl_const.log2e)
        end
        : Siso)
        a


    and log10 a =
      build_siso
        (module struct
          let label = "log10"
          let ff_f a = F A.Scalar.(log10 a)
          let ff_arr a = Arr A.(log10 a)
          let df _cp ap at = at / (ap * pack_flt Owl_const.log10e)
          let dr a _cp ca = !ca / (primal a * pack_flt Owl_const.log10e)
        end
        : Siso)
        a


    and exp a =
      build_siso
        (module struct
          let label = "exp"
          let ff_f a = F A.Scalar.(exp a)
          let ff_arr a = Arr A.(exp a)
          let df cp _ap at = at * cp
          let dr _a cp ca = !ca * cp
        end
        : Siso)
        a


    and sin a =
      build_siso
        (module struct
          let label = "sin"
          let ff_f a = F A.Scalar.(sin a)
          let ff_arr a = Arr A.(sin a)
          let df _cp ap at = at * cos ap
          let dr a _cp ca = !ca * cos (primal a)
        end
        : Siso)
        a


    and cos a =
      build_siso
        (module struct
          let label = "cos"
          let ff_f a = F A.Scalar.(cos a)
          let ff_arr a = Arr A.(cos a)
          let df _cp ap at = neg (at * sin ap)
          let dr a _cp ca = !ca * neg (sin (primal a))
        end
        : Siso)
        a


    and tan a =
      build_siso
        (module struct
          let label = "tan"
          let ff_f a = F A.Scalar.(tan a)
          let ff_arr a = Arr A.(tan a)
          let df _cp ap at = at / sqr (cos ap)
          let dr a _cp ca = !ca / sqr (cos (primal a))
        end
        : Siso)
        a


    and sinh a =
      build_siso
        (module struct
          let label = "sinh"
          let ff_f a = F A.Scalar.(sinh a)
          let ff_arr a = Arr A.(sinh a)
          let df _cp ap at = at * cosh ap
          let dr a _cp ca = !ca * cosh (primal a)
        end
        : Siso)
        a


    and cosh a =
      build_siso
        (module struct
          let label = "cosh"
          let ff_f a = F A.Scalar.(cosh a)
          let ff_arr a = Arr A.(cosh a)
          let df _cp ap at = at * sinh ap
          let dr a _cp ca = !ca * sinh (primal a)
        end
        : Siso)
        a


    and tanh a =
      build_siso
        (module struct
          let label = "tanh"
          let ff_f a = F A.Scalar.(tanh a)
          let ff_arr a = Arr A.(tanh a)
          let df _cp ap at = at / sqr (cosh ap)
          let dr a _cp ca = !ca / sqr (cosh (primal a))
        end
        : Siso)
        a


    and asin a =
      build_siso
        (module struct
          let label = "asin"
          let ff_f a = F A.Scalar.(asin a)
          let ff_arr a = Arr A.(asin a)
          let df _cp ap at = at / sqrt (pack_flt 1. - sqr ap)
          let dr a _cp ca = !ca / sqrt (pack_flt 1. - sqr (primal a))
        end
        : Siso)
        a


    and acos a =
      build_siso
        (module struct
          let label = "acos"
          let ff_f a = F A.Scalar.(acos a)
          let ff_arr a = Arr A.(acos a)
          let df _cp ap at = neg at / sqrt (pack_flt 1. - sqr ap)
          let dr a _cp ca = neg !ca / sqrt (pack_flt 1. - sqr (primal a))
        end
        : Siso)
        a


    and atan a =
      build_siso
        (module struct
          let label = "atan"
          let ff_f a = F A.Scalar.(atan a)
          let ff_arr a = Arr A.(atan a)
          let df _cp ap at = at / (pack_flt 1. + sqr ap)
          let dr a _cp ca = !ca / (pack_flt 1. + sqr (primal a))
        end
        : Siso)
        a


    and asinh a =
      build_siso
        (module struct
          let label = "asinh"
          let ff_f a = F A.Scalar.(asinh a)
          let ff_arr a = Arr A.(asinh a)
          let df _cp ap at = at / sqrt (sqr ap + pack_flt 1.)
          let dr a _cp ca = !ca / sqrt (sqr (primal a) + pack_flt 1.)
        end
        : Siso)
        a


    and acosh a =
      build_siso
        (module struct
          let label = "acosh"
          let ff_f a = F A.Scalar.(acosh a)
          let ff_arr a = Arr A.(acosh a)
          let df _cp ap at = at / sqrt (sqr ap - pack_flt 1.)
          let dr a _cp ca = !ca / sqrt (sqr (primal a) - pack_flt 1.)
        end
        : Siso)
        a


    and atanh a =
      build_siso
        (module struct
          let label = "atanh"
          let ff_f a = F A.Scalar.(atanh a)
          let ff_arr a = Arr A.(atanh a)
          let df _cp ap at = at / (pack_flt 1. - sqr ap)
          let dr a _cp ca = !ca / (pack_flt 1. - sqr (primal a))
        end
        : Siso)
        a


    and get_slice i a =
      build_siso
        (module struct
          let label = "get_slice"
          let ff_f a = error_uniop label (pack_elt a)
          let ff_arr a = Arr A.(get_slice i a)
          let df _cp _ap at = get_slice i at
          let dr a _cp ca = set_slice i (zero a) !ca
        end
        : Siso)
        a


    and sum' a =
      build_siso
        (module struct
          let label = "sum'"
          let ff_f a = F a
          let ff_arr a = F A.(sum' a)
          let df _cp _ap at = sum' at
          let dr _a _cp ca = !ca
        end
        : Siso)
        a


    and sum ?(axis = -1) a =
      build_siso
        (module struct
          let label = "sum axis"
          let ff_f a = error_uniop label (pack_elt a)
          let ff_arr a = Arr A.(sum ~axis a)
          let df _cp _ap at = sum ~axis at

          let dr a _cp ca =
            let s = shape a in
            let reps = Array.(make (length s) 1) in
            reps.(axis) <- s.(axis);
            repeat !ca reps
        end
        : Siso)
        a


    and sum_reduce ?(axis = [| 0 |]) a =
      build_siso
        (module struct
          let label = "sum_reduce"
          let ff_f a = error_uniop label (pack_elt a)
          let ff_arr a = Arr A.(sum_reduce ~axis a)
          let df _cp _ap at = sum_reduce ~axis at

          let dr a _cp ca =
            let s = shape a in
            let reps = Array.(make (length s) 1) in
            Array.iter (fun j -> reps.(j) <- s.(j)) axis;
            repeat !ca reps
        end
        : Siso)
        a


    and mean a = sum' a / F (numel a |> float_of_int |> A.float_to_elt)

    and transpose a =
      build_siso
        (module struct
          let label = "transpose"
          let ff_f a = error_uniop label (pack_elt a)
          let ff_arr a = Arr A.(transpose a)
          let df _cp _ap at = transpose at
          let dr _a _cp ca = transpose !ca
        end
        : Siso)
        a


    and l1norm' a =
      build_siso
        (module struct
          let label = "l1norm'"
          let ff_f a = error_uniop label (pack_elt a)
          let ff_arr a = F A.(l1norm' a)
          let df _cp ap at = at * signum ap
          let dr a _cp ca = !ca * signum (primal a)
        end
        : Siso)
        a


    and l2norm' a =
      build_siso
        (module struct
          let label = "l2norm'"
          let ff_f a = error_uniop label (pack_elt a)
          let ff_arr a = F A.(l2norm' a)
          let df cp ap at = ap * at / cp
          let dr a cp ca = !ca / cp * primal a
        end
        : Siso)
        a


    and l2norm_sqr' a =
      build_siso
        (module struct
          let label = "l2norm_sqr'"
          let ff_f a = error_uniop label (pack_elt a)
          let ff_arr a = F A.(l2norm_sqr' a)
          let df _cp ap at = pack_flt 2. * (ap * at)
          let dr a _cp ca = !ca * pack_flt 2. * primal a
        end
        : Siso)
        a


    and sigmoid a =
      build_siso
        (module struct
          let label = "sigmoid"
          let ff_f a = F A.Scalar.(sigmoid a)
          let ff_arr a = Arr A.(sigmoid a)
          let df cp _ap at = at * cp * (pack_flt 1. - cp)
          let dr _a cp ca = !ca * cp * (pack_flt 1. - cp)
        end
        : Siso)
        a


    and relu a =
      build_siso
        (module struct
          let label = "relu"
          let ff_f a = F A.Scalar.(relu a)
          let ff_arr a = Arr A.(relu a)
          let df _cp ap at = at * (pack_flt 1. + signum ap) / pack_flt 2.
          let dr a _cp ca = !ca * ((signum (primal a) + pack_flt 1.) / pack_flt 2.)
        end
        : Siso)
        a


    and diag ?(k = 0) a =
      build_siso
        (module struct
          let label = "diag"
          let ff_f a = error_uniop label (pack_elt a)
          let ff_arr a = Arr A.(diag ~k a |> copy)
          let df _cp _ap at = diag ~k at

          let dr a _cp ca =
            let m = col_num a in
            let l = Pervasives.(m - k) in
            let rec accu i a_ =
              if i < l
              then accu (succ i) (set_item a_ i Pervasives.(k + i) (get_item !ca 0 i))
              else a_
            in
            accu 0 (zero a)
        end
        : Siso)
        a


    and diagm ?(k = 0) a =
      build_siso
        (module struct
          let label = "diagm"
          let ff_f a = error_uniop label (pack_elt a)
          let ff_arr a = Arr A.(diagm ~k a |> copy)
          let df _cp _ap at = diagm ~k at
          let dr _a _cp ca = diag ~k !ca
        end
        : Siso)
        a


    and trace a =
      build_siso
        (module struct
          let label = "trace"
          let ff_f a = error_uniop label (pack_elt a)
          let ff_arr a = F A.(trace a)
          let df _cp _ap at = trace at

          let dr a _cp ca =
            let m = col_num a in
            !ca * diagm (pack_arr A.(ones [| 1; m |]))
        end
        : Siso)
        a


    and triu ?(k = 0) a =
      build_siso
        (module struct
          let label = "triu"
          let ff_f a = error_uniop label (pack_elt a)
          let ff_arr a = Arr A.(triu ~k a)
          let df _cp _ap at = triu ~k at
          let dr _a _cp ca = triu ~k !ca
        end
        : Siso)
        a


    and tril ?(k = 0) a =
      build_siso
        (module struct
          let label = "tril"
          let ff_f a = error_uniop label (pack_elt a)
          let ff_arr a = Arr A.(tril ~k a)
          let df _cp _ap at = tril ~k at
          let dr _a _cp ca = tril ~k !ca
        end
        : Siso)
        a


    and inv a =
      build_siso
        (module struct
          let label = "inv"
          let ff_f a = error_uniop label (pack_elt a)
          let ff_arr a = Arr A.(inv a)
          let df cp _ap at = neg cp *@ at *@ cp

          let dr _a cp ca =
            let dpt = transpose cp in
            neg dpt *@ !ca *@ dpt
        end
        : Siso)
        a


    and softplus x = log (pack_flt 1. + exp x)
    and softsign x = x / (pack_flt 1. + abs x)

    and softmax ?(axis = -1) x =
      let c = Arr A.(max ~axis (unpack_arr x)) in
      let y = exp (x - c) in
      let a = sum ~axis y in
      y / a


    and reshape a s =
      build_siso
        (module struct
          let label = "reshape"
          let ff_f a = error_uniop label (pack_elt a)
          let ff_arr a = Arr A.(reshape a s)
          let df _cp _ap at = reshape at s
          let dr a _cp ca = reshape !ca (shape (primal a))
        end
        : Siso)
        a


    and flatten a = reshape a [| 1; numel a |]

    and get_item a i j =
      match a with
      | Arr ap -> F (A.get ap [| i; j |])
      | DF (ap, at, ai) -> DF (get_item ap i j, get_item at i j, ai)
      | DR (ap, _, _, _, ai, _) ->
        let reverse _ap ca t = (set_item (zero a) i j (sum' !ca), a) :: t in
        let input t = a :: t in
        let label = "Get_Item", [ a ] in
        DR (get_item ap i j, ref (pack_flt 0.), (reverse, input, label), ref 0, ai, ref 0)
      | _ -> error_uniop "get_item" a


    and get_row a i =
      build_siso
        (module struct
          let label = "get_row"
          let ff_f a = error_uniop label (pack_elt a)
          let ff_arr a = Arr A.(row a i |> copy)
          let df _cp _ap at = get_row at i

          let dr a _cp ca =
            adjref a := add_row (adjval a) !ca i;
            zero a
        end
        : Siso)
        a


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
          let dr_ab _a _b _cp ca = !ca, !ca
          let dr_a _a _b _cp ca = !ca
          let dr_b _a _b _cp ca = !ca
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
          let dr_ab _a _b _cp ca = !ca, neg !ca
          let dr_a _a _b _cp ca = !ca
          let dr_b _a _b _cp ca = neg !ca
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
          let dr_ab a b _cp ca = !ca * primal b, !ca * primal a
          let dr_a _a b _cp ca = !ca * b
          let dr_b a _b _cp ca = !ca * a
        end
        : Piso)
        a
        b


    and ( / ) a b = div a b

    and div a b =
      build_piso
        (module struct
          let label = "div"
          let ff_aa a b = F A.Scalar.(div a b)
          let ff_ab a b = Arr A.(scalar_div a b)
          let ff_ba a b = Arr A.(div_scalar a b)
          let ff_bb a b = Arr A.(div a b)
          let df_da _cp _ap at = at / b
          let df_db cp bp bt = neg bt * cp / bp
          let df_dab cp _ap at bp bt = (at - (bt * cp)) / bp

          let dr_ab a b _cp ca =
            !ca / primal b, !ca * (neg (primal a) / (primal b * primal b))


          let dr_a _a b _cp ca = !ca / b
          let dr_b a b _cp ca = !ca * (neg a / (primal b * primal b))
        end
        : Piso)
        a
        b


    and ( ** ) a b = pow a b

    and pow a b =
      build_piso
        (module struct
          let label = "pow"
          let ff_aa a b = F A.Scalar.(pow a b)
          let ff_ab a b = Arr A.(scalar_pow a b)
          let ff_ba a b = Arr A.(pow_scalar a b)
          let ff_bb a b = Arr A.(pow a b)
          let df_da _cp ap at = at * (ap ** (b - pack_flt 1.)) * b
          let df_db cp _bp bt = bt * cp * log a

          let df_dab _cp ap at bp bt =
            (ap ** (bp - pack_flt 1.)) * ((at * bp) + (ap * bt * log ap))


          let dr_ab a b _cp ca =
            ( !ca * (primal a ** (primal b - pack_flt 1.)) * primal b
            , !ca * (primal a ** primal b) * log (primal a) )


          let dr_a a b _cp ca = !ca * (primal a ** (primal b - pack_flt 1.)) * primal b
          let dr_b a b _cp ca = !ca * (primal a ** primal b) * log (primal a)
        end
        : Piso)
        a
        b


    and atan2 a b =
      build_piso
        (module struct
          let label = "atan2"
          let ff_aa a b = F A.Scalar.(atan2 a b)
          let ff_ab a b = Arr A.(scalar_atan2 a b)
          let ff_ba a b = Arr A.(atan2_scalar a b)
          let ff_bb a b = Arr A.(atan2 a b)
          let df_da _cp ap at = at * b / (sqr ap + sqr b)
          let df_db _cp bp bt = neg bt * a / (sqr a + sqr bp)
          let df_dab _cp ap at bp bt = ((at * bp) - (bt * ap)) / (sqr ap + sqr bp)

          let dr_ab a b _cp ca =
            let d = sqr (primal a) + sqr (primal b) in
            !ca * primal b / d, !ca * neg (primal a) / d


          let dr_a a b _cp ca =
            let d = sqr (primal a) + sqr (primal b) in
            !ca * primal b / d


          let dr_b a b _cp ca =
            let d = sqr (primal a) + sqr (primal b) in
            !ca * neg (primal a) / d
        end
        : Piso)
        a
        b


    and min2 a b = (a + b - abs (a - b)) / pack_flt 2.
    and max2 a b = (a + b + abs (b - a)) / pack_flt 2.

    and set_item a i j b =
      build_piso
        (module struct
          let label = "set_item"
          let ff_aa a _b = error_uniop label (pack_elt a)
          let ff_ab a _b = error_uniop label (pack_elt a)

          let ff_ba a b =
            let aa = A.copy a in
            A.set aa [| i; j |] b;
            Arr aa


          let ff_bb a _b = error_uniop label (pack_arr a)
          let df_da _cp _ap at = set_item at i j (pack_flt 0.)
          let df_db _cp _bp bt = add_item (zero a) i j bt
          let df_dab _cp _ap at _bp bt = set_item at i j bt
          let dr_ab _a _b _cp ca = set_item !ca i j (pack_flt 0.), get_item !ca i j
          let dr_a _a _b _cp ca = set_item !ca i j (pack_flt 0.)
          let dr_b _a _b _cp ca = get_item !ca i j
        end
        : Piso)
        a
        b


    and add_item a i j b =
      build_piso
        (module struct
          let label = "add_item"
          let ff_aa a _b = error_uniop label (pack_elt a)
          let ff_ab a _b = error_uniop label (pack_elt a)

          let ff_ba a b =
            let aa = A.copy a in
            A.set aa [| i; j |] A.Scalar.(add (A.get aa [| i; j |]) b);
            Arr aa


          let ff_bb a _b = error_uniop label (pack_arr a)
          let df_da _cp _ap at = at
          let df_db _cp _bp bt = add_item (zero a) i j bt
          let df_dab _cp _ap at _bp bt = add_item at i j bt
          let dr_ab _a _b _cp ca = !ca, get_item !ca i j
          let dr_a _a _b _cp ca = !ca
          let dr_b _a _b _cp ca = get_item !ca i j
        end
        : Piso)
        a
        b


    and set_slice i a b =
      build_piso
        (module struct
          let label = "set_slice"
          let ff_aa a _b = error_uniop label (pack_elt a)
          let ff_ab a _b = error_uniop label (pack_elt a)
          let ff_ba _a b = error_uniop label (pack_elt b)

          let ff_bb a b =
            let a = A.copy a in
            A.(set_slice i a b);
            Arr a


          let df_da _cp _ap at = set_slice i at (zero b)
          let df_db _cp _bp bt = set_slice i (zero a) bt
          let df_dab _cp _ap at _bp bt = set_slice i at bt
          let dr_ab _a b _cp ca = set_slice i !ca (zero b), get_slice i !ca
          let dr_a _a b _cp ca = set_slice i !ca (zero b)
          let dr_b _a _b _cp ca = get_slice i !ca
        end
        : Piso)
        a
        b


    and ( *@ ) a b = dot a b

    and dot a b =
      build_piso
        (module struct
          let label = "dot"
          let ff_aa a _b = error_uniop label (pack_elt a)
          let ff_ab a _b = error_uniop label (pack_elt a)
          let ff_ba _a b = error_uniop label (pack_elt b)
          let ff_bb a b = Arr A.(dot a b)
          let df_da _cp _ap at = at *@ b
          let df_db _cp _bp bt = a *@ bt
          let df_dab _cp ap at bp bt = (ap *@ bt) + (at *@ bp)

          let dr_ab a b _cp ca =
            dot !ca (transpose (primal b)), dot (transpose (primal a)) !ca


          let dr_a _a b _cp ca = dot !ca (transpose (primal b))
          let dr_b a _b _cp ca = dot (transpose (primal a)) !ca
        end
        : Piso)
        a
        b


    and cross_entropy x y = x * log y |> sum' |> neg

    and add_row a b i =
      build_piso
        (module struct
          let label = "add_row"
          let ff_aa a _b = error_uniop label (pack_elt a)
          let ff_ab a _b = error_uniop label (pack_elt a)
          let ff_ba _a b = error_uniop label (pack_elt b)

          let ff_bb a b =
            A.(
              copy_row_to (add (row a i) b) a i;
              Arr a)


          let df_da _cp _ap at = at
          let df_db _cp _bp bt = add_row (zero a) bt i
          let df_dab _cp _ap at _bp bt = add_row at bt i
          let dr_ab _a _b _cp ca = !ca, get_row !ca i
          let dr_a _a _b _cp ca = !ca
          let dr_b _a _b _cp ca = get_row !ca i
        end
        : Piso)
        a
        b


    and concat axis a b =
      build_piso
        (module struct
          let label = "concat"
          let ff_aa a _b = error_uniop label (pack_elt a)
          let ff_ab a _b = error_uniop label (pack_elt a)
          let ff_ba _a b = error_uniop label (pack_elt b)
          let ff_bb a b = Arr A.(concatenate ~axis [| a; b |])
          let df_da _cp _ap at = concat axis at (zero b)
          let df_db _cp _bp bt = concat axis (zero a) bt
          let df_dab _cp _ap at _bp bt = concat axis at bt

          let dr_ab a b _cp ca =
            let s = split ~axis [| (shape a).(axis); (shape b).(axis) |] !ca in
            s.(0), s.(1)


          let dr_a a b _cp ca =
            let s = split ~axis [| (shape a).(axis); (shape b).(axis) |] !ca in
            s.(0)


          let dr_b a b _cp ca =
            let s = split ~axis [| (shape a).(axis); (shape b).(axis) |] !ca in
            s.(1)
        end
        : Piso)
        a
        b


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
        let reverse _ap ca t =
          t |> List.append (a |> Array.to_list |> List.mapi (fun i v -> get_row !ca i, v))
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
        let reverse _cp ca t =
          let ca_arrays = to_arrays !ca in
          t |> List.append (idxs |> List.map (fun (i, j) -> ca_arrays.(i).(j), a.(i).(j)))
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


    and split ~axis parts a =
      build_siao
        (module struct
          let label = "split"
          let ff_f a = error_uniop "label" (pack_elt a)
          let ff_arr a = A.(split ~axis parts a) |> Array.map (fun x -> Arr x)
          let df _cp _ap _at = raise (Owl_exception.NOT_IMPLEMENTED "owl_algodiff_ops.split")

          let dr _a _cp _cp_ref_arr ca_ref_arr =
            concatenate ~axis (Array.map (fun ca -> !ca) ca_ref_arr)
        end
        : Siao)
        a


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
        let adjoint _cp ca t =
          let ca_arr = split ~axis (Array.map (fun x -> (shape x).(axis)) a) !ca in
          t |> List.(append (map (fun i -> ca_arr.(i), a.(i)) idxs))
        in
        let register t = List.append List.(map (fun i -> a.(i)) idxs) t in
        let label = "Concatenate_D", List.(map (fun i -> a.(i)) idxs) in
        DR (cp, ref (zero cp), (adjoint , register, label), ref 0, !ai_ref, ref 0)
      | 2 ->
        let at =
          a
          |> Array.map (fun x -> x |> tangent |> unpack_arr)
          |> A.concatenate ~axis
          |> pack_arr
        in
        DF (cp, at, !ai_ref)
      | _ -> error_uniop "concatenate" a.(0)
  end

  module Linalg = struct
    open Maths

    (* single input single output *)

    let rec noop _ = ()
    and inv = Maths.inv

    and logdet a =
      build_siso
        (module struct
          let label = "logdet"
          let ff_f a = error_uniop label (pack_elt a)
          let ff_arr a = F A.(logdet a)
          let df _cp ap at = trace (transpose (inv ap) *@ at)
          let dr a _cp ca = !ca * transpose (inv (primal a))
        end
        : Siso)
        a


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
      let _chol_backward o ca upper =
        if upper
        then (
          let x = linsolve ~typ:`u o (copyutl (ca *@ transpose o)) in
          let x = linsolve ~typ:`u o (transpose x) in
          pack_flt 0.5 * transpose x)
        else (
          let x = linsolve ~trans:true ~typ:`l o (copyltu (transpose o *@ ca)) in
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
            let dr _a cp ca = _chol_backward cp !ca upper
          end
          : Siso)
          a


    (* single input pair outputs *)
    and qr =
      let _qr_backward (cp1, cp2) (ca1, ca2) =
        let q = !cp1
        and r = !cp2
        and qbar = !ca1
        and rbar = !ca2 in
        let m = (rbar *@ transpose r) - (transpose q *@ qbar) in
        linsolve r (transpose (qbar + (q *@ copyutl m))) |> transpose
      in
      fun a ->
        build_sipo
          (module struct
            let label = "qr"
            let ff_f _ = error_uniop "qr" a

            let ff_arr a =
              let q, r = A.(qr a) in
              Arr q, Arr r

            let df _cp _ap _at = raise (Owl_exception.NOT_IMPLEMENTED "owl_algodiff_ops.qr")
            let dr _a _cp cp_ref ca_ref = _qr_backward cp_ref ca_ref
          end
          : Sipo)
          a


    and lq =
      let _lq_backward (o1, o2) (ca1, ca2) =
        let l = !o1
        and q = !o2
        and lbar = !ca1
        and qbar = !ca2 in
        let m = (transpose l *@ lbar) - (qbar *@ transpose q) in
        linsolve ~trans:true ~typ:`l l (qbar + (copyltu m *@ q))
      in
      fun a ->
        build_sipo
          (module struct
            let label = "lq"
            let ff_f _ = error_uniop "lq" a

            let ff_arr a =
              let l, q = A.(lq a) in
              Arr l, Arr q


            let df _cp _ap _at = raise (Owl_exception.NOT_IMPLEMENTED "owl_algodiff_ops.lq")
            let dr _a _cp o ca = _lq_backward o ca
          end
          : Sipo)
          a


    (* single input triple outputs *)
    and svd =
      let _svd_backward (o1, o2, o3) (ca1, ca2, ca3) thin =
        let u, s, vt = !o1, !o2, !o3
        and ubar, sbar, vbart = !ca1, !ca2, !ca3 in
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
        if thin then
          (u * sbar *@ vt)
          + (((u *@ (f * ((ut *@ ubar) - (ubart *@ u))) * s)
             + ((e_m - (u *@ ut)) *@ ubar * inv_s))
            *@ vt)
          + (u
            *@ ((transpose s * (f * ((vt *@ vbar) - (vbart *@ v))) *@ vt)
               + (transpose inv_s * vbart *@ (e_n - (v *@ vt)))))
        else
          raise (Owl_exception.NOT_IMPLEMENTED "owl_algodiff_ops.svd")
      in
      fun ?(thin = true) a ->
        build_sito
          (module struct
            let label = "svd"
            let ff_f _ = error_uniop "svd" a

            let ff_arr a =
              let u, s, vt = A.(svd ~thin a) in
              Arr u, Arr s, Arr vt


            let df _cp _ap _at = raise (Owl_exception.NOT_IMPLEMENTED "owl_algodiff_ops.svd")
            let dr _a _cp o ca = _svd_backward o ca thin
          end
          : Sito)
          a


    (* pair outputs single input *)
    and lyapunov =
      let _lyapunov_backward_a a ca cp =
        let s = lyapunov (transpose a) (neg ca) in
        pack_flt 2. * s *@ cp
      in
      let _lyapunov_backward_q a ca = neg (lyapunov (transpose a) (neg ca)) in
      let _lyapunov_backward_aq a ca cp =
        let s = lyapunov (transpose a) (neg ca) in
        pack_flt 2. * s *@ cp, neg s
      in
      fun a q ->
        build_piso
          (module struct
            let label = "lyapunov"
            let ff_aa a _q = error_uniop label (pack_elt a)
            let ff_ab a _q = error_uniop label (pack_elt a)
            let ff_ba _a q = error_uniop label (pack_elt q)
            let ff_bb a q = Arr A.(lyapunov a q)
            let df_da cp ap at = lyapunov ap (neg ((at *@ cp) + (cp *@ transpose at)))
            let df_db _cp _qp qt = lyapunov a (neg qt)

            let df_dab cp ap at _qp qt =
              lyapunov ap (neg ((at *@ cp) + (cp *@ transpose at)))
              + lyapunov ap (neg qt)


            let dr_ab _a _b cp ca =
              let abar, qbar = _lyapunov_backward_aq (primal a) !ca cp in
              abar, qbar


            let dr_a a _q cp ca = _lyapunov_backward_a (primal a) !ca cp
            let dr_b a _q _cp ca = _lyapunov_backward_q (primal a) !ca
          end
          : Piso)
          a
          q


    and discrete_lyapunov =
      let _discrete_lyapunov_backward_a a ca cp =
        let s = discrete_lyapunov (transpose a) ca in
        pack_flt 2. * s *@ a *@ cp
      in
      let _discrete_lyapunov_backward_q a ca = discrete_lyapunov (transpose a) ca in
      let _discrete_lyapunov_backward_aq a ca cp =
        let s = discrete_lyapunov (transpose a) ca in
        pack_flt 2. * s *@ a *@ cp, s
      in
      fun ?(solver = `default) a q ->
        build_piso
          (module struct
            let label = "discrete_lyapunov"
            let ff_aa a _q = error_uniop label (pack_elt a)
            let ff_ab a _q = error_uniop label (pack_elt a)
            let ff_ba _a q = error_uniop label (pack_elt q)
            let ff_bb a q = Arr A.(discrete_lyapunov ~solver a q)

            let df_da cp ap at =
              discrete_lyapunov
                ap
                ((ap *@ cp *@ transpose at) + (at *@ cp *@ transpose a))


            let df_db _cp _qp qt = discrete_lyapunov a qt

            let df_dab cp ap at _qp qt =
              discrete_lyapunov
                ap
                ((ap *@ cp *@ transpose at) + (at *@ cp *@ transpose a))
              + discrete_lyapunov ap qt


            let dr_ab a _b cp ca =
              let abar, qbar = _discrete_lyapunov_backward_aq (primal a) !ca cp in
              abar, qbar


            let dr_a a _q cp ca = _discrete_lyapunov_backward_a (primal a) !ca cp
            let dr_b a _q _cp ca = _discrete_lyapunov_backward_q (primal a) !ca
          end
          : Piso)
          a
          q


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
      fun ?(trans = false) ?(typ = `n) a q ->
        build_piso
          (module struct
            let label = "linsolve"
            let ff_aa a _q = error_uniop label (pack_elt a)
            let ff_ab a _q = error_uniop label (pack_elt a)
            let ff_ba _a q = error_uniop label (pack_elt q)
            let ff_bb a q = Arr A.(linsolve ~trans ~typ a q)

            let df_da cp ap at =
              linsolve
                ~trans
                ap
                (if trans then neg (transpose at) *@ cp else neg at *@ cp)


            let df_db _cp _bp bt = linsolve ~trans a bt

            let df_dab cp ap at _bp bt =
              linsolve
                ~trans
                ap
                (if trans then bt - (transpose at *@ cp) else bt - (at *@ cp))


            let dr_ab a _b cp ca =
              let bbar = _linsolve_backward_b trans typ a !ca in
              let abar = _linsolve_backward_a trans typ cp bbar in
              abar, bbar


            let dr_a a _b cp ca =
              let bbar = _linsolve_backward_b trans typ a !ca in
              let abar = _linsolve_backward_a trans typ cp bbar in
              abar


            let dr_b a _b _cp ca = _linsolve_backward_b trans typ a !ca
          end
          : Piso)
          a
          q
  end

  (* neural network module: for specialised neural network operations *)
  module NN = struct
    open Maths

    (* NOTE: these fucntions are for neural network. There are many restrictions at the
       moment. E.g. they do not support higher-order derivatives, and some do not support
       forward mode, so use them when you know what you are doing. *)

    let dropout ?(rate = 0.5) a =
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
        build_piso
          (module struct
            let label = "conv1d"
            let ff_aa a _b = error_uniop label (pack_elt a)
            let ff_ab a _b = error_uniop label (pack_elt a)
            let ff_ba _a b = error_uniop label (pack_elt b)
            let ff_bb a b = Arr A.(conv1d ?padding a b s)
            let df_da _cp _ap at = at
            let df_db _cp _bp bt = bt
            let df_dab _cp _ap at _bp bt = at + bt

            let dr_ab a b _cp ca =
              conv1d_backward_input a b s !ca, conv1d_backward_kernel a b s !ca


            let dr_a a b _cp ca = conv1d_backward_input a b s !ca
            let dr_b a b _cp ca = conv1d_backward_kernel a b s !ca
          end
          : Piso)
          a
          b


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
        build_piso
          (module struct
            let label = "conv2d"
            let ff_aa a _b = error_uniop label (pack_elt a)
            let ff_ab a _b = error_uniop label (pack_elt a)
            let ff_ba _a b = error_uniop label (pack_elt b)
            let ff_bb a b = Arr A.(conv2d ?padding a b s)
            let df_da _cp _ap at = at
            let df_db _cp _bp bt = bt
            let df_dab _cp _ap at _bp bt = at + bt

            let dr_ab a b _cp ca =
              conv2d_backward_input a b s !ca, conv2d_backward_kernel a b s !ca


            let dr_a a b _cp ca = conv2d_backward_input a b s !ca
            let dr_b a b _cp ca = conv2d_backward_kernel a b s !ca
          end
          : Piso)
          a
          b


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
        build_piso
          (module struct
            let label = "conv3d"
            let ff_aa a _b = error_uniop label (pack_elt a)
            let ff_ab a _b = error_uniop label (pack_elt a)
            let ff_ba _a b = error_uniop label (pack_elt b)
            let ff_bb a b = Arr A.(conv3d ?padding a b s)
            let df_da _cp _ap at = at
            let df_db _cp _bp bt = bt
            let df_dab _cp _ap at _bp bt = at + bt

            let dr_ab a b _cp ca =
              conv3d_backward_input a b s !ca, conv3d_backward_kernel a b s !ca


            let dr_a a b _cp ca = conv3d_backward_input a b s !ca
            let dr_b a b _cp ca = conv3d_backward_kernel a b s !ca
          end
          : Piso)
          a
          b


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
        build_piso
          (module struct
            let label = "dilated_conv1d"
            let ff_aa a _b = error_uniop label (pack_elt a)
            let ff_ab a _b = error_uniop label (pack_elt a)
            let ff_ba _a b = error_uniop label (pack_elt b)
            let ff_bb a b = Arr A.(dilated_conv1d ?padding a b s r)
            let df_da _cp _ap at = at
            let df_db _cp _bp bt = bt
            let df_dab _cp _ap at _bp bt = at + bt

            let dr_ab a b _cp ca =
              ( dilated_conv1d_backward_input a b s r !ca
              , dilated_conv1d_backward_kernel a b s r !ca )


            let dr_a a b _cp ca = dilated_conv1d_backward_input a b s r !ca
            let dr_b a b _cp ca = dilated_conv1d_backward_kernel a b s r !ca
          end
          : Piso)
          a
          b


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
        build_piso
          (module struct
            let label = "dilated_conv2d"
            let ff_aa a _b = error_uniop label (pack_elt a)
            let ff_ab a _b = error_uniop label (pack_elt a)
            let ff_ba _a b = error_uniop label (pack_elt b)
            let ff_bb a b = Arr A.(dilated_conv2d ?padding a b s r)
            let df_da _cp _ap at = at
            let df_db _cp _bp bt = bt
            let df_dab _cp _ap at _bp bt = at + bt

            let dr_ab a b _cp ca =
              ( dilated_conv2d_backward_input a b s r !ca
              , dilated_conv2d_backward_kernel a b s r !ca )


            let dr_a a b _cp ca = dilated_conv2d_backward_input a b s r !ca
            let dr_b a b _cp ca = dilated_conv2d_backward_kernel a b s r !ca
          end
          : Piso)
          a
          b


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
        build_piso
          (module struct
            let label = "dilated_conv3d"
            let ff_aa a _b = error_uniop label (pack_elt a)
            let ff_ab a _b = error_uniop label (pack_elt a)
            let ff_ba _a b = error_uniop label (pack_elt b)
            let ff_bb a b = Arr A.(dilated_conv3d ?padding a b s r)
            let df_da _cp _ap at = at
            let df_db _cp _bp bt = bt
            let df_dab _cp _ap at _bp bt = at + bt

            let dr_ab a b _cp ca =
              ( dilated_conv3d_backward_input a b s r !ca
              , dilated_conv3d_backward_kernel a b s r !ca )


            let dr_a a b _cp ca = dilated_conv3d_backward_input a b s r !ca
            let dr_b a b _cp ca = dilated_conv3d_backward_kernel a b s r !ca
          end
          : Piso)
          a
          b


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
        build_piso
          (module struct
            let label = "transpose_conv1d"
            let ff_aa a _b = error_uniop label (pack_elt a)
            let ff_ab a _b = error_uniop label (pack_elt a)
            let ff_ba _a b = error_uniop label (pack_elt b)
            let ff_bb a b = Arr A.(transpose_conv1d ?padding a b s)
            let df_da _cp _ap at = at
            let df_db _cp _bp bt = bt
            let df_dab _cp _ap at _bp bt = at + bt

            let dr_ab a b _cp ca =
              ( transpose_conv1d_backward_input a b s !ca
              , transpose_conv1d_backward_kernel a b s !ca )


            let dr_a a b _cp ca = transpose_conv1d_backward_input a b s !ca
            let dr_b a b _cp ca = transpose_conv1d_backward_kernel a b s !ca
          end
          : Piso)
          a
          b


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
        build_piso
          (module struct
            let label = "transpose_conv2d"
            let ff_aa a _b = error_uniop label (pack_elt a)
            let ff_ab a _b = error_uniop label (pack_elt a)
            let ff_ba _a b = error_uniop label (pack_elt b)
            let ff_bb a b = Arr A.(transpose_conv2d ?padding a b s)
            let df_da _cp _ap at = at
            let df_db _cp _bp bt = bt
            let df_dab _cp _ap at _bp bt = at + bt

            let dr_ab a b _cp ca =
              ( transpose_conv2d_backward_input a b s !ca
              , transpose_conv2d_backward_kernel a b s !ca )


            let dr_a a b _cp ca = transpose_conv2d_backward_input a b s !ca
            let dr_b a b _cp ca = transpose_conv2d_backward_kernel a b s !ca
          end
          : Piso)
          a
          b


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
        build_piso
          (module struct
            let label = "transpose_conv3d"
            let ff_aa a _b = error_uniop label (pack_elt a)
            let ff_ab a _b = error_uniop label (pack_elt a)
            let ff_ba _a b = error_uniop label (pack_elt b)
            let ff_bb a b = Arr A.(transpose_conv3d ?padding a b s)
            let df_da _cp _ap at = at
            let df_db _cp _bp bt = bt
            let df_dab _cp _ap at _bp bt = at + bt

            let dr_ab a b _cp ca =
              ( transpose_conv3d_backward_input a b s !ca
              , transpose_conv3d_backward_kernel a b s !ca )


            let dr_a a b _cp ca = transpose_conv3d_backward_input a b s !ca
            let dr_b a b _cp ca = transpose_conv3d_backward_kernel a b s !ca
          end
          : Piso)
          a
          b


    (* a:input; b:kernel; s:stride *)
    and max_pool1d =
      (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
      let max_pool1d_backward p a b s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.max_pool1d_backward p a b s o |> pack_arr
      in
      fun padding a b s ->
        build_siso
          (module struct
            let label = "max_pool1d"
            let ff_f a = error_uniop label (pack_elt a)
            let ff_arr a = Arr A.(max_pool1d ~padding a b s)
            let df _cp _ap _at = failwith "max_pool1d:df"
            let dr a _cp ca = max_pool1d_backward padding (primal a) b s !ca
          end
          : Siso)
          a


    (* a:input; b:kernel; s:stride *)
    and max_pool2d =
      (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
      let max_pool2d_backward p a b s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.max_pool2d_backward p a b s o |> pack_arr
      in
      fun padding a b s ->
        build_siso
          (module struct
            let label = "max_pool2d"
            let ff_f a = error_uniop label (pack_elt a)
            let ff_arr a = Arr A.(max_pool2d ~padding a b s)
            let df _cp _ap _at = failwith "max_pool2d:df"
            let dr a _cp ca = max_pool2d_backward padding (primal a) b s !ca
          end
          : Siso)
          a


    (* a:input; b:kernel; s:stride *)
    and max_pool3d =
      (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
      let max_pool3d_backward p a b s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.max_pool3d_backward p a b s o |> pack_arr
      in
      fun padding a b s ->
        build_siso
          (module struct
            let label = "max_pool3d"
            let ff_f a = error_uniop label (pack_elt a)
            let ff_arr a = Arr A.(max_pool3d ~padding a b s)
            let df _cp _ap _at = failwith "max_pool3d:df"
            let dr a _cp ca = max_pool3d_backward padding (primal a) b s !ca
          end
          : Siso)
          a


    (* a:input; b:kernel; s:stride *)
    and avg_pool1d =
      (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
      let avg_pool1d_backward p a b s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.avg_pool1d_backward p a b s o |> pack_arr
      in
      fun padding a b s ->
        build_siso
          (module struct
            let label = "avg_pool1d"
            let ff_f a = error_uniop label (pack_elt a)
            let ff_arr a = Arr A.(avg_pool1d ~padding a b s)
            let df _cp _ap _at = failwith "avg_pool1d:df"
            let dr a _cp ca = avg_pool1d_backward padding (primal a) b s !ca
          end
          : Siso)
          a


    (* a:input; b:kernel; s:stride *)
    and avg_pool2d =
      (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
      let avg_pool2d_backward p a b s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.avg_pool2d_backward p a b s o |> pack_arr
      in
      fun padding a b s ->
        build_siso
          (module struct
            let label = "avg_pool2d"
            let ff_f a = error_uniop label (pack_elt a)
            let ff_arr a = Arr A.(avg_pool2d ~padding a b s)
            let df _cp _ap _at = failwith "avg_pool2d:df"
            let dr a _cp ca = avg_pool2d_backward padding (primal a) b s !ca
          end
          : Siso)
          a


    (* a:input; b:kernel; s:stride *)
    and avg_pool3d =
      (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
      let avg_pool3d_backward p a b s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.avg_pool3d_backward p a b s o |> pack_arr
      in
      fun padding a b s ->
        build_siso
          (module struct
            let label = "avg_pool3d"
            let ff_f a = error_uniop label (pack_elt a)
            let ff_arr a = Arr A.(avg_pool3d ~padding a b s)
            let df _cp _ap _at = failwith "avg_pool3d:df"
            let dr a _cp ca = avg_pool3d_backward padding (primal a) b s !ca
          end
          : Siso)
          a


    (* a:input; s:size *)
    and upsampling2d =
      (* a:input; s:size; o:output' *)
      let upsampling2d_backward a s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.upsampling2d_backward a s o |> pack_arr
      in
      fun a s ->
        build_siso
          (module struct
            let label = "upsampling2d"
            let ff_f a = error_uniop label (pack_elt a)
            let ff_arr a = Arr A.(upsampling2d a s)
            let df _cp _ap _at = failwith "upsampling2d:df"
            let dr a _cp ca = upsampling2d_backward (primal a) s !ca
          end
          : Siso)
          a


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
        build_siso
          (module struct
            let label = "pad"
            let ff_f a = error_uniop label (pack_elt a)
            let ff_arr a = Arr A.(pad ?v p a)
            let df _cp _ap _at = failwith "pad:df"
            let dr _a _cp ca = pad_backward !ca p
          end
          : Siso)
          a
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

    let init_2d n_rows n_cols f =
      Array.init n_rows (fun i -> Array.init n_cols (fun j -> f i j)) |> Maths.of_arrays
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
