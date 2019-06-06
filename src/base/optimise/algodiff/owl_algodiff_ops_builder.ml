module Make_Ops_Builder (Core : Owl_algodiff_core_sig.Sig) = struct
  open Core

  module type Siso = sig
    val label : string
    val ff_f : A.elt -> t
    val ff_arr : A.arr -> t
    val df : t -> t -> t -> t
    val dr : t -> t ref -> t
  end

  let build_siso (module S : Siso) a =
    let rec f a =
      let open S in
      let ff = function F a -> S.ff_f a | Arr a -> S.ff_arr a | _ -> error_uniop label a in
      let fd a = f a in
      let r a =
        let reverse ap aa t = (S.dr ap aa, a) :: t in
        let input t = a :: t in
        let label = S.label, [a] in
        reverse, input, label
      in
      op_s_s a ff fd S.df r
    in
    f a

  module type Sipo = sig
    val label : string
    val ff_f : A.elt -> t * t
    val ff_arr : A.arr -> t * t
    val df : t -> t -> t -> t
    val dr : t -> t ref * t ref -> t ref * t ref -> t
  end

  let build_sipo (module S : Sipo) a =
    let rec f a =
      let open S in
      let ff = function F a -> S.ff_f a | Arr a -> S.ff_arr a | _ -> error_uniop label a in
      let fd = f in
      let r (a, o, aa) =
        let reverse ap _aa t = (S.dr ap o aa, a) :: t in
        let input t = a :: t in
        let label = S.label, [a] in
        reverse, input, label
      in
      op_s_p a ff fd df r
    in
    f a

  module type Sito = sig
    val label : string
    val ff_f : A.elt -> t * t * t
    val ff_arr : A.arr -> t * t * t
    val df : t -> t -> t -> t
    val dr : t -> t ref * t ref * t ref -> t ref * t ref * t ref -> t
  end

  let build_sito (module S : Sito) a =
    let rec f a =
      let open S in
      let ff = function F a -> S.ff_f a | Arr a -> S.ff_arr a | _ -> error_uniop label a in
      let fd = f in
      let r (a, o, aa) =
        let reverse ap _aa t = (S.dr ap o aa, a) :: t in
        let input t = a :: t in
        let label = S.label, [a] in
        reverse, input, label
      in
      op_s_t a ff fd df r
    in
    f a

  module type Piso = sig
    val label : string
    val ff_aa : A.elt -> A.elt -> t
    val ff_ab : A.elt -> A.arr -> t
    val ff_ba : A.arr -> A.elt -> t
    val ff_bb : A.arr -> A.arr -> t
    val df_da : t -> t -> t -> t
    val df_db : t -> t -> t -> t
    val df_dab : t -> t -> t -> t -> t -> t
    val dr_ab : t -> t -> t * t
    val dr_a : t -> t -> t
    val dr_b : t -> t -> t
  end

  let build_piso (module S : Piso) a b =
    let rec f a b =
      let ff a b =
        match a, b with
        | F a, F b -> S.ff_aa a b
        | F a, Arr b -> S.ff_ab a b
        | Arr a, F b -> S.ff_ba a b
        | Arr a, Arr b -> S.ff_bb a b
        | _ -> error_binop S.label a b
      in
      let fd = f in
      let r_d_d a b =
        let reverse ap aa t =
          let aa, ba = S.dr_ab ap !aa in
          (aa, a) :: (ba, b) :: t
        in
        let input t = a :: b :: t in
        let label = S.label, [a; b] in
        reverse, input, label
      in
      let r_d_c a b =
        let reverse ap aa t = (S.dr_a ap !aa, a) :: t in
        let input t = a :: t in
        let label = S.label, [a; b] in
        reverse, input, label
      in
      let r_c_d a b =
        let reverse ap aa t = (S.dr_b ap !aa, b) :: t in
        let input t = b :: t in
        let label = S.label, [a; b] in
        reverse, input, label
      in
      op_p_s a b ff fd S.df_da S.df_db S.df_dab r_d_d r_d_c r_c_d
    in
    f a b
end
