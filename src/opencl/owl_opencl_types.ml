(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_dense_ndarray_s

open Owl_opencl_generated


type t =
  | F     of float
  | Arr   of arr
  | Trace of trace
and trace = {
  mutable op     : trace_op;
  mutable input  : trace array;
  mutable outval : t array;        (* output value, not Trace *)
  mutable outmem : cl_mem array;
  mutable events : cl_event array;
  mutable refnum : int;
}
and trace_op =
  | Noop
  | Add
  | Sub
  | Mul
  | Div
  | Sin
  | Cos
