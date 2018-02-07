(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(**
Statistics: random number generators, PDF and CDF functions, and hypothesis
tests. The module also includes some basic statistical functions such as mean,
variance, skew, and etc.
*)

(** {1 Random variables} *)

val uniform : float -> float -> float
(** ``uniform a b`` returns a continuous RV uniformly distributed within [``a``, ``b``]. *)

val bernoulli : float -> float
(** ``bernoulli p`` returns a continuous RV equal to ``1.`` with probability ``p``, ``0.`` otherwise *)

val gaussian : float -> float -> float
(** ``gaussian mu sigma`` returns a continous RV normally distributed with mean ``mu`` and stddev ``sigma`` *)


(* ends here *)
