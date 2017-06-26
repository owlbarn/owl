(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Fast Fourier Transforms (FFTs) *)

(** This module implements some basic FFT operations. Most of them are similar
  to the same funcitons in Matlab, and you will find it very easy to use in
  case you are familiar with Matlab.
 *)


type rmat = Owl_dense_matrix_d.mat

type cmat = Owl_dense_matrix_z.mat

val fft : rmat -> cmat
(** [fft x] performs an FFT operation on matrix [x]. If [x] has more than one
  row, then one FFT operation will be performed on each of them. The input is
  a real dense matrix, and the returned result is a complex dense matrix.
 *)

val fft_complex : cmat -> cmat
(** [fft_complex x] is similar to [fft x] but is performed on complex matrices. *)

val ifft : cmat -> cmat
(** [ifft x] performs the inverse operation of FFT on [x]. Note the input [x] is
  a complex matrix, both the output from [fft x] and [fft_complex x] can be used
  as the input of [ifft].
 *)

val fft2 : rmat -> cmat
(** [fft2 x] performns a two-dimensional FFT on a real matrix [x]. *)

val fft2_complex : cmat -> cmat
(** [fft2_complex x] is similar to [fft2 x] but is performed on complex matrices. *)

val ifft2 : cmat -> cmat
(** [ifft2 x] performs the inverse operation of FFT on [x], i.e., the inverse
  function of both [fft2] and [fft2_complex].
 *)

val fftshift : cmat -> cmat
(** [fftshift x] shifts the zero frequency component in the middle. This is
  especially useful when plotting the figures.
 *)

val ifftshift : cmat -> cmat
(** [ifftshift x] undoes the results of [fftshift x], it is the inverse operation
  of [fftshift]. Note that calling [fftshift] twice such as [fftshift (fftshift x)]
  will not give you the same [x] if there is an odd number of elements.
 *)
