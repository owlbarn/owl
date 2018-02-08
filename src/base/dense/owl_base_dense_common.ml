(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray


(* basic operations on individual element *)

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
