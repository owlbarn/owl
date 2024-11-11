(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

open Bigarray
open Owl_dense_ndarray_generic

val fft
  :  ?axis:int
  -> ?norm:int
  -> ?nthreads:int
  -> (Complex.t, complex32_elt) Owl_dense_ndarray_generic.t
  -> (Complex.t, complex32_elt) Owl_dense_ndarray_generic.t

val ifft
  :  ?axis:int
  -> ?norm:int
  -> ?nthreads:int
  -> (Complex.t, complex32_elt) Owl_dense_ndarray_generic.t
  -> (Complex.t, complex32_elt) Owl_dense_ndarray_generic.t

val rfft
  :  ?axis:int
  -> ?norm:int
  -> ?nthreads:int
  -> (float, float32_elt) t
  -> (Complex.t, complex32_elt) t

val irfft
  :  ?axis:int
  -> ?n:int
  -> ?norm:int
  -> ?nthreads:int
  -> (Complex.t, complex32_elt) t
  -> (float, float32_elt) t

val fft2 : (Complex.t, complex32_elt) t -> (Complex.t, complex32_elt) t

val ifft2 : (Complex.t, complex32_elt) t -> (Complex.t, complex32_elt) t

val dct
  :  ?axis:int
  -> ?ttype:int
  -> ?norm:int
  -> ?ortho:bool
  -> ?nthreads:int
  -> (float, float32_elt) t
  -> (float, float32_elt) t

val idct
  :  ?axis:int
  -> ?ttype:int
  -> ?norm:int
  -> ?ortho:bool
  -> ?nthreads:int
  -> (float, float32_elt) t
  -> (float, float32_elt) t

val dst
  :  ?axis:int
  -> ?ttype:int
  -> ?norm:int
  -> ?ortho:bool
  -> ?nthreads:int
  -> (float, float32_elt) t
  -> (float, float32_elt) t

val idst
  :  ?axis:int
  -> ?ttype:int
  -> ?norm:int
  -> ?ortho:bool
  -> ?nthreads:int
  -> (float, float32_elt) t
  -> (float, float32_elt) t
