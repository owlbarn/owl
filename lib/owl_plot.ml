(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Graphical Module ]  *)

open Plplot

module MX = Owl_dense

(* types in plot module *)

type dsmat = Owl_dense.dsmat

type marker_typ = SQUARE | DOT | PLUS | STAR | CIRCLE | CROSS | UPTRI | DIAMOND | PENTAGON

type plot_typ = {
  mutable output : string;
  mutable title : string;
  mutable xlabel : string;
  mutable ylabel : string;
  mutable zlabel : string;
  mutable xrange : float option * float option;
  mutable yrange : float option * float option;
  mutable zrange : float option * float option;
  mutable bgcolor : int * int * int;
  mutable fgcolor : int * int * int;
  mutable fontsize : float;
  mutable marker_style : int;
  mutable marker_size : float;
}

(* module functions to simplify plotting *)

let create () = {
  output = "";
  title = "";
  xlabel = "x";
  ylabel = "y";
  zlabel = "z";
  xrange = (None, None);
  yrange = (None, None);
  zrange = (None, None);
  bgcolor = (0, 0, 0);
  fgcolor = (255, 0, 0);
  fontsize = -1.;
  marker_style = 2;
  marker_size = -1.;
}

let _default_handle = create ()

let _supported_device = ["aqt"; "pdf"; "ps"; "psc"; "png"; "svg"; "xfig"]

let _set_device h =
  try let x = Owl_utils.get_suffix h.output in
    plsdev x;
    plsfnam h.output;
  with exn -> ()

let _update_range r x =
  match r with
  | Some a, None -> a, Owl_stats.max x
  | None, Some b -> Owl_stats.min x, b
  | Some a, Some b -> a, b
  | None, None -> Owl_stats.minmax x

let _initialise h x y=
  (* configure before init *)
  let _ = _set_device h in
  (* init the plot *)
  let _ = plinit () in
  (* configure after init *)
  let _ = (let r, g, b = h.bgcolor in plscolbg r g b) in
  let _ = (let r, g, b = h.fgcolor in plscol0 1 r g b; plcol0 1) in
  let _ = if h.fontsize > 0. then plschr h.fontsize 1.0 in
  let xmin, xmax = _update_range h.xrange x in
  let ymin, ymax = _update_range h.yrange y in
  let _ = plenv xmin xmax ymin ymax 0 0 in
  let _ = pllab h.xlabel h.ylabel h.title in ()

let _finalise h =
  plend ()

let set_output h s =
  let x = Owl_utils.get_suffix s in
  match (List.mem x _supported_device) with
  | true  -> h.output <- s
  | false -> Log.error "unsupported file type."

let set_title h s = h.title <- s

let set_xlabel h s = h.xlabel <- s

let set_ylabel h s = h.ylabel <- s

let set_zlabel h s = h.zlabel <- s

let set_xrange h a b = h.xrange <- (a, b)

let set_yrange h a b = h.yrange <- (a, b)

let set_zrange h a b = h.zrange <- (a, b)

let set_foreground_color h r g b = h.fgcolor <- (r, g, b)

let set_background_color h r g b = h.bgcolor <- (r, g, b)

let set_font_size h x = h.fontsize <- x

let set_marker_style h x =
  let m = match x with
    | SQUARE   -> 0
    | DOT      -> 1
    | PLUS     -> 2
    | STAR     -> 3
    | CIRCLE   -> 4
    | CROSS    -> 5
    | UPTRI    -> 7
    | DIAMOND  -> 11
    | PENTAGON -> 12
  in h.marker_style <- m

let set_marker_size h x = h.marker_size <- x

(* TODO *)
let set_line_style = None

(* TODO *)
let set_line_size = None

(* TODO *)
let set_plot_size = None

(* TODO *)
let legend_on = None

(* TODO *)
let legend_off = None

let _plot_line = None

