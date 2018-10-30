(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl
open Owl_aeos_c_interface

module N = Dense.Ndarray.S
module M = Dense.Matrix.S


let generate_sizes_map start step n =
  let x = Array.make n [|0|] in
  for i = 0 to n - 1 do
    x.(i) <- [| start + i * step |]
  done;
  x

let size2mat_map xs =
  let a = Array.map (fun x -> float_of_int x.(0)) xs in
  M.of_array a (Array.length a) 1


let eval_map_unary f sz () =
  let x = N.uniform sz in
  let y = N.copy x in
  let h () = f (Owl_utils.numel x) x y |> ignore in
  Owl_utils.time h


let eval_map_binary f sz () =
  let x1 = N.uniform sz in
  let x2 = N.uniform sz in
  let y  = N.copy x1 in
  let h () = f (Owl_utils.numel x1) x1 x2 y |> ignore in
  Owl_utils.time h


let step_measure_map_unary xs f base_f msg =
  let ef = eval_map_unary f in
  let eg = eval_map_unary base_f in
  Owl_aeos_utils.step_measure xs ef eg msg


let step_measure_map_binary xs f base_f msg =
  let ef = eval_map_binary f in
  let eg = eval_map_binary base_f in
  Owl_aeos_utils.step_measure xs ef eg msg

(* Unary operations *)

module Sin = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "sin";
    param = "OWL_OMP_THRESHOLD_SIN";
    value = max_int;
    input = generate_sizes_map 1000 1000 30;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_sin Float32 in
    let f2 = baseline_float32_sin in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f

  let plot t =
    let x = size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f t.y in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Cos = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "cos";
    param = "OWL_OMP_THRESHOLD_COS";
    value = max_int;
    input = generate_sizes_map 1000 1000 30;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_cos Float32 in
    let f2 = baseline_float32_cos in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f

  let plot t =
    let x = size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f t.y in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Reci = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "reci";
    param = "OWL_OMP_THRESHOLD_RECI";
    value = max_int;
    input = generate_sizes_map 1000 10000 30;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_reci Float32 in
    let f2 = baseline_float32_reci in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f

  let plot t =
    let x = size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f t.y in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Exp = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "exp";
    param = "OWL_OMP_THRESHOLD_EXP";
    value = max_int;
    input = generate_sizes_map 1000 1000 30;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_exp Float32 in
    let f2 = baseline_float32_exp in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f

  let plot t =
    let x = size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f t.y in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end

(* Binary operations *)

module Add = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "add";
    param = "OWL_OMP_THRESHOLD_ADD";
    value = max_int;
    input = generate_sizes_map 1000 20000 50;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_add Float32 in
    let f2 = baseline_float32_add in
    t.y <- step_measure_map_binary t.input f1 f2 t.name;
    let x = size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f

  let plot t =
    let x = size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f t.y in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Div = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "div";
    param = "OWL_OMP_THRESHOLD_DIV";
    value = max_int;
    input = generate_sizes_map 1000 20000 50;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_div Float32 in
    let f2 = baseline_float32_div in
    t.y <- step_measure_map_binary t.input f1 f2 t.name;
    let x = size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f

  let plot t =
    let x = size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f t.y in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Atan2 = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "atan2";
    param = "OWL_OMP_THRESHOLD_ATAN2";
    value = max_int;
    input = generate_sizes_map 1000 1000 50;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_atan2 Float32 in
    let f2 = baseline_float32_atan2 in
    t.y <- step_measure_map_binary t.input f1 f2 t.name;
    let x = size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f

  let plot t =
    let x = size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f t.y in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Fmod = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : M.mat
  }

  let make () = {
    name  = "fmod";
    param = "OWL_OMP_THRESHOLD_FMOD";
    value = max_int;
    input = generate_sizes_map 1000 2000 50;
    y = M.zeros 1 1
  }

  let tune t =
    Owl_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_fmod Float32 in
    let f2 = baseline_float32_fmod in
    t.y <- step_measure_map_binary t.input f1 f2 t.name;
    let x = size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f

  let plot t =
    let x = size2mat_map t.input in
    let f = Owl_aeos_utils.linear_reg x t.y in
    let y' = M.map f t.y in
    Owl_aeos_utils.plot x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


(* Operation to map x to y with explicit offset, step size, number of ops *)
