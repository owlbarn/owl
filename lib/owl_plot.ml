(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Graphical Module ]  *)

(* types in plot module *)

type dsmat = Owl_dense.dsmat

type color = RED | GREEN | BLUE

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
  (* control grids *)
  mutable xgrid : bool;
  mutable ygrid : bool;
  mutable zgrid : bool;
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
  xgrid = false;
  ygrid = false;
  zgrid = false;
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

let _prepare_page p =
  let open Plplot in
  (* configure an individual page *)
  let _ = (let r, g, b = p.fgcolor in plscol0 1 r g b; plcol0 1) in
  let _ = if p.fontsize > 0. then plschr p.fontsize 1.0 in
  let xmin, xmax = p.xrange in
  let ymin, ymax = p.yrange in
  let zmin, zmax = p.zrange in
  if not p.is_3d then
    (* prepare a 2D plot *)
    let _ = plenv xmin xmax ymin ymax 0 0 in
    let _ = pllab p.xlabel p.ylabel p.title in ()
  else
    (* prepare a 3D plot *)
    let _ = pladv 0 in
    let _ = plvpor 0.0 1.0 0.0 1.0 in
    let _ = plwind (-1.0) 1.0 (-1.0) 1.5 in
    let _ = plw3d 1.0 1.0 1.0 xmin xmax ymin ymax zmin zmax 33. 115. in
    let _ = plbox3  "bnstu", "x axis", 0.0, 0,
                    "bnstu", "y axis", 0.0, 0,
                    "bcdmnstuv", "z axis", 0.0, 4
    in ()

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

let set_foreground_color h r g b = (h.pages.(h.current_page)).fgcolor <- (r, g, b)

let set_background_color h r g b = h.bgcolor <- (r, g, b)

let set_font_size h x = (h.pages.(h.current_page)).fontsize <- x

let set_pen_size h x = h.pensize <- x

let set_page_size h x y = h.page_size <- (x, y)

(* TODO *)
let legend_on = None

(* TODO *)
let legend_off = None

(* TODO *)
let rgb = None

