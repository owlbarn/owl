(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


(* Functor of making Lazy module of different number types *)

module Make (A : StatsSig) = struct


  module Uniform_ = struct

    type t = {
      a : A.arr;
      b : A.arr;
    }

    let make ~a ~b =
      (* TODO: maybe we should validate a < b constraint *)
      { a; b }

    let sample t n = A.uniform_rvs ~a:t.a ~b:t.b ~n

    let pdf t x = A.uniform_pdf ~a:t.a ~b:t.b x

    let logpdf t x = A.uniform_logpdf ~a:t.a ~b:t.b x

    let cdf t x = A.uniform_cdf ~a:t.a ~b:t.b x

    let logcdf t x = A.uniform_logcdf ~a:t.a ~b:t.b x

    let ppf t x = A.uniform_ppf ~a:t.a ~b:t.b x

    let sf t x = A.uniform_sf ~a:t.a ~b:t.b x

    let logsf t x = A.uniform_logsf ~a:t.a ~b:t.b x

    let isf t x = A.uniform_isf ~a:t.a ~b:t.b x

  end


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

    let mean t = (t.a +. t.b) /. 2.

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

    let mean t = t.mu

  end


  module Gaussian_ = struct

    type t = {
      mu    : A.arr;
      sigma : A.arr;
    }

    let make ~mu ~sigma =
      assert (A.is_positive sigma);
      { mu; sigma }

    let sample t n =
      let s = A.shape t.mu in
      let z = A.empty s in
      ()

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


  let mean t = match t with
    | Uniform t  -> Uniform.mean t
    | Gaussian t -> Gaussian.mean t


end
