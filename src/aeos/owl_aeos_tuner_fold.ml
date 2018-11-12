(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl
open Owl_aeos_c_interface

module N = Dense.Ndarray.S
module M = Dense.Matrix.S

let default_threshold = 1000

let generate_sizes_fold ?(dims=4) start step n =
  let u = Array.make dims start in
  let x = Array.make n u in
  for i = 0 to n - 1 do
    x.(i) <- Array.make dims (start + i * step)
  done;
  x

let size2mat_fold a =
  let n = Array.length a in
  let s = Array.make n 0. in
  Array.iteri (fun i x ->
    s.(i) <- Array.fold_left ( * ) 1 x |> float_of_int
  ) a;
  M.of_array s n 1


let eval_fold f sz () =
  let x = N.uniform sz in
  let h () = f (Owl_utils.numel x) x |> ignore in
  Owl_utils.time h


let eval_fold_arr f sz () =
  let x = N.uniform sz in
  let h () = f ~axis:0 x |> ignore in
  Owl_utils.time h


let step_measure_fold xs f base_f msg =
  let ef = eval_fold f in
  let eg = eval_fold base_f in
  Owl_aeos_utils.step_measure xs ef eg msg


let step_measure_fold_arr xs f base_f msg =
  let ef = eval_fold_arr f in
  let eg = eval_fold_arr base_f in
  Owl_aeos_utils.step_measure xs ef eg msg

(*
let eval_fold_along f a xs () =
  let x = N.uniform xs in
  let m, n, o, ys = Owl_utils.reduce_params a x in
  let y = N.uniform ys in
  let h () = f m n o x y |> ignore in
  Owl_utils.time h

let step_measure_fold_along xs f base_f msg =
  let ef = eval_fold_along f 0 in
  let eg = eval_fold_along base_f 0 in
  Owl_aeos_utils.step_measure xs ef eg msg
*)

(* Reduction on all elements *)

module Sum = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "sum";
    param = "OWL_OMP_THRESHOLD_SUM";
    value = default_threshold;
    input = generate_sizes_fold 10 4 20;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_sum Float32 in
    let f2 = baseline_float32_sum in
    t.y <- step_measure_fold t.input f1 f2 t.name;
    let x = size2mat_fold t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let plot t =
    let x = size2mat_fold t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f x in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Prod = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "prod";
    param = "OWL_OMP_THRESHOLD_PROD";
    value = default_threshold;
    input = generate_sizes_fold 10 2 20;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_prod Float32 in
    let f2 = baseline_float32_prod in
    t.y <- step_measure_fold t.input f1 f2 t.name;
    let x = size2mat_fold t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let plot t =
    let x = size2mat_fold t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f x in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Cumsum = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "cumsum";
    param = "OWL_OMP_THRESHOLD_CUMSUM";
    value = default_threshold;
    input = generate_sizes_fold 10 2 10;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = fun ~axis x -> N.cumsum ~axis x in
    let f2 = baseline_cumsum in
    t.y <- step_measure_fold_arr t.input f1 f2 t.name;
    let x = size2mat_fold t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let plot t =
    let x = size2mat_fold t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f x in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Cumprod = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "cumprod";
    param = "OWL_OMP_THRESHOLD_CUMPROD";
    value = default_threshold;
    input = generate_sizes_fold 10 2 10;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = fun ~axis x -> N.cumprod_ ~axis x in
    let f2 = baseline_cumprod in
    t.y <- step_measure_fold_arr t.input f1 f2 t.name;
    let x = size2mat_fold t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let plot t =
    let x = size2mat_fold t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f x in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Cummax = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "cummax";
    param = "OWL_OMP_THRESHOLD_CUMMAX";
    value = default_threshold;
    input = generate_sizes_fold 10 2 10;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = fun ~axis x -> N.cummax ~axis x in
    let f2 = baseline_cummax in
    t.y <- step_measure_fold_arr t.input f1 f2 t.name;
    let x = size2mat_fold t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let plot t =
    let x = size2mat_fold t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f x in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end

module Diff = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "diff";
    param = "OWL_OMP_THRESHOLD_DIFF";
    value = default_threshold;
    input = generate_sizes_fold 10 2 10;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = fun ~axis x -> N.diff ~axis x in
    let f2 = baseline_diff in
    t.y <- step_measure_fold_arr t.input f1 f2 t.name;
    let x = size2mat_fold t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let plot t =
    let x = size2mat_fold t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f x in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Repeat = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "repeat";
    param = "OWL_OMP_THRESHOLD_REPEAT";
    value = default_threshold;
    input = generate_sizes_fold 10 2 10;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = fun ~axis x -> N.repeat x [|axis|] in
    let f2 = baseline_repeat in
    t.y <- step_measure_fold_arr t.input f1 f2 t.name;
    let x = size2mat_fold t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let plot t =
    let x = size2mat_fold t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f x in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end
