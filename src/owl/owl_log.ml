(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.caMD.ac.uk>
 *)

(** Log module provides logging functionality. *)

type level =
  | DEBUG
  | INFO
  | WARN
  | ERROR

let _level = INFO

let _colorful = true

let set_level x = _level = x

let color_on () = _colorful = true

let color_off () = _colorful = false
