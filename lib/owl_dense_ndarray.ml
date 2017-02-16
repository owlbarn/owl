(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_dense_common

type ('a, 'b) t = ('a, 'b, c_layout) Genarray.t

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

(* Basic functions from Genarray module *)

let empty kind dimension = Genarray.create kind c_layout dimension

let get x i = Genarray.get x i

let set x i a = Genarray.set x i a

let num_dims x = Genarray.num_dims x

let shape x = Genarray.dims x

let nth_dim x i = Genarray.nth_dim x i

let numel x = Array.fold_right (fun c a -> c * a) (shape x) 1

let kind x = Genarray.kind x

let layout x = Genarray.layout x

let size_in_bytes x = Genarray.size_in_bytes x

let sub_left = Genarray.sub_left

let sub_right = Genarray.sub_right

let slice_left = Genarray.slice_left

let slice_right = Genarray.slice_right

let copy src dst = Genarray.blit src dst

let fill x a = Genarray.fill x a

let reshape x dimension = reshape x dimension

let mmap fd ?pos kind shared dims = Genarray.map_file fd ?pos kind c_layout shared dims

let same_shape x y =
  if (num_dims x) <> (num_dims y) then false
  else (
    let s0 = shape x in
    let s1 = shape y in
    let b = ref true in
    Array.iteri (fun i d ->
      if s0.(i) <> s1.(i) then b := false
    ) s0;
    !b
  )

let clone x =
  let y = empty (kind x) (shape x) in
  Genarray.blit x y;
  y

(* TODO: zpxy, zmxy, ssqr_diff *)

(* TODO: add axis paramater *)

let min : type a b . (a, b) t -> a = fun x ->
  let k = kind x in
  match k with
  | Complex32 -> (_min k) (ndarray_to_fortran_vec x)
  | Complex64 -> (_min k) (ndarray_to_fortran_vec x)
  | _ -> (_gsl_min k) (ndarray_to_c_mat x)

let max : type a b . (a, b) t -> a = fun x ->
  let k = kind x in
  match k with
  | Complex32 -> (_max k) (ndarray_to_fortran_vec x)
  | Complex64 -> (_max k) (ndarray_to_fortran_vec x)
  | _ -> (_gsl_max k) (ndarray_to_c_mat x)

let minmax x =
  let y = ndarray_to_c_mat x in
  let a, b = (_gsl_minmax (kind x)) y in
  a, b

let min_i x =
  let y = ndarray_to_c_mat x in
  let a, _, i = (_gsl_min_index (kind x)) y in
  let s = _calc_stride (shape x) in
  let j = Array.copy s in
  let _ = _index_1d_nd i j s in
  a, j

let max_i x =
  let y = ndarray_to_c_mat x in
  let a, _, i = (_gsl_max_index (kind x)) y in
  let s = _calc_stride (shape x) in
  let j = Array.copy s in
  let _ = _index_1d_nd i j s in
  a, j

let minmax_i x =
  let y = ndarray_to_c_mat x in
  let (a, _, i), (b, _, j) = (_gsl_minmax_index (kind x)) y in
  let s = _calc_stride (shape x) in
  let p = Array.copy s in
  let q = Array.copy s in
  let _ = _index_1d_nd i p s in
  let _ = _index_1d_nd j q s in
  (a, p), (b, q)

let add x y =
  let x' = Genarray.change_layout x fortran_layout in
  let x' = Bigarray.reshape_1 x' (numel x) in
  let y' = Genarray.change_layout y fortran_layout in
  let y' = Bigarray.reshape_1 y' (numel y) in
  let z = (_add (kind x)) x' y' in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let sub x y =
  let x' = Genarray.change_layout x fortran_layout in
  let x' = Bigarray.reshape_1 x' (numel x) in
  let y' = Genarray.change_layout y fortran_layout in
  let y' = Bigarray.reshape_1 y' (numel y) in
  let z = (_sub (kind x)) x' y' in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let mul x y =
  let x' = Genarray.change_layout x fortran_layout in
  let x' = Bigarray.reshape_1 x' (numel x) in
  let y' = Genarray.change_layout y fortran_layout in
  let y' = Bigarray.reshape_1 y' (numel y) in
  let z = (_mul (kind x)) x' y' in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let div x y =
  let x' = Genarray.change_layout x fortran_layout in
  let x' = Bigarray.reshape_1 x' (numel x) in
  let y' = Genarray.change_layout y fortran_layout in
  let y' = Bigarray.reshape_1 y' (numel y) in
  let z = (_div (kind x)) x' y' in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let pow x y =
  let x' = Genarray.change_layout x fortran_layout in
  let x' = Bigarray.reshape_1 x' (numel x) in
  let y' = Genarray.change_layout y fortran_layout in
  let y' = Bigarray.reshape_1 y' (numel y) in
  let z = (_pow (kind x)) x' y' in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let atan2 x y =
  let x' = Genarray.change_layout x fortran_layout in
  let x' = Bigarray.reshape_1 x' (numel x) in
  let y' = Genarray.change_layout y fortran_layout in
  let y' = Bigarray.reshape_1 y' (numel y) in
  let z = (_atan2 (kind x)) x' y' in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let hypot x y =
  let x' = Genarray.change_layout x fortran_layout in
  let x' = Bigarray.reshape_1 x' (numel x) in
  let y' = Genarray.change_layout y fortran_layout in
  let y' = Bigarray.reshape_1 y' (numel y) in
  let z = (_hypot (kind x)) x' y' in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let min2 x y =
  let x' = Genarray.change_layout x fortran_layout in
  let x' = Bigarray.reshape_1 x' (numel x) in
  let y' = Genarray.change_layout y fortran_layout in
  let y' = Bigarray.reshape_1 y' (numel y) in
  let z = (_min2 (kind x)) x' y' in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let max2 x y =
  let x' = Genarray.change_layout x fortran_layout in
  let x' = Bigarray.reshape_1 x' (numel x) in
  let y' = Genarray.change_layout y fortran_layout in
  let y' = Bigarray.reshape_1 y' (numel y) in
  let z = (_max2 (kind x)) x' y' in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let abs x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_abs (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let neg x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_neg (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let signum x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_signum (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let sqr x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_sqr (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let sqrt x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_sqrt (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let cbrt x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_cbrt (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let exp x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_exp (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let exp2 x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_exp2 (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let expm1 x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_expm1 (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let log x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_log (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let log10 x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_log10 (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let log2 x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_log2 (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let log1p x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_log1p (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let sin x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_sin (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let cos x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_cos (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let tan x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_tan (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let asin x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_asin (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let acos x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_acos (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let atan x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_atan (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let sinh x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_sinh (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let cosh x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_cosh (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let tanh x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_tanh (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let asinh x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_asinh (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let acosh x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_acosh (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let atanh x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_atanh (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let floor x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_floor (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let ceil x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_ceil (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let round x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_round (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let trunc x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_trunc (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let erf x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_erf (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let erfc x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_erfc (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let logistic x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_logistic (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let relu x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_relu (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let softplus x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_softplus (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let softsign x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_softsign (kind x)) y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let add_scalar x a =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_add_scalar (kind x)) a y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let sub_scalar x a =
  let k = kind x in
  let b = (_sub_elt k) (_zero k) (_one k) in
  add_scalar x ((_mul_elt k) a b)

let mul_scalar x a =
  let y = clone x in
  let y = Genarray.change_layout y fortran_layout in
  let z = Bigarray.reshape_1 y (numel x) in
  let _ = (_mul_scalar (kind x)) a z in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let div_scalar x a =
  let k = kind x in
  let b = (_div_elt k) (_one k) a in
  mul_scalar x b

let sum x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  (_sum (kind x)) y

let uniform ?(scale=1.) kind dimension =
  let n = Array.fold_right (fun c a -> c * a) dimension 1 in
  let _op = _uniform (kind) in
  let x = _op scale n in
  let x = Bigarray.genarray_of_array1 x in
  let x = Genarray.change_layout x c_layout in
  Bigarray.reshape x dimension


(* advanced operations *)

let create kind dimension a =
  let x = empty kind dimension in
  let _ = fill x a in
  x

let zeros kind dimension = create kind dimension (_zero kind)

let ones kind dimension = create kind dimension (_one kind)

let sequential k dimension =
  let x = empty k dimension in
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let _op = _add_elt (kind x) in
  let _ac = ref (_zero (kind x)) in
  let _aa = _one (kind x) in
  for i = 1 to (numel x) do
    Array1.unsafe_set y i !_ac;
    _ac := _op !_ac _aa
  done;
  x

let flatten x =
  let n = numel x in
  reshape x [|n|]

let rec __iteri_fix_axis d j i l h f x =
  if j = d - 1 then (
    for k = l.(j) to h.(j) do
      i.(j) <- k;
      f i (get x i);
    done
  )
  else (
    for k = l.(j) to h.(j) do
      i.(j) <- k;
      __iteri_fix_axis d (j + 1) i l h f x
    done
  )

let _iteri_fix_axis axis f x =
  let d = num_dims x in
  let i = Array.make d 0 in
  let l = Array.make d 0 in
  let h = shape x in
  Array.iteri (fun j a ->
    match a with
    | Some b -> (l.(j) <- b; h.(j) <- b)
    | None   -> (h.(j) <- h.(j) - 1)
  ) axis;
  __iteri_fix_axis d 0 i l h f x

let iteri ?axis f x =
  match axis with
  | Some a -> _iteri_fix_axis a f x
  | None   -> _iteri_fix_axis (Array.make (num_dims x) None) f x

let _iter_all_axis f x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  (_iter_op (kind x)) f y

let iter ?axis f x =
  match axis with
  | Some a -> _iteri_fix_axis a (fun _ y -> f y) x
  | None   -> _iter_all_axis f x

let iter2i f x y =
  let s = shape x in
  let d = num_dims x in
  let i = Array.make d 0 in
  let k = ref 0 in
  let n = (numel x) - 1 in
  for j = 0 to n do
    f i (get x i) (get y i);
    k := d - 1;
    i.(!k) <- i.(!k) + 1;
    while not (i.(!k) < s.(!k)) && j <> n do
      i.(!k) <- 0;
      k := !k - 1;
      i.(!k) <- i.(!k) + 1;
    done
  done

let iter2 f x y =
  let x' = Genarray.change_layout x fortran_layout in
  let x' = Bigarray.reshape_1 x' (numel x) in
  let y' = Genarray.change_layout y fortran_layout in
  let y' = Bigarray.reshape_1 y' (numel y) in
  _iteri_op (kind x) (fun i a -> f a y'.{i}) x'

let mapi ?axis f x =
  let y = clone x in
  iteri ?axis (fun i z -> set y i (f i z)) y; y

let _map_all_axis f x =
  let y = Genarray.change_layout x fortran_layout in
  let y = Bigarray.reshape_1 y (numel x) in
  let z = (_map_op (kind x)) f y in
  let z = Bigarray.genarray_of_array1 z in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z (shape x) in
  z

let map ?axis f x =
  match axis with
  | Some a -> mapi ?axis (fun _ y -> f y) x
  | None   -> _map_all_axis f x

let map2i ?axis f x y =
  if same_shape x y = false then
    failwith "error: dimension mismatch";
  let z = empty (kind x) (shape x) in
  iteri ?axis (fun i a ->
    let b = get y i in
    set z i (f i a b)
  ) x; z

let map2 ?axis f x y = map2i ?axis (fun _ a b -> f a b) x y

let _check_transpose_axis axis d =
  let info = "check_transpose_axis fails" in
  if Array.length axis <> d then
    failwith info;
  let h = Hashtbl.create 16 in
  Array.iter (fun x ->
    if x < 0 || x >= d then failwith info;
    if Hashtbl.mem h x = true then failwith info;
    Hashtbl.add h x 0
  ) axis

let transpose ?axis x =
  let d = num_dims x in
  let a = match axis with
    | Some a -> a
    | None -> Array.init d (fun i -> d - i - 1)
  in
  (* check if axis is a correct permutation *)
  _check_transpose_axis a d;
  let s0 = shape x in
  let s1 = Array.map (fun j -> s0.(j)) a in
  let i' = Array.make d 0 in
  let y = empty (kind x) s1 in
  iteri (fun i z ->
    Array.iteri (fun k j -> i'.(k) <- i.(j)) a;
    set y i' z
  ) x;
  y

let swap a0 a1 x =
  let d = num_dims x in
  let a = Array.init d (fun i -> i) in
  let t = a.(a0) in
  a.(a0) <- a.(a1);
  a.(a1) <- t;
  transpose ~axis:a x

let filteri ?axis f x =
  let a = ref [||] in
  iteri ?axis (fun i y ->
    if f i y = true then
      let j = Array.copy i in
      a := Array.append !a [|j|]
  ) x;
  !a

let filter ?axis f x = filteri ?axis (fun _ y -> f y) x

let foldi ?axis f a x =
  let c = ref a in
  iteri ?axis (fun i y -> c := (f i !c y)) x;
  !c

let fold ?axis f a x =
  let c = ref a in
  iter ?axis (fun y -> c := (f !c y)) x;
  !c

let _check_slice_axis axis s =
  if Array.length axis <> Array.length s then
    failwith "check_slice_axis: length does not match";
  let has_none = ref false in
  Array.iteri (fun i a ->
    match a with
    | Some a -> if a < 0 || a >= s.(i) then failwith "_check_slice_axis: boundary error"
    | None   -> has_none := true
  ) axis;
  if !has_none = false then failwith "_check_slice_axis: there should be at least one None"

(* calculate the continuous block size based on slice definition *)
let _slice_continuous_blksz shp axis =
  let stride = _calc_stride shp in
  let l = ref (Array.length shp - 1) in
  let ssz = ref 1 in
  while !l >= 0 && axis.(!l) = None do
    l := !l - 1
  done;
  if !l = (-1) then ssz := stride.(0) * shp.(0)
  else ssz := stride.(!l);
  !ssz

let rec __foreach_continuous_blk d j i l h f =
  if j = d then f i
  else (
    for k = l.(j) to h.(j) do
      i.(j) <- k;
      __foreach_continuous_blk d (j + 1) i l h f
    done
  )

let _foreach_continuous_blk axis shp f =
  let d = Array.length shp in
  let i = Array.make d 0 in
  let l = Array.make d 0 in
  let h = shp in
  Array.iteri (fun j a ->
    match a with
    | Some b -> (l.(j) <- b; h.(j) <- b)
    | None   -> (h.(j) <- h.(j) - 1)
  ) axis;
  let k = ref (d - 1) in
  while !k >= 0 && axis.(!k) = None do
    l.(!k) <- 0;
    h.(!k) <- 0;
    k := !k - 1
  done;
  __foreach_continuous_blk d 0 i l h f

let _slice_block axis x =
  let s0 = shape x in
  (* check axis is within boundary, has at least one None *)
  _check_slice_axis axis s0;
  let s1 = ref [||] in
  Array.iteri (fun i a ->
    match a with
    | Some _ -> ()
    | None   -> s1 := Array.append !s1 [|s0.(i)|]
  ) axis;
  let y = empty (kind x) !s1 in
  (* transform into 1d array *)
  let x' = Genarray.change_layout x fortran_layout in
  let x' = Bigarray.reshape_1 x' (numel x) in
  let y' = Genarray.change_layout y fortran_layout in
  let y' = Bigarray.reshape_1 y' (numel y) in
  (* prepare function of copying blocks *)
  let b = _slice_continuous_blksz s0 axis in
  let s = _calc_stride s0 in
  let _cp_op = _copy (kind x) in
  let ofsy_i = ref 0 in
  let f = fun i -> (
    let ofsx = (_index_nd_1d i s) + 1 in
    let ofsy = (!ofsy_i * b) + 1 in
    let _ = _cp_op ~n:b ~ofsy ~y:y' ~ofsx x' in
    ofsy_i := !ofsy_i + 1
  ) in
  (* start copying blocks *)
  _foreach_continuous_blk axis s0 f;
  (* reshape the ndarray *)
  let z = Bigarray.genarray_of_array1 y' in
  let z = Genarray.change_layout z c_layout in
  let z = Bigarray.reshape z !s1 in
  z

let _slice_1byte axis x =
  let s0 = shape x in
  (* check axis is within boundary, has at least one None *)
  _check_slice_axis axis s0;
  let s1 = ref [||] in
  Array.iteri (fun i a ->
    match a with
    | Some _ -> ()
    | None   -> s1 := Array.append !s1 [|s0.(i)|]
  ) axis;
  let y = empty (kind x) !s1 in
  let k = Array.make (num_dims y) 0 in
  let t = ref 0 in
  Array.iteri (fun i a ->
    match a with
    | Some _ -> ()
    | None   -> (k.(!t) <- i; t := !t + 1)
  ) axis;
  let j = Array.make (num_dims y) 0 in
  iteri ~axis (fun i a ->
    Array.iteri (fun m m' -> j.(m) <- i.(m')) k;
    set y j a
  ) x;
  y

let slice axis x =
  let s = shape x in
  (* check axis is within boundary, has at least one None *)
  _check_slice_axis axis s;
  (* if block size is > 99 bytes, then use block copying *)
  let threshold = 99 in
  match _slice_continuous_blksz s axis > threshold with
  | true  -> _slice_block axis x
  | false -> _slice_1byte axis x

let rec _iteri_slice index axis f x =
  if Array.length axis = 0 then (
    f index (slice index x)
  )
  else (
    let s = shape x in
    for i = 0 to s.(axis.(0)) - 1 do
      index.(axis.(0)) <- Some i;
      _iteri_slice index (Array.sub axis 1 (Array.length axis - 1)) f x
    done
  )

let iteri_slice axis f x =
  let index = Array.make (num_dims x) None in
  _iteri_slice index axis f x

let iter_slice axis f x = iteri_slice axis (fun _ y -> f y) x

let copy_slice i src dst =
  let s = shape dst in
  _check_slice_axis i s;
  let j = Array.make (num_dims dst) 0 in
  let k = ref [||] in
  let m = ref 0 in
  Array.iteri (fun n a ->
    match a with
    | Some a' -> j.(n) <- a'
    | None    -> (k := Array.append !k [|n|]; m := !m + 1)
  ) i;
  let k = !k in
  iteri (fun i' a ->
    Array.iteri (fun m n -> j.(k.(m)) <- n) i';
    set dst j a
  ) src

(* some comparison functions *)

let is_zero x =
  let y = ndarray_to_c_mat x in
  (_gsl_isnull (kind x)) y

let is_positive x =
  let y = ndarray_to_c_mat x in
  (_gsl_ispos (kind x)) y

let is_negative x =
  let y = ndarray_to_c_mat x in
  (_gsl_isneg (kind x)) y

let is_nonnegative x =
  let y = ndarray_to_c_mat x in
  (_gsl_isnonneg (kind x)) y

let is_nonpositive x =
  let y = flatten x |> array1_of_genarray in
  let _op = _owl_is_nonpositive (kind x) in
  _op (numel x) y = 1

let is_equal x y = ( = ) x y

let is_unequal x y = ( <> ) x y

let is_greater x y =
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let _op = _owl_is_greater (kind x) in
  _op (numel x) x' y' = 1

let is_smaller x y =
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let _op = _owl_is_smaller (kind x) in
  _op (numel x) x' y' = 1

let equal_or_greater x y =
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let _op = _owl_equal_or_greater (kind x) in
  _op (numel x) x' y' = 1

let equal_or_smaller x y =
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let _op = _owl_equal_or_smaller (kind x) in
  _op (numel x) x' y' = 1

let exists f x =
  let b = ref false in
  try iter (fun y ->
    if (f y) then (
      b := true;
      failwith "found";
    )
  ) x; !b
  with Failure _ -> !b

let not_exists f x = not (exists f x)

let for_all f x = let g y = not (f y) in not_exists g x

let nnz x =
  let y = flatten x |> array1_of_genarray in
  let _op = _owl_nnz (kind x) in
  _op (numel x) y

let density x = (nnz x |> float_of_int) /. (numel x |> float_of_int)

(* input/output functions *)

let print_index i =
  Printf.printf "[ ";
  Array.iter (fun x -> Printf.printf "%i " x) i;
  Printf.printf "] "

let print_element k v =
  let s = (_owl_elt_to_str k) v in
  Printf.printf "%s" s

let print x =
  let _op = _owl_elt_to_str (kind x) in
  iteri (fun i y ->
    print_index i;
    Printf.printf "%s\n" (_op y)
  ) x

let pp_dsnda x =
  let _op = _owl_elt_to_str (kind x) in
  let k = shape x in
  let s = _calc_stride k in
  let _pp = fun i j -> (
    for i' = i to j do
      _index_1d_nd i' k s;
      print_index k;
      Printf.printf "%s\n" (_op (get x k))
    done
  )
  in
  let n = numel x in
  if n <= 40 then (
    _pp 0 (n - 1)
  )
  else (
    _pp 0 19;
    print_endline "......";
    _pp (n - 20) (n - 1)
  )

let save x f = Owl_utils.marshal_to_file x f

let load k f = Owl_utils.marshal_from_file f

(* math operations. code might be verbose for performance concern. *)

let re x =
  let y = empty Float64 (shape x) in
  iteri (fun i c -> set y i Complex.(c.re) ) x;
  y

let im x =
  let y = empty Float64 (shape x) in
  iteri (fun i c -> set y i Complex.(c.im) ) x;
  y

let conj x = map Complex.conj x

(* NOTE: experimental feature *)
let pmap f x =
  let _op = _map_op (kind x) in
  let x' = Bigarray.reshape_1 x (numel x) in
  let f' lo hi x y = (
    (* change the layout so we can call lacaml map *)
    let x = Bigarray.genarray_of_array1 x in
    let x = Genarray.change_layout x fortran_layout in
    let x = Bigarray.array1_of_genarray x in
    let y = Bigarray.genarray_of_array1 y in
    let y = Genarray.change_layout y fortran_layout in
    let y = Bigarray.array1_of_genarray y in
    (* add 1 because fortran start indexing at 1 *)
    let lo = lo + 1 in
    let hi = hi + 1 in
    (* drop the return since y is modified in place *)
    ignore (_op f ~n:(hi - lo + 1) ~ofsy:lo ~y:y ~ofsx:lo x)
  )
  in
  let y = Owl_parallel.map_block f' x' in
  let y = genarray_of_array1 y in
  reshape y (shape x)

let prod ?axis x =
  let _a1 = _one (kind x) in
  let _op = _mul_elt (kind x) in
  fold ?axis (fun a y -> _op a y) _a1 x

let tile x reps =
  (* check the validity of reps *)
  if Array.exists ((>) 1) reps then
    failwith "tile: repitition must be >= 1";
  (* align and promote the shape *)
  let a = num_dims x in
  let b = Array.length reps in
  let x, reps = match a < b with
    | true -> (
      let d = Owl_utils.array_pad `Left (shape x) 1 (b - a) in
      (reshape x d), reps
      )
    | false -> (
      let r = Owl_utils.array_pad `Left reps 1 (a - b) in
      x, r
      )
  in
  (* calculate the smallest continuous slice dx *)
  let i = ref (Array.length reps - 1) in
  let sx = shape x in
  let dx = ref sx.(!i) in
  while reps.(!i) = 1 && !i - 1 >= 0 do
    i := !i - 1;
    dx := !dx * sx.(!i);
  done;
  (* project x and y to 1-dimensional array s*)
  let sy = Owl_utils.array_map2i (fun _ a b -> a * b) sx reps in
  let y = empty (kind x) sy in
  let x1 = Bigarray.reshape_1 x (numel x) in
  let y1 = Bigarray.reshape_1 y (numel y) in
  let stride_x = _calc_stride (shape x) in
  let stride_y = _calc_stride (shape y) in
  (* recursively tile the data within y *)
  let rec _tile ofsx ofsy lvl =
    if lvl = !i then (
      let src = Array1.sub x1 ofsx !dx in
      for k = 0 to reps.(lvl) - 1 do
        let ofsy' = ofsy + (k * !dx) in
        let dst = Array1.sub y1 ofsy' !dx in
        Array1.blit src dst;
      done;
    ) else (
      for j = 0 to sx.(lvl) - 1 do
        let ofsx' = ofsx + j * stride_x.(lvl) in
        let ofsy' = ofsy + j * stride_y.(lvl) in
        _tile ofsx' ofsy' (lvl + 1);
      done;
      let _len = stride_y.(lvl) * sx.(lvl) in
      let src = Array1.sub y1 ofsy _len in
      for k = 1 to reps.(lvl) - 1 do
        let dst = Array1.sub y1 (ofsy + (k * _len)) _len in
        Array1.blit src dst;
      done;
    )
  in
  _tile 0 0 0; y

let repeat ?axis x reps =
  let highest_dim = Array.length (shape x) - 1 in
  (* by default, repeat at the highest dimension *)
  let axis = match axis with
    | Some a -> a
    | None   -> highest_dim
  in
  (* calculate the new shape of y based on reps *)
  let _shape_y = shape x in
  _shape_y.(axis) <- _shape_y.(axis) * reps;
  let y = empty (kind x) _shape_y in
  (* transform into genarray first *)
  let x' = Genarray.change_layout x fortran_layout in
  let x' = Bigarray.reshape_1 x' (numel x) in
  let y' = Genarray.change_layout y fortran_layout in
  let y' = Bigarray.reshape_1 y' (numel y) in
  (* if repeat at the highest dimension, use this strategy *)
  if axis = highest_dim then (
    let _cp_op = _copy (kind x) in
    (* be careful of the index, this is fortran layout *)
    for i = 1 to reps do
      ignore (_cp_op ~n:(numel x) ~ofsy:i ~incy:reps ~y:y' ~ofsx:1 ~incx:1 x')
    done;
  )
  (* if repeat at another dimension, use this block copying *)
  else (
    let _cp_op = _copy (kind x) in
    let _stride_x = _calc_stride (shape x) in
    let _slice_sz = _stride_x.(axis) in
    (* be careful of the index, this is fortran layout *)
    for i = 0 to (numel x) / _slice_sz - 1 do
      let ofsx = i * _slice_sz + 1 in
      for j = 0 to reps - 1 do
        let ofsy = (i * reps + j) * _slice_sz + 1 in
        ignore (_cp_op ~n:_slice_sz ~ofsy ~incy:1 ~y:y' ~ofsx ~incx:1 x')
      done;
    done;
  );
  (* reshape y' back to ndarray before return result *)
  let y' = genarray_of_array1 y' in
  let y' = Genarray.change_layout y' c_layout in
  reshape y' _shape_y


(* TODO *)

let squeeze ?(axis=[||]) x = None

let insert_slice = None

let remove_slice = None

let mapi_slice = None

let map_slice = None

let sort axis x = None

let diag x = None

let trace x = None


(* TODO *)

let inv x = None

let mean x = None

let std x = None

let dot x = None

let tensordot x = None

let cumsum axis x = None


(* Shorhand infix operators *)

let ( >> ) = copy

let ( << ) x1 x2 = copy x2 x1

let ( +@ ) = add

let ( -@ ) = sub

let ( *@ ) = mul

let ( /@ ) = div

let ( **@ ) = pow

let ( =@ ) = ( = )

let ( <>@ ) = ( <> )

let ( >@ ) = is_greater

let ( <@ ) = is_smaller

let ( >=@ ) = equal_or_greater

let ( <=@ ) = equal_or_smaller

let ( +$ ) x a = add_scalar x a

let ( $+ ) a x = add_scalar x a

let ( -$ ) x a = sub_scalar x a

let ( $- ) a x = sub_scalar x a

let ( *$ ) x a = mul_scalar x a

let ( $* ) a x = mul_scalar x a

let ( /$ ) x a = div_scalar x a

let ( $/ ) a x = div_scalar x a

let ( @@ ) f x = map f x


(* ends here *)
