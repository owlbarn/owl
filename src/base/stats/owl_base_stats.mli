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

val central_moment : int -> float array -> float
(** ``central_moment n x`` calcuates the ``n`` th central moment of ``x``. *)

val cov : ?m0:float -> ?m1:float -> float array -> float array -> float
(**
``cov x0 x1`` calculates the covariance of ``x0`` and ``x1``, the mean of
``x0`` and ``x1`` can be specified by ``m0`` and ``m1`` respectively.
 *)

val concordant : 'a array -> 'b array -> int
(** TODO *)

val discordant : 'a array -> 'b array -> int
(** TODO *)

val kendall_tau : float array -> float array -> float
(** ``kendall_tau x y`` calcuates the Kendall Tau correlation between ``x`` and ``y``. *)

val min : float array -> float
(** ``min x`` returns the minimum element in ``x``. *)

val max : float array -> float
(** ``max x`` returns the maximum element in ``x``. *)

val minmax : float array -> float * float
(** ``minmax x`` returns both ``(minimum, maximum)`` elements in ``x``. *)

val min_i : float array -> int
(** ``min_i x`` returns the index of the minimum in ``x``. *)

val max_i : float array -> int
(** ``max_i x`` returns the index of the maximum in ``x``. *)

val minmax_i : float array -> int * int
(** ``minmax_i x`` returns the indices of both minimum and maximum in ``x``. *)

val sort : ?inc:bool -> float array -> float array
(** ``sort x`` sorts the elements in the ``x`` in increasing order if
``inc = true``, otherwise in decreasing order if ``inc=false``. By default,
``inc`` is ``true``. Note a copy is returned, the original data is not modified.
 *)

val argsort : ?inc:bool -> float array -> int array
(**
``argsort x`` sorts the elements in ``x`` and returns the indices mapping of
the elements in the current array to their original position in ``x``.

The sorting is in increasing order if ``inc = true``, otherwise in decreasing
order if ``inc=false``. By default, ``inc`` is ``true``.
 *)

val rank : ?ties_strategy:[ `Average | `Min | `Max ] -> float array -> float array
(**
Computes sample's ranks.

The ranking order is from the smallest one to the largest. For example
``rank [|54.; 74.; 55.; 86.; 56.|]`` returns ``[|1.; 4.; 2.; 5.; 3.|]``.
Note that the ranking starts with one!

``ties_strategy`` controls which ranks are assigned to equal values:

- ``Average`` the mean of ranks should be assigned to each value.
  {b Default}.
- ``Min`` the minimum of ranks is assigned to each value.
- ``Max`` the maximum of ranks is assigned to each value.
 *)

val histogram : float array -> int -> int array
(** ``histogram x n`` creates a histogram of ``n`` buckets for ``x``. *)


(** {6 Random variables} *)

val uniform_rvs : float -> float -> float
(** ``uniform a b`` returns a continuous RV uniformly distributed within [``a``, ``b``]. *)

val bernoulli_rvs : float -> float
(** ``bernoulli_rvs p`` returns a continuous RV equal to ``1.`` with probability ``p``, ``0.`` otherwise *)

val gaussian_rvs : float -> float -> float
(** ``gaussian_rvs mu sigma`` returns a continous RV normally distributed with mean ``mu`` and stddev ``sigma`` *)


(* ends here *)
