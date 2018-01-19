(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_dense_ndarray_generic


val fft : ?axis:int -> (Complex.t, complex64_elt) t -> (Complex.t, complex64_elt) t

val ifft : ?axis:int -> (Complex.t, complex64_elt) t -> (Complex.t, complex64_elt) t

val rfft : ?axis:int -> (float, float64_elt) t -> (Complex.t, complex64_elt) t

val irfft : ?axis:int -> ?n:int -> (Complex.t, complex64_elt) t -> (float, float64_elt) t
