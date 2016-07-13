(** [ Module for math, statistics, distributions ]

  The functions in this module are grouped based on their corresponding
  distributions. For each random variable distribution, e.g., distribution abc,
  there are usually six corresponding (if any) functions as follows:

  1) abc : generate a random value following the distribution abc;
  2) abc_pdf : calculate the probability desensit at a given point;
  3) abc_P : calculate CDF of the distribution, i.e., P(X <= x);
  4) abc_Q : calculate tail distribution Q (X > x), i.e., 1 - P (X <= x);
  5) abc_Pinv : the inverse function of P, also a.k.a percentile function;
  6) abc_Qinv : the inverse function of Q.

  Please refer to GSL documentation using following linke for details:
  https://www.gnu.org/software/gsl/manual
*)


(** [ Constants ]  *)

val e : float

val pi : float

val euler : float


(** [ Helper and randomisation functions ]  *)

val seed : int -> unit
(** [seed x] sets x as seed for the internal random number generator.  *)

val shuffle : 'a array -> 'a array
(** [ shuffle x ] return a new array of the shuffled x  *)

val choose : 'a array -> int -> 'a array
(** [ choose x n ] draw n samples from x without replecement  *)

val sample : 'a array -> int -> 'a array
(** [ sample x n ] draw n samples from x with replacement  *)


(** [ Statistics functions ]  *)

val mean : ?w:float array -> float array -> float

val variance : ?w:float array -> ?mean:float -> float array -> float

val std : ?w:float array -> ?mean:float -> float array -> float

val absdev : ?w:float array -> ?mean:float -> float array -> float

val skew : ?w:float array -> ?mean:float -> ?sd:float -> float array -> float

val kurtosis : ?w:float array -> ?mean:float -> ?sd:float -> float array -> float

val covariance : ?mean0:float -> ?mean1:float -> float array -> float array -> float

val min : float array -> float

val max : float array -> float

val minmax : float array -> float * float

val min_i : float array -> float * int

val max_i : float array -> float * int

val minmax_i : float array -> float * int * float * int


(** [ Basic and advanced math functions ]  *)

val abs : float -> float

val sqrt : float -> float

val pow : float -> float -> float

val exp : float -> float

val expm1 : float -> float

val exp_mult : float -> float -> float

val exprel : float -> float

val log1p : float -> float

val log_abs : float -> float

val sin : float -> float

val cos : float -> float

val asinh : float -> float

val acosh : float -> float

val atanh : float -> float

val hypot : float -> float -> float

val beta : float -> float

val betaf : float -> float -> float

val betaf_inc : float -> float -> float -> float

val gammaf : float -> float

val lngammaf : float -> float

val zeta : float -> float

val hzeta : float -> float -> float

val eta : float -> float

val lambert_w0 : float -> float

val lambert_w1 : float -> float

val factorial : int -> float

val double_factorial : int -> float

val taylorcoeff : int -> float -> float

val combination : int -> int -> float

val poch : float -> float -> float

val dilog : float -> float


(** [ Uniform distribution ]  *)

val uniform_int : ?a:int -> ?b:int -> unit -> int
(** [uniform_int a b] returns a random int between a and b inclusive,
    i.e., a random int in [a, b] *)

val uniform : unit -> float
(** [uniform] returns a random float number within [0,1), includes 0.
    but excludes 1. *)

val flat : float -> float -> float

val flat_pdf : float -> float -> float -> float

val flat_P : float -> float -> float -> float

val flat_Q : float -> float -> float -> float

val flat_Pinv : float -> float -> float -> float

val flat_Qinv : float -> float -> float -> float


(** [ Gaussian distribution ]  *)

val gaussian : ?sigma:float -> unit -> float
(** [gaussian ~sigma:s ()] returns the value of a random variable that
    follows Normal distribution of sigma = s. *)

val gaussian_pdf : float -> float -> float
(** [ gaussian_pdf x sigma ] returns the probability density at x *)

val gaussian_P : float -> float -> float

val gaussian_Q : float -> float -> float

val gaussian_Pinv : float -> float -> float

val gaussian_Qinv : float -> float -> float


(** [ Gaussian tail distribution ]  *)

val gaussian_tail : float -> float -> float
(** [ gaussian_tail a x sigma ] returns a random value of a gaussian tail
  distribution. note "a" must be positive. *)

