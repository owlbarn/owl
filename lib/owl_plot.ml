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

type color = RED | GREEN | BLUE

type plot_typ = {
  mutable holdon : bool;
  mutable output : string;
  mutable title : string;
  mutable bgcolor : int * int * int;
  mutable fgcolor : int * int * int;
  mutable fontsize : float;
  mutable marker_style : int;
  mutable marker_size : float;
  mutable line_color : int * int * int;
  (* control axises *)
  mutable xlabel : string;
  mutable ylabel : string;
  mutable zlabel : string;
  mutable xrange : float * float;
  mutable yrange : float * float;
  mutable zrange : float * float;
  mutable auto_xrange : bool;
  mutable auto_yrange : bool;
  mutable auto_zrange : bool;
  (* control the sub plots *)
  mutable shape : int * int;
  mutable pages : plot_typ array;
  mutable current_page : int;
  (* cache the plot operations *)
  mutable plots : (unit -> unit) array;
}

(* module functions to simplify plotting *)

let _create () = {
  holdon = true;
  output = "";
  title = "";
  xlabel = "x";
  ylabel = "y";
  zlabel = "z";
  xrange = (infinity, neg_infinity);
  yrange = (infinity, neg_infinity);
  zrange = (infinity, neg_infinity);
  bgcolor = (0, 0, 0);
  fgcolor = (255, 0, 0);
  fontsize = -1.;
  marker_style = 2;
  marker_size = -1.;
  line_color = Plplot.plgcol0 1;
  auto_xrange = true;
  auto_yrange = true;
  auto_zrange = true;
  plots = [||];
  shape = (1, 1);
  current_page = 0;
  pages = [||];
}

let create ?(m=1) ?(n=1) s =
  let pages = match (m * n) > 1 with
    | true  -> Array.make (m * n) None |> Array.map (fun _ -> _create ())
    | false -> [||]
  in
  let h = _create () in
  let _ = h.shape <- (m, n) in
  let _ = h.pages <- pages in
  let _ = h.output <- s in h

let _default_handle =
  let h = _create () in
  let _ = h.holdon <- false in h

let _supported_device = ["aqt"; "pdf"; "ps"; "psc"; "png"; "svg"; "xfig"]

let _set_device h =
  try let x = Owl_utils.get_suffix h.output in
    plsdev x;
    plsfnam h.output;
  with exn -> ()

let _initialise h =
  (* configure before init *)
  let _ = _set_device h in
  let _ = (let r, g, b = h.bgcolor in plscolbg r g b) in
  (* init the plot *)
  let m, n = h.shape in
  let _ = if not (h.shape = (1,1)) then plssub m n in
  let _ = plinit () in
  (* configure after init *)
  let _ = (let r, g, b = h.fgcolor in plscol0 1 r g b; plcol0 1) in
  let _ = if h.fontsize > 0. then plschr h.fontsize 1.0 in
  let _ = if h.marker_size > 0. then plssym h.marker_size 1. in
  let g h' = (
    let xmin, xmax = h'.xrange in
    let ymin, ymax = h'.yrange in
    let _ = plenv xmin xmax ymin ymax 0 0 in
    let _ = pllab h.xlabel h'.ylabel h'.title in ()
  ) in
  match h.shape = (1, 1) with
  | true  -> g h
  | false -> Array.iteri (fun i h' -> if i > 0 then Plplot.pladv i; g h') h.pages

let _finalise () = plend ()

let output h =
  let _  = h.holdon <- false in
  let _  = _initialise h in
  let _  = match h.shape = (1, 1) with
    | true  -> Array.iter (fun f -> f ()) h.plots
    | false -> Array.iteri (fun i h' ->
        if i > 0 then Plplot.pladv i;
        Array.iter (fun f -> f ()) h'.plots
      ) h.pages
  in
  _finalise ()

let set_output h s =
  let x = Owl_utils.get_suffix s in
  match (List.mem x _supported_device) with
  | true  -> h.output <- s
  | false -> Log.error "unsupported file type."

let set_title h s = h.title <- s

let set_xlabel h s = h.xlabel <- s

let set_ylabel h s = h.ylabel <- s

