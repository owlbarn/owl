(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_dense_ndarray_generic


val fft : ?axis:int -> (Complex.t, complex32_elt) t -> (Complex.t, complex32_elt) t

val ifft : ?axis:int -> (Complex.t, complex32_elt) t -> (Complex.t, complex32_elt) t

val rfft : ?axis:int -> (float, float32_elt) t -> (Complex.t, complex32_elt) t

val irfft : ?axis:int -> ?n:int -> (Complex.t, complex32_elt) t -> (float, float32_elt) t
