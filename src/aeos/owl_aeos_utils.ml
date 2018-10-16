(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)
open Owl

module N = Dense.Ndarray.S

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
  Printf.printf "| %s :\t mean = %.3f \t std = %.3f \n" msg m_time s_time;
  flush stdout;
  m_time, s_time


let eval_single_op f sz () =
  let x = N.uniform [|sz|] in
  let y = N.copy x in
  f Bigarray.Float32 (Owl_utils.numel x) x y |> ignore


let regression m =
  let vals1 = m.(0) in
  let vals2 = m.(1) in
  Array.length vals1 - Array.length vals2
