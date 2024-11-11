(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

open Owl_dense_ndarray_generic

type tnorm =
  | Backward
  | Forward
  | Ortho

let tnorm_to_int = function
  | Backward -> 0
  | Forward -> 1
  | Ortho -> 2

let fft ?axis ?(norm : tnorm = Backward) ?(nthreads : int = 1) x =
  let axis =
    match axis with
    | Some a -> a
    | None -> num_dims x - 1
  in
  let axis = if axis < 0 then num_dims x + axis else axis in
  assert (axis < num_dims x);
  let y = empty (kind x) (shape x) in
  Owl_fftpack._owl_cfftf (kind x) x y axis (tnorm_to_int norm) nthreads;
  y


let ifft ?axis ?(norm : tnorm = Forward) ?(nthreads : int = 1) x =
  let axis =
    match axis with
    | Some a -> a
    | None -> num_dims x - 1
  in
  let axis = if axis < 0 then num_dims x + axis else axis in
  assert (axis < num_dims x);
  let y = empty (kind x) (shape x) in
  Owl_fftpack._owl_cfftb (kind x) x y axis (tnorm_to_int norm) nthreads;
  y


let rfft ?axis ?(norm : tnorm = Backward) ?(nthreads : int = 1) ~(otyp : ('a, 'b) kind) x =
  let axis =
    match axis with
    | Some a -> a
    | None -> num_dims x - 1
  in
  let axis = if axis < 0 then num_dims x + axis else axis in
  assert (axis < num_dims x);
  let s = shape x in
  s.(axis) <- (s.(axis) / 2) + 1;
  let y = empty otyp s in
  let ityp = kind x in
  Owl_fftpack._owl_rfftf ityp otyp x y axis (tnorm_to_int norm) nthreads;
  y


let irfft ?axis ?n ?(norm : tnorm = Forward) ?(nthreads : int = 1) ~(otyp : ('a, 'b) kind) x =
  let axis =
    match axis with
    | Some a -> a
    | None -> num_dims x - 1
  in
  let axis = if axis < 0 then num_dims x + axis else axis in
  assert (axis < num_dims x);
  let s = shape x in
  let _ =
    match n with
    | Some n -> s.(axis) <- n
    | None -> s.(axis) <- (s.(axis) - 1) * 2
  in
  let y = empty otyp s in
  let ityp = kind x in
  Owl_fftpack._owl_rfftb ityp otyp x y axis (tnorm_to_int norm) nthreads;
  y


let fft2 x = fft ~axis:0 x |> fft ~axis:1

let ifft2 x = ifft ~axis:0 x |> ifft ~axis:1

type ttrig_transform  =
  | I
  | II
  | III
  | IV

let ttrig_transform_to_int = function
  | I -> 1
  | II -> 2
  | III -> 3
  | IV -> 4

let dct ?axis ?(ttype: ttrig_transform = II) ?(norm : tnorm = Backward) ?(ortho : bool option) ?(nthreads = 1) x =
  let axis =
    match axis with
    | Some a -> a
    | None -> num_dims x - 1
  in
  let axis = if axis < 0 then num_dims x + axis else axis in
  assert (axis < num_dims x);
  let ortho =
    match ortho with
    | Some o -> o
    | None -> if norm = Ortho then true else false
  in
  let y = empty (kind x) (shape x) in
  Owl_fftpack._owl_dctf (kind x) x y axis (ttrig_transform_to_int ttype) (tnorm_to_int norm) ortho nthreads;
  y


let idct ?axis ?(ttype: ttrig_transform = II) ?(norm : tnorm = Forward) ?(ortho : bool option) ?(nthreads = 1) x =
  let axis =
    match axis with
    | Some a -> a
    | None -> num_dims x - 1
  in
  let axis = if axis < 0 then num_dims x + axis else axis in
  assert (axis < num_dims x);
  let ortho =
    match ortho with
    | Some o -> o
    | None -> if norm = Ortho then true else false
  in
  let y = empty (kind x) (shape x) in
  Owl_fftpack._owl_dctb (kind x) x y axis (ttrig_transform_to_int ttype) (tnorm_to_int norm) ortho nthreads;
  y


let dst ?axis ?(ttype: ttrig_transform = II) ?(norm : tnorm = Backward) ?(ortho : bool option) ?(nthreads = 1) x =
  let axis =
    match axis with
    | Some a -> a
    | None -> num_dims x - 1
  in
  let axis = if axis < 0 then num_dims x + axis else axis in
  assert (axis < num_dims x);
  let ortho =
    match ortho with
    | Some o -> o
    | None -> if norm = Ortho then true else false
  in
  let y = empty (kind x) (shape x) in
  Owl_fftpack._owl_dstf (kind x) x y axis (ttrig_transform_to_int ttype) (tnorm_to_int norm) ortho nthreads;
  y


let idst ?axis ?(ttype = III) ?(norm : tnorm = Forward) ?(ortho : bool option) ?(nthreads = 1) x =
  let axis =
    match axis with
    | Some a -> a
    | None -> num_dims x - 1
  in
  let axis = if axis < 0 then num_dims x + axis else axis in
  assert (axis < num_dims x);
  let ortho =
    match ortho with
    | Some o -> o
    | None -> if norm = Ortho then true else false
  in
  let y = empty (kind x) (shape x) in
  Owl_fftpack._owl_dstb (kind x) x y axis (ttrig_transform_to_int ttype) (tnorm_to_int norm) ortho nthreads;
  y
