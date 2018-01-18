(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_dense_ndarray_generic


val fft : ?axis:int -> (Complex.t, 'a) t -> (Complex.t, 'a) t

val ifft : ?axis:int -> (Complex.t, 'a) t -> (Complex.t, 'a) t

val rfft : ?axis:int -> otyp:(Complex.t, 'a) kind -> (float, 'b) t -> (Complex.t, 'a) t

val irfft : ?axis:int -> ?n:int -> otyp:(float, 'a) kind -> (Complex.t, 'b) t -> (float, 'a) t