val gaussian_tail_pdf : float -> float -> float -> float
(** [ gaussian_tail_pdf x a sigma ] returns the probability density at x given
    a gaussian tail distribution of N(a, sigma) *)


(** [ Bivariate distribution ]  *)

val bivariate_gaussian : float -> float -> float -> float * float
(** [ bivariate_gaussian sigma_x sigma_y rho ] returns a pair of correlated
  gaussian variates, with mean zero, correlation coefficient rho [-1, 1] and
  standard deviations sigma_x and sigma_y in the x and y directions. *)

val bivariate_gaussian_pdf : float -> float -> float -> float -> float -> float
(** [ bivariate_gaussian_pdf x y sigma_x sigma_y rho ] returns the probability
  density p(x,y) at (x,y) for a bivariate Gaussian distribution with standard
  deviations sigma_x, sigma_y and correlation coefficient rho.  *)


(** [ Exponential distribution ]
  p(x) dx = {1 \over \mu} \exp(-x/\mu) dx
  *)

val exponential : float -> float
(** [ exponential mu ] return a random value *)

val exponential_pdf : float -> float -> float
(** [ exponential_pdf x mu ] returns the probability density at x*)

val exponential_P : float -> float -> float

val exponential_Q : float -> float -> float

val exponential_Pinv : float -> float -> float

val exponential_Qinv : float -> float -> float


(** [ Laplace distribution ]
  p(x) dx = {1 \over 2 a}  \exp(-|x/a|) dx
  *)

val laplace : float -> float
(** p(x) dx = {1 \over 2 a}  \exp(-|x/a|) dx  *)

val laplace_pdf : float -> float -> float

val laplace_P : float -> float -> float

val laplace_Q : float -> float -> float

val laplace_Pinv : float -> float -> float

val laplace_Qinv : float -> float -> float


(** [ Exponential power distribution ]  *)

val exppow : float -> float -> float

val exppow_pdf : float -> float -> float -> float

val exppow_P : float -> float -> float -> float

val exppow_Q : float -> float -> float -> float


(** [ Cauchy distribution ]  *)

val cauchy : float -> float

val cauchy_pdf : float -> float -> float

val cauchy_P : float -> float -> float

val cauchy_Q : float -> float -> float

val cauchy_Pinv : float -> float -> float

val cauchy_Qinv : float -> float -> float


(** [ Rayleigh distribution ]  *)

val rayleigh : float -> float

val rayleigh_pdf : float -> float -> float

val rayleigh_P : float -> float -> float

val rayleigh_Q : float -> float -> float

val rayleigh_Pinv : float -> float -> float

val rayleigh_Qinv : float -> float -> float


(** [ Landau distribution ]  *)

val landau : unit -> float

val landau_pdf : float -> float


(** [ Levy alpha-stable distribution ]  *)

val levy : float -> float -> float


(** [ Levy skew alpha-stable distribution ]  *)

val levy_skew : float -> float -> float -> float


(** [ Gamma distribution ]  *)

val gamma : float -> float -> float

val gamma_pdf : float -> float -> float -> float

val gamma_P : float -> float -> float -> float

val gamma_Q : float -> float -> float -> float

val gamma_Pinv : float -> float -> float -> float

val gamma_Qinv : float -> float -> float -> float


(** [ Lognormal distribution ]  *)

val lognormal : float -> float -> float

val lognormal_pdf : float -> float -> float -> float

val lognormal_P : float -> float -> float -> float

val lognormal_Q : float -> float -> float -> float

val lognormal_Pinv : float -> float -> float -> float

val lognormal_Qinv : float -> float -> float -> float


(** [ Chi-squared distribution ]  *)

val chisq : float -> float

val chisq_pdf : float -> float -> float

val chisq_P : float -> float -> float

val chisq_Q : float -> float -> float

val chisq_Pinv : float -> float -> float

val chisq_Qinv : float -> float -> float


(** [ Dirichlet distribution ]  *)

val dirichlet : float array -> float array -> unit

val dirichlet_pdf : float array -> float array -> float

val dirichlet_lnpdf : float array -> float array -> float


(** [ F distribution ]  *)

val fdist : float -> float -> float

val fdist_pdf : float -> float -> float -> float

val fdist_P : float -> float -> float -> float

val fdist_Q : float -> float -> float -> float

val fdist_Pinv : float -> float -> float -> float

