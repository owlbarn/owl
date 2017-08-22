(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

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

let flatten x = reshape x [|numel x|]

let init k d f =
  let x = empty k d in
  let y = array1_of_genarray (flatten x) in
  let n = numel x in
  for i = 0 to n - 1 do
    Array1.unsafe_set y i (f i)
  done;
  x

let init_nd k d f =
  let x = empty k d in
  let y = array1_of_genarray (flatten x) in
  let n = numel x in
  let s = shape x in
  let j = Array.copy s in
  for i = 0 to n - 1 do
    Owl_dense_common._index_1d_nd i j s;
    Array1.unsafe_set y i (f j)
  done;
  x

(* FIXME: optimise, no need to iterate all dimension *)
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

let reverse x =
  let y = clone x in
  let x' = x |> flatten |> array1_of_genarray in
  let y' = y |> flatten |> array1_of_genarray in
  let k = kind x in
  let n = numel x in
  _owl_copy k n ~ofsx:0 ~incx:1 ~ofsy:0 ~incy:(-1) x' y';
  y

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
  (* project x and y to 1-dimensional arrays *)
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


let concatenate ?(axis=0) xs =
  (* get the shapes of all inputs and etc. *)
  let shapes = Array.map shape xs in
  let shape0 = Array.copy shapes.(0) in
  shape0.(axis) <- 0;
  let acc_dim = ref 0 in
  (* validate all the input shapes; update step_sz *)
  let step_sz = Array.(make (length xs) 0) in
  Array.iteri (fun i shape1 ->
    step_sz.(i) <- (_calc_slice shape1).(axis);
    acc_dim := !acc_dim + shape1.(axis);
    shape1.(axis) <- 0;
    assert (shape0 = shape1);
  ) shapes;
  (* allocalte space for new array *)
  shape0.(axis) <- !acc_dim;
  let y = empty (kind xs.(0)) shape0 in
  (* flatten y then calculate the number of copies *)
  let z = Bigarray.reshape_1 y (numel y) in
  let slice_sz = (_calc_slice shape0).(axis) in
  let m = numel y / slice_sz in
  let n = Array.length xs in
  (* flatten all the inputs and init the copy location *)
  let x_flt = Array.map (fun x -> Bigarray.reshape_1 x (numel x)) xs in
  let x_ofs = Array.make n 0 in
  (* copy data in the flattened space *)
  let z_ofs = ref 0 in
  let _cp_op = _owl_copy (kind y) in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      ignore(_cp_op step_sz.(j) ~ofsx:x_ofs.(j) ~incx:1 ~ofsy:!z_ofs ~incy:1 x_flt.(j) z);
      x_ofs.(j) <- x_ofs.(j) + step_sz.(j);
      z_ofs := !z_ofs + step_sz.(j);
    done;
  done;
  (* all done, return the combined result *)
  y


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


let expand x d =
  let d0 = d - (num_dims x) in
  match d0 > 0 with
  | true  -> Owl_utils.array_pad `Left (shape x) 1 d0 |> reshape x
  | false -> x


let resize ?(head=true) x d =
  let n0 = numel x in
  let n1 = Array.fold_left (fun a b -> a * b) 1 d in
  let _x = reshape_1 x n0 in
  let ofsx, ofsy =
    match head, n0 < n1 with
    | true, true   -> 0, 0
    | true, false  -> 0, 0
    | false, true  -> 0, (n1 - n0)
    | false, false -> (n0 - n1), 0
  in
  match n0 < n1 with
  | true  -> (
      let k = kind x in
      let y = empty k d in
      fill y (_zero k);
      let _y = reshape_1 y n1 in
      _owl_copy k n0 ~ofsx ~incx:1 ~ofsy ~incy:1 _x _y;
      y
    )
  | false -> (
      let _y = Array1.sub _x ofsx n1 |> genarray_of_array1 in
      reshape _y d
    )


let strides x = x |> shape |> Owl_dense_common._calc_stride


let slice_size x = x |> shape |> Owl_dense_common._calc_slice


let index_nd_1d i_nd _stride =
  Owl_dense_common._index_nd_1d i_nd _stride


let index_1d_nd i_1d _stride =
  let i_nd = Array.copy _stride in
  Owl_dense_common._index_1d_nd i_1d i_nd _stride;
  i_nd


(* TODO: zpxy, zmxy, sort ... *)

(* TODO: add axis paramater *)


(* general broadcast operation for add/sub/mul/div and etc.
  This function compares the dimension element-wise from the highest to the
  lowest with the following broadcast rules (same as numpy):
  1. equal; 2. either is 1.
 *)
let broadcast_op op x0 x1 =
  (* align the rank of inputs *)
  let d0 = num_dims x0 in
  let d1 = num_dims x1 in
  let d3 = max d0 d1 in
  let y0 = expand x0 d3 in
  let y1 = expand x1 d3 in
  (* check whether the shape is valid *)
  let sy0 = shape y0 in
  let sy1 = shape y1 in
  Array.iter2 (fun a b ->
    if a <> 1 && b <> 1 && a <> b then
      failwith "broadcast_op: slice not aligned"
  ) sy0 sy1;
  (* calculate the output shape *)
  let s3 = Array.map2 max sy0 sy1 in
  (* tile y0, i.e. x0 as output *)
  let st = Array.map2 (fun a b -> a / b) s3 sy0 in
  let x3 = tile y0 st in
  (* tile x1 as x4 with orginal rank *)
  let s1 = shape x1 in
  let s4 = Array.sub s3 (d3-d1) d1 in
  let st = Array.map2 (fun a b -> a / b) s4 s1 in
  let x4 = tile x1 st in
  (* reshape both into 2d matrices *)
  let k = kind x4 in
  let n = numel x4 in
  let m = numel x3 / n in
  let y4 = reshape x4 [|1;n|] |> array2_of_genarray in
  let y3 = reshape x3 [|m;n|] |> array2_of_genarray in
  (* call broadcast in eigen, return the tiled x3 *)
  (_eigen_rowwise_op k) op y3 y4;
  x3


(* mathematical functions *)

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

let minmax_i x = min_i x, max_i x

let min x = x |> min_i |> fst

let max x = x |> max_i |> fst

let minmax x =
  let minx_i, maxx_i = minmax_i x in
  fst minx_i, fst maxx_i

let add x y =
  match same_shape x y with
  | true  -> (
      let z = clone x in
      let x = ndarray_to_c_mat z in
      let y = ndarray_to_c_mat y in
      let _ = Owl_backend_gsl_linalg.add (kind z) x y in
      z
    )
  | false -> broadcast_op 0 x y

let sub x y =
  match same_shape x y with
  | true  -> (
      let z = clone x in
      let x = ndarray_to_c_mat z in
      let y = ndarray_to_c_mat y in
      let _ = Owl_backend_gsl_linalg.sub (kind z) x y in
      z
    )
  | false -> broadcast_op 1 x y

let mul x y =
  match same_shape x y with
  | true  -> (
      let z = clone x in
      let x = ndarray_to_c_mat z in
      let y = ndarray_to_c_mat y in
      let _ = Owl_backend_gsl_linalg.mul (kind z) x y in
      z
    )
  | false -> broadcast_op 2 x y

let div x y =
  match same_shape x y with
  | true  -> (
      let z = clone x in
      let x = ndarray_to_c_mat z in
      let y = ndarray_to_c_mat y in
      let _ = Owl_backend_gsl_linalg.div (kind z) x y in
      z
  )
  | false -> broadcast_op 3 x y

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

let fmod x y =
  let z = empty (kind x) (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  _owl_fmod (kind x) (numel z) x' y' z';
  z

let fmod_scalar x a =
  let y = empty (kind x) (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  _owl_fmod_scalar (kind x) (numel y) x' y' a;
  y

let scalar_fmod a x =
  let y = empty (kind x) (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  _owl_scalar_fmod (kind x) (numel y) x' y' a;
  y

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

let exp10 x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_exp10 (kind x) (numel y) src dst in
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

let fix x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_fix (kind x) (numel y) src dst in
  y

let angle x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_angle (kind x) (numel y) src dst in
  y

let proj x =
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_proj (kind x) (numel y) src dst in
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

let elu ?(alpha=1.0) x =
  let y = empty (kind x) (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  _owl_elu (kind x) (numel x) x' y' alpha;
  y

let leaky_relu ?(alpha=0.2) x =
  let y = empty (kind x) (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  _owl_leaky_relu (kind x) (numel x) x' y' alpha;
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
let scalar_pow a x =
  let y = empty (kind x) (shape x) in
  fill y a;
  pow y x

(* TODO: optimise *)
let pow_scalar x a =
  let y = empty (kind x) (shape x) in
  fill y a;
  pow x y

(* TODO: optimise *)
let scalar_atan2 a x =
  let y = empty (kind x) (shape x) in
  fill y a;
  atan2 y x

(* TODO: optimise *)
let atan2_scalar x a =
  let y = empty (kind x) (shape x) in
  fill y a;
  atan2 x y

let scalar_add a x =
  let z = clone x in
  let x = ndarray_to_c_mat z in
  let _ = Owl_backend_gsl_linalg.add_scalar (kind z) x a in
  z

let scalar_sub a x =
  let z = neg x in
  let x = ndarray_to_c_mat z in
  let _ = Owl_backend_gsl_linalg.add_scalar (kind z) x a in
  z

let scalar_mul a x =
  let z = clone x in
  let x = ndarray_to_c_mat z in
  let _ = Owl_backend_gsl_linalg.mul_scalar (kind z) x a in
  z

let scalar_div a x =
  let z = reci x in
  let x = ndarray_to_c_mat z in
  let _ = Owl_backend_gsl_linalg.mul_scalar (kind z) x a in
  z

let reci_tol ?tol x =
  let tol = match tol with
    | Some t -> t
    | None   -> _float_typ_elt (kind x) (Owl_utils.eps Float32)
  in
  let y = clone x in
  let src = flatten x |> array1_of_genarray in
  let dst = flatten y |> array1_of_genarray in
  let _ = _owl_reci_tol (kind x) (numel y) src dst tol in
  y

(* element-wise comparison functions *)

let elt_equal x y =
  let z = empty (kind x) (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  _owl_elt_equal (kind x) (numel z) x' y' z';
  z

let elt_not_equal x y =
  let z = empty (kind x) (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  _owl_elt_not_equal (kind x) (numel z) x' y' z';
  z

let elt_less x y =
  let z = empty (kind x) (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  _owl_elt_less (kind x) (numel z) x' y' z';
  z

let elt_greater x y =
  let z = empty (kind x) (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  _owl_elt_greater (kind x) (numel z) x' y' z';
  z

let elt_less_equal x y =
  let z = empty (kind x) (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  _owl_elt_less_equal (kind x) (numel z) x' y' z';
  z

let elt_greater_equal x y =
  let z = empty (kind x) (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  _owl_elt_greater_equal (kind x) (numel z) x' y' z';
  z

let elt_equal_scalar x a =
  let y = empty (kind x) (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  _owl_elt_equal_scalar (kind x) (numel x) x' y' a;
  y

let elt_not_equal_scalar x a =
  let y = empty (kind x) (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  _owl_elt_not_equal_scalar (kind x) (numel x) x' y' a;
  y

let elt_less_scalar x a =
  let y = empty (kind x) (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  _owl_elt_less_scalar (kind x) (numel x) x' y' a;
  y

let elt_greater_scalar x a =
  let y = empty (kind x) (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  _owl_elt_greater_scalar (kind x) (numel x) x' y' a;
  y

let elt_less_equal_scalar x a =
  let y = empty (kind x) (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  _owl_elt_less_equal_scalar (kind x) (numel x) x' y' a;
  y

let elt_greater_equal_scalar x a =
  let y = empty (kind x) (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  _owl_elt_greater_equal_scalar (kind x) (numel x) x' y' a;
  y

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

let gaussian : type a b. ?sigma:float -> (a, b) kind -> int array -> (a, b) t =
  fun ?(sigma=1.) kind dimension ->
  let x = empty kind dimension in
  let n = numel x in
  let y = Bigarray.reshape_1 x n in
  let _ = match kind with
  | Float32 -> (
    for i = 0 to n - 1 do
      y.{i} <- Owl_stats.Rnd.gaussian ~sigma ()
    done
    )
  | Float64 -> (
    for i = 0 to n - 1 do
      y.{i} <- Owl_stats.Rnd.gaussian ~sigma ()
    done
    )
  | Complex32 -> (
    for i = 0 to n - 1 do
      y.{i} <- Complex.({ re = Owl_stats.Rnd.gaussian ~sigma (); im = Owl_stats.Rnd.gaussian ~sigma () })
    done
    )
  | Complex64 -> (
    for i = 0 to n - 1 do
      y.{i} <- Complex.({ re = Owl_stats.Rnd.gaussian ~sigma (); im = Owl_stats.Rnd.gaussian ~sigma () })
    done
    )
  | _ -> failwith "Owl_dense_ndarray_generic.gaussian: unknown type"
  in x

let linspace k a b n =
  let x = Array1.create k c_layout n in
  _owl_linspace k n a b x;
  genarray_of_array1 x

let logspace k ?(base=Owl_maths.e) a b n =
  let x = Array1.create k c_layout n in
  _owl_logspace k n base a b x;
  genarray_of_array1 x

let bernoulli k ?(p=0.5) ?seed d =
  assert (p >= 0. && p <= 1.);
  let seed = match seed with
    | Some a -> a
    | None   -> Owl_stats.Rnd.uniform_int ()
  in
  let x = empty k d in
  let y = x |> flatten |> array1_of_genarray in
  (_owl_bernoulli k) (numel x) y p seed;
  x

let create kind dimension a =
  let x = empty kind dimension in
  let _ = fill x a in
  x

let zeros kind dimension = create kind dimension (_zero kind)

let ones kind dimension = create kind dimension (_one kind)

let sequential k ?a ?step dimension =
  let a = match a with
    | Some a -> a
    | None   -> _zero k
  in
  let step = match step with
    | Some step -> step
    | None      -> _one k
  in
  let x = empty k dimension in
  let y = flatten x |> array1_of_genarray in
  _owl_sequential k (numel x) y a step;
  x

let dropout ?(rate=0.5) ?seed x =
  let y = bernoulli ~p:(1. -. rate) ?seed (kind x) (shape x) in
  mul x y


(* advanced operations *)

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
  let s = Owl_utils.Stack.make () in
  iteri ?axis (fun i y ->
    if f i y = true then
      let j = Array.copy i in
      Owl_utils.Stack.push s j
  ) x;
  Owl_utils.Stack.to_array s

let filter ?axis f x = filteri ?axis (fun _ y -> f y) x

let foldi ?axis f a x =
  let c = ref a in
  iteri ?axis (fun i y -> c := (f i !c y)) x;
  !c

let fold ?axis f a x =
  let c = ref a in
  iter ?axis (fun y -> c := (f !c y)) x;
  !c

let get_slice axis x = Owl_slicing.get_slice_list_typ axis x

let set_slice axis x y = Owl_slicing.set_slice_list_typ axis x y

let get_slice_simple axis x = Owl_slicing.get_slice_simple axis x

let set_slice_simple axis x y = Owl_slicing.set_slice_simple axis x y

let rec _iteri_slice index slice_def axis f x =
  if Array.length axis = 0 then (
    f index (Owl_slicing.get_slice_array_typ slice_def x)
  )
  else (
    let s = shape x in
    for i = 0 to s.(axis.(0)) - 1 do
      index.(axis.(0)) <- [|i|];
      slice_def.(axis.(0)) <- R_ [|i|];
      _iteri_slice index slice_def (Array.sub axis 1 (Array.length axis - 1)) f x
    done
  )

let iteri_slice axis f x =
  if Array.length axis > num_dims x then
    failwith "iteri_slice: invalid indices";
  let index = Array.make (num_dims x) [||] in
  let slice_def = Array.make (num_dims x) (R_ [||]) in
  _iteri_slice index slice_def axis f x

let iter_slice axis f x = iteri_slice axis (fun _ y -> f y) x

let flip ?(axis=0) x =
  let a = Array.init (num_dims x) (fun _ -> R_ [||]) in
  a.(axis) <- R_ [|-1;0|];
  Owl_slicing.get_slice_array_typ a x


let rotate x degree =
  assert (degree mod 90 = 0);
  let k = (degree mod 360) / 90 in
  let _cp_op = _owl_copy (kind x) in

  if num_dims x < 2 || k = 0 then
    clone x
  else if k = 1 then (
    let sx = shape x in
    let sy = Array.copy sx in
    sy.(0) <- sx.(1);
    sy.(1) <- sx.(0);

    let y = empty (kind x) sy in
    let x' = flatten x |> array1_of_genarray in
    let y' = flatten y |> array1_of_genarray in

    let m = sx.(0) in
    let n = (numel x) / m in
    let ofsx = ref 0 in
    let ofsy = ref 0 in

    if m <= n then (
      for i = 1 to m do
        _cp_op n ~ofsx:!ofsx ~incx:1 ~ofsy:(m - i) ~incy:m x' y';
        ofsx := !ofsx + n
      done
    )
    else (
      for i = 0 to n - 1 do
        _cp_op m ~ofsx:i ~incx:n ~ofsy:!ofsy ~incy:(-1) x' y';
        ofsy := !ofsy + m
      done
    );
    y
  )
  else if k = 2 then (
    let sx = shape x in
    let y = empty (kind x) sx in
    let x' = flatten x |> array1_of_genarray in
    let y' = flatten y |> array1_of_genarray in

    let m = sx.(0) in
    let n = (numel x) / m in

    if m <= n then (
      let ofsx = ref 0 in
      let ofsy = ref ((m - 1) * n) in
      for i = 0 to m - 1 do
        _cp_op n ~ofsx:!ofsx ~incx:1 ~ofsy:!ofsy ~incy:(-1) x' y';
        ofsx := !ofsx + n;
        ofsy := !ofsy - n
      done
    )
    else (
      for i = 0 to n - 1 do
        _cp_op m ~ofsx:i ~incx:n ~ofsy:(n - i - 1) ~incy:(-n) x' y'
      done
    );
    y
  )
  else (
    let sx = shape x in
    let sy = Array.copy sx in
    sy.(0) <- sx.(1);
    sy.(1) <- sx.(0);

    let y = empty (kind x) sy in
    let x' = flatten x |> array1_of_genarray in
    let y' = flatten y |> array1_of_genarray in

    let m = sx.(0) in
    let n = (numel x) / m in
    let ofsx = ref 0 in
    let ofsy = ref ((n - 1) * m) in

    if m <= n then (
      for i = 0 to m - 1 do
        _cp_op n ~ofsx:!ofsx ~incx:1 ~ofsy:i ~incy:(-m) x' y';
        ofsx := !ofsx + n
      done
    )
    else (
      for i = 0 to n - 1 do
        _cp_op m ~ofsx:i ~incx:n ~ofsy:!ofsy ~incy:1 x' y';
        ofsy := !ofsy - m
      done
    );
    y
  )


let get_index x axis =
  let d = num_dims x in
  assert (Array.length axis = d);
  let n = Array.length axis.(0) in
  let indices = Array.make_matrix n d 0 in
  Array.iteri (fun j a ->
    Array.iteri (fun i b -> indices.(i).(j) <- b) a
  ) axis;
  Array.map (fun i -> Bigarray.Genarray.get x i) indices


let set_index x axis a =
  let d = num_dims x in
  assert (Array.length axis = d);
  let n = Array.length axis.(0) in
  let indices = Array.make_matrix n d 0 in
  Array.iteri (fun j a ->
    Array.iteri (fun i b -> indices.(i).(j) <- b) a
  ) axis;
  if Array.length a = 1 then
    Array.iteri (fun i j -> Bigarray.Genarray.set x j a.(0)) indices
  else
    Array.iteri (fun i j -> Bigarray.Genarray.set x j a.(i)) indices


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

let is_normal x =
  let y = flatten x |> array1_of_genarray in
  let _op = _owl_is_normal (kind x) in
  _op (numel x) y = 1

let not_nan x =
  let y = flatten x |> array1_of_genarray in
  let _op = _owl_not_nan (kind x) in
  _op (numel x) y = 1

let not_inf x =
  let y = flatten x |> array1_of_genarray in
  let _op = _owl_not_inf (kind x) in
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

let equal_scalar x a =
  let x' = flatten x |> array1_of_genarray in
  let _op = _owl_equal_scalar (kind x) in
  _op (numel x) x' a = 1

let not_equal_scalar x a =
  let x' = flatten x |> array1_of_genarray in
  let _op = _owl_not_equal_scalar (kind x) in
  _op (numel x) x' a = 1

let less_scalar x a =
  let x' = flatten x |> array1_of_genarray in
  let _op = _owl_less_scalar (kind x) in
  _op (numel x) x' a = 1

let greater_scalar x a =
  let x' = flatten x |> array1_of_genarray in
  let _op = _owl_greater_scalar (kind x) in
  _op (numel x) x' a = 1

let less_equal_scalar x a =
  let x' = flatten x |> array1_of_genarray in
  let _op = _owl_less_equal_scalar (kind x) in
  _op (numel x) x' a = 1

let greater_equal_scalar x a =
  let x' = flatten x |> array1_of_genarray in
  let _op = _owl_greater_equal_scalar (kind x) in
  _op (numel x) x' a = 1

let approx_equal ?eps x y =
  let eps = match eps with
    | Some eps -> eps
    | None     -> Owl_utils.eps Float32
  in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let _op = _owl_approx_equal (kind x) in
  _op (numel x) x' y' eps = 1

let approx_equal_scalar ?eps x a =
  let eps = match eps with
    | Some eps -> eps
    | None     -> Owl_utils.eps Float32
  in
  let x' = flatten x |> array1_of_genarray in
  let _op = _owl_approx_equal_scalar (kind x) in
  _op (numel x) x' a eps = 1

let approx_elt_equal ?eps x y =
  let eps = match eps with
    | Some eps -> eps
    | None     -> Owl_utils.eps Float32
  in
  let _eps : type a b. (a, b) kind -> float -> a =
    fun k a -> match k with
    | Float32   -> a
    | Float64   -> a
    | Complex32 -> Complex.({re = a; im = 0.})
    | Complex64 -> Complex.({re = a; im = 0.})
    | _         -> failwith "Owl_dense_ndarray_generic:approx_elt_equal"
  in
  let k = kind x in
  let z = create k (shape x) (_eps k eps) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  _owl_approx_elt_equal k (numel z) x' y' z';
  z

let approx_elt_equal_scalar ?eps x a =
  let eps = match eps with
    | Some eps -> eps
    | None     -> Owl_utils.eps Float32
  in
  let _eps : type a b. (a, b) kind -> float -> a =
    fun k a -> match k with
    | Float32   -> a
    | Float64   -> a
    | Complex32 -> Complex.({re = a; im = 0.})
    | Complex64 -> Complex.({re = a; im = 0.})
    | _         -> failwith "Owl_dense_ndarray_generic:approx_elt_equal"
  in
  let k = kind x in
  let y = create k (shape x) (_eps k eps) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  _owl_approx_elt_equal_scalar k (numel y) x' y' a;
  y

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

let of_array k x d =
  let n = Array.fold_left (fun a b -> a * b) 1 d in
  assert (Array.length x = n);
  let y = Array1.of_array k C_layout x |> genarray_of_array1 in
  reshape y d

let to_array x =
  let y = reshape x [|1;numel x|] |> array2_of_genarray in
  Owl_backend_gsl_linalg.to_array (kind x) y


let complex
  : type a b c d. (a, b) kind -> (c, d) kind -> (a, b) t -> (a, b) t -> (c, d) t
  = fun real_kind complex_kind re im ->
  assert (shape re = shape im);
  let _re = flatten re |> array1_of_genarray in
  let _im = flatten im |> array1_of_genarray in
  let x = empty complex_kind (shape re) in
  let _x = flatten x |> array1_of_genarray in
  _owl_to_complex real_kind complex_kind (numel re) _re _im _x;
  x

let polar
  : type a b c d. (a, b) kind -> (c, d) kind -> (a, b) t -> (a, b) t -> (c, d) t
  = fun real_kind complex_kind rho theta ->
  assert (shape rho = shape theta);
  let _rho = flatten rho |> array1_of_genarray in
  let _theta = flatten theta |> array1_of_genarray in
  let x = empty complex_kind (shape rho) in
  let _x = flatten x |> array1_of_genarray in
  _owl_polar real_kind complex_kind (numel rho) _rho _theta _x;
  x


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

let clip_by_value ?amin ?amax x =
  let k = kind x in
  let amin = match amin with
    | Some a -> a
    | None   -> _neg_inf k
  in
  let amax = match amax with
    | Some a -> a
    | None   -> _pos_inf k
  in
  let y = clone x in
  let z = flatten y |> array1_of_genarray in
  _owl_clip_by_value k (numel x) amin amax z;
  y

let clip_by_l2norm t x =
  let a = l2norm x in
  match a > t with
  | true  -> mul_scalar x (t /. a)
  | false -> x


(* padding and its helper functions *)

let _expand_padding_index d s =
  let ls = Array.length s in
  let ld = Array.length d in
  let d = Owl_utils.(array_pad `Right d [|0;0|] (ls - ld)) in
  Array.map (function
    | [||]  -> [|0;0|]
    | [|x|] -> [|x;x|]
    | x     -> x
  ) d

