(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Plot: high-level plotting functions. *)

(** The input to a plot function is supposed to be a row-based matrix/vector.
  The functions in this module are built atop of Plplot library.
 *)


(** {6 Type definition} *)

type dsmat = Owl_dense_matrix.D.mat

type handle

type color = RED | GREEN | BLUE

type legend_position = North | South | West | East | NorthWest | NorthEast | SouthWest | SouthEast

type axis = X | Y | Z | XY | XZ | YZ | XYZ

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
  | ZLine       of axis
  | NoMagColor
  | Curtain
  | Faceted
  | Axis        of axis


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

val scatter : ?h:handle -> ?spec:spec list -> dsmat -> dsmat -> unit
(** [scatter x y] generates a scatter plot of [y] as a function of [x].

  Parameters: [RGB], [Marker], [MarkerSize].
 *)

val histogram : ?h:handle -> ?spec:spec list -> ?bin:int -> dsmat -> unit
(** [histogram x] generates a histogram of [x] with the number [bin].

  Parameters: [RGB].
 *)

val ecdf : ?h:handle -> ?spec:spec list -> dsmat -> unit
(** [ecdf x]

  Parameters: [RGB], [LineStyle], [LineWidth].
 *)

val stairs : ?h:handle -> ?spec:spec list -> dsmat -> dsmat -> unit
(** [stairs x y]

  Parameters: [RGB], [LineStyle], [LineWidth].
 *)

val stem : ?h:handle -> ?spec:spec list -> dsmat -> dsmat -> unit
(** [stem x] generates a stem plot of [y] as a function of [x].

  Parameters: [RGB], [Marker], [MarkerSize], [LineStyle], [LineWidth].
 *)

val autocorr : ?h:handle -> ?spec:spec list -> dsmat -> unit
(** [autocorr x] generates an autocorrelation plot of [x].

  Parameters: [RGB], [Marker], [MarkerSize], [LineStyle], [LineWidth].
 *)

val text : ?h:handle -> ?spec:spec list -> float -> float -> ?dx:float -> ?dy:float -> string -> unit
(** [text x y s] draws a text string at [(x,y)]. [dx] and [dy] indicate ...

  Parameters: [RGB].
 *)

val draw_line: ?h:handle -> ?spec:spec list -> float -> float -> float -> float -> unit
(** [draw_line x0 y0 x1 y0] draws a straight line from [(x0,y0)] to [(x1,y1)].

  Parameters: [RGB], [LineStyle], [LineWidth].
 *)

val draw_rect : ?h:handle -> ?spec:spec list -> float -> float -> float -> float -> unit
(** [draw_rect x0 y0 x1 y1] draws a rectangle with top-left point at [(x0,y0)]
  and bottom-right point at [(x1,y1)].

  Parameters: [RGB], [LineStyle], [FillPattern].
 *)

val draw_circle : ?h:handle -> ?spec:spec list -> float -> float -> float -> unit
(** [draw_circle x y r] draws a circle at point [(x,y)] of radius [r].

  Parameters: [RGB], [LineStyle], [LineWidth], [FillPattern].
 *)

val bar : ?h:handle -> ?spec:spec list -> dsmat -> unit
(** [bar x] draws a bar chart of [x].

  Parameters: [RGB], [LineStyle], [FillPattern].
 *)

val area : ?h:handle -> ?spec:spec list -> dsmat -> dsmat -> unit
(** [area x y] fills the area specified by [x] and [y].

  Parameters: [RGB], [LineStyle], [FillPattern].
 *)

val error_bar : ?h:handle -> ?spec:spec list -> dsmat -> dsmat -> dsmat -> unit
(** [error_bar x y] generates a line plot of [x] and [y] with error bars.

  Parameters: [RGB], [LineStyle], [LineWidth].
 *)

val boxplot : ?h:handle -> ?spec:spec list -> dsmat -> unit
(** [boxplot x] generates a box plot of [x].

  Parameters: [RGB].
 *)

val pie : ?h:handle -> ?spec:spec list -> dsmat -> unit
(** [pie x] generates a simple pie chart of [x].

  Parameters: [RGB], [Fill].
 *)

val loglog : ?h:handle -> ?spec:spec list -> ?x:dsmat -> dsmat -> unit
(** [loglog x y]  plots all [y] versus [x] pairs with log-log scale.
  [loglog y] plots data in [y] versus their indices. If [Axis X] or [Axis Y] is
  specified in [spec], plot logarithmic scales only for x-axis or y-axis
  respectively.

  Parameters: [RGB], [Marker], [MarkerSize], [LineStyle], [LineWidth], [Axis].
 *)

