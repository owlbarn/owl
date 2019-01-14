(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_aeos_c_interface
open Owl_aeos_utils

let default_threshold = 10000


let generate_sizes_fold ?(dims=4) start step n =
  let u = Array.make dims start in
  let x = Array.make n u in
  for i = 0 to n - 1 do
    x.(i) <- Array.make dims (start + i * step)
  done;
  x


let size2arr_fold a =
  let n = Array.length a in
  let s = Array.make n 0. in
  Array.iteri (fun i x ->
    s.(i) <- Array.fold_left ( * ) 1 x |> float_of_int
  ) a;
  s


let eval_fold f sz () =
  let x = ones sz in
  let h () = f (numel x) x |> ignore in
  time h


let eval_fold_arr f sz () =
  let x = ones sz in
  let h () = f ~axis:0 x |> ignore in
  time h


let step_measure_fold xs f base_f msg =
  let ef = eval_fold f in
  let eg = eval_fold base_f in
  step_measure xs ef eg msg


let step_measure_fold_arr xs f base_f msg =
  let ef = eval_fold_arr f in
  let eg = eval_fold_arr base_f in
  step_measure xs ef eg msg


module Cumsum = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "cumsum";
    param = "OWL_OMP_THRESHOLD_CUMSUM";
    value = default_threshold;
    input = generate_sizes_fold 10 2 15;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = openmp_cumsum in
    let f2 = baseline_cumsum in
    t.y <- step_measure_fold_arr t.input f1 f2 t.name;
    let x = size2arr_fold t.input in
    let f, sign = linear_reg x t.y in
    t.value <- find_root f sign

  let save_data t =
    let x = size2arr_fold t.input in
    let f, _ = linear_reg x t.y in
    let y' = Array.map f x in
    to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Cumprod = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "cumprod";
    param = "OWL_OMP_THRESHOLD_CUMPROD";
    value = default_threshold;
    input = generate_sizes_fold 10 2 15;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = openmp_cumprod in
    let f2 = baseline_cumprod in
    t.y <- step_measure_fold_arr t.input f1 f2 t.name;
    let x = size2arr_fold t.input in
    let f, sign = linear_reg x t.y in
    t.value <- find_root f sign

  let save_data t =
    let x = size2arr_fold t.input in
    let f, _ = linear_reg x t.y in
    let y' = Array.map f x in
    to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Cummax = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "cummax";
    param = "OWL_OMP_THRESHOLD_CUMMAX";
    value = default_threshold;
    input = generate_sizes_fold 10 2 15;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = openmp_cummax in
    let f2 = baseline_cummax in
    t.y <- step_measure_fold_arr t.input f1 f2 t.name;
    let x = size2arr_fold t.input in
    let f, sign = linear_reg x t.y in
    t.value <- find_root f sign

  let save_data t =
    let x = size2arr_fold t.input in
    let f, _ = linear_reg x t.y in
    let y' = Array.map f x in
    to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Diff = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "diff";
    param = "OWL_OMP_THRESHOLD_DIFF";
    value = default_threshold;
    input = generate_sizes_fold 10 2 15;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = openmp_diff in
    let f2 = baseline_diff in
    t.y <- step_measure_fold_arr t.input f1 f2 t.name;
    let x = size2arr_fold t.input in
    let f, sign = linear_reg x t.y in
    t.value <- find_root f sign

  let save_data t =
    let x = size2arr_fold t.input in
    let f, _ = linear_reg x t.y in
    let y' = Array.map f x in
    to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Repeat = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "repeat";
    param = "OWL_OMP_THRESHOLD_REPEAT";
    value = default_threshold;
    input = generate_sizes_fold 10 2 15;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = openmp_repeat in
    let f2 = baseline_repeat in
    t.y <- step_measure_fold_arr t.input f1 f2 t.name;
    let x = size2arr_fold t.input in
    let f, sign = linear_reg x t.y in
    t.value <- find_root f sign

  let save_data t =
    let x = size2arr_fold t.input in
    let f, _ = linear_reg x t.y in
    let y' = Array.map f x in
    to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end
