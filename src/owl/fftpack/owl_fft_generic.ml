(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

open Owl_dense_ndarray_generic

let fft ?axis ?(norm : int = 0) ?(nthreads : int = 1) x =
  let axis =
    match axis with
    | Some a -> a
    | None -> num_dims x - 1
  in
  let axis = if axis < 0 then num_dims x + axis else axis in
  assert (axis < num_dims x);
  let y = empty (kind x) (shape x) in
  Owl_fftpack._owl_cfftf (kind x) x y axis norm nthreads;
  y


let ifft ?axis ?(norm : int = 1) ?(nthreads : int = 1) x =
  let axis =
    match axis with
    | Some a -> a
    | None -> num_dims x - 1
  in
  let axis = if axis < 0 then num_dims x + axis else axis in
  assert (axis < num_dims x);
  let y = empty (kind x) (shape x) in
  Owl_fftpack._owl_cfftb (kind x) x y axis norm nthreads;
  y


let rfft ?axis ?(norm : int = 0) ?(nthreads : int = 1) ~(otyp : ('a, 'b) kind) x =
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
  Owl_fftpack._owl_rfftf ityp otyp x y axis norm nthreads;
  y


let irfft ?axis ?n ?(norm : int = 1) ?(nthreads : int = 1) ~(otyp : ('a, 'b) kind) x =
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
  Owl_fftpack._owl_rfftb ityp otyp x y axis norm nthreads;
  y


let fft2 x = fft ~axis:0 x |> fft ~axis:1

let ifft2 x = ifft ~axis:0 x |> ifft ~axis:1

let dct ?axis ?(ttype = 2) ?(norm : int = 0) ?(ortho : bool option) ?(nthreads = 1) x =
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
    | None -> if norm = 2 then true else false
  in
  assert (ttype > 0 || ttype < 5);
  let y = empty (kind x) (shape x) in
  Owl_fftpack._owl_dctf (kind x) x y axis ttype norm ortho nthreads;
  y


let idct ?axis ?(ttype = 3) ?(norm : int = 1) ?(ortho : bool option) ?(nthreads = 1) x =
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
    | None -> if norm = 2 then true else false
  in
  assert (ttype > 0 || ttype < 5);
  let y = empty (kind x) (shape x) in
  Owl_fftpack._owl_dctb (kind x) x y axis ttype norm ortho nthreads;
  y


let dst ?axis ?(ttype = 2) ?(norm : int = 0) ?(ortho : bool option) ?(nthreads = 1) x =
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
    | None -> if norm = 2 then true else false
  in
  assert (ttype > 0 || ttype < 5);
  let y = empty (kind x) (shape x) in
  Owl_fftpack._owl_dstf (kind x) x y axis ttype norm ortho nthreads;
  y


let idst ?axis ?(ttype = 3) ?(norm : int = 1) ?(ortho : bool option) ?(nthreads = 1) x =
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
    | None -> if norm = 2 then true else false
  in
  assert (ttype > 0 || ttype < 5);
  let y = empty (kind x) (shape x) in
  Owl_fftpack._owl_dstb (kind x) x y axis ttype norm ortho nthreads;
  y
