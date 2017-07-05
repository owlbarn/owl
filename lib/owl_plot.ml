(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Plot Module *)

(* types in plot module *)

type dsmat = Owl_dense_matrix.D.mat

type color = RED | GREEN | BLUE

type legend_typ = LINE | SCATTER | BOX

type legend_position = North | South | West | East | NorthWest | NorthEast | SouthWest | SouthEast

type legend_item = {
  mutable plot_type : legend_typ;
  mutable line_style : int;
  mutable line_color : int * int * int;
  mutable marker : string;
  mutable marker_color : int * int * int;
  mutable fill_pattern : int;
  mutable fill_color : int * int * int;
}

type page = {
  mutable title : string;
  mutable fgcolor : int * int * int;
  mutable fontsize : float;
  mutable is_3d : bool;
  (* control axis labels *)
  mutable xlabel : string;
  mutable ylabel : string;
  mutable zlabel : string;
  (* control axis ranges *)
  mutable xrange : float * float;
  mutable yrange : float * float;
  mutable zrange : float * float;
  mutable auto_xrange : bool;
  mutable auto_yrange : bool;
  mutable auto_zrange : bool;
  (* control tick labels *)
  mutable xticklabels : (float * string) list;
  mutable yticklabels : (float * string) list;
  mutable zticklabels : (float * string) list;
  (* control axis log scale *)
  mutable xlogscale : bool;
  mutable ylogscale : bool;
  (* control grids *)
  mutable xgrid : bool;
  mutable ygrid : bool;
  mutable zgrid : bool;
  (* viewing perspective for 3D plots
   * http://plplot.sourceforge.net/docbook-manual/plplot-html-5.12.0/plw3d.html *)
  mutable altitude : float;
  mutable azimuth : float;
  (* control legend *)
  mutable legend : bool;
  mutable legend_position : legend_position;
  mutable legend_items : legend_item array;
  mutable legend_names : string array;
  (* cache the plot operations *)
  mutable plots : (unit -> unit) array;
}

type handle = {
  mutable holdon : bool;
  mutable output : string;
  mutable bgcolor : int * int * int;
  mutable pensize : float;
  mutable page_size : int * int;
  (* control the sub plots *)
  mutable shape : int * int;
  mutable pages : page array;
  mutable current_page : int;
}

(* module functions to simplify plotting *)

let _create_page () = {
  title = "";
  fgcolor = (255, 0, 0);
  fontsize = -1.;
  is_3d = false;
  xlabel = "x";
  ylabel = "y";
  zlabel = "z";
  xrange = (infinity, neg_infinity);
  yrange = (infinity, neg_infinity);
  zrange = (infinity, neg_infinity);
  auto_xrange = true;
  auto_yrange = true;
  auto_zrange = true;
  xticklabels = [];
  yticklabels = [];
  zticklabels = [];
  xlogscale = false;
  ylogscale = false;
  xgrid = false;
  ygrid = false;
  zgrid = false;
  altitude = 33.;
  azimuth = 115.;
  legend = false;
  legend_position = NorthEast;
  legend_items = [||];
  legend_names = [||];
  plots = [||];
}

let _create_handle () = {
  holdon = true;
  output = "";
  bgcolor = (0, 0, 0);
  pensize = 0.;
  page_size = (0,0);
  shape = (1, 1);
  current_page = 0;
  pages = [|_create_page ()|];
}

let create ?(m=1) ?(n=1) s =
  let pages = Array.make (m * n) None |> Array.map (fun _ -> _create_page ()) in
  let h = _create_handle () in
  let _ = h.shape <- (m, n) in
  let _ = h.pages <- pages in
  let _ = h.output <- s in h

let _default_handle =
  let h = _create_handle () in
  let _ = h.holdon <- false in h

let _supported_device = ["aqt"; "xwin"; "pdf"; "ps"; "psc"; "png"; "svg"; "xfig"; "psttf"; "psttc";
  "xcairo"; "pdfcairo"; "epscairo"; "pscairo"; "svgcairo"; "pngcairo"; "memcairo"; "extcairo"]

let _set_device h =
  try let x = Owl_utils.get_suffix h.output in
    Plplot.plsdev x;
    Plplot.plsfnam h.output;
  with exn -> ()

let _add_legend_item p plot_type line_style line_color marker marker_color fill_pattern fill_color =
  let item = {
    plot_type = plot_type;
    line_style = line_style;
    line_color = line_color;
    marker = marker;
    marker_color = marker_color;
    fill_pattern = fill_pattern;
    fill_color = fill_color;
  }
  in
  p.legend_items <- Array.append p.legend_items [|item|]

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
  let opt_array = Array.map (fun item ->
    match item.plot_type with
    | LINE -> [ PL_LEGEND_LINE; PL_LEGEND_SYMBOL ]
    | SCATTER -> [ PL_LEGEND_SYMBOL ]
    | BOX -> [ PL_LEGEND_COLOR_BOX ]
    ) p.legend_items in
  let text_colors = Array.map (fun _ -> 1) p.legend_items in
  let text = Array.mapi (fun i _ -> p.legend_names.(i)) p.legend_items in
  let line_colors = Array.mapi (fun i x ->
    let r, g, b = x.line_color in
    plscol0 (i + cbase) r g b; (i + cbase)
    ) p.legend_items in
  let line_styles = Array.map (fun x -> x.line_style) p.legend_items in
  let line_widths = Array.map (fun _ -> 1.) p.legend_items in
  let marker_colors = line_colors in
  let marker_scales = Array.map (fun _ -> 1.) p.legend_items in
  let marker_nums = Array.map (fun _ -> 3) p.legend_items in
  let markers = Array.map (fun x -> x.marker) p.legend_items in
  let box_colors = line_colors in
  let box_patterns = Array.map (fun x -> x.fill_pattern) p.legend_items in
  let box_scales = Array.map (fun x -> 0.8) p.legend_items in
  let box_linewidths = Array.map (fun x -> 1.) p.legend_items in
  let _ = pllegend opt position 0.05 0.05
    0.1 15 1 1 0 0
    opt_array 1.0 1.0 2.0
    1.0 text_colors text
    box_colors box_patterns box_scales box_linewidths
    line_colors line_styles line_widths
    marker_colors marker_scales marker_nums markers
  in ()

let _calculate_paper_size m n =
  let max_w, max_h = 900., 900. in
  let r0 = 4. /. 3. in
  let cur_w, cur_h = r0 *. (float_of_int n), float_of_int m in
  let r1 = max_w /. max_h in
  let r2 = cur_w /. cur_h in
  let w, h = match (r1 /. r2) < 1. with
    | true  -> max_w, max_w /. r2
    | false -> max_h *. r2, max_h
  in
  int_of_float w, int_of_float h

(* calculate the axis config based on a page config *)
let _config_2d_axis p =
  let base = 0 in
  let residual =
    if (p.xlogscale, p.ylogscale) = (true, false) then 10 else
    if (p.xlogscale, p.ylogscale) = (false, true) then 20 else
    if (p.xlogscale, p.ylogscale) = (true, true)  then 30 else
    if p.xticklabels |> List.length > 0
    || p.yticklabels |> List.length > 0
    then 70
    else 0
  in base + residual

let _initialise h =
  let open Plplot in
  (* configure before init *)
  let _ = _set_device h in
  let _ = (let r, g, b = h.bgcolor in plscolbg r g b) in
  (* init the plot *)
  let m, n = h.shape in
  let _ = if not (h.shape = (1,1)) then plssub n m in
  let x, y = match h.page_size = (0, 0) with
    | true  -> _calculate_paper_size m n
    | false -> h.page_size
  in
  let _ = plspage 0. 0. x y 0 0 in
  let _ = plinit () in
  (* configure after init *)
  let _ = plwidth h.pensize in ()

(* callback function of drawing customised tick labels *)
let _draw_ticklabels p axis value =
  let open Plplot in
  let l = match axis with
    | PL_X_AXIS -> p.xticklabels
    | PL_Y_AXIS -> p.yticklabels
    | PL_Z_AXIS -> p.zticklabels
  in
  try List.assoc value l
  with exn -> Printf.sprintf "%g" value

let _prepare_page p =
  let open Plplot in
  (* customise tick labels if necessary *)
  plslabelfunc (_draw_ticklabels p);
  (* configure an individual page *)
  let r, g, b = p.fgcolor in
  let _ = plscol0 1 r g b; plcol0 1 in
  let _ = if p.fontsize > 0. then plschr p.fontsize 1.0 in
  let xmin, xmax = p.xrange in
  let ymin, ymax = p.yrange in
  let zmin, zmax = p.zrange in
  let alt, az = p.altitude, p.azimuth in (
  if not p.is_3d then
    (* prepare a 2D plot *)
    let _ = plenv xmin xmax ymin ymax 0 (_config_2d_axis p) in
    let _ = pllab p.xlabel p.ylabel p.title in ()
  else
    (* prepare a 3D plot *)
    let _ = pladv 0 in
    let _ = plvpor 0.0 1.0 0.0 0.9 in
    let _ = plwind (-1.0) 1.0 (-1.0) 1.5 in
    let _ = plw3d 1.0 1.0 1.2 xmin xmax ymin ymax zmin zmax alt az in
    let _ = plbox3 "bntu" p.xlabel 0.0 0
                   "bntu" p.ylabel 0.0 0
                   "bcdfntu" p.zlabel 0.0 4
    in ()
  );
  if p.legend then _draw_legend p

let _finalise () =
  (* play safe, reset pages in default_handle *)
  _default_handle.pages <- [|_create_page ()|];
  Plplot.plend ()

let output h =
  h.holdon <- false;
  _initialise h;
  Array.iteri (fun i p ->
    if i > 0 then Plplot.pladv i;
    _prepare_page p;
    Array.iter (fun f -> f ()) p.plots
  ) h.pages;
  _finalise ()

let set_output h s =
  let x = Owl_utils.get_suffix s in
  match (List.mem x _supported_device) with
  | true  -> h.output <- s
  | false -> Log.error "unsupported file type."

let set_title h s = (h.pages.(h.current_page)).title <- s

let set_xlabel h s = (h.pages.(h.current_page)).xlabel <- s

let set_ylabel h s = (h.pages.(h.current_page)).ylabel <- s

let set_zlabel h s = (h.pages.(h.current_page)).zlabel <- s

let set_xrange h a b =
  (h.pages.(h.current_page)).auto_xrange <- false;
  (h.pages.(h.current_page)).xrange <- (a, b)

let set_yrange h a b =
  (h.pages.(h.current_page)).auto_yrange <- false;
  (h.pages.(h.current_page)).yrange <- (a, b)

let set_zrange h a b =
  (h.pages.(h.current_page)).auto_zrange <- false;
  (h.pages.(h.current_page)).zrange <- (a, b)

let set_xticklabels h l = (h.pages.(h.current_page)).xticklabels <- l

let set_yticklabels h l = (h.pages.(h.current_page)).yticklabels <- l

let set_zticklabels h l = (h.pages.(h.current_page)).zticklabels <- l

let set_foreground_color h r g b = (h.pages.(h.current_page)).fgcolor <- (r, g, b)

let set_background_color h r g b = h.bgcolor <- (r, g, b)

let set_altitude h a = (h.pages.(h.current_page)).altitude <- a

let set_azimuth h a = (h.pages.(h.current_page)).azimuth <- a

let set_font_size h x = (h.pages.(h.current_page)).fontsize <- x

let set_pen_size h x = h.pensize <- x

let set_page_size h x y = h.page_size <- (x, y)

let legend_on h ?(position=NorthEast) s =
  (h.pages.(h.current_page)).legend <- true;
  (h.pages.(h.current_page)).legend_position <- position;
  (h.pages.(h.current_page)).legend_names <- s

let legend_off h = (h.pages.(h.current_page)).legend <- false

(* TODO *)
let rgb = None

(*FIXME: plptex3 to write text inside the viewport of a 3D plot*)
let text ?(h=_default_handle) ?(color=(-1,-1,-1)) x y ?(dx=0.) ?(dy=0.) s =
  let open Plplot in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let r, g, b = if color = (-1,-1,-1) then p.fgcolor else color in
  let f = (fun () ->
    (*save original color index*)
    let r', g', b' = plgcol0 1 in
    let _ = plscol0 1 r g b; plcol0 1 in
    let _ = plptex x y dx dy 0. s in
    (* restore original settings *)
    plscol0 1 r' g' b'; plcol0 1
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  if not h.holdon then output h

let _thinning x =
  let n = min ((float_of_int (Array.length x)) *. 0.1 ) 15. in
  let c = float_of_int (Array.length x) /. n in
  Array.init (int_of_float n) (fun i -> x.(int_of_float (float_of_int i *. c)))

let _union_range p r x =
  let a, b = r in
  let m, n = Owl_stats.minmax x in
  let c = if a < m then a else m in
  let d = if b > n then b else n in
  let e = (d -. c) *. p in
  c -. e, d +. e

let _adjust_range ?(margin=0.) h d axis =
  let p = h.pages.(h.current_page) in
  match axis with
  | `X -> if p.auto_xrange then p.xrange <- _union_range margin p.xrange d
  | `Y -> if p.auto_yrange then p.yrange <- _union_range margin p.yrange d
  | `Z -> if p.auto_zrange then p.zrange <- _union_range margin p.zrange d

let plot ?(h=_default_handle) ?(color=(-1,-1,-1)) ?(marker="") ?(marker_size=4.) ?(line_style=1) ?(line_width=(-1.)) x y =
  let open Plplot in
  let x = Owl_dense_matrix.D.to_array x in
  let y = Owl_dense_matrix.D.to_array y in
  let _ = _adjust_range h x `X in
  let _ = _adjust_range h y `Y in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = if color = (-1,-1,-1) then p.fgcolor else color in
  let r, g, b = color in
  let old_pensize = h.pensize in
  let f = (fun () ->
    let r', g', b' = plgcol0 1 in
    let _ = plscol0 1 r g b; plcol0 1 in
    let _ = if line_width > (-1.) then plwidth line_width in
    let c' = plgchr () |> fst in
    let _ = plschr marker_size 1. in
    let _ = match line_style > 0 && line_style < 9 with
      | true  -> pllsty line_style; plline x y
      | false -> ()
    in
    let _ = match marker = "" with
      | true  -> ()
      | false -> (
          let x', y' = _thinning x, _thinning y in
          plstring x' y' marker )
    in
    (* restore original settings *)
    let _ = plschr c' 1. in
    let _ = plwidth old_pensize in
    let _ = pllsty 1 in
    plscol0 1 r' g' b'; plcol0 1
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  (* add legend item to page *)
  _add_legend_item p LINE line_style color marker color 0 color;
  if not h.holdon then output h

let plot_fun ?(h=_default_handle) ?(color=(-1,-1,-1)) ?(marker="") ?(marker_size=4.) ?(line_style=1) ?(line_width=(-1.)) f a b =
  let x = Owl_dense_matrix.D.linspace a b 100 in
  let y = Owl_dense_matrix.D.map f x in
  plot ~h ~color ~marker ~marker_size ~line_style ~line_width x y

let scatter ?(h=_default_handle) ?(color=(-1,-1,-1)) ?(marker="•") ?(marker_size=4.) x y =
  let open Plplot in
  let x = Owl_dense_matrix.D.to_array x in
  let y = Owl_dense_matrix.D.to_array y in
  let _ = _adjust_range h x `X in
  let _ = _adjust_range h y `Y in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = if color = (-1,-1,-1) then p.fgcolor else color in
  let r, g, b = color in
  let f = (fun () ->
    let r', g', b' = plgcol0 1 in
    let _ = plscol0 1 r g b; plcol0 1 in
    let c' = plgchr () |> fst in
    let _ = plschr marker_size 1. in
    let _ = plstring x y marker in
    (* restore original settings *)
    let _ = plschr c' 1. in
    plscol0 1 r' g' b'; plcol0 1
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  (* add legend item to page *)
  _add_legend_item p SCATTER 0 color marker color 0 color;
  if not h.holdon then output h

let histogram ?(h=_default_handle) ?(color=(-1,-1,-1)) ?(bin=10) x =
  let open Plplot in
  let x = Owl_dense_matrix.D.to_array x in
  let _ = _adjust_range h x `X in
  let xmin, xmax = Owl_stats.minmax x in
  let ymin, ymax = 0., Owl_stats.(histogram x bin |> Array.map float_of_int |> max)  *. 1.1 in
  let _ = _adjust_range h [|xmin; xmax|] `X in
  let _ = _adjust_range h [|ymin; ymax|] `Y in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = if color = (-1,-1,-1) then p.fgcolor else color in
  let r, g, b = color in
  let f = (fun () ->
    let r', g', b' = plgcol0 1 in
    let _ = plscol0 1 r g b; plcol0 1 in
    plhist x xmin xmax bin [ PL_HIST_DEFAULT; PL_HIST_NOSCALING; PL_HIST_NOEXPAND ];
    (* restore original settings *)
    plscol0 1 r' g' b'; plcol0 1;
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  (* add legend item to page *)
  _add_legend_item p BOX 1 color "" color 0 color;
  if not h.holdon then output h

let subplot h i j =
  let _, n = h.shape in
  h.current_page <- (n * i + j)

let stem ?(h=_default_handle) ?(color=(-1,-1,-1)) ?(marker="#[0x2299]") ?(marker_size=4.) ?(line_style=2) ?(line_width=(-1.)) x y =
  let open Plplot in
  let x = Owl_dense_matrix.D.to_array x in
  let y = Owl_dense_matrix.D.to_array y in
  let _ = _adjust_range h x `X in
  let _ = _adjust_range h y `Y in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = if color = (-1,-1,-1) then p.fgcolor else color in
  let r, g, b = color in
  let old_pensize = h.pensize in
  let f = (fun () ->
    let r', g', b' = plgcol0 1 in
    let _ = plscol0 1 r g b; plcol0 1 in
    let _ = if line_width > (-1.) then plwidth line_width in
    let c' = plgchr () |> fst in
    let _ = plschr marker_size 1. in
    let _ = match line_style > 0 && line_style < 9 with
      | true  -> (
          pllsty line_style;
          Owl_utils.array_iter2 (fun x' y' -> pljoin x' 0. x' y') x y
        )
      | false -> ()
    in
    let _ = if not (marker = "") then plstring x y marker in
    (* restore original settings *)
    let _ = plschr c' 1. in
    let _ = plwidth old_pensize in
    let _ = pllsty 1 in
    plscol0 1 r' g' b'; plcol0 1
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  (* add legend item to page *)
  _add_legend_item p LINE line_style color marker color 0 color;
  if not h.holdon then output h

let autocorr ?(h=_default_handle) ?(marker="•") ?(marker_size=4.) x =
  let z = Owl_dense_matrix.D.to_array x in
  let x' = Array.init (Array.length z) (fun i -> float_of_int i) in
  let y' = Array.mapi (fun i _ -> Owl_stats.autocorrelation ~lag:i z) x' in
  let x' = Owl_dense_matrix.D.of_arrays [|x'|] in
  let y' = Owl_dense_matrix.D.of_arrays [|y'|] in
  let _ = set_xlabel h "Lag" in
  let _ = set_ylabel h "Autocorrelation" in
  stem ~h ~marker ~marker_size ~line_style:1 x' y'

let draw_line ?(h=_default_handle) ?(color=(-1,-1,-1)) ?(line_style=1) ?(line_width=(-1.)) x0 y0 x1 y1 =
  let open Plplot in
  let x = [|x0; x1|] in
  let y = [|y0; y1|] in
  let _ = _adjust_range h x `X in
  let _ = _adjust_range h y `Y in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let r, g, b = if color = (-1,-1,-1) then p.fgcolor else color in
  let old_pensize = h.pensize in
  let f = (fun () ->
    let r', g', b' = plgcol0 1 in
    let _ = plscol0 1 r g b; plcol0 1 in
    let _ = if line_width > (-1.) then plwidth line_width in
    let _ = match line_style > 0 && line_style < 9 with
      | true  -> pllsty line_style; pljoin x0 y0 x1 y1
      | false -> ()
    in
    (* restore original settings *)
    let _ = plwidth old_pensize in
    let _ = pllsty 1 in
    plscol0 1 r' g' b'; plcol0 1
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  if not h.holdon then output h

(* TODO *)
let plot_multi = None

let _draw_error_bar ?(w=0.) x y e =
  let open Plplot in
  let w = w /. 2. in
  (* draw vertical line *)
  let x' = [|x; x|] in
  let y' = [|y-.e; y+.e|] in
  let _ = plline x' y' in
  (* draw upper bar *)
  let x' = [|x-.w; x+.w|] in
  let y' = [|y+.e; y+.e|] in
  let _ = plline x' y' in
  (* draw lower line *)
  let x' = [|x-.w; x+.w|] in
  let y' = [|y-.e; y-.e|] in
  let _ = plline x' y' in ()

let error_bar ?(h=_default_handle) ?(color=(-1,-1,-1)) ?(line_style=1) ?(line_width=(-1.)) x y e =
  let open Plplot in
  let ymin = Owl_dense_matrix.D.(min(y - e)) in
  let ymax = Owl_dense_matrix.D.(max(y + e)) in
  let x = Owl_dense_matrix.D.to_array x in
  let y = Owl_dense_matrix.D.to_array y in
  let e = Owl_dense_matrix.D.to_array e in
  let _ = _adjust_range h x `X in
  let _ = _adjust_range h [|ymin; ymax|] `Y in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let r, g, b = if color = (-1,-1,-1) then p.fgcolor else color in
  let old_pensize = h.pensize in
  let w = let a, b = Owl_stats.minmax x in (a -. b) *. 0.02 in
  let f = (fun () ->
    let r', g', b' = plgcol0 1 in
    let _ = plscol0 1 r g b; plcol0 1 in
    let _ = if line_width > (-1.) then plwidth line_width in
    let _ = pllsty line_style in
    let _ = Owl_utils.array_iter3 (fun x0 y0 e0 ->
      _draw_error_bar ~w x0 y0 e0
    ) x y e in
    (* restore original settings *)
    let _ = plwidth old_pensize in
    let _ = pllsty 1 in
    plscol0 1 r' g' b'; plcol0 1
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  if not h.holdon then output h

let _draw_whiskers_box w x y =
  let open Plplot in
  let ymed, y1st, y3rd = Owl_stats.(median y, first_quartile y, third_quartile y) in
  let w = w /. 2. in
  let x' = [|x-.w; x-.w; x+.w; x+.w; x-.w|] in
  let y' = [|y1st; y3rd; y3rd; y1st; y1st|] in
  let _ = pllsty 1; plline x' y' in
  let x' = [|x-.w; x+.w|] in
  let y' = [|ymed; ymed|] in
  let _ = pllsty 1; plline x' y' in
  let ymin, ymax = Owl_stats.minmax y in
  let x' = [|x; x|] in
  let y' = [|ymin; y1st|] in
  let _ = pllsty 1; plline x' y' in
  let x' = [|x; x|] in
  let y' = [|y3rd; ymax|] in
  let _ = pllsty 1; plline x' y' in ()

let boxplot ?(h=_default_handle) ?(color=(-1,-1,-1)) y =
  let open Plplot in
  let m, _ = Owl_dense_matrix.D.shape y in
  let x = Array.init m (fun i -> float_of_int i +. 1.) in
  let xmin, xmax = Owl_stats.minmax x in
  let w = 0.4 in
  let y0 = Owl_dense_matrix.D.to_array y in
  let y1 = Owl_dense_matrix.D.to_arrays y in
  let _ = _adjust_range h [|xmin-.w; xmax+.w|] `X in
  let _ = _adjust_range h ~margin:0.1 y0 `Y in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let r, g, b = if color = (-1,-1,-1) then p.fgcolor else color in
  let f = (fun () ->
    let r', g', b' = plgcol0 1 in
    let _ = plscol0 1 r g b; plcol0 1 in
    Owl_utils.array_iter2 (fun x' y' -> _draw_whiskers_box w x' y') x y1;
    (* restore original settings *)
    plscol0 1 r' g' b'; plcol0 1;
    pllsty 1
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  if not h.holdon then output h

let _draw_bar w x0 y0 =
  let open Plplot in
  let x = [|x0-.w; x0-.w; x0+.w; x0+.w|] in
  let y = [|0.; y0; y0; 0.|] in
  let _ = plfill x y in
  let _ = pllsty 1; plline x y in ()

let draw_rect ?(h=_default_handle) ?(color=(-1,-1,-1)) ?(line_style=1) ?(fill_pattern=0) x0 y0 x1 y1 =
  let open Plplot in
  let x = [|x0; x0; x1; x1|] in
  let y = [|y1; y0; y0; y1|] in
  let _ = _adjust_range h x `X in
  let _ = _adjust_range h y `Y in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let r, g, b = if color = (-1,-1,-1) then p.fgcolor else color in
  let f = (fun () ->
    let r', g', b' = plgcol0 1 in
    let _ = plscol0 1 r g b; plcol0 1 in
    let _ = pllsty line_style in
    let _ = plpsty fill_pattern in
    let _ = plfill x y in
    (* restore original settings *)
    plscol0 1 r' g' b'; plcol0 1;
    pllsty 1
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  if not h.holdon then output h

let bar ?(h=_default_handle) ?(color=(-1,-1,-1)) ?(line_style=1) ?(fill_pattern=0) y =
  let open Plplot in
  let w = 0.4 in
  let y = Owl_dense_matrix.D.to_array y in
  let x = Array.mapi (fun i _ -> float_of_int i +. 1.) y in
  let xmin, xmax = Owl_stats.minmax x in
  let _ = _adjust_range h [|xmin-.w; xmax+.w|] `X in
  let _ = _adjust_range h y `Y in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = if color = (-1,-1,-1) then p.fgcolor else color in
  let r, g, b = color in
  let f = (fun () ->
    let r', g', b' = plgcol0 1 in
    let _ = plscol0 1 r g b; plcol0 1 in
    let _ = pllsty line_style in
    let _ = plpsty fill_pattern in
    Owl_utils.array_iter2 (fun x0 y0 -> _draw_bar w x0 y0) x y;
    (* restore original settings *)
    plscol0 1 r' g' b'; plcol0 1;
    pllsty 1
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  (* add legend item to page *)
  _add_legend_item p BOX line_style color "" color fill_pattern color;
  if not h.holdon then output h

let area ?(h=_default_handle) ?(color=(-1,-1,-1)) ?(line_style=1) ?(fill_pattern=0) x y=
  let open Plplot in
  let x = Owl_dense_matrix.D.to_array x in
  let y = Owl_dense_matrix.D.to_array y in
  let xmin, xmax = Owl_stats.minmax x in
  let x = Array.(append (append [|xmin|] x) [|xmax|]) in
  let y = Array.(append (append [|0.|] y) [|0.|]) in
  let _ = _adjust_range h x `X in
  let _ = _adjust_range h y `Y in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = if color = (-1,-1,-1) then p.fgcolor else color in
  let r, g, b = color in
  let f = (fun () ->
    let r', g', b' = plgcol0 1 in
    let _ = plscol0 1 r g b; plcol0 1 in
    let _ = pllsty line_style in
    let _ = plline x y in
    let _ = plpsty fill_pattern in
    let _ = plfill x y in
    (* restore original settings *)
    plscol0 1 r' g' b'; plcol0 1;
    pllsty 1
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  (* add legend item to page *)
  _add_legend_item p BOX line_style color "" color fill_pattern color;
  if not h.holdon then output h

let _ecdf_interleave x i =
  let m = Array.length x in
  let n = 2 * m in
  let y = Array.make n 0. in
  let _ = Array.iteri (fun j z ->
    let k = 2 * j + i in
    if k < n then y.(k) <- z;
    if k < n - 1 then y.(k + 1) <- z
  ) x
  in y

let ecdf ?(h=_default_handle) ?(color=(-1,-1,-1)) ?(line_style=1) ?(line_width=(-1.)) x =
  let x0 = Owl_dense_matrix.D.to_array x in
  let x, y = Owl_stats.ecdf x0 in
  let x = _ecdf_interleave x 0 in
  let y = _ecdf_interleave y 1 in
  let n = Array.length x in
  let x = Owl_dense_matrix.D.of_array x n 1 in
  let y = Owl_dense_matrix.D.of_array y n 1 in
  plot ~h ~color ~line_style ~line_width x y

let stairs ?(h=_default_handle) ?(color=(-1,-1,-1)) ?(line_style=1) ?(line_width=(-1.)) x y =
  let x = Owl_dense_matrix.D.to_array x in
  let y = Owl_dense_matrix.D.to_array y in
  let x = _ecdf_interleave x 0 in
  let a = y.(0) in
  let y = _ecdf_interleave y 1 in
  let _ = y.(0) <- a in
  let n = Array.length x in
  let x = Owl_dense_matrix.D.of_array x n 1 in
  let y = Owl_dense_matrix.D.of_array y n 1 in
  plot ~h ~color ~line_style ~line_width x y

let draw_circle ?(h=_default_handle) ?(color=(-1,-1,-1)) ?(line_style=1) ?(line_width=(-1.)) ?(fill_pattern=0) x y rr =
  let open Plplot in
  let n = 1000 in
  let theta = (2. *. Owl_maths.pi) /. (float_of_int n) in
  let x' = Array.init (n + 1) (fun i -> x +. Owl_maths.(sin (float_of_int i *. theta)) *. rr) in
  let y' = Array.init (n + 1) (fun i -> y +. Owl_maths.(cos (float_of_int i *. theta)) *. rr) in
  let _ = _adjust_range h ~margin:0.05 x' `X in
  let _ = _adjust_range h ~margin:0.05 y' `Y in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let r, g, b = if color = (-1,-1,-1) then p.fgcolor else color in
  let old_pensize = h.pensize in
  let f = (fun () ->
    let r', g', b' = plgcol0 1 in
    let _ = plscol0 1 r g b; plcol0 1 in
    let _ = if line_width > (-1.) then plwidth line_width in
    let _ = pllsty line_style in
    let _ = plpsty fill_pattern in
    let _ = plfill x' y' in
    let _ = plline x' y' in
    (* restore original settings *)
    plscol0 1 r' g' b'; plcol0 1;
    plwidth old_pensize;
    pllsty 1
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  if not h.holdon then output h

let _draw_arc fill n x =
  let open Plplot in
  let a = 2. *. Owl_maths.pi in
  let theta = a /. n in
  let i = ref 0. in
  Array.iter (fun y ->
    let c = n *. y in
    let x' = Array.init (int_of_float c + 1) (fun j -> Owl_maths.(sin ((float_of_int j +. !i) *. theta))) in
    let y' = Array.init (int_of_float c + 1) (fun j -> Owl_maths.(cos ((float_of_int j +. !i) *. theta))) in
    let x' = Array.(append [|0.|] x') in
    let y' = Array.(append [|0.|] y') in
    let _ = plline x' y' in
    i := !i +. c;
  ) x

let pie ?(h=_default_handle) ?(color=(-1,-1,-1)) ?(fill=false) x =
  let open Plplot in
  let _ = _adjust_range h ~margin:0.1 [|-1.; 1.|] `X in
  let _ = _adjust_range h ~margin:0.1 [|-1.; 1.|] `Y in
  let x = Owl_dense_matrix.D.to_array x in
  let x = Owl_stats.normlise_pdf x in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let r, g, b = if color = (-1,-1,-1) then p.fgcolor else color in
  let old_pensize = h.pensize in
  let f = (fun () ->
    let r', g', b' = plgcol0 1 in
    let _ = plscol0 1 r g b; plcol0 1 in
    let _ = plwidth 1. in
    let _ = pllsty 1 in
    let _ = plpsty 0 in
    let _ = _draw_arc fill 1000. x in
    (* restore original settings *)
    plscol0 1 r' g' b'; plcol0 1;
    plwidth old_pensize;
    pllsty 1
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  if not h.holdon then output h

let surf ?(h=_default_handle) ?(contour=false) ?altitude ?azimuth x y z =
  let open Plplot in
  let x = Owl_dense_matrix.D.to_array x in
  let y = Owl_dense_matrix.D.(transpose y |> to_array) in
  let z0 = Owl_dense_matrix.D.to_arrays z in
  let z1 = Owl_dense_matrix.D.to_array z in
  let _ = _adjust_range h x `X in
  let _ = _adjust_range h y `Y in
  let _ = _adjust_range h z1 `Z in
  (* construct contour level *)
  let zmin, zmax = Owl_stats.minmax z1 in
  let clvl = Owl_dense_matrix.D.(linspace zmin zmax 10 |> to_array) in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let _ = p.is_3d <- true in
  let _ = match altitude with None -> () | Some a -> p.altitude <- a in
  let _ = match azimuth with None -> () | Some a -> p.azimuth <- a in
  let opt = match contour with
    | true  -> [ PL_FACETED; PL_MAG_COLOR; PL_BASE_CONT; PL_SURF_CONT ]
    | false -> [ PL_FACETED; PL_MAG_COLOR ]
  in
  let f = (fun () ->
    plsurf3d x y z0 opt clvl;
    (* restore original settings, if any *)
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  if not h.holdon then output h

let plot3d = surf

let mesh ?(h=_default_handle) ?(contour=false) ?altitude ?azimuth x y z =
  let open Plplot in
  let x = Owl_dense_matrix.D.to_array x in
  let y = Owl_dense_matrix.D.(transpose y |> to_array) in
  let z0 = Owl_dense_matrix.D.to_arrays z in
  let z1 = Owl_dense_matrix.D.to_array z in
  let _ = _adjust_range h x `X in
  let _ = _adjust_range h y `Y in
  let _ = _adjust_range h z1 `Z in
  (* construct contour level *)
  let zmin, zmax = Owl_stats.minmax z1 in
  let clvl = Owl_dense_matrix.D.(linspace zmin zmax 10 |> to_array) in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let _ = p.is_3d <- true in
  let _ = match altitude with None -> () | Some a -> p.altitude <- a in
  let _ = match azimuth with None -> () | Some a -> p.azimuth <- a in
  let opt0 = [ PL_DRAW_LINEXY; PL_MAG_COLOR; PL_MESH; PL_BASE_CONT; PL_SURF_CONT ] in
  let opt1 = [ PL_DRAW_LINEXY; PL_MAG_COLOR; PL_MESH ] in
  let f = (fun () ->
    match contour with
    | true  -> plmeshc x y z0 opt0 clvl
    | false -> plmesh x y z0 opt1
    (* restore original settings, if any *)
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  if not h.holdon then output h

let heatmap ?(h=_default_handle) x y z =
  let open Plplot in
  let x = Owl_dense_matrix.D.to_array x in
  let y = Owl_dense_matrix.D.(transpose y |> to_array) in
  let z0 = Owl_dense_matrix.D.to_arrays z in
  let z1 = Owl_dense_matrix.D.to_array z in
  let _ = _adjust_range h x `X in
  let _ = _adjust_range h y `Y in
  let _ = _adjust_range h z1 `Z in
  (* construct contour level *)
  let xmin, xmax = Owl_stats.minmax x in
  let ymin, ymax = Owl_stats.minmax y in
  let zmin, zmax = Owl_stats.minmax z1 in
  let clvl = Owl_dense_matrix.D.(linspace zmin zmax 10 |> to_array) in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let f = (fun () ->
    plshades z0 xmin xmax ymin ymax clvl 1.0 0 1.0 false
    (* restore original settings, if any *)
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  if not h.holdon then output h

(* FIXME: something wrong with Plplot callback function. The contour function
  may cause segmentation fault. I suspect plset_pltr and plunset_pltr functions. *)
let contour ?(h=_default_handle) x y z =
  let open Plplot in
  let m, n = Owl_dense_matrix.D.shape x in
  let x0 = Owl_dense_matrix.D.to_arrays x in
  let x1 = Owl_dense_matrix.D.to_array x in
  let y0 = Owl_dense_matrix.D.to_arrays y in
  let y1 = Owl_dense_matrix.D.to_array y in
  let z0 = Owl_dense_matrix.D.to_arrays z in
  let z1 = Owl_dense_matrix.D.to_array z in
  let _ = _adjust_range h x1 `X in
  let _ = _adjust_range h y1 `Y in
  (* construct contour level *)
  let zmin, zmax = Owl_stats.minmax z1 in
  let clvl = Owl_dense_matrix.D.(linspace zmin zmax 10 |> to_array) in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let f = (fun () ->
    plset_pltr (pltr2 x0 y0);
    plcont z0 1 m 1 n clvl;
    plunset_pltr ()
    (* restore original settings, if any *)
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  if not h.holdon then output h

let _draw_extended_line x0 y0 x1 y1 l r u d =
  (* Specify two points, draw a line between them, and extend on both ends with dash line *)
  let open Plplot in
  let x0, y0, x1, y1 = if x0 > x1 then x1, y1, x0, y0 else x0, y0, x1, y1 in
  let yl = if x0 = x1 then u else y0 -. (y1 -. y0) /. (x1 -. x0) *. (x0 -. l) in
  let yr = if x0 = x1 then d else y1 +. (y1 -. y0) /. (x1 -. x0) *. (r -. x1) in
  let xl = if x0 = x1 then x0 else l in
  let xr = if x0 = x1 then x0 else r in
  let _ = pllsty 1; pljoin x0 y0 x1 y1 in
  let _ = pllsty 3; pljoin xl yl x0 y0 in
  let _ = pllsty 3; pljoin x1 y1 xr yr in ()

let probplot ?(h=_default_handle) ?(marker="#[0x002b]") ?(color=(-1, -1, -1)) ?(marker_size = 3.) ?(dist=(fun q -> Owl_stats.Cdf.gaussian_Pinv q 1.)) ?(noref=false) x =

    (* TODO: show y-axis as probability instead of invcdf; Choose suitable yticks for different distribution; support for censor data, frequency *)

    (* Inputs *)
    let open Plplot in
    let x = Owl_dense_matrix.D.to_array x |> Owl_stats.sort ~inc:true in
    let y = let n = Array.length x in
            let qth = Owl_dense_matrix.D.linspace ((1. -. 0.5) /. float_of_int n)
                (( float_of_int n-. 0.5) /. float_of_int n) n in
            let q = Owl_dense_matrix.D.map dist qth in
            Owl_dense_matrix.D.to_array q
    in
    let _ = _adjust_range h x `X in
    let _ = _adjust_range h y `Y in
    (* Parameters to draw the reference line *)
    let p1y, p1x = (Owl_stats.first_quartile y, Owl_stats.first_quartile x) in
    let p3y, p3x = (Owl_stats.third_quartile y, Owl_stats.third_quartile x) in
    let left, right = Owl_stats.minmax x in
    let up, down = Owl_stats.minmax y in
    (* Prepare the closure *)
    let p = h.pages.(h.current_page) in
    let color = if color = (-1,-1,-1) then p.fgcolor else color in
    let r, g, b = color in
    let f = (fun () ->
        let r', g', b' = plgcol0 1 in
        let _ = plscol0 1 r g b; plcol0 1 in
        let c' = plgchr () |> fst in
        let _ = plschr marker_size 1. in
        let _ = if not noref then _draw_extended_line p1x p1y p3x p3y left right up down in
        let _ = plstring x y marker in
        (* restore original settings *)
        let _ = plschr c' 1. in
        plscol0 1 r' g' b'; plcol0 1
    ) in
    (* add closure as a layer *)
    p.plots <- Array.append p.plots [|f|];
    (* add legend item to page *)
    _add_legend_item p SCATTER 0 color marker color 0 color;
    if not h.holdon then output h

let normplot ?(h=_default_handle) ?(marker="#[0x002b]") ?(color=(-1, -1, -1)) ?(marker_size = 3.) ?(sigma=1.) x =
  (* TODO: replace yticklabels, including unseen tick labels,  with user-defined labels *)
  let dist = fun q -> Owl_stats.Cdf.gaussian_Pinv q sigma in
  probplot ~h ~marker:marker ~color:color ~marker_size:marker_size ~dist:dist x

let wblplot ?(h=_default_handle) ?(marker="#[0x002b]") ?(color=(-1, -1, -1)) ?(marker_size = 3.) ?(lambda=1.) ?(k=1.) x =
  (* inputs *)
  let open Plplot in
  let x = Owl_dense_matrix.D.to_array x |> Owl_stats.sort ~inc:true in
  (* manually change the x data to log10-based *)
  let x = Array.map Owl_maths.log10 x in
  let dist = (fun q -> Owl_stats.Cdf.weibull_Pinv q lambda k) in
  let y = let n = Array.length x in
          let qth = Owl_dense_matrix.D.linspace ((1. -. 0.5) /. float_of_int n)
              (( float_of_int n-. 0.5) /. float_of_int n) n in
          let q = Owl_dense_matrix.D.map dist qth in
          Owl_dense_matrix.D.to_array q
  in
  let _ = _adjust_range h x `X in
  let _ = _adjust_range h y `Y in
  (* Parameters to draw the reference line *)
  let p1y, p1x = (Owl_stats.first_quartile y, Owl_stats.first_quartile x) in
  let p3y, p3x = (Owl_stats.third_quartile y, Owl_stats.third_quartile x) in
  let left, right = Owl_stats.minmax x in
  let up, down = Owl_stats.minmax y in
  (* Prepare the closure; note the change to log sacle *)
  let p = h.pages.(h.current_page) in
  let _ = p.xlogscale <- true in
  let color = if color = (-1,-1,-1) then p.fgcolor else color in
  let r, g, b = color in
  let f = (fun () ->
    let r', g', b' = plgcol0 1 in
    let _ = plscol0 1 r g b; plcol0 1 in
    let c' = plgchr () |> fst in
    let _ = plschr marker_size 1. in
    let _ = _draw_extended_line p1x p1y p3x p3y left right up down in
    let _ = plstring x y marker in
    (* restore original settings *)
    let _ = plschr c' 1. in
    plscol0 1 r' g' b'; plcol0 1
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  (* add legend item to page *)
  _add_legend_item p SCATTER 0 color marker color 0 color;
  if not h.holdon then output h

let _ecdf_dist a b p =
  (*Find the ecdf value of probability value p; (a, b) is the output of Stats.ecdf*)
  let rec _find_rec x lst i = match lst with
    | hd::tl -> if (hd > x) then i - 1  else _find_rec x tl (i+1)
    | _ -> (Array.length b) - 1
  in
  let ticks = Array.to_list b in
  let i = _find_rec p ticks 1 in
  a.(i)

let qqplot ?(h=_default_handle) ?(color=(-1,-1,-1)) ?(marker_size=4.)
  ?(pd=(fun i -> Owl_stats.Cdf.gaussian_Pinv i 1.)) ?x y =
  (* TODO: support matrix input; add support for `pvec` argument;
    plot the larger data input on x-axis *)
  let open Plplot in
  let y = Owl_dense_matrix.D.to_array y |> Owl_stats.sort ~inc:true in
  let n = Array.length y in
  let dist = match x with
    | Some arr ->
      (* If the second argument is a vector*)
      let x = Owl_dense_matrix.D.to_array arr in
      (* The empirical CDF of it is used as dist. *)
      let a, b = Owl_stats.ecdf x in
      (fun p -> _ecdf_dist a b p)
    | None     -> pd
  in
  let qth = Owl_dense_matrix.D.linspace ((1. -. 0.5) /. float_of_int n)
      (( float_of_int n-. 0.5) /. float_of_int n) n in
  let q = Owl_dense_matrix.D.map dist qth in
  let x = Owl_dense_matrix.D.to_array q in
  (*draw the figure*)
  let _ = _adjust_range h x `X in
  let _ = _adjust_range h y `Y in
  (* default settings *)
  let marker = "#[0x002b]" in
  (* Parameters to draw the reference line *)
  let p1y, p1x = (Owl_stats.first_quartile y, Owl_stats.first_quartile x) in
  let p3y, p3x = (Owl_stats.third_quartile y, Owl_stats.third_quartile x) in
  let left, right = Owl_stats.minmax x in
  let up, down = Owl_stats.minmax y in
  (* Prepare the closure *)
  let p = h.pages.(h.current_page) in
  let color = if color = (-1,-1,-1) then p.fgcolor else color in
  let r, g, b = color in
  let f = (fun () ->
      let r', g', b' = plgcol0 1 in
      let _ = plscol0 1 r g b; plcol0 1 in
      let c' = plgchr () |> fst in
      let _ = plschr marker_size 1. in
      let _ = _draw_extended_line p1x p1y p3x p3y left right up down in
      let _ = plstring x y marker in
      (* restore original settings *)
      let _ = plschr c' 1. in
      plscol0 1 r' g' b'; plcol0 1
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  (* add legend item to page *)
  _add_legend_item p SCATTER 0 color marker color 0 color;
  if not h.holdon then output h

(* TODO *)

let scatterhist = None

(* other plots *)

let image x = None

(* ends here *)
