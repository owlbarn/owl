(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module Make (Core : Owl_algodiff_core_sig.Sig) = struct
  open Core

  let cmp_tag ai bi = if ai > bi then 1 else if ai < bi then -1 else 0

  module type Siso = sig
    val label : string

    val ff_f : A.elt -> t

    val ff_arr : A.arr -> t

    val df : t -> t -> t -> t

    val dr : t -> t -> t ref -> t
  end

  let build_siso =
    (* single input single output operation *)
    let op_siso ~ff ~fd ~df ~r a =
      match a with
      | DF (ap, at, ai)         ->
        let cp = fd ap in
        DF (cp, df cp ap at, ai)
      | DR (ap, _, _, _, ai, _) ->
        let cp = fd ap in
        DR (cp, ref (zero cp), r a, ref 0, ai, ref 0)
      | ap                      -> ff ap
    in
    fun (module S : Siso) ->
      let rec f a =
        let open S in
        let ff = function
          | F a   -> S.ff_f a
          | Arr a -> S.ff_arr a
          | _     -> error_uniop label a
        in
        let fd a = f a in
        let r a =
          let adjoint cp ca t = (S.dr a cp ca, a) :: t in
          let register t = a :: t in
          let label = S.label, [ a ] in
          adjoint, register, label
        in
        op_siso ~ff ~fd ~df:S.df ~r a
      in
      f


  module type Sipo = sig
    val label : string

    val ff_f : A.elt -> t * t

    val ff_arr : A.arr -> t * t

    val df : t -> t -> t -> t

    val dr : t -> t -> t ref * t ref -> t ref * t ref -> t
  end

  let build_sipo =
    (* single input pair outputs operation *)
    let op_sipo ~ff ~fd ~df ~r a =
      match a with
      | DF (ap, at, ai)         ->
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
      | ap                      -> ff ap
    in
    fun (module S : Sipo) ->
      let rec f a =
        let open S in
        let ff = function
          | F a   -> S.ff_f a
          | Arr a -> S.ff_arr a
          | _     -> error_uniop label a
        in
        let fd = f in
        let r (a, cp_ref, ca_ref) =
          let adjoint cp _ca t = (S.dr a cp cp_ref ca_ref, a) :: t in
          let register t = a :: t in
          let label = S.label, [ a ] in
          adjoint, register, label
        in
        op_sipo ~ff ~fd ~df ~r a
      in
      f


  module type Sito = sig
    val label : string

    val ff_f : A.elt -> t * t * t

    val ff_arr : A.arr -> t * t * t

    val df : t -> t -> t -> t

    val dr : t -> t -> t ref * t ref * t ref -> t ref * t ref * t ref -> t
  end

  let build_sito =
    (* single input three outputs operation *)
    let op_sito ~ff ~fd ~df ~r a =
      match a with
      | DF (ap, at, ai)         ->
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
      | ap                      -> ff ap
    in
    fun (module S : Sito) ->
      let rec f a =
        let open S in
        let ff = function
          | F a   -> S.ff_f a
          | Arr a -> S.ff_arr a
          | _     -> error_uniop label a
        in
        let fd = f in
        let r (a, cp_ref, ca_ref) =
          let adjoint cp _ca t = (S.dr a cp cp_ref ca_ref, a) :: t in
          let register t = a :: t in
          let label = S.label, [ a ] in
          adjoint, register, label
        in
        op_sito ~ff ~fd ~df ~r a
      in
      f


  module type Siao = sig
    val label : string

    val ff_f : A.elt -> t array

    val ff_arr : A.arr -> t array

    val df : t -> t -> t -> t

    val dr : t -> t -> t ref array -> t ref array -> t
  end

  let build_siao =
    (* single input array outputs operation *)
    let op_siao ~ff ~fd ~df ~r a =
      match a with
      | DF (ap, at, ai)         ->
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
      | ap                      -> ff ap
    in
    fun (module S : Siao) ->
      let rec f a =
        let open S in
        let ff = function
          | F a   -> S.ff_f a
          | Arr a -> S.ff_arr a
          | _     -> error_uniop label a
        in
        let fd = f in
        let r (a, cp_arr_ref, ca_arr_ref) =
          let adjoint cp _ca_ref t = (S.dr a cp cp_arr_ref ca_arr_ref, a) :: t in
          let register t = a :: t in
          let label = S.label, [ a ] in
          adjoint, register, label
        in
        op_siao ~ff ~fd ~df ~r a
      in
      f


  module type Piso = sig
    val label : string

    val ff_aa : A.elt -> A.elt -> t

    val ff_ab : A.elt -> A.arr -> t

    val ff_ba : A.arr -> A.elt -> t

    val ff_bb : A.arr -> A.arr -> t

    val df_da : t -> t -> t -> t -> t

    val df_db : t -> t -> t -> t -> t

    val df_dab : t -> t -> t -> t -> t -> t

    val dr_ab : t -> t -> t -> t ref -> t * t

    val dr_a : t -> t -> t -> t ref -> t

    val dr_b : t -> t -> t -> t ref -> t
  end

  let build_piso =
    (* pair input single output operation *)
    let op_piso ~ff ~fd ~df_da ~df_db ~df_dab ~r_d_d ~r_d_c ~r_c_d a b =
      match a, b with
      | F _ap, DF (bp, bt, bi) ->
        let cp = fd a bp in
        DF (cp, df_db cp a bp bt, bi)
      | DF (ap, at, ai), F _bp ->
        let cp = fd ap b in
        DF (cp, df_da cp ap at b, ai)
      | Arr _ap, DF (bp, bt, bi) ->
        let cp = fd a bp in
        DF (cp, df_db cp a bp bt, bi)
      | DF (ap, at, ai), Arr _bp ->
        let cp = fd ap b in
        DF (cp, df_da cp ap at b, ai)
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
        | 1  ->
          let cp = fd ap b in
          DF (cp, df_da cp ap at b, ai)
        | -1 ->
          let cp = fd a bp in
          DR (cp, ref (zero cp), r_c_d a b, ref 0, bi, ref 0)
        | _  -> failwith "error: forward and reverse clash at the same level")
      | DR (ap, _, _, _, ai, _), DF (bp, bt, bi) ->
        (match cmp_tag ai bi with
        | -1 ->
          let cp = fd a bp in
          DF (cp, df_db cp a bp bt, bi)
        | 1  ->
          let cp = fd ap b in
          DR (cp, ref (zero cp), r_d_c a b, ref 0, ai, ref 0)
        | _  -> failwith "error: forward and reverse clash at the same level")
      | DF (ap, at, ai), DF (bp, bt, bi) ->
        (match cmp_tag ai bi with
        | 0 ->
          let cp = fd ap bp in
          DF (cp, df_dab cp ap at bp bt, ai)
        | 1 ->
          let cp = fd ap b in
          DF (cp, df_da cp ap at b, ai)
        | _ ->
          let cp = fd a bp in
          DF (cp, df_db cp a bp bt, bi))
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
    in
    fun (module S : Piso) ->
      let rec f a b =
        let ff a b =
          match a, b with
          | F a, F b     -> S.ff_aa a b
          | F a, Arr b   -> S.ff_ab a b
          | Arr a, F b   -> S.ff_ba a b
          | Arr a, Arr b -> S.ff_bb a b
          | _            -> error_binop S.label a b
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
        op_piso
          ~ff
          ~fd
          ~df_da:S.df_da
          ~df_db:S.df_db
          ~df_dab:S.df_dab
          ~r_d_d
          ~r_d_c
          ~r_c_d
          a
          b
      in
      f


  module type Aiso = sig
    val label : string

    val ff : t array -> t

    val df : int list -> t -> t array -> t array -> t

    val dr : int list -> t array -> t -> t ref -> t list
  end

  let build_aiso =
    let build_info =
      Array.fold_left
        (fun (i, t, m, idxs) x ->
          match m, x with
          | _, F _ | _, Arr _ -> succ i, t, m, idxs
          | `normal, DR (_, _, _, _, t', _) -> succ i, t', `reverse, [ i ]
          | `forward, DR (_, _, _, _, t', _) ->
            if t' > t
            then succ i, t', `reverse, []
            else if t' = t
            then failwith "error: forward and reverse clash on the same level"
            else succ i, t, `forward, idxs
          | `reverse, DR (_, _, _, _, t', _) ->
            if t' > t
            then succ i, t', `reverse, []
            else if t' = t
            then succ i, t', `reverse, i :: idxs
            else succ i, t, m, idxs
          | `normal, DF (_, _, t') -> succ i, t', `forward, [ i ]
          | `forward, DF (_, _, t') ->
            if t' > t
            then succ i, t', `forward, []
            else if t' = t
            then succ i, t', `forward, i :: idxs
            else succ i, t, `forward, idxs
          | `reverse, DF (_, _, t') ->
            if t' > t
            then succ i, t', `forward, []
            else if t' = t
            then failwith "error: forward and reverse clash on the same level"
            else succ i, t, `reverse, idxs)
        (0, -10000, `normal, [])
    in
    fun (module S : Aiso) ->
      let rec f a =
        let _, t, mode, idxs = build_info a in
        let idxs = idxs |> List.rev in
        match mode with
        | `normal  -> S.ff a
        | `forward ->
          let ap =
            Array.map
              (fun x ->
                match x with
                | DF (p, _, t') -> if t = t' then p else x
                | x             -> x)
              a
          in
          let cp = f ap in
          let at =
            let at = a |> Array.map zero in
            List.iter (fun k -> at.(k) <- tangent a.(k)) idxs;
            S.df idxs cp ap at
          in
          DF (cp, at, t)
        | `reverse ->
          let ap =
            Array.map
              (fun x ->
                match x with
                | DR (p, _, _, _, t', _) -> if t = t' then p else x
                | x                      -> x)
              a
          in
          let cp = f ap in
          let adjoint cp ca t =
            (* use primal of inputs to calculate adjoint *)
            let ar = S.dr idxs ap cp ca |> Array.of_list in
            List.append List.(mapi (fun i k -> ar.(i), a.(k)) idxs) t
          in
          let register t = List.fold_left (fun t i -> a.(i) :: t) t idxs in
          let label = S.label, List.(map (fun i -> a.(i)) idxs) in
          DR (cp, ref (zero cp), (adjoint, register, label), ref 0, t, ref 0)
      in
      f
end
