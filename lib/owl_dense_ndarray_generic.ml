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

let size_in_bytes x = _size_in_bytes x

let sub_left = Genarray.sub_left

let sub_right = Genarray.sub_right

let slice_left = Genarray.slice_left

let slice_right = Genarray.slice_right

let copy src dst = Genarray.blit src dst

let fill x a = Genarray.fill x a

let reshape x dimension = reshape x dimension

let reset x = Genarray.fill x (_zero (kind x))

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

let flatten x = reshape x [|numel x|]

let reverse x =
  let y = clone x in
  y |> flatten |> array1_of_genarray |> Owl_backend_gsl_linalg.reverse (kind x);
  y

(* TODO: cast x to kind k *)
let cast k x = None

(* TODO: zpxy, zmxy, sort ... *)

(* TODO: add axis paramater *)

let min x = x |> flatten |> array1_of_genarray |> Owl_backend_gsl_linalg.min (kind x)

let max x = x |> flatten |> array1_of_genarray |> Owl_backend_gsl_linalg.max (kind x)

let minmax x = x |> flatten |> array1_of_genarray |> Owl_backend_gsl_linalg.minmax (kind x)

let min_i x =
  let y = flatten x |> array1_of_genarray in
  let i = _owl_min_i (kind x) (numel x) y in
  let s = _calc_stride (shape x) in
  let j = Array.copy s in
  let _ = _index_1d_nd i j s in
  y.{i}, j

let max_i x =
  let y = flatten x |> array1_of_genarray in
  let i = _owl_max_i (kind x) (numel x) y in
  let s = _calc_stride (shape x) in
  let j = Array.copy s in
  let _ = _index_1d_nd i j s in
  y.{i}, j

let minmax_i x =
  let y = flatten x |> array1_of_genarray in
  let i, j = Owl_backend_gsl_linalg.minmax_i (kind x) y in
  let s = _calc_stride (shape x) in
  let p = Array.copy s in
  let q = Array.copy s in
  let _ = _index_1d_nd i p s in
  let _ = _index_1d_nd j q s in
  (y.{i}, p), (y.{j}, q)

let add x y =
  let z = clone x in
  let x = ndarray_to_c_mat z in
  let y = ndarray_to_c_mat y in
  let _ = Owl_backend_gsl_linalg.add (kind z) x y in
  z

let sub x y =
  let z = clone x in
  let x = ndarray_to_c_mat z in
  let y = ndarray_to_c_mat y in
  let _ = Owl_backend_gsl_linalg.sub (kind z) x y in
  z

let mul x y =
  let z = clone x in
  let x = ndarray_to_c_mat z in
  let y = ndarray_to_c_mat y in
  let _ = Owl_backend_gsl_linalg.mul (kind z) x y in
  z

let div x y =
  let z = clone x in
  let x = ndarray_to_c_mat z in
  let y = ndarray_to_c_mat y in
  let _ = Owl_backend_gsl_linalg.div (kind z) x y in
  z

let add_scalar x a =
  let z = clone x in
  let x = ndarray_to_c_mat z in
  let _ = Owl_backend_gsl_linalg.add_scalar (kind z) x a in
  z

let sub_scalar x a =
  let k = kind x in
  let b = (_sub_elt k) (_zero k) (_one k) in
  add_scalar x ((_mul_elt k) a b)

let mul_scalar x a =
  let z = clone x in
  let x = ndarray_to_c_mat z in
  let _ = Owl_backend_gsl_linalg.mul_scalar (kind z) x a in
  z

let div_scalar x a =
  let k = kind x in
  let b = (_div_elt k) (_one k) a in
  mul_scalar x b

let pow x y =
  let z = clone x in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  let _ = _owl_pow (kind x) (numel x) x' y' z' in
  z

let atan2 x y =
  let z = clone x in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  let _ = _owl_atan2 (kind x) (numel x) x' y' z' in
  z

let hypot x y =
  let z = clone x in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  let _ = _owl_hypot (kind x) (numel x) x' y' z' in
  z

