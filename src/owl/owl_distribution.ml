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

    let sample t s = ()

    let pdf x = ()

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

    let pdf x = ()

    let mean x = ()

  end


  type dist =
    | Uniform  of Uniform.t
    | Gaussian of Gaussian.t


end
