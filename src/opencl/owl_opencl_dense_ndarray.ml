(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_opencl_primitive


(* unary operator definitions *)

let erf x = map_arr "erf" x

let erfc x = map_arr "erfc" x

let abs x = map_arr "abs" x

let neg x = map_arr "neg" x

let sqr x = map_arr "sqr" x

let sqrt x = map_arr "sqrt" x

let cbrt x = map_arr "cbrt" x

let reci x = map_arr "reci" x

let sin x = map_arr "sin" x

let cos x = map_arr "cos" x

let tan x = map_arr "tan" x

let asin x = map_arr "asin" x

let acos x = map_arr "acos" x

let atan x = map_arr "atan" x

let sinh x = map_arr "sinh" x

let cosh x = map_arr "cosh" x

let tanh x = map_arr "tanh" x

let asinh x = map_arr "asinh" x

let acosh x = map_arr "acosh" x

let atanh x = map_arr "atanh" x

let atanpi x = map_arr "atanpi" x

let sinpi x = map_arr "sinpi" x

let cospi x = map_arr "cospi" x

let tanpi x = map_arr "tanpi" x

let floor x = map_arr "floor" x

let ceil x = map_arr "ceil" x

let round x = map_arr "round" x

let exp x = map_arr "exp" x

let exp2 x = map_arr "exp2" x

let exp10 x = map_arr "exp10" x

let expm1 x = map_arr "expm1" x

let log x = map_arr "log" x

let log2 x = map_arr "log2" x

let log10 x = map_arr "log10" x

let log1p x = map_arr "log1p" x

let logb x = map_arr "logb" x

let relu x = map_arr "relu" x

let signum x = map_arr "signum" x

let sigmoid x = map_arr "sigmoid" x

let softplus x = map_arr "softplus" x

let softsign x = map_arr "softsign" x


(* binary operator definitions *)

let add x y = map2_arr "add" x y

let sub x y = map2_arr "sub" x y

let mul x y = map2_arr "mul" x y

let div x y = map2_arr "div" x y

let pow x y = map2_arr "pow" x y

let min2 x y = map2_arr "min2" x y

let max2 x y = map2_arr "max2" x y

let fmod x y = map2_arr "fmod" x y

let hypot x y = map2_arr "hypot" x y

let atan2 x y = map2_arr "atan2" x y

let atan2pi x y = map2_arr "atan2pi" x y

let add_scalar x a = map_arr_scalar "add_scalar" x a

let sub_scalar x a = map_arr_scalar "sub_scalar" x a

let mul_scalar x a = map_arr_scalar "mul_scalar" x a

let div_scalar x a = map_arr_scalar "div_scalar" x a

let pow_scalar x a = map_arr_scalar "pow_scalar" x a

let fmod_scalar x a = map_arr_scalar "fmod_scalar" x a

let atan2_scalar x a = map_arr_scalar "atan2_scalar" x a

let atan2pi_scalar x a = map_arr_scalar "atan2pi_scalar" x a

let scalar_add a x = map_arr_scalar "scalar_add" x a

let scalar_sub a x = map_arr_scalar "scalar_sub" x a

let scalar_mul a x = map_arr_scalar "scalar_mul" x a

let scalar_div a x = map_arr_scalar "scalar_div" x a

let scalar_pow a x = map_arr_scalar "scalar_pow" x a

let scalar_fmod a x = map_arr_scalar "scalar_fmod" x a

let scalar_atan2 a x = map_arr_scalar "scalar_atan2" x a

let scalar_atan2pi a x = map_arr_scalar "scalar_atan2pi" x a


(* helper functions *)

let to_ndarray
  : type a b . (a, b) Bigarray.kind -> t -> (a, b) Owl_dense_ndarray_generic.t
  = fun k x ->
  eval x |> ignore;
  let y = unpack_trace x in
  (y.outval.(0) |> unpack_arr)


let of_ndarray x = pack_arr (Owl_dense_ndarray_generic.copy x)


(* ends here *)
