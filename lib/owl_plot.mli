(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Plot: high-level plotting functions. *)

(** The input to a plot function is supposed to be a row-based matrix/vector.
  The functions in this module are built atop of Plplot library.
 *)


type dsmat = Owl_dense_matrix.D.mat

type handle

type color = RED | GREEN | BLUE

type legend_position = North | South | West | East | NorthWest | NorthEast | SouthWest | SouthEast

type spec =
  | RGB         of int * int * int
  | LineStyle   of int
  | LineWidth   of float
  | Marker      of string
  | MarkerSize  of float
  | Fill
  | FillPattern of int
  | Contour
  | Altitude    of float
  | Azimuth     of float


(** {6 Config functions} *)


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

val set_xticklabels : handle -> (float * string) list -> unit

val set_yticklabels : handle -> (float * string) list -> unit

val set_zticklabels : handle -> (float * string) list -> unit

val set_foreground_color : handle -> int -> int -> int -> unit

val set_background_color : handle -> int -> int -> int -> unit

val set_altitude : handle -> float -> unit

val set_azimuth : handle -> float -> unit

val set_font_size : handle -> float -> unit

val set_pen_size : handle -> float -> unit

val set_page_size : handle -> int -> int -> unit

val legend_on : handle -> ?position:legend_position -> string array -> unit

val legend_off : handle -> unit


(** {6 Basic plot functions} *)

(** Line style is an integer ranging from 1 to 8. *)

val plot : ?h:handle -> ?spec:spec list -> dsmat -> dsmat -> unit
(** [plot x y] plots [y] as a function of [x].

  Parameters: [RGB], [Marker], [MarkerSize], [LineStyle], [LineWidth].
 *)

val plot_fun : ?h:handle -> ?spec:spec list -> (float -> float) -> float -> float -> unit
(** [plot_fun f a b] generates a line plot for function [f : float -> float]
  in the interval [a, b].

  Parameters: [RGB], [Marker], [MarkerSize], [LineStyle], [LineWidth].
 *)

val scatter : ?h:handle -> ?color:int * int * int -> ?marker:string -> ?marker_size:float -> dsmat -> dsmat -> unit

val histogram : ?h:handle -> ?color:int * int * int -> ?bin:int -> dsmat -> unit

val ecdf : ?h:handle -> ?spec:spec list -> dsmat -> unit
(** [ecdf x]

  Parameters: [RGB], [LineStyle], [LineWidth].
 *)

val stairs : ?h:handle -> ?spec:spec list -> dsmat -> dsmat -> unit
(** [stairs x y]

  Parameters: [RGB], [LineStyle], [LineWidth].
 *)

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


(** {6 3D plot functions} *)


val plot3d : ?h:handle -> ?contour:bool -> ?altitude:float -> ?azimuth:float -> dsmat -> dsmat -> dsmat -> unit
(** [plot3d] is just an alias of [surf] function. *)

val surf : ?h:handle -> ?contour:bool -> ?altitude:float -> ?azimuth:float -> dsmat -> dsmat -> dsmat -> unit

val mesh : ?h:handle -> ?contour:bool -> ?altitude:float -> ?azimuth:float -> dsmat -> dsmat -> dsmat -> unit

val contour : ?h:handle -> dsmat -> dsmat -> dsmat -> unit

val heatmap : ?h:handle -> dsmat -> dsmat -> dsmat -> unit


(** {6 Advanced statistical plot} *)


val probplot :
  ?h:handle ->
  ?marker:string -> ?color:int * int * int -> ?marker_size:float ->
  ?dist:(float -> float) -> ?noref:bool -> dsmat -> unit
(**
  [probplot dist x] creates a probability plot comparing the distribution of the data in [x] to the given distribution. The [dist] is set to standard normal distribution by default.

  Note that in our implementation of probplot, we choose a Matlab-like definition: for the i-th point on the figure, x-axis is the sorted input sample data x.(i), and y-axis is the inverseCDF (for different [dist]) of meadian [(i - 0.5)/n], where n is the length of input data,

  The y-axis is to be updated to corrsponding probability p = cdf(y) * 100%.

  The same definition also applies to normplot and wblplot.
*)

val normplot : ?h:handle -> ?marker:string -> ?color:int * int * int -> ?marker_size:float -> ?sigma:float -> dsmat -> unit
(**
  [normalplot sigma x] is probplot with normal distribution. User need to specify the [sigma] of distribution or the default value 1 will be used.
*)

val wblplot : ?h:handle -> ?marker:string -> ?color:int * int * int -> ?marker_size:float -> ?lambda:float -> ?k:float -> dsmat -> unit
(**
  [wblplot lambda k x] is probplot with weibull distribution. Currently user need to specify the weibull distribution parameters [lambda] and [k] explicitly. By default, (lambda, k) = (1., 1.). [wblplot] applies log-scale on x-axis.
*)

val qqplot : ?h:handle -> ?color:int * int * int -> ?marker_size:float ->   ?pd:(float -> float) -> ?x:dsmat -> dsmat -> unit
(**
  [qqplot y dist] displays a quantile-quantile plot of the quantiles of the sample data x versus the theoretical quantiles values from [dist], which by default is standard normal distribution. If the second argument [x] is a vector, the empirical CDF of it is used as the distribtion of x-axis data, otherwise the qqplot is similar to [probplot], showing the inverseCDF of meadian [(i - 0.5)/n] on x-axis.

  If input vectors are not of the same length, users are explected to input the
  longer one as x, and the shorter one y.
*)