(*
  k : kind of the source
  p1: padding index
  ls: slice size of the source
  l0: stride size of the source
  l1: stride size of the destination
  i0: current source nd index
  i1: current destination nd index
  d0: current depth of index
  d1: depth threshold
  s0: shape of the source
  s1: shape of the destination
  x0: source
  x1: destination
 *)
let rec _copy_to_padding k p1 ls l0 l1 i0 i1 d0 d1 s0 s1 x0 x1 =
  if d0 < d1 then (
    (* Printf.printf "+++ %i\n" d0; *)
    for i = 0 to s0.(d0) - 1 do
      i0.(d0) <- i;
      i1.(d0) <- i + p1.(d0).(0);
      _copy_to_padding k p1 ls l0 l1 i0 i1 (d0 + 1) d1 s0 s1 x0 x1;
      i0.(d0) <- 0;
      i1.(d0) <- p1.(d0).(0);
    done
  )
  else (
    (* print_index i0; Printf.printf " === "; print_index i1; print_endline ""; *)
    let j0 = _index_nd_1d i0 l0 in
    let j1 = _index_nd_1d i1 l1 in
    _owl_copy k ls.(d0) ~ofsx:j0 ~incx:1 ~ofsy:j1 ~incy:1 x0 x1
  )

(* according to the expanded padding index, calcuate the highest dimension
  with padding, so we can figure out the minimum continuous block size.
 *)
