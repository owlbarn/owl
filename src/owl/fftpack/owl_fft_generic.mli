(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(** Fast Fourier Transform *)

open Owl_dense_ndarray_generic

(** {5 Basic functions} *)

val fft : ?axis:int -> (Complex.t, 'a) t -> (Complex.t, 'a) t
(**
``fft ~axis x`` performs 1-dimensional FFT on a complex input. ``axis`` is the
highest dimension if not specified. The return is not scaled.
 *)

val ifft : ?axis:int -> (Complex.t, 'a) t -> (Complex.t, 'a) t
(**
``ifft ~axis x`` performs inverse 1-dimensional FFT on a complex input. ``axis``
is the highest dimension by default.
 *)

val rfft : ?axis:int -> otyp:(Complex.t, 'a) kind -> (float, 'b) t -> (Complex.t, 'a) t
(**
``rfft ~axis ~otyp x`` performs 1-dimensional FFT on real input along the
``axis``. ``otyp`` is used to specify the output type, it must be the consistent
precision with input ``x``. You can skip this parameter by using a submodule
with specific precision such as ``Owl.Fft.S`` or ``Owl.Fft.D``.
 *)

val irfft
  :  ?axis:int
  -> ?n:int
  -> otyp:(float, 'a) kind
  -> (Complex.t, 'b) t
  -> (float, 'a) t
(**
``irfft ~axis ~n x`` is the inverse function of ``rfft``. Note the ``n`` parameter
is used to specified the size of output.
 *)

val fft2 : (Complex.t, 'a) t -> (Complex.t, 'a) t
(**
``fft2 x`` performs 2-dimensional FFT on a complex input. The return is not scaled.
 *)

val ifft2 : (Complex.t, 'a) t -> (Complex.t, 'a) t
(**
``ifft2 x`` performs inverse 2-dimensional FFT on a complex input.
 *)