val fdist_Qinv : float -> float -> float -> float


(** [ T distribution ]  *)

val tdist : float -> float

val tdist_pdf : float -> float -> float

val tdist_P : float -> float -> float

val tdist_Q : float -> float -> float

val tdist_Pinv : float -> float -> float

val tdist_Qinv : float -> float -> float


(** [ Beta distribution ]  *)

val beta : float -> float -> float

val beta_pdf : float -> float -> float -> float

val beta_P : float -> float -> float -> float

val beta_Q : float -> float -> float -> float

val beta_Pinv : float -> float -> float -> float

val beta_Qinv : float -> float -> float -> float


(** [ Logistic distribution ]  *)

val logistic : float -> float

val logistic_pdf : float -> float -> float

val logistic_P : float -> float -> float

val logistic_Q : float -> float -> float

val logistic_Pinv : float -> float -> float

val logistic_Qinv : float -> float -> float


(** [ Pareto distribution ]  *)

val pareto : float -> float -> float

val pareto_pdf : float -> float -> float -> float

val pareto_P : float -> float -> float -> float

val pareto_Q : float -> float -> float -> float

val pareto_Pinv : float -> float -> float -> float

val pareto_Qinv : float -> float -> float -> float


(** [ Spherical Vector distributions: ]  *)

val dir_2d : unit -> float * float

val dir_2d_trig_method : unit -> float * float

val dir_3d : unit -> float * float * float

val dir_nd : int -> float array


(** [ Weibull distribution ]  *)

val weibull : float -> float -> float

val weibull_pdf : float -> float -> float -> float

val weibull_P : float -> float -> float -> float

val weibull_Q : float -> float -> float -> float

val weibull_Pinv : float -> float -> float -> float

val weibull_Qinv : float -> float -> float -> float


(** [ Type-1 Gumbel distribution ]  *)

val gumbel1 : float -> float -> float

val gumbel1_pdf : float -> float -> float -> float

val gumbel1_P : float -> float -> float -> float

val gumbel1_Q : float -> float -> float -> float

val gumbel1_Pinv : float -> float -> float -> float

val gumbel1_Qinv : float -> float -> float -> float


(** [ Type-2 Gumbel distribution ]  *)

val gumbel2 : float -> float -> float

val gumbel2_pdf : float -> float -> float -> float

val gumbel2_P : float -> float -> float -> float

val gumbel2_Q : float -> float -> float -> float

val gumbel2_Pinv : float -> float -> float -> float

val gumbel2_Qinv : float -> float -> float -> float


(** [ Poisson distribution ]  *)

val poisson : float -> int

val poisson_pdf : int -> float -> float

val poisson_P : int -> float -> float

val poisson_Q : int -> float -> float


(** [ Bernoulli distribution ]  *)

val bernoulli : float -> int

val bernoulli_pdf : int -> float -> float


(** [ Binomial distribution ]  *)

val binomial : float -> int -> int

val binomial_pdf : int -> float -> int -> float

val binomial_P : int -> float -> int -> float

val binomial_Q : int -> float -> int -> float


(** [ Multinomial distribution ]  *)

val multinomial : int -> float array -> int array

val multinomial_pdf : float array -> int array -> float

val multinomial_lnpdf : float array -> int array -> float


(** [ Negative Binomial distribution ]  *)

val negative_binomial : float -> float -> int

val negative_binomial_pdf : int -> float -> float -> float

val negative_binomial_P : int -> float -> float -> float

val negative_binomial_Q : int -> float -> float -> float


(** [ Pascal distribution ]  *)

val pascal : float -> int -> int

val pascal_pdf : int -> float -> int -> float

val pascal_P : int -> float -> int -> float

val pascal_Q : int -> float -> int -> float


(** [ Geometric distribution ]  *)

val geometric : float -> int

val geometric_pdf : int -> float -> float

val geometric_P : int -> float -> float

val geometric_Q : int -> float -> float


(** [ Hypergeometric distribution ]  *)

val hypergeometric : int -> int -> int -> int

val hypergeometric_pdf : int -> int -> int -> int -> float

val hypergeometric_P : int -> int -> int -> int -> float

val hypergeometric_Q : int -> int -> int -> int -> float


(** [ Logarithmic distribution ]  *)

val logarithmic : float -> int

val logarithmic_pdf : int -> float -> float



(* ends here *)
