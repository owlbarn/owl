(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Functor to generate distribution module *)

module Make (A : Owl_types.Stats_Dist) : sig


  (** {6 Uniform distribtion} *)

  module Uniform : sig

    type t = { a : A.arr; b : A.arr; }
    (** Type definition of a specific distribution *)

    val make : a:A.arr -> b:A.arr -> t
    (** Make a distribution of the given parameters. *)

    val sample : t -> int -> A.arr
    (** Sample a distribution of the given parameters. *)

    val pdf : t -> A.arr -> A.arr
    (**  Probability density/mass function of the distribution. *)

    val logpdf : t -> A.arr -> A.arr
    (**  Logarithm of the probability density/mass function of the distribution. *)

    val cdf : t -> A.arr -> A.arr
    (** Cumulative density/mass function of the distribution. *)

    val logcdf : t -> A.arr -> A.arr
    (**  Logarithm of the cumulative density/mass function of the distribution. *)

    val ppf : t -> A.arr -> A.arr
    (** Percentile function of the distribution. *)

    val sf : t -> A.arr -> A.arr
    (** Survival function of the distribution. *)

    val logsf : t -> A.arr -> A.arr
    (** Logarithm of the survival function of the distribution. *)

    val isf : t -> A.arr -> A.arr
    (** Inverse survival function of the distribution. *)

  end


  (** {6 Gaussian distribtion} *)

  module Gaussian : sig

    type t = { mu : A.arr; sigma : A.arr; }
    (** Type definition of a specific distribution *)

    val make : mu:A.arr -> sigma:A.arr -> t
    (** Make a distribution of the given parameters. *)

    val sample : t -> int -> A.arr
    (** Sample a distribution of the given parameters. *)

    val pdf : t -> A.arr -> A.arr
    (**  Probability density/mass function of the distribution. *)

    val logpdf : t -> A.arr -> A.arr
    (**  Logarithm of the probability density/mass function of the distribution. *)

    val cdf : t -> A.arr -> A.arr
    (** Cumulative density/mass function of the distribution. *)

    val logcdf : t -> A.arr -> A.arr
    (**  Logarithm of the cumulative density/mass function of the distribution. *)

    val ppf : t -> A.arr -> A.arr
    (** Percentile function of the distribution. *)

    val sf : t -> A.arr -> A.arr
    (** Survival function of the distribution. *)

    val logsf : t -> A.arr -> A.arr
    (** Logarithm of the survival function of the distribution. *)

    val isf : t -> A.arr -> A.arr
    (** Inverse survival function of the distribution. *)

  end


  (** {6 Exponential distribtion} *)

  module Exponential : sig

    type t = { lambda : A.arr; }
    (** Type definition of a specific distribution *)

    val make : lambda:A.arr -> t
    (** Make a distribution of the given parameters. *)

    val sample : t -> int -> A.arr
    (** Sample a distribution of the given parameters. *)

    val pdf : t -> A.arr -> A.arr
    (**  Probability density/mass function of the distribution. *)

    val logpdf : t -> A.arr -> A.arr
    (**  Logarithm of the probability density/mass function of the distribution. *)

    val cdf : t -> A.arr -> A.arr
    (** Cumulative density/mass function of the distribution. *)

    val logcdf : t -> A.arr -> A.arr
    (**  Logarithm of the cumulative density/mass function of the distribution. *)

    val ppf : t -> A.arr -> A.arr
    (** Percentile function of the distribution. *)

    val sf : t -> A.arr -> A.arr
    (** Survival function of the distribution. *)

    val logsf : t -> A.arr -> A.arr
    (** Logarithm of the survival function of the distribution. *)

    val isf : t -> A.arr -> A.arr
    (** Inverse survival function of the distribution. *)

  end


  (** {6 Gamma distribtion} *)

  module Gamma : sig

    type t = { shape : A.arr; scale : A.arr; }
    (** Type definition of a specific distribution *)

    val make : shape:A.arr -> scale:A.arr -> t
    (** Make a distribution of the given parameters. *)

    val sample : t -> int -> A.arr
    (** Sample a distribution of the given parameters. *)

    val pdf : t -> A.arr -> A.arr
    (**  Probability density/mass function of the distribution. *)

    val logpdf : t -> A.arr -> A.arr
    (**  Logarithm of the probability density/mass function of the distribution. *)

    val cdf : t -> A.arr -> A.arr
    (** Cumulative density/mass function of the distribution. *)

    val logcdf : t -> A.arr -> A.arr
    (**  Logarithm of the cumulative density/mass function of the distribution. *)

    val ppf : t -> A.arr -> A.arr
    (** Percentile function of the distribution. *)

    val sf : t -> A.arr -> A.arr
    (** Survival function of the distribution. *)

    val logsf : t -> A.arr -> A.arr
    (** Logarithm of the survival function of the distribution. *)

    val isf : t -> A.arr -> A.arr
    (** Inverse survival function of the distribution. *)

  end


  (** {6 Beta distribtion} *)

  module Beta : sig

    type t = { a : A.arr; b : A.arr; }
    (** Type definition of a specific distribution *)

    val make : a:A.arr -> b:A.arr -> t
    (** Make a distribution of the given parameters. *)

    val sample : t -> int -> A.arr
    (** Sample a distribution of the given parameters. *)

    val pdf : t -> A.arr -> A.arr
    (**  Probability density/mass function of the distribution. *)

    val logpdf : t -> A.arr -> A.arr
    (**  Logarithm of the probability density/mass function of the distribution. *)

    val cdf : t -> A.arr -> A.arr
    (** Cumulative density/mass function of the distribution. *)

    val logcdf : t -> A.arr -> A.arr
    (**  Logarithm of the cumulative density/mass function of the distribution. *)

    val ppf : t -> A.arr -> A.arr
    (** Percentile function of the distribution. *)

    val sf : t -> A.arr -> A.arr
    (** Survival function of the distribution. *)

    val logsf : t -> A.arr -> A.arr
    (** Logarithm of the survival function of the distribution. *)

    val isf : t -> A.arr -> A.arr
    (** Inverse survival function of the distribution. *)

  end


  (** {6 Chi2 distribtion} *)

  module Chi2 : sig

    type t = { df : A.arr; }
    (** Type definition of a specific distribution *)

    val make : df:A.arr -> _sigma:'a -> t
    (** Make a distribution of the given parameters. *)

    val sample : t -> int -> A.arr
    (** Sample a distribution of the given parameters. *)

    val pdf : t -> A.arr -> A.arr
    (**  Probability density/mass function of the distribution. *)

    val logpdf : t -> A.arr -> A.arr
    (**  Logarithm of the probability density/mass function of the distribution. *)

    val cdf : t -> A.arr -> A.arr
    (** Cumulative density/mass function of the distribution. *)

    val logcdf : t -> A.arr -> A.arr
    (**  Logarithm of the cumulative density/mass function of the distribution. *)

    val ppf : t -> A.arr -> A.arr
    (** Percentile function of the distribution. *)

    val sf : t -> A.arr -> A.arr
    (** Survival function of the distribution. *)

    val logsf : t -> A.arr -> A.arr
    (** Logarithm of the survival function of the distribution. *)

    val isf : t -> A.arr -> A.arr
    (** Inverse survival function of the distribution. *)

  end


  (** {6 F distribtion} *)

  module F : sig

    type t = { dfnum : A.arr; dfden : A.arr; }
    (** Type definition of a specific distribution *)

    val make : dfnum:A.arr -> dfden:A.arr -> t
    (** Make a distribution of the given parameters. *)

    val sample : t -> int -> A.arr
    (** Sample a distribution of the given parameters. *)

    val pdf : t -> A.arr -> A.arr
    (**  Probability density/mass function of the distribution. *)

    val logpdf : t -> A.arr -> A.arr
    (**  Logarithm of the probability density/mass function of the distribution. *)

    val cdf : t -> A.arr -> A.arr
    (** Cumulative density/mass function of the distribution. *)

    val logcdf : t -> A.arr -> A.arr
    (**  Logarithm of the cumulative density/mass function of the distribution. *)

    val ppf : t -> A.arr -> A.arr
    (** Percentile function of the distribution. *)

    val sf : t -> A.arr -> A.arr
    (** Survival function of the distribution. *)

    val logsf : t -> A.arr -> A.arr
    (** Logarithm of the survival function of the distribution. *)

    val isf : t -> A.arr -> A.arr
    (** Inverse survival function of the distribution. *)

  end


  (** {6 Cauchy distribtion} *)

  module Cauchy : sig

    type t = { loc : A.arr; scale : A.arr; }
    (** Type definition of a specific distribution *)

    val make : loc:A.arr -> scale:A.arr -> t
    (** Make a distribution of the given parameters. *)

    val sample : t -> int -> A.arr
    (** Sample a distribution of the given parameters. *)

    val pdf : t -> A.arr -> A.arr
    (**  Probability density/mass function of the distribution. *)

    val logpdf : t -> A.arr -> A.arr
    (**  Logarithm of the probability density/mass function of the distribution. *)

    val cdf : t -> A.arr -> A.arr
    (** Cumulative density/mass function of the distribution. *)

    val logcdf : t -> A.arr -> A.arr
    (**  Logarithm of the cumulative density/mass function of the distribution. *)

    val ppf : t -> A.arr -> A.arr
    (** Percentile function of the distribution. *)

    val sf : t -> A.arr -> A.arr
    (** Survival function of the distribution. *)

    val logsf : t -> A.arr -> A.arr
    (** Logarithm of the survival function of the distribution. *)

    val isf : t -> A.arr -> A.arr
    (** Inverse survival function of the distribution. *)

  end


  (** {6 Lomax distribtion} *)

  module Lomax : sig

    type t = { shape : A.arr; scale : A.arr; }
    (** Type definition of a specific distribution *)

    val make : shape:A.arr -> scale:A.arr -> t
    (** Make a distribution of the given parameters. *)

    val sample : t -> int -> A.arr
    (** Sample a distribution of the given parameters. *)

    val pdf : t -> A.arr -> A.arr
    (**  Probability density/mass function of the distribution. *)

    val logpdf : t -> A.arr -> A.arr
    (**  Logarithm of the probability density/mass function of the distribution. *)

    val cdf : t -> A.arr -> A.arr
    (** Cumulative density/mass function of the distribution. *)

    val logcdf : t -> A.arr -> A.arr
    (**  Logarithm of the cumulative density/mass function of the distribution. *)

    val ppf : t -> A.arr -> A.arr
    (** Percentile function of the distribution. *)

    val sf : t -> A.arr -> A.arr
    (** Survival function of the distribution. *)

    val logsf : t -> A.arr -> A.arr
    (** Logarithm of the survival function of the distribution. *)

    val isf : t -> A.arr -> A.arr
    (** Inverse survival function of the distribution. *)

  end


  (** {6 Weibull distribtion} *)

  module Weibull : sig

    type t = { shape : A.arr; scale : A.arr; }
    (** Type definition of a specific distribution *)

    val make : shape:A.arr -> scale:A.arr -> t
    (** Make a distribution of the given parameters. *)

    val sample : t -> int -> A.arr
    (** Sample a distribution of the given parameters. *)

    val pdf : t -> A.arr -> A.arr
    (**  Probability density/mass function of the distribution. *)

    val logpdf : t -> A.arr -> A.arr
    (**  Logarithm of the probability density/mass function of the distribution. *)

    val cdf : t -> A.arr -> A.arr
    (** Cumulative density/mass function of the distribution. *)

    val logcdf : t -> A.arr -> A.arr
    (**  Logarithm of the cumulative density/mass function of the distribution. *)

    val ppf : t -> A.arr -> A.arr
    (** Percentile function of the distribution. *)

    val sf : t -> A.arr -> A.arr
    (** Survival function of the distribution. *)

    val logsf : t -> A.arr -> A.arr
    (** Logarithm of the survival function of the distribution. *)

    val isf : t -> A.arr -> A.arr
    (** Inverse survival function of the distribution. *)

  end


  (** {6 Laplace distribtion} *)

  module Laplace : sig

    type t = { loc : A.arr; scale : A.arr; }
    (** Type definition of a specific distribution *)

    val make : loc:A.arr -> scale:A.arr -> t
    (** Make a distribution of the given parameters. *)

    val sample : t -> int -> A.arr
    (** Sample a distribution of the given parameters. *)

    val pdf : t -> A.arr -> A.arr
    (**  Probability density/mass function of the distribution. *)

    val logpdf : t -> A.arr -> A.arr
    (**  Logarithm of the probability density/mass function of the distribution. *)

    val cdf : t -> A.arr -> A.arr
    (** Cumulative density/mass function of the distribution. *)

    val logcdf : t -> A.arr -> A.arr
    (**  Logarithm of the cumulative density/mass function of the distribution. *)

    val ppf : t -> A.arr -> A.arr
    (** Percentile function of the distribution. *)

    val sf : t -> A.arr -> A.arr
    (** Survival function of the distribution. *)

    val logsf : t -> A.arr -> A.arr
    (** Logarithm of the survival function of the distribution. *)

    val isf : t -> A.arr -> A.arr
    (** Inverse survival function of the distribution. *)

  end


  (** {6 Gumbel1 distribtion} *)

  module Gumbel1 : sig

    type t = { a : A.arr; b : A.arr; }
    (** Type definition of a specific distribution *)

    val make : a:A.arr -> b:A.arr -> t
    (** Make a distribution of the given parameters. *)

    val sample : t -> int -> A.arr
    (** Sample a distribution of the given parameters. *)

    val pdf : t -> A.arr -> A.arr
    (**  Probability density/mass function of the distribution. *)

    val logpdf : t -> A.arr -> A.arr
    (**  Logarithm of the probability density/mass function of the distribution. *)

    val cdf : t -> A.arr -> A.arr
    (** Cumulative density/mass function of the distribution. *)

    val logcdf : t -> A.arr -> A.arr
    (**  Logarithm of the cumulative density/mass function of the distribution. *)

    val ppf : t -> A.arr -> A.arr
    (** Percentile function of the distribution. *)

    val sf : t -> A.arr -> A.arr
    (** Survival function of the distribution. *)

    val logsf : t -> A.arr -> A.arr
    (** Logarithm of the survival function of the distribution. *)

    val isf : t -> A.arr -> A.arr
    (** Inverse survival function of the distribution. *)

  end


  (** {6 Gumbel2 distribtion} *)

  module Gumbel2 : sig

    type t = { a : A.arr; b : A.arr; }
    (** Type definition of a specific distribution *)

    val make : a:A.arr -> b:A.arr -> t
    (** Make a distribution of the given parameters. *)

    val sample : t -> int -> A.arr
    (** Sample a distribution of the given parameters. *)

    val pdf : t -> A.arr -> A.arr
    (**  Probability density/mass function of the distribution. *)

    val logpdf : t -> A.arr -> A.arr
    (**  Logarithm of the probability density/mass function of the distribution. *)

    val cdf : t -> A.arr -> A.arr
    (** Cumulative density/mass function of the distribution. *)

    val logcdf : t -> A.arr -> A.arr
    (**  Logarithm of the cumulative density/mass function of the distribution. *)

    val ppf : t -> A.arr -> A.arr
    (** Percentile function of the distribution. *)

    val sf : t -> A.arr -> A.arr
    (** Survival function of the distribution. *)

    val logsf : t -> A.arr -> A.arr
    (** Logarithm of the survival function of the distribution. *)

    val isf : t -> A.arr -> A.arr
    (** Inverse survival function of the distribution. *)

  end


  (** {6 Logistic distribtion} *)

  module Logistic : sig

    type t = { loc : A.arr; scale : A.arr; }
    (** Type definition of a specific distribution *)

    val make : loc:A.arr -> scale:A.arr -> t
    (** Make a distribution of the given parameters. *)

    val sample : t -> int -> A.arr
    (** Sample a distribution of the given parameters. *)

    val pdf : t -> A.arr -> A.arr
    (**  Probability density/mass function of the distribution. *)

    val logpdf : t -> A.arr -> A.arr
    (**  Logarithm of the probability density/mass function of the distribution. *)

    val cdf : t -> A.arr -> A.arr
    (** Cumulative density/mass function of the distribution. *)

    val logcdf : t -> A.arr -> A.arr
    (**  Logarithm of the cumulative density/mass function of the distribution. *)

    val ppf : t -> A.arr -> A.arr
    (** Percentile function of the distribution. *)

    val sf : t -> A.arr -> A.arr
    (** Survival function of the distribution. *)

    val logsf : t -> A.arr -> A.arr
    (** Logarithm of the survival function of the distribution. *)

    val isf : t -> A.arr -> A.arr
    (** Inverse survival function of the distribution. *)

  end


  (** {6 Lognormal distribtion} *)

  module Lognormal : sig

    type t = { mu : A.arr; sigma : A.arr; }
    (** Type definition of a specific distribution *)

    val make : mu:A.arr -> sigma:A.arr -> t
    (** Make a distribution of the given parameters. *)

    val sample : t -> int -> A.arr
    (** Sample a distribution of the given parameters. *)

    val pdf : t -> A.arr -> A.arr
    (**  Probability density/mass function of the distribution. *)

    val logpdf : t -> A.arr -> A.arr
    (**  Logarithm of the probability density/mass function of the distribution. *)

    val cdf : t -> A.arr -> A.arr
    (** Cumulative density/mass function of the distribution. *)

    val logcdf : t -> A.arr -> A.arr
    (**  Logarithm of the cumulative density/mass function of the distribution. *)

    val ppf : t -> A.arr -> A.arr
    (** Percentile function of the distribution. *)

    val sf : t -> A.arr -> A.arr
    (** Survival function of the distribution. *)

    val logsf : t -> A.arr -> A.arr
    (** Logarithm of the survival function of the distribution. *)

    val isf : t -> A.arr -> A.arr
    (** Inverse survival function of the distribution. *)

  end


  (** {6 Rayleigh distribtion} *)

  module Rayleigh : sig

    type t = { sigma : A.arr; }
    (** Type definition of a specific distribution *)

    val make : sigma:A.arr -> t
    (** Make a distribution of the given parameters. *)

    val sample : t -> int -> A.arr
    (** Sample a distribution of the given parameters. *)

    val pdf : t -> A.arr -> A.arr
    (**  Probability density/mass function of the distribution. *)

    val logpdf : t -> A.arr -> A.arr
    (**  Logarithm of the probability density/mass function of the distribution. *)

    val cdf : t -> A.arr -> A.arr
    (** Cumulative density/mass function of the distribution. *)

    val logcdf : t -> A.arr -> A.arr
    (**  Logarithm of the cumulative density/mass function of the distribution. *)

    val ppf : t -> A.arr -> A.arr
    (** Percentile function of the distribution. *)

    val sf : t -> A.arr -> A.arr
    (** Survival function of the distribution. *)

    val logsf : t -> A.arr -> A.arr
    (** Logarithm of the survival function of the distribution. *)

    val isf : t -> A.arr -> A.arr
    (** Inverse survival function of the distribution. *)

  end


  (** {6 Type definition} *)

  type dist =
    | Uniform of Uniform.t
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
  (** Type definition of various distribtions *)


  (** {6 Core functions} *)

  val sample : dist -> int -> A.arr
  (** Sample a given distribution of the given parameters. *)

  val prob : dist -> A.arr -> A.arr
  (** Probability density/mass function of a given distribtion. *)

  val log_prob : dist -> A.arr -> A.arr
  (** logarithmic probability density/mass function of a given distribtion. *)

  val cdf : dist -> A.arr -> A.arr
  (** Cumulative density/mass function of the distribution. *)

  val logcdf : dist -> A.arr -> A.arr
  (**  Logarithm of the cumulative density/mass function of the distribution. *)


end
