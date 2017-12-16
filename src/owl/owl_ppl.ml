(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Experimental: Probabilistic Programming *)

open Owl_types

open Owl_graph


module Make (A : NdarraySig) = struct

  include Owl_distribution.Make (A)

  type rv = attr node
  and attr = {
    mutable dist  : dist;
    mutable shape : int array;
  }


  (* Draw random variables from different distribution. *)

  let uniform ~a ~b = {
    dist  = Uniform (Uniform.make ~a ~b);
    shape = [||];
  }

  let gaussian ~mu ~sigma = {
    dist  = Gaussian (Gaussian.make ~mu ~sigma);
    shape = [||];
  }


  (* Mathematical operators *)

  let add x y = ()


end
