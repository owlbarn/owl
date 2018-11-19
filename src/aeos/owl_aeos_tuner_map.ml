(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_aeos_c_interface

let default_threshold = 1000


let generate_sizes start step n =
  let x = Array.make n [|0|] in
  for i = 0 to n - 1 do
    x.(i) <- [| start + i * step |]
  done;
  x


let size2arr xs =
  Array.map (fun x -> float_of_int x.(0)) xs


let eval_map_unary f sz () =
  let x = Owl_aeos_utils.ones sz in
  let y = Owl_aeos_utils.ones sz in
  let h () = f (Owl_utils.numel x) x y |> ignore in
  Owl_utils.time h


let eval_map_binary f sz () =
  let x1 = Owl_aeos_utils.ones sz in
  let x2 = Owl_aeos_utils.ones sz in
  let y  = Owl_aeos_utils.ones sz in
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

module Reci = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "reci";
    param = "OWL_OMP_THRESHOLD_RECI";
    value = default_threshold;
    input = generate_sizes 1000 10000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_reci Float32 in
    let f2 = baseline_float32_reci in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Abs = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "abs";
    param = "OWL_OMP_THRESHOLD_ABS";
    value = default_threshold;
    input = generate_sizes 1000 10000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_abs Float32 in
    let f2 = baseline_float32_abs in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Abs2 = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "abs2";
    param = "OWL_OMP_THRESHOLD_ABS2";
    value = default_threshold;
    input = generate_sizes 1000 10000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_abs2 Float32 in
    let f2 = baseline_float32_abs2 in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Signum = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "signum";
    param = "OWL_OMP_THRESHOLD_SIGNUM";
    value = default_threshold;
    input = generate_sizes 1000 10000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_signum Float32 in
    let f2 = baseline_float32_signum in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Sqr = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "sqr";
    param = "OWL_OMP_THRESHOLD_SQR";
    value = default_threshold;
    input = generate_sizes 1000 10000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_sqr Float32 in
    let f2 = baseline_float32_sqr in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Sqrt = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "sqrt";
    param = "OWL_OMP_THRESHOLD_SQRT";
    value = default_threshold;
    input = generate_sizes 1000 1000 20;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_sqrt Float32 in
    let f2 = baseline_float32_sqrt in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Cbrt = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "cbrt";
    param = "OWL_OMP_THRESHOLD_CBRT";
    value = default_threshold;
    input = generate_sizes 1000 1000 20;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_cbrt Float32 in
    let f2 = baseline_float32_cbrt in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Exp = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "exp";
    param = "OWL_OMP_THRESHOLD_EXP";
    value = default_threshold;
    input = generate_sizes 1000 1000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_exp Float32 in
    let f2 = baseline_float32_exp in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Expm1 = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "expm1";
    param = "OWL_OMP_THRESHOLD_EXPM1";
    value = default_threshold;
    input = generate_sizes 1000 1000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_expm1 Float32 in
    let f2 = baseline_float32_expm1 in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Log = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "log";
    param = "OWL_OMP_THRESHOLD_LOG";
    value = default_threshold;
    input = generate_sizes 1000 1000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_log Float32 in
    let f2 = baseline_float32_log in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Log1p = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "log1p";
    param = "OWL_OMP_THRESHOLD_LOG1P";
    value = default_threshold;
    input = generate_sizes 1000 1000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_log1p Float32 in
    let f2 = baseline_float32_log1p in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Sin = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "sin";
    param = "OWL_OMP_THRESHOLD_SIN";
    value = default_threshold;
    input = generate_sizes 1000 1000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_sin Float32 in
    let f2 = baseline_float32_sin in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Cos = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "cos";
    param = "OWL_OMP_THRESHOLD_COS";
    value = default_threshold;
    input = generate_sizes 1000 1000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_cos Float32 in
    let f2 = baseline_float32_cos in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Tan = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "tan";
    param = "OWL_OMP_THRESHOLD_TAN";
    value = default_threshold;
    input = generate_sizes 1000 1000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_tan Float32 in
    let f2 = baseline_float32_tan in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Asin = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "asin";
    param = "OWL_OMP_THRESHOLD_ASIN";
    value = default_threshold;
    input = generate_sizes 1000 1000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_asin Float32 in
    let f2 = baseline_float32_asin in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Acos = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "acos";
    param = "OWL_OMP_THRESHOLD_ACOS";
    value = default_threshold;
    input = generate_sizes 1000 1000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_acos Float32 in
    let f2 = baseline_float32_acos in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Atan = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "atan";
    param = "OWL_OMP_THRESHOLD_ATAN";
    value = default_threshold;
    input = generate_sizes 1000 1000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_atan Float32 in
    let f2 = baseline_float32_atan in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Sinh = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "sinh";
    param = "OWL_OMP_THRESHOLD_SINH";
    value = default_threshold;
    input = generate_sizes 1000 1000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_sinh Float32 in
    let f2 = baseline_float32_sinh in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Cosh = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "cosh";
    param = "OWL_OMP_THRESHOLD_COSH";
    value = default_threshold;
    input = generate_sizes 1000 1000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_cosh Float32 in
    let f2 = baseline_float32_cosh in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Tanh = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "tanh";
    param = "OWL_OMP_THRESHOLD_TANH";
    value = default_threshold;
    input = generate_sizes 1000 1000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_tanh Float32 in
    let f2 = baseline_float32_tanh in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Asinh = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "asinh";
    param = "OWL_OMP_THRESHOLD_ASINH";
    value = default_threshold;
    input = generate_sizes 1000 1000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_asinh Float32 in
    let f2 = baseline_float32_asinh in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Acosh = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "acosh";
    param = "OWL_OMP_THRESHOLD_ACOSH";
    value = default_threshold;
    input = generate_sizes 1000 1000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_acosh Float32 in
    let f2 = baseline_float32_acosh in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Atanh = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "atanh";
    param = "OWL_OMP_THRESHOLD_ATANH";
    value = default_threshold;
    input = generate_sizes 1000 1000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_atanh Float32 in
    let f2 = baseline_float32_atanh in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Erf = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "erf";
    param = "OWL_OMP_THRESHOLD_ERF";
    value = default_threshold;
    input = generate_sizes 1000 1000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_erf Float32 in
    let f2 = baseline_float32_erf in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Erfc = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "atanh";
    param = "OWL_OMP_THRESHOLD_ERFC";
    value = default_threshold;
    input = generate_sizes 1000 1000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_erfc Float32 in
    let f2 = baseline_float32_erfc in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Logistic = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "logistic";
    param = "OWL_OMP_THRESHOLD_LOGISTIC";
    value = default_threshold;
    input = generate_sizes 1000 1000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_logistic Float32 in
    let f2 = baseline_float32_logistic in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Relu = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "Relu";
    param = "OWL_OMP_THRESHOLD_RELU";
    value = default_threshold;
    input = generate_sizes 1000 1000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_relu Float32 in
    let f2 = baseline_float32_relu in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Softplus = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "softplus";
    param = "OWL_OMP_THRESHOLD_SOFTPLUS";
    value = default_threshold;
    input = generate_sizes 1000 10000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_softplus Float32 in
    let f2 = baseline_float32_softplus in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Softsign = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "softsign";
    param = "OWL_OMP_THRESHOLD_SOFTSIGN";
    value = default_threshold;
    input = generate_sizes 1000 10000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_softsign Float32 in
    let f2 = baseline_float32_softsign in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Sigmoid = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "softplus";
    param = "OWL_OMP_THRESHOLD_SIGMOID";
    value = default_threshold;
    input = generate_sizes 1000 10000 30;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_sigmoid Float32 in
    let f2 = baseline_float32_sigmoid in
    t.y <- step_measure_map_unary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


(* Binary operations *)

module Elt_equal = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "elt_equal";
    param = "OWL_OMP_THRESHOLD_ELT_EQUAL";
    value = default_threshold;
    input = generate_sizes 10000 20000 50;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_elt_equal Float32 in
    let f2 = baseline_float32_elt_equal in
    t.y <- step_measure_map_binary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Add = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "add";
    param = "OWL_OMP_THRESHOLD_ADD";
    value = default_threshold;
    input = generate_sizes 1000 20000 50;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_add Float32 in
    let f2 = baseline_float32_add in
    t.y <- step_measure_map_binary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Mul = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "mul";
    param = "OWL_OMP_THRESHOLD_MUL";
    value = default_threshold;
    input = generate_sizes 1000 10000 50;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_mul Float32 in
    let f2 = baseline_float32_mul in
    t.y <- step_measure_map_binary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Div = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "div";
    param = "OWL_OMP_THRESHOLD_DIV";
    value = default_threshold;
    input = generate_sizes 1000 20000 50;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_div Float32 in
    let f2 = baseline_float32_div in
    t.y <- step_measure_map_binary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Pow = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "pow";
    param = "OWL_OMP_THRESHOLD_POW";
    value = default_threshold;
    input = generate_sizes 1000 20000 50;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_pow Float32 in
    let f2 = baseline_float32_pow in
    t.y <- step_measure_map_binary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Hypot = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "hypot";
    param = "OWL_OMP_THRESHOLD_Hypot";
    value = default_threshold;
    input = generate_sizes 1000 1000 50;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_hypot Float32 in
    let f2 = baseline_float32_hypot in
    t.y <- step_measure_map_binary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Atan2 = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "atan2";
    param = "OWL_OMP_THRESHOLD_ATAN2";
    value = default_threshold;
    input = generate_sizes 1000 1000 50;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_atan2 Float32 in
    let f2 = baseline_float32_atan2 in
    t.y <- step_measure_map_binary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Max2 = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "max2";
    param = "OWL_OMP_THRESHOLD_MAX2";
    value = default_threshold;
    input = generate_sizes 1000 10000 50;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_max2 Float32 in
    let f2 = baseline_float32_max2 in
    t.y <- step_measure_map_binary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


module Fmod = struct

  type t = {
    mutable name  : string;
    mutable param : string;
    mutable value : int;
    mutable input : int array array;
    mutable y     : float array
  }

  let make () = {
    name  = "fmod";
    param = "OWL_OMP_THRESHOLD_FMOD";
    value = default_threshold;
    input = generate_sizes 1000 2000 50;
    y = [|0.|]
  }

  let tune t =
    Owl_aeos_log.info "AEOS: tune %s ..." t.name;
    let f1 = Owl_ndarray._owl_fmod Float32 in
    let f2 = baseline_float32_fmod in
    t.y <- step_measure_map_binary t.input f1 f2 t.name;
    let x = size2arr t.input in
    let f, sign = Owl_aeos_utils.linear_reg x t.y in
    t.value <- Owl_aeos_utils.find_root f sign

  let save_data t =
    let x = size2arr t.input in
    let f, _ = Owl_aeos_utils.linear_reg x t.y in
    let y' = Array.map f x in
    Owl_aeos_utils.to_csv x t.y y' t.name

  let to_string t =
    Printf.sprintf "#define %s %s" t.param (string_of_int t.value)

end


(* Operation to map x to y with explicit offset, step size, number of ops *)
