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

let copy_to src dst = Genarray.blit src dst

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

let copy x =
  let y = empty (kind x) (shape x) in
  Genarray.blit x y;
  y

let reverse x =
  let y = copy x in
  let n = numel x in
  _owl_copy (kind x) n ~ofsx:0 ~incx:1 ~ofsy:(n-1) ~incy:(-1) x y;
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
  let _kind = kind x in
  let y = empty _kind sy in
  let stride_x = _calc_stride (shape x) in
  let stride_y = _calc_stride (shape y) in
  (* recursively tile the data within y *)
  let rec _tile ofsx ofsy lvl =
    if lvl = !i then
      _owl_repeat _kind !dx reps.(lvl) x ofsx 1 0 y ofsy 1 !dx
    else (
      for j = 0 to sx.(lvl) - 1 do
        let ofsx' = ofsx + j * stride_x.(lvl) in
        let ofsy' = ofsy + j * stride_y.(lvl) in
        _tile ofsx' ofsy' (lvl + 1);
      done;
      let _len = stride_y.(lvl) * sx.(lvl) in
      for k = 1 to reps.(lvl) - 1 do
        _owl_copy _kind _len ~ofsx:ofsy ~incx:1 ~ofsy:(ofsy + (k * _len)) ~incy:1 y y
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
  let _kind = kind x in
  let _shape_y = shape x in
  _shape_y.(axis) <- _shape_y.(axis) * reps;
  let y = empty _kind _shape_y in
  (* if repeat at the highest dimension, use this strategy *)
  if axis = highest_dim then (
    for i = 0 to reps - 1 do
      _owl_copy _kind (numel x) ~ofsx:0 ~incx:1 ~ofsy:i ~incy:reps x y
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
        _owl_copy _kind _slice_sz ~ofsx ~incx:1 ~ofsy ~incy:1 x y
      done;
    done;
  );
  (* reshape y' back to ndarray before return result *)
  reshape y _shape_y


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
  let _kind = kind xs.(0) in
  shape0.(axis) <- !acc_dim;
  let y = empty _kind shape0 in
  (* calculate the number of copies *)
  let slice_sz = (_calc_slice shape0).(axis) in
  let m = numel y / slice_sz in
  let n = Array.length xs in
  (* init the copy location for all inputs *)
  let x_ofs = Array.make n 0 in
  (* copy data in the flattened space *)
  let y_ofs = ref 0 in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      _owl_copy _kind step_sz.(j) ~ofsx:x_ofs.(j) ~incx:1 ~ofsy:!y_ofs ~incy:1 xs.(j) y;
      x_ofs.(j) <- x_ofs.(j) + step_sz.(j);
      y_ofs := !y_ofs + step_sz.(j);
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
      _owl_copy k n0 ~ofsx ~incx:1 ~ofsy ~incy:1 x y;
      y
    )
  | false -> (
      let _x = reshape_1 x n0 in
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


(* align and calculate the output shape for broadcasting over [x0] and [x1] *)
let broadcast_align_shape x0 x1 =
  (* align the rank of inputs *)
  let d0 = num_dims x0 in
  let d1 = num_dims x1 in
  let d3 = max d0 d1 in
  let y0 = expand x0 d3 in
  let y1 = expand x1 d3 in
  (* check whether the shape is valid *)
  let s0 = shape y0 in
  let s1 = shape y1 in
  Array.iter2 (fun a b ->
    assert (not(a <> 1 && b <> 1 && a <> b))
  ) s0 s1;
  (* calculate the output shape *)
  let s2 = Array.map2 max s0 s1 in
  (* calculate the strides *)
  let t0 = _calc_stride s0 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  let t1 = _calc_stride s1 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  let t2 = _calc_stride s2 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  (* return aligned arrays, shapes, strides *)
  y0, y1, s0, s1, s2, t0, t1, t2


(* general broadcast operation for add/sub/mul/div and etc.
  This function compares the dimension element-wise from the highest to the
  lowest with the following broadcast rules (same as numpy):
  1. equal; 2. either is 1.
 *)
let broadcast_op ?out op x0 x1 =
  (* align the input rank, calculate the output shape and stride *)
  let y0, y1, s0, s1, s2, t0, t1, t2 = broadcast_align_shape x0 x1 in
  let y2 = match out with
    | Some y2 -> y2
    | None    -> empty (kind x0) s2
  in
  (* call the specific map function *)
  op y0 t0 y1 t1 y2 t2;
  y2


(* mathematical functions *)

let min_i x =
  let y = flatten x |> array1_of_genarray in
  let i = _owl_min_i (kind x) (numel x) x in
  let s = _calc_stride (shape x) in
  let j = Array.copy s in
  _index_1d_nd i j s;
  y.{i}, j

let max_i x =
  let y = flatten x |> array1_of_genarray in
  let i = _owl_max_i (kind x) (numel x) x in
  let s = _calc_stride (shape x) in
  let j = Array.copy s in
  _index_1d_nd i j s;
  y.{i}, j

let minmax_i x = min_i x, max_i x

let min' x = x |> min_i |> fst

let max' x = x |> max_i |> fst

let minmax' x =
  let minx_i, maxx_i = minmax_i x in
  fst minx_i, fst maxx_i

let add x y =
  match same_shape x y with
  | true  -> (
      let y = copy y in
      _owl_add (kind x) (numel x) x y y;
      y
    )
  | false -> broadcast_op (_owl_broadcast_add (kind x)) x y

let sub x y =
  match same_shape x y with
  | true  -> (
      let y = copy y in
      _owl_sub (kind x) (numel x) x y y;
      y
    )
  | false -> broadcast_op (_owl_broadcast_sub (kind x)) x y

let mul x y =
  match same_shape x y with
  | true  -> (
      let y = copy y in
      _owl_mul (kind x) (numel x) x y y;
      y
    )
  | false -> broadcast_op (_owl_broadcast_mul (kind x)) x y

let div x y =
  match same_shape x y with
  | true  -> (
      let y = copy y in
      _owl_div (kind x) (numel x) x y y;
      y
    )
  | false -> broadcast_op (_owl_broadcast_div (kind x)) x y

let add_scalar x a =
  let x = copy x in
  _owl_add_scalar (kind x) (numel x) x x a;
  x

let sub_scalar x a = add_scalar x (_neg_elt (kind x) a)

let mul_scalar x a =
  let x = copy x in
  _owl_mul_scalar (kind x) (numel x) x x a;
  x

let div_scalar x a =
  let x = copy x in
  _owl_div_scalar (kind x) (numel x) x x a;
  x

let pow x y =
  match same_shape x y with
  | true  -> (
      let y = copy y in
      _owl_pow (kind x) (numel x) x y y;
      y
    )
  | false -> broadcast_op (_owl_broadcast_pow (kind x)) x y

let atan2 x y =
  match same_shape x y with
  | true  -> (
      let y = copy y in
      _owl_atan2 (kind x) (numel x) x y y;
      y
    )
  | false -> broadcast_op (_owl_broadcast_atan2 (kind x)) x y

let hypot x y =
  match same_shape x y with
  | true  -> (
      let y = copy y in
      _owl_hypot (kind x) (numel x) x y y;
      y
    )
  | false -> broadcast_op (_owl_broadcast_hypot (kind x)) x y

let min2 x y =
  match same_shape x y with
  | true  -> (
      let y = copy y in
      _owl_min2 (kind x) (numel x) x y y;
      y
    )
  | false -> broadcast_op (_owl_broadcast_min2 (kind x)) x y

let max2 x y =
  match same_shape x y with
  | true  -> (
      let y = copy y in
      _owl_max2 (kind x) (numel x) x y y;
      y
    )
  | false -> broadcast_op (_owl_broadcast_max2 (kind x)) x y

let fmod x y =
  match same_shape x y with
  | true  -> (
      let y = copy y in
      _owl_fmod (kind x) (numel x) x y y;
      y
    )
  | false -> broadcast_op (_owl_broadcast_fmod (kind x)) x y

let fmod_scalar x a =
  let y = empty (kind x) (shape x) in
  _owl_fmod_scalar (kind x) (numel y) x y a;
  y

let scalar_fmod a x =
  let y = empty (kind x) (shape x) in
  _owl_scalar_fmod (kind x) (numel y) x y a;
  y

let ssqr_diff' x y = _owl_ssqr_diff (kind x) (numel x) x y

let abs x =
  let y = copy x in
  _owl_abs (kind x) (numel y) x y;
  y

let abs2 x =
  let y = copy x in
  _owl_abs2 (kind x) (numel y) x y;
  y

let conj x =
  let y = copy x in
  _owl_conj (kind x) (numel y) x y;
  y

let neg x =
  let y = copy x in
  _owl_neg (kind x) (numel y) x y;
  y

let reci x =
  let y = copy x in
  _owl_reci (kind x) (numel y) x y;
  y

let signum x =
  let y = copy x in
  _owl_signum (kind x) (numel y) x y;
  y

let sqr x =
  let y = copy x in
  _owl_sqr (kind x) (numel y) x y;
  y

let sqrt x =
  let y = copy x in
  _owl_sqrt (kind x) (numel y) x y;
  y

let cbrt x =
  let y = copy x in
  _owl_cbrt (kind x) (numel y) x y;
  y

let exp x =
  let y = copy x in
  _owl_exp (kind x) (numel y) x y;
  y

let exp2 x =
  let y = copy x in
  _owl_exp2 (kind x) (numel y) x y;
  y

let exp10 x =
  let y = copy x in
  _owl_exp10 (kind x) (numel y) x y;
  y

let expm1 x =
  let y = copy x in
  _owl_expm1 (kind x) (numel y) x y;
  y

let log x =
  let y = copy x in
  _owl_log (kind x) (numel y) x y;
  y

let log10 x =
  let y = copy x in
  _owl_log10 (kind x) (numel y) x y;
  y

let log2 x =
  let y = copy x in
  _owl_log2 (kind x) (numel y) x y;
  y

let log1p x =
  let y = copy x in
  _owl_log1p (kind x) (numel y) x y;
  y

let sin x =
  let y = copy x in
  _owl_sin (kind x) (numel y) x y;
  y

let cos x =
  let y = copy x in
  _owl_cos (kind x) (numel y) x y;
  y

let tan x =
  let y = copy x in
  _owl_tan (kind x) (numel y) x y;
  y

let asin x =
  let y = copy x in
  _owl_asin (kind x) (numel y) x y;
  y

let acos x =
  let y = copy x in
  _owl_acos (kind x) (numel y) x y;
  y

let atan x =
  let y = copy x in
  _owl_atan (kind x) (numel y) x y;
  y

let sinh x =
  let y = copy x in
  _owl_sinh (kind x) (numel y) x y;
  y

let cosh x =
  let y = copy x in
  _owl_cosh (kind x) (numel y) x y;
  y

let tanh x =
  let y = copy x in
  _owl_tanh (kind x) (numel y) x y;
  y

let asinh x =
  let y = copy x in
  _owl_asinh (kind x) (numel y) x y;
  y

let acosh x =
  let y = copy x in
  _owl_acosh (kind x) (numel y) x y;
  y

let atanh x =
  let y = copy x in
  _owl_atanh (kind x) (numel y) x y;
  y

let floor x =
  let y = copy x in
  _owl_floor (kind x) (numel y) x y;
  y

let ceil x =
  let y = copy x in
  _owl_ceil (kind x) (numel y) x y;
  y

let round x =
  let y = copy x in
  _owl_round (kind x) (numel y) x y;
  y

let trunc x =
  let y = copy x in
  _owl_trunc (kind x) (numel y) x y;
  y

let fix x =
  let y = copy x in
  _owl_fix (kind x) (numel y) x y;
  y

let angle x =
  let y = copy x in
  _owl_angle (kind x) (numel y) x y;
  y

let proj x =
  let y = copy x in
  _owl_proj (kind x) (numel y) x y;
  y

let erf x =
  let y = copy x in
  _owl_erf (kind x) (numel y) x y;
  y

let erfc x =
  let y = copy x in
  _owl_erfc (kind x) (numel y) x y;
  y

let logistic x =
  let y = copy x in
  _owl_logistic (kind x) (numel y) x y;
  y

let relu x =
  let y = copy x in
  _owl_relu (kind x) (numel y) x y;
  y

let elu ?(alpha=1.0) x =
  let y = empty (kind x) (shape x) in
  _owl_elu (kind x) (numel x) x y alpha;
  y

let leaky_relu ?(alpha=0.2) x =
  let y = empty (kind x) (shape x) in
  _owl_leaky_relu (kind x) (numel x) x y alpha;
  y

let softplus x =
  let y = copy x in
  _owl_softplus (kind x) (numel y) x y;
  y

let softsign x =
  let y = copy x in
  _owl_softsign (kind x) (numel y) x y;
  y

let sigmoid x =
  let y = copy x in
  _owl_sigmoid (kind x) (numel y) x y;
  y

let ssqr' x a = _owl_ssqr (kind x) (numel x) a x

let l1norm' x =
  let _kind = kind x in
  _owl_l1norm _kind (numel x) x |> _float_typ_elt _kind

let l2norm_sqr' x =
  let _kind = kind x in
  _owl_l2norm_sqr _kind (numel x) x |> _float_typ_elt _kind

let l2norm' x =
  let _kind = kind x in
  _owl_l2norm_sqr _kind (numel x) x |> Owl_maths.sqrt |> _float_typ_elt _kind

let log_sum_exp' x = _owl_log_sum_exp (kind x) (numel x) x

let scalar_pow a x =
  let x = copy x in
  _owl_scalar_pow (kind x) (numel x) x x a;
  x

let pow_scalar x a =
  let x = copy x in
  _owl_pow_scalar (kind x) (numel x) x x a;
  x

let scalar_atan2 a x =
  let x = copy x in
  _owl_scalar_atan2 (kind x) (numel x) x x a;
  x

let atan2_scalar x a =
  let x = copy x in
  _owl_atan2_scalar (kind x) (numel x) x x a;
  x

let scalar_add a x =
  let x = copy x in
  _owl_add_scalar (kind x) (numel x) x x a;
  x

let scalar_sub a x =
  let x = copy x in
  _owl_scalar_sub (kind x) (numel x) x x a;
  x

let scalar_mul a x =
  let x = copy x in
  let x' = flatten x |> array1_of_genarray in
  Owl_cblas.scal (numel x) a x' 1;
  x

let scalar_div a x =
  let x = copy x in
  _owl_scalar_div (kind x) (numel x) x x a;
  x

let reci_tol ?tol x =
  let tol = match tol with
    | Some t -> t
    | None   -> _float_typ_elt (kind x) (Owl_utils.eps Float32)
  in
  let y = copy x in
  _owl_reci_tol (kind x) (numel y) x y tol;
  y

(* element-wise comparison functions *)

let elt_equal x y =
  match same_shape x y with
  | true  -> (
      let z = empty (kind x) (shape x) in
      _owl_elt_equal (kind x) (numel z) x y z;
      z
    )
  | false -> broadcast_op (_owl_broadcast_elt_equal (kind x)) x y

let elt_not_equal x y =
  match same_shape x y with
  | true  -> (
      let z = empty (kind x) (shape x) in
      _owl_elt_not_equal (kind x) (numel z) x y z;
      z
    )
  | false -> broadcast_op (_owl_broadcast_elt_not_equal (kind x)) x y

let elt_less x y =
  match same_shape x y with
  | true  -> (
      let z = empty (kind x) (shape x) in
      _owl_elt_less (kind x) (numel z) x y z;
      z
    )
  | false -> broadcast_op (_owl_broadcast_elt_less (kind x)) x y

let elt_greater x y =
  match same_shape x y with
  | true  -> (
      let z = empty (kind x) (shape x) in
      _owl_elt_greater (kind x) (numel z) x y z;
      z
    )
  | false -> broadcast_op (_owl_broadcast_elt_greater (kind x)) x y

let elt_less_equal x y =
  match same_shape x y with
  | true  -> (
      let z = empty (kind x) (shape x) in
      _owl_elt_less_equal (kind x) (numel z) x y z;
      z
    )
  | false -> broadcast_op (_owl_broadcast_elt_less_equal (kind x)) x y

let elt_greater_equal x y =
  match same_shape x y with
  | true  -> (
      let z = empty (kind x) (shape x) in
      _owl_elt_greater_equal (kind x) (numel z) x y z;
      z
    )
  | false -> broadcast_op (_owl_broadcast_elt_greater_equal (kind x)) x y

let elt_equal_scalar x a =
  let y = empty (kind x) (shape x) in
  _owl_elt_equal_scalar (kind x) (numel x) x y a;
  y

let elt_not_equal_scalar x a =
  let y = empty (kind x) (shape x) in
  _owl_elt_not_equal_scalar (kind x) (numel x) x y a;
  y

let elt_less_scalar x a =
  let y = empty (kind x) (shape x) in
  _owl_elt_less_scalar (kind x) (numel x) x y a;
  y

let elt_greater_scalar x a =
  let y = empty (kind x) (shape x) in
  _owl_elt_greater_scalar (kind x) (numel x) x y a;
  y

let elt_less_equal_scalar x a =
  let y = empty (kind x) (shape x) in
  _owl_elt_less_equal_scalar (kind x) (numel x) x y a;
  y

let elt_greater_equal_scalar x a =
  let y = empty (kind x) (shape x) in
  _owl_elt_greater_equal_scalar (kind x) (numel x) x y a;
  y

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
  let x = empty k [|n|] in
  _owl_linspace k n a b x;
  x

let logspace k ?(base=Owl_maths.e) a b n =
  let x = empty k [|n|] in
  _owl_logspace k n base a b x;
  x

let bernoulli k ?(p=0.5) ?seed d =
  assert (p >= 0. && p <= 1.);
  let seed = match seed with
    | Some a -> a
    | None   -> Owl_stats.Rnd.uniform_int ()
  in
  let x = empty k d in
  (_owl_bernoulli k) (numel x) x p seed;
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
  _owl_sequential k (numel x) x a step;
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
  let y = copy x in
  iteri ?axis (fun i z -> set y i (f i z)) y; y

let _map_all_axis f x =
  let x = copy x in
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


let matrix_transpose x =
  let s = shape x in
  let m, n = s.(0), s.(1) in
  let y = empty (kind x) [|n;m|] in
  let x' = Bigarray.array2_of_genarray x in
  let y' = Bigarray.array2_of_genarray y in
  Owl_backend_gsl_linalg.transpose_copy (kind x) y' x';
  y


(*TODO: FIXME: optimise*)
let transpose ?axis x =
  let d = num_dims x in
  if d = 2 then matrix_transpose x
  else (
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
  )


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
  let _kind = kind x in

  if num_dims x < 2 || k = 0 then
    copy x
  else if k = 1 then (
    let sx = shape x in
    let sy = Array.copy sx in
    sy.(0) <- sx.(1);
    sy.(1) <- sx.(0);
    let y = empty _kind sy in

    let m = sx.(0) in
    let n = (numel x) / m in

    if m <= n then (
      let ofsx = ref 0 in
      for i = 1 to m do
        _owl_copy _kind n ~ofsx:!ofsx ~incx:1 ~ofsy:(m - i) ~incy:m x y;
        ofsx := !ofsx + n
      done
    )
    else (
      let ofsy = ref (m - 1) in
      for i = 0 to n - 1 do
        _owl_copy _kind m ~ofsx:i ~incx:n ~ofsy:!ofsy ~incy:(-1) x y;
        ofsy := !ofsy + m
      done
    );
    y
  )
  else if k = 2 then (
    let sx = shape x in
    let y = empty _kind sx in
    let m = sx.(0) in
    let n = (numel x) / m in

    if m <= n then (
      let ofsx = ref 0 in
      let ofsy = ref (m * n - 1) in
      for i = 0 to m - 1 do
        _owl_copy _kind n ~ofsx:!ofsx ~incx:1 ~ofsy:!ofsy ~incy:(-1) x y;
        ofsx := !ofsx + n;
        ofsy := !ofsy - n
      done
    )
    else (
      let ofsy = m * n - 1 in
      for i = 0 to n - 1 do
        _owl_copy _kind m ~ofsx:i ~incx:n ~ofsy:(ofsy - i) ~incy:(-n) x y
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

    let m = sx.(0) in
    let n = (numel x) / m in

    if m <= n then (
      let ofsx = ref 0 in
      let ofsy = (n - 1) * m in
      for i = 0 to m - 1 do
        _owl_copy _kind n ~ofsx:!ofsx ~incx:1 ~ofsy:(ofsy + i) ~incy:(-m) x y;
        ofsx := !ofsx + n
      done
    )
    else (
      let ofsy = ref ((n - 1) * m) in
      for i = 0 to n - 1 do
        _owl_copy _kind m ~ofsx:i ~incx:n ~ofsy:!ofsy ~incy:1 x y;
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

let sort x = _owl_sort (kind x) (numel x) x

let is_zero x = _owl_is_zero (kind x) (numel x) x = 1

let is_positive x = _owl_is_positive (kind x) (numel x) x = 1

let is_negative x = _owl_is_negative (kind x) (numel x) x = 1

let is_nonnegative x = _owl_is_nonnegative (kind x) (numel x) x = 1

let is_nonpositive x = _owl_is_nonpositive (kind x) (numel x) x = 1

let is_normal x = _owl_is_normal (kind x) (numel x) x = 1

let not_nan x = _owl_not_nan (kind x) (numel x) x = 1

let not_inf x = _owl_not_inf (kind x) (numel x) x = 1

let equal x y = ( = ) x y

let not_equal x y = ( <> ) x y

let greater x y = _owl_greater (kind x) (numel x) x y = 1

let less x y = _owl_less (kind x) (numel x) x y = 1

let greater_equal x y = _owl_greater_equal (kind x) (numel x) x y = 1

let less_equal x y = _owl_less_equal (kind x) (numel x) x y = 1

let equal_scalar x a = _owl_equal_scalar (kind x) (numel x) x a = 1

let not_equal_scalar x a = _owl_equal_scalar (kind x) (numel x) x a = 1

let less_scalar x a = _owl_less_scalar (kind x) (numel x) x a = 1

let greater_scalar x a = _owl_greater_scalar (kind x) (numel x) x a = 1

let less_equal_scalar x a = _owl_less_equal_scalar (kind x) (numel x) x a = 1

let greater_equal_scalar x a = _owl_greater_equal_scalar (kind x) (numel x) x a = 1

let approx_equal ?eps x y =
  let eps = match eps with
    | Some eps -> eps
    | None     -> Owl_utils.eps Float32
  in
  _owl_approx_equal (kind x) (numel x) x y eps = 1

let approx_equal_scalar ?eps x a =
  let eps = match eps with
    | Some eps -> eps
    | None     -> Owl_utils.eps Float32
  in
  _owl_approx_equal_scalar (kind x) (numel x) x a eps = 1

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
  _owl_approx_elt_equal k (numel z) x y z;
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
  _owl_approx_elt_equal_scalar k (numel y) x y a;
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

let nnz x = _owl_nnz (kind x) (numel x) x

let density x = (nnz x |> float_of_int) /. (numel x |> float_of_int)

(* input/output functions *)

let print_index i =
  Printf.printf "[ ";
  Array.iter (fun x -> Printf.printf "%i " x) i;
  Printf.printf "] "

let print_element k v =
  let s = (_owl_elt_to_str k) v in
  Printf.printf "%s" s

let print ?max_row ?max_col ?header ?fmt x =
  let n = (shape x).(num_dims x - 1) in
  let max_row = match max_row with
    | Some a -> Some a
    | None   -> Some ((numel x) / n)
  in
  let max_col = match max_col with
    | Some a -> Some a
    | None   -> Some n
  in
  Owl_pretty.print ?max_row ?max_col ?header ?elt_to_str_fun:fmt x

let pp_dsnda formatter x = Owl_pretty.pp_dsnda formatter x

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
  let x = empty complex_kind (shape re) in
  _owl_to_complex real_kind complex_kind (numel re) re im x;
  x

let polar
  : type a b c d. (a, b) kind -> (c, d) kind -> (a, b) t -> (a, b) t -> (c, d) t
  = fun real_kind complex_kind rho theta ->
  assert (shape rho = shape theta);
  let x = empty complex_kind (shape rho) in
  _owl_polar real_kind complex_kind (numel rho) rho theta x;
  x


(* math operations. code might be verbose for performance concern. *)

let re_c2s x =
  let y = empty Float32 (shape x) in
  _owl_re_c2s (numel x) x y;
  y

let re_z2d x =
  let y = empty Float64 (shape x) in
  _owl_re_z2d (numel x) x y;
  y

let im_c2s x =
  let y = empty Float32 (shape x) in
  _owl_im_c2s (numel x) x y;
  y

let im_z2d x =
  let y = empty Float64 (shape x) in
  _owl_im_z2d (numel x) x y;
  y

let abs_c2s x = abs x |> re_c2s

let abs_z2d x = abs x |> re_z2d

let abs2_c2s x = abs2 x |> re_c2s

let abs2_z2d x = abs2 x |> re_z2d


(* cast functions *)

let cast
  : type a b c d. (a, b) kind -> (c, d) t -> (a, b) t
  = fun dst_typ x ->
  let src_typ = kind x in
  let y = empty dst_typ (shape x) in
  match src_typ, dst_typ with
  | Float32,   Float32   -> copy x
  | Float64,   Float64   -> copy x
  | Complex32, Complex32 -> copy x
  | Complex64, Complex64 -> copy x
  | Float32,   Float64   -> _owl_cast_s2d (numel x) x y; y
  | Float64,   Float32   -> _owl_cast_d2s (numel x) x y; y
  | Float32,   Complex32 -> _owl_cast_s2c (numel x) x y; y
  | Float64,   Complex64 -> _owl_cast_d2z (numel x) x y; y
  | Float32,   Complex64 -> _owl_cast_s2z (numel x) x y; y
  | Float64,   Complex32 -> _owl_cast_d2c (numel x) x y; y
  | Complex32, Complex64 -> _owl_cast_c2z (numel x) x y; y
  | Complex64, Complex32 -> _owl_cast_z2c (numel x) x y; y
  | _                    -> failwith "Owl_dense_ndarray_generic:cast"


let cast_s2d x = cast Float64 x

let cast_d2s x = cast Float32 x

let cast_c2z x = cast Complex64 x

let cast_z2c x = cast Complex32 x

let cast_s2c x = cast Complex32 x

let cast_d2z x = cast Complex64 x

let cast_s2z x = cast Complex64 x

let cast_d2c x = cast Complex32 x


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
  let y = copy x in
  _owl_clip_by_value k (numel x) amin amax y;
  y

let clip_by_l2norm t x =
  let a = l2norm' x in
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
let rec _copy_to_padding p1 ls l0 l1 i0 i1 d0 d1 s0 s1 x0 x1 =
  if d0 < d1 then (
    for i = 0 to s0.(d0) - 1 do
      i0.(d0) <- i;
      i1.(d0) <- i + p1.(d0).(0);
      _copy_to_padding p1 ls l0 l1 i0 i1 (d0 + 1) d1 s0 s1 x0 x1;
      i0.(d0) <- 0;
      i1.(d0) <- p1.(d0).(0);
    done
  )
  else (
    (* print_index i0; Printf.printf " === "; print_index i1; print_endline ""; *)
    let j0 = _index_nd_1d i0 l0 in
    let j1 = _index_nd_1d i1 l1 in
    _owl_copy (kind x0) ls.(d0) ~ofsx:j0 ~incx:1 ~ofsy:j1 ~incy:1 x0 x1
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
  _copy_to_padding p1 ls l0 l1 i0 i1 d0 d1 s0 s1 x y;
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

  _cumop m n x ofsx incx_m incx_n x ofsy incy_m incy_n


let cumsum ?axis x =
  let x = copy x in
  let _cumop = _owl_cumsum (kind x) in
  cumulative_op ?axis _cumop x;
  x


let cumprod ?axis x =
  let x = copy x in
  let _cumop = _owl_cumprod (kind x) in
  cumulative_op ?axis _cumop x;
  x


let cummin ?axis x =
  let x = copy x in
  let _cumop = _owl_cummin (kind x) in
  cumulative_op ?axis _cumop x;
  x


let cummax ?axis x =
  let x = copy x in
  let _cumop = _owl_cummax (kind x) in
  cumulative_op ?axis _cumop x;
  x


let modf x =
  let x = copy x in
  let y = empty (kind x) (shape x) in
  (* the last parameter zero is just a dummy parameter *)
  _owl_modf (kind x) (numel x) x y (_zero (kind x));
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


let sum' x = _owl_sum (kind x) (numel x) x


let prod' x = _owl_prod (kind x) (numel x) x


(* prepare the parameters for reduce operation, [a] is axis *)
let reduce_params a x =
  let d = num_dims x in
  assert (0 <= a && a < d);

  let _shape = shape x in
  let _stride = strides x in
  let _slicez = slice_size x in
  let m = (numel x) / _slicez.(a) in
  let n = _slicez.(a) in
  let o = _stride.(a) in
  _shape.(a) <- 1;
  m, n, o, _shape


(* TODO: performance can be optimised by removing embedded loops *)
(* generic fold funtion *)
let fold__ ?axis f a x =
  let _kind = kind x in
  let x' = flatten x |> array1_of_genarray in
  match axis with
  | Some axis -> (
      let m, n, o, s = reduce_params axis x in
      let start_x = ref 0 in
      let start_y = ref 0 in
      let incy = ref 0 in

      let y = create _kind s a in
      let y' = flatten y |> array1_of_genarray in

      for i = 0 to m - 1 do
        for j = 0 to n - 1 do
          y'.{!start_y + !incy} <- f y'.{!start_y + !incy} x'.{!start_x + j};
          if !incy + 1 = o then incy := 0
          else incy := !incy + 1;
        done;
        start_x := !start_x + n;
        start_y := !start_y + o;
      done;
      y
    )
  | None   -> (
      let b = ref x'.{0} in
      for i = 1 to (numel x) - 1 do
        b := f !b x'.{i}
      done;
      create _kind [|1|] !b
    )


(* generic cumulate function *)
let cumulate ?axis f x =
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
  let incx = _slicez.(a) in
  let incy = _slicez.(a) in
  let start_x = ref 0 in
  let start_y = ref _stride.(a) in

  let y = copy x in
  let y' = flatten y |> array1_of_genarray in

  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      y'.{!start_y + j} <- f y'.{!start_x + j} y'.{!start_y + j}
    done;
    start_x := !start_x + incx;
    start_y := !start_y + incy;
  done;
  y


let sum ?axis x =
  let _kind = kind x in
  match axis with
  | Some a -> (
      let m, n, o, s = reduce_params a x in
      let y = zeros _kind s in
      _owl_sum_along _kind m n o x y;
      y
    )
  | None   -> _owl_sum _kind (numel x) x |> create _kind [|1|]


let prod ?axis x =
  let _kind = kind x in
  match axis with
  | Some a -> (
      let m, n, o, s = reduce_params a x in
      let y = ones _kind s in
      _owl_prod_along _kind m n o x y;
      y
    )
  | None   -> _owl_prod _kind (numel x) x |> create _kind [|1|]


let min ?axis x =
  let _kind = kind x in
  match axis with
  | Some a -> (
      let m, n, o, s = reduce_params a x in
      let y = create _kind s (_pos_inf _kind) in
      _owl_min_along _kind m n o x y;
      y
    )
  | None   -> min' x |> create _kind [|1|]


let max ?axis x =
  let _kind = kind x in
  match axis with
  | Some a -> (
      let m, n, o, s = reduce_params a x in
      let y = create _kind s (_neg_inf _kind) in
      _owl_max_along _kind m n o x y;
      y
    )
  | None   -> max' x |> create _kind [|1|]


let minmax ?axis x = min ?axis x, max ?axis x


let mean' x =
  let _kind = kind x in
  let _numel = numel x in
  let y = _owl_sum _kind _numel x in
  _mean_elt _kind y _numel


let mean ?axis x =
  let _kind = kind x in
  match axis with
  | Some a -> (
      let y = sum ~axis:a x in
      let n = (shape x).(a) |> float_of_int |> _float_typ_elt _kind in
      _owl_div_scalar _kind (numel y) y y n;
      y
    )
  | None   -> mean' x |> create _kind [|1|]


let var' x =
  let _kind = kind x in
  let mu = mean' x in
  let y = sub_scalar x mu in
  _owl_sqr _kind (numel y) y y;
  let y = sum' y in
  let n = (numel x) - 1 |> Pervasives.max 1 |> float_of_int |> _float_typ_elt _kind in
  _div_elt _kind y n


let var ?axis x =
  let _kind = kind x in
  match axis with
  | Some a -> (
      let mu = mean ~axis:a x in
      let y = sub x mu in
      _owl_sqr _kind (numel y) y y;
      let y = sum ~axis:a y in
      let n = (shape x).(a) - 1 |> Pervasives.max 1 |> float_of_int |> _float_typ_elt _kind in
      _owl_div_scalar _kind (numel y) y y n;
      y
    )
  | None   -> var' x |> create _kind [|1|]


let std' x =
  let _kind = kind x in
  let mu = mean' x in
  let y = sub_scalar x mu in
  _owl_sqr _kind (numel y) y y;
  let y = sum' y in
  let n = (numel x) - 1 |> Pervasives.max 1 |> float_of_int |> _float_typ_elt _kind in
  _div_elt _kind y n |> _sqrt_elt _kind


let std ?axis x =
  let _kind = kind x in
  match axis with
  | Some a -> (
      let mu = mean ~axis:a x in
      let y = sub x mu in
      _owl_sqr _kind (numel y) y y;
      let y = sum ~axis:a y in
      let n = (shape x).(a) - 1 |> Pervasives.max 1 |> float_of_int |> _float_typ_elt _kind in
      _owl_div_scalar _kind (numel y) y y n;
      _owl_sqrt _kind (numel y) y y;
      y
    )
  | None   -> std' x |> create _kind [|1|]


let l1norm ?axis x =
  let _kind = kind x in
  match axis with
  | Some a -> (
      let m, n, o, s = reduce_params a x in
      let y = zeros _kind s in
      _owl_l1norm_along _kind m n o x y;
      y
    )
  | None   -> l1norm' x |> create _kind [|1|]


let l2norm_sqr ?axis x =
  let _kind = kind x in
  match axis with
  | Some a -> (
      let m, n, o, s = reduce_params a x in
      let y = zeros _kind s in
      _owl_l2norm_sqr_along _kind m n o x y;
      y
    )
  | None   -> l2norm_sqr' x |> create _kind [|1|]


let l2norm ?axis x =
  let _kind = kind x in
  match axis with
  | Some a -> (
      let m, n, o, s = reduce_params a x in
      let y = zeros _kind s in
      _owl_l2norm_sqr_along _kind m n o x y;
      _owl_sqrt _kind (numel y) y y;
      y
    )
  | None   -> l2norm' x |> create _kind [|1|]


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



(* fucntions which modify the data in-place, not so pure *)

let add_ x y =
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_add (kind x) (numel x) x y x
  else (
    (* broadcast [y] to [x], so make sure [x] is big enough *)
    assert (Owl_utils.array_greater_eqaul sx sy);
    broadcast_op (_owl_broadcast_add (kind x)) x y ~out:x |> ignore
  )

let sub_ x y =
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_sub (kind x) (numel x) x y x
  else (
    (* broadcast [y] to [x], so make sure [x] is big enough *)
    assert (Owl_utils.array_greater_eqaul sx sy);
    broadcast_op (_owl_broadcast_sub (kind x)) x y ~out:x |> ignore
  )

let mul_ x y =
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_mul (kind x) (numel x) x y x
  else (
    (* broadcast [y] to [x], so make sure [x] is big enough *)
    assert (Owl_utils.array_greater_eqaul sx sy);
    broadcast_op (_owl_broadcast_mul (kind x)) x y ~out:x |> ignore
  )

let div_ x y =
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_div (kind x) (numel x) x y x
  else (
    (* broadcast [y] to [x], so make sure [x] is big enough *)
    assert (Owl_utils.array_greater_eqaul sx sy);
    broadcast_op (_owl_broadcast_div (kind x)) x y ~out:x |> ignore
  )

let pow_ x y =
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_pow (kind x) (numel x) x y x
  else (
    (* broadcast [y] to [x], so make sure [x] is big enough *)
    assert (Owl_utils.array_greater_eqaul sx sy);
    broadcast_op (_owl_broadcast_pow (kind x)) x y ~out:x |> ignore
  )

let atan2_ x y =
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_atan2 (kind x) (numel x) x y x
  else (
    (* broadcast [y] to [x], so make sure [x] is big enough *)
    assert (Owl_utils.array_greater_eqaul sx sy);
    broadcast_op (_owl_broadcast_atan2 (kind x)) x y ~out:x |> ignore
  )

let hypot_ x y =
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_hypot (kind x) (numel x) x y x
  else (
    (* broadcast [y] to [x], so make sure [x] is big enough *)
    assert (Owl_utils.array_greater_eqaul sx sy);
    broadcast_op (_owl_broadcast_hypot (kind x)) x y ~out:x |> ignore
  )

let fmod_ x y =
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_fmod (kind x) (numel x) x y x
  else (
    (* broadcast [y] to [x], so make sure [x] is big enough *)
    assert (Owl_utils.array_greater_eqaul sx sy);
    broadcast_op (_owl_broadcast_fmod (kind x)) x y ~out:x |> ignore
  )

let min2_ x y =
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_min2 (kind x) (numel x) x y x
  else (
    (* broadcast [y] to [x], so make sure [x] is big enough *)
    assert (Owl_utils.array_greater_eqaul sx sy);
    broadcast_op (_owl_broadcast_min2 (kind x)) x y ~out:x |> ignore
  )

let max2_ x y =
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_max2 (kind x) (numel x) x y x
  else (
    (* broadcast [y] to [x], so make sure [x] is big enough *)
    assert (Owl_utils.array_greater_eqaul sx sy);
    broadcast_op (_owl_broadcast_max2 (kind x)) x y ~out:x |> ignore
  )

let elt_equal_ x y =
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_elt_equal (kind x) (numel x) x y x
  else (
    (* broadcast [y] to [x], so make sure [x] is big enough *)
    assert (Owl_utils.array_greater_eqaul sx sy);
    broadcast_op (_owl_broadcast_elt_equal (kind x)) x y ~out:x |> ignore
  )

let elt_not_equal_ x y =
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_elt_not_equal (kind x) (numel x) x y x
  else (
    (* broadcast [y] to [x], so make sure [x] is big enough *)
    assert (Owl_utils.array_greater_eqaul sx sy);
    broadcast_op (_owl_broadcast_elt_not_equal (kind x)) x y ~out:x |> ignore
  )

let elt_less_ x y =
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_elt_less (kind x) (numel x) x y x
  else (
    (* broadcast [y] to [x], so make sure [x] is big enough *)
    assert (Owl_utils.array_greater_eqaul sx sy);
    broadcast_op (_owl_broadcast_elt_less (kind x)) x y ~out:x |> ignore
  )

let elt_greater_ x y =
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_elt_greater (kind x) (numel x) x y x
  else (
    (* broadcast [y] to [x], so make sure [x] is big enough *)
    assert (Owl_utils.array_greater_eqaul sx sy);
    broadcast_op (_owl_broadcast_elt_greater (kind x)) x y ~out:x |> ignore
  )

let elt_less_equal_ x y =
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_elt_less_equal (kind x) (numel x) x y x
  else (
    (* broadcast [y] to [x], so make sure [x] is big enough *)
    assert (Owl_utils.array_greater_eqaul sx sy);
    broadcast_op (_owl_broadcast_elt_less_equal (kind x)) x y ~out:x |> ignore
  )

let elt_greater_equal_ x y =
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_elt_equal (kind x) (numel x) x y x
  else (
    (* broadcast [y] to [x], so make sure [x] is big enough *)
    assert (Owl_utils.array_greater_eqaul sx sy);
    broadcast_op (_owl_broadcast_elt_greater_equal (kind x)) x y ~out:x |> ignore
  )

let add_scalar_ x a = _owl_add_scalar (kind x) (numel x) x x a

let sub_scalar_ x a = add_scalar_ x (_neg_elt (kind x) a)

let mul_scalar_ x a = _owl_mul_scalar (kind x) (numel x) x x a

let div_scalar_ x a = _owl_div_scalar (kind x) (numel x) x x a

let pow_scalar_ x a = _owl_pow_scalar (kind x) (numel x) x x a

let atan2_scalar_ x a = _owl_atan2_scalar (kind x) (numel x) x x a

let fmod_scalar_ x a = _owl_fmod_scalar (kind x) (numel x) x x a

let scalar_add_ a x = _owl_add_scalar (kind x) (numel x) x x a

let scalar_sub_ a x = _owl_scalar_sub (kind x) (numel x) x x a

let scalar_mul_ a x = _owl_mul_scalar (kind x) (numel x) x x a

let scalar_div_ a x = _owl_scalar_div (kind x) (numel x) x x a

let scalar_pow_ a x = _owl_scalar_pow (kind x) (numel x) x x a

let scalar_atan2_ a x = _owl_scalar_atan2 (kind x) (numel x) x x a

let scalar_fmod_ a x = _owl_scalar_fmod (kind x) (numel x) x x a

let conj_ x = _owl_conj (kind x) (numel x) x x

let abs_ x = _owl_abs (kind x) (numel x) x x

let neg_ x = _owl_neg (kind x) (numel x) x x

let reci_ x = _owl_reci (kind x) (numel x) x x

let signum_ x = _owl_signum (kind x) (numel x) x x

let sqr_ x = _owl_sqr (kind x) (numel x) x x

let sqrt_ x = _owl_sqrt (kind x) (numel x) x x

let cbrt_ x = _owl_cbrt (kind x) (numel x) x x

let exp_ x = _owl_exp (kind x) (numel x) x x

let exp2_ x = _owl_exp2 (kind x) (numel x) x x

let exp10_ x = _owl_exp10 (kind x) (numel x) x x

let expm1_ x = _owl_expm1 (kind x) (numel x) x x

let log_ x = _owl_log (kind x) (numel x) x x

let log2_ x = _owl_log2 (kind x) (numel x) x x

let log10_ x = _owl_log10 (kind x) (numel x) x x

let log1p_ x = _owl_log1p (kind x) (numel x) x x

let sin_ x = _owl_sin (kind x) (numel x) x x

let cos_ x = _owl_cos (kind x) (numel x) x x

let tan_ x = _owl_tan (kind x) (numel x) x x

let asin_ x = _owl_asin (kind x) (numel x) x x

let acos_ x = _owl_acos (kind x) (numel x) x x

let atan_ x = _owl_atan (kind x) (numel x) x x

let sinh_ x = _owl_sinh (kind x) (numel x) x x

let cosh_ x = _owl_cosh (kind x) (numel x) x x

let tanh_ x = _owl_tanh (kind x) (numel x) x x

let asinh_ x = _owl_asinh (kind x) (numel x) x x

let acosh_ x = _owl_acosh (kind x) (numel x) x x

let atanh_ x = _owl_atanh (kind x) (numel x) x x

let floor_ x = _owl_floor (kind x) (numel x) x x

let ceil_ x = _owl_ceil (kind x) (numel x) x x

let round_ x = _owl_round (kind x) (numel x) x x

let trunc_ x = _owl_trunc (kind x) (numel x) x x

let fix_ x = _owl_fix (kind x) (numel x) x x

let erf_ x = _owl_erf (kind x) (numel x) x x

let erfc_ x = _owl_erfc (kind x) (numel x) x x

let relu_ x = _owl_relu (kind x) (numel x) x x

let softplus_ x = _owl_softplus (kind x) (numel x) x x

let softsign_ x = _owl_softsign (kind x) (numel x) x x

let sigmoid_ x = _owl_sigmoid (kind x) (numel x) x x

let softmax x =
  let x = copy x in
  sub_scalar_ x (max' x);
  exp_ x;
  let a = sum' x in
  div_scalar_ x a;
  x

let softmax_ x =
  sub_scalar_ x (max' x);
  exp_ x;
  let a = sum' x in
  div_scalar_ x a

let cumsum_ ?axis x =
  let _cumop = _owl_cumsum (kind x) in
  cumulative_op ?axis _cumop x

let cumprod_ ?axis x =
  let _cumop = _owl_cumprod (kind x) in
  cumulative_op ?axis _cumop x

let cummin_ ?axis x =
  let _cumop = _owl_cummin (kind x) in
  cumulative_op ?axis _cumop x

let cummax_ ?axis x =
  let _cumop = _owl_cummax (kind x) in
  cumulative_op ?axis _cumop x

let cross_entropy' x y =
  let y = copy y in
  log_ y;
  mul_ y x;
  _neg_elt (kind y) (sum' y)



(** Matrix functions *)

type area = { a : int; b : int; c : int; d : int }


let area a b c d = { a = a; b = b; c = c; d = d }


let area_of x =
  let s = shape x in
  let m, n = s.(0), s.(1) in
  { a = 0; b = 0; c = m - 1; d = n - 1 }


let area_of_row x i =
  let n = (shape x).(1) in
  area i 0 i (n - 1)


let area_of_col x i =
  let m = (shape x).(0) in
  area 0 i (m - 1) i


let equal_area r1 r2 =
  ((r1.c-r1.a = r2.c-r2.a) && (r1.d-r1.b = r2.d-r2.b))


let same_area r1 r2 = r1 = r2


let copy_area_to x1 r1 x2 r2 =
  assert (equal_area r1 r2);
  for i = 0 to r1.c - r1.a do
    for j = 0 to r1.d - r1.b do
      set x2 [|r2.a + i; r2.b + j|]
      (get x1 [|r1.a + i; r1.b + j|])
    done
  done


let copy_area x r =
  let y = empty (kind x) [|r.c - r.a + 1; r.d - r.b + 1|] in
  copy_area_to x r y (area_of y)


let _matrix_shape x =
  let s = shape x in
  assert (Array.length s = 2);
  s.(0), s.(1)


let row_num x =
  assert (num_dims x = 2);
  (shape x).(0)


let col_num x =
  assert (num_dims x = 2);
  (shape x).(1)


let row x i =
  let m, n = _matrix_shape x in
  assert (i < m);
  let y = Bigarray.Genarray.slice_left x [|i|] in
  reshape y [|1;n|]


let col x j =
  let m, n = _matrix_shape x in
  assert (j < n);
  let _kind = kind x in
  let y = empty _kind [|m;1|] in
  _owl_copy _kind m ~ofsx:j ~incx:n ~ofsy:0 ~incy:1 x y;
  y


let copy_row_to v x i =
  let u = row x i in
  copy_to v u


let copy_col_to v x i =
  let r1 = area_of v in
  let r2 = area_of_col x i in
  copy_area_to v r1 x r2


let dot x1 x2 =
  let m, k = _matrix_shape x1 in
  let l, n = _matrix_shape x2 in
  assert (k = l);

  let _kind = kind x1 in
  let alpha = _one _kind in
  let beta = _zero _kind in
  let x3 = empty _kind [|m; n|] in
  let a = flatten x1 |> Bigarray.array1_of_genarray in
  let b = flatten x2 |> Bigarray.array1_of_genarray in
  let c = flatten x3 |> Bigarray.array1_of_genarray in

  let layout = Owl_cblas.CblasRowMajor in
  let transa = Owl_cblas.CblasNoTrans in
  let transb = Owl_cblas.CblasNoTrans in
  Owl_cblas.gemm layout transa transb m n k alpha a k b n beta c n;
  x3


let inv x =
  let m, n = _matrix_shape x in
  assert (m = n && num_dims x = 2);
  let x' = Bigarray.array2_of_genarray x in
  Owl_dense_common._eigen_inv (kind x) x'
  |> Bigarray.genarray_of_array2


let diag ?(k=0) x =
  let m, n = _matrix_shape x in
  let l = match k >= 0 with
    | true  -> Pervasives.(max 0 (min m (n - k)))
    | false -> Pervasives.(max 0 (min n (m + k)))
  in
  let i, j = match k >= 0 with
    | true  -> 0, k
    | false -> Pervasives.abs k, 0
  in
  let y = empty (kind x) [|1;l|] in
  for k = 0 to l - 1 do
    set y [|0; k|] (get x [|i + k; j + k|])
  done;
  y


let trace x = sum' (diag x)


let to_rows x = Array.init (row_num x) (fun i -> row x i)


let to_cols x = Array.init (col_num x) (fun i -> col x i)


let of_rows l =
  let x = empty (kind l.(0)) [|(Array.length l); (col_num l.(0))|] in
  Array.iteri (fun i v -> copy_row_to v x i) l;
  x


let of_cols l =
  let x = empty (kind l.(0)) [|(row_num l.(0)); (Array.length l)|] in
  Array.iteri (fun i v -> copy_col_to v x i) l;
  x


let of_arrays k x = Owl_backend_gsl_linalg.of_arrays k x |> Bigarray.genarray_of_array2


let to_arrays x = Owl_backend_gsl_linalg.to_arrays (kind x) (Bigarray.array2_of_genarray x)


let rows x l =
  let m, n = Array.length (l), col_num x in
  let y = empty (kind x) [|m;n|] in
  Array.iteri (fun i j ->
    copy_row_to (row x j) y i
  ) l;
  y


let cols x l =
  let m, n = _matrix_shape x in
  let nl = Array.length (l) in
  let _kind = kind x in
  let y = empty _kind [|m;nl|] in
  Array.iteri (fun i j ->
    assert (i < nl && j < n);
    _owl_copy _kind m ~ofsx:j ~incx:n ~ofsy:i ~incy:nl x y;
  ) l;
  y


let draw_rows ?(replacement=true) x c =
  let a = Array.init (row_num x) (fun i -> i) in
  let l = match replacement with
    | true  -> Owl_stats.sample a c
    | false -> Owl_stats.choose a c
  in rows x l, l


let draw_cols ?(replacement=true) x c =
  let a = Array.init (col_num x) (fun i -> i) in
  let l = match replacement with
    | true  -> Owl_stats.sample a c
    | false -> Owl_stats.choose a c
  in cols x l, l


let draw_rows2 ?(replacement=true) x y c =
  let x_rows, l = draw_rows ~replacement x c in
  x_rows, rows y l, l


let draw_cols2 ?(replacement=true) x y c =
  let x_cols, l = draw_rows ~replacement x c in
  x_cols, cols y l, l


(* ends here *)
