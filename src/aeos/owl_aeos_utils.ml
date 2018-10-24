(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)
open Owl

module N = Dense.Ndarray.S
module M = Dense.Matrix.S
module L = Linalg.S

let default_threshold = 100000

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
  fn () |> ignore;
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


let eval_map_unary f sz () =
  let x = N.uniform [|sz|] in
  let y = N.copy x in
  f (Owl_utils.numel x) x y |> ignore


let eval_map_binary f sz () =
  let x1 = N.uniform [|sz|] in
  let x2 = N.uniform [|sz|] in
  let y = N.copy x1 in
  f (Owl_utils.numel x1) x1 x2 y |> ignore

let eval_fold f sz () =
  let x = N.uniform sz in
  f (Owl_utils.numel x) x |> ignore

let eval_fold_along f xs a () =
  let x = N.uniform xs in
  let m, n, o, ys = Owl_utils.reduce_params a x in
  let y = N.uniform ys in
  f m n o x y |> ignore

let plot x y k b =
  let h = Plot.create "line_plot.png" in
  let x = Dense.Matrix.Generic.cast_s2d x in
  let y = Dense.Matrix.Generic.cast_s2d y in

  let y' = Mat.(x *$ k +$ b) in
  Plot.scatter ~h x y;
  Plot.plot ~h ~spec:[ RGB (0,255,0) ] x y';
  Plot.output h


let regression ?(p=false) x y =
  try
    let b, k = L.linreg x y in
    if p = true then (
      Printf.fprintf stderr "k: %.3f, b: %.3f\n" k b;
      plot x y k b
    );
    let g x = x *. k +. b in
    let rt = Owl_maths_root.fzero g 0. 1000000. in
    Owl_log.info "Crosspoint: %f.\n" rt;
    int_of_float rt
  with
  | Assert_failure (err_msg, _, _) ->
    Owl_log.warn "%s" (err_msg ^ " ; using default value");
    default_threshold


(* utils *)

let make_step_array start step n =
  let x = Array.make n 0 in
  for i = 0 to n - 1 do
    x.(i) <- start + i * step
  done;
  x


let array_to_mat a =
  let a = Array.map float_of_int a in
  M.of_array a (Array.length a) 1


let make_step_fold ?(dims=4) start step n =
  let u = Array.make dims start in
  let x = Array.make n u in
  for i = 0 to n - 1 do
    x.(i) <- Array.make dims (start + i * step)
  done;
  x


let fold_arr_to_mat a =
  let n = Array.length a in
  let s = Array.make n 0. in
  Array.iteri (fun i x ->
    s.(i) <- Array.fold_left ( * ) 1 x |> float_of_int
  ) a;
  M.of_array s n 1
