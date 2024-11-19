(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

open Bigarray
open Owl_dense_ndarray_generic
open Owl_fft_generic

val fft
  :  ?axis:int
  -> ?norm:tnorm
  -> ?nthreads:int
  -> (Complex.t, complex32_elt) Owl_dense_ndarray_generic.t
  -> (Complex.t, complex32_elt) Owl_dense_ndarray_generic.t

val ifft
  :  ?axis:int
  -> ?norm:tnorm
  -> ?nthreads:int
  -> (Complex.t, complex32_elt) Owl_dense_ndarray_generic.t
  -> (Complex.t, complex32_elt) Owl_dense_ndarray_generic.t

val rfft
  :  ?axis:int
  -> ?norm:tnorm
  -> ?nthreads:int
  -> (float, float32_elt) t
  -> (Complex.t, complex32_elt) t

val irfft
  :  ?axis:int
  -> ?n:int
  -> ?norm:tnorm
  -> ?nthreads:int
  -> (Complex.t, complex32_elt) t
  -> (float, float32_elt) t

val fft2 : ?norm:tnorm -> ?nthreads:int -> (Complex.t, complex32_elt) t -> (Complex.t, complex32_elt) t

val ifft2 : ?norm:tnorm -> ?nthreads:int -> (Complex.t, complex32_elt) t -> (Complex.t, complex32_elt) t

val dct
  :  ?axis:int
  -> ?ttype:ttrig_transform
  -> ?norm:tnorm
  -> ?ortho:bool
  -> ?nthreads:int
  -> (float, float32_elt) t
  -> (float, float32_elt) t

val idct
  :  ?axis:int
  -> ?ttype:ttrig_transform
  -> ?norm:tnorm
  -> ?ortho:bool
  -> ?nthreads:int
  -> (float, float32_elt) t
  -> (float, float32_elt) t

val dst
  :  ?axis:int
  -> ?ttype:ttrig_transform
  -> ?norm:tnorm
  -> ?ortho:bool
  -> ?nthreads:int
  -> (float, float32_elt) t
  -> (float, float32_elt) t

val idst
  :  ?axis:int
  -> ?ttype:ttrig_transform
  -> ?norm:tnorm
  -> ?ortho:bool
  -> ?nthreads:int
  -> (float, float32_elt) t
  -> (float, float32_elt) t
