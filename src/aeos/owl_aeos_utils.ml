(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)
open Owl

module N = Dense.Ndarray.S
module M = Dense.Matrix.S
module L = Linalg.S

(* timing utils *)

let c = 30 (* repeat times *)

let remove_outlier arr =
  let first_perc = Owl_stats.percentile arr 25. in
  let third_perc = Owl_stats.percentile arr 75. in
  let lst = Array.to_list arr in
  List.filter (fun x -> (x >= first_perc) && (x <= third_perc)) lst
    |> Array.of_list


let timing fn msg =
  let times = Owl.Utils.Stack.make () in
  for _ = 1 to c do
    let t = Owl_utils.time fn in
    Owl.Utils.Stack.push times t
  done;
  let times = Owl.Utils.Stack.to_array times in
  let times = remove_outlier(times) in
  let m_time = Owl.Stats.mean times in
  let s_time = Owl.Stats.std times in
  Owl_log.info "| %s :\t mean = %.3f \t std = %.3f \n" msg m_time s_time;
  flush stdout;
  m_time, s_time


let eval_single_op f sz () =
  let x = N.uniform [|sz|] in
  let y = N.copy x in
  f Bigarray.Float32 (Owl_utils.numel x) x y |> ignore


let plot x y k b =
  let h = Plot.create "line_plot.png" in
  let x = Dense.Matrix.Generic.cast_s2d x in
  let y = Dense.Matrix.Generic.cast_s2d y in

  let y' = Mat.(x *$ k +$ b) in
  Plot.scatter ~h x y;
  Plot.plot ~h ~spec:[ RGB (0,255,0) ] x y';
  Plot.output h


let regression ?(p=false) x y =
  let b, k = L.linreg x y in
  if p = true then (
    Printf.fprintf stderr "k: %.3f, b: %.3f\n" k b;
    plot x y k b
  );
  let g x = x *. k +. b in
  let rt = Owl_maths_root.fzero g 0. 1000000. in
  Owl_log.info "Crosspoint: %f.\n" rt;
  int_of_float rt
