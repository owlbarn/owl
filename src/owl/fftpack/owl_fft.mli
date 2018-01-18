(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_dense_ndarray_generic


val fft : ?axis:int -> (Complex.t, 'a) t -> (Complex.t, 'a) t

val ifft : ?axis:int -> (Complex.t, 'a) t -> (Complex.t, 'a) t