let text ?(h=_default_handle) ?(color=(-1,-1,-1)) x y ?(dx=0.) ?(dy=0.) s =
  let open Plplot in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let r, g, b = if color = (-1,-1,-1) then p.fgcolor else color in
  let f = (fun () ->
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
  let x = Owl_dense.to_array x in
  let y = Owl_dense.to_array y in
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
  if not h.holdon then output h

let plot_fun ?(h=_default_handle) ?(color=(-1,-1,-1)) ?(marker="") ?(marker_size=4.) ?(line_style=1) ?(line_width=(-1.)) f a b =
  let x = Owl_dense.linspace a b 100 in
  let y = Owl_dense.map f x in
  plot ~h ~color ~marker ~marker_size ~line_style ~line_width x y

let scatter ?(h=_default_handle) ?(color=(-1,-1,-1)) ?(marker="•") ?(marker_size=4.) x y =
  let open Plplot in
  let x = Owl_dense.to_array x in
  let y = Owl_dense.to_array y in
  let _ = _adjust_range h x `X in
  let _ = _adjust_range h y `Y in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let r, g, b = if color = (-1,-1,-1) then p.fgcolor else color in
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
  if not h.holdon then output h

let histogram ?(h=_default_handle) ?(bin=10) x =
  let open Plplot in
  let x = Owl_dense.to_array x in
  let _ = _adjust_range h x `X in
  let xmin, xmax = Owl_stats.minmax x in
  let ymin, ymax = 0., Owl_stats.(histogram x bin |> Array.map float_of_int |> max)  *. 1.1 in
  let _ = _adjust_range h [|xmin; xmax|] `X in
  let _ = _adjust_range h [|ymin; ymax|] `Y in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let f = (fun () ->
    plhist x xmin xmax bin [ PL_HIST_DEFAULT; PL_HIST_NOSCALING ]
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  if not h.holdon then output h

let subplot h i j =
  let _, n = h.shape in
  h.current_page <- (n * i + j)

let stem ?(h=_default_handle) ?(color=(-1,-1,-1)) ?(marker="#[0x2299]") ?(marker_size=4.) ?(line_style=2) ?(line_width=(-1.)) x y =
  let open Plplot in
  let x = Owl_dense.to_array x in
  let y = Owl_dense.to_array y in
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
  if not h.holdon then output h

let autocorr ?(h=_default_handle) ?(marker="•") ?(marker_size=4.) x =
  let z = Owl_dense.to_array x in
  let x' = Array.init (Array.length z) (fun i -> float_of_int i) in
  let y' = Array.mapi (fun i _ -> Owl_stats.autocorrelation ~lag:i z) x' in
  let x' = Owl_dense.of_arrays [|x'|] in
  let y' = Owl_dense.of_arrays [|y'|] in
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
  let ymin, _, _ = Owl_dense.(min(y -@ e)) in
  let ymax, _, _ = Owl_dense.(max(y +@ e)) in
  let x = Owl_dense.to_array x in
  let y = Owl_dense.to_array y in
  let e = Owl_dense.to_array e in
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
  let m, _ = Owl_dense.shape y in
  let x = Array.init m (fun i -> float_of_int i +. 1.) in
  let xmin, xmax = Owl_stats.minmax x in
  let w = 0.4 in
  let y0 = Owl_dense.to_array y in
  let y1 = Owl_dense.to_arrays y in
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
  let y = Owl_dense.to_array y in
  let x = Array.mapi (fun i _ -> float_of_int i +. 1.) y in
  let xmin, xmax = Owl_stats.minmax x in
  let _ = _adjust_range h [|xmin-.w; xmax+.w|] `X in
  let _ = _adjust_range h y `Y in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let r, g, b = if color = (-1,-1,-1) then p.fgcolor else color in
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
  if not h.holdon then output h

let area ?(h=_default_handle) ?(color=(-1,-1,-1)) ?(line_style=1) ?(fill_pattern=0) x y=
  let open Plplot in
  let x = Owl_dense.to_array x in
  let y = Owl_dense.to_array y in
  let xmin, xmax = Owl_stats.minmax x in
  let x = Array.(append (append [|xmin|] x) [|xmax|]) in
  let y = Array.(append (append [|0.|] y) [|0.|]) in
  let _ = _adjust_range h x `X in
  let _ = _adjust_range h y `Y in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let r, g, b = if color = (-1,-1,-1) then p.fgcolor else color in
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
  if not h.holdon then output h

let pie = None

let contour = None

let surf ?(h=_default_handle) x y z =
  let open Plplot in
  let x = Owl_dense.to_array x in
  let y = Owl_dense.(transpose y |> to_array) in
  let z0 = Owl_dense.to_arrays z in
  let z1 = Owl_dense.to_array z in
  let _ = _adjust_range h x `X in
  let _ = _adjust_range h y `Y in
  let _ = _adjust_range h z1 `Z in
  (* construct contour level *)
  let zmin, zmax = Owl_stats.minmax z1 in
  let clvl = Owl_dense.(linspace zmin zmax 5 |> to_array) in
  (* prepare the closure *)
  let p = h.pages.(h.current_page) in
  let _ = p.is_3d <- true in
  let f = (fun () ->
    let _ = plsurf3d x y z0 [ PL_FACETED ] clvl in
    (* restore original settings *)
    ()
  ) in
  (* add closure as a layer *)
  p.plots <- Array.append p.plots [|f|];
  if not h.holdon then output h

let heatmap = None

(* FIXME: the labels will not show *)
let mesh ?(h=_default_handle) x y z =
  let open Plplot in
  let x = Owl_dense.to_array x in
  let y = Owl_dense.(transpose y |> to_array) in
  let xmin, xmax = Owl_stats.minmax x in
  let ymin, ymax = Owl_stats.minmax y in
  let zmin, zmax, _, _, _, _ = Owl_dense.minmax z in
  let _ = _set_device h in
  let _ = plinit () in
  let _ = pladv 0 in
  let _ = plvpor 0.0 1.0 0.0 1.0 in
  let _ = plwind (-1.0) 1.0 (-1.0) 1.5 in
  let _ = plw3d 1.0 1.0 1.0 xmin xmax ymin ymax zmin zmax 33. 115. in
  let _ = plbox3  "bnstu", "x axis", 0.0, 0,
                  "bnstu", "y axis", 0.0, 0,
                  "bcdmnstuv", "z axis", 0.0, 4 in
  let z = Owl_dense.to_arrays z in
  let _ = plmesh x y z [ PL_DRAW_LINEXY; PL_MAG_COLOR; PL_MESH ] in
  let p = h.pages.(h.current_page) in
  let _ = plmtex "t" 1.0 1.0 0.5 p.title in
  plend ()




(* ends here *)