let _highest_padding_dimension p =
  let l = Array.length p - 1 in
  let d = ref l in
  (try for i = l downto 0 do
    d := i;
    if p.(i) <> [|0;0|] then failwith "stop"
  done with exn -> ());
  !d

let pad ?v d x =
  let k = kind x in
  let v = match v with
    | Some v -> v
    | None   -> _zero k
  in
  let s0 = shape x in
  let p1 = _expand_padding_index (Owl_utils.llss2aarr d) s0 in
  let s1 = Array.map2 (fun m n -> m + n.(0) + n.(1)) s0 p1 in
  let y = create k s1 v in
  (* prepare variables for block copying *)
  let ls = _calc_slice s0 in
  let l0 = _calc_stride s0 in
  let l1 = _calc_stride s1 in
  let i0 = Array.make (num_dims x) 0 in
  let i1 = Array.map (fun a -> a.(0)) p1 in
  let d0 = 0 in
  let d1 = _highest_padding_dimension p1 in
  let x0 = Bigarray.reshape_1 x (numel x) in
  let x1 = Bigarray.reshape_1 y (numel y) in
  _copy_to_padding k p1 ls l0 l1 i0 i1 d0 d1 s0 s1 x0 x1;
  y



(* NOTE
  The following functions (i.e., conv2d* and conv3d* and etc.) are for neural
  network functionality. Currently I keep them here because Algodiff functor
  uses this module as parameter. In future, I might wrap them into separate
  modules to reduce the compplexity of the generic module.
 *)


