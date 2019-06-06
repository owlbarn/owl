module Make (Core : Owl_algodiff_core_sig.Sig) = struct
  open Core

  module type Siso = sig
    val label : string
    val ff_f : A.elt -> t
    val ff_arr : A.arr -> t
    val df : t -> t -> t -> t
    val dr : t -> t -> t ref -> t
  end

  let build_siso (module S : Siso) =
    let rec f a =
      let open S in
      let ff = function
        | F a -> S.ff_f a
        | Arr a -> S.ff_arr a
        | _ -> error_uniop label a
      in
      let fd a = f a in
      let r a =
        let adjoint cp ca t = (S.dr a cp ca, a) :: t in
        let register t = a :: t in
        let label = S.label, [ a ] in
        adjoint, register, label
      in
      op_siso a ff fd S.df r
    in
    f


  module type Sipo = sig
    val label : string
    val ff_f : A.elt -> t * t
    val ff_arr : A.arr -> t * t
    val df : t -> t -> t -> t
    val dr : t -> t -> t ref * t ref -> t ref * t ref -> t
  end

  let build_sipo (module S : Sipo) a =
    let rec f a =
      let open S in
      let ff = function
        | F a -> S.ff_f a
        | Arr a -> S.ff_arr a
        | _ -> error_uniop label a
      in
      let fd = f in
      let r (a, cp_ref, ca_ref) =
        let adjoint cp _ca t = (S.dr a cp cp_ref ca_ref, a) :: t in
        let register t = a :: t in
        let label = S.label, [ a ] in
        adjoint, register, label
      in
      op_sipo a ff fd df r
    in
    f a


  module type Sito = sig
    val label : string
    val ff_f : A.elt -> t * t * t
    val ff_arr : A.arr -> t * t * t
    val df : t -> t -> t -> t
    val dr : t -> t -> t ref * t ref * t ref -> t ref * t ref * t ref -> t
  end

  let build_sito (module S : Sito) a =
    let rec f a =
      let open S in
      let ff = function
        | F a -> S.ff_f a
        | Arr a -> S.ff_arr a
        | _ -> error_uniop label a
      in
      let fd = f in
      let r (a, cp_ref, ca_ref) =
        let adjoint cp _ca t = (S.dr a cp cp_ref ca_ref, a) :: t in
        let register t = a :: t in
        let label = S.label, [ a ] in
        adjoint, register, label
      in
      op_sito a ff fd df r
    in
    f a


  module type Siao = sig
    val label : string
    val ff_f : A.elt -> t array
    val ff_arr : A.arr -> t array
    val df : t -> t -> t -> t
    val dr : t -> t -> t ref array -> t ref array -> t
  end

  let build_siao (module S : Siao) a =
    let rec f a =
      let open S in
      let ff = function
        | F a -> S.ff_f a
        | Arr a -> S.ff_arr a
        | _ -> error_uniop label a
      in
      let fd = f in
      let r (a, cp_arr_ref, ca_arr_ref) =
        let adjoint cp _ca_ref t = (S.dr a cp cp_arr_ref ca_arr_ref, a) :: t in
        let register t = a :: t in
        let label = S.label, [ a ] in
        adjoint, register, label
      in
      op_siao a ff fd df r
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
    val dr_ab : t -> t -> t -> t ref -> t * t
    val dr_a :  t -> t -> t -> t ref -> t
    val dr_b : t -> t -> t -> t ref -> t
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
        let adjoint cp ca_ref t =
          let abar, bbar = S.dr_ab a b cp ca_ref in
          (abar, a) :: (bbar, b) :: t
        in
        let register t = a :: b :: t in
        let label = S.label ^ "_d_d", [ a; b ] in
        adjoint, register, label
      in
      let r_d_c a b =
        let adjoint cp ca_ref t = (S.dr_a a b cp ca_ref, a) :: t in
        let register t = a :: t in
        let label = S.label ^ "_d_c", [ a; b ] in
        adjoint, register, label
      in
      let r_c_d a b =
        let adjoint cp ca_ref t = (S.dr_b a b cp ca_ref, b) :: t in
        let register t = b :: t in
        let label = S.label ^ "_c_d", [ a; b ] in
        adjoint, register, label
      in
      op_piso a b ff fd S.df_da S.df_db S.df_dab r_d_d r_d_c r_c_d
    in
    f a b
end
