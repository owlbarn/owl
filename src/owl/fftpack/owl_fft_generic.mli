(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Fast Fourier Transform *)

open Bigarray
open Owl_dense_ndarray_generic


(** {6 Basic functions} *)

val fft : ?axis:int -> (Complex.t, 'a) t -> (Complex.t, 'a) t
(** [fft ~axis x] performs 1-dimensional FFT on a complex input. [axis] is the
  highest dimension if not specified. The return is not scaled.
 *)

val ifft : ?axis:int -> (Complex.t, 'a) t -> (Complex.t, 'a) t
(** [ifft ~axis x] performs inverse 1-dimensional FFT on a complex input. [axis]
  is the highest dimension by default.
 *)

val rfft : ?axis:int -> otyp:(Complex.t, 'a) kind -> (float, 'b) t -> (Complex.t, 'a) t
(** [rfft ~axis ~otyp x] performs 1-dimensional FFT on real input along the
  [axis]. [otyp] is used to specify the output type, it must be the consistent
  precision with input [x]. You can skip this parameter by using a submodule
  with specific precision such as [Owl.Fft.S] or [Owl.Fft.D].
 *)

val irfft : ?axis:int -> ?n:int -> otyp:(float, 'a) kind -> (Complex.t, 'b) t -> (float, 'a) t
(** [irfft ~axis ~n x] is the inverse function of [rfft]. Note the [n] parameter
  is used to specified the size of output.
 *)
