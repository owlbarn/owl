(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_dense_ndarray_generic


let fft ?axis x =
  let axis = match axis with
    | Some a -> a
    | None   -> num_dims x - 1
  in
  assert (axis < num_dims x);
  let y = empty (kind x) (shape x) in
  Owl_fftpack._owl_cfftf (kind x) x y axis;
  y


let ifft ?axis x =
  let axis = match axis with
    | Some a -> a
    | None   -> num_dims x - 1
  in
  assert (axis < num_dims x);
  let y = empty (kind x) (shape x) in
  Owl_fftpack._owl_cfftb (kind x) x y axis;
  let norm = Complex.{re = float_of_int (shape y).(axis); im = 0.} in
  div_scalar_ y norm;
  y


let rfft ?axis ~otyp x =
  let axis = match axis with
    | Some a -> a
    | None   -> num_dims x - 1
  in
  assert (axis < num_dims x);
  let s = shape x in
  s.(axis) <- s.(axis) / 2 + 1;
  let y = empty otyp s in
  let ityp = kind x in
  Owl_fftpack._owl_rfftf ityp otyp x y axis;
  y


let irfft ?axis ?n ~otyp x =
  let axis = match axis with
    | Some a -> a
    | None   -> num_dims x - 1
  in
  assert (axis < num_dims x);
  let s = shape x in
  let _ = match n with
    | Some n -> s.(axis) <- n
    | None   -> s.(axis) <- (s.(axis) - 1) * 2
  in
  let y = empty otyp s in
  let ityp = kind x in
  Owl_fftpack._owl_rfftb ityp otyp x y axis;
  let norm = float_of_int s.(axis) in
  div_scalar_ y norm;
  y
