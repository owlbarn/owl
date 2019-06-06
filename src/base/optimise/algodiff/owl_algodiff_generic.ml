(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>

 * Core nested automatic differentiation algorithm and differentiation API
 * ported from DiffSharp (http://diffsharp.github.io), copyright (c) 2014-2016
 * National University of Ireland Maynooth (Atilim Gunes Baydin), 2014-2018
 * National University of Ireland Maynooth (Barak A. Pearlmutter
 * <barak@pearlmutter.net>), 2016-2018 University of Oxford (Atilim Gunes
 * Baydin <gunes@robots.ox.ac.uk>), 2017-2018 Microsoft Research Cambridge
 * (Don Syme <dsyme@microsoft.com>
 *)

(* Functor of making AD module of different precisions *)

module Make (A : Owl_types_ndarray_algodiff.Sig) = struct
  (* generate global tags *)
  let _global_tag = ref 0

  let tag () =
    _global_tag := !_global_tag + 1;
    !_global_tag


  (* core module *)
  module Core = Owl_algodiff_core.Make (Owl_algodiff_types.Make (A))
  include Core

  (* include graph conversion functions *)
  include Owl_algodiff_graph_convert.Make (Core)

  (* instantiate operations *)
  module Ops = Owl_algodiff_ops.Make (Core)
  module Maths = Ops.Maths
  module Mat = Ops.Mat
  module Arr = Ops.Arr
  module Linalg = Ops.Linalg
  module NN = Ops.NN

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
          (aa := Maths.(!aa + v));
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


  (* convenient wrappers *)

  let make_forward p t i = DF (p, t, i)

  let make_reverse p i =
    let adjoint _ap _aa t = t in
    let register t = t in
    let label = "Noop", [] in
    DR (p, ref (zero p), (adjoint, register, label), ref 0, i, ref 0)


  (* derivative of f (scalar -> scalr) at x, forward ad *)
  let diff' f x =
    let x = make_forward x (pack_flt 1.) (tag ()) in
    let y = f x in
    primal y, tangent y


  (* derivative of f (scalar -> scalar) at x, forward ad *)
  let diff f x = diff' f x |> snd

  (* gradient of f (vector -> scalar) at x, reverse ad *)
  let grad' f x =
    let x = make_reverse x (tag ()) in
    let y = f x in
    reverse_reset y;
    reverse_push (pack_flt 1.) y;
    primal y, x |> adjval


  (* gradient of f (vector -> scalar) at x, reverse ad *)
  let grad f x = grad' f x |> snd

  (* jacobian vector product of f (vector -> vector) at x along v, forward ad *)
  let jacobianv' f x v =
    let x = make_forward x v (tag ()) in
    let y = f x in
    primal y, tangent y


  (* jacobian vector product of f (vector -> vector) at x along v, forward ad *)
  let jacobianv f x v = jacobianv' f x v |> snd

  (* transposed jacobian vector product of f (vector -> vector) at x along v, backward ad *)
  let jacobianTv' f x v =
    let x = make_reverse x (tag ()) in
    let y = f x in
    reverse_reset y;
    reverse_push v y;
    primal y, x |> adjval |> primal


  (* transposed jacobian vector product of f (vector -> vector) at x along v, backward ad *)
  let jacobianTv f x v = jacobianTv' f x v |> snd

  (* jacobian of f (vector -> vector) at x, both x and y are row vectors, also return the
     original value *)
  let jacobian' f x =
    let y = f x |> primal in
    let m = col_num y in
    let n = col_num x in
    let z = A.empty [| m; n |] in
    (match m > n with
    | true ->
      Array.init n (fun i ->
          let v = A.zeros [| 1; n |] in
          A.(set v [| 0; i |] (float_to_elt 1.));
          jacobianv f x (Arr v))
      |> Array.iteri (fun i v ->
             match v with
             | Arr v -> A.copy_col_to (A.transpose v) z i
             | _ -> failwith "error: jacobian")
    | false ->
      Array.init m (fun i ->
          let v = A.zeros [| 1; m |] in
          A.(set v [| 0; i |] (float_to_elt 1.));
          jacobianTv f x (Arr v))
      |> Array.iteri (fun i v ->
             match v with
             | Arr v -> A.copy_row_to v z i
             | _ -> failwith "error: jacobian"));
    y, Arr z


  (* jacobian of f *)
  let jacobian f x = jacobian' f x |> snd

  (* gradient, hessian of f (vector -> scalar) at [x] *)
  let gradhessian f x = jacobian' (grad f) x

  (* original value, gradient, and hessian *)
  let gradhessian' f x =
    let g, h = gradhessian f x in
    f x, g, h


  (* hessian of f *)
  let hessian f x = (f |> grad |> jacobian) x

  (* original value and hessian of f *)
  let hessian' f x = f x, hessian f x

  (* original value, gradient-vector product, hessian-vector product *)
  let gradhessianv' f x v =
    let gv, hv = grad' (fun y -> jacobianv f y v) x in
    f x, gv, hv


  (* gradient-vector product and hessian-vector product *)
  let gradhessianv f x v =
    let _, gv, hv = gradhessianv' f x v in
    gv, hv


  (* original value and hessian-vector product *)
  let hessianv' f x v =
    let fv, _, hv = gradhessianv' f x v in
    fv, hv


  (* hessian-vector *)
  let hessianv f x v =
    let _, _, hv = gradhessianv' f x v in
    hv


  (* laplacian of f *)
  let laplacian f x = F (hessian f x |> unpack_arr |> A.trace)
  let laplacian' f x = f x, laplacian f x

  
end

(* ends here *)
