(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Fast Fourier Transforms (FFTs) *)

type rmat = Owl_dense_real.mat

type cmat = Owl_dense_complex.mat

val fft : rmat -> cmat

val fft_complex : cmat -> cmat

val ifft : cmat -> cmat

val fft2 : rmat -> cmat

val fft2_complex : cmat -> cmat

val ifft2 : cmat -> cmat

val fftshift : cmat -> cmat

val ifftshift : cmat -> cmat
(** [ifftshift x] undoes the results of [fftshift x], it is the inverse operation
  of [fftshift]. Note that calling [fftshift] twice such as [fftshift (fftshift x)]
  will not give you the same [x] if there is an odd number of elements.
 *)
