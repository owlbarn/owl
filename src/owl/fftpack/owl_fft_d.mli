(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_dense_ndarray_generic


val fft : ?axis:int -> (Complex.t, complex64_elt) t -> (Complex.t, complex64_elt) t

val ifft : ?axis:int -> (Complex.t, complex64_elt) t -> (Complex.t, complex64_elt) t

val rfft : ?axis:int -> (float, float64_elt) t -> (Complex.t, complex64_elt) t

val irfft : ?axis:int -> ?n:int -> (Complex.t, complex64_elt) t -> (float, float64_elt) t