let plot ?(h=_default_handle) x y =
  let open Plplot in
  let x = MX.to_array x in
  let y = MX.to_array y in
  (* configure before init *)
  let _ = _set_device h in
  (* init the plot *)
  let _ = plinit () in
  (* configure after init *)
  let _ = (let r, g, b = h.bgcolor in plscolbg r g b) in
  let _ = (let r, g, b = h.fgcolor in plscol0 1 r g b; plcol0 1) in
  let _ = if h.fontsize > 0. then plschr h.fontsize 1.0 in
  let _ = if h.marker_size > 0. then plssym h.marker_size 1. in
  let xmin, xmax = _update_range h.xrange x in
  let ymin, ymax = _update_range h.yrange y in
  let _ = plenv xmin xmax ymin ymax 0 0 in
  let _ = pllab h.xlabel h.ylabel h.title in
  (* plot *)
  let _ = plline x y in
  plend ()

let plot_fun ?(h=_default_handle) f a b =
  let x = MX.linspace a b 100 in
  let y = MX.map f x in
  plot ~h x y

let scatter ?(h=_default_handle) x y =
  let open Plplot in
  let x = MX.to_array x in
  let y = MX.to_array y in
  (* configure before init *)
  let _ = _set_device h in
  (* init the plot *)
  let _ = plinit () in
  (* configure after init *)
  let _ = (let r, g, b = h.bgcolor in plscolbg r g b) in
  let _ = (let r, g, b = h.fgcolor in plscol0 1 r g b; plcol0 1) in
  let _ = if h.fontsize > 0. then plschr h.fontsize 1. in
  let _ = if h.marker_size > 0. then plssym h.marker_size 1. in
  let xmin, xmax = _update_range h.xrange x in
  let ymin, ymax = _update_range h.yrange y in
  let _ = plenv xmin xmax ymin ymax 0 0 in
  let _ = pllab h.xlabel h.ylabel h.title in
  (* plot *)
  let _ = plpoin x y h.marker_style in
  plend ()

let histogram ?(h=_default_handle) ?(bin=10) x =
  let open Plplot in
  let x = MX.to_array x in
  (* configure before init *)
  let _ = _set_device h in
  (* init the plot *)
  let _ = plinit () in
  (* configure after init *)
  let _ = (let r, g, b = h.bgcolor in plscolbg r g b) in
  let _ = (let r, g, b = h.fgcolor in plscol0 1 r g b; plcol0 1) in
  let _ = if h.fontsize > 0. then plschr h.fontsize 1.0 in
  let _ = if h.marker_size > 0. then plssym h.marker_size 1. in
  let xmin, xmax = _update_range h.xrange x in
let _ = plenv xmin xmax 0. 5000. 0 0 in
  (* plot *)
  let _ = plhist x xmin xmax bin [ PL_HIST_DEFAULT; PL_HIST_NOSCALING ] in
  let _ = pllab h.xlabel h.ylabel h.title in
  plend ()

(* FIXME: the labels will not show *)
let mesh ?(h=_default_handle) x y z =
  let open Plplot in
  let x = MX.to_array x in
  let y = MX.(transpose y |> to_array) in
  let xmin, xmax = Owl_stats.minmax x in
  let ymin, ymax = Owl_stats.minmax y in
  let zmin, zmax, _, _, _, _ = MX.minmax z in
  let _ = _set_device h in
  let _ = plinit () in
  let _ = pladv 0 in
  let _ = plvpor 0.0 1.0 0.0 1.0 in
  let _ = plwind (-1.0) 1.0 (-1.0) 1.5 in
  let _ = plw3d 1.0 1.0 1.0 xmin xmax ymin ymax zmin zmax 33. 115. in
  let _ = plbox3  "bnstu", "x axis", 0.0, 0,
                  "bnstu", "y axis", 0.0, 0,
                  "bcdmnstuv", "z axis", 0.0, 4 in
  let z = MX.to_arrays z in
  let _ = plmesh x y z [ PL_DRAW_LINEXY; PL_MAG_COLOR; PL_MESH ] in
  let _ = plmtex "t" 1.0 1.0 0.5 h.title in
  plend ()

(* TODO *)
let stem = None