(* calculate the output shape of [conv2d] given input and kernel and stride *)
let calc_conv2d_output_shape
  padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  =
  let input_cols = float_of_int input_cols in
  let input_rows = float_of_int input_rows in
  let kernel_cols = float_of_int kernel_cols in
  let kernel_rows = float_of_int kernel_rows in
  let row_stride = float_of_int row_stride in
  let col_stride = float_of_int col_stride in
  let output_cols = match padding with
    | SAME  -> (input_cols /. col_stride) |> Owl_maths.ceil |> int_of_float
    | VALID -> ((input_cols -. kernel_cols +. 1.) /. col_stride) |> Owl_maths.ceil |> int_of_float
  in
  let output_rows = match padding with
    | SAME  -> (input_rows /. row_stride) |> Owl_maths.ceil |> int_of_float
    | VALID -> ((input_rows -. kernel_rows +. 1.) /. row_stride) |> Owl_maths.ceil |> int_of_float
  in
  (output_cols, output_rows)

(* calculate the padding size along width and height *)
let calc_conv2d_padding
  input_cols input_rows kernel_cols kernel_rows output_cols output_rows row_stride col_stride
  =
  let pad_along_height = Pervasives.max ((output_rows - 1) * row_stride + kernel_rows - input_rows) 0 in
  let pad_along_width = Pervasives.max ((output_cols - 1) * col_stride + kernel_cols - input_cols) 0 in
  let pad_top = pad_along_height / 2 in
  let pad_bottom = pad_along_height - pad_top in
  let pad_left = pad_along_width / 2 in
  let pad_right = pad_along_width - pad_left in
  pad_top, pad_left, pad_bottom, pad_right

