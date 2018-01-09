(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


(* Functor of making Lazy module of different number types *)

module Make (A : StatsSig) = struct


  module Utility = struct

    (* check the elements in [xs] and make sure their shapes are broadcastable,
      by satisfying either of the following rules: 1) equal; 2) equal to one.
     *)
    let _check_broadcast_shape xs =
      let xs = Array.map A.shape xs in
      let s = Array.copy xs.(0) in
      Array.iter (fun x ->
        assert (Array.length s = Array.length x);
        Array.iteri (fun i d ->
          if d <> s.(i) then (
            if s.(i) = 1 then s.(i) <- d
            else if d = 1 then ()
            else failwith "_check_broadcast_shape"
          )
        ) x
      ) xs

  end


  module Uniform = struct

    type t = {
      a : A.arr;
      b : A.arr;
    }

    let make ~a ~b =
      Utility._check_broadcast_shape [|a; b|];
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


  module Gaussian = struct

    type t = {
      mu    : A.arr;
      sigma : A.arr;
    }

    let make ~mu ~sigma =
      Utility._check_broadcast_shape [|mu; sigma|];
      { mu; sigma }

    let sample t n = A.gaussian_rvs ~mu:t.mu ~sigma:t.sigma ~n

    let pdf t x = A.gaussian_pdf ~mu:t.mu ~sigma:t.sigma x

    let logpdf t x = A.gaussian_logpdf ~mu:t.mu ~sigma:t.sigma x

    let cdf t x = A.gaussian_cdf ~mu:t.mu ~sigma:t.sigma x

    let logcdf t x = A.gaussian_logcdf ~mu:t.mu ~sigma:t.sigma x

    let ppf t x = A.gaussian_ppf ~mu:t.mu ~sigma:t.sigma x

    let sf t x = A.gaussian_sf ~mu:t.mu ~sigma:t.sigma x

    let logsf t x = A.gaussian_logsf ~mu:t.mu ~sigma:t.sigma x

    let isf t x = A.gaussian_isf ~mu:t.mu ~sigma:t.sigma x

  end


  type dist =
    | Uniform  of Uniform.t
    | Gaussian of Gaussian.t


  let sample t n = match t with
    | Uniform t  -> Uniform.sample t n
    | Gaussian t -> Gaussian.sample t n


  let prob t x = match t with
    | Uniform t  -> Uniform.pdf t x
    | Gaussian t -> Gaussian.pdf t x


  let log_prob t x = match t with
    | Uniform t  -> Uniform.logpdf t x
    | Gaussian t -> Gaussian.logpdf t x

  let cdf t x = match t with
    | Uniform t  -> Uniform.cdf t x
    | Gaussian t -> Gaussian.cdf t x

  let logcdf t x = match t with
    | Uniform t  -> Uniform.logcdf t x
    | Gaussian t -> Gaussian.logcdf t x

(*
  let mean t = match t with
    | Uniform t  -> Uniform.mean t
    | Gaussian t -> Gaussian.mean t
*)


end
