(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray


(* basic operations on individual element *)

let _max_val_elt : type a b. (a, b) kind -> a = function
  | Float32        -> Owl_const.max_float32
  | Float64        -> Owl_const.max_float64
  | Complex32      -> {re = Owl_const.max_float32; im = Owl_const.max_float32}
  | Complex64      -> {re = Owl_const.max_float64; im = Owl_const.max_float64}
  | Int8_signed    -> 127
  | Int8_unsigned  -> 255
  | Int16_signed   -> 32767
  | Int16_unsigned -> 65535
  | Int32          -> Int32.max_int
  | Int64          -> Int64.max_int
  | _              -> failwith "_max_val_elt: unsupported operation"


let _min_val_elt : type a b. (a, b) kind -> a = function
  | Float32        -> Owl_const.min_float32
  | Float64        -> Owl_const.min_float64
  | Complex32      -> {re = Owl_const.min_float32; im = Owl_const.min_float32}
  | Complex64      -> {re = Owl_const.min_float64; im = Owl_const.min_float64}
  | Int8_signed    -> ~-128
  | Int8_unsigned  -> 0
  | Int16_signed   -> ~-32768
  | Int16_unsigned -> 0
  | Int32          -> Int32.min_int
  | Int64          -> Int64.min_int
  | _              -> failwith "_max_val_elt: unsupported operation"


let _max_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32        -> Pervasives.max
  | Float64        -> Pervasives.max
  | Int8_signed    -> Pervasives.max
  | Int8_unsigned  -> Pervasives.max
  | Int16_signed   -> Pervasives.max
  | Int16_unsigned -> Pervasives.max
  | Int32          -> Pervasives.max
  | Int64          -> Pervasives.max
  | Complex32      -> failwith "_max_elt: unsupported operation"
  | Complex64      -> failwith "_max_elt: unsupported operation"
  | _              -> failwith "_max_elt: unsupported operation"


let _min_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32        -> Pervasives.min
  | Float64        -> Pervasives.min
  | Int8_signed    -> Pervasives.min
  | Int8_unsigned  -> Pervasives.min
  | Int16_signed   -> Pervasives.min
  | Int16_unsigned -> Pervasives.min
  | Int32          -> Pervasives.min
  | Int64          -> Pervasives.min
  | Complex32      -> failwith "_min_elt: unsupported operation"
  | Complex64      -> failwith "_min_elt: unsupported operation"
  | _              -> failwith "_min_elt: unsupported operation"


let _add_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32        -> ( +. )
  | Float64        -> ( +. )
  | Complex32      -> Complex.add
  | Complex64      -> Complex.add
  | Int8_signed    -> ( + )
  | Int8_unsigned  -> ( + )
  | Int16_signed   -> ( + )
  | Int16_unsigned -> ( + )
  | Int32          -> Int32.add
  | Int64          -> Int64.add
  | _              -> failwith "_add_elt: unsupported operation"


let _sub_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32        -> ( -. )
  | Float64        -> ( -. )
  | Complex32      -> Complex.sub
  | Complex64      -> Complex.sub
  | Int8_signed    -> ( - )
  | Int8_unsigned  -> ( - )
  | Int16_signed   -> ( - )
  | Int16_unsigned -> ( - )
  | Int32          -> Int32.sub
  | Int64          -> Int64.sub
  | _              -> failwith "_sub_elt: unsupported operation"


let _mul_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32        -> ( *. )
  | Float64        -> ( *. )
  | Complex32      -> Complex.mul
  | Complex64      -> Complex.mul
  | Int8_signed    -> ( * )
  | Int8_unsigned  -> ( * )
  | Int16_signed   -> ( * )
  | Int16_unsigned -> ( * )
  | Int32          -> Int32.mul
  | Int64          -> Int64.mul
  | _              -> failwith "_mul_elt: unsupported operation"


let _div_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32        -> ( /. )
  | Float64        -> ( /. )
  | Complex32      -> Complex.div
  | Complex64      -> Complex.div
  | Int8_signed    -> ( / )
  | Int8_unsigned  -> ( / )
  | Int16_signed   -> ( / )
  | Int16_unsigned -> ( / )
  | Int32          -> Int32.div
  | Int64          -> Int64.div
  | _              -> failwith "_div: unsupported operation"


let _inv_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> fun x -> 1. /. x
  | Float64   -> fun x -> 1. /. x
  | Complex32 -> Complex.inv
  | Complex64 -> Complex.inv
  | _         -> failwith "_inv_elt: unsupported operation"


let _neg_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32        -> fun x -> (-.x)
  | Float64        -> fun x -> (-.x)
  | Complex32      -> Complex.neg
  | Complex64      -> Complex.neg
  | Int8_signed    -> fun x -> -x
  | Int8_unsigned  -> fun x -> -x
  | Int16_signed   -> fun x -> -x
  | Int16_unsigned -> fun x -> -x
  | Int32          -> Int32.neg
  | Int64          -> Int64.neg
  | _              -> failwith "_inv_elt: unsupported operation"


let _abs_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32        -> abs_float
  | Float64        -> abs_float
  | Complex32      -> fun x -> Complex.({re = norm x; im = 0.})
  | Complex64      -> fun x -> Complex.({re = norm x; im = 0.})
  | Int8_signed    -> abs
  | Int8_unsigned  -> abs
  | Int16_signed   -> abs
  | Int16_unsigned -> abs
  | Int32          -> Int32.abs
  | Int64          -> Int64.abs
  | _              -> failwith "_abs_elt: unsupported operation"


let _log_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Pervasives.log
  | Float64   -> Pervasives.log
  | Complex32 -> Complex.log
  | Complex64 -> Complex.log
  | _         -> failwith "_log_elt: unsupported operation"


let _log2_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.log2
  | Float64   -> Owl_base_maths.log2
  | Complex32 -> Owl_base_complex.log2
  | Complex64 -> Owl_base_complex.log2
  | _         -> failwith "_log2_elt: unsupported operation"


let _log10_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.log10
  | Float64   -> Owl_base_maths.log10
  | Complex32 -> Owl_base_complex.log10
  | Complex64 -> Owl_base_complex.log10
  | _         -> failwith "_log10_elt: unsupported operation"


let _log1p_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.log1p
  | Float64   -> Owl_base_maths.log1p
  | Complex32 -> Owl_base_complex.log1p
  | Complex64 -> Owl_base_complex.log1p
  | _         -> failwith "_log1p_elt: unsupported operation"


let _exp_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.exp
  | Float64   -> Owl_base_maths.exp
  | Complex32 -> Owl_base_complex.exp
  | Complex64 -> Owl_base_complex.exp
  | _         -> failwith "_exp_elt: unsupported operation"


let _exp2_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.exp2
  | Float64   -> Owl_base_maths.exp2
  | Complex32 -> Owl_base_complex.exp2
  | Complex64 -> Owl_base_complex.exp2
  | _         -> failwith "_exp2_elt: unsupported operation"


let _exp10_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.exp10
  | Float64   -> Owl_base_maths.exp10
  | Complex32 -> Owl_base_complex.exp10
  | Complex64 -> Owl_base_complex.exp10
  | _         -> failwith "_exp10_elt: unsupported operation"


let _expm1_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.expm1
  | Float64   -> Owl_base_maths.expm1
  | Complex32 -> Owl_base_complex.expm1
  | Complex64 -> Owl_base_complex.expm1
  | _         -> failwith "_expm1_elt: unsupported operation"


let _re_elt : type a b. (a, b) kind -> (a -> float) = function
  | Float32   -> fun x -> x
  | Float64   -> fun x -> x
  | Complex32 -> fun x -> Complex.(x.re)
  | Complex64 -> fun x -> Complex.(x.re)
  | _         -> failwith "_re_elt: unsupported operation"


let _im_elt : type a b. (a, b) kind -> (a -> float) = function
  | Float32   -> fun _ -> 0.
  | Float64   -> fun _ -> 0.
  | Complex32 -> fun x -> Complex.(x.im)
  | Complex64 -> fun x -> Complex.(x.im)
  | _         -> failwith "_im_elt: unsupported operation"


let _sqr_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> fun x -> x *. x
  | Float64   -> fun x -> x *. x
  | Complex32 -> fun x -> Complex.mul x x
  | Complex64 -> fun x -> Complex.mul x x
  | _         -> failwith "_sqr_elt: unsupported operation"


let _sqrt_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Pervasives.sqrt
  | Float64   -> Pervasives.sqrt
  | Complex32 -> Complex.sqrt
  | Complex64 -> Complex.sqrt
  | _         -> failwith "_sqrt_elt: unsupported operation"


let _mean_elt : type a b. (a, b) kind -> (a -> int -> a) = function
  | Float32        -> fun x n -> x /. (float_of_int n)
  | Float64        -> fun x n -> x /. (float_of_int n)
  | Complex32      -> fun x n -> Complex.(div x {re = float_of_int n; im = 0.})
  | Complex64      -> fun x n -> Complex.(div x {re = float_of_int n; im = 0.})
  | Int8_signed    -> fun x n -> x / n
  | Int8_unsigned  -> fun x n -> x / n
  | Int16_signed   -> fun x n -> x / n
  | Int16_unsigned -> fun x n -> x / n
  | Int32          -> fun x n -> Int32.(div x (of_int n))
  | Int64          -> fun x n -> Int64.(div x (of_int n))
  | _              -> failwith "_mean_elt: unsupported operation"


let _pow_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32   -> ( ** )
  | Float64   -> ( ** )
  | Complex32 -> Complex.pow
  | Complex64 -> Complex.pow
  | _         -> failwith "_power_scalar_elt: unsupported operation"


let _sin_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.sin
  | Float64   -> Owl_base_maths.sin
  | Complex32 -> Owl_base_complex.sin
  | Complex64 -> Owl_base_complex.sin
  | _         -> failwith "_sin_elt: unsupported operation"


let _cos_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.cos
  | Float64   -> Owl_base_maths.cos
  | Complex32 -> Owl_base_complex.cos
  | Complex64 -> Owl_base_complex.cos
  | _         -> failwith "_cos_elt: unsupported operation"


let _tan_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.tan
  | Float64   -> Owl_base_maths.tan
  | Complex32 -> Owl_base_complex.tan
  | Complex64 -> Owl_base_complex.tan
  | _         -> failwith "_tan_elt: unsupported operation"


let _asin_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.asin
  | Float64   -> Owl_base_maths.asin
  | Complex32 -> Owl_base_complex.asin
  | Complex64 -> Owl_base_complex.asin
  | _         -> failwith "_asin_elt: unsupported operation"


let _acos_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.acos
  | Float64   -> Owl_base_maths.acos
  | Complex32 -> Owl_base_complex.acos
  | Complex64 -> Owl_base_complex.acos
  | _         -> failwith "_acos_elt: unsupported operation"


let _atan_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.atan
  | Float64   -> Owl_base_maths.atan
  | Complex32 -> Owl_base_complex.atan
  | Complex64 -> Owl_base_complex.atan
  | _         -> failwith "_atan_elt: unsupported operation"


let _sinh_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.sinh
  | Float64   -> Owl_base_maths.sinh
  | Complex32 -> Owl_base_complex.sinh
  | Complex64 -> Owl_base_complex.sinh
  | _         -> failwith "_sinh_elt: unsupported operation"


let _cosh_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.cosh
  | Float64   -> Owl_base_maths.cosh
  | Complex32 -> Owl_base_complex.cosh
  | Complex64 -> Owl_base_complex.cosh
  | _         -> failwith "_cosh_elt: unsupported operation"


let _tanh_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.tanh
  | Float64   -> Owl_base_maths.tanh
  | Complex32 -> Owl_base_complex.tanh
  | Complex64 -> Owl_base_complex.tanh
  | _         -> failwith "_tanh_elt: unsupported operation"


let _asinh_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.asinh
  | Float64   -> Owl_base_maths.asinh
  | Complex32 -> Owl_base_complex.asinh
  | Complex64 -> Owl_base_complex.asinh
  | _         -> failwith "_asinh_elt: unsupported operation"


let _acosh_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.acosh
  | Float64   -> Owl_base_maths.acosh
  | Complex32 -> Owl_base_complex.acosh
  | Complex64 -> Owl_base_complex.acosh
  | _         -> failwith "_acosh_elt: unsupported operation"


let _atanh_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.atanh
  | Float64   -> Owl_base_maths.atanh
  | Complex32 -> Owl_base_complex.atanh
  | Complex64 -> Owl_base_complex.atanh
  | _         -> failwith "_atanh_elt: unsupported operation"


let _scale_elt : type a b. (a, b) kind -> (float -> a -> a) = function
  | Float32   -> fun a b -> a *. b
  | Float64   -> fun a b -> a *. b
  | Complex32 -> fun a b -> Complex.({re = a *. b.re; im = a *. b.im})
  | Complex64 -> fun a b -> Complex.({re = a *. b.re; im = a *. b.im})
  | _         -> failwith "_scale_elt: unsupported operation"


let _conj_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> fun x -> x
  | Float64   -> fun x -> x
  | Complex32 -> fun x -> Complex.({re = x.re; im = -.x.im})
  | Complex64 -> fun x -> Complex.({re = x.re; im = -.x.im})
  | _         -> failwith "_conj_elt: unsupported operation"


let _ceil_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.ceil
  | Float64   -> Owl_base_maths.ceil
  | Complex32 -> Owl_base_complex.ceil
  | Complex64 -> Owl_base_complex.ceil
  | _         -> failwith "_ceil_elt: unsupported operation"


let _floor_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.floor
  | Float64   -> Owl_base_maths.floor
  | Complex32 -> Owl_base_complex.floor
  | Complex64 -> Owl_base_complex.floor
  | _         -> failwith "_floor_elt: unsupported operation"


let _round_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.round
  | Float64   -> Owl_base_maths.round
  | Complex32 -> Owl_base_complex.round
  | Complex64 -> Owl_base_complex.round
  | _         -> failwith "_round_elt: unsupported operation"


let _trunc_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.trunc
  | Float64   -> Owl_base_maths.trunc
  | Complex32 -> Owl_base_complex.trunc
  | Complex64 -> Owl_base_complex.trunc
  | _         -> failwith "_trunc_elt: unsupported operation"


let _fix_elt : type a b. (a, b) kind -> (a -> a) = function
  | Float32   -> Owl_base_maths.fix
  | Float64   -> Owl_base_maths.fix
  | Complex32 -> Owl_base_complex.fix
  | Complex64 -> Owl_base_complex.fix
  | _         -> failwith "_fix_elt: unsupported operation"


let _is_nan_elt : type a b. (a, b) kind -> (a -> bool) = function
  | Float32   -> Owl_base_maths.is_nan
  | Float64   -> Owl_base_maths.is_nan
  | Complex32 -> Owl_base_complex.is_nan
  | Complex64 -> Owl_base_complex.is_nan
  | _         -> failwith "_is_nan_elt: unsupported operation"


let _is_inf_elt : type a b. (a, b) kind -> (a -> bool) = function
  | Float32   -> Owl_base_maths.is_inf
  | Float64   -> Owl_base_maths.is_inf
  | Complex32 -> Owl_base_complex.is_inf
  | Complex64 -> Owl_base_complex.is_inf
  | _         -> failwith "_is_inf_elt: unsupported operation"


let _is_normal_elt : type a b. (a, b) kind -> (a -> bool) = function
  | Float32   -> Owl_base_maths.is_normal
  | Float64   -> Owl_base_maths.is_normal
  | Complex32 -> Owl_base_complex.is_normal
  | Complex64 -> Owl_base_complex.is_normal
  | _         -> failwith "_is_normal_elt: unsupported operation"


let _float_typ_elt : type a b. (a, b) kind -> (float -> a) = function
  | Float32        -> fun a -> a
  | Float64        -> fun a -> a
  | Complex32      -> fun a -> Complex.({re = a; im = 0.})
  | Complex64      -> fun a -> Complex.({re = a; im = 0.})
  | Int8_signed    -> int_of_float
  | Int8_unsigned  -> int_of_float
  | Int16_signed   -> int_of_float
  | Int16_unsigned -> int_of_float
  | Int32          -> fun a -> int_of_float a |> Int32.of_int
  | Int64          -> fun a -> int_of_float a |> Int64.of_int
  | _              -> failwith "_float_typ_elt: unsupported operation"


let _uniform_elt : type a b. (a, b) kind -> a -> a -> (a -> a) =
  fun k a b -> match k with
  | Float32   -> fun _ -> Owl_base_stats.uniform_rvs ~a ~b
  | Float64   -> fun _ -> Owl_base_stats.uniform_rvs ~a ~b
  | Complex32 -> fun _ -> (
      let re = Complex.(Owl_base_stats.uniform_rvs ~a:a.re ~b:b.re) in
      let im = Complex.(Owl_base_stats.uniform_rvs ~a:a.im ~b:b.im) in
      Complex.({re; im})
    )
  | Complex64 -> fun _ -> (
      let re = Complex.(Owl_base_stats.uniform_rvs ~a:a.re ~b:b.re) in
      let im = Complex.(Owl_base_stats.uniform_rvs ~a:a.im ~b:b.im) in
      Complex.({re; im})
    )
  | _         -> failwith "_uniform_elt: unsupported operation"


let _gaussian_elt : type a b. (a, b) kind -> a -> a -> (a -> a) =
  fun k mu sigma -> match k with
  | Float32   -> fun _ -> Owl_base_stats.gaussian_rvs ~mu ~sigma
  | Float64   -> fun _ -> Owl_base_stats.gaussian_rvs ~mu ~sigma
  | Complex32 -> fun _ -> (
      let re = Complex.(Owl_base_stats.gaussian_rvs ~mu:mu.re ~sigma:sigma.re) in
      let im = Complex.(Owl_base_stats.gaussian_rvs ~mu:mu.im ~sigma:sigma.im) in
      Complex.({re; im})
    )
  | Complex64 -> fun _ -> (
      let re = Complex.(Owl_base_stats.gaussian_rvs ~mu:mu.re ~sigma:sigma.re) in
      let im = Complex.(Owl_base_stats.gaussian_rvs ~mu:mu.im ~sigma:sigma.im) in
      Complex.({re; im})
    )
  | _         -> failwith "_gaussian_elt: unsupported operation"



(* ends here *)
