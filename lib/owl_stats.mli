(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Statistics module

  The module includes some basic statistical functions such as mean, variance,
  skew, and etc. It also includes the following three submodules.

  The {! Rnd } module provides random number generators of various
  distributions.

  The {! Pdf } module provides a range of probability density/mass functions of
  different distributions.

  The {! Cdf } module provides cumulative distribution functions.

  Please refer to {{: https://www.gnu.org/software/gsl/manual }
  GSL documentation} for details.
*)


(** {6 Randomisation functions} *)

val seed : int -> unit
(** [seed x] sets [x] as seed for the internal random number generator.  *)

val shuffle : 'a array -> 'a array
(** [ shuffle x ] return a new array of the shuffled [x].  *)

val choose : 'a array -> int -> 'a array
(** [ choose x n ] draw [n] samples from [x] without replecement.  *)

val sample : 'a array -> int -> 'a array
(** [ sample x n ] draw [n] samples from [x] with replacement.  *)


(** {6 Basic statistical functions} *)

val mean : ?w:float array -> float array -> float

val variance : ?w:float array -> ?mean:float -> float array -> float

val std : ?w:float array -> ?mean:float -> float array -> float

val absdev : ?w:float array -> ?mean:float -> float array -> float

val skew : ?w:float array -> ?mean:float -> ?sd:float -> float array -> float

val kurtosis : ?w:float array -> ?mean:float -> ?sd:float -> float array -> float

val central_moment : int -> float array -> float

val covariance : ?mean0:float -> ?mean1:float -> float array -> float array -> float

val correlation : float array -> float array -> float

val pearson_r : float array -> float array -> float

val kendall_tau : float array -> float array -> float

val spearman_rho : float array -> float array -> float

val autocorrelation : ?lag:int -> float array -> float

val median : float array -> float
(** [median x] returns the median of [x]. *)

val percentile : float array -> float -> float
(** [percentile x p] returns the [p] percentile of the data [x]. [p] is between
  0. and 1. [x] does not need to be sorted.
 *)

val first_quartile : float array -> float
(** [first_quartile x] returns the first quartile of [x], i.e., 25 percentiles. *)

val third_quartile : float array -> float
(** [third_quartile x] returns the third quartile of [x], i.e., 75 percentiles. *)

val min : float array -> float

val max : float array -> float

val minmax : float array -> float * float

val min_i : float array -> float * int

val max_i : float array -> float * int

val minmax_i : float array -> float * int * float * int

val sort : ?inc:bool -> float array -> float array

val rank : float array -> float array
(** [ rank x ] translates each element in [x] to its ranking. The ranking Order
  is from the smallest one to the largest. E.g., [rank [|54.; 74.; 55.; 86.; 56.|]]
  returns [[|1.; 4.; 2.; 5.; 3.|]]. Note that the ranking starts with one!
 *)

val histogram : float array -> int -> int array


(** {6 MCMC: Markov Chain Monte Carlo} *)

val metropolis_hastings : (float array -> float) -> float array -> int -> float array array
(** TODO: [ metropolis_hastings f p n ] is Metropolis-Hastings MCMC algorithm.
  f is pdf of the p
 *)

val gibbs_sampling : (float array -> int -> float) -> float array -> int -> float array array
(** TODO: [ gibbs_sampling f p n ] is Gibbs sampler. f is a sampler based on the full
  conditional function of all variables
 *)


(** {6 Random numbers, PDF, and CDF} *)

module Rnd : sig

  (** Rnd module is for generating random variables of various distributions.

    Please refer to {{: https://www.gnu.org/software/gsl/manual }
    GSL documentation} for details.
   *)

  (** {6 Continuous random variables} *)

  val flat : float -> float -> float
  (** [flat a b] draws a random number from the interval [\[a,b)] with a uniform
    distribution.
   *)

  val uniform : unit -> float
  (** [uniform] returns a random float number within [\[0,1)], including 0
      but excluding 1. [uniform ()] is equivalent to [flat 0. 1.]
   *)

  val gaussian : ?sigma:float -> unit -> float
  (** [gaussian ~sigma:s ()] returns the value of a random variable that
      follows Normal distribution of [sigma = s]. *)

  val gaussian_tail : float -> float -> float
  (** [ gaussian_tail a x sigma ] returns a random value of a gaussian tail
    distribution. note "a" must be positive. *)

  val bivariate_gaussian : float -> float -> float -> float * float
  (** [ bivariate_gaussian sigma_x sigma_y rho ] returns a pair of correlated
    gaussian variates, with mean zero, correlation coefficient rho [-1, 1] and
    standard deviations sigma_x and sigma_y in the x and y directions. *)

  val exponential : float -> float
  (** [ exponential mu ] return a random value that follows exponential distribution. *)

  val laplace : float -> float

  val exppow : float -> float -> float

  val cauchy : float -> float

  val rayleigh : float -> float

  val landau : unit -> float

  val levy : float -> float -> float

  val levy_skew : float -> float -> float -> float

  val gamma : float -> float -> float

  val lognormal : float -> float -> float

  val chisq : float -> float

  val dirichlet : float array -> float array -> unit

  val fdist : float -> float -> float

  val tdist : float -> float

  val beta : float -> float -> float

  val logistic : float -> float

  val pareto : float -> float -> float

  val dir_2d : unit -> float * float

  val dir_2d_trig_method : unit -> float * float

  val dir_3d : unit -> float * float * float

  val dir_nd : int -> float array

  val weibull : float -> float -> float

  val gumbel1 : float -> float -> float

  val gumbel2 : float -> float -> float


  (** {6 Discrete random variables} *)

  val uniform_int : ?a:int -> ?b:int -> unit -> int
  (** [uniform_int a b] returns a random int between a and b inclusive,
      i.e., a random int in [a, b] *)

  val poisson : float -> int

  val bernoulli : float -> int

  val binomial : float -> int -> int

  val multinomial : int -> float array -> int array

  val negative_binomial : float -> float -> int

  val pascal : float -> int -> int

  val geometric : float -> int

  val hypergeometric : int -> int -> int -> int

  val logarithmic : float -> int

end


module Pdf : sig
  (** Pdf module provides the probability density functions of various random
    number distribution.

    Please refer to {{: https://www.gnu.org/software/gsl/manual }
    GSL documentation} for details.
   *)

   (** {6 Continuous random variables} *)

  val flat : float -> float -> float -> float

  val gaussian : float -> float -> float
  (** [ gaussian_pdf x sigma ] returns the probability density at x *)

  val gaussian_tail : float -> float -> float -> float
  (** [ gaussian_tail_pdf x a sigma ] returns the probability density at x given
      a gaussian tail distribution of N(a, sigma) *)

  val bivariate_gaussian : float -> float -> float -> float -> float -> float
  (** [ bivariate_gaussian x y sigma_x sigma_y rho ] returns the probability
    density p(x,y) at (x,y) for a bivariate Gaussian distribution with standard
    deviations sigma_x, sigma_y and correlation coefficient rho.  *)

  val exponential : float -> float -> float
  (** [ exponential x mu ] returns the probability density at x*)

  val laplace : float -> float -> float

  val cauchy : float -> float -> float

  val exppow : float -> float -> float -> float

  val rayleigh : float -> float -> float

  val landau : float -> float

  val gamma : float -> float -> float -> float

  val lognormal : float -> float -> float -> float

  val chisq : float -> float -> float

  val dirichlet : float array -> float array -> float

  val dirichlet_lnpdf : float array -> float array -> float

  val fdist : float -> float -> float -> float

  val tdist : float -> float -> float

  val beta : float -> float -> float -> float

  val logistic : float -> float -> float

  val pareto : float -> float -> float -> float

  val weibull : float -> float -> float -> float

  val gumbel1 : float -> float -> float -> float

  val gumbel2 : float -> float -> float -> float

  (** {6 Discrete random variables} *)

  val poisson : int -> float -> float

  val bernoulli : int -> float -> float

  val binomial : int -> float -> int -> float

  val multinomial : float array -> int array -> float

  val multinomial_lnpdf : float array -> int array -> float

  val negative_binomial : int -> float -> float -> float

  val pascal : int -> float -> int -> float

  val geometric : int -> float -> float

  val hypergeometric : int -> int -> int -> int -> float

  val logarithmic : int -> float -> float

end


module Cdf : sig
  (**
    For each random variable distribution, the module includes four corresponding
    functions (if well-defined).

    E.g., for [gaussian] distribution, there are four functions as follows:
    {ul
      {- [gaussian_P] : calculates CDF of the distribution, i.e., P(X <= x);}
      {- [gaussian_Q] : calculates tail distribution Q (X > x), i.e., 1 - P (X <= x);}
      {- [gaussian_Pinv] : the inverse function of P, also a.k.a percentile function;}
      {- [gaussian_Qinv] : the inverse function of Q.}
    }

    Please refer to {{: https://www.gnu.org/software/gsl/manual }
    GSL documentation} for details.
  *)

  (** {6 Continuous random variables} *)

  val flat_P : float -> float -> float -> float

  val flat_Q : float -> float -> float -> float

  val flat_Pinv : float -> float -> float -> float

  val flat_Qinv : float -> float -> float -> float

  val gaussian_P : float -> float -> float

  val gaussian_Q : float -> float -> float

  val gaussian_Pinv : float -> float -> float

  val gaussian_Qinv : float -> float -> float

  val exponential_P : float -> float -> float

  val exponential_Q : float -> float -> float

  val exponential_Pinv : float -> float -> float

  val exponential_Qinv : float -> float -> float

  val laplace_P : float -> float -> float

  val laplace_Q : float -> float -> float

  val laplace_Pinv : float -> float -> float

  val laplace_Qinv : float -> float -> float

  val exppow_P : float -> float -> float -> float

  val exppow_Q : float -> float -> float -> float

  val cauchy_P : float -> float -> float

  val cauchy_Q : float -> float -> float

  val cauchy_Pinv : float -> float -> float

  val cauchy_Qinv : float -> float -> float

  val rayleigh_P : float -> float -> float

  val rayleigh_Q : float -> float -> float

  val rayleigh_Pinv : float -> float -> float

  val rayleigh_Qinv : float -> float -> float

  val gamma_P : float -> float -> float -> float

  val gamma_Q : float -> float -> float -> float

  val gamma_Pinv : float -> float -> float -> float

  val gamma_Qinv : float -> float -> float -> float

  val lognormal_P : float -> float -> float -> float

  val lognormal_Q : float -> float -> float -> float

  val lognormal_Pinv : float -> float -> float -> float

  val lognormal_Qinv : float -> float -> float -> float

  val chisq_P : float -> float -> float

  val chisq_Q : float -> float -> float

  val chisq_Pinv : float -> float -> float

  val chisq_Qinv : float -> float -> float

  val fdist_P : float -> float -> float -> float

  val fdist_Q : float -> float -> float -> float

  val fdist_Pinv : float -> float -> float -> float

  val fdist_Qinv : float -> float -> float -> float

  val tdist_P : float -> float -> float

  val tdist_Q : float -> float -> float

  val tdist_Pinv : float -> float -> float

  val tdist_Qinv : float -> float -> float

  val beta_P : float -> float -> float -> float

  val beta_Q : float -> float -> float -> float

  val beta_Pinv : float -> float -> float -> float

  val beta_Qinv : float -> float -> float -> float

  val logistic_P : float -> float -> float

  val logistic_Q : float -> float -> float

  val logistic_Pinv : float -> float -> float

  val logistic_Qinv : float -> float -> float

  val pareto_P : float -> float -> float -> float

  val pareto_Q : float -> float -> float -> float

  val pareto_Pinv : float -> float -> float -> float

  val pareto_Qinv : float -> float -> float -> float

  val weibull_P : float -> float -> float -> float

  val weibull_Q : float -> float -> float -> float

  val weibull_Pinv : float -> float -> float -> float

  val weibull_Qinv : float -> float -> float -> float

  val gumbel1_P : float -> float -> float -> float

  val gumbel1_Q : float -> float -> float -> float

  val gumbel1_Pinv : float -> float -> float -> float

  val gumbel1_Qinv : float -> float -> float -> float

  val gumbel2_P : float -> float -> float -> float

  val gumbel2_Q : float -> float -> float -> float

  val gumbel2_Pinv : float -> float -> float -> float

  val gumbel2_Qinv : float -> float -> float -> float

  (** {6 Discrete random variables} *)

  val poisson_P : int -> float -> float

  val poisson_Q : int -> float -> float

  val binomial_P : int -> float -> int -> float

  val binomial_Q : int -> float -> int -> float

  val negative_binomial_P : int -> float -> float -> float

  val negative_binomial_Q : int -> float -> float -> float

  val pascal_P : int -> float -> int -> float

  val pascal_Q : int -> float -> int -> float

  val geometric_P : int -> float -> float

  val geometric_Q : int -> float -> float

  val hypergeometric_P : int -> int -> int -> int -> float

  val hypergeometric_Q : int -> int -> int -> int -> float

end


(* TODO: implement a small PPL *)


(* ends here *)
