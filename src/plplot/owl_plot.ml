(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(** Plot Module *)

(* types in plot module *)

type dsmat = Owl_dense_matrix.D.mat

type color =
  | RED
  | GREEN
  | BLUE

type legend_typ =
  | LINE
  | SCATTER
  | BOX

type legend_position =
  | North
  | South
  | West
  | East
  | NorthWest
  | NorthEast
  | SouthWest
  | SouthEast

type legend_item =
  { mutable plot_type : legend_typ
  ; mutable line_style : int
  ; mutable line_color : int * int * int
  ; mutable marker : string
  ; mutable marker_color : int * int * int
  ; mutable fill_pattern : int
  ; mutable fill_color : int * int * int
  }

type page =
  { mutable title : string
  ; mutable fgcolor : int * int * int
  ; mutable fontsize : float
  ; mutable is_3d : bool
  ; mutable no_axes : bool
  ; (* control axis labels *)
    mutable xlabel : string
  ; mutable ylabel : string
  ; mutable zlabel : string
  ; (* control axis ranges *)
    mutable xrange : float * float
  ; mutable yrange : float * float
  ; mutable zrange : float * float
  ; mutable auto_xrange : bool
  ; mutable auto_yrange : bool
  ; mutable auto_zrange : bool
  ; (* control tick labels *)
    mutable xticklabels : (float * string) list
  ; mutable yticklabels : (float * string) list
  ; mutable zticklabels : (float * string) list
  ; (* control axis log scale *)
    mutable xlogscale : bool
  ; mutable ylogscale : bool
  ; (* control grids *)
    mutable xgrid : bool
  ; mutable ygrid : bool
  ; mutable zgrid : bool
  ; (* viewing perspective for 3D plots
     * http://plplot.sourceforge.net/docbook-manual/plplot-html-5.12.0/plw3d.html *)
    mutable altitude : float
  ; mutable azimuth : float
  ; (* control legend *)
    mutable legend : bool
  ; mutable legend_position : legend_position
  ; mutable legend_items : legend_item array
  ; mutable legend_names : string array
  ; (* cache the plot operations *)
    mutable plots : (unit -> unit) array
  }

type handle =
  { mutable holdon : bool
  ; mutable output : string
  ; mutable bgcolor : int * int * int
  ; mutable pensize : float
  ; mutable page_size : int * int
  ; (* control the sub plots *)
    mutable shape : int * int
  ; mutable pages : page array
  ; mutable current_page : int
  }

type axis =
  | X
  | Y
  | Z
  | XY
  | XZ
  | YZ
  | XYZ

(* Specification to configure a plot *)

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

let _get_rgb l default_val =
  let l =
    l
    |> List.filter (function
           | RGB _ -> true
           | _     -> false)
    |> List.map (function
           | RGB (r, g, b) -> r, g, b
           | _             -> default_val)
  in
  let k = List.length l in
  if k = 0 then default_val else List.nth l (k - 1)


let _get_line_style l default_val =
  let l =
    l
    |> List.filter (function
           | LineStyle _ -> true
           | _           -> false)
    |> List.map (function
           | LineStyle x -> x
           | _           -> default_val)
  in
  let k = List.length l in
  if k = 0 then default_val else List.nth l (k - 1)


let _get_line_width l default_val =
  let l =
    l
    |> List.filter (function
           | LineWidth _ -> true
           | _           -> false)
    |> List.map (function
           | LineWidth x -> x
           | _           -> default_val)
  in
  let k = List.length l in
  if k = 0 then default_val else List.nth l (k - 1)


let _get_marker l default_val =
  let l =
    l
    |> List.filter (function
           | Marker _ -> true
           | _        -> false)
    |> List.map (function
           | Marker x -> x
           | _        -> default_val)
  in
  let k = List.length l in
  if k = 0 then default_val else List.nth l (k - 1)


let _get_marker_size l default_val =
  let l =
    l
    |> List.filter (function
           | MarkerSize _ -> true
           | _            -> false)
    |> List.map (function
           | MarkerSize x -> x
           | _            -> default_val)
  in
  let k = List.length l in
  if k = 0 then default_val else List.nth l (k - 1)


let _get_fill l default_val =
  let l =
    l
    |> List.filter (function
           | Fill -> true
           | _    -> false)
    |> List.map (function
           | Fill -> true
           | _    -> default_val)
  in
  let k = List.length l in
  if k = 0 then default_val else List.nth l (k - 1)


let _get_fill_pattern l default_val =
  let l =
    l
    |> List.filter (function
           | FillPattern _ -> true
           | _             -> false)
    |> List.map (function
           | FillPattern x -> x
           | _             -> default_val)
  in
  let k = List.length l in
  if k = 0 then default_val else List.nth l (k - 1)


let _get_contour l default_val =
  let l =
    l
    |> List.filter (function
           | Contour -> true
           | _       -> false)
    |> List.map (function
           | Contour -> true
           | _       -> default_val)
  in
  let k = List.length l in
  if k = 0 then default_val else List.nth l (k - 1)


let _get_altitude l default_val =
  let l =
    l
    |> List.filter (function
           | Altitude _ -> true
           | _          -> false)
    |> List.map (function
           | Altitude x -> x
           | _          -> default_val)
  in
  let k = List.length l in
  if k = 0 then default_val else List.nth l (k - 1)


let _get_azimuth l default_val =
  let l =
    l
    |> List.filter (function
           | Azimuth _ -> true
           | _         -> false)
    |> List.map (function
           | Azimuth x -> x
           | _         -> default_val)
  in
  let k = List.length l in
  if k = 0 then default_val else List.nth l (k - 1)


let _get_zline l default_val =
  let l =
    l
    |> List.filter (function
           | ZLine _ -> true
           | _       -> false)
    |> List.map (function
           | ZLine X  -> Plplot.PL_DRAW_LINEX
           | ZLine Y  -> Plplot.PL_DRAW_LINEY
           | ZLine XY -> Plplot.PL_DRAW_LINEXY
           | _        -> default_val)
  in
  let k = List.length l in
  if k = 0 then default_val else List.nth l (k - 1)


let _get_mag_color l default_val =
  let l =
    l
    |> List.filter (function
           | NoMagColor -> true
           | _          -> false)
    |> List.map (function
           | NoMagColor -> false
           | _          -> true)
  in
  let k = List.length l in
  if k = 0 then default_val else List.nth l (k - 1)


let _get_curtain l default_val =
  let l =
    l
    |> List.filter (function
           | Curtain -> true
           | _       -> false)
    |> List.map (function
           | Curtain -> true
           | _       -> false)
  in
  let k = List.length l in
  if k = 0 then default_val else List.nth l (k - 1)


let _get_faceted l default_val =
  let l =
    l
    |> List.filter (function
           | Faceted -> true
           | _       -> false)
    |> List.map (function
           | Faceted -> true
           | _       -> false)
  in
  let k = List.length l in
  if k = 0 then default_val else List.nth l (k - 1)


let _get_axis l default_val =
  let l =
    l
    |> List.filter (function
           | Axis _ -> true
           | _      -> false)
    |> List.map (function
           | Axis x -> x
           | _      -> default_val)
  in
  let k = List.length l in
  if k = 0 then default_val else List.nth l (k - 1)


(* module functions to simplify plotting *)

let _create_page () =
  { title = ""
  ; fgcolor = 0, 0, 0
  ; fontsize = -1.
  ; is_3d = false
  ; no_axes = false
  ; xlabel = "x"
  ; ylabel = "y"
  ; zlabel = "z"
  ; xrange = infinity, neg_infinity
  ; yrange = infinity, neg_infinity
  ; zrange = infinity, neg_infinity
  ; auto_xrange = true
  ; auto_yrange = true
  ; auto_zrange = true
  ; xticklabels = []
  ; yticklabels = []
  ; zticklabels = []
  ; xlogscale = false
  ; ylogscale = false
  ; xgrid = false
  ; ygrid = false
  ; zgrid = false
  ; altitude = 33.
  ; azimuth = 45.
  ; legend = false
  ; legend_position = NorthEast
  ; legend_items = [||]
  ; legend_names = [||]
  ; plots = [||]
  }


let _create_handle () =
  { holdon = true
  ; output = ""
  ; bgcolor = 255, 255, 255
  ; pensize = 0.
  ; page_size = 0, 0
  ; shape = 1, 1
  ; current_page = 0
  ; pages = [| _create_page () |]
  }


let create ?(m = 1) ?(n = 1) s =
  let pages = Array.make (m * n) None |> Array.map (fun _ -> _create_page ()) in
  let h = _create_handle () in
  h.shape <- m, n;
  h.pages <- pages;
  h.output <- s;
  h


let _default_handle =
  let h = _create_handle () in
  h.holdon <- false;
  h


let _supported_device =
  [ "aqt"
  ; "xwin"
  ; "pdf"
  ; "ps"
  ; "psc"
  ; "png"
  ; "svg"
  ; "xfig"
  ; "psttf"
  ; "psttc"
  ; "xcairo"
  ; "pdfcairo"
  ; "epscairo"
  ; "pscairo"
  ; "svgcairo"
  ; "pngcairo"
  ; "memcairo"
  ; "extcairo"
  ]


let _set_device h =
  try
    let x = Owl_utils.get_suffix h.output in
    Plplot.plsdev x;
    if String.length h.output = 0 then () else Plplot.plsfnam h.output
  with
  | _exn -> ()


let _add_legend_item
    p
    plot_type
    line_style
    line_color
    marker
    marker_color
    fill_pattern
    fill_color
  =
  let item =
    { plot_type; line_style; line_color; marker; marker_color; fill_pattern; fill_color }
  in
  p.legend_items <- Array.append p.legend_items [| item |]


let _plplot_position pos =
  let open Plplot in
  match pos with
  | North     -> [ PL_POSITION_TOP ]
  | South     -> [ PL_POSITION_BOTTOM ]
  | West      -> [ PL_POSITION_LEFT ]
  | East      -> [ PL_POSITION_RIGHT ]
  | NorthWest -> [ PL_POSITION_TOP; PL_POSITION_LEFT ]
  | NorthEast -> [ PL_POSITION_TOP; PL_POSITION_RIGHT ]
  | SouthWest -> [ PL_POSITION_BOTTOM; PL_POSITION_LEFT ]
  | SouthEast -> [ PL_POSITION_BOTTOM; PL_POSITION_RIGHT ]


let _draw_legend p =
  let open Plplot in
  let _ = plscmap0n 64 in
  let cbase = 16 in
  let opt = [ PL_LEGEND_BOUNDING_BOX ] in
  let position = _plplot_position p.legend_position @ [ PL_POSITION_INSIDE ] in
  let opt_array =
    Array.map
      (fun item ->
        match item.plot_type with
        | LINE    -> [ PL_LEGEND_LINE; PL_LEGEND_SYMBOL ]
        | SCATTER -> [ PL_LEGEND_SYMBOL ]
        | BOX     -> [ PL_LEGEND_COLOR_BOX ])
      p.legend_items
  in
  let text_colors = Array.map (fun _ -> 1) p.legend_items in
  let text = Array.mapi (fun i _ -> p.legend_names.(i)) p.legend_items in
  let line_colors =
    Array.mapi
      (fun i x ->
        let r, g, b = x.line_color in
        plscol0 (i + cbase) r g b;
        i + cbase)
      p.legend_items
  in
  let line_styles = Array.map (fun x -> x.line_style) p.legend_items in
  let line_widths = Array.map (fun _ -> 1.) p.legend_items in
  let marker_colors = line_colors in
  let marker_scales = Array.map (fun _ -> 1.) p.legend_items in
  let marker_nums = Array.map (fun _ -> 3) p.legend_items in
  let markers = Array.map (fun x -> x.marker) p.legend_items in
  let box_colors = line_colors in
  let box_patterns = Array.map (fun x -> x.fill_pattern) p.legend_items in
  let box_scales = Array.map (fun _x -> 0.8) p.legend_items in
  let box_linewidths = Array.map (fun _x -> 1.) p.legend_items in
  let _ =
    pllegend
      opt
      position
      0.05
      0.05
      0.1
      15
      1
      1
      0
      0
      opt_array
      1.0
      1.0
      2.0
      1.0
      text_colors
      text
      box_colors
      box_patterns
      box_scales
      box_linewidths
      line_colors
      line_styles
      line_widths
      marker_colors
      marker_scales
      marker_nums
      markers
  in
  ()


let _calculate_paper_size m n =
  let max_w, max_h = 900., 900. in
  let r0 = 4. /. 3. in
  let cur_w, cur_h = r0 *. float_of_int n, float_of_int m in
  let r1 = max_w /. max_h in
  let r2 = cur_w /. cur_h in
  let w, h =
    match r1 /. r2 < 1. with
    | true  -> max_w, max_w /. r2
    | false -> max_h *. r2, max_h
  in
  int_of_float w, int_of_float h


(* calculate the axis config based on a page config *)
let _config_2d_axis p =
  let base = 0 in
  if p.no_axes
  then -1
  else (
    let residual =
      if (p.xlogscale, p.ylogscale) = (true, false)
      then 10
      else if (p.xlogscale, p.ylogscale) = (false, true)
      then 20
      else if (p.xlogscale, p.ylogscale) = (true, true)
      then 30
      else if p.xticklabels |> List.length > 0 || p.yticklabels |> List.length > 0
      then 70
      else 0
    in
    base + residual)


let _initialise h =
  let open Plplot in
  (* configure before init *)
  _set_device h;
  let r, g, b = h.bgcolor in
  plscolbg r g b;
  (* init the plot *)
  let m, n = h.shape in
  if not (h.shape = (1, 1)) then plssub n m;
  let x, y =
    match h.page_size = (0, 0) with
    | true  -> _calculate_paper_size m n
    | false -> h.page_size
  in
  plspage 0. 0. x y 0 0;
  plinit ();
  (* configure after init *)
  plwidth h.pensize


(* callback function of drawing customised tick labels *)
let _draw_ticklabels p axis value =
  let open Plplot in
  let l =
    match axis with
    | PL_X_AXIS -> p.xticklabels
    | PL_Y_AXIS -> p.yticklabels
    | PL_Z_AXIS -> p.zticklabels
  in
  try List.assoc value l with
  | _exn -> Printf.sprintf "%g" value


let _prepare_page p =
  let open Plplot in
  (* customise tick labels if necessary *)
  plslabelfunc (_draw_ticklabels p);
  (* configure an individual page *)
  let r, g, b = p.fgcolor in
  plscol0 2 r g b;
  plcol0 2;
  if p.fontsize > 0. then plschr p.fontsize 1.0;
  let xmin, xmax = p.xrange in
  let ymin, ymax = p.yrange in
  let zmin, zmax = p.zrange in
  let alt, az = p.altitude, p.azimuth in
  if not p.is_3d
  then (* prepare a 2D plot *)
    plenv xmin xmax ymin ymax 0 (_config_2d_axis p)
  else (
    (* prepare a 3D plot *)
    pladv 0;
    plvpor 0.0 1.0 0.0 0.9;
    plwind (-1.0) 1.0 (-1.0) 1.5;
    plw3d 1.0 1.0 1.2 xmin xmax ymin ymax zmin zmax alt az;
    plbox3 "bntu" p.xlabel 0.0 0 "bntu" p.ylabel 0.0 0 "bcdfntu" p.zlabel 0.0 4);
  (* set x-label, y-label, and title *)
  pllab p.xlabel p.ylabel p.title;
  (* reset foreground colour to index 1 *)
  plcol0 1;
  if p.legend then _draw_legend p


let _finalise () =
  (* play safe, reset pages in default_handle *)
  _default_handle.pages <- [| _create_page () |];
  Plplot.plend ()


let output h =
  h.holdon <- false;
  _initialise h;
  Array.iteri
    (fun i p ->
      if i > 0 then Plplot.pladv i;
      _prepare_page p;
      Array.iter (fun f -> f ()) p.plots)
    h.pages;
  _finalise ()


let set_output h s =
  let x = Owl_utils.get_suffix s in
  match List.mem x _supported_device with
  | true  -> h.output <- s
  | false -> Owl_log.error "unsupported file type."


let get_output h = h.output

let set_title h s = h.pages.(h.current_page).title <- s

let set_xlabel h s = h.pages.(h.current_page).xlabel <- s

let set_ylabel h s = h.pages.(h.current_page).ylabel <- s

let set_zlabel h s = h.pages.(h.current_page).zlabel <- s

let set_xrange h a b =
  h.pages.(h.current_page).auto_xrange <- false;
  h.pages.(h.current_page).xrange <- a, b


let set_yrange h a b =
  h.pages.(h.current_page).auto_yrange <- false;
  h.pages.(h.current_page).yrange <- a, b


let set_zrange h a b =
  h.pages.(h.current_page).auto_zrange <- false;
  h.pages.(h.current_page).zrange <- a, b


let set_xticklabels h l = h.pages.(h.current_page).xticklabels <- l

let set_yticklabels h l = h.pages.(h.current_page).yticklabels <- l

let set_zticklabels h l = h.pages.(h.current_page).zticklabels <- l

let set_foreground_color h r g b = h.pages.(h.current_page).fgcolor <- r, g, b

let set_background_color h r g b = h.bgcolor <- r, g, b

let set_font_size h x = h.pages.(h.current_page).fontsize <- x

let set_pen_size h x = h.pensize <- x

let set_page_size h x y = h.page_size <- x, y

let legend_on h ?(position = NorthEast) s =
  h.pages.(h.current_page).legend <- true;
  h.pages.(h.current_page).legend_position <- position;
  h.pages.(h.current_page).legend_names <- s


let legend_off h = h.pages.(h.current_page).legend <- false

(* TODO *)
let rgb = None [@@warning "-32"]

(*FIXME: plptex3 to write text inside the viewport of a 3D plot*)
let text ?(h = _default_handle) ?(spec = []) x y ?(dx = 0.) ?(dy = 0.) s =
  let open Plplot in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = _get_rgb spec p.fgcolor in
  let r, g, b = color in
  (* drawing function *)
  let f () =
    (*save original color index*)
    let r', g', b' = plgcol0 1 in
    plscol0 1 r g b;
    plcol0 1;
    plptex x y dx dy 0. s;
    (* restore original settings *)
    plscol0 1 r' g' b';
    plcol0 1
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  if not h.holdon then output h


let _thinning x =
  let l = float_of_int (Array.length x) in
  let n = if l < 16. then l else 16. in
  let c = float_of_int (Array.length x) /. n in
  Array.init (int_of_float n) (fun i -> x.(int_of_float (float_of_int i *. c)))


let _union_range p r x =
  let a, b = r in
  let m, n = Owl_stats.minmax x in
  let c = if a < m then a else m in
  let d = if b > n then b else n in
  let e = (d -. c) *. p in
  c -. e, d +. e


let _adjust_range ?(margin = 0.) h d axis =
  let p = h.pages.(h.current_page) in
  match axis with
  | X -> if p.auto_xrange then p.xrange <- _union_range margin p.xrange d
  | Y -> if p.auto_yrange then p.yrange <- _union_range margin p.yrange d
  | Z -> if p.auto_zrange then p.zrange <- _union_range margin p.zrange d
  | _ -> failwith "owl_plot:_adjust_range"


let plot ?(h = _default_handle) ?(spec = []) x y =
  let open Plplot in
  let x = Owl_dense_matrix.D.to_array x in
  let y = Owl_dense_matrix.D.to_array y in
  _adjust_range h x X;
  _adjust_range h y Y;
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = _get_rgb spec p.fgcolor in
  let r, g, b = color in
  let marker = _get_marker spec "" in
  let marker_size = _get_marker_size spec 4. in
  let line_style = _get_line_style spec 1 in
  let line_width = _get_line_width spec (-1.) in
  let old_pensize = h.pensize in
  (* drawing function *)
  let f () =
    let r', g', b' = plgcol0 1 in
    plscol0 1 r g b;
    plcol0 1;
    if line_width > -1. then plwidth line_width;
    let c' = plgchr () |> fst in
    plschr marker_size 1.;
    if line_style > 0 && line_style < 9 then pllsty line_style;
    plline x y;
    if marker <> ""
    then (
      let x', y' = _thinning x, _thinning y in
      plstring x' y' marker);
    (* restore original settings *)
    plschr c' 1.;
    plwidth old_pensize;
    pllsty 1;
    plscol0 1 r' g' b';
    plcol0 1
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  (* add legend item to page *)
  _add_legend_item p LINE line_style color marker color 0 color;
  if not h.holdon then output h


let plot_fun ?(h = _default_handle) ?(spec = []) f a b =
  let x = Owl_dense_matrix.D.linspace a b 100 in
  let y = Owl_dense_matrix.D.map f x in
  plot ~h ~spec x y


let scatter ?(h = _default_handle) ?(spec = []) x y =
  let open Plplot in
  let x = Owl_dense_matrix.D.to_array x in
  let y = Owl_dense_matrix.D.to_array y in
  _adjust_range h x X;
  _adjust_range h y Y;
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = _get_rgb spec p.fgcolor in
  let r, g, b = color in
  let marker = _get_marker spec "•" in
  let marker_size = _get_marker_size spec 4. in
  (* drawing function *)
  let f () =
    let r', g', b' = plgcol0 1 in
    plscol0 1 r g b;
    plcol0 1;
    let c' = plgchr () |> fst in
    plschr marker_size 1.;
    plstring x y marker;
    (* restore original settings *)
    plschr c' 1.;
    plscol0 1 r' g' b';
    plcol0 1
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  (* add legend item to page *)
  _add_legend_item p SCATTER 0 color marker color 0 color;
  if not h.holdon then output h


let histogram ?(h = _default_handle) ?(spec = []) ?(bin = 10) x =
  let open Plplot in
  let x = Owl_dense_matrix.D.to_array x in
  _adjust_range h x X;
  let xmin, xmax = Owl_stats.minmax x in
  let ymin, ymax =
    0., Owl_stats.((histogram (`N bin) x).counts |> Array.map float_of_int |> max) *. 1.1
  in
  _adjust_range h [| xmin; xmax |] X;
  _adjust_range h [| ymin; ymax |] Y;
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = _get_rgb spec p.fgcolor in
  let r, g, b = color in
  (* drawing function *)
  let f () =
    let r', g', b' = plgcol0 1 in
    let _ =
      plscol0 1 r g b;
      plcol0 1
    in
    plhist x xmin xmax bin [ PL_HIST_DEFAULT; PL_HIST_NOSCALING; PL_HIST_NOEXPAND ];
    (* restore original settings *)
    plscol0 1 r' g' b';
    plcol0 1
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  (* add legend item to page *)
  _add_legend_item p BOX 1 color "" color 0 color;
  if not h.holdon then output h


let subplot h i j =
  let _, n = h.shape in
  h.current_page <- (n * i) + j


let stem ?(h = _default_handle) ?(spec = []) x y =
  let open Plplot in
  let x = Owl_dense_matrix.D.to_array x in
  let y = Owl_dense_matrix.D.to_array y in
  _adjust_range h x X;
  _adjust_range h y Y;
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = _get_rgb spec p.fgcolor in
  let r, g, b = color in
  let marker = _get_marker spec "#[0x2299]" in
  let marker_size = _get_marker_size spec 4. in
  let line_style = _get_line_style spec 2 in
  let line_width = _get_line_width spec (-1.) in
  let old_pensize = h.pensize in
  (* drawing function *)
  let f () =
    let r', g', b' = plgcol0 1 in
    plscol0 1 r g b;
    plcol0 1;
    if line_width > -1. then plwidth line_width;
    let c' = plgchr () |> fst in
    plschr marker_size 1.;
    if line_style > 0 && line_style < 9
    then (
      pllsty line_style;
      Owl_utils.Array.iter2 (fun x' y' -> pljoin x' 0. x' y') x y);
    if not (marker = "") then plstring x y marker;
    (* restore original settings *)
    plschr c' 1.;
    plwidth old_pensize;
    pllsty 1;
    plscol0 1 r' g' b';
    plcol0 1
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  (* add legend item to page *)
  _add_legend_item p LINE line_style color marker color 0 color;
  if not h.holdon then output h


let autocorr ?(h = _default_handle) ?(spec = []) x =
  let z = Owl_dense_matrix.D.to_array x in
  let x' = Array.init (Array.length z) (fun i -> float_of_int i) in
  let y' = Array.mapi (fun i _ -> Owl_stats.autocorrelation ~lag:i z) x' in
  let x' = Owl_dense_matrix.D.of_arrays [| x' |] in
  let y' = Owl_dense_matrix.D.of_arrays [| y' |] in
  set_xlabel h "Lag";
  set_ylabel h "Autocorrelation";
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let r, g, b = _get_rgb spec p.fgcolor in
  let color = RGB (r, g, b) in
  let marker = Marker (_get_marker spec "•") in
  let marker_size = MarkerSize (_get_marker_size spec 4.) in
  let line_style = LineStyle (_get_line_style spec 1) in
  let line_width = LineWidth (_get_line_width spec (-1.)) in
  let spec = [ color; marker; marker_size; line_style; line_width ] in
  (* drawing function *)
  stem ~h ~spec x' y'


let draw_line ?(h = _default_handle) ?(spec = []) x0 y0 x1 y1 =
  let open Plplot in
  let x = [| x0; x1 |] in
  let y = [| y0; y1 |] in
  _adjust_range h x X;
  _adjust_range h y Y;
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = _get_rgb spec p.fgcolor in
  let r, g, b = color in
  let line_style = _get_line_style spec 1 in
  let line_width = _get_line_width spec (-1.) in
  let old_pensize = h.pensize in
  (* drawing function *)
  let f () =
    let r', g', b' = plgcol0 1 in
    plscol0 1 r g b;
    plcol0 1;
    if line_width > -1. then plwidth line_width;
    if line_style > 0 && line_style < 9
    then (
      pllsty line_style;
      pljoin x0 y0 x1 y1);
    (* restore original settings *)
    plwidth old_pensize;
    pllsty 1;
    plscol0 1 r' g' b';
    plcol0 1
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  if not h.holdon then output h


(* TODO *)
let plot_multi = None [@@warning "-32"]

let _draw_error_bar ?(w = 0.) x y e =
  let open Plplot in
  let w = w /. 2. in
  (* draw vertical line *)
  let x' = [| x; x |] in
  let y' = [| y -. e; y +. e |] in
  plline x' y';
  (* draw upper bar *)
  let x' = [| x -. w; x +. w |] in
  let y' = [| y +. e; y +. e |] in
  plline x' y';
  (* draw lower line *)
  let x' = [| x -. w; x +. w |] in
  let y' = [| y -. e; y -. e |] in
  plline x' y'


let error_bar ?(h = _default_handle) ?(spec = []) x y e =
  let open Plplot in
  let ymin = Owl_dense_matrix.D.(min' (y - e)) in
  let ymax = Owl_dense_matrix.D.(max' (y + e)) in
  let x = Owl_dense_matrix.D.to_array x in
  let y = Owl_dense_matrix.D.to_array y in
  let e = Owl_dense_matrix.D.to_array e in
  _adjust_range h x X;
  _adjust_range h [| ymin; ymax |] Y;
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = _get_rgb spec p.fgcolor in
  let r, g, b = color in
  let line_style = _get_line_style spec 1 in
  let line_width = _get_line_width spec (-1.) in
  let old_pensize = h.pensize in
  let w =
    let a, b = Owl_stats.minmax x in
    (a -. b) *. 0.02
  in
  (* drawing function *)
  let f () =
    let r', g', b' = plgcol0 1 in
    plscol0 1 r g b;
    plcol0 1;
    if line_width > -1. then plwidth line_width;
    pllsty line_style;
    Owl_utils.Array.iter3 (fun x0 y0 e0 -> _draw_error_bar ~w x0 y0 e0) x y e;
    (* restore original settings *)
    plwidth old_pensize;
    pllsty 1;
    plscol0 1 r' g' b';
    plcol0 1
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  if not h.holdon then output h


let _draw_whiskers_box w x y =
  let open Plplot in
  let ymed, y1st, y3rd = Owl_stats.(median y, first_quartile y, third_quartile y) in
  let w = w /. 2. in
  let x' = [| x -. w; x -. w; x +. w; x +. w; x -. w |] in
  let y' = [| y1st; y3rd; y3rd; y1st; y1st |] in
  pllsty 1;
  plline x' y';
  let x' = [| x -. w; x +. w |] in
  let y' = [| ymed; ymed |] in
  pllsty 1;
  plline x' y';
  let ymin, ymax = Owl_stats.minmax y in
  let x' = [| x; x |] in
  let y' = [| ymin; y1st |] in
  pllsty 1;
  plline x' y';
  let x' = [| x; x |] in
  let y' = [| y3rd; ymax |] in
  pllsty 1;
  plline x' y'


let boxplot ?(h = _default_handle) ?(spec = []) y =
  let open Plplot in
  let m, _ = Owl_dense_matrix.D.shape y in
  let x = Array.init m (fun i -> float_of_int i +. 1.) in
  let xmin, xmax = Owl_stats.minmax x in
  let w = 0.4 in
  let y0 = Owl_dense_matrix.D.to_array y in
  let y1 = Owl_dense_matrix.D.to_arrays y in
  _adjust_range h [| xmin -. w; xmax +. w |] X;
  _adjust_range h ~margin:0.1 y0 Y;
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = _get_rgb spec p.fgcolor in
  let r, g, b = color in
  (* drawing function *)
  let f () =
    let r', g', b' = plgcol0 1 in
    plscol0 1 r g b;
    plcol0 1;
    Owl_utils.Array.iter2 (fun x' y' -> _draw_whiskers_box w x' y') x y1;
    (* restore original settings *)
    plscol0 1 r' g' b';
    plcol0 1;
    pllsty 1
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  if not h.holdon then output h


let _draw_bar w x0 y0 =
  let open Plplot in
  let x = [| x0 -. w; x0 -. w; x0 +. w; x0 +. w |] in
  let y = [| 0.; y0; y0; 0. |] in
  plfill x y;
  pllsty 1;
  plline x y


let draw_rect ?(h = _default_handle) ?(spec = []) x0 y0 x1 y1 =
  let open Plplot in
  let x = [| x0; x0; x1; x1 |] in
  let y = [| y1; y0; y0; y1 |] in
  _adjust_range h x X;
  _adjust_range h y Y;
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = _get_rgb spec p.fgcolor in
  let r, g, b = color in
  let line_style = _get_line_style spec 1 in
  let fill_pattern = _get_fill_pattern spec 0 in
  (* drawing function *)
  let f () =
    let r', g', b' = plgcol0 1 in
    plscol0 1 r g b;
    plcol0 1;
    pllsty line_style;
    plpsty fill_pattern;
    plfill x y;
    (* restore original settings *)
    plscol0 1 r' g' b';
    plcol0 1;
    pllsty 1
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  if not h.holdon then output h


let bar ?(h = _default_handle) ?(spec = []) y =
  let open Plplot in
  let w = 0.4 in
  let y = Owl_dense_matrix.D.to_array y in
  let x = Array.mapi (fun i _ -> float_of_int i +. 1.) y in
  let xmin, xmax = Owl_stats.minmax x in
  _adjust_range h [| xmin -. w; xmax +. w |] X;
  _adjust_range h y Y;
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = _get_rgb spec p.fgcolor in
  let r, g, b = color in
  let line_style = _get_line_style spec 1 in
  let fill_pattern = _get_fill_pattern spec 0 in
  (* drawing function *)
  let f () =
    let r', g', b' = plgcol0 1 in
    plscol0 1 r g b;
    plcol0 1;
    pllsty line_style;
    plpsty fill_pattern;
    Owl_utils.Array.iter2 (fun x0 y0 -> _draw_bar w x0 y0) x y;
    (* restore original settings *)
    plscol0 1 r' g' b';
    plcol0 1;
    pllsty 1
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  (* add legend item to page *)
  _add_legend_item p BOX line_style color "" color fill_pattern color;
  if not h.holdon then output h


let area ?(h = _default_handle) ?(spec = []) x y =
  let open Plplot in
  let x = Owl_dense_matrix.D.to_array x in
  let y = Owl_dense_matrix.D.to_array y in
  let xmin, xmax = Owl_stats.minmax x in
  let x = Array.(append (append [| xmin |] x) [| xmax |]) in
  let y = Array.(append (append [| 0. |] y) [| 0. |]) in
  _adjust_range h x X;
  _adjust_range h y Y;
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = _get_rgb spec p.fgcolor in
  let r, g, b = color in
  let line_style = _get_line_style spec 1 in
  let fill_pattern = _get_fill_pattern spec 0 in
  (* drawing function *)
  let f () =
    let r', g', b' = plgcol0 1 in
    plscol0 1 r g b;
    plcol0 1;
    pllsty line_style;
    plline x y;
    plpsty fill_pattern;
    plfill x y;
    (* restore original settings *)
    plscol0 1 r' g' b';
    plcol0 1;
    pllsty 1
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  (* add legend item to page *)
  _add_legend_item p BOX line_style color "" color fill_pattern color;
  if not h.holdon then output h


let draw_polygon ?(h = _default_handle) ?(spec = []) x y =
  let open Plplot in
  let x = Owl_dense_matrix.D.to_array x in
  let y = Owl_dense_matrix.D.to_array y in
  _adjust_range h x X;
  _adjust_range h y Y;
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = _get_rgb spec p.fgcolor in
  let r, g, b = color in
  let line_style = _get_line_style spec 1 in
  let fill_pattern = _get_fill_pattern spec 0 in
  (* drawing function *)
  let f () =
    let r', g', b' = plgcol0 1 in
    plscol0 1 r g b;
    plcol0 1;
    pllsty line_style;
    plline x y;
    plpsty fill_pattern;
    plfill x y;
    (* restore original settings *)
    plscol0 1 r' g' b';
    plcol0 1;
    pllsty 1
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  (* add legend item to page *)
  _add_legend_item p BOX line_style color "" color fill_pattern color;
  if not h.holdon then output h


let _ecdf_interleave x i =
  let m = Array.length x in
  let n = 2 * m in
  let y = Array.make n 0. in
  Array.iteri
    (fun j z ->
      let k = (2 * j) + i in
      if k < n then y.(k) <- z;
      if k < n - 1 then y.(k + 1) <- z)
    x;
  y


let ecdf ?(h = _default_handle) ?(spec = []) x =
  let x0 = Owl_dense_matrix.D.to_array x in
  let x, y = Owl_stats.ecdf x0 in
  let x = _ecdf_interleave x 0 in
  let y = _ecdf_interleave y 1 in
  let n = Array.length x in
  let x = Owl_dense_matrix.D.of_array x n 1 in
  let y = Owl_dense_matrix.D.of_array y n 1 in
  plot ~h ~spec x y


let stairs ?(h = _default_handle) ?(spec = []) x y =
  let x = Owl_dense_matrix.D.to_array x in
  let y = Owl_dense_matrix.D.to_array y in
  let x = _ecdf_interleave x 0 in
  let a = y.(0) in
  let y = _ecdf_interleave y 1 in
  let _ = y.(0) <- a in
  let n = Array.length x in
  let x = Owl_dense_matrix.D.of_array x n 1 in
  let y = Owl_dense_matrix.D.of_array y n 1 in
  plot ~h ~spec x y


let draw_circle ?(h = _default_handle) ?(spec = []) x y rr =
  let open Plplot in
  let n = 1000 in
  let theta = 2. *. Owl_const.pi /. float_of_int n in
  let x' =
    Array.init (n + 1) (fun i -> x +. (Owl_maths.(sin (float_of_int i *. theta)) *. rr))
  in
  let y' =
    Array.init (n + 1) (fun i -> y +. (Owl_maths.(cos (float_of_int i *. theta)) *. rr))
  in
  _adjust_range h ~margin:0.05 x' X;
  _adjust_range h ~margin:0.05 y' Y;
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = _get_rgb spec p.fgcolor in
  let r, g, b = color in
  let line_style = _get_line_style spec 1 in
  let line_width = _get_line_width spec (-1.) in
  let fill_pattern = _get_fill_pattern spec 0 in
  let old_pensize = h.pensize in
  (* drawing function *)
  let f () =
    let r', g', b' = plgcol0 1 in
    plscol0 1 r g b;
    plcol0 1;
    if line_width > -1. then plwidth line_width;
    pllsty line_style;
    plpsty fill_pattern;
    plfill x' y';
    plline x' y';
    (* restore original settings *)
    plscol0 1 r' g' b';
    plcol0 1;
    plwidth old_pensize;
    pllsty 1
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  if not h.holdon then output h


let _draw_arc _fill n x =
  let open Plplot in
  let a = 2. *. Owl_const.pi in
  let theta = a /. n in
  let i = ref 0. in
  Array.iter
    (fun y ->
      let c = n *. y in
      let x' =
        Array.init
          (int_of_float c + 1)
          (fun j -> Owl_maths.(sin ((float_of_int j +. !i) *. theta)))
      in
      let y' =
        Array.init
          (int_of_float c + 1)
          (fun j -> Owl_maths.(cos ((float_of_int j +. !i) *. theta)))
      in
      let x' = Array.(append [| 0. |] x') in
      let y' = Array.(append [| 0. |] y') in
      plline x' y';
      (* generates a color theme *)
      let r', g', b' = plgcol0 1 in
      let rgb = mod_float ((!i +. 1.) *. 50.) 256. |> int_of_float in
      plscol0 1 rgb rgb rgb;
      plcol0 1;
      plpsty 3;
      plfill x' y';
      (* restore original settings *)
      plscol0 1 r' g' b';
      plcol0 1;
      i := !i +. c)
    x


(* TODO: improve the filling ... *)
let pie ?(h = _default_handle) ?(spec = []) x =
  let open Plplot in
  _adjust_range h ~margin:0.1 [| -1.; 1. |] X;
  _adjust_range h ~margin:0.1 [| -1.; 1. |] Y;
  let x = Owl_dense_matrix.D.to_array x in
  let x = Owl_stats.normlise_pdf x in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = _get_rgb spec p.fgcolor in
  let r, g, b = color in
  let fill = _get_fill spec false in
  let old_pensize = h.pensize in
  (* drawing function *)
  let f () =
    let r', g', b' = plgcol0 1 in
    plscol0 1 r g b;
    plcol0 1;
    plwidth 1.;
    pllsty 1;
    plpsty 0;
    _draw_arc fill 1000. x;
    (* restore original settings *)
    plscol0 1 r' g' b';
    plcol0 1;
    plwidth old_pensize;
    pllsty 1
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  if not h.holdon then output h


let loglog ?(h = _default_handle) ?(spec = []) ?x y =
  let open Plplot in
  let y = Owl_dense_matrix.D.to_array y in
  let n = Array.length y in
  let x =
    match x with
    | Some mtx -> Owl_dense_matrix.D.to_array mtx
    (* The range is [1..n] instead of [0..(n-1)] *)
    | None ->
      Owl_dense_matrix.D.linspace 1. (float_of_int n) n |> Owl_dense_matrix.D.to_array
  in
  let axis = _get_axis spec XY in
  let x, y =
    match axis with
    | X -> Array.map Owl_maths.log10 x, y
    | Y -> x, Array.map Owl_maths.log10 y
    | _ -> Array.map Owl_maths.log10 x, Array.map Owl_maths.log10 y
  in
  _adjust_range h x X;
  _adjust_range h y Y;
  let p = h.pages.(h.current_page) in
  let _ =
    match axis with
    | X -> p.xlogscale <- true
    | Y -> p.ylogscale <- true
    | _ ->
      p.xlogscale <- true;
      p.ylogscale <- true
  in
  (* prepare the closure *)
  let color = _get_rgb spec p.fgcolor in
  let r, g, b = color in
  let marker = _get_marker spec "" in
  let marker_size = _get_marker_size spec 4. in
  let line_style = _get_line_style spec 1 in
  let line_width = _get_line_width spec (-1.) in
  let old_pensize = h.pensize in
  (* drawing function *)
  let f () =
    let r', g', b' = plgcol0 1 in
    plscol0 1 r g b;
    plcol0 1;
    if line_width > -1. then plwidth line_width;
    let c' = plgchr () |> fst in
    plschr marker_size 1.;
    if line_style > 0 && line_style < 9 then pllsty line_style;
    plline x y;
    if marker <> ""
    then (
      let x', y' = _thinning x, _thinning y in
      plstring x' y' marker);
    (* restore original settings *)
    plschr c' 1.;
    plwidth old_pensize;
    pllsty 1;
    plscol0 1 r' g' b';
    plcol0 1
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  (* add legend item to page *)
  _add_legend_item p LINE line_style color marker color 0 color;
  if not h.holdon then output h


let semilogx ?(h = _default_handle) ?(spec = []) ?x y =
  let spec = spec @ [ Axis X ] in
  match x with
  | Some arr -> loglog ~h ~spec ~x:arr y
  | None     -> loglog ~h ~spec y


let semilogy ?(h = _default_handle) ?(spec = []) ?x y =
  let spec = spec @ [ Axis Y ] in
  match x with
  | Some arr -> loglog ~h ~spec ~x:arr y
  | None     -> loglog ~h ~spec y


let surf ?(h = _default_handle) ?(spec = []) x y z =
  let open Plplot in
  let x = Owl_dense_matrix.D.(row x 0 |> to_array) in
  let y = Owl_dense_matrix.D.(col y 0 |> to_array) in
  let z = Owl_dense_matrix.D.transpose z in
  let z0 = Owl_dense_matrix.D.to_arrays z in
  let z1 = Owl_dense_matrix.D.to_array z in
  _adjust_range h x X;
  _adjust_range h y Y;
  _adjust_range h z1 Z;
  (* construct contour level *)
  let zmin, zmax = Owl_stats.minmax z1 in
  let clvl = Owl_dense_matrix.D.(linspace zmin zmax 10 |> to_array) in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  p.is_3d <- true;
  p.altitude <- _get_altitude spec p.altitude;
  p.azimuth <- _get_azimuth spec p.azimuth;
  (* assemble the specifications *)
  let mag_color = _get_mag_color spec true in
  let contour = _get_contour spec false in
  let curtain = _get_curtain spec false in
  let faceted = _get_faceted spec false in
  let opt = [ PL_DIFFUSE ] in
  let opt = opt @ if mag_color then [ PL_MAG_COLOR ] else [] in
  let opt = opt @ if contour then [ PL_BASE_CONT; PL_SURF_CONT ] else [] in
  let opt = opt @ if curtain then [ PL_DRAW_SIDES ] else [] in
  let opt = opt @ if faceted then [ PL_FACETED ] else [] in
  (* drawing function *)
  let f () = plsurf3d x y z0 opt clvl (* restore original settings, if any *) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  if not h.holdon then output h


let plot3d = surf

let mesh ?(h = _default_handle) ?(spec = []) x y z =
  let open Plplot in
  let x = Owl_dense_matrix.D.(row x 0 |> to_array) in
  let y = Owl_dense_matrix.D.(col y 0 |> to_array) in
  let z = Owl_dense_matrix.D.transpose z in
  let z0 = Owl_dense_matrix.D.to_arrays z in
  let z1 = Owl_dense_matrix.D.to_array z in
  _adjust_range h x X;
  _adjust_range h y Y;
  _adjust_range h z1 Z;
  (* construct contour level *)
  let zmin, zmax = Owl_stats.minmax z1 in
  let clvl = Owl_dense_matrix.D.(linspace zmin zmax 10 |> to_array) in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  p.is_3d <- true;
  p.altitude <- _get_altitude spec p.altitude;
  p.azimuth <- _get_azimuth spec p.azimuth;
  let color = _get_rgb spec p.fgcolor in
  let r, g, b = color in
  (* assemble the specifications *)
  let mag_color = _get_mag_color spec true in
  let contour = _get_contour spec false in
  let curtain = _get_curtain spec false in
  let opt = [ PL_MESH ] in
  let opt = opt @ [ _get_zline spec PL_DRAW_LINEXY ] in
  let opt = opt @ if mag_color then [ PL_MAG_COLOR ] else [] in
  let opt = opt @ if contour then [ PL_BASE_CONT; PL_SURF_CONT ] else [] in
  let opt = opt @ if curtain then [ PL_DRAW_SIDES ] else [] in
  (* drawing function *)
  let f () =
    (* only takes effect when NoMagColor is set *)
    let r', g', b' = plgcol0 1 in
    plscol0 1 r g b;
    plcol0 1;
    match contour with
    | true  -> plmeshc x y z0 opt clvl
    | false ->
      plmesh x y z0 opt;
      (* restore original settings, if any *)
      plscol0 1 r' g' b';
      plcol0 1
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  if not h.holdon then output h


let heatmap ?(h = _default_handle) x y z =
  let open Plplot in
  let x = Owl_dense_matrix.D.(row x 0 |> to_array) in
  let y = Owl_dense_matrix.D.(col y 0 |> to_array) in
  let z = Owl_dense_matrix.D.transpose z in
  let z0 = Owl_dense_matrix.D.to_arrays z in
  let z1 = Owl_dense_matrix.D.to_array z in
  _adjust_range h x X;
  _adjust_range h y Y;
  _adjust_range h z1 Z;
  (* construct contour level *)
  let xmin, xmax = Owl_stats.minmax x in
  let ymin, ymax = Owl_stats.minmax y in
  let zmin, zmax = Owl_stats.minmax z1 in
  let clvl = Owl_dense_matrix.D.(linspace zmin zmax 10 |> to_array) in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let f () =
    plshades z0 xmin xmax ymin ymax clvl 1.0 0 1.0 false
    (* restore original settings, if any *)
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  if not h.holdon then output h


let contour ?(h = _default_handle) x y z =
  let open Plplot in
  let m, n = Owl_dense_matrix.D.shape z in
  let x0 = Owl_dense_matrix.D.to_arrays x in
  let x1 = Owl_dense_matrix.D.to_array x in
  let y0 = Owl_dense_matrix.D.to_arrays y in
  let y1 = Owl_dense_matrix.D.to_array y in
  let z0 = Owl_dense_matrix.D.to_arrays z in
  let z1 = Owl_dense_matrix.D.to_array z in
  _adjust_range h x1 X;
  _adjust_range h y1 Y;
  (* construct contour level *)
  let zmin, zmax = Owl_stats.minmax z1 in
  let clvl = Owl_dense_matrix.D.(linspace zmin zmax 10 |> to_array) in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let f () =
    plset_pltr (pltr2 x0 y0);
    plcont z0 1 m 1 n clvl;
    plunset_pltr ()
    (* restore original settings, if any *)
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  if not h.holdon then output h


let _draw_extended_line x0 y0 x1 y1 l r u d =
  (* Specify two points, draw a line between them, and extend on both ends with dash line *)
  let open Plplot in
  let x0, y0, x1, y1 = if x0 > x1 then x1, y1, x0, y0 else x0, y0, x1, y1 in
  let yl = if x0 = x1 then u else y0 -. ((y1 -. y0) /. (x1 -. x0) *. (x0 -. l)) in
  let yr = if x0 = x1 then d else y1 +. ((y1 -. y0) /. (x1 -. x0) *. (r -. x1)) in
  let xl = if x0 = x1 then x0 else l in
  let xr = if x0 = x1 then x0 else r in
  pllsty 1;
  pljoin x0 y0 x1 y1;
  pllsty 3;
  pljoin xl yl x0 y0;
  pllsty 3;
  pljoin x1 y1 xr yr;
  (* restore line style *)
  pllsty 1


let probplot
    ?(h = _default_handle)
    ?(spec = [])
    ?(dist = Owl_stats.gaussian_ppf ~mu:0. ~sigma:1.)
    ?(noref = false)
    x
  =
  (* TODO: show y-axis as probability instead of invcdf; Choose suitable
      yticks for different distribution; support for censor data, frequency *)

  (* inputs *)
  let open Plplot in
  let x = Owl_dense_matrix.D.to_array x |> Owl_stats.sort ~inc:true in
  let y =
    let n = Array.length x in
    let qth =
      Owl_dense_matrix.D.linspace
        ((1. -. 0.5) /. float_of_int n)
        ((float_of_int n -. 0.5) /. float_of_int n)
        n
    in
    let q = Owl_dense_matrix.D.map dist qth in
    Owl_dense_matrix.D.to_array q
  in
  _adjust_range h x X;
  _adjust_range h y Y;
  (* parameters to draw the reference line *)
  let p1y, p1x = Owl_stats.first_quartile y, Owl_stats.first_quartile x in
  let p3y, p3x = Owl_stats.third_quartile y, Owl_stats.third_quartile x in
  let left, right = Owl_stats.minmax x in
  let up, down = Owl_stats.minmax y in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = _get_rgb spec p.fgcolor in
  let r, g, b = color in
  let marker = _get_marker spec "#[0x002b]" in
  let marker_size = _get_marker_size spec 4. in
  (* drawing function *)
  let f () =
    let r', g', b' = plgcol0 1 in
    plscol0 1 r g b;
    plcol0 1;
    let c' = plgchr () |> fst in
    plschr marker_size 1.;
    if not noref then _draw_extended_line p1x p1y p3x p3y left right up down;
    plstring x y marker;
    (* restore original settings *)
    plschr c' 1.;
    plscol0 1 r' g' b';
    plcol0 1
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  (* add legend item to page *)
  _add_legend_item p SCATTER 0 color marker color 0 color;
  if not h.holdon then output h


let normplot ?(h = _default_handle) ?(spec = []) ?(sigma = 1.) x =
  (* TODO: replace yticklabels, including unseen tick labels,  with user-defined labels *)
  let dist = Owl_stats.gaussian_ppf ~mu:0. ~sigma in
  probplot ~h ~spec ~dist x


let wblplot ?(h = _default_handle) ?(spec = []) ?(lambda = 1.) ?(k = 1.) x =
  (* TODO: logscale and logfit *)
  (* inputs *)
  let open Plplot in
  let x = Owl_dense_matrix.D.to_array x |> Owl_stats.sort ~inc:true in
  let dist = Owl_stats.weibull_ppf ~shape:k ~scale:lambda in
  let y =
    let n = Array.length x in
    let qth =
      Owl_dense_matrix.D.linspace
        ((1. -. 0.5) /. float_of_int n)
        ((float_of_int n -. 0.5) /. float_of_int n)
        n
    in
    let q = Owl_dense_matrix.D.map dist qth in
    Owl_dense_matrix.D.to_array q
  in
  _adjust_range h x X;
  _adjust_range h y Y;
  (* parameters to draw the reference line *)
  let p1y, p1x = Owl_stats.first_quartile y, Owl_stats.first_quartile x in
  let p3y, p3x = Owl_stats.third_quartile y, Owl_stats.third_quartile x in
  let left, right = Owl_stats.minmax x in
  let up, down = Owl_stats.minmax y in
  (* prepare the closure; note the change to log scale *)
  let p = h.pages.(h.current_page) in
  let color = _get_rgb spec p.fgcolor in
  let r, g, b = color in
  let marker = _get_marker spec "#[0x002b]" in
  let marker_size = _get_marker_size spec 4. in
  (* drawing function *)
  let f () =
    let r', g', b' = plgcol0 1 in
    plscol0 1 r g b;
    plcol0 1;
    let c' = plgchr () |> fst in
    plschr marker_size 1.;
    _draw_extended_line p1x p1y p3x p3y left right up down;
    plstring x y marker;
    (* restore original settings *)
    plschr c' 1.;
    plscol0 1 r' g' b';
    plcol0 1
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  (* add legend item to page *)
  _add_legend_item p SCATTER 0 color marker color 0 color;
  if not h.holdon then output h


let _ecdf_dist a b p =
  (* find the ecdf value of probability value p; (a, b) is the output of
     Stats.ecdf *)
  let rec _find_rec x lst i =
    match lst with
    | hd :: tl -> if hd > x then i - 1 else _find_rec x tl (i + 1)
    | _        -> Array.length b - 1
  in
  let ticks = Array.to_list b in
  let i = _find_rec p ticks 1 in
  a.(i)


let qqplot
    ?(h = _default_handle)
    ?(spec = [])
    ?(pd = Owl_stats.gaussian_ppf ~mu:0. ~sigma:1.)
    ?x
    y
  =
  (* TODO: support matrix input; add support for `pvec` argument;
     plot the larger data input on x-axis *)
  let open Plplot in
  let y = Owl_dense_matrix.D.to_array y |> Owl_stats.sort ~inc:true in
  let n = Array.length y in
  let dist =
    match x with
    | Some arr ->
      (* if the second argument is a vector *)
      let x = Owl_dense_matrix.D.to_array arr in
      (* The empirical CDF of it is used as dist. *)
      let a, b = Owl_stats.ecdf x in
      fun p -> _ecdf_dist a b p
    | None     -> pd
  in
  let qth =
    Owl_dense_matrix.D.linspace
      ((1. -. 0.5) /. float_of_int n)
      ((float_of_int n -. 0.5) /. float_of_int n)
      n
  in
  let q = Owl_dense_matrix.D.map dist qth in
  let x = Owl_dense_matrix.D.to_array q in
  (* draw the figure *)
  _adjust_range h x X;
  _adjust_range h y Y;
  (* parameters to draw the reference line *)
  let p1y, p1x = Owl_stats.first_quartile y, Owl_stats.first_quartile x in
  let p3y, p3x = Owl_stats.third_quartile y, Owl_stats.third_quartile x in
  let left, right = Owl_stats.minmax x in
  let up, down = Owl_stats.minmax y in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = _get_rgb spec p.fgcolor in
  let r, g, b = color in
  let marker = _get_marker spec "#[0x002b]" in
  let marker_size = _get_marker_size spec 4. in
  (* drawing function *)
  let f () =
    let r', g', b' = plgcol0 1 in
    plscol0 1 r g b;
    plcol0 1;
    let c' = plgchr () |> fst in
    plschr marker_size 1.;
    _draw_extended_line p1x p1y p3x p3y left right up down;
    plstring x y marker;
    (* restore original settings *)
    plschr c' 1.;
    plscol0 1 r' g' b';
    plcol0 1
  in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [| f |];
  (* add legend item to page *)
  _add_legend_item p SCATTER 0 color marker color 0 color;
  if not h.holdon then output h


(* TODO *)

let scatterhist = None [@@warning "-32"]

(* other plots *)

let image ?(h = _default_handle) x =
  let open Plplot in
  (* rotate the matrix 90 degree clockwise to be shown correctly as image *)
  let x = Owl_dense_matrix.D.rotate x 90 in
  (* compute necessary parameters *)
  let width, height = Owl_dense_matrix.D.shape x in
  let num_col = Owl_dense_matrix.D.max' x in
  let img = Owl_dense_matrix.D.to_arrays x in
  let width = float_of_int width in
  let height = float_of_int height in
  let num_col = int_of_float num_col in
  (* specify the boundary of imageplot *)
  let x = [| 1.0; width |] in
  let y = [| 1.0; height |] in
  _adjust_range h x X;
  _adjust_range h y Y;
  (* keep the scale of original image instead of 4:3 *)
  h.page_size <- int_of_float width, int_of_float height;
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let _ = p.no_axes <- true in
  let f () =
    (* set gray_cmap *)
    let r = [| 0.0; 1.0 |] in
    let g = [| 0.0; 1.0 |] in
    let b = [| 0.0; 1.0 |] in
    let pos = [| 0.0; 1.0 |] in
    plscmap1n num_col;
    plscmap1l true pos r g b None;
    plimage img 1.0 width 1.0 height 0.0 0.0 1.0 width 1.0 height
    (* possibly need to restore original settings *)
  in
  p.plots <- Array.append p.plots [| f |];
  if not h.holdon then output h


let spy ?(h = _default_handle) ?(spec = []) x =
  let xs = Owl_utils.Stack.make () in
  let ys = Owl_utils.Stack.make () in
  let m, n = Owl_dense_matrix.D.shape x in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      let a = Owl_dense_matrix.D.get x i j in
      if a <> 0.
      then (
        Owl_utils.Stack.push xs (float_of_int i);
        Owl_utils.Stack.push ys (float_of_int j))
    done
  done;
  let x = Owl_utils.Stack.to_array xs in
  let y = Owl_utils.Stack.to_array ys in
  let x = Owl_dense_matrix.D.of_arrays [| x |] in
  let y = Owl_dense_matrix.D.of_arrays [| y |] in
  scatter ~h ~spec x y

(* ends here *)
