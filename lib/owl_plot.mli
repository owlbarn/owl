(** Plot module  *)

type dsmat = Owl_dense.dsmat

type device = AQT | PNG | PDF | SVG

type plot_typ = {
  mutable title : string;
  mutable xlabel : string;
  mutable ylabel : string;
  mutable xrange : float option * float option;
  mutable yrange : float option * float option;
}

val set_device : device -> unit

val create : unit -> plot_typ

val set_title : plot_typ -> string -> unit

val set_xlabel : plot_typ -> string -> unit

val set_ylabel : plot_typ -> string -> unit

val set_xrange : plot_typ -> float option -> float option -> unit

val set_yrange : plot_typ -> float option -> float option -> unit

val my_plot : plot_typ -> dsmat -> dsmat -> unit

val plot : dsmat -> dsmat -> unit

val plot_fun : (float -> float) -> float -> float -> unit

val scatter : ?marker:char -> dsmat -> dsmat -> unit

val histogram : ?bin:int -> dsmat -> unit

val mesh : dsmat -> dsmat -> dsmat -> unit
