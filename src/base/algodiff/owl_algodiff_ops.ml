(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* Below the variable naming convention is based on c = f(a), where f is the operation we
   are defining. Therefore we use `cp` to denote the primal of the output, `ca` as the
   adjoin of the output, `ap` as the primal of the input, and `at` as the tangent at the
   input. *)

module Make (Core : Owl_algodiff_core_sig.Sig) = struct
  open Core
  module Builder = Owl_algodiff_ops_builder.Make (Core)
  open Builder

  module Maths = struct
    (* squeeze x so that it has shape s *)
    let rec _squeeze_broadcast x s =
      let shp_x = shape x in
      let dim_x = Array.length shp_x in
      let dim = Array.length s in
      if shp_x = s
      then x
      else if dim_x < dim
      then
        Printf.sprintf
          "_squeeze_broadcast: x must have dimension greater than %i, instead has  \
           dimension %i"
          dim
          dim_x
        |> failwith
      else if dim = 0
      then sum' x
      else (
        let s, shp_x = Owl_utils_array.align `Left 1 s shp_x in
        let fold =
          Array.fold_left (fun (k, accu) shp_x ->
              if s.(k) = shp_x
              then succ k, accu
              else if s.(k) = 1
              then succ k, k :: accu
              else
                failwith
                  Printf.(
                    sprintf
                      "_squeeze_broadcast: there ought to have been a broadcasting error \
                       in the forward pass"))
        in
        let _, axis = fold (0, []) shp_x in
        let idxs = Array.of_list axis in
        sum_reduce ~axis:idxs x)


    (* single input single output operations *)
    and _neg =
      lazy
        (build_siso
           (module struct
             let label = "neg"

             let ff_f a = F A.Scalar.(neg a)

             let ff_arr a = Arr A.(neg a)

             let df _cp _ap at = neg at

             let dr _a _cp ca = neg !ca
           end : Siso))


    and neg a = Lazy.force _neg a

    and _abs =
      lazy
        (build_siso
           (module struct
             let label = "abs"

             let ff_f a = F A.Scalar.(abs a)

             let ff_arr a = Arr A.(abs a)

             let df _cp ap at = at * signum ap

             let dr a _cp ca = !ca * signum (primal a)
           end : Siso))


    and abs a = Lazy.force _abs a

    and _signum =
      lazy
        (build_siso
           (module struct
             let label = "signum"

             let ff_f a = F A.Scalar.(signum a)

             let ff_arr a = Arr A.(signum a)

             let df _cp ap _at = zero ap

             let dr a _cp _ca = zero a
           end : Siso))


    and signum a = Lazy.force _signum a

    and _floor =
      lazy
        (build_siso
           (module struct
             let label = "floor"

             let ff_f a = F A.Scalar.(floor a)

             let ff_arr a = Arr A.(floor a)

             let df _cp ap _at = zero ap

             let dr a _cp _ca = zero a
           end : Siso))


    and floor a = Lazy.force _floor a

    and _ceil =
      lazy
        (build_siso
           (module struct
             let label = "ceil"

             let ff_f a = F A.Scalar.(ceil a)

             let ff_arr a = Arr A.(ceil a)

             let df _cp ap _at = zero ap

             let dr a _cp _ca = zero a
           end : Siso))


    and ceil a = Lazy.force _ceil a

    and _round =
      lazy
        (build_siso
           (module struct
             let label = "round"

             let ff_f a = F A.Scalar.(round a)

             let ff_arr a = Arr A.(round a)

             let df _cp ap _at = zero ap

             let dr a _cp _ca = zero a
           end : Siso))


    and round a = Lazy.force _round a

    and _sqr =
      lazy
        (build_siso
           (module struct
             let label = "sqr"

             let ff_f a = F A.Scalar.(sqr a)

             let ff_arr a = Arr A.(sqr a)

             let df _cp ap at = pack_flt 2. * at * ap

             let dr a _cp ca = !ca * primal a * pack_flt 2.
           end : Siso))


    and sqr a = Lazy.force _sqr a

    and _sqrt =
      lazy
        (build_siso
           (module struct
             let label = "sqrt"

             let ff_f a = F A.Scalar.(sqrt a)

             let ff_arr a = Arr A.(sqrt a)

             let df cp _ap at = at / (pack_flt 2. * cp)

             let dr _a cp ca = !ca / (pack_flt 2. * cp)
           end : Siso))


    and sqrt a = Lazy.force _sqrt a

    and _log =
      lazy
        (build_siso
           (module struct
             let label = "log"

             let ff_f a = F A.Scalar.(log a)

             let ff_arr a = Arr A.(log a)

             let df _cp ap at = at / ap

             let dr a _cp ca = !ca / primal a
           end : Siso))


    and log a = Lazy.force _log a

    and _log2 =
      lazy
        (build_siso
           (module struct
             let label = "log2"

             let ff_f a = F A.Scalar.(log2 a)

             let ff_arr a = Arr A.(log2 a)

             let df _cp ap at = at / (ap * pack_flt Owl_const.log2e)

             let dr a _cp ca = !ca / (primal a * pack_flt Owl_const.log2e)
           end : Siso))


    and log2 a = Lazy.force _log2 a

    and _log10 =
      lazy
        (build_siso
           (module struct
             let label = "log10"

             let ff_f a = F A.Scalar.(log10 a)

             let ff_arr a = Arr A.(log10 a)

             let df _cp ap at = at / (ap * pack_flt Owl_const.log10e)

             let dr a _cp ca = !ca / (primal a * pack_flt Owl_const.log10e)
           end : Siso))


    and log10 a = Lazy.force _log10 a

    and _exp =
      lazy
        (build_siso
           (module struct
             let label = "exp"

             let ff_f a = F A.Scalar.(exp a)

             let ff_arr a = Arr A.(exp a)

             let df cp _ap at = at * cp

             let dr _a cp ca = !ca * cp
           end : Siso))


    and exp a = Lazy.force _exp a

    and _sin =
      lazy
        (build_siso
           (module struct
             let label = "sin"

             let ff_f a = F A.Scalar.(sin a)

             let ff_arr a = Arr A.(sin a)

             let df _cp ap at = at * cos ap

             let dr a _cp ca = !ca * cos (primal a)
           end : Siso))


    and sin a = Lazy.force _sin a

    and _cos =
      lazy
        (build_siso
           (module struct
             let label = "cos"

             let ff_f a = F A.Scalar.(cos a)

             let ff_arr a = Arr A.(cos a)

             let df _cp ap at = neg (at * sin ap)

             let dr a _cp ca = !ca * neg (sin (primal a))
           end : Siso))


    and cos a = Lazy.force _cos a

    and _tan =
      lazy
        (build_siso
           (module struct
             let label = "tan"

             let ff_f a = F A.Scalar.(tan a)

             let ff_arr a = Arr A.(tan a)

             let df _cp ap at = at / sqr (cos ap)

             let dr a _cp ca = !ca / sqr (cos (primal a))
           end : Siso))


    and tan a = Lazy.force _tan a

    and _sinh =
      lazy
        (build_siso
           (module struct
             let label = "sinh"

             let ff_f a = F A.Scalar.(sinh a)

             let ff_arr a = Arr A.(sinh a)

             let df _cp ap at = at * cosh ap

             let dr a _cp ca = !ca * cosh (primal a)
           end : Siso))


    and sinh a = Lazy.force _sinh a

    and _cosh =
      lazy
        (build_siso
           (module struct
             let label = "cosh"

             let ff_f a = F A.Scalar.(cosh a)

             let ff_arr a = Arr A.(cosh a)

             let df _cp ap at = at * sinh ap

             let dr a _cp ca = !ca * sinh (primal a)
           end : Siso))


    and cosh a = Lazy.force _cosh a

    and _tanh =
      lazy
        (build_siso
           (module struct
             let label = "tanh"

             let ff_f a = F A.Scalar.(tanh a)

             let ff_arr a = Arr A.(tanh a)

             let df _cp ap at = at / sqr (cosh ap)

             let dr a _cp ca = !ca / sqr (cosh (primal a))
           end : Siso))


    and tanh a = Lazy.force _tanh a

    and _asin =
      lazy
        (build_siso
           (module struct
             let label = "asin"

             let ff_f a = F A.Scalar.(asin a)

             let ff_arr a = Arr A.(asin a)

             let df _cp ap at = at / sqrt (pack_flt 1. - sqr ap)

             let dr a _cp ca = !ca / sqrt (pack_flt 1. - sqr (primal a))
           end : Siso))


    and asin a = Lazy.force _asin a

    and _acos =
      lazy
        (build_siso
           (module struct
             let label = "acos"

             let ff_f a = F A.Scalar.(acos a)

             let ff_arr a = Arr A.(acos a)

             let df _cp ap at = neg at / sqrt (pack_flt 1. - sqr ap)

             let dr a _cp ca = neg !ca / sqrt (pack_flt 1. - sqr (primal a))
           end : Siso))


    and acos a = Lazy.force _acos a

    and _atan =
      lazy
        (build_siso
           (module struct
             let label = "atan"

             let ff_f a = F A.Scalar.(atan a)

             let ff_arr a = Arr A.(atan a)

             let df _cp ap at = at / (pack_flt 1. + sqr ap)

             let dr a _cp ca = !ca / (pack_flt 1. + sqr (primal a))
           end : Siso))


    and atan a = Lazy.force _atan a

    and _asinh =
      lazy
        (build_siso
           (module struct
             let label = "asinh"

             let ff_f a = F A.Scalar.(asinh a)

             let ff_arr a = Arr A.(asinh a)

             let df _cp ap at = at / sqrt (sqr ap + pack_flt 1.)

             let dr a _cp ca = !ca / sqrt (sqr (primal a) + pack_flt 1.)
           end : Siso))


    and asinh a = Lazy.force _asinh a

    and _acosh =
      lazy
        (build_siso
           (module struct
             let label = "acosh"

             let ff_f a = F A.Scalar.(acosh a)

             let ff_arr a = Arr A.(acosh a)

             let df _cp ap at = at / sqrt (sqr ap - pack_flt 1.)

             let dr a _cp ca = !ca / sqrt (sqr (primal a) - pack_flt 1.)
           end : Siso))


    and acosh a = Lazy.force _acosh a

    and _atanh =
      lazy
        (build_siso
           (module struct
             let label = "atanh"

             let ff_f a = F A.Scalar.(atanh a)

             let ff_arr a = Arr A.(atanh a)

             let df _cp ap at = at / (pack_flt 1. - sqr ap)

             let dr a _cp ca = !ca / (pack_flt 1. - sqr (primal a))
           end : Siso))


    and atanh a = Lazy.force _atanh a

    and _get_slice =
      lazy
        (fun i ->
          build_siso
            (module struct
              let label = "get_slice"

              let ff_f a = error_uniop label (pack_elt a)

              let ff_arr a = Arr A.(get_slice i a)

              let df _cp _ap at = get_slice i at

              let dr a _cp ca = set_slice i (zero a) !ca
            end : Siso))


    and get_slice i = Lazy.force _get_slice i

    and _sum' =
      lazy
        (build_siso
           (module struct
             let label = "sum'"

             let ff_f a = F a

             let ff_arr a = F A.(sum' a)

             let df _cp _ap at = sum' at

             let dr _a _cp ca = !ca
           end : Siso))


    and sum' a = Lazy.force _sum' a

    and _sum =
      lazy
        (fun ?axis ~keep_dims ->
          build_siso
            (module struct
              let label = "sum axis"

              let ff_f a = error_uniop label (pack_elt a)

              let ff_arr a = Arr A.(sum ?axis ~keep_dims a)

              let df _cp _ap at = sum ?axis ~keep_dims at

              let dr a _cp ca =
                match axis with
                | Some axis ->
                  let s = shape a in
                  let ndim = Array.length s in
                  let reps = Array.(make ndim 1) in
                  let axis = Owl_utils.adjust_index axis ndim in
                  reps.(axis) <- s.(axis);
                  if keep_dims
                  then repeat !ca reps
                  else (
                    s.(axis) <- 1;
                    repeat (reshape !ca s) reps)
                | None      -> !ca
            end : Siso))


    and sum ?axis ?(keep_dims = true) = Lazy.force _sum ?axis ~keep_dims

    and _sum_reduce =
      lazy
        (fun ~axis ->
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
            end : Siso))


    and sum_reduce ?(axis = [| 0 |]) = Lazy.force _sum_reduce ~axis

    and _log_sum_exp' =
      lazy
        (build_siso
           (module struct
             let label = "log_sum_exp'"

             let ff_f _ = raise Owl_exception.(NOT_IMPLEMENTED "log_sum_exp'")

             let ff_arr x = pack_elt (A.log_sum_exp' x)

             let df cp ap at = sum' (at * exp (ap - cp))

             let dr x y ybar =
               let x = primal x in
               !ybar * exp (x - y)
           end : Siso))


    and log_sum_exp' x = Lazy.force _log_sum_exp' x

    and print_dim x =
      let shp = shape x in
      Array.iter (fun i -> Printf.printf "%i, %!" i) shp;
      print_newline ()


    and _log_sum_exp =
      lazy
        (fun ?(axis = 0) ~keep_dims ->
          build_siso
            (module struct
              let label = "log_sum_exp"

              let ff_f _ = raise Owl_exception.(NOT_IMPLEMENTED "log_sum_exp")

              let ff_arr x = pack_arr (A.log_sum_exp ~axis ~keep_dims x)

              let df cp ap at =
                print_dim cp;
                print_dim ap;
                print_dim at;
                let z = sum ~axis ~keep_dims (at * exp (ap - cp)) in
                print_dim z;
                z


              let dr x y ybar =
                let x = primal x in
                if keep_dims
                then !ybar * exp (x - y)
                else (
                  let shp = shape x in
                  shp.(axis) <- 1;
                  let y = reshape y shp in
                  print_dim !ybar;
                  let ybar = reshape !ybar shp in
                  print_dim ybar;
                  ybar * exp (x - y))
            end : Siso))


    and log_sum_exp ?axis ?(keep_dims = true) = Lazy.force _log_sum_exp ?axis ~keep_dims

    and mean a = sum' a / F (numel a |> float_of_int |> A.float_to_elt)

    and _transpose =
      lazy
        (fun ?axis ->
          build_siso
            (module struct
              let label = "transpose"

              let ff_f a = error_uniop label (pack_elt a)

              let ff_arr a = Arr A.(transpose ?axis a)

              let df _cp _ap at = transpose ?axis at

              let dr _a _cp ca = transpose ?axis !ca
            end : Siso))


    and transpose ?axis = Lazy.force _transpose ?axis

    and swap a0 a1 x =
      let d = Array.length (shape x) in
      let a = Array.init d (fun i -> i) in
      let t = a.(a0) in
      a.(a0) <- a.(a1);
      a.(a1) <- t;
      transpose ~axis:a x


    and _l1norm' =
      lazy
        (build_siso
           (module struct
             let label = "l1norm'"

             let ff_f a = error_uniop label (pack_elt a)

             let ff_arr a = F A.(l1norm' a)

             let df _cp ap at = sum' (at * signum ap)

             let dr a _cp ca = !ca * signum (primal a)
           end : Siso))


    and l1norm' a = Lazy.force _l1norm' a

    and _l2norm' =
      lazy
        (build_siso
           (module struct
             let label = "l2norm'"

             let ff_f a = error_uniop label (pack_elt a)

             let ff_arr a = F A.(l2norm' a)

             let df cp ap at = sum' (ap * at) / cp

             let dr a cp ca = !ca / cp * primal a
           end : Siso))


    and l2norm' a = Lazy.force _l2norm' a

    and _l2norm_sqr' =
      lazy
        (build_siso
           (module struct
             let label = "l2norm_sqr'"

             let ff_f a = error_uniop label (pack_elt a)

             let ff_arr a = F A.(l2norm_sqr' a)

             let df _cp ap at = pack_flt 2. * sum' (ap * at)

             let dr a _cp ca = !ca * pack_flt 2. * primal a
           end : Siso))


    and l2norm_sqr' a = Lazy.force _l2norm_sqr' a

    and _sigmoid =
      lazy
        (build_siso
           (module struct
             let label = "sigmoid"

             let ff_f a = F A.Scalar.(sigmoid a)

             let ff_arr a = Arr A.(sigmoid a)

             let df cp _ap at = at * cp * (pack_flt 1. - cp)

             let dr _a cp ca = !ca * cp * (pack_flt 1. - cp)
           end : Siso))


    and sigmoid a = Lazy.force _sigmoid a

    and _relu =
      lazy
        (build_siso
           (module struct
             let label = "relu"

             let ff_f a = F A.Scalar.(relu a)

             let ff_arr a = Arr A.(relu a)

             let df _cp ap at = at * (pack_flt 1. + signum ap) / pack_flt 2.

             let dr a _cp ca = !ca * ((signum (primal a) + pack_flt 1.) / pack_flt 2.)
           end : Siso))


    and relu a = Lazy.force _relu a

    and _dawsn =
      lazy
        (build_siso
           (module struct
             let label = "dawsn"

             let ff_f a = F A.Scalar.(dawsn a)

             let ff_arr a = Arr A.(dawsn a)

             let df cp ap at = at * (pack_flt 1. - (pack_flt 2. * ap * cp))

             let dr a cp ca = !ca * (pack_flt 1. - (pack_flt 2. * primal a * cp))
           end : Siso))


    and dawsn a = Lazy.force _dawsn a

    and _diag =
      lazy
        (fun ~k ->
          build_siso
            (module struct
              let label = "diag"

              let ff_f a = error_uniop label (pack_elt a)

              let ff_arr a = Arr A.(diag ~k a |> copy)

              let df _cp _ap at = diag ~k at

              let dr a _cp ca =
                let m = col_num a in
                let l = Stdlib.(m - k) in
                let rec accu i a_ =
                  if i < l
                  then accu (succ i) (set_item a_ i Stdlib.(k + i) (get_item !ca 0 i))
                  else a_
                in
                accu 0 (zero a)
            end : Siso))


    and diag ?(k = 0) = Lazy.force _diag ~k

    and _diagm =
      lazy
        (fun ~k ->
          build_siso
            (module struct
              let label = "diagm"

              let ff_f a = error_uniop label (pack_elt a)

              let ff_arr a = Arr A.(Mat.diagm ~k a |> copy)

              let df _cp _ap at = diagm ~k at

              let dr _a _cp ca = diag ~k !ca
            end : Siso))


    and diagm ?(k = 0) = Lazy.force _diagm ~k

    and _trace =
      lazy
        (build_siso
           (module struct
             let label = "trace"

             let ff_f a = error_uniop label (pack_elt a)

             let ff_arr a = F A.(trace a)

             let df _cp _ap at = trace at

             let dr a _cp ca =
               let m = col_num a in
               !ca * diagm (pack_arr A.(ones [| 1; m |]))
           end : Siso))


    and trace a = Lazy.force _trace a

    and _triu =
      lazy
        (fun ~k ->
          build_siso
            (module struct
              let label = "triu"

              let ff_f a = error_uniop label (pack_elt a)

              let ff_arr a = Arr A.(Mat.triu ~k a)

              let df _cp _ap at = triu ~k at

              let dr _a _cp ca = triu ~k !ca
            end : Siso))


    and triu ?(k = 0) = Lazy.force _triu ~k

    and _tril =
      lazy
        (fun ~k ->
          build_siso
            (module struct
              let label = "tril"

              let ff_f a = error_uniop label (pack_elt a)

              let ff_arr a = Arr A.(Mat.tril ~k a)

              let df _cp _ap at = tril ~k at

              let dr _a _cp ca = tril ~k !ca
            end : Siso))


    and tril ?(k = 0) = Lazy.force _tril ~k

    and _inv =
      lazy
        (build_siso
           (module struct
             let label = "inv"

             let ff_f a = error_uniop label (pack_elt a)

             let ff_arr a = Arr A.(Linalg.inv a)

             let df cp _ap at = neg cp *@ at *@ cp

             let dr _a cp ca =
               let dpt = transpose cp in
               neg dpt *@ !ca *@ dpt
           end : Siso))


    and inv a = Lazy.force _inv a

    and softplus x = log (pack_flt 1. + exp x)

    and softsign x = x / (pack_flt 1. + abs x)

    and softmax ?(axis = -1) x =
      let c = Arr A.(max ~axis (unpack_arr x)) in
      let y = exp (x - c) in
      let a = sum ~axis y in
      y / a


    and _reshape =
      lazy
        (fun a s ->
          build_siso
            (module struct
              let label = "reshape"

              let ff_f a = error_uniop label (pack_elt a)

              let ff_arr a = Arr A.(reshape a s)

              let df _cp _ap at = reshape at s

              let dr a _cp ca = reshape !ca (shape (primal a))
            end : Siso)
            a)


    and reshape a = Lazy.force _reshape a

    and flatten a = reshape a [| 1; numel a |]

    and get_item a i j =
      match a with
      | Arr ap                  -> F (A.get ap [| i; j |])
      | DF (ap, at, ai)         -> DF (get_item ap i j, get_item at i j, ai)
      | DR (ap, _, _, _, ai, _) ->
        let reverse _ap ca t = (set_item (zero a) i j (sum' !ca), a) :: t in
        let input t = a :: t in
        let label = "Get_Item", [ a ] in
        DR (get_item ap i j, ref (pack_flt 0.), (reverse, input, label), ref 0, ai, ref 0)
      | _                       -> error_uniop "get_item" a


    and _get_row =
      lazy
        (fun a i ->
          build_siso
            (module struct
              let label = "get_row"

              let ff_f a = error_uniop label (pack_elt a)

              let ff_arr a = Arr A.(row a i |> copy)

              let df _cp _ap at = get_row at i

              let dr a _cp ca =
                adjref a := add_row (adjval a) !ca i;
                zero a
            end : Siso)
            a)


    and get_row a = Lazy.force _get_row a

    (* pair inputs single output operations *)
    and ( + ) a b = add a b

    and _add =
      lazy
        (build_piso
           (module struct
             let label = "add"

             let ff_aa a b = F A.Scalar.(add a b)

             let ff_ab a b = Arr A.(scalar_add a b)

             let ff_ba a b = Arr A.(add_scalar a b)

             let ff_bb a b = Arr A.(add a b)

             let df_da _cp _ap at _bp = at

             let df_db _cp _ap _bp bt = bt

             let df_dab _cp _ap at _bp bt = at + bt

             let dr_ab a b _cp ca =
               _squeeze_broadcast !ca (shape a), _squeeze_broadcast !ca (shape b)


             let dr_a a _b _cp ca = _squeeze_broadcast !ca (shape a)

             let dr_b _a b _cp ca = _squeeze_broadcast !ca (shape b)
           end : Piso))


    and add a = Lazy.force _add a

    and ( - ) a b = sub a b

    and _sub =
      lazy
        (build_piso
           (module struct
             let label = "sub"

             let ff_aa a b = F A.Scalar.(sub a b)

             let ff_ab a b = Arr A.(scalar_sub a b)

             let ff_ba a b = Arr A.(sub_scalar a b)

             let ff_bb a b = Arr A.(sub a b)

             let df_da _cp _ap at _bp = at

             let df_db _cp _ap _bp bt = neg bt

             let df_dab _cp _ap at _bp bt = at - bt

             let dr_ab a b _cp ca =
               _squeeze_broadcast !ca (shape a), neg (_squeeze_broadcast !ca (shape b))


             let dr_a a _b _cp ca = _squeeze_broadcast !ca (shape a)

             let dr_b _a b _cp ca = neg (_squeeze_broadcast !ca (shape b))
           end : Piso))


    and sub a = Lazy.force _sub a

    and ( * ) a b = mul a b

    and _mul =
      lazy
        (build_piso
           (module struct
             let label = "mul"

             let ff_aa a b = F A.Scalar.(mul a b)

             let ff_ab a b = Arr A.(scalar_mul a b)

             let ff_ba a b = Arr A.(mul_scalar a b)

             let ff_bb a b = Arr A.(mul a b)

             let df_da _cp _ap at bp = at * bp

             let df_db _cp ap _bp bt = ap * bt

             let df_dab _cp ap at bp bt = (ap * bt) + (at * bp)

             let dr_ab a b _cp ca =
               ( _squeeze_broadcast (!ca * primal b) (shape a)
               , _squeeze_broadcast (!ca * primal a) (shape b) )


             let dr_a a b _cp ca = _squeeze_broadcast (!ca * b) (shape a)

             let dr_b a b _cp ca = _squeeze_broadcast (!ca * a) (shape b)
           end : Piso))


    and mul a = Lazy.force _mul a

    and ( / ) a b = div a b

    and _div =
      lazy
        (build_piso
           (module struct
             let label = "div"

             let ff_aa a b = F A.Scalar.(div a b)

             let ff_ab a b = Arr A.(scalar_div a b)

             let ff_ba a b = Arr A.(div_scalar a b)

             let ff_bb a b = Arr A.(div a b)

             let df_da _cp _ap at bp = at / bp

             let df_db cp _ap bp bt = neg bt * cp / bp

             let df_dab cp _ap at bp bt = (at - (bt * cp)) / bp

             let dr_ab a b _cp ca =
               ( _squeeze_broadcast (!ca / primal b) (shape a)
               , _squeeze_broadcast
                   (!ca * (neg (primal a) / (primal b * primal b)))
                   (shape b) )


             let dr_a a b _cp ca = _squeeze_broadcast (!ca / b) (shape a)

             let dr_b a b _cp ca =
               _squeeze_broadcast (!ca * (neg a / (primal b * primal b))) (shape b)
           end : Piso))


    and div a = Lazy.force _div a

    and kron a b =
      let na, ma =
        let s = shape a in
        s.(0), s.(1)
      in
      let nb, mb =
        let s = shape b in
        s.(0), s.(1)
      in
      let a = reshape a [| -1; 1 |] in
      let b = reshape b [| 1; -1 |] in
      let c = a *@ b in
      let c = reshape c [| na; ma; nb; mb |] in
      let c = transpose ~axis:[| 0; 2; 1; 3 |] c in
      reshape c [| Stdlib.(na * nb); Stdlib.(ma * mb) |]


    and ( ** ) a b = pow a b

    and _pow =
      lazy
        (build_piso
           (module struct
             let label = "pow"

             let ff_aa a b = F A.Scalar.(pow a b)

             let ff_ab a b = Arr A.(scalar_pow a b)

             let ff_ba a b = Arr A.(pow_scalar a b)

             let ff_bb a b = Arr A.(pow a b)

             let df_da _cp ap at bp = at * (ap ** (bp - pack_flt 1.)) * bp

             let df_db cp ap _bp bt = bt * cp * log ap

             let df_dab cp ap at bp bt =
               ((ap ** (bp - pack_flt 1.)) * (at * bp)) + (cp * bt * log ap)


             let dr_ab a b cp ca =
               ( _squeeze_broadcast
                   (!ca * (primal a ** (primal b - pack_flt 1.)) * primal b)
                   (shape a)
               , _squeeze_broadcast (!ca * cp * log (primal a)) (shape b) )


             let dr_a a b _cp ca =
               _squeeze_broadcast
                 (!ca * (primal a ** (primal b - pack_flt 1.)) * b)
                 (shape a)


             let dr_b a b cp ca = _squeeze_broadcast (!ca * cp * log (primal a)) (shape b)
           end : Piso))


    and pow a = Lazy.force _pow a

    and _atan2 =
      lazy
        (build_piso
           (module struct
             let label = "atan2"

             let ff_aa a b = F A.Scalar.(atan2 a b)

             let ff_ab a b = Arr A.(scalar_atan2 a b)

             let ff_ba a b = Arr A.(atan2_scalar a b)

             let ff_bb a b = Arr A.(atan2 a b)

             let df_da _cp ap at bp = at * bp / (sqr ap + sqr bp)

             let df_db _cp ap bp bt = neg bt * ap / (sqr ap + sqr bp)

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
           end : Piso))


    and atan2 a = Lazy.force _atan2 a

    and min2 a b = (a + b - abs (a - b)) / pack_flt 2.

    and max2 a b = (a + b + abs (b - a)) / pack_flt 2.

    and _set_item =
      lazy
        (fun a i j b ->
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

              let df_da _cp _ap at _bp = set_item at i j (pack_flt 0.)

              let df_db _cp _ap _bp bt = add_item (zero a) i j bt

              let df_dab _cp _ap at _bp bt = set_item at i j bt

              let dr_ab _a _b _cp ca = set_item !ca i j (pack_flt 0.), get_item !ca i j

              let dr_a _a _b _cp ca = set_item !ca i j (pack_flt 0.)

              let dr_b _a _b _cp ca = get_item !ca i j
            end : Piso)
            a
            b)


    and set_item a = Lazy.force _set_item a

    and _add_item =
      lazy
        (fun a i j b ->
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

              let df_da _cp _ap at _bp = at

              let df_db _cp ap _bp bt = add_item (zero ap) i j bt

              let df_dab _cp _ap at _bp bt = add_item at i j bt

              let dr_ab _a _b _cp ca = !ca, get_item !ca i j

              let dr_a _a _b _cp ca = !ca

              let dr_b _a _b _cp ca = get_item !ca i j
            end : Piso)
            a
            b)


    and add_item a = Lazy.force _add_item a

    and _set_slice =
      lazy
        (fun i ->
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


              let df_da _cp _ap at bp = set_slice i at (zero bp)

              let df_db _cp ap _bp bt = set_slice i (zero ap) bt

              let df_dab _cp _ap at _bp bt = set_slice i at bt

              let dr_ab _a b _cp ca = set_slice i !ca (zero b), get_slice i !ca

              let dr_a _a b _cp ca = set_slice i !ca (zero b)

              let dr_b _a _b _cp ca = get_slice i !ca
            end : Piso))


    and set_slice i = Lazy.force _set_slice i

    and ( *@ ) a b = dot a b

    and _dot =
      lazy
        (build_piso
           (module struct
             let label = "dot"

             let ff_aa a _b = error_uniop label (pack_elt a)

             let ff_ab a _b = error_uniop label (pack_elt a)

             let ff_ba _a b = error_uniop label (pack_elt b)

             let ff_bb a b = Arr A.(dot a b)

             let df_da _cp _ap at bp = at *@ bp

             let df_db _cp ap _bp bt = ap *@ bt

             let df_dab _cp ap at bp bt = (ap *@ bt) + (at *@ bp)

             let dr_ab a b _cp ca =
               dot !ca (transpose (primal b)), dot (transpose (primal a)) !ca


             let dr_a _a b _cp ca = dot !ca (transpose (primal b))

             let dr_b a _b _cp ca = dot (transpose (primal a)) !ca
           end : Piso))


    and dot a = Lazy.force _dot a

    and cross_entropy x y = x * log y |> sum' |> neg

    and _add_row =
      lazy
        (fun a b i ->
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


              let df_da _cp _ap at _bp = at

              let df_db _cp ap _bp bt = add_row (zero ap) bt i

              let df_dab _cp _ap at _bp bt = add_row at bt i

              let dr_ab _a _b _cp ca = !ca, get_row !ca i

              let dr_a _a _b _cp ca = !ca

              let dr_b _a _b _cp ca = get_row !ca i
            end : Piso)
            a
            b)


    and add_row a = Lazy.force _add_row a

    and _concat axis =
      lazy
        (build_piso
           (module struct
             let label = "concat"

             let ff_aa a _b = error_uniop label (pack_elt a)

             let ff_ab a _b = error_uniop label (pack_elt a)

             let ff_ba _a b = error_uniop label (pack_elt b)

             let ff_bb a b = Arr A.(concatenate ~axis [| a; b |])

             let df_da _cp _ap at bp = concat ~axis at (zero bp)

             let df_db _cp ap _bp bt = concat ~axis (zero ap) bt

             let df_dab _cp _ap at _bp bt = concat ~axis at bt

             let dr_ab a _b _cp ca =
               let sa = shape a in
               let l = sa.(axis) in
               let dim = Array.length sa in
               ( get_slice
                   (List.init dim (fun i -> if i = axis then [ 0; pred l ] else [ 0; -1 ]))
                   !ca
               , get_slice
                   (List.init dim (fun i -> if i = axis then [ l; -1 ] else [ 0; -1 ]))
                   !ca )


             let dr_a a _b _cp ca =
               let sa = shape a in
               let l = sa.(axis) in
               let dim = Array.length sa in
               get_slice
                 (List.init dim (fun i -> if i = axis then [ 0; pred l ] else [ 0; -1 ]))
                 !ca


             let dr_b a _b _cp ca =
               let sa = shape a in
               let l = sa.(axis) in
               let dim = Array.length sa in
               get_slice
                 (List.init dim (fun i -> if i = axis then [ l; -1 ] else [ 0; -1 ]))
                 !ca
           end : Piso))


    and concat ~axis = Lazy.force (_concat axis)

    and to_rows a = Array.init (row_num a) (fun i -> get_row a i)

    and of_rows a =
      (* TODO: this can be further optimised by incorporating t array type as t *)
      match a.(0) with
      | Arr _                  -> Array.map unpack_arr a |> A.of_rows |> pack_arr
      | DF (_, _, ai)          ->
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
      | _                      -> error_uniop "of_rows a.(0)" a.(0)


    and _of_arrays =
      lazy
        (fun a ->
          (* mode: `normal , `reverse, `forward *)
          let mode = ref `normal in
          let idxs = ref [] in
          let ai_ref = ref 0 in
          a
          (* TODO: the following checks can probably be refactored into ops_builder *)
          |> Array.iteri (fun i xs ->
                 Array.iteri
                   (fun j x ->
                     match x, !mode with
                     | F _, _ -> ()
                     | Arr _, _ ->
                       error_uniop "of_arrays: array elements should be F not Arr" x
                     | DR (_, _, _, _, ai, _), `normal ->
                       mode := `reverse;
                       ai_ref := ai;
                       idxs := [ i, j ]
                     | DR (_, _, _, _, ai, _), `reverse ->
                       if ai > !ai_ref
                       then (
                         idxs := [ i, j ];
                         ai_ref := ai)
                       else if ai = !ai_ref
                       then idxs := (i, j) :: !idxs
                       else ()
                     | DR (_, _, _, _, ai, _), `forward ->
                       if ai > !ai_ref
                       then (
                         mode := `reverse;
                         idxs := [ i, j ];
                         ai_ref := ai)
                       else if ai = !ai_ref
                       then failwith "error: forward and reverse clash on the same level"
                       else ()
                     | DF (_, _, ai), `normal ->
                       mode := `forward;
                       ai_ref := ai;
                       idxs := [ i, j ]
                     | DF (_, _, ai), `reverse ->
                       if ai > !ai_ref
                       then (
                         mode := `forward;
                         idxs := [ i, j ];
                         ai_ref := ai)
                       else if ai = !ai_ref
                       then failwith "error: forward and reverse clash on the same level"
                       else ()
                     | DF (_, _, ai), `forward ->
                       if ai > !ai_ref
                       then (
                         idxs := [ i, j ];
                         ai_ref := ai)
                       else if ai = !ai_ref
                       then idxs := (i, j) :: !idxs
                       else ())
                   xs);
          match !mode with
          | `normal  -> Array.map (Array.map unpack_elt) a |> A.of_arrays |> pack_arr
          | `reverse ->
            let cp =
              Array.map
                (Array.map (fun x ->
                     match x with
                     | DR (p, _, _, _, ai, _) -> if ai = !ai_ref then p else x
                     | x                      -> x))
                a
              |> of_arrays
            in
            let idxs = List.rev !idxs in
            let reverse _cp ca t =
              let ca_arrays = to_arrays !ca in
              t
              |> List.append
                   (idxs |> List.map (fun (i, j) -> ca_arrays.(i).(j), a.(i).(j)))
            in
            let input t = List.(append (map (fun (i, j) -> a.(i).(j)) idxs) t) in
            let label = "Of_Arrays_D", List.map (fun (i, j) -> a.(i).(j)) idxs in
            DR (cp, ref (zero cp), (reverse, input, label), ref 0, !ai_ref, ref 0)
          | `forward ->
            let cp =
              Array.map
                (Array.map (fun x ->
                     match x with
                     | DF (p, _, ai) -> if ai = !ai_ref then p else x
                     | x             -> x))
                a
              |> of_arrays
            in
            let at =
              let at = Array.map (Array.map zero) a in
              List.iter (fun (i, j) -> at.(i).(j) <- tangent a.(i).(j)) !idxs;
              at |> of_arrays
            in
            DF (cp, at, !ai_ref))


    and of_arrays a = Lazy.force _of_arrays a

    and to_arrays a =
      Array.init (row_num a) (fun i -> Array.init (col_num a) (fun j -> get_item a i j))


    and _split =
      lazy
        (fun ~axis parts ->
          build_siao
            (module struct
              let label = "split"

              let ff_f a = error_uniop "label" (pack_elt a)

              let ff_arr a = A.(split ~axis parts a) |> Array.map (fun x -> Arr x)

              let df _cp _ap _at =
                raise (Owl_exception.NOT_IMPLEMENTED "owl_algodiff_ops.split")


              let dr _a _cp _cp_ref_arr ca_ref_arr =
                concatenate ~axis (Array.map (fun ca -> !ca) ca_ref_arr)
            end : Siao))


    and split ~axis parts = Lazy.force _split ~axis parts

    and _concatenate =
      lazy
        (fun ~axis ->
          build_aiso
            (module struct
              let label = "Concatenate_D"

              let ff a = Array.map unpack_arr a |> A.concatenate ~axis |> pack_arr

              let df _ _ _ tangents = concatenate ~axis tangents

              let dr idxs ap _ ca =
                let ca = split ~axis (Array.map (fun x -> (shape x).(axis)) ap) !ca in
                List.map (fun k -> ca.(k)) idxs
            end : Aiso))


    and concatenate ~axis = Lazy.force _concatenate ~axis

    and _stack =
      lazy
        (fun ~axis ->
          build_aiso
            (module struct
              let label = "Stack_D"

              let ff a = Array.map unpack_arr a |> A.stack ~axis |> pack_arr

              let df _ _ _ tangents = stack ~axis tangents

              let dr idxs ap _ ca =
                let shp = shape !ca in
                let ndim = Array.length shp in
                let axis = Owl_utils.adjust_index axis ndim in
                let inp_shp = shape ap.(0) in
                let ca =
                  split ~axis (Array.make shp.(axis) 1) !ca
                  |> Array.map (fun x -> reshape x inp_shp)
                in
                List.map (fun k -> ca.(k)) idxs
            end : Aiso))


    and stack ~axis = Lazy.force _stack ~axis
  end

  module Linalg = struct
    open Maths

    (* single input single output *)

    let rec inv = Maths.inv

    and _logdet =
      lazy
        (build_siso
           (module struct
             let label = "logdet"

             let ff_f a = error_uniop label (pack_elt a)

             let ff_arr a = F A.(Linalg.logdet a)

             let df _cp ap at = trace (transpose (inv ap) *@ at)

             let dr a _cp ca = !ca * transpose (inv (primal a))
           end : Siso))


    and logdet a = Lazy.force _logdet a

    and copyltu x = tril x + transpose (tril ~k:(-1) x)

    and copyutl x = triu x + transpose (triu ~k:1 x)

    and _chol =
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
      lazy
        (fun ~upper ->
          build_siso
            (module struct
              let label = "chol"

              let ff_f a = error_uniop "chol" (pack_elt a)

              let ff_arr a = Arr A.(Linalg.chol ~upper a)

              let df cp _ap at = _chol_forward cp at upper

              let dr _a cp ca = _chol_backward cp !ca upper
            end : Siso))


    and chol ?(upper = true) = Lazy.force _chol ~upper

    (* single input pair outputs *)
    and _qr =
      let _qr_backward (cp1, cp2) (ca1, ca2) =
        let q = !cp1
        and r = !cp2
        and qbar = !ca1
        and rbar = !ca2 in
        let m = (rbar *@ transpose r) - (transpose q *@ qbar) in
        linsolve r (transpose (qbar + (q *@ copyutl m))) |> transpose
      in
      lazy
        (build_sipo
           (module struct
             let label = "qr"

             let ff_f a = error_uniop "qr" (pack_elt a)

             let ff_arr a =
               let q, r = A.(Linalg.qr a) in
               Arr q, Arr r


             let df _cp _ap _at =
               raise (Owl_exception.NOT_IMPLEMENTED "owl_algodiff_ops.qr")


             let dr _a _cp cp_ref ca_ref = _qr_backward cp_ref ca_ref
           end : Sipo))


    and qr a = Lazy.force _qr a

    and _lq =
      let _lq_backward (o1, o2) (ca1, ca2) =
        let l = !o1
        and q = !o2
        and lbar = !ca1
        and qbar = !ca2 in
        let m = (transpose l *@ lbar) - (qbar *@ transpose q) in
        linsolve ~trans:true ~typ:`l l (qbar + (copyltu m *@ q))
      in
      lazy
        (build_sipo
           (module struct
             let label = "lq"

             let ff_f a = error_uniop "lq" (pack_elt a)

             let ff_arr a =
               let l, q = A.(Linalg.lq a) in
               Arr l, Arr q


             let df _cp _ap _at =
               raise (Owl_exception.NOT_IMPLEMENTED "owl_algodiff_ops.lq")


             let dr _a _cp o ca = _lq_backward o ca
           end : Sipo))


    and lq a = Lazy.force _lq a

    (* single input triple outputs *)
    and _svd =
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
        if thin
        then
          (u * sbar *@ vt)
          + (((u *@ (f * ((ut *@ ubar) - (ubart *@ u))) * s)
             + ((e_m - (u *@ ut)) *@ ubar * inv_s))
            *@ vt)
          + (u
            *@ ((transpose s * (f * ((vt *@ vbar) - (vbart *@ v))) *@ vt)
               + (transpose inv_s * vbart *@ (e_n - (v *@ vt)))))
        else raise (Owl_exception.NOT_IMPLEMENTED "owl_algodiff_ops.svd")
      in
      lazy
        (fun ~thin ->
          build_sito
            (module struct
              let label = "svd"

              let ff_f a = error_uniop "svd" (pack_elt a)

              let ff_arr a =
                let u, s, vt = A.(Linalg.svd ~thin a) in
                Arr u, Arr s, Arr vt


              let df _cp _ap _at =
                raise (Owl_exception.NOT_IMPLEMENTED "owl_algodiff_ops.svd")


              let dr _a _cp o ca = _svd_backward o ca thin
            end : Sito))


    and svd ?(thin = true) = Lazy.force _svd ~thin

    and _sylvester =
      lazy
        (let unpack a = a.(0), a.(1), a.(2) in
         let sylv_forward p a b _c at bt ct =
           let dp_da () = sylvester a b (neg at *@ p) in
           let dp_db () = sylvester a b (neg p *@ bt) in
           let dp_dc () = sylvester a b ct in
           [| dp_da; dp_db; dp_dc |]
         in
         let sylv_backward a b _c p pbar =
           let st = sylvester (transpose a) (transpose b) (neg pbar) in
           (* the following calculations are not calculated unless needed *)
           let abar () = st *@ transpose p in
           let bbar () = transpose p *@ st in
           let cbar () = neg st in
           [| abar; bbar; cbar |]
         in
         build_aiso
           (module struct
             let label = "sylvester"

             let ff a =
               match unpack a with
               | Arr a, Arr b, Arr c -> A.Linalg.sylvester a b c |> pack_arr
               | _                   -> error_uniop "sylvester" a.(0)


             let df idxs p inp tangents =
               let a, b, c = unpack inp in
               let at, bt, ct = unpack tangents in
               let dp = sylv_forward p a b c at bt ct in
               List.map (fun k -> dp.(k) ()) idxs |> List.fold_left ( + ) (pack_flt 0.)


             let dr idxs inp p pbar_ref =
               let pbar = !pbar_ref in
               let bars =
                 let a, b, c = unpack inp in
                 sylv_backward a b c p pbar
               in
               List.map
                 (fun k ->
                   let bar = bars.(k) in
                   bar ())
                 idxs
           end : Aiso))


    and sylvester a b c = Lazy.force _sylvester [| a; b; c |]

    (* pair outputs single input *)
    and _lyapunov =
      let _lyapunov_backward_a a ca cp =
        let s = lyapunov (transpose a) (neg ca) in
        pack_flt 2. * s *@ cp
      in
      let _lyapunov_backward_q a ca = neg (lyapunov (transpose a) (neg ca)) in
      let _lyapunov_backward_aq a ca cp =
        let s = lyapunov (transpose a) (neg ca) in
        pack_flt 2. * s *@ cp, neg s
      in
      lazy
        (build_piso
           (module struct
             let label = "lyapunov"

             let ff_aa a _q = error_uniop label (pack_elt a)

             let ff_ab a _q = error_uniop label (pack_elt a)

             let ff_ba _a q = error_uniop label (pack_elt q)

             let ff_bb a q = Arr A.(Linalg.lyapunov a q)

             let df_da cp ap at _qp =
               lyapunov ap (neg ((at *@ cp) + (cp *@ transpose at)))


             let df_db _cp ap _qp qt = lyapunov ap qt

             let df_dab cp ap at _qp qt =
               lyapunov ap (neg ((at *@ cp) + (cp *@ transpose at))) + lyapunov ap qt


             let dr_ab a _b cp ca =
               let abar, qbar = _lyapunov_backward_aq (primal a) !ca cp in
               abar, qbar


             let dr_a a _q cp ca = _lyapunov_backward_a (primal a) !ca cp

             let dr_b a _q _cp ca = _lyapunov_backward_q (primal a) !ca
           end : Piso))


    and lyapunov a = Lazy.force _lyapunov a

    and _discrete_lyapunov =
      let _discrete_lyapunov_backward_a a ca cp =
        let s = discrete_lyapunov (transpose a) ca in
        pack_flt 2. * s *@ a *@ cp
      in
      let _discrete_lyapunov_backward_q a ca = discrete_lyapunov (transpose a) ca in
      let _discrete_lyapunov_backward_aq a ca cp =
        let s = discrete_lyapunov (transpose a) ca in
        pack_flt 2. * s *@ a *@ cp, s
      in
      lazy
        (fun ~solver ->
          build_piso
            (module struct
              let label = "discrete_lyapunov"

              let ff_aa a _q = error_uniop label (pack_elt a)

              let ff_ab a _q = error_uniop label (pack_elt a)

              let ff_ba _a q = error_uniop label (pack_elt q)

              let ff_bb a q = Arr A.(Linalg.discrete_lyapunov ~solver a q)

              let df_da cp ap at _qp =
                let g = ap *@ cp *@ transpose at in
                discrete_lyapunov ap (g + transpose g)


              let df_db _cp ap _qp qt = discrete_lyapunov ap qt

              let df_dab cp ap at _qp qt =
                let g = ap *@ cp *@ transpose at in
                discrete_lyapunov ap (g + transpose g) + discrete_lyapunov ap qt


              let dr_ab a _b cp ca =
                let abar, qbar = _discrete_lyapunov_backward_aq (primal a) !ca cp in
                abar, qbar


              let dr_a a _q cp ca = _discrete_lyapunov_backward_a (primal a) !ca cp

              let dr_b a _q _cp ca = _discrete_lyapunov_backward_q (primal a) !ca
            end : Piso))


    and discrete_lyapunov ?(solver = `default) = Lazy.force _discrete_lyapunov ~solver

    and ( /@ ) a b = linsolve ~trans:false ~typ:`n a b

    and _linsolve =
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
      lazy
        (fun ~trans ~typ ->
          build_piso
            (module struct
              let label = "linsolve"

              let ff_aa a _q = error_uniop label (pack_elt a)

              let ff_ab a _q = error_uniop label (pack_elt a)

              let ff_ba _a q = error_uniop label (pack_elt q)

              let ff_bb a q = Arr A.(Linalg.linsolve ~trans ~typ a q)

              let df_da cp ap at _qp =
                linsolve
                  ~trans
                  ap
                  (if trans then neg (transpose at) *@ cp else neg at *@ cp)


              let df_db _cp ap _bp bt = linsolve ~trans ap bt

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
            end : Piso))


    and linsolve ?(trans = false) ?(typ = `n) = Lazy.force _linsolve ~trans ~typ

    and _care =
      lazy
        (let unpack a = a.(0), a.(1), a.(2), a.(3) in
         let care_forward ~diag_r p a b r at bt qt rt =
           let tr_b = transpose b in
           let r = if diag_r then diag r else r in
           let inv_r = if diag_r then pack_flt 1. / r else inv r in
           let atilde =
             if diag_r then a - (b * inv_r *@ tr_b *@ p) else a - (b *@ inv_r *@ tr_b *@ p)
           in
           let tr_atilde = transpose atilde in
           let dp_da () =
             let pat = p *@ at in
             lyapunov tr_atilde (neg (transpose pat) - pat)
           in
           let dp_dq () = lyapunov tr_atilde (neg qt) in
           let dp_dr () =
             let pbinv_r = if diag_r then p *@ (b * inv_r) else p *@ b *@ inv_r in
             lyapunov tr_atilde (neg (pbinv_r *@ rt *@ transpose pbinv_r))
           in
           let dp_db () =
             let x =
               if diag_r
               then p *@ (bt * inv_r) *@ tr_b *@ p
               else p *@ bt *@ inv_r *@ tr_b *@ p
             in
             lyapunov tr_atilde (x + transpose x)
           in
           [| dp_da; dp_db; dp_dq; dp_dr |]
         in
         let care_backward ~diag_r a b _q r p pbar =
           let tr_b = transpose b in
           let inv_r = if diag_r then pack_flt 1. / diag r else inv r in
           let atilde =
             if diag_r then a - (b * inv_r *@ tr_b *@ p) else a - (b *@ inv_r *@ tr_b *@ p)
           in
           let s = lyapunov atilde (neg pbar) in
           (* the following calculations are not calculated unless needed *)
           let qbar () = s in
           let rbar () =
             let pbinv_r = if diag_r then p *@ (b * inv_r) else p *@ b *@ inv_r in
             transpose pbinv_r *@ s *@ pbinv_r
           in
           let abar () = pack_flt 2. * p *@ s in
           let bbar () =
             if diag_r
             then neg (pack_flt 2.) * p *@ s *@ p *@ (b * inv_r)
             else neg (pack_flt 2.) * p *@ s *@ p *@ b *@ inv_r
           in
           [| abar; bbar; qbar; rbar |]
         in
         fun ~diag_r ->
           build_aiso
             (module struct
               let label = "care"

               let ff a =
                 match unpack a with
                 | Arr a, Arr b, Arr q, Arr r -> A.Linalg.care ~diag_r a b q r |> pack_arr
                 | _                          -> error_uniop "care" a.(0)


               let df idxs p inp tangents =
                 let a, b, _, r = unpack inp in
                 let at, bt, qt, rt = unpack tangents in
                 let dp = care_forward ~diag_r p a b r at bt qt rt in
                 List.map (fun k -> dp.(k) ()) idxs |> List.fold_left ( + ) (pack_flt 0.)


               let dr idxs inp p pbar_ref =
                 let pbar = !pbar_ref in
                 let bars =
                   let a, b, q, r = unpack inp in
                   care_backward ~diag_r a b q r p pbar
                 in
                 List.map (fun k -> bars.(k) ()) idxs
             end : Aiso))


    and care ?(diag_r = false) a b q r = Lazy.force _care ~diag_r [| a; b; q; r |]
  end

  (* neural network module: for specialised neural network operations *)
  module NN = struct
    open Maths

    (* NOTE: these functions are for neural network. There are many restrictions at the
       moment. E.g. they do not support higher-order derivatives, and some do not support
       forward mode, so use them when you know what you are doing. *)

    let dropout ?(rate = 0.5) a =
      let p = A.float_to_elt (1. -. rate) in
      let b =
        match primal' a with
        | Arr a -> Arr (A.bernoulli ~p (A.shape a))
        | _     -> error_uniop "dropout" a
      in
      a * b


    (* a:input; b:kernel; s:stride *)
    let _conv1d =
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
      lazy
        (fun ~padding a b s ->
          build_piso
            (module struct
              let label = "conv1d"

              let ff_aa a _b = error_uniop label (pack_elt a)

              let ff_ab a _b = error_uniop label (pack_elt a)

              let ff_ba _a b = error_uniop label (pack_elt b)

              let ff_bb a b = Arr A.(conv1d ?padding a b s)

              let df_da _cp _ap at _bp = at

              let df_db _cp _ap _bp bt = bt

              let df_dab _cp _ap at _bp bt = at + bt

              let dr_ab a b _cp ca =
                conv1d_backward_input a b s !ca, conv1d_backward_kernel a b s !ca


              let dr_a a b _cp ca = conv1d_backward_input a b s !ca

              let dr_b a b _cp ca = conv1d_backward_kernel a b s !ca
            end : Piso)
            a
            b)


    let conv1d ?padding = Lazy.force _conv1d ~padding

    (* a:input; b:kernel; s:stride *)
    let _conv2d =
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
      lazy
        (fun ~padding a b s ->
          build_piso
            (module struct
              let label = "conv2d"

              let ff_aa a _b = error_uniop label (pack_elt a)

              let ff_ab a _b = error_uniop label (pack_elt a)

              let ff_ba _a b = error_uniop label (pack_elt b)

              let ff_bb a b = Arr A.(conv2d ?padding a b s)

              let df_da _cp _ap at _bp = at

              let df_db _cp _ap _bp bt = bt

              let df_dab _cp _ap at _bp bt = at + bt

              let dr_ab a b _cp ca =
                conv2d_backward_input a b s !ca, conv2d_backward_kernel a b s !ca


              let dr_a a b _cp ca = conv2d_backward_input a b s !ca

              let dr_b a b _cp ca = conv2d_backward_kernel a b s !ca
            end : Piso)
            a
            b)


    let conv2d ?padding = Lazy.force _conv2d ~padding

    (* a:input; b:kernel; s:stride *)
    let _conv3d =
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
      lazy
        (fun ~padding a b s ->
          build_piso
            (module struct
              let label = "conv3d"

              let ff_aa a _b = error_uniop label (pack_elt a)

              let ff_ab a _b = error_uniop label (pack_elt a)

              let ff_ba _a b = error_uniop label (pack_elt b)

              let ff_bb a b = Arr A.(conv3d ?padding a b s)

              let df_da _cp _ap at _bp = at

              let df_db _cp _ap _bp bt = bt

              let df_dab _cp _ap at _bp bt = at + bt

              let dr_ab a b _cp ca =
                conv3d_backward_input a b s !ca, conv3d_backward_kernel a b s !ca


              let dr_a a b _cp ca = conv3d_backward_input a b s !ca

              let dr_b a b _cp ca = conv3d_backward_kernel a b s !ca
            end : Piso)
            a
            b)


    let conv3d ?padding = Lazy.force _conv3d ~padding

    (* a:input; b:kernel; s:stride; r:rate *)
    let _dilated_conv1d =
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
      lazy
        (fun ~padding a b s r ->
          build_piso
            (module struct
              let label = "dilated_conv1d"

              let ff_aa a _b = error_uniop label (pack_elt a)

              let ff_ab a _b = error_uniop label (pack_elt a)

              let ff_ba _a b = error_uniop label (pack_elt b)

              let ff_bb a b = Arr A.(dilated_conv1d ?padding a b s r)

              let df_da _cp _ap at _bp = at

              let df_db _cp _ap _bp bt = bt

              let df_dab _cp _ap at _bp bt = at + bt

              let dr_ab a b _cp ca =
                ( dilated_conv1d_backward_input a b s r !ca
                , dilated_conv1d_backward_kernel a b s r !ca )


              let dr_a a b _cp ca = dilated_conv1d_backward_input a b s r !ca

              let dr_b a b _cp ca = dilated_conv1d_backward_kernel a b s r !ca
            end : Piso)
            a
            b)


    let dilated_conv1d ?padding = Lazy.force _dilated_conv1d ~padding

    (* a:input; b:kernel; s:stride; r:rate *)
    let _dilated_conv2d =
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
      lazy
        (fun ~padding a b s r ->
          build_piso
            (module struct
              let label = "dilated_conv2d"

              let ff_aa a _b = error_uniop label (pack_elt a)

              let ff_ab a _b = error_uniop label (pack_elt a)

              let ff_ba _a b = error_uniop label (pack_elt b)

              let ff_bb a b = Arr A.(dilated_conv2d ?padding a b s r)

              let df_da _cp _ap at _bp = at

              let df_db _cp _ap _bp bt = bt

              let df_dab _cp _ap at _bp bt = at + bt

              let dr_ab a b _cp ca =
                ( dilated_conv2d_backward_input a b s r !ca
                , dilated_conv2d_backward_kernel a b s r !ca )


              let dr_a a b _cp ca = dilated_conv2d_backward_input a b s r !ca

              let dr_b a b _cp ca = dilated_conv2d_backward_kernel a b s r !ca
            end : Piso)
            a
            b)


    let dilated_conv2d ?padding = Lazy.force _dilated_conv2d ~padding

    (* a:input; b:kernel; s:stride; r:rate *)
    let _dilated_conv3d =
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
      lazy
        (fun ~padding a b s r ->
          build_piso
            (module struct
              let label = "dilated_conv3d"

              let ff_aa a _b = error_uniop label (pack_elt a)

              let ff_ab a _b = error_uniop label (pack_elt a)

              let ff_ba _a b = error_uniop label (pack_elt b)

              let ff_bb a b = Arr A.(dilated_conv3d ?padding a b s r)

              let df_da _cp _ap at _bp = at

              let df_db _cp _ap _bp bt = bt

              let df_dab _cp _ap at _bp bt = at + bt

              let dr_ab a b _cp ca =
                ( dilated_conv3d_backward_input a b s r !ca
                , dilated_conv3d_backward_kernel a b s r !ca )


              let dr_a a b _cp ca = dilated_conv3d_backward_input a b s r !ca

              let dr_b a b _cp ca = dilated_conv3d_backward_kernel a b s r !ca
            end : Piso)
            a
            b)


    let dilated_conv3d ?padding = Lazy.force _dilated_conv3d ~padding

    (* a:input; b:kernel; s:stride *)
    let _transpose_conv1d =
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
      lazy
        (fun ~padding a b s ->
          build_piso
            (module struct
              let label = "transpose_conv1d"

              let ff_aa a _b = error_uniop label (pack_elt a)

              let ff_ab a _b = error_uniop label (pack_elt a)

              let ff_ba _a b = error_uniop label (pack_elt b)

              let ff_bb a b = Arr A.(transpose_conv1d ?padding a b s)

              let df_da _cp _ap at _bp = at

              let df_db _cp _ap _bp bt = bt

              let df_dab _cp _ap at _bp bt = at + bt

              let dr_ab a b _cp ca =
                ( transpose_conv1d_backward_input a b s !ca
                , transpose_conv1d_backward_kernel a b s !ca )


              let dr_a a b _cp ca = transpose_conv1d_backward_input a b s !ca

              let dr_b a b _cp ca = transpose_conv1d_backward_kernel a b s !ca
            end : Piso)
            a
            b)


    let transpose_conv1d ?padding = Lazy.force _transpose_conv1d ~padding

    (* a:input; b:kernel; s:stride *)
    and _transpose_conv2d =
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
      lazy
        (fun ~padding a b s ->
          build_piso
            (module struct
              let label = "transpose_conv2d"

              let ff_aa a _b = error_uniop label (pack_elt a)

              let ff_ab a _b = error_uniop label (pack_elt a)

              let ff_ba _a b = error_uniop label (pack_elt b)

              let ff_bb a b = Arr A.(transpose_conv2d ?padding a b s)

              let df_da _cp _ap at _bp = at

              let df_db _cp _ap _bp bt = bt

              let df_dab _cp _ap at _bp bt = at + bt

              let dr_ab a b _cp ca =
                ( transpose_conv2d_backward_input a b s !ca
                , transpose_conv2d_backward_kernel a b s !ca )


              let dr_a a b _cp ca = transpose_conv2d_backward_input a b s !ca

              let dr_b a b _cp ca = transpose_conv2d_backward_kernel a b s !ca
            end : Piso)
            a
            b)


    let transpose_conv2d ?padding = Lazy.force _transpose_conv2d ~padding

    (* a:input; b:kernel; s:stride *)
    let _transpose_conv3d =
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
      lazy
        (fun ~padding a b s ->
          build_piso
            (module struct
              let label = "transpose_conv3d"

              let ff_aa a _b = error_uniop label (pack_elt a)

              let ff_ab a _b = error_uniop label (pack_elt a)

              let ff_ba _a b = error_uniop label (pack_elt b)

              let ff_bb a b = Arr A.(transpose_conv3d ?padding a b s)

              let df_da _cp _ap at _bp = at

              let df_db _cp _ap _bp bt = bt

              let df_dab _cp _ap at _bp bt = at + bt

              let dr_ab a b _cp ca =
                ( transpose_conv3d_backward_input a b s !ca
                , transpose_conv3d_backward_kernel a b s !ca )


              let dr_a a b _cp ca = transpose_conv3d_backward_input a b s !ca

              let dr_b a b _cp ca = transpose_conv3d_backward_kernel a b s !ca
            end : Piso)
            a
            b)


    let transpose_conv3d ?padding = Lazy.force _transpose_conv3d ~padding

    (* a:input; b:kernel; s:stride *)
    let _max_pool1d =
      (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
      let max_pool1d_backward p a b s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.max_pool1d_backward p a b s o |> pack_arr
      in
      lazy
        (fun padding a b s ->
          build_siso
            (module struct
              let label = "max_pool1d"

              let ff_f a = error_uniop label (pack_elt a)

              let ff_arr a = Arr A.(max_pool1d ~padding a b s)

              let df _cp _ap _at = failwith "max_pool1d:df"

              let dr a _cp ca = max_pool1d_backward padding (primal a) b s !ca
            end : Siso)
            a)


    let max_pool1d padding = Lazy.force _max_pool1d padding

    (* a:input; b:kernel; s:stride *)
    let _max_pool2d =
      (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
      let max_pool2d_backward p a b s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.max_pool2d_backward p a b s o |> pack_arr
      in
      lazy
        (fun padding a b s ->
          build_siso
            (module struct
              let label = "max_pool2d"

              let ff_f a = error_uniop label (pack_elt a)

              let ff_arr a = Arr A.(max_pool2d ~padding a b s)

              let df _cp _ap _at = failwith "max_pool2d:df"

              let dr a _cp ca = max_pool2d_backward padding (primal a) b s !ca
            end : Siso)
            a)


    let max_pool2d padding = Lazy.force _max_pool2d padding

    (* a:input; b:kernel; s:stride *)
    let _max_pool3d =
      (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
      let max_pool3d_backward p a b s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.max_pool3d_backward p a b s o |> pack_arr
      in
      lazy
        (fun padding a b s ->
          build_siso
            (module struct
              let label = "max_pool3d"

              let ff_f a = error_uniop label (pack_elt a)

              let ff_arr a = Arr A.(max_pool3d ~padding a b s)

              let df _cp _ap _at = failwith "max_pool3d:df"

              let dr a _cp ca = max_pool3d_backward padding (primal a) b s !ca
            end : Siso)
            a)


    let max_pool3d padding = Lazy.force _max_pool3d padding

    (* a:input; b:kernel; s:stride *)
    let _avg_pool1d =
      (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
      let avg_pool1d_backward p a b s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.avg_pool1d_backward p a b s o |> pack_arr
      in
      lazy
        (fun padding a b s ->
          build_siso
            (module struct
              let label = "avg_pool1d"

              let ff_f a = error_uniop label (pack_elt a)

              let ff_arr a = Arr A.(avg_pool1d ~padding a b s)

              let df _cp _ap _at = failwith "avg_pool1d:df"

              let dr a _cp ca = avg_pool1d_backward padding (primal a) b s !ca
            end : Siso)
            a)


    let avg_pool1d padding = Lazy.force _avg_pool1d padding

    (* a:input; b:kernel; s:stride *)
    and _avg_pool2d =
      (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
      let avg_pool2d_backward p a b s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.avg_pool2d_backward p a b s o |> pack_arr
      in
      lazy
        (fun padding a b s ->
          build_siso
            (module struct
              let label = "avg_pool2d"

              let ff_f a = error_uniop label (pack_elt a)

              let ff_arr a = Arr A.(avg_pool2d ~padding a b s)

              let df _cp _ap _at = failwith "avg_pool2d:df"

              let dr a _cp ca = avg_pool2d_backward padding (primal a) b s !ca
            end : Siso)
            a)


    let avg_pool2d padding = Lazy.force _avg_pool2d padding

    (* a:input; b:kernel; s:stride *)
    let _avg_pool3d =
      (* a:input; p:padding type; b:kernel; s:stride; o:output' *)
      let avg_pool3d_backward p a b s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.avg_pool3d_backward p a b s o |> pack_arr
      in
      lazy
        (fun padding a b s ->
          build_siso
            (module struct
              let label = "avg_pool3d"

              let ff_f a = error_uniop label (pack_elt a)

              let ff_arr a = Arr A.(avg_pool3d ~padding a b s)

              let df _cp _ap _at = failwith "avg_pool3d:df"

              let dr a _cp ca = avg_pool3d_backward padding (primal a) b s !ca
            end : Siso)
            a)


    let avg_pool3d padding = Lazy.force _avg_pool3d padding

    (* a:input; s:size *)
    let _upsampling2d =
      (* a:input; s:size; o:output' *)
      let upsampling2d_backward a s o =
        let a = unpack_arr a in
        let o = unpack_arr o in
        A.upsampling2d_backward a s o |> pack_arr
      in
      lazy
        (fun a s ->
          build_siso
            (module struct
              let label = "upsampling2d"

              let ff_f a = error_uniop label (pack_elt a)

              let ff_arr a = Arr A.(upsampling2d a s)

              let df _cp _ap _at = failwith "upsampling2d:df"

              let dr a _cp ca = upsampling2d_backward (primal a) s !ca
            end : Siso)
            a)


    let upsampling2d a = Lazy.force _upsampling2d a

    (* v: padded value; p:padding index; a:input *)
    let _pad =
      (* TODO: sources required to confirm this backward op *)
      (* o:outut'; p: padding index *)
      let pad_backward o p =
        (* assume p is full legal index for pad operation *)
        let o = unpack_arr o in
        let os = A.shape o in
        let q = Owl_utils.llss2aarr p in
        Array.iteri (fun i x -> x.(1) <- Stdlib.(os.(i) - 1 - x.(1))) q;
        let q = Owl_utils.aarr2llss q in
        A.(get_slice q o) |> pack_arr
      in
      lazy
        (fun ~v p a ->
          build_siso
            (module struct
              let label = "pad"

              let ff_f a = error_uniop label (pack_elt a)

              let ff_arr a = Arr A.(pad ?v p a)

              let df _cp _ap _at = failwith "pad:df"

              let dr _a _cp ca = pad_backward !ca p
            end : Siso)
            a)


    let pad ?v = Lazy.force _pad ~v
  end

  module Mat = struct
    let empty m n = A.empty [| m; n |] |> pack_arr

    let zeros m n = A.zeros [| m; n |] |> pack_arr

    let eye n = A.Mat.eye n |> pack_arr

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
