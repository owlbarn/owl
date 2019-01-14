(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray


(* interface to owl's c functions, types for interfacing to owl *)

type ('a, 'b) owl_arr = ('a, 'b, c_layout) Genarray.t


type ('a, 'b) owl_arr_op00 = int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int

type ('a, 'b) owl_arr_op01 = int -> ('a, 'b) owl_arr -> int

type ('a, 'b) owl_arr_op02 = int -> ('a, 'b) owl_arr -> float

type ('a, 'b) owl_arr_op03 = int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit

type ('a, 'b) owl_arr_op04 = int -> ('a, 'b) owl_arr -> 'a

type ('a, 'b) owl_arr_op05 = int -> 'a -> ('a, 'b) owl_arr -> 'a

type ('a, 'b) owl_arr_op06 = int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a

type ('a, 'b) owl_arr_op07 = int -> 'a -> 'a -> ('a, 'b) owl_arr -> unit

type ('a, 'b) owl_arr_op08 = int -> float -> 'a -> 'a -> ('a, 'b) owl_arr -> unit

type ('a, 'b) owl_arr_op09 = int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit

type ('a, 'b) owl_arr_op10 = int -> ('a, 'b) owl_arr -> 'a -> int

type ('a, 'b) owl_arr_op11 = int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> 'a -> unit

type ('a, 'b) owl_arr_op12 = int -> ('a, 'b) owl_arr -> float -> int -> unit

type ('a, 'b) owl_arr_op13 = int -> ('a, 'b) owl_arr -> 'a -> 'a -> unit

type ('a, 'b) owl_arr_op14 = int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> unit

type ('a, 'b) owl_arr_op15 = int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> float -> int

type ('a, 'b) owl_arr_op16 = int -> ('a, 'b) owl_arr -> 'a -> float -> int

type ('a, 'b) owl_arr_op17 = ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit

type ('a, 'b) owl_arr_op18 = int -> ?ofsx:int -> ?incx:int -> ?ofsy:int -> ?incy:int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit

type ('a, 'b, 'c, 'd) owl_arr_op19 = int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('c, 'd) owl_arr -> unit

type ('a, 'b) owl_arr_op20 = int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> int -> ('a, 'b) owl_arr -> int -> int -> int -> int -> unit

type ('a, 'b) owl_arr_op21 = int -> int -> int -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit

type ('a, 'b) owl_arr_op22 = ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit

type ('a, 'b) owl_arr_op23 = ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit

type ('a, 'b) owl_arr_op24 = ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit

type ('a, 'b) owl_arr_op25 = ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit

type ('a, 'b) owl_arr_op26 = ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit

type ('a, 'b) owl_arr_op27 = ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit

type ('a, 'b) owl_arr_op28 = ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit

type ('a, 'b) owl_arr_op29 = ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit

type ('a, 'b) owl_arr_op30 = ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit

type ('a, 'b) owl_arr_op31 = ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit

type ('a, 'b) owl_arr_op32 = ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit

type ('a, 'b) owl_arr_op33 = int -> 'a -> 'a -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> unit

type ('a, 'b) owl_arr_op34 = ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit

type ('a, 'b) owl_arr_op35 = ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> int -> unit
