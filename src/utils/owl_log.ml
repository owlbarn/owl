(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.caMD.ac.uk>
 *)

(** Log module provides logging functionality. *)

type color = Red | Green | Yellow | Blue | Magenta | Cyan

type level = DEBUG | INFO | WARN | ERROR

let _level_to_int = function
  | DEBUG -> 0
  | INFO  -> 1
  | WARN  -> 2
  | ERROR -> 3

let _color_to_str = function
  | Red     -> "\027[31m"
  | Green   -> "\027[32m"
  | Yellow  -> "\027[33m"
  | Blue    -> "\027[34m"
  | Magenta -> "\027[35m"
  | Cyan    -> "\027[36m"

let _level = ref INFO

let _output = ref stderr

let _colorful = ref true

let set_level x = _level := x

let set_output x = _output := x

let set_color x = _colorful := x

let _shall_print x = (_level_to_int x) >= (_level_to_int !_level)

let _shall_paint c s =
  match !_colorful with
  | true  -> (_color_to_str c) ^ s ^ "\027[0m"
  | false -> s

let _level_to_str = function
  | DEBUG -> _shall_paint Cyan "DEBUG"
  | INFO  -> _shall_paint Green "INFO"
  | WARN  -> _shall_paint Yellow "WARN"
  | ERROR -> _shall_paint Red "ERROR"

let make_prefix lvl =
  let ts = Unix.gettimeofday() in
  let tm = Unix.localtime ts in
  Printf.sprintf "%04d-%02d-%02d %02d:%02d:%02d.%03d %s : "
    (tm.Unix.tm_year + 1900)
    (tm.Unix.tm_mon + 1)
    tm.Unix.tm_mday
    tm.Unix.tm_hour
    tm.Unix.tm_min
    tm.Unix.tm_sec
    (modf ts |> fst |> ( *. ) 1000. |> int_of_float)
    (_level_to_str lvl)

let _log lvl fmt =
  match _shall_print lvl with
  | true  -> Printf.fprintf !_output ("%s" ^^ fmt ^^ "\n%!") (make_prefix lvl)
  | false -> Printf.ifprintf !_output fmt

let error fmt = _log ERROR fmt

let warn fmt = _log WARN  fmt

let info fmt = _log INFO  fmt

let debug fmt = _log DEBUG fmt
