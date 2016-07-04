(*
  Library for generating random numbers.
*)


val seed : int -> unit
(** [seed x] sets x as seed for the internal random number generator.  *)

val uniform_int : ?a:int -> ?b:int -> unit -> int
(** [uniform_int a b] returns a random int between a and b inclusive,
    i.e., a random int in [a, b] *)

val uniform : unit -> float
(** [uniform] returns a random float number within [0,1), includes 0.
    but excludes 1. *)

val gaussian : ?sigma:float -> unit -> float
(** [gaussian ~sigma:s ()] return the value of a random variable that
    follows Normal distribution of sigma = s. *)
