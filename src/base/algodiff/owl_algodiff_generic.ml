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
  (* include functions in the Core module *)
  module Core = Owl_algodiff_core.Make (A)
  include Core

  (* include graph conversion functions *)
  include Owl_algodiff_graph_convert.Make (Core)

  (* instantiate operations *)
  module Ops = Owl_algodiff_ops.Make (Core)
  include Ops

  (* include core reverse mode functions *)
  module Reverse = Owl_algodiff_reverse.Make (struct
    include Core

    let reverse_add = Maths.add
  end)

  (* convenient wrappers *)

  let make_forward p t i = DF (p, t, i)

  let make_reverse p i =
    let adjoint _cp _ca t = t in
    let register t = t in
    let label = "Noop", [] in
    DR (p, ref (zero p), (adjoint, register, label), ref 0, i, ref 0)


  (* expose reverse prop: propagate gradients *)
  let reverse_prop = Reverse.reverse_prop

  (* derivative of f (scalar -> scalar) at x, forward ad *)
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
    Reverse.reverse_reset y;
    Reverse.reverse_push (pack_flt 1.) y;
    primal y, x |> adjval


  (* gradient of f (vector -> scalar) at x, reverse ad *)
  let grad f x = grad' f x |> snd

  (* jacobian vector product of f (vector -> vector) at x along v, forward ad *)
  let jacobianv' f x v =
    if shape x <> shape v
    then failwith "jacobianv': vector not the same dimension as input";
    let x = make_forward x v (tag ()) in
    let y = f x in
    primal y, tangent y


  (* jacobian vector product of f (vector -> vector) at x along v, forward ad *)
  let jacobianv f x v = jacobianv' f x v |> snd

  (* transposed jacobian vector product of f (vector -> vector) at x along v, backward ad *)
  let jacobianTv' f x v =
    let x = make_reverse x (tag ()) in
    let y = f x in
    if shape y <> shape v
    then failwith "jacobianTv': vector not the same dimension as output";
    Reverse.reverse_reset y;
    Reverse.reverse_push v y;
    primal y, x |> adjval


  (* transposed jacobian vector product of f (vector -> vector) at x along v, backward ad *)
  let jacobianTv f x v = jacobianTv' f x v |> snd

  (* jacobian of f (vector -> vector) at x, both x and y are row vectors, also return the
     original value *)
  let jacobian' =
    let dim_typ x =
      match primal' x with
      | F _   -> `float
      | Arr x ->
        let s = A.shape x in
        let d = Array.length s in
        if d > 2
        then `arr
        else if s.(0) = 1
        then `row s.(1)
        else if s.(1) = 1
        then `col s.(0)
        else `mat
      | _     -> assert false
    in
    fun f x ->
      let y = f x |> primal in
      let m, n =
        match dim_typ y, dim_typ x with
        | `row a, `row 1 -> a, 1
        | `row a, `row b -> a, b
        | _              -> failwith "jacobian: input and output must both be row vectors"
      in
      let z = A.empty [| m; n |] in
      (match m > n with
      | true  ->
        Array.init n (fun i ->
            let v = A.zeros [| 1; n |] in
            A.(set v [| 0; i |] (float_to_elt 1.));
            jacobianv f x (Arr v))
        |> Array.iteri (fun i v ->
               match v with
               | Arr v -> A.copy_col_to (A.transpose v) z i
               | _     -> failwith "error: jacobian")
      | false ->
        Array.init m (fun i ->
            let v = A.zeros [| 1; m |] in
            A.(set v [| 0; i |] (float_to_elt 1.));
            jacobianTv f x (Arr v))
        |> Array.iteri (fun i v ->
               match v with
               | Arr v -> A.copy_row_to v z i
               | _     -> failwith "error: jacobian"));
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