let min2 x y =
  let z = clone x in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  let _ = _owl_min2 (kind x) (numel x) x' y' z' in
  z

let max2 x y =
  let z = clone x in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  let _ = _owl_max2 (kind x) (numel x) x' y' z' in
  z

let ssqr_diff x y =
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  _owl_ssqr_diff (kind x) (numel x) x' y'

let abs x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_abs (kind x) (numel y) src dst in
  y

let abs_c2s x =
  let y = empty Float32 (shape x) in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = owl_complex_float_abs (numel y) src dst in
  y

let abs_z2d x =
  let y = empty Float64 (shape x) in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = owl_complex_double_abs (numel y) src dst in
  y

let abs2 x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_abs2 (kind x) (numel y) src dst in
  y

let abs2_c2s x =
  let y = empty Float32 (shape x) in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = owl_complex_float_abs2 (numel y) src dst in
  y

let abs2_z2d x =
  let y = empty Float64 (shape x) in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = owl_complex_double_abs2 (numel y) src dst in
  y

let conj x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_conj (kind x) (numel y) src dst in
  y

let neg x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_neg (kind x) (numel y) src dst in
  y

let reci x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_reci (kind x) (numel y) src dst in
  y

let signum x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_signum (kind x) (numel y) src dst in
  y

let sqr x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_sqr (kind x) (numel y) src dst in
  y

let sqrt x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_sqrt (kind x) (numel y) src dst in
  y

let cbrt x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_cbrt (kind x) (numel y) src dst in
  y

let exp x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_exp (kind x) (numel y) src dst in
  y

let exp2 x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_exp2 (kind x) (numel y) src dst in
  y

let expm1 x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_expm1 (kind x) (numel y) src dst in
  y

let log x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_log (kind x) (numel y) src dst in
  y

let log10 x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_log10 (kind x) (numel y) src dst in
  y

let log2 x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_log2 (kind x) (numel y) src dst in
  y

let log1p x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_log1p (kind x) (numel y) src dst in
  y

let sin x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_sin (kind x) (numel y) src dst in
  y

let cos x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_cos (kind x) (numel y) src dst in
  y

let tan x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_tan (kind x) (numel y) src dst in
  y

let asin x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_asin (kind x) (numel y) src dst in
  y

let acos x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_acos (kind x) (numel y) src dst in
  y

let atan x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_atan (kind x) (numel y) src dst in
  y

let sinh x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_sinh (kind x) (numel y) src dst in
  y

let cosh x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_cosh (kind x) (numel y) src dst in
  y

let tanh x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_tanh (kind x) (numel y) src dst in
  y

let asinh x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_asinh (kind x) (numel y) src dst in
  y

let acosh x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_acosh (kind x) (numel y) src dst in
  y

let atanh x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_atanh (kind x) (numel y) src dst in
  y

let floor x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_floor (kind x) (numel y) src dst in
  y

let ceil x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_ceil (kind x) (numel y) src dst in
  y

let round x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_round (kind x) (numel y) src dst in
  y

let trunc x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_trunc (kind x) (numel y) src dst in
  y

let erf x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_erf (kind x) (numel y) src dst in
  y

let erfc x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_erfc (kind x) (numel y) src dst in
  y

let logistic x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_logistic (kind x) (numel y) src dst in
  y

let relu x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_relu (kind x) (numel y) src dst in
  y

let softplus x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_softplus (kind x) (numel y) src dst in
  y

let softsign x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_softsign (kind x) (numel y) src dst in
  y

let sigmoid x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_sigmoid (kind x) (numel y) src dst in
  y

let _ssqr_0 x =
  let n = numel x in
  let x1 = reshape x [|1;n|] |> array2_of_genarray in
  let x2 = reshape x [|n;1|] |> array2_of_genarray in
  let y = Owl_backend_gsl_linalg.dot (kind x) x1 x2 in
  y.{0,0}

let ssqr x a = flatten x |> array1_of_genarray |> _owl_ssqr (kind x) (numel x) a

