(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)
open Owl

module N = Dense.Ndarray.S
module M = Dense.Matrix.S
module L = Linalg.S

let default_threshold = 100000

let c = 30 (* repeat times *)

let remove_outlier arr =
  let first_perc = Owl_stats.percentile arr 25. in
  let third_perc = Owl_stats.percentile arr 75. in
  let lst = Array.to_list arr in
  List.filter (fun x -> (x >= first_perc) && (x <= third_perc)) lst
    |> Array.of_list


let timing fn msg =
  Gc.compact ();
  let times = Owl.Utils.Stack.make () in
  for _ = 1 to c do
    let t = fn () in
    Owl.Utils.Stack.push times t
  done;
  let times = Owl.Utils.Stack.to_array times in
  let times = remove_outlier(times) in
  let m_time = Owl.Stats.mean times in
  let s_time = Owl.Stats.std times in
  Owl_log.info "| %s :\t mean = %.3f \t std = %.3f \n" msg m_time s_time;
  flush stdout;
  m_time, s_time


let step_measure xs ef eg msg =
  let n = Array.length xs in
  let y1 = Array.make n 0. in
  let y2 = Array.make n 0. in

  for i = 0 to n - 1 do
    let x = xs.(i) in
    let v1, _ = timing (ef x) msg in
    let v2, _ = timing (eg x) (msg ^ "-baseline") in
    y1.(i) <- v1;
    y2.(i) <- v2;
  done;

  let y1 = M.of_array y1 n 1 in
  let y2 = M.of_array y2 n 1 in
  M.(y2 - y1)


let linear_reg x y =
  let b, k = L.linreg x y in
  Owl_log.info "Linear Regression: k: %.2f, b: %.2f\n" k b;
  let g x = x *. k +. b in
  g


let find_root ?(l=(-10000.)) ?(u=1000000.) f =
  try
    let r = Owl_maths_root.fzero f l u in
    let r = if (r > 0.) then r else 0. in
    Owl_log.info "Crosspoint: %f.\n" r;
    int_of_float r
  with
  | Assert_failure (err_msg, _, _) ->
    Owl_log.warn "%s" (err_msg ^ " ; using default value");
    default_threshold


let plot x y y' m =
  let h = Plot.create (Printf.sprintf "line_plot_%s.png" m) in
  let x = Dense.Matrix.Generic.cast_s2d x in
  let y = Dense.Matrix.Generic.cast_s2d y in
  let y' = Dense.Matrix.Generic.cast_s2d y' in
  Plot.scatter ~h x y;
  Plot.plot ~h ~spec:[ RGB (0,255,0) ] x y';
  Plot.output h
