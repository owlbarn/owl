(** Plot module
  The input to a plot function is supposed to be a row-based matrix.
 *)

type dsmat = Owl_dense_real.mat

type handle

type color = RED | GREEN | BLUE

type legend_position = North | South | West | East | NorthWest | NorthEast | SouthWest | SouthEast


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

val legend_on : handle -> ?position:legend_position -> string array -> unit

val legend_off : handle -> unit

(** Line style is an integer ranging from 1 to 8. *)

val plot : ?h:handle -> ?color:int * int * int -> ?marker:string -> ?marker_size:float -> ?line_style:int -> ?line_width:float -> dsmat -> dsmat -> unit

val plot_fun : ?h:handle -> ?color:int * int * int -> ?marker:string -> ?marker_size:float -> ?line_style:int -> ?line_width:float -> (float -> float) -> float -> float -> unit

val scatter : ?h:handle -> ?color:int * int * int -> ?marker:string -> ?marker_size:float -> dsmat -> dsmat -> unit

val histogram : ?h:handle -> ?color:int * int * int -> ?bin:int -> dsmat -> unit

val ecdf : ?h:handle -> ?color:int * int * int -> ?line_style:int -> ?line_width:float -> dsmat -> unit

val stairs : ?h:handle -> ?color:int * int * int -> ?line_style:int -> ?line_width:float -> dsmat -> dsmat -> unit

val stem : ?h:handle -> ?color:int * int * int -> ?marker:string -> ?marker_size:float -> ?line_style:int -> ?line_width:float -> dsmat -> dsmat -> unit

val autocorr : ?h:handle -> ?marker:string -> ?marker_size:float -> dsmat -> unit

val text : ?h:handle -> ?color:int * int * int -> float -> float -> ?dx:float -> ?dy:float -> string -> unit

val draw_line: ?h:handle -> ?color:int * int * int -> ?line_style:int -> ?line_width:float -> float -> float -> float -> float -> unit

val draw_rect : ?h:handle -> ?color:int * int * int -> ?line_style:int -> ?fill_pattern:int -> float -> float -> float -> float -> unit

val draw_circle : ?h:handle -> ?color:int * int * int -> ?line_style:int -> ?line_width:float -> ?fill_pattern:int -> float -> float -> float -> unit

val bar : ?h:handle -> ?color:int * int * int -> ?line_style:int -> ?fill_pattern:int -> dsmat -> unit

val area : ?h:handle -> ?color:int * int * int -> ?line_style:int -> ?fill_pattern:int -> dsmat -> dsmat -> unit

val error_bar : ?h:handle -> ?color:int * int * int -> ?line_style:int -> ?line_width:float -> dsmat -> dsmat -> dsmat -> unit

val boxplot : ?h:handle -> ?color:int * int * int -> dsmat -> unit

val pie : ?h:handle -> ?color:int * int * int -> ?fill:bool -> dsmat -> unit

(** Plot 3D figures *)

val plot3d : ?h:handle -> ?contour:bool -> dsmat -> dsmat -> dsmat -> unit
(** [plot3d] is just an alias of [surf] function. *)

val surf : ?h:handle -> ?contour:bool -> dsmat -> dsmat -> dsmat -> unit

val mesh : ?h:handle -> ?contour:bool -> dsmat -> dsmat -> dsmat -> unit

val contour : ?h:handle -> dsmat -> dsmat -> dsmat -> unit

val heatmap : ?h:handle -> dsmat -> dsmat -> dsmat -> unit
