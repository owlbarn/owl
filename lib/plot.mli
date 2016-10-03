(** [ Plot module ]  *)

type dsmat = Dense.dsmat

val plot : dsmat -> dsmat -> unit

val plot_fun : (float -> float) -> float -> float -> unit

val scatter : ?marker:char -> dsmat -> dsmat -> unit

val histogram : ?bin:int -> dsmat -> unit

val mesh : dsmat -> dsmat -> dsmat -> unit
