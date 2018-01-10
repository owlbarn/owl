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


  module Exponential = struct

    type t = {
      lambda : A.arr;
    }

    let make ~lambda =
      Utility._check_broadcast_shape [|lambda|];
      { lambda }

    let sample t n = A.exponential_rvs ~lambda:t.lambda ~n

    let pdf t x = A.exponential_pdf ~lambda:t.lambda x

    let logpdf t x = A.exponential_logpdf ~lambda:t.lambda x

    let cdf t x = A.exponential_cdf ~lambda:t.lambda x

    let logcdf t x = A.exponential_logcdf ~lambda:t.lambda x

    let ppf t x = A.exponential_ppf ~lambda:t.lambda x

    let sf t x = A.exponential_sf ~lambda:t.lambda x

    let logsf t x = A.exponential_logsf ~lambda:t.lambda x

    let isf t x = A.exponential_isf ~lambda:t.lambda x

  end


  module Gamma = struct

    type t = {
      shape : A.arr;
      scale : A.arr;
    }

    let make ~shape ~scale =
      Utility._check_broadcast_shape [|shape; scale|];
      { shape; scale }

    let sample t n = A.gamma_rvs ~shape:t.shape ~scale:t.scale ~n

    let pdf t x = A.gamma_pdf ~shape:t.shape ~scale:t.scale x

    let logpdf t x = A.gamma_logpdf ~shape:t.shape ~scale:t.scale x

    let cdf t x = A.gamma_cdf ~shape:t.shape ~scale:t.scale x

    let logcdf t x = A.gamma_logcdf ~shape:t.shape ~scale:t.scale x

    let ppf t x = A.gamma_ppf ~shape:t.shape ~scale:t.scale x

    let sf t x = A.gamma_sf ~shape:t.shape ~scale:t.scale x

    let logsf t x = A.gamma_logsf ~shape:t.shape ~scale:t.scale x

    let isf t x = A.gamma_isf ~shape:t.shape ~scale:t.scale x

  end


  module Beta = struct

    type t = {
      a : A.arr;
      b : A.arr;
    }

    let make ~a ~b =
      Utility._check_broadcast_shape [|a; b|];
      { a; b }

    let sample t n = A.beta_rvs ~a:t.a ~b:t.b ~n

    let pdf t x = A.beta_pdf ~a:t.a ~b:t.b x

    let logpdf t x = A.beta_logpdf ~a:t.a ~b:t.b x

    let cdf t x = A.beta_cdf ~a:t.a ~b:t.b x

    let logcdf t x = A.beta_logcdf ~a:t.a ~b:t.b x

    let ppf t x = A.beta_ppf ~a:t.a ~b:t.b x

    let sf t x = A.beta_sf ~a:t.a ~b:t.b x

    let logsf t x = A.beta_logsf ~a:t.a ~b:t.b x

    let isf t x = A.beta_isf ~a:t.a ~b:t.b x

  end


  module Chi2 = struct

    type t = {
      df : A.arr;
    }

    let make ~df ~sigma =
      Utility._check_broadcast_shape [|df|];
      { df }

    let sample t n = A.chi2_rvs ~df:t.df ~n

    let pdf t x = A.chi2_pdf ~df:t.df x

    let logpdf t x = A.chi2_logpdf ~df:t.df x

    let cdf t x = A.chi2_cdf ~df:t.df x

    let logcdf t x = A.chi2_logcdf ~df:t.df x

    let ppf t x = A.chi2_ppf ~df:t.df x

    let sf t x = A.chi2_sf ~df:t.df x

    let logsf t x = A.chi2_logsf ~df:t.df x

    let isf t x = A.chi2_isf ~df:t.df x

  end


  module F = struct

    type t = {
      dfnum : A.arr;
      dfden : A.arr;
    }

    let make ~dfnum ~dfden =
      Utility._check_broadcast_shape [|dfnum; dfden|];
      { dfnum; dfden }

    let sample t n = A.f_rvs ~dfnum:t.dfnum ~dfden:t.dfden ~n

    let pdf t x = A.f_pdf ~dfnum:t.dfnum ~dfden:t.dfden x

    let logpdf t x = A.f_logpdf ~dfnum:t.dfnum ~dfden:t.dfden x

    let cdf t x = A.f_cdf ~dfnum:t.dfnum ~dfden:t.dfden x

    let logcdf t x = A.f_logcdf ~dfnum:t.dfnum ~dfden:t.dfden x

    let ppf t x = A.f_ppf ~dfnum:t.dfnum ~dfden:t.dfden x

    let sf t x = A.f_sf ~dfnum:t.dfnum ~dfden:t.dfden x

    let logsf t x = A.f_logsf ~dfnum:t.dfnum ~dfden:t.dfden x

    let isf t x = A.f_isf ~dfnum:t.dfnum ~dfden:t.dfden x

  end


  type dist =
    | Uniform     of Uniform.t
    | Gaussian    of Gaussian.t
    | Exponential of Exponential.t
    | Gamma       of Gamma.t
    | Beta        of Beta.t
    | Chi2        of Chi2.t
    | F           of F.t

  let sample t n = match t with
    | Uniform t     -> Uniform.sample t n
    | Gaussian t    -> Gaussian.sample t n
    | Exponential t -> Exponential.sample t n
    | Gamma t       -> Gamma.sample t n
    | Beta t        -> Beta.sample t n
    | Chi2 t        -> Chi2.sample t n
    | F t           -> F.sample t n


  let prob t x = match t with
    | Uniform t     -> Uniform.pdf t x
    | Gaussian t    -> Gaussian.pdf t x
    | Exponential t -> Exponential.pdf t x
    | Gamma t       -> Gamma.pdf t x
    | Beta t        -> Beta.pdf t x
    | Chi2 t        -> Chi2.pdf t x
    | F t           -> F.pdf t x


  let log_prob t x = match t with
    | Uniform t     -> Uniform.logpdf t x
    | Gaussian t    -> Gaussian.logpdf t x
    | Exponential t -> Exponential.logpdf t x
    | Gamma t       -> Gamma.logpdf t x
    | Beta t        -> Beta.logpdf t x
    | Chi2 t        -> Chi2.logpdf t x
    | F t           -> F.logpdf t x

  let cdf t x = match t with
    | Uniform t     -> Uniform.cdf t x
    | Gaussian t    -> Gaussian.cdf t x
    | Exponential t -> Exponential.cdf t x
    | Gamma t       -> Gamma.cdf t x
    | Beta t        -> Beta.cdf t x
    | Chi2 t        -> Chi2.cdf t x
    | F t           -> F.cdf t x

  let logcdf t x = match t with
    | Uniform t     -> Uniform.logcdf t x
    | Gaussian t    -> Gaussian.logcdf t x
    | Exponential t -> Exponential.logcdf t x
    | Gamma t       -> Gamma.logcdf t x
    | Beta t        -> Beta.logcdf t x
    | Chi2 t        -> Chi2.logcdf t x
    | F t           -> F.logcdf t x

(*
  let mean t = match t with
    | Uniform t  -> Uniform.mean t
    | Gaussian t -> Gaussian.mean t
*)


end
