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
