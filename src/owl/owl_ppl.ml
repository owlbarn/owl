(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Experimental: Probabilistic Programming *)

open Owl_types

open Owl_graph


module Make (A : InpureSig) = struct

  include Owl_distribution.Make (A)

  include Owl_lazy.Make (A)


  (* graph manipulation *)

  (* Draw random variables from different distribution. *)

  let uniform ~a ~b =
    let draw_samples args =
      let a = to_elt args.(0) in
      let b = to_elt args.(1) in
      let t = Uniform.make ~a ~b in
      of_arr (Uniform.sample t [|100|])
    in
    map ~name:"uniform" draw_samples [|a;b|]

  let gaussian ~mu ~sigma =
    let draw_samples args =
      let mu = to_elt args.(0) in
      let sigma = to_elt args.(1) in
      let t = Gaussian.make ~mu ~sigma in
      of_arr (Gaussian.sample t [|100|])
    in
    map ~name:"gaussian" draw_samples [|mu;sigma|]


  (* Mathematical operators *)

  let add x y = ()


end
