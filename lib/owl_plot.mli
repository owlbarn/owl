(** Plot module  *)

type dsmat = Owl_dense.dsmat

type plot_typ

type marker_typ = SQUARE | DOT | PLUS | STAR | CIRCLE | CROSS | UPTRI | DIAMOND | PENTAGON

val create : unit -> plot_typ

val output : plot_typ -> unit

val set_output : plot_typ -> string -> unit

val set_title : plot_typ -> string -> unit

val set_xlabel : plot_typ -> string -> unit

val set_ylabel : plot_typ -> string -> unit

val set_zlabel : plot_typ -> string -> unit

val set_xrange : plot_typ -> float -> float -> unit

val set_yrange : plot_typ -> float -> float -> unit

val set_zrange : plot_typ -> float -> float -> unit

val set_marker_style : plot_typ -> marker_typ -> unit

val set_marker_size : plot_typ -> float -> unit

val set_foreground_color : plot_typ -> int -> int -> int -> unit

val set_background_color : plot_typ -> int -> int -> int -> unit

val set_font_size : plot_typ -> float -> unit

val set_line_color : plot_typ -> int -> int -> int -> unit

val plot : ?h:plot_typ -> dsmat -> dsmat -> unit

val plot_fun : ?h:plot_typ -> (float -> float) -> float -> float -> unit

val scatter : ?h:plot_typ -> dsmat -> dsmat -> unit

val histogram : ?h:plot_typ -> ?bin:int -> dsmat -> unit

val mesh : ?h:plot_typ -> dsmat -> dsmat -> dsmat -> unit
