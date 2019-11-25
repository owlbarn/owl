module Make (C : sig
  include Owl_algodiff_core_sig.Sig

  val reverse_add : t -> t -> t
end) =
struct
  open C

  (* core of reverse mode functions *)

  let reverse_reset x =
    let rec reset xs =
      match xs with
      | []     -> ()
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
      | F _, Arr v   -> F (A.sum' v)
      | Arr a, Arr v ->
        let shp_a = A.shape a in
        let shp_v = A.shape v in
        if shp_a <> shp_v
        then (
          let shp_a, shp_v = Owl_utils_array.align `Left 1 shp_a shp_v in
          let axis = Owl_utils_array.filter2_i ( <> ) shp_a shp_v in
          Arr (A.sum_reduce ~axis v))
        else Arr v
      | _a, v        -> v
    in
    let rec push xs =
      match xs with
      | []          -> ()
      | (v, x) :: t ->
        (match x with
        | DR (cp, aa, (adjoint, _, _), af, _ai, tracker) ->
          let v = _shrink !aa v in
          aa := reverse_add !aa v;
          (af := Stdlib.(!af - 1));
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
