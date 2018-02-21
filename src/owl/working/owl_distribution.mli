(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module Make :
  functor (A : Owl_types.Stats_Dist) ->
    sig
      module Utility : sig  end
      module Uniform :
        sig
          type t = { a : A.arr; b : A.arr; }
          val make : a:A.arr -> b:A.arr -> t
          val sample : t -> int -> A.arr
          val pdf : t -> A.arr -> A.arr
          val logpdf : t -> A.arr -> A.arr
          val cdf : t -> A.arr -> A.arr
          val logcdf : t -> A.arr -> A.arr
          val ppf : t -> A.arr -> A.arr
          val sf : t -> A.arr -> A.arr
          val logsf : t -> A.arr -> A.arr
          val isf : t -> A.arr -> A.arr
        end
      module Gaussian :
        sig
          type t = { mu : A.arr; sigma : A.arr; }
          val make : mu:A.arr -> sigma:A.arr -> t
          val sample : t -> int -> A.arr
          val pdf : t -> A.arr -> A.arr
          val logpdf : t -> A.arr -> A.arr
          val cdf : t -> A.arr -> A.arr
          val logcdf : t -> A.arr -> A.arr
          val ppf : t -> A.arr -> A.arr
          val sf : t -> A.arr -> A.arr
          val logsf : t -> A.arr -> A.arr
          val isf : t -> A.arr -> A.arr
        end
      module Exponential :
        sig
          type t = { lambda : A.arr; }
          val make : lambda:A.arr -> t
          val sample : t -> int -> A.arr
          val pdf : t -> A.arr -> A.arr
          val logpdf : t -> A.arr -> A.arr
          val cdf : t -> A.arr -> A.arr
          val logcdf : t -> A.arr -> A.arr
          val ppf : t -> A.arr -> A.arr
          val sf : t -> A.arr -> A.arr
          val logsf : t -> A.arr -> A.arr
          val isf : t -> A.arr -> A.arr
        end
      module Gamma :
        sig
          type t = { shape : A.arr; scale : A.arr; }
          val make : shape:A.arr -> scale:A.arr -> t
          val sample : t -> int -> A.arr
          val pdf : t -> A.arr -> A.arr
          val logpdf : t -> A.arr -> A.arr
          val cdf : t -> A.arr -> A.arr
          val logcdf : t -> A.arr -> A.arr
          val ppf : t -> A.arr -> A.arr
          val sf : t -> A.arr -> A.arr
          val logsf : t -> A.arr -> A.arr
          val isf : t -> A.arr -> A.arr
        end
      module Beta :
        sig
          type t = { a : A.arr; b : A.arr; }
          val make : a:A.arr -> b:A.arr -> t
          val sample : t -> int -> A.arr
          val pdf : t -> A.arr -> A.arr
          val logpdf : t -> A.arr -> A.arr
          val cdf : t -> A.arr -> A.arr
          val logcdf : t -> A.arr -> A.arr
          val ppf : t -> A.arr -> A.arr
          val sf : t -> A.arr -> A.arr
          val logsf : t -> A.arr -> A.arr
          val isf : t -> A.arr -> A.arr
        end
      module Chi2 :
        sig
          type t = { df : A.arr; }
          val make : df:A.arr -> sigma:'a -> t
          val sample : t -> int -> A.arr
          val pdf : t -> A.arr -> A.arr
          val logpdf : t -> A.arr -> A.arr
          val cdf : t -> A.arr -> A.arr
          val logcdf : t -> A.arr -> A.arr
          val ppf : t -> A.arr -> A.arr
          val sf : t -> A.arr -> A.arr
          val logsf : t -> A.arr -> A.arr
          val isf : t -> A.arr -> A.arr
        end
      module F :
        sig
          type t = { dfnum : A.arr; dfden : A.arr; }
          val make : dfnum:A.arr -> dfden:A.arr -> t
          val sample : t -> int -> A.arr
          val pdf : t -> A.arr -> A.arr
          val logpdf : t -> A.arr -> A.arr
          val cdf : t -> A.arr -> A.arr
          val logcdf : t -> A.arr -> A.arr
          val ppf : t -> A.arr -> A.arr
          val sf : t -> A.arr -> A.arr
          val logsf : t -> A.arr -> A.arr
          val isf : t -> A.arr -> A.arr
        end
      module Cauchy :
        sig
          type t = { loc : A.arr; scale : A.arr; }
          val make : loc:A.arr -> scale:A.arr -> t
          val sample : t -> int -> A.arr
          val pdf : t -> A.arr -> A.arr
          val logpdf : t -> A.arr -> A.arr
          val cdf : t -> A.arr -> A.arr
          val logcdf : t -> A.arr -> A.arr
          val ppf : t -> A.arr -> A.arr
          val sf : t -> A.arr -> A.arr
          val logsf : t -> A.arr -> A.arr
          val isf : t -> A.arr -> A.arr
        end
      module Lomax :
        sig
          type t = { shape : A.arr; scale : A.arr; }
          val make : shape:A.arr -> scale:A.arr -> t
          val sample : t -> int -> A.arr
          val pdf : t -> A.arr -> A.arr
          val logpdf : t -> A.arr -> A.arr
          val cdf : t -> A.arr -> A.arr
          val logcdf : t -> A.arr -> A.arr
          val ppf : t -> A.arr -> A.arr
          val sf : t -> A.arr -> A.arr
          val logsf : t -> A.arr -> A.arr
          val isf : t -> A.arr -> A.arr
        end
      module Weibull :
        sig
          type t = { shape : A.arr; scale : A.arr; }
          val make : shape:A.arr -> scale:A.arr -> t
          val sample : t -> int -> A.arr
          val pdf : t -> A.arr -> A.arr
          val logpdf : t -> A.arr -> A.arr
          val cdf : t -> A.arr -> A.arr
          val logcdf : t -> A.arr -> A.arr
          val ppf : t -> A.arr -> A.arr
          val sf : t -> A.arr -> A.arr
          val logsf : t -> A.arr -> A.arr
          val isf : t -> A.arr -> A.arr
        end
      module Laplace :
        sig
          type t = { loc : A.arr; scale : A.arr; }
          val make : loc:A.arr -> scale:A.arr -> t
          val sample : t -> int -> A.arr
          val pdf : t -> A.arr -> A.arr
          val logpdf : t -> A.arr -> A.arr
          val cdf : t -> A.arr -> A.arr
          val logcdf : t -> A.arr -> A.arr
          val ppf : t -> A.arr -> A.arr
          val sf : t -> A.arr -> A.arr
          val logsf : t -> A.arr -> A.arr
          val isf : t -> A.arr -> A.arr
        end
      module Gumbel1 :
        sig
          type t = { a : A.arr; b : A.arr; }
          val make : a:A.arr -> b:A.arr -> t
          val sample : t -> int -> A.arr
          val pdf : t -> A.arr -> A.arr
          val logpdf : t -> A.arr -> A.arr
          val cdf : t -> A.arr -> A.arr
          val logcdf : t -> A.arr -> A.arr
          val ppf : t -> A.arr -> A.arr
          val sf : t -> A.arr -> A.arr
          val logsf : t -> A.arr -> A.arr
          val isf : t -> A.arr -> A.arr
        end
      module Gumbel2 :
        sig
          type t = { a : A.arr; b : A.arr; }
          val make : a:A.arr -> b:A.arr -> t
          val sample : t -> int -> A.arr
          val pdf : t -> A.arr -> A.arr
          val logpdf : t -> A.arr -> A.arr
          val cdf : t -> A.arr -> A.arr
          val logcdf : t -> A.arr -> A.arr
          val ppf : t -> A.arr -> A.arr
          val sf : t -> A.arr -> A.arr
          val logsf : t -> A.arr -> A.arr
          val isf : t -> A.arr -> A.arr
        end
      module Logistic :
        sig
          type t = { loc : A.arr; scale : A.arr; }
          val make : loc:A.arr -> scale:A.arr -> t
          val sample : t -> int -> A.arr
          val pdf : t -> A.arr -> A.arr
          val logpdf : t -> A.arr -> A.arr
          val cdf : t -> A.arr -> A.arr
          val logcdf : t -> A.arr -> A.arr
          val ppf : t -> A.arr -> A.arr
          val sf : t -> A.arr -> A.arr
          val logsf : t -> A.arr -> A.arr
          val isf : t -> A.arr -> A.arr
        end
      module Lognormal :
        sig
          type t = { mu : A.arr; sigma : A.arr; }
          val make : mu:A.arr -> sigma:A.arr -> t
          val sample : t -> int -> A.arr
          val pdf : t -> A.arr -> A.arr
          val logpdf : t -> A.arr -> A.arr
          val cdf : t -> A.arr -> A.arr
          val logcdf : t -> A.arr -> A.arr
          val ppf : t -> A.arr -> A.arr
          val sf : t -> A.arr -> A.arr
          val logsf : t -> A.arr -> A.arr
          val isf : t -> A.arr -> A.arr
        end
      module Rayleigh :
        sig
          type t = { sigma : A.arr; }
          val make : sigma:A.arr -> t
          val sample : t -> int -> A.arr
          val pdf : t -> A.arr -> A.arr
          val logpdf : t -> A.arr -> A.arr
          val cdf : t -> A.arr -> A.arr
          val logcdf : t -> A.arr -> A.arr
          val ppf : t -> A.arr -> A.arr
          val sf : t -> A.arr -> A.arr
          val logsf : t -> A.arr -> A.arr
          val isf : t -> A.arr -> A.arr
        end
      type dist =
          Uniform of Uniform.t
        | Gaussian of Gaussian.t
        | Exponential of Exponential.t
        | Gamma of Gamma.t
        | Beta of Beta.t
        | Chi2 of Chi2.t
        | F of F.t
        | Cauchy of Cauchy.t
        | Lomax of Lomax.t
        | Weibull of Weibull.t
        | Laplace of Laplace.t
        | Gumbel1 of Gumbel1.t
        | Gumbel2 of Gumbel2.t
        | Logistic of Logistic.t
        | Lognormal of Lognormal.t
        | Rayleigh of Rayleigh.t
      val sample : dist -> int -> A.arr
      val prob : dist -> A.arr -> A.arr
      val log_prob : dist -> A.arr -> A.arr
      val cdf : dist -> A.arr -> A.arr
      val logcdf : dist -> A.arr -> A.arr
    end