(* calc_conv1d_output_shape actually calls its 2d version  *)
let calc_conv1d_output_shape padding input_cols kernel_cols col_stride =
  let input_rows = 1 in
  let kernel_rows = 1 in
  let row_stride = 1 in
  calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  |> fst

(* conv2d: 4d input and 4d kernel, refer to tensorlfow doc
  input : [batch; input_column; input_row; input_channel]
  kernel: [kernel_column; kernel_row; input_channel; output_channel]
  stride: [column_stride; row_stride]
  output: [batch; output_column; output_row; output_channel]
 *)
let conv2d ?(padding=SAME) input kernel stride =
  assert (num_dims input = 4);
  assert (num_dims kernel = 4);
  assert (Array.length stride = 2);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let in_channel = input_shp.(3) in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let kernel_rows = kernel_shp.(1) in
  let out_channel = kernel_shp.(3) in
  assert (in_channel = kernel_shp.(2));

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in
  let col_in_stride = 1 in
  let row_in_stride = 1 in

  let output_cols, output_rows =
    calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  let output = empty (kind input) [|batches; output_cols; output_rows; out_channel|] in

  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  (* FIXME: DEBUG *)
  (*
  Printf.printf "input:\t [ b:%i, c:%i, r:%i, i:%i ]\n" batches input_cols input_rows in_channel;
  Printf.printf "kernel:\t [ c:%i, r:%i, i:%i, o:%i ]\n" kernel_cols kernel_rows in_channel out_channel;
  Printf.printf "output:\t [ b:%i, c:%i, r:%i, o:%i ]\n" batches output_cols output_rows out_channel;
  flush_all ();
  *)

  _eigen_spatial_conv (kind input)
    input kernel output batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows out_channel
    row_stride col_stride pad_typ row_in_stride col_in_stride;

  output


