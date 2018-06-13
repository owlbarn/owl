(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray


(* basic operations on individual element *)

let _zero_val_elt : type a b. (a, b) kind -> a = function
  | Float32        -> 0.
  | Float64        -> 0.
  | Complex32      -> Complex.zero
  | Complex64      -> Complex.zero
  | Int8_signed    -> 0
  | Int8_unsigned  -> 0
  | Int16_signed   -> 0
  | Int16_unsigned -> 0
  | Int32          -> Int32.zero
  | Int64          -> Int64.zero
  | _              -> failwith "_zero_elt: unsupported operation"

let _one_val_elt : type a b. (a, b) kind -> a = function
  | Float32        -> 1.
  | Float64        -> 1.
  | Complex32      -> Complex.one
  | Complex64      -> Complex.one
  | Int8_signed    -> 1
  | Int8_unsigned  -> 1
  | Int16_signed   -> 1
  | Int16_unsigned -> 1
  | Int32          -> Int32.zero
  | Int64          -> Int64.zero
  | _              -> failwith "_one_elt: unsupported operation"

let _float32_max_val = 340282346638528859811704183484516925440.0
let _float32_min_val = ~-.340282346638528859811704183484516925440.0

let _max_val_elt : type a b. (a, b) kind -> a = function
  | Float32        -> _float32_max_val
  | Float64        -> Pervasives.max_float
  | Complex32      -> {re = _float32_max_val; im = _float32_max_val}
  | Complex64      -> {re = Pervasives.max_float; im = Pervasives.max_float}
  | Int8_signed    -> 127
  | Int8_unsigned  -> 255
  | Int16_signed   -> 32767
  | Int16_unsigned -> 65535
  | Int32          -> Int32.max_int
  | Int64          -> Int64.max_int
  | _              -> failwith "_max_val_elt: unsupported operation"

let _min_val_elt : type a b. (a, b) kind -> a = function
  | Float32        -> _float32_min_val
  | Float64        -> Pervasives.min_float
  | Complex32      -> {re = _float32_min_val; im = _float32_min_val}
  | Complex64      -> {re = Pervasives.min_float; im = Pervasives.min_float}
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


(* ends here *)
