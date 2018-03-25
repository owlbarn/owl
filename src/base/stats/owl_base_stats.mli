(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(**
Statistics: random number generators, PDF and CDF functions, and hypothesis
tests. The module also includes some basic statistical functions such as mean,
variance, skew, and etc.
*)


(** {6 Randomisation functions} *)

val shuffle : 'a array -> 'a array
(** ``shuffle x`` return a new array of the shuffled ``x``.  *)

val choose : 'a array -> int -> 'a array
(** ``choose x n`` draw ``n`` samples from ``x`` without replecement.  *)

val sample : 'a array -> int -> 'a array
(** ``sample x n`` draw ``n`` samples from ``x`` with replacement.  *)


(** {6 Basic statistical functions} *)

val sum : float array -> float
(** ``sum x`` returns the summation of the elements in ``x``. *)

val mean : float array -> float
(** ``mean x`` returns the mean of the elements in ``x``. *)

val var : ?mean:float -> float array -> float
(** ``var x`` returns the variance of elements in ``x``. *)

val std : ?mean:float -> float array -> float
(** ``std x`` calculates the standard deviation of ``x``. *)

val sem : ?mean:float -> float array -> float
(**
``sem x`` calculates the standard error of ``x``, also referred to as
standard error of the mean.
 *)

val absdev : ?mean:float -> float array -> float
(** ``absdev x`` calculates the average absolute deviation of ``x``. *)

val skew : ?mean:float -> ?sd:float -> float array -> float
(** ``skew x`` calculates the skewness (the third standardized moment) of ``x``. *)

val kurtosis : ?mean:float -> ?sd:float -> float array -> float
(**
``kurtosis x`` calculates the Pearson's kurtosis of ``x``, i.e. the fourth
standardized moment of ``x``.
 *)


(** {6 Random variables} *)

val uniform : float -> float -> float
(** ``uniform a b`` returns a continuous RV uniformly distributed within [``a``, ``b``]. *)

val bernoulli : float -> float
(** ``bernoulli p`` returns a continuous RV equal to ``1.`` with probability ``p``, ``0.`` otherwise *)

val gaussian : float -> float -> float
(** ``gaussian mu sigma`` returns a continous RV normally distributed with mean ``mu`` and stddev ``sigma`` *)


(* ends here *)