let set_zlabel h s = h.zlabel <- s

let set_xrange h a b = h.auto_xrange <- false; h.xrange <- (a, b)

let set_yrange h a b = h.auto_yrange <- false; h.yrange <- (a, b)

let set_zrange h a b = h.auto_zrange <- false; h.zrange <- (a, b)

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

let set_line_color h r g b = h.line_color <- (r, g, b)

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

(* TODO *)
let rgb = None

let text ?(h=_default_handle) x y ?(dx=0.) ?(dy=0.) s =
  let open Plplot in
  (* prepare the closure *)
  let f = (fun () ->
    plptex x y dx dy 0. s
  ) in
  (* add closure as a layer *)
  let _ = h.plots <- Array.append h.plots [|f|] in
  if not h.holdon then output h

let _union_range r x =
  let a, b = r in
  let m, n = Owl_stats.minmax x in
  let c = if a < m then a else m in
  let d = if b > n then b else n in
  c, d

let _adjust_range h d axis =
  match axis with
  | `X -> if h.auto_xrange then h.xrange <- _union_range h.xrange d
  | `Y -> if h.auto_yrange then h.yrange <- _union_range h.yrange d
  | `Z -> if h.auto_zrange then h.zrange <- _union_range h.zrange d

let plot ?(h=_default_handle) x y =
  let open Plplot in
  let x = MX.to_array x in
  let y = MX.to_array y in
  let _ = _adjust_range h x `X in
  let _ = _adjust_range h y `Y in
  (* prepare the closure *)
  let r, g, b = h.line_color in
  let f = (fun () ->
    let r', g', b' = plgcol0 1 in
    let _ = plscol0 1 r g b; plcol0 1 in
    let _ = plline x y in
    plscol0 1 r' g' b'; plcol0 1
  ) in
  (* add closure as a layer *)
  let _ = match h.shape = (1, 1) with
    | true  -> h.plots <- Array.append h.plots [|f|]
    | false -> (
        let h' = h.pages.(h.current_page) in
        h'.plots <- Array.append h'.plots [|f|]
      )
  in
  if not h.holdon then output h

let plot_fun ?(h=_default_handle) f a b =
  let x = MX.linspace a b 100 in
  let y = MX.map f x in
  plot ~h x y

let scatter ?(h=_default_handle) x y =
  let open Plplot in
  let x = MX.to_array x in
  let y = MX.to_array y in
  let _ = _adjust_range h x `X in
  let _ = _adjust_range h y `Y in
  (* prepare the closure *)
  let marker_style = h.marker_style in
  let marker_size = h.marker_size in
  let f = (fun () ->
    plssym marker_size 1.;
    plpoin x y marker_style
  ) in
  (* add closure as a layer *)
  let _ = match h.shape = (1, 1) with
    | true  -> h.plots <- Array.append h.plots [|f|]
    | false -> (
        let h' = h.pages.(h.current_page) in
        h'.plots <- Array.append h'.plots [|f|]
      )
  in
  if not h.holdon then output h

let histogram ?(h=_default_handle) ?(bin=10) x =
  let open Plplot in
  let x = MX.to_array x in
  let _ = _adjust_range h x `X in
  let xmin, xmax = Owl_stats.minmax x in
  let ymin, ymax = 0., Owl_stats.(histogram x bin |> Array.map float_of_int |> max)  *. 1.1 in
  let _ = _adjust_range h [|xmin; xmax|] `X in
  let _ = _adjust_range h [|ymin; ymax|] `Y in
  (* prepare the closure *)
  let f = (fun () ->
    plhist x xmin xmax bin [ PL_HIST_DEFAULT; PL_HIST_NOSCALING ]
  ) in
  (* add closure as a layer *)
  let _ = match h.shape = (1, 1) with
    | true  -> h.plots <- Array.append h.plots [|f|]
    | false -> (
        let h' = h.pages.(h.current_page) in
        h'.plots <- Array.append h'.plots [|f|]
      )
  in
  if not h.holdon then output h

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

let subplot h i j =
  let open Plplot in
  let m, n = h.shape in
  let c = m * i + j in
  h.current_page <- c


(* TODO *)
let stem = None
