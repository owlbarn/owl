(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


(* Functor of making Lazy module of different number types *)

module Make
  (A : NdarraySig)
  = struct


  module Uniform = struct

    type t = {
      a : float;
      b : float;
    }

    let make ~a ~b =
      assert ( a <= b);
      { a; b }

    let sample t s = A.uniform s

    (* FIXME *)
    let log_prob t x = A.zeros [|10|]

    let mean x = ()

  end


  module Gaussian = struct

    type t = {
      mu    : float;
      sigma : float;
    }

    let make ~mu ~sigma =
      assert (sigma >= 0.);
      { mu; sigma }

    let sample t s =
      let x = A.gaussian ~sigma:t.sigma s in
      A.add_scalar x t.mu

    (* FIXME *)
    let log_prob t x = A.zeros [|10|]

    let mean x = ()

  end


  type dist =
    | Uniform  of Uniform.t
    | Gaussian of Gaussian.t


  let sample t s = match t with
    | Uniform t  -> Uniform.sample t s
    | Gaussian t -> Gaussian.sample t s


  let log_prob t x = match t with
    | Uniform t  -> Uniform.log_prob t x
    | Gaussian t -> Gaussian.log_prob t x


end
