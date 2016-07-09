(*
  Library for generating random numbers.
*)

(* continuous random variables *)

val seed : int -> unit
(** [seed x] sets x as seed for the internal random number generator.  *)

val uniform_int : ?a:int -> ?b:int -> unit -> int
(** [uniform_int a b] returns a random int between a and b inclusive,
    i.e., a random int in [a, b] *)

val uniform : unit -> float
(** [uniform] returns a random float number within [0,1), includes 0.
    but excludes 1. *)

val gaussian : ?sigma:float -> unit -> float
(** [gaussian ~sigma:s ()] returns the value of a random variable that
    follows Normal distribution of sigma = s. *)

val gaussian_pdf : float -> float -> float
(** [ gaussian_pdf x sigma ] returns the probability density at x of a given
  gaussian distribution p(x) dx = {1 \over \sqrt{2 \pi \sigma^2}} \exp (-x^2 / 2\sigma^2) dx *)

val gaussian_tail : float -> float -> float
(** [ gaussian_tail a x sigma ] returns a random value of a gaussian tail
  distribution. note "a" must be positive.
  p(x) dx = {1 \over N(a;\sigma) \sqrt{2 \pi \sigma^2}} \exp (- x^2/(2 \sigma^2)) dx *)

val gaussian_tail_pdf : float -> float -> float -> float
(** [ gaussian_tail_pdf x a sigma ] returns the probability density at x given
    a gaussian tail distribution of N(a, sigma) *)

val bivariate_gaussian : float -> float -> float -> float * float
(** [ bivariate_gaussian sigma_x sigma_y rho ] returns a pair of correlated
  gaussian variates, with mean zero, correlation coefficient rho [-1, 1] and
  standard deviations sigma_x and sigma_y in the x and y directions.
  The probability density function is  p(x,y) dx dy = {1 \over 2 \pi \sigma_x \sigma_y \sqrt{1-\rho^2}} \exp (-(x^2/\sigma_x^2 + y^2/\sigma_y^2 - 2 \rho x y/(\sigma_x\sigma_y))/2(1-\rho^2)) dx dy *)

val bivariate_gaussian_pdf : float -> float -> float -> float -> float -> float
(** [ bivariate_gaussian_pdf x y sigma_x sigma_y rho ] returns the probability
  density p(x,y) at (x,y) for a bivariate Gaussian distribution with standard
  deviations sigma_x, sigma_y and correlation coefficient rho.  *)

val exponential : float -> float
(** [ exponential mu ] return a random value of the following exponential
  distribution p(x) dx = {1 \over \mu} \exp(-x/\mu) dx *)

val exponential_pdf : float -> float -> float
(** [ exponential_pdf x mu ] returns the probability density at x given an
exponential distribution of p(x) dx = {1 \over \mu} \exp(-x/\mu) dx *)

val laplace : float -> float
(** [ ]
  p(x) dx = {1 \over 2 a}  \exp(-|x/a|) dx  *)

val laplace_pdf : float -> float -> float
(** [ ]  *)

(* discrete random variables *)

val poisson : float -> int