(* TODO: using Gsl.dot is not really faster
let ssqr x a = match a = _zero (kind x) with
  | true  -> _ssqr_0 x
  | false -> _ssqr_1 x a
*)

let l1norm x = flatten x |> array1_of_genarray |> _owl_l1norm (kind x) (numel x)

let l2norm_sqr x = flatten x |> array1_of_genarray |> _owl_l2norm_sqr (kind x) (numel x)

let l2norm x = l2norm_sqr x |> Owl_maths.sqrt

let log_sum_exp x =
  let y = flatten x |> array1_of_genarray in
  _owl_log_sum_exp (kind x) (numel x) y

(* TODO: optimise *)
let pow0 a x =
  let y = empty (kind x) (shape x) in
  fill y a;
  pow y x

(* TODO: optimise *)
let pow1 x a =
  let y = empty (kind x) (shape x) in
  fill y a;
  pow x y

(* TODO: optimise *)
let atan20 a x =
  let y = empty (kind x) (shape x) in
  fill y a;
  atan2 y x

(* TODO: optimise *)
let atan21 x a =
  let y = empty (kind x) (shape x) in
  fill y a;
  atan2 x y

(* element-wise comparison functions *)

let elt_equal x y =
  let z = empty Float32 (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  _owl_elt_equal (kind x) (numel z) x' y' z';
  z

let elt_not_equal x y =
  let z = empty Float32 (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  _owl_elt_not_equal (kind x) (numel z) x' y' z';
  z

let elt_less x y =
  let z = empty Float32 (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  _owl_elt_less (kind x) (numel z) x' y' z';
  z

let elt_greater x y =
  let z = empty Float32 (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  _owl_elt_greater (kind x) (numel z) x' y' z';
  z

let elt_less_equal x y =
  let z = empty Float32 (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  _owl_elt_less_equal (kind x) (numel z) x' y' z';
  z

let elt_greater_equal x y =
  let z = empty Float32 (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  _owl_elt_greater_equal (kind x) (numel z) x' y' z';
  z

let sum x = flatten x |> array1_of_genarray |> _owl_sum (kind x) (numel x)

let softmax x =
  let y = max x |> sub_scalar x |> exp in
  let a = sum y in
  div_scalar y a

let cross_entropy x y = (mul x (log y) |> sum) |> _neg_elt (kind x)

let uniform : type a b. ?scale:float -> (a, b) kind -> int array -> (a, b) t =
  fun ?(scale=1.) kind dimension ->
  let x = empty kind dimension in
  let n = numel x in
  let y = Bigarray.reshape_1 x n in
  let _ = match kind with
  | Float32 -> (
    for i = 0 to n - 1 do
      y.{i} <- Owl_stats.Rnd.uniform () *. scale
    done
    )
  | Float64 -> (
    for i = 0 to n - 1 do
      y.{i} <- Owl_stats.Rnd.uniform () *. scale
    done
    )
  | Complex32 -> (
    for i = 0 to n - 1 do
      y.{i} <- Complex.({ re = Owl_stats.Rnd.uniform () *. scale; im = Owl_stats.Rnd.uniform () *. scale })
    done
    )
  | Complex64 -> (
    for i = 0 to n - 1 do
      y.{i} <- Complex.({ re = Owl_stats.Rnd.uniform () *. scale; im = Owl_stats.Rnd.uniform () *. scale })
    done
    )
  | _ -> failwith "Owl_dense_ndarray_generic.uniform: unknown type"
  in x

let linspace k a b n =
  let x = Array1.create k c_layout n in
  _owl_linspace k n a b x;
  genarray_of_array1 x

let logspace k ?(base=Owl_maths.e) a b n =
  let x = Array1.create k c_layout n in
  _owl_logspace k n base a b x;
  genarray_of_array1 x

(* advanced operations *)

let create kind dimension a =
  let x = empty kind dimension in
  let _ = fill x a in
  x

let zeros kind dimension = create kind dimension (_zero kind)

let ones kind dimension = create kind dimension (_one kind)

let sequential k dimension =
  let x = empty k dimension in
  let y = flatten x |> array1_of_genarray in
  let _op = _add_elt (kind x) in
  let _ac = ref (_zero (kind x)) in
  let _aa = _one (kind x) in
  for i = 0 to (numel x) - 1 do
    Array1.unsafe_set y i !_ac;
    _ac := _op !_ac _aa
  done;
  x

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
  let y = flatten x |> array1_of_genarray in
  for i = 0 to (numel x) - 1 do
    f y.{i}
  done

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
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  for i = 0 to (numel x) - 1 do
    f x'.{i} y'.{i}
  done

let mapi ?axis f x =
  let y = clone x in
  iteri ?axis (fun i z -> set y i (f i z)) y; y

let _map_all_axis f x =
  let x = clone x in
  let y = flatten x |> array1_of_genarray in
  for i = 0 to (numel x) - 1 do
    y.{i} <- f y.{i}
  done;
  x

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

let slice axis x = Owl_slicing.slice_list_typ axis x

(* FIXME
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

*)

let rec _iteri_slice index axis f x =
  if Array.length axis = 0 then (
    f index (Owl_slicing.slice_array_typ index x)
  )
  else (
    let s = shape x in
    for i = 0 to s.(axis.(0)) - 1 do
      index.(axis.(0)) <- [|i|];
      _iteri_slice index (Array.sub axis 1 (Array.length axis - 1)) f x
    done
  )

let iteri_slice axis f x =
  if Array.length axis > num_dims x then
    failwith "iteri_slice: invalid indices";
  let index = Array.make (num_dims x) [||] in
  _iteri_slice index axis f x

let iter_slice axis f x = iteri_slice axis (fun _ y -> f y) x


(* some comparison functions *)

let is_zero x =
  let y = flatten x |> array1_of_genarray in
  let _op = _owl_is_zero (kind x) in
  _op (numel x) y = 1

let is_positive x =
  let y = flatten x |> array1_of_genarray in
  let _op = _owl_is_positive (kind x) in
  _op (numel x) y = 1

let is_negative x =
  let y = flatten x |> array1_of_genarray in
  let _op = _owl_is_negative (kind x) in
  _op (numel x) y = 1

let is_nonnegative x =
  let y = flatten x |> array1_of_genarray in
  let _op = _owl_is_nonnegative (kind x) in
  _op (numel x) y = 1

let is_nonpositive x =
  let y = flatten x |> array1_of_genarray in
  let _op = _owl_is_nonpositive (kind x) in
  _op (numel x) y = 1

let equal x y = ( = ) x y

let not_equal x y = ( <> ) x y

let greater x y =
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let _op = _owl_greater (kind x) in
  _op (numel x) x' y' = 1

let less x y =
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let _op = _owl_less (kind x) in
  _op (numel x) x' y' = 1

let greater_equal x y =
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let _op = _owl_greater_equal (kind x) in
  _op (numel x) x' y' = 1

let less_equal x y =
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let _op = _owl_less_equal (kind x) in
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

let re_c2s x =
  let y = empty Float32 (shape x) in
  _owl_re_c2s (numel x) (flatten x |> array1_of_genarray) (flatten y |> array1_of_genarray);
  y

let re_z2d x =
  let y = empty Float64 (shape x) in
  _owl_re_z2d (numel x) (flatten x |> array1_of_genarray) (flatten y |> array1_of_genarray);
  y

let im_c2s x =
  let y = empty Float32 (shape x) in
  _owl_im_c2s (numel x) (flatten x |> array1_of_genarray) (flatten y |> array1_of_genarray);
  y

let im_z2d x =
  let y = empty Float64 (shape x) in
  _owl_im_z2d (numel x) (flatten x |> array1_of_genarray) (flatten y |> array1_of_genarray);
  y

let prod ?axis x =
  match axis with
  | Some axis ->
    let _a1 = _one (kind x) in
    let _op = _mul_elt (kind x) in
    fold ~axis (fun a y -> _op a y) _a1 x
  | None -> flatten x |> array1_of_genarray |> _owl_prod (kind x) (numel x)

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
  let _cp_op = _owl_copy (kind x) in
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
  let x' = Bigarray.reshape_1 x (numel x) in
  let y' = Bigarray.reshape_1 y (numel y) in
  (* if repeat at the highest dimension, use this strategy *)
  if axis = highest_dim then (
    for i = 0 to reps - 1 do
      ignore (_cp_op (numel x) ~ofsx:0 ~incx:1 ~ofsy:i ~incy:reps x' y')
    done;
  )
  (* if repeat at another dimension, use this block copying *)
  else (
    let _stride_x = _calc_stride (shape x) in
    let _slice_sz = _stride_x.(axis) in
    (* be careful of the index, this is fortran layout *)
    for i = 0 to (numel x) / _slice_sz - 1 do
      let ofsx = i * _slice_sz in
      for j = 0 to reps - 1 do
        let ofsy = (i * reps + j) * _slice_sz in
        ignore (_cp_op _slice_sz ~ofsx ~incx:1 ~ofsy ~incy:1 x' y')
      done;
    done;
  );
  (* reshape y' back to ndarray before return result *)
  let y' = genarray_of_array1 y' in
  reshape y' _shape_y

let squeeze ?(axis=[||]) x =
  let a = match Array.length axis with
    | 0 -> Array.init (num_dims x) (fun i -> i)
    | _ -> axis
  in
  let s = Owl_utils.array_filteri (fun i v ->
    not (v == 1 && Array.mem i a)
  ) (shape x)
  in
  reshape x s

(* cast functions *)

let cast_s2d x =
  let y = empty Float64 (shape x) in
  _owl_cast_s2d (numel x) (flatten x |> array1_of_genarray) (flatten y |> array1_of_genarray);
  y

let cast_d2s x =
  let y = empty Float32 (shape x) in
  _owl_cast_d2s (numel x) (flatten x |> array1_of_genarray) (flatten y |> array1_of_genarray);
  y

let cast_c2z x =
  let y = empty Complex64 (shape x) in
  _owl_cast_c2z (numel x) (flatten x |> array1_of_genarray) (flatten y |> array1_of_genarray);
  y

let cast_z2c x =
  let y = empty Complex32 (shape x) in
  _owl_cast_z2c (numel x) (flatten x |> array1_of_genarray) (flatten y |> array1_of_genarray);
  y

let cast_s2c x =
  let y = empty Complex32 (shape x) in
  _owl_cast_s2c (numel x) (flatten x |> array1_of_genarray) (flatten y |> array1_of_genarray);
  y

let cast_d2z x =
  let y = empty Complex64 (shape x) in
  _owl_cast_d2z (numel x) (flatten x |> array1_of_genarray) (flatten y |> array1_of_genarray);
  y

let cast_s2z x =
  let y = empty Complex64 (shape x) in
  _owl_cast_s2z (numel x) (flatten x |> array1_of_genarray) (flatten y |> array1_of_genarray);
  y

let cast_d2c x =
  let y = empty Complex32 (shape x) in
  _owl_cast_d2c (numel x) (flatten x |> array1_of_genarray) (flatten y |> array1_of_genarray);
  y


(* clipping functions *)

let clip_by_l2norm t x =
  let a = l2norm x in
  match a > t with
  | true  -> mul_scalar x (t /. a)
  | false -> x


(* TODO *)

let insert_slice = None

let remove_slice = None

let mapi_slice = None

let map_slice = None

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

let ( >@ ) = greater

let ( <@ ) = less

let ( >=@ ) = greater_equal

let ( <=@ ) = less_equal

let ( +$ ) x a = add_scalar x a

let ( $+ ) a x = add_scalar x a

let ( -$ ) x a = sub_scalar x a

let ( $- ) a x = sub_scalar x a |> neg

let ( *$ ) x a = mul_scalar x a

let ( $* ) a x = mul_scalar x a

let ( /$ ) x a = div_scalar x a

let ( $/ ) a x = div_scalar x a |> reci

let ( @@ ) f x = map f x


(* ends here *)
