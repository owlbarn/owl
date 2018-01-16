(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_dense_ndarray_generic


let fft x =
  let y = copy x in
  Owl_fftpack.cfftf y;
  y


let ifft x =
  let y = copy x in
  Owl_fftpack.cfftb y;
  y


let rfft x =
  let y = copy x in
  Owl_fftpack.rfftf y;
  let n = numel x / 2 + 1 in
  let z = empty Complex64 [|n|] in
  Owl_fftpack.halfcomplex_unpack y z;
  z


let irfft x =
  let y = copy x in
  Owl_fftpack.rfftb y;
  y
