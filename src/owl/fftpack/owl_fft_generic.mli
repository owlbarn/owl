(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(** Fast Fourier Transform *)

open Owl_dense_ndarray_generic

(** Normalisation options for transforms. *)
type tnorm =
  | Backward (** No normalization on Forward and scaling by 1/N on Backward *)
  | Forward (** Normalization by 1/N on the Forward transform. *)
  | Ortho (** Forward and Backward are scaled by 1/sqrt(N) *)

(** {5 Discrete Fourier Transforms functions} *)

val fft
  :  ?axis:int
  -> ?norm:tnorm
  -> ?nthreads:int
  -> (Complex.t, 'a) t
  -> (Complex.t, 'a) t
(** [fft ~axis ~norm x] performs 1-dimensional FFT on a complex input. [axis] is the
    highest dimension if not specified. [norm] is the normalization option. By default, [norm] is set to [Backward].
    [nthreads] is the desired number of threads used to compute the fft. *)

val ifft
  :  ?axis:int
  -> ?norm:tnorm
  -> ?nthreads:int
  -> (Complex.t, 'a) t
  -> (Complex.t, 'a) t
(** [ifft ~axis x] performs inverse 1-dimensional FFT on a complex input. The parameter [axis]
    indicates the highest dimension by default. [norm] is the normalization option. By default, [norm] is set to [Forward].
    [nthreads] is the desired number of threads used to compute the fft. *)

val rfft
  :  ?axis:int
  -> ?norm:tnorm
  -> ?nthreads:int
  -> otyp:('a, 'b) kind
  -> ('c, 'd) t
  -> ('a, 'b) t
(** [rfft ~axis ~otyp x] performs 1-dimensional FFT on real input along the
    [axis]. [norm] is the normalization option. By default, [norm] is set to [Backward].
    [nthreads] is the desired number of threads used to compute the fft.
    [otyp] is used to specify the output type, it must be the consistent precision with input [x].
    You can skip this parameter by using a submodule with specific precision such as [Owl.Fft.S] or [Owl.Fft.D]. *)

val irfft
  :  ?axis:int
  -> ?n:int
  -> ?norm:tnorm
  -> ?nthreads:int
  -> otyp:('a, 'b) kind
  -> ('c, 'd) t
  -> ('a, 'b) t
(** [irfft ~axis ~n x] is the inverse function of [rfft]. [norm] is the normalization option.
    By default, [norm] is set to [Forward].
    [nthreads] is the desired number of threads used to compute the fft.
    Note the [n] parameter is used to specified the size of output. *)

val fft2 : (Complex.t, 'a) t -> (Complex.t, 'a) t
(** [fft2 x] performs 2-dimensional FFT on a complex input. The return is not scaled. *)

val ifft2 : (Complex.t, 'a) t -> (Complex.t, 'a) t
(** [ifft2 x] performs inverse 2-dimensional FFT on a complex input. *)

(** {5 Discrete Cosine & Sine Transforms functions} *)

type ttrig_transform  =
  | I
  | II
  | III
  | IV
(** Trigonometric (Cosine and Sine) transform types. *)

val dct
  :  ?axis:int
  -> ?ttype:ttrig_transform
  -> ?norm:tnorm
  -> ?ortho:bool
  -> ?nthreads:int
  -> ('a, 'b) t
  -> ('a, 'b) t
(** [dct ?axis ?ttype ?norm ?ortho ?nthreads x] performs 1-dimensional Discrete Cosine Transform (DCT) on a real input.
    [ttype] is the DCT type to use for this transform. Default value is [II].
    [norm] is the normalization option. By default, [norm] is set to [Backward].
    [ortho] constrols whether or not we should use the orthogonalized variant of the DCT. *)

val idct
  :  ?axis:int
  -> ?ttype:ttrig_transform
  -> ?norm:tnorm
  -> ?ortho:bool
  -> ?nthreads:int
  -> ('a, 'b) t
  -> ('a, 'b) t
(** [idct ?axis ?ttype ?norm ?ortho ?nthreads x] performs inverse 1-dimensional Discrete Cosine Transform (DCT) on a real input.
    [ttype] is the DCT type to use for this transform. Default value is [II].
    [norm] is the normalization option. By default, [norm] is set to [Forward].
    [ortho] constrols whether or not we should use the orthogonalized variant of the DCT. *)

val dst
  :  ?axis:int
  -> ?ttype:ttrig_transform
  -> ?norm:tnorm
  -> ?ortho:bool
  -> ?nthreads:int
  -> ('a, 'b) t
  -> ('a, 'b) t
(** [dst ?axis ?ttype ?norm ?ortho ?nthreads x] performs 1-dimensional Discrete Sine Transform (DCT) on a real input.
    [ttype] is the DCT type to use for this transform. Default value is [II].
    [norm] is the normalization option. By default, [norm] is set to [Backward].
    [ortho] constrols whether or not we should use the orthogonalized variant of the DST. *)

val idst
  :  ?axis:int
  -> ?ttype:ttrig_transform
  -> ?norm:tnorm
  -> ?ortho:bool
  -> ?nthreads:int
  -> ('a, 'b) t
  -> ('a, 'b) t
(** [idst ?axis ?ttype ?norm ?ortho ?nthreads x] performs inverse 1-dimensional Discrete Sine Transform (DST) on a real input.
    [ttype] is the DST type to use for this transform. Default value is [II].
    [norm] is the normalization option. By default, [norm] is set to [Forward].
    [ortho] constrols whether or not we should use the orthogonalized variant of the DST. *)