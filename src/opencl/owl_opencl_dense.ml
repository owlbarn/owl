(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(* unary operator definitions *)

let erf x = Owl_opencl_operand.map_arr "erf" x

let erfc x = Owl_opencl_operand.map_arr "erfc" x

let abs x = Owl_opencl_operand.map_arr "abs" x

let neg x = Owl_opencl_operand.map_arr "neg" x

let sqr x = Owl_opencl_operand.map_arr "sqr" x

let sqrt x = Owl_opencl_operand.map_arr "sqrt" x

let cbrt x = Owl_opencl_operand.map_arr "cbrt" x

let reci x = Owl_opencl_operand.map_arr "reci" x

let sin x = Owl_opencl_operand.map_arr "sin" x

let cos x = Owl_opencl_operand.map_arr "cos" x

let tan x = Owl_opencl_operand.map_arr "tan" x

let asin x = Owl_opencl_operand.map_arr "asin" x

let acos x = Owl_opencl_operand.map_arr "acos" x

let atan x = Owl_opencl_operand.map_arr "atan" x

let sinh x = Owl_opencl_operand.map_arr "sinh" x

let cosh x = Owl_opencl_operand.map_arr "cosh" x

let tanh x = Owl_opencl_operand.map_arr "tanh" x

let asinh x = Owl_opencl_operand.map_arr "asinh" x

let acosh x = Owl_opencl_operand.map_arr "acosh" x

let atanh x = Owl_opencl_operand.map_arr "atanh" x

let atanpi x = Owl_opencl_operand.map_arr "atanpi" x

let sinpi x = Owl_opencl_operand.map_arr "sinpi" x

let cospi x = Owl_opencl_operand.map_arr "cospi" x

let tanpi x = Owl_opencl_operand.map_arr "tanpi" x

let floor x = Owl_opencl_operand.map_arr "floor" x

let ceil x = Owl_opencl_operand.map_arr "ceil" x

let round x = Owl_opencl_operand.map_arr "round" x

let exp x = Owl_opencl_operand.map_arr "exp" x

let exp2 x = Owl_opencl_operand.map_arr "exp2" x

let exp10 x = Owl_opencl_operand.map_arr "exp10" x

let expm1 x = Owl_opencl_operand.map_arr "expm1" x

let log x = Owl_opencl_operand.map_arr "log" x

let log2 x = Owl_opencl_operand.map_arr "log2" x

let log10 x = Owl_opencl_operand.map_arr "log10" x

let log1p x = Owl_opencl_operand.map_arr "log1p" x

let logb x = Owl_opencl_operand.map_arr "logb" x

let relu x = Owl_opencl_operand.map_arr "relu" x

let signum x = Owl_opencl_operand.map_arr "signum" x

let sigmoid x = Owl_opencl_operand.map_arr "sigmoid" x

let softplus x = Owl_opencl_operand.map_arr "softplus" x

let softsign x = Owl_opencl_operand.map_arr "softsign" x


(* binary operator definitions *)

let add x y = Owl_opencl_operand.map2_arr "add" x y

let sub x y = Owl_opencl_operand.map2_arr "sub" x y

let mul x y = Owl_opencl_operand.map2_arr "mul" x y

let div x y = Owl_opencl_operand.map2_arr "div" x y

let pow x y = Owl_opencl_operand.map2_arr "pow" x y

let min2 x y = Owl_opencl_operand.map2_arr "min2" x y

let max2 x y = Owl_opencl_operand.map2_arr "max2" x y

let fmod x y = Owl_opencl_operand.map2_arr "fmod" x y

let hypot x y = Owl_opencl_operand.map2_arr "hypot" x y

let atan2 x y = Owl_opencl_operand.map2_arr "atan2" x y

let atan2pi x y = Owl_opencl_operand.map2_arr "atan2pi" x y

let add_scalar x a = Owl_opencl_operand.map_arr_scalar "add_scalar" x a

let sub_scalar x a = Owl_opencl_operand.map_arr_scalar "sub_scalar" x a

let mul_scalar x a = Owl_opencl_operand.map_arr_scalar "mul_scalar" x a

let div_scalar x a = Owl_opencl_operand.map_arr_scalar "div_scalar" x a

let pow_scalar x a = Owl_opencl_operand.map_arr_scalar "pow_scalar" x a

let fmod_scalar x a = Owl_opencl_operand.map_arr_scalar "fmod_scalar" x a

let atan2_scalar x a = Owl_opencl_operand.map_arr_scalar "atan2_scalar" x a

let atan2pi_scalar x a = Owl_opencl_operand.map_arr_scalar "atan2pi_scalar" x a


(* helper functions *)

let to_ndarray x =
  Owl_opencl_operand.eval x |> ignore;
  let y = Owl_opencl_operand.unpack_trace x in
  Owl_opencl_operand.(y.outval.(0) |> unpack_arr)


let of_ndarray x = Owl_opencl_operand.(Arr x)


(* ends here *)
