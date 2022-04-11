(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

open Bigarray
open Owl_dense_ndarray_generic

val fft : ?axis:int -> (Complex.t, complex32_elt) t -> (Complex.t, complex32_elt) t

val ifft : ?axis:int -> (Complex.t, complex32_elt) t -> (Complex.t, complex32_elt) t

val rfft : ?axis:int -> (float, float32_elt) t -> (Complex.t, complex32_elt) t

val irfft : ?axis:int -> ?n:int -> (Complex.t, complex32_elt) t -> (float, float32_elt) t

val fft2 : (Complex.t, complex32_elt) t -> (Complex.t, complex32_elt) t

val ifft2 : (Complex.t, complex32_elt) t -> (Complex.t, complex32_elt) t
