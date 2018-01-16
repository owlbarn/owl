(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_dense_ndarray_generic


let fft ?axis x =
  let axis = match axis with
    | Some a -> a
    | None   -> num_dims x - 1
  in
  assert (axis < num_dims x);
  let y = empty (kind x) (shape x) in
  Owl_fftpack.cfftf x y axis;
  y


let ifft ?axis x =
  let axis = match axis with
    | Some a -> a
    | None   -> num_dims x - 1
  in
  assert (axis < num_dims x);
  let y = empty (kind x) (shape x) in
  Owl_fftpack.cfftb x y axis;
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
