(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* Exception definition *)

exception CONV_INVALID_ARGUMENT

exception NOT_IMPLEMENTED of string

exception NOT_SUPPORTED

exception FOUND

exception NOT_FOUND

exception EMPTY_ARRAY

exception TEST_FAIL

exception INVALID_ARGUMENT of string

exception INVALID_PROBABILITY of float

exception LINALG_MATRIX_DOT_SHAPE of (int * int * int * int)

exception NOT_SQUARE of int array

exception NOT_MATRIX of int array

exception NON_NEGATIVE_INT of int

exception DIFFERENT_SHAPE of (int array * int array)

exception DIFFERENT_SIZE of (int * int)

exception NOT_BROADCASTABLE

exception NOT_CONVERGE

exception MAX_ITERATION

exception SINGULAR

exception NOT_SIMPLEX

exception INDEX_OUT_OF_BOUND

exception ZOO_ILLEGAL_GIST_NAME

(* Core functions *)

let check p e = if p = false then raise e

let verify p f = if p = false then raise (f ())

let different_shape sx sy =
  let prefix = "Owl_exception.DIFFERENT_SHAPE:" in
  let s0 = Array.to_list sx |> List.map string_of_int |> String.concat "," in
  let s1 = Array.to_list sy |> List.map string_of_int |> String.concat "," in
  Printf.sprintf "%s [ %s ] and [ %s ] are different shapes." prefix s0 s1


let different_size m n =
  let prefix = "Owl_exception.DIFFERENT_SIZE:" in
  Printf.sprintf "%s %i is not equal to %i." prefix m n


let invalid_argument s =
  let prefix = "Owl_exception.INVALID_ARGUMENT:" in
  Printf.sprintf "%s %s" prefix s


let invalid_probability p =
  let prefix = "Owl_exception.INVALID_PROBABILITY:" in
  Printf.sprintf "%s %g is not a valid probability, it should be within [0,1]." prefix p


let linalg_matrix_dot_shape combined_shape =
  let xm, xn, ym, yn = combined_shape in
  let prefix = "Owl_exception.LINALG_MATRIX_DOT_SHAPE:" in
  Printf.sprintf "%s x[%i,%i] *@ y[%i,%i] is invalid." prefix xm xn ym yn


let non_negative_int i =
  let prefix = "Owl_exception.NON_NEGATIVE_INT:" in
  Printf.sprintf "%s input should be non-negative, but %i is negative." prefix i


let not_implemented s =
  let prefix = "Owl_exception.NOT_IMPLEMENTED:" in
  Printf.sprintf "%s %s is not implemented." prefix s


let not_square x =
  let prefix = "Owl_exception.NOT_SQUARE:" in
  let s = Array.to_list x |> List.map string_of_int |> String.concat "," in
  Printf.sprintf "%s matrix [ %s ] is not square." prefix s


let to_string = function
  | DIFFERENT_SHAPE (sx, sy)  -> different_shape sx sy
  | DIFFERENT_SIZE (m, n)     -> different_size m n
  | INVALID_ARGUMENT s        -> invalid_argument s
  | INVALID_PROBABILITY p     -> invalid_probability p
  | LINALG_MATRIX_DOT_SHAPE s -> linalg_matrix_dot_shape s
  | NON_NEGATIVE_INT i        -> non_negative_int i
  | NOT_IMPLEMENTED s         -> not_implemented s
  | NOT_SQUARE x              -> not_square x
  | other                     -> Printexc.to_string other


let pp_exception formatter x =
  Format.open_box 0;
  Format.fprintf formatter "%s" (to_string x);
  Format.close_box ()
