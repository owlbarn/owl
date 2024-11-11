(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(** Fast Fourier Transform *)

open Owl_dense_ndarray_generic

(** {5 Discrete Fourier Transforms functions} *)

val fft
  :  ?axis:int
  -> ?norm:int
  -> ?nthreads:int
  -> (Complex.t, 'a) t
  -> (Complex.t, 'a) t
(** [fft ~axis x] performs 1-dimensional FFT on a complex input. [axis] is the
    highest dimension if not specified. The return is not scaled. *)

val ifft
  :  ?axis:int
  -> ?norm:int
  -> ?nthreads:int
  -> (Complex.t, 'a) t
  -> (Complex.t, 'a) t
(** [ifft ~axis x] performs inverse 1-dimensional FFT on a complex input. The parameter [axis]
    indicates the highest dimension by default. *)

val rfft
  :  ?axis:int
  -> ?norm:int
  -> ?nthreads:int
  -> otyp:('a, 'b) kind
  -> ('c, 'd) t
  -> ('a, 'b) t
(** [rfft ~axis ~otyp x] performs 1-dimensional FFT on real input along the
    [axis]. [otyp] is used to specify the output type, it must be the consistent
    precision with input [x]. You can skip this parameter by using a submodule
    with specific precision such as [Owl.Fft.S] or [Owl.Fft.D]. *)

val irfft
  :  ?axis:int
  -> ?n:int
  -> ?norm:int
  -> ?nthreads:int
  -> otyp:('a, 'b) kind
  -> ('c, 'd) t
  -> ('a, 'b) t
(** [irfft ~axis ~n x] is the inverse function of [rfft]. Note the [n] parameter
    is used to specified the size of output. *)

val fft2 : (Complex.t, 'a) t -> (Complex.t, 'a) t
(** [fft2 x] performs 2-dimensional FFT on a complex input. The return is not scaled. *)

val ifft2 : (Complex.t, 'a) t -> (Complex.t, 'a) t
(** [ifft2 x] performs inverse 2-dimensional FFT on a complex input. *)

(** {5 Discrete Cosine & Sine Transforms functions} *)

val dct
  :  ?axis:int
  -> ?ttype:int
  -> ?norm:int
  -> ?ortho:bool
  -> ?nthreads:int
  -> ('a, 'b) t
  -> ('a, 'b) t
(** [dct ~axis ~type x] performs 1-dimensional Discrete Cosine Transform (DCT) on a real input. Default type is 2. *)

val idct
  :  ?axis:int
  -> ?ttype:int
  -> ?norm:int
  -> ?ortho:bool
  -> ?nthreads:int
  -> ('a, 'b) t
  -> ('a, 'b) t
(** [idct ~axis ~type x] performs inverse 1-dimensional Discrete Cosine Transform (DCT) on a real input. Default type is 2. *)

val dst
  :  ?axis:int
  -> ?ttype:int
  -> ?norm:int
  -> ?ortho:bool
  -> ?nthreads:int
  -> ('a, 'b) t
  -> ('a, 'b) t
(** [dst ~axis ~type x] performs 1-dimensional Discrete Sine Transform (DST) on a real input. Default type is 2. *)

val idst
  :  ?axis:int
  -> ?ttype:int
  -> ?norm:int
  -> ?ortho:bool
  -> ?nthreads:int
  -> ('a, 'b) t
  -> ('a, 'b) t
(** [idst ~axis ~type x] performs inverse 1-dimensional Discrete Sine Transform (DST) on a real input. Default type is 2. *)
