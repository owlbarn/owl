(** Plot module  *)

type dsmat = Owl_dense.dsmat

type handle

type marker_typ = SQUARE | DOT | PLUS | STAR | CIRCLE | CROSS | UPTRI | DIAMOND | PENTAGON

type color = RED | GREEN | BLUE

val create : ?m:int -> ?n:int -> string -> handle

val subplot : handle -> int -> int -> unit

val output : handle -> unit

val set_output : handle -> string -> unit

val set_title : handle -> string -> unit

val set_xlabel : handle -> string -> unit

val set_ylabel : handle -> string -> unit

val set_zlabel : handle -> string -> unit

val set_xrange : handle -> float -> float -> unit

val set_yrange : handle -> float -> float -> unit

val set_zrange : handle -> float -> float -> unit

val set_marker_style : handle -> marker_typ -> unit

val set_marker_size : handle -> float -> unit

val set_foreground_color : handle -> int -> int -> int -> unit

val set_background_color : handle -> int -> int -> int -> unit

val set_font_size : handle -> float -> unit

val set_line_color : handle -> int -> int -> int -> unit

val plot : ?h:handle -> dsmat -> dsmat -> unit

val plot_fun : ?h:handle -> (float -> float) -> float -> float -> unit

val scatter : ?h:handle -> dsmat -> dsmat -> unit

val histogram : ?h:handle -> ?bin:int -> dsmat -> unit

val mesh : ?h:handle -> dsmat -> dsmat -> dsmat -> unit

val text : ?h:handle -> float -> float -> ?dx:float -> ?dy:float -> string -> unit
