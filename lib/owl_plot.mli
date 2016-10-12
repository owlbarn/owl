(** Plot module  *)

type dsmat = Owl_dense.dsmat

type handle

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

val set_foreground_color : handle -> int -> int -> int -> unit

val set_background_color : handle -> int -> int -> int -> unit

val set_font_size : handle -> float -> unit

val set_pen_size : handle -> float -> unit

val set_page_size : handle -> int -> int -> unit

(** Line style is an integer ranging from 1 to 8. *)

val plot : ?h:handle -> ?color:int * int * int -> ?marker:string -> ?marker_size:float -> ?line_style:int -> ?line_width:float -> dsmat -> dsmat -> unit

val plot_fun : ?h:handle -> ?color:int * int * int -> ?marker:string -> ?marker_size:float -> ?line_style:int -> ?line_width:float -> (float -> float) -> float -> float -> unit

val scatter : ?h:handle -> ?color:int * int * int -> ?marker:string -> ?marker_size:float -> dsmat -> dsmat -> unit

val histogram : ?h:handle -> ?bin:int -> dsmat -> unit

val stem : ?h:handle -> ?color:int * int * int -> ?marker:string -> ?marker_size:float -> ?line_style:int -> ?line_width:float -> dsmat -> dsmat -> unit

val autocorr : ?h:handle -> ?marker:string -> ?marker_size:float -> dsmat -> unit

val text : ?h:handle -> float -> float -> ?dx:float -> ?dy:float -> string -> unit

val draw_line: ?h:handle -> ?color:int * int * int -> ?line_style:int -> ?line_width:float -> float -> float -> float -> float -> unit

val mesh : ?h:handle -> dsmat -> dsmat -> dsmat -> unit

val bar : ?h:handle -> ?color:int * int * int -> ?line_style:int -> ?fill_pattern:int -> dsmat -> unit

val area : ?h:handle -> ?color:int * int * int -> ?line_style:int -> ?fill_pattern:int -> dsmat -> dsmat -> unit