val semilogx : ?h:handle -> ?spec:spec list -> ?x:dsmat -> dsmat -> unit
(**
  [semilogx] is similar to [loglog]. Plot data as logarithmic scales for the
  x-axis.

  Parameters: [RGB], [Marker], [MarkerSize], [LineStyle], [LineWidth].
 *)

val semilogy : ?h:handle -> ?spec:spec list -> ?x:dsmat -> dsmat -> unit
(**
  [semilogy] is similar to [loglog]. Plot data as logarithmic scales for the
  y-axis.

  Parameters: [RGB], [Marker], [MarkerSize], [LineStyle], [LineWidth].
 *)


(** {6 3D plot functions} *)

val plot3d : ?h:handle -> ?spec:spec list -> dsmat -> dsmat -> dsmat -> unit
(** TODO: [plot3d] is just an alias of [surf] function.
 *)

val surf : ?h:handle -> ?spec:spec list -> dsmat -> dsmat -> dsmat -> unit
(** [surf x y z] generates a surface plot defined by [x], [y], and [z].

  Parameters: [Altitude], [Azimuth], [Contour], [NoMagColor], [Curtain].

  Please refer to [plotsurf3d] functions in the PLplot library for more
  information.
 *)

val mesh : ?h:handle -> ?spec:spec list -> dsmat -> dsmat -> dsmat -> unit
(** [mesh x y z] generates a mesh plot defined by [x], [y], and [z].

  Parameters: [RGB], [Altitude], [Azimuth], [Contour], [NoMagColor], [ZLine],
  [Curtain].

  Please refer to [plmesh] and [plmeshc] functions in the PLplot library for
  more information.
 *)

val contour : ?h:handle -> dsmat -> dsmat -> dsmat -> unit
(** [contour x y z] generates a contour plot defined by [x], [y], and [z].
 *)

val heatmap : ?h:handle -> dsmat -> dsmat -> dsmat -> unit
(** [heatmap x y z] generates a heatmap defined by [x], [y], and [z].
 *)


(** {6 Advanced statistical plot} *)


val probplot : ?h:handle -> ?spec:spec list -> ?dist:(float -> float) -> ?noref:bool -> dsmat -> unit
(**
  [probplot dist x] creates a probability plot comparing the distribution of
  the data in [x] to the given distribution. The [dist] is set to standard
  normal distribution by default.

  Note that in our implementation of probplot, we choose a Matlab-like
  definition: for the i-th point on the figure, x-axis is the sorted input
  sample data x.(i), and y-axis is the inverseCDF (for different [dist]) of
  meadian [(i - 0.5)/n], where n is the length of input data,

  The y-axis is to be updated to corrsponding probability [p = cdf(y) * 100%].

  The same definition also applies to normplot and wblplot.

  Parameters: [RGB], [Marker], [MarkerSize].
 *)

val normplot : ?h:handle -> ?spec:spec list -> ?sigma:float -> dsmat -> unit
(**
  [normalplot sigma x] is probplot with normal distribution. User need to
  specify the [sigma] of distribution or the default value 1 will be used.

  Parameters: [RGB], [Marker], [MarkerSize].
 *)

val wblplot : ?h:handle -> ?spec:spec list -> ?lambda:float -> ?k:float -> dsmat -> unit
(**
  [wblplot lambda k x] is probplot with weibull distribution. Currently user
  need to specify the weibull distribution parameters [lambda] and [k]
  explicitly. By default, (lambda, k) = (1., 1.). [wblplot] applies log-scale
  on x-axis.

  Parameters: [RGB], [Marker], [MarkerSize].
 *)

val qqplot : ?h:handle -> ?spec:spec list -> ?pd:(float -> float) -> ?x:dsmat -> dsmat -> unit
(**
  [qqplot y dist] displays a quantile-quantile plot of the quantiles of the
  sample data x versus the theoretical quantiles values from [dist], which by
  default is standard normal distribution. If the second argument [x] is a
  vector, the empirical CDF of it is used as the distribtion of x-axis data,
  otherwise the qqplot is similar to [probplot], showing the inverseCDF of
  meadian \[(i - 0.5)/n\] on x-axis.

  If input vectors are not of the same length, users are explected to input the
  longer one as x, and the shorter one y.

  Parameters: [RGB], [Marker], [MarkerSize].
 *)

val image : ?h:handle -> dsmat -> unit
(**
  [image x] display a m * n matrix [x] xas image. Each element in the matrix is of range 0 ~ 255.
 *)
