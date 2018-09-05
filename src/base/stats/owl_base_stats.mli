(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(**
Statistics: random number generators, PDF and CDF functions, and hypothesis
tests. The module also includes some basic statistical functions such as mean,
variance, skew, and etc.
*)


(** {6 Randomisation functions} *)

val shuffle : 'a array -> 'a array
(** Refer to :doc:`owl_stats`. *)

val choose : 'a array -> int -> 'a array
(** Refer to :doc:`owl_stats`. *)

val sample : 'a array -> int -> 'a array
(** Refer to :doc:`owl_stats`. *)


(** {6 Basic statistical functions} *)

val sum : float array -> float
(** Refer to :doc:`owl_stats`. *)

val mean : float array -> float
(** Refer to :doc:`owl_stats`. *)

val var : ?mean:float -> float array -> float
(** Refer to :doc:`owl_stats`. *)

val std : ?mean:float -> float array -> float
(** Refer to :doc:`owl_stats`. *)

val sem : ?mean:float -> float array -> float
(** Refer to :doc:`owl_stats`. *)

val absdev : ?mean:float -> float array -> float
(** Refer to :doc:`owl_stats`. *)

val skew : ?mean:float -> ?sd:float -> float array -> float
(** Refer to :doc:`owl_stats`. *)

val kurtosis : ?mean:float -> ?sd:float -> float array -> float
(** Refer to :doc:`owl_stats`. *)

val central_moment : int -> float array -> float
(** Refer to :doc:`owl_stats`. *)

val cov : ?m0:float -> ?m1:float -> float array -> float array -> float
(** Refer to :doc:`owl_stats`. *)

val concordant : 'a array -> 'b array -> int
(** Refer to :doc:`owl_stats`. *)

val discordant : 'a array -> 'b array -> int
(** Refer to :doc:`owl_stats`. *)

val kendall_tau : float array -> float array -> float
(** Refer to :doc:`owl_stats`. *)

val min : float array -> float
(** Refer to :doc:`owl_stats`. *)

val max : float array -> float
(** Refer to :doc:`owl_stats`. *)

val minmax : float array -> float * float
(** Refer to :doc:`owl_stats`. *)

val min_i : float array -> int
(** Refer to :doc:`owl_stats`. *)

val max_i : float array -> int
(** Refer to :doc:`owl_stats`. *)

val minmax_i : float array -> int * int
(** Refer to :doc:`owl_stats`. *)

val sort : ?inc:bool -> float array -> float array
(** Refer to :doc:`owl_stats`. *)

val argsort : ?inc:bool -> float array -> int array
(** Refer to :doc:`owl_stats`. *)

val rank : ?ties_strategy:[ `Average | `Min | `Max ] -> float array -> float array
(** Refer to :doc:`owl_stats`. *)

val percentile : float array -> float -> float
(** Refer to :doc:`owl_stats`. *)

val quantile : float array -> float -> float
(** Refer to :doc:`owl_stats`. *)

val first_quartile : float array -> float
(** Refer to :doc:`owl_stats`. *)

val third_quartile : float array -> float
(** Refer to :doc:`owl_stats`. *)

val median : float array -> float
(** Refer to :doc:`owl_stats`. *)

type histogram = {
  bins              : float array;
  counts            : int array;
  weighted_counts   : float array option;
  normalised_counts : float array option;
  density           : float array option
}
(** Refer to :doc:`owl_stats`. *)

val histogram : [ `Bins of float array | `N of int ] -> ?weights:float array ->
  float array -> histogram
(** Refer to :doc:`owl_stats`. *)

val histogram_sorted : [ `Bins of float array | `N of int ] -> ?weights:float array -> float array -> histogram
(** Refer to :doc:`owl_stats`. *)

val normalise : histogram -> histogram
(** Refer to :doc:`owl_stats`. *)

val normalise_density : histogram -> histogram
(** Refer to :doc:`owl_stats`. *)

val pp_hist: Format.formatter -> histogram -> unit
(** Refer to :doc:`owl_stats`. *)

val tukey_fences : ?k:float -> float array -> float * float
(** Refer to :doc:`owl_stats`. *)


(** {6 Random variables} *)

val uniform_rvs : a:float -> b:float -> float
(** Refer to :doc:`owl_stats`. *)

val bernoulli_rvs : p:float -> float
(** Refer to :doc:`owl_stats`. *)

val gaussian_rvs : mu:float -> sigma:float -> float
(** Refer to :doc:`owl_stats`. *)

val exponential_rvs : lambda:float -> float
(** Refer to :doc:`owl_stats`. *)

val cauchy_rvs : loc:float -> scale:float -> float
(** Refer to :doc:`owl_stats`. *)

val std_gamma_rvs : shape:float -> float
(** Refer to :doc:`owl_stats`. *)

val gamma_rvs : shape:float -> scale:float -> float
(** Refer to :doc:`owl_stats`. *)

val gumbel1_rvs : a:float -> b:float -> float
(** Refer to :doc:`owl_stats`. *)

val gumbel2_rvs : a:float -> b:float -> float
(** Refer to :doc:`owl_stats`. *)


(* ends here *)