(* gradient of conv2d w.r.t the input *)
let conv2d_backward_input input kernel stride output' =
  assert (num_dims input = 4);
  assert (num_dims kernel = 4);
  assert (num_dims output' = 4);
  assert (Array.length stride = 2);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let in_channel = input_shp.(3) in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let kernel_rows = kernel_shp.(1) in
  let out_channel = kernel_shp.(3) in
  assert (in_channel = kernel_shp.(2));

  let output_shp = shape output' in
  let output_cols = output_shp.(1) in
  let output_rows = output_shp.(2) in
  assert (batches = output_shp.(0));
  assert (out_channel = output_shp.(3));

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in
  let col_in_stride = 1 in
  let row_in_stride = 1 in

  let input' = empty (kind input) (shape input) in

  _eigen_spatial_conv_backward_input (kind input')
    input' kernel output' batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows out_channel
    row_stride col_stride row_in_stride col_in_stride;

  input'


(* gradient of conv2d w.r.t the kernel *)
let conv2d_backward_kernel input kernel stride output' =
  assert (num_dims input = 4);
  assert (num_dims kernel = 4);
  assert (num_dims output' = 4);
  assert (Array.length stride = 2);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let in_channel = input_shp.(3) in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let kernel_rows = kernel_shp.(1) in
  let out_channel = kernel_shp.(3) in
  assert (in_channel = kernel_shp.(2));

  let output_shp = shape output' in
  let output_cols = output_shp.(1) in
  let output_rows = output_shp.(2) in
  assert (batches = output_shp.(0));
  assert (out_channel = output_shp.(3));

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in
  let col_in_stride = 1 in
  let row_in_stride = 1 in

  let kernel' = empty (kind kernel) (shape kernel) in

  _eigen_spatial_conv_backward_kernel (kind input)
    input kernel' output' batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows out_channel
    row_stride col_stride row_in_stride col_in_stride;

  kernel'


(* calculate the output shape of [conv3d] given input and kernel and stride *)
let calc_conv3d_output_shape
  padding input_cols input_rows input_dpts
  kernel_cols kernel_rows kernel_dpts
  row_stride col_stride dpt_stride
  =
  let input_cols = float_of_int input_cols in
  let input_rows = float_of_int input_rows in
  let input_dpts = float_of_int input_dpts in
  let kernel_cols = float_of_int kernel_cols in
  let kernel_rows = float_of_int kernel_rows in
  let kernel_dpts = float_of_int kernel_dpts in
  let row_stride = float_of_int row_stride in
  let col_stride = float_of_int col_stride in
  let dpt_stride = float_of_int dpt_stride in
  let output_cols = match padding with
    | SAME  -> (input_cols /. col_stride) |> Owl_maths.ceil |> int_of_float
    | VALID -> ((input_cols -. kernel_cols +. 1.) /. col_stride) |> Owl_maths.ceil |> int_of_float
  in
  let output_rows = match padding with
    | SAME  -> (input_rows /. row_stride) |> Owl_maths.ceil |> int_of_float
    | VALID -> ((input_rows -. kernel_rows +. 1.) /. row_stride) |> Owl_maths.ceil |> int_of_float
  in
  let output_dpts = match padding with
    | SAME  -> (input_dpts /. dpt_stride) |> Owl_maths.ceil |> int_of_float
    | VALID -> ((input_dpts -. kernel_dpts +. 1.) /. dpt_stride) |> Owl_maths.ceil |> int_of_float
  in
  (output_cols, output_rows, output_dpts)


(* conv3d: 5d input and 5d kernel, refer to tensorflow doc
  input : [batch; input_column; input_row; input_depth; input_channel]
  kernel: [kernel_column; kernel_row; kernel_depth; input_channel; output_channel]
  stride: [column_stride; row_stride; depth_stride]
  output: [batch; output_column; output_row; output_dpts; output_channel]
 *)
let conv3d ?(padding=SAME) input kernel stride =
  assert (num_dims input = 5);
  assert (num_dims kernel = 5);
  assert (Array.length stride = 3);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let input_dpts = input_shp.(3) in
  let in_channel = input_shp.(4) in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let kernel_rows = kernel_shp.(1) in
  let kernel_dpts = kernel_shp.(2) in
  let out_channel = kernel_shp.(4) in
  assert (in_channel = kernel_shp.(3));

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in
  let dpt_stride = stride.(2) in

  let output_cols, output_rows, output_dpts =
    calc_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols kernel_rows kernel_dpts row_stride col_stride dpt_stride
  in
  let output = empty (kind input) [|batches; output_cols; output_rows; output_dpts; out_channel|] in

  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  (* FIXME: DEBUG *)
  (*
  Printf.printf "input:\t [ b:%i, c:%i, r:%i, d:%i, i:%i ]\n" batches input_cols input_rows input_dpts in_channel;
  Printf.printf "kernel:\t [ c:%i, r:%i, d:%i, i:%i, o:%i ]\n" kernel_cols kernel_rows kernel_dpts in_channel out_channel;
  Printf.printf "output:\t [ b:%i, c:%i, r:%i, d:%i, o:%i ]\n" batches output_cols output_rows output_dpts out_channel;
  flush_all ();
  *)

  _eigen_cuboid_conv (kind input)
    input kernel output batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts out_channel
    dpt_stride row_stride col_stride pad_typ;

  output


(* gradient of conv3d w.r.t the input *)
let conv3d_backward_input input kernel stride output' =
  assert (num_dims input = 5);
  assert (num_dims kernel = 5);
  assert (num_dims output' = 5);
  assert (Array.length stride = 3);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let input_dpts = input_shp.(3) in
  let in_channel = input_shp.(4) in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let kernel_rows = kernel_shp.(1) in
  let kernel_dpts = kernel_shp.(2) in
  let out_channel = kernel_shp.(4) in
  assert (in_channel = kernel_shp.(3));

  let output_shp = shape output' in
  let output_cols = output_shp.(1) in
  let output_rows = output_shp.(2) in
  let output_dpts =  output_shp.(3) in
  assert (batches = output_shp.(0));
  assert (out_channel = output_shp.(4));

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in
  let dpt_stride = stride.(2) in

  let input' = empty (kind input) (shape input) in

  _eigen_cuboid_conv_backward_input (kind input')
    input' kernel output' batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts out_channel
    dpt_stride row_stride col_stride;

  input'


(* gradient of conv3d w.r.t the kernel *)
let conv3d_backward_kernel input kernel stride output' =
  assert (num_dims input = 5);
  assert (num_dims kernel = 5);
  assert (num_dims output' = 5);
  assert (Array.length stride = 3);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let input_dpts = input_shp.(3) in
  let in_channel = input_shp.(4) in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let kernel_rows = kernel_shp.(1) in
  let kernel_dpts = kernel_shp.(2) in
  let out_channel = kernel_shp.(4) in
  assert (in_channel = kernel_shp.(3));

  let output_shp = shape output' in
  let output_cols = output_shp.(1) in
  let output_rows = output_shp.(2) in
  let output_dpts =  output_shp.(3) in
  assert (batches = output_shp.(0));
  assert (out_channel = output_shp.(4));

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in
  let dpt_stride = stride.(2) in

  let kernel' = empty (kind kernel) (shape kernel) in

  _eigen_cuboid_conv_backward_kernel (kind input)
    input kernel' output' batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts out_channel
    dpt_stride row_stride col_stride;

  kernel'


(* conv1d: 3d input and 3d kernel, refer to tensorlfow doc
  input : [batch; input_column; input_channel]
  kernel: [kernel_column; input_channel; output_channel]
  stride: [column_stride]
  output: [batch; output_column; output_channel]
 *)
let conv1d ?(padding=SAME) input kernel stride =
  assert (num_dims input = 3);
  assert (num_dims kernel = 3);
  assert (Array.length stride = 1);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let in_channel = input_shp.(2) in
  let input = reshape input [|batches; 1; input_cols; in_channel|] in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let out_channel = kernel_shp.(2) in
  assert (in_channel = kernel_shp.(1));
  let kernel = reshape kernel [|1;kernel_cols; in_channel; out_channel|] in

  let col_stride = stride.(0) in
  let stride = [|1; col_stride|] in

  let output = conv2d ~padding input kernel stride in
  let output_shp = shape output in
  let output_cols = output_shp.(2) in
  let output = reshape output [|batches; output_cols; out_channel|] in
  output


(* gradient of conv1d w.r.t the input *)
let conv1d_backward_input input kernel stride output' =
  assert (num_dims input = 3);
  assert (num_dims kernel = 3);
  assert (num_dims output' = 3);
  assert (Array.length stride = 1);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let in_channel = input_shp.(2) in
  let input_rows = 1 in
  let input = reshape input [|batches; input_rows; input_cols; in_channel|] in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let out_channel = kernel_shp.(2) in
  assert (in_channel = kernel_shp.(1));
  let kernel_rows = 1 in
  let kernel = reshape kernel [|kernel_rows; kernel_cols; in_channel; out_channel|] in

  let output'_shp = shape output' in
  let output_cols = output'_shp.(1) in
  assert (batches = output'_shp.(0));
  assert (out_channel = output'_shp.(2));
  let output_rows = 1 in
  let output' = reshape output' [|batches; output_rows; output_cols; out_channel|] in

  let col_stride = stride.(0) in
  let row_stride = 1 in
  let stride = [|row_stride; col_stride|] in

  let input' = conv2d_backward_input input kernel stride output' in
  reshape input' input_shp


(* gradient of conv1d w.r.t the kernel *)
let conv1d_backward_kernel input kernel stride output' =
  assert (num_dims input = 3);
  assert (num_dims kernel = 3);
  assert (num_dims output' = 3);
  assert (Array.length stride = 1);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let in_channel = input_shp.(2) in
  let input_rows = 1 in
  let input = reshape input [|batches; input_rows; input_cols; in_channel|] in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let out_channel = kernel_shp.(2) in
  assert (in_channel = kernel_shp.(1));
  let kernel_rows = 1 in
  let kernel = reshape kernel [|kernel_rows; kernel_cols; in_channel; out_channel|] in

  let output'_shp = shape output' in
  let output_cols = output'_shp.(1) in
  assert (batches = output'_shp.(0));
  assert (out_channel = output'_shp.(2));
  let output_rows = 1 in
  let output' = reshape output' [|batches; output_rows; output_cols; out_channel|] in

  let col_stride = stride.(0) in
  let row_stride = 1 in
  let stride = [|row_stride; col_stride|] in

  let kernel' = conv2d_backward_kernel input kernel stride output' in
  reshape kernel' kernel_shp


(* max_pool2d: 4d input and 2d kernel, refer to tensorlfow doc
  input : [batch; input_column; input_row; input_channel]
  kernel: [kernel_column; kernel_row]
  stride: [column_stride; row_stride]
  output: [batch; output_column; output_row; input_channel]
 *)
let max_pool2d ?(padding=SAME) input kernel stride =
  assert (num_dims input = 4);
  assert (Array.length kernel = 2);
  assert (Array.length stride = 2);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let in_channel = input_shp.(3) in

  let kernel_cols = kernel.(0) in
  let kernel_rows = kernel.(1) in

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in
  let col_in_stride = 1 in
  let row_in_stride = 1 in

  let output_cols, output_rows =
    calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  let output = empty (kind input) [|batches; output_cols; output_rows; in_channel|] in

  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _eigen_spatial_max_pooling (kind input)
    input output batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride pad_typ row_in_stride col_in_stride;

  output


(* max_pool1d: 3d input and 1d kernel, refer to tensorlfow doc
  input : [batch; input_column; input_channel]
  kernel: [kernel_column]
  stride: [column_stride]
  output: [batch; output_column; input_channel]
 *)
let max_pool1d ?(padding=SAME) input kernel stride =
  assert (num_dims input = 3);
  assert (Array.length kernel = 1);
  assert (Array.length stride = 1);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let in_channel = input_shp.(2) in
  let input = reshape input [|batches; 1; input_cols; in_channel|] in

  let kernel_cols = kernel.(0) in
  let kernel = [|1; kernel_cols|] in

  let col_stride = stride.(0) in
  let stride = [|1; col_stride|] in

  let output = max_pool2d ~padding input kernel stride in
  let output_shp = shape output in
  let output_cols = output_shp.(2) in
  let output = reshape output [|batches; output_cols; in_channel|] in
  output


(* similar to max_pool2d *)
let avg_pool2d ?(padding=SAME) input kernel stride =
  assert (num_dims input = 4);
  assert (Array.length kernel = 2);
  assert (Array.length stride = 2);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let in_channel = input_shp.(3) in

  let kernel_cols = kernel.(0) in
  let kernel_rows = kernel.(1) in

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in
  let col_in_stride = 1 in
  let row_in_stride = 1 in

  let output_cols, output_rows =
    calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  let output = empty (kind input) [|batches; output_cols; output_rows; in_channel|] in

  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _eigen_spatial_avg_pooling (kind input)
    input output batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride pad_typ row_in_stride col_in_stride;

  output


(* similar to max_pool1d *)
let avg_pool1d ?(padding=SAME) input kernel stride =
  assert (num_dims input = 3);
  assert (Array.length kernel = 1);
  assert (Array.length stride = 1);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let in_channel = input_shp.(2) in
  let input = reshape input [|batches; 1; input_cols; in_channel|] in

  let kernel_cols = kernel.(0) in
  let kernel = [|1; kernel_cols|] in

  let col_stride = stride.(0) in
  let stride = [|1; col_stride|] in

  let output = avg_pool2d ~padding input kernel stride in
  let output_shp = shape output in
  let output_cols = output_shp.(2) in
  let output = reshape output [|batches; output_cols; in_channel|] in
  output


(* max_pool3d: 5d input and 3d kernel, refer to tensorflow doc
  input : [batch; input_column; input_row; input_depth; input_channel]
  kernel: [kernel_column; kernel_row; kernel_depth]
  stride: [column_stride; row_stride; depth_stride]
  output: [batch; output_column; output_row; output_dpts; input_channel]
 *)
let max_pool3d ?(padding=SAME) input kernel stride =
  assert (num_dims input = 5);
  assert (Array.length kernel = 3);
  assert (Array.length stride = 3);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let input_dpts = input_shp.(3) in
  let in_channel = input_shp.(4) in

  let kernel_cols = kernel.(0) in
  let kernel_rows = kernel.(1) in
  let kernel_dpts = kernel.(2) in

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in
  let dpt_stride = stride.(2) in

  let output_cols, output_rows, output_dpts =
    calc_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols kernel_rows kernel_dpts row_stride col_stride dpt_stride
  in
  let output = empty (kind input) [|batches; output_cols; output_rows; output_dpts; in_channel|] in

  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _eigen_cuboid_max_pooling (kind input)
    input output batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts
    dpt_stride row_stride col_stride pad_typ;

  output


(* simiar to max_pool3d *)
let avg_pool3d ?(padding=SAME) input kernel stride =
  assert (num_dims input = 5);
  assert (Array.length kernel = 3);
  assert (Array.length stride = 3);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let input_dpts = input_shp.(3) in
  let in_channel = input_shp.(4) in

  let kernel_cols = kernel.(0) in
  let kernel_rows = kernel.(1) in
  let kernel_dpts = kernel.(2) in

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in
  let dpt_stride = stride.(2) in

  let output_cols, output_rows, output_dpts =
    calc_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols kernel_rows kernel_dpts row_stride col_stride dpt_stride
  in
  let output = empty (kind input) [|batches; output_cols; output_rows; output_dpts; in_channel|] in

  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _eigen_cuboid_avg_pooling (kind input)
    input output batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts
    dpt_stride row_stride col_stride pad_typ;

  output


(* similar to max_pool2d, but also return the flatten indices of the max values *)
let max_pool2d_argmax ?(padding=SAME) input kernel stride =
  assert (num_dims input = 4);
  assert (Array.length kernel = 2);
  assert (Array.length stride = 2);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let in_channel = input_shp.(3) in

  let kernel_cols = kernel.(0) in
  let kernel_rows = kernel.(1) in

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in

  let output_cols, output_rows =
    calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  let output = empty (kind input) [|batches; output_cols; output_rows; in_channel|] in
  let argmax = Genarray.create int64 c_layout [|batches; output_cols; output_rows; in_channel|] in

  let pad_top, pad_left, _, _ =
    calc_conv2d_padding input_cols input_rows kernel_cols kernel_rows output_cols output_rows row_stride col_stride
  in

  _eigen_spatial_max_pooling_argmax (kind input)
    input output argmax
    batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride pad_top pad_left;

  output, argmax


(* calculate the gradient of max_pool2d *)
let max_pool2d_backward padding input kernel stride output' =
  assert (num_dims input = 4);
  assert (Array.length kernel = 2);
  assert (Array.length stride = 2);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let in_channel = input_shp.(3) in

  let kernel_cols = kernel.(0) in
  let kernel_rows = kernel.(1) in

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in

  let output_cols, output_rows =
    calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  let pad_top, pad_left, _, _ =
    calc_conv2d_padding input_cols input_rows kernel_cols kernel_rows output_cols output_rows row_stride col_stride
  in
  let input' = empty (kind input) (shape input) in

  _eigen_spatial_max_pooling_backward (kind input)
    input output' input'
    batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride pad_top pad_left;

  input'


(* calculate the gradient of max_pool1d *)
let max_pool1d_backward padding input kernel stride output' =
  assert (num_dims input = 3);
  assert (Array.length kernel = 1);
  assert (Array.length stride = 1);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = 1 in
  let in_channel = input_shp.(2) in
  let input = reshape input [|batches; input_rows; input_cols; in_channel|] in

  let kernel_cols = kernel.(0) in
  let kernel_rows = 1 in
  let kernel = [|kernel_rows; kernel_cols|] in

  let col_stride = stride.(0) in
  let row_stride = 1 in
  let stride = [|row_stride; col_stride|] in

  let output'_shp = shape output' in
  let output_cols = output'_shp.(1) in
  let output_rows = 1 in
  let out_channel = output'_shp.(2) in
  let output' = reshape output' [|batches; output_rows; output_cols; out_channel|] in

  let input' = max_pool2d_backward padding input kernel stride output' in
  reshape input' input_shp


(* calculate the gradient of avg_pool2d *)
let avg_pool2d_backward padding input kernel stride output' =
  assert (num_dims input = 4);
  assert (Array.length kernel = 2);
  assert (Array.length stride = 2);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let in_channel = input_shp.(3) in

  let kernel_cols = kernel.(0) in
  let kernel_rows = kernel.(1) in

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in

  let output_cols, output_rows =
    calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  let pad_top, pad_left, _, _ =
    calc_conv2d_padding input_cols input_rows kernel_cols kernel_rows output_cols output_rows row_stride col_stride
  in
  let input' = empty (kind input) (shape input) in

  _eigen_spatial_avg_pooling_backward (kind input)
    input' output'
    batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride pad_top pad_left;

  input'


(* calculate the gradient of avg_pool1d *)
let avg_pool1d_backward padding input kernel stride output' =
  assert (num_dims input = 3);
  assert (Array.length kernel = 1);
  assert (Array.length stride = 1);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = 1 in
  let in_channel = input_shp.(2) in
  let input = reshape input [|batches; input_rows; input_cols; in_channel|] in

  let kernel_cols = kernel.(0) in
  let kernel_rows = 1 in
  let kernel = [|kernel_rows; kernel_cols|] in

  let col_stride = stride.(0) in
  let row_stride = 1 in
  let stride = [|row_stride; col_stride|] in

  let output'_shp = shape output' in
  let output_cols = output'_shp.(1) in
  let output_rows = 1 in
  let out_channel = output'_shp.(2) in
  let output' = reshape output' [|batches; output_rows; output_cols; out_channel|] in

  let input' = avg_pool2d_backward padding input kernel stride output' in
  reshape input' input_shp


(* simiar to sum_rows in matrix, sum all the slices along an axis.
  The default [axis] is the highest dimension. E.g., for [x] of [|2;3;4;5|],
  [sum_slices ~axis:2] returns an ndarray of shape [|4;5|].

  currently, the operation is done using [gemm], fast but uses more memory.
 *)
let sum_slices ?axis x =
  let axis = match axis with
    | Some a -> a
    | None   -> num_dims x - 1
  in
  (* reshape into 2d matrix *)
  let s = shape x in
  let n = (_calc_slice s).(axis) in
  let m = (numel x) / n in
  let y = reshape x [|m;n|] |> array2_of_genarray in
  (* create a row vector of all ones *)
  let v = ones (kind x) [|1;m|] |> array2_of_genarray in
  (* sum all the rows using gemm operation *)
  let y = Owl_backend_gsl_linalg.dot (kind x) v y in
  (* reshape back into ndarray *)
  let s = Array.(sub s axis (length s - axis)) in
  reshape (genarray_of_array2 y) s


(* FIXME: experimental *)
let draw_slices ?(axis=0) x n =
  let shp = shape x in
  let pre = Array.sub shp 0 axis in
  let pad_len = num_dims x - axis - 1 in
  let indices = Array.init n (fun _ ->
    let idx_pre = Array.map (fun b -> Owl_stats.Rnd.uniform_int ~a:0 ~b:(b-1) ()) pre in
    Owl_utils.(array_pad `Right idx_pre 0 pad_len)
  ) in
  (* copy slices to the output array *)
  let sfx = Array.sub shp axis (num_dims x - axis) in
  let y = empty (kind x) Array.(append [|n|] sfx) in
  let jdx = Array.make (num_dims y) 0 in
  Array.iteri (fun i idx ->
    let s = Genarray.slice_left x idx in
    let src = reshape s sfx in
    jdx.(0) <- i;
    let s = Genarray.slice_left y jdx in
    let dst = reshape s sfx in
    Genarray.blit src dst;
  ) indices;
  y, indices

(* FIXME: experimental *)
let slice_along_dim0 x indices =
  let shp = shape x in
  let n = Array.length indices in
  shp.(0) <- n;
  let y = empty (kind x) shp in

  Array.iteri (fun dst_idx src_idx ->
    let src = Genarray.slice_left x [|src_idx|] in
    let dst = Genarray.slice_left y [|dst_idx|] in
    Genarray.blit src dst;
  ) indices;
  y


(* FIXME: experimental *)
let draw_along_dim0 x n =
  let all_indices = Array.init (shape x).(0) (fun i -> i) in
  let indices = Owl_stats.choose all_indices n in
  (slice_along_dim0 x indices), indices


(* TODO: optimise performance, slow along the low dimension *)
let cumulative_op ?axis _cumop x =
  let y = clone x in
  let y' = flatten y |> array1_of_genarray in
  let d = num_dims x in
  let a = match axis with
    | Some a -> a
    | None   -> d - 1
  in
  assert (0 <= a && a < d);

  let _stride = strides x in
  let _slicez = slice_size x in
  let m = (numel x) / _slicez.(a) in
  let n = _slicez.(a) - _stride.(a) in
  let incx_m = _slicez.(a) in
  let incx_n = 1 in
  let incy_m = _slicez.(a) in
  let incy_n = 1 in
  let ofsx = 0 in
  let ofsy = _stride.(a) in

  _cumop m n y' ofsx incx_m incx_n y' ofsy incy_m incy_n;
  y


let cumsum ?axis x =
  let _cumop = _owl_cumsum (kind x) in
  cumulative_op ?axis _cumop x


let cumprod ?axis x =
  let _cumop = _owl_cumprod (kind x) in
  cumulative_op ?axis _cumop x

let cummin ?axis x =
  let _cumop = _owl_cummin (kind x) in
  cumulative_op ?axis _cumop x

let cummax ?axis x =
  let _cumop = _owl_cummax (kind x) in
  cumulative_op ?axis _cumop x

let modf x =
  let x = clone x in
  let y = empty (kind x) (shape x) in
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  (* the last parameter zero is just a dummy parameter *)
  _owl_modf (kind x) (numel x) x' y' (_zero (kind x));
  x, y


(* TODO: optimise *)
let split ?(axis=0) parts x =
  let x_shp = shape x in
  let x_dim = num_dims x in
  let _d = Array.fold_left ( + ) 0 parts in
  assert (axis < x_dim);
  assert (_d = x_shp.(axis));

  let _pos = ref 0 in
  let slices = Array.map (fun d ->
    let s_def = Array.make x_dim (R_ [||]) in
    s_def.(axis) <- R_ [|!_pos; !_pos + d - 1|];
    _pos := !_pos + d;
    Owl_slicing.get_slice_array_typ s_def x
  ) parts
  in
  slices


(* TODO: optimise ... I am lazy so I currently use the cumsum operation,
  but we should generalise reduce_op.
 *)
let sum_ ?(axis=0) x =
  let i = Array.make (num_dims x) (R_ [||]) in
  i.(axis) <- R_ [|-1|];
  let y = cumsum ~axis x in
  Owl_slicing.get_slice_array_typ i y


(* this function is used for searching top/bottom values in [x] *)
let _search_close_to_extreme x n neg_ext cmp_fun =
  let m = numel x in
  let n = Pervasives.min n m in
  let vls = Array.make n neg_ext in
  let idx = Array.make n max_int in
  let y = flatten x |> array1_of_genarray in
  let l = n - 1 in

  let _insert vls idx x p =
    for q = l downto 0 do
      if cmp_fun x vls.(q) then (
        if q < l then (
          vls.(q+1) <- vls.(q);
          idx.(q+1) <- idx.(q);
        );
        vls.(q) <- x;
        idx.(q) <- p;
      )
    done
  in

  for i = 0 to m - 1 do
    if cmp_fun y.{i} vls.(l) then _insert vls idx y.{i} i
  done;

  let k = num_dims x in
  let s = strides x in
  Array.map (fun i ->
    let j = Array.make k 0 in
    Owl_dense_common._index_1d_nd i j s;
    j
  ) idx


(* FIXME:
  the (<) and (>) functions needs to be changed for complex numbers, since
  Pervasives module may have different way to compare complex numbers.
 *)
let top x n = _search_close_to_extreme x n (_neg_inf (kind x)) ( > )

let bottom x n = _search_close_to_extreme x n (_pos_inf (kind x)) ( < )





(* ends here *)
