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

let _re_elt : type a b. (a, b) kind -> (a -> float) = function
  | Float32   -> fun x -> x
  | Float64   -> fun x -> x
  | Complex32 -> fun x -> Complex.(x.re)
  | Complex64 -> fun x -> Complex.(x.re)
  | _         -> failwith "_re_elt: unsupported operation"

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

let _power_scalar_elt : type a b. (a, b) kind -> (a -> a -> a) = function
  | Float32   -> ( ** )
  | Float64   -> ( ** )
  | Complex32 -> Complex.pow
  | Complex64 -> Complex.pow
  | _         -> failwith "_power_scalar_elt: unsupported operation"

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


(* ends here *)
