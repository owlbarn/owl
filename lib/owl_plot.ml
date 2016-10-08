(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Graphical Module ]  *)

open Plplot

module MX = Owl_dense

(* types in plot module *)

type dsmat = Owl_dense.dsmat

type device = AQT | PNG | PDF | SVG

type plot_typ = {
  mutable title : string;
  mutable xlabel : string;
  mutable ylabel : string;
  mutable xrange : float option * float option;
  mutable yrange : float option * float option;
}

(* module functions to simplify plotting *)

let set_device d =
  match d with
  | AQT -> plsdev "aqt"
  | PNG -> plsdev "png"
  | PDF -> plsdev "pdf"
  | SVG -> plsdev "svg"

let create () = {
  title = "";
  xlabel = "x";
  ylabel = "y";
  xrange = (None, None);
  yrange = (None, None);
}

let set_title h s = h.title <- s

let set_xlabel h s = h.xlabel <- s

let set_ylabel h s = h.ylabel <- s

let set_xrange h a b = h.xrange <- (a, b)

let set_yrange h a b = h.yrange <- (a, b)

let _update_range r x =
  match r with
  | Some a, None -> a, Owl_stats.max x
  | None, Some b -> Owl_stats.min x, b
  | Some a, Some b -> a, b
  | None, None -> Owl_stats.minmax x

let my_plot h x y =
  let x = MX.to_array x in
  let y = MX.to_array y in
  let _ = plsfnam "default.pdf" in
  let _ = plinit () in
  let xmin, xmax = _update_range h.xrange x in
  let ymin, ymax = _update_range h.yrange y in
  let _ = plenv xmin xmax ymin ymax 0 0 in
  let _ = pllab h.xlabel h.ylabel h.title in
  let _ = plline x y in
  plend ()

let plot x y =
  let x = MX.to_array x in
  let y = MX.to_array y in
  let _ = plinit () in
  let xmin, xmax = Owl_stats.minmax x in
  let ymin, ymax = Owl_stats.minmax y in
  let _ = plenv xmin xmax ymin ymax 0 0 in
  let _ = plline x y in
  plend ()

let plot_fun f a b =
  let x = MX.linspace a b 100 in
  let y = MX.map f x in
  plot x y

let scatter ?(marker='+') x y =
  let x = MX.to_array x in
  let y = MX.to_array y in
  let _ = plinit () in
  let xmin, xmax = Owl_stats.minmax x in
  let ymin, ymax = Owl_stats.minmax y in
  let _ = plenv xmin xmax ymin ymax 0 0 in
  let _ = pllab "x" "y" "scatter plot" in
  let _ = plpoin x y 2 in (* TODO: + is 2; x is 5 *)
  plend ()

let histogram ?(bin=10) x =
  let open Plplot in
  let x = MX.to_array x in
  let _ = plinit () in
  let xmin, xmax = Owl_stats.minmax x in
  let _ = plhist x xmin xmax bin [ PL_HIST_DEFAULT ] in
  plend ()

let mesh x y z =
  let open Plplot in
  let x = MX.to_array x in
  let y = MX.(transpose y |> to_array) in
  let xmin, xmax = Owl_stats.minmax x in
  let ymin, ymax = Owl_stats.minmax y in
  let zmin, zmax, _, _, _, _ = MX.minmax z in
  let _ = plinit () in
  let _ = pladv 0 in
  let _ = plvpor 0.0 1.0 0.0 1.0 in
  let _ = plwind (-1.0) 1.0 (-1.0) 1.5 in
  let _ = plcol0 1 in
  let _ = plw3d 1.0 1.0 1.0 xmin xmax ymin ymax zmin zmax 33. 115. in
  let _ = plbox3  "bnstu", "x axis", 0.0, 0,
                  "bnstu", "y axis", 0.0, 0,
                  "bcdmnstuv", "z axis", 0.0, 4 in
  let _ = plcol0 2 in
  let z = MX.to_arrays z in
  let _ = plmesh x y z [ PL_DRAW_LINEXY; PL_MAG_COLOR; PL_MESH ] in
  let _ = plcol0 3 in
  plend ()





(* ends here *)
