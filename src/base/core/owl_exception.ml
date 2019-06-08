(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(* Exception definition *)

exception NOT_IMPLEMENTED of string

exception NOT_SUPPORTED

exception FOUND

exception NOT_FOUND

exception EMPTY_ARRAY

exception TEST_FAIL

exception NOT_SQUARE of int array

exception DIFFERENT_SHAPE of (int array * int array)

exception NOT_BROADCASTABLE

exception NOT_CONVERGE

exception MAX_ITERATION

exception SINGULAR

exception NOT_SIMPLEX

exception INDEX_OUT_OF_BOUND

exception ZOO_ILLEGAL_GIST_NAME


(* Core functions *)

let check p e =
  if p = false then raise e


let different_shape sx sy =
  let s0 = Array.to_list sx |> List.map string_of_int |> String.concat "," in
  let s1 = Array.to_list sy |> List.map string_of_int |> String.concat "," in
  Printf.sprintf "[ %s ] and [ %s ] are different shapes." s0 s1


let not_implemented s = Printf.sprintf "%s is not implemented." s


let not_square x =
  let s = Array.to_list x |> List.map string_of_int |> String.concat "," in
  Printf.sprintf "[ %s ] is not square." s


let to_string = function
  | DIFFERENT_SHAPE (sx, sy) -> different_shape sx sy
  | NOT_IMPLEMENTED s        -> not_implemented s
  | NOT_SQUARE x             -> not_square x
  | _                        -> "unknown exception"
