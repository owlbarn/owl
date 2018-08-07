(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

open Bigarray

open Owl_ndarray


type ('a, 'b) t = ('a, 'b, c_layout) Genarray.t

type ('a, 'b) kind = ('a, 'b) Bigarray.kind


(* Basic functions from Genarray module *)

let empty kind dimension = Genarray.create kind c_layout dimension


let get x i = Genarray.get x i


let set x i a = Genarray.set x i a


let num_dims x = Genarray.num_dims x


let shape x = Genarray.dims x


let nth_dim x i = Genarray.nth_dim x i


let numel x = Owl_utils.numel x


let kind x = Genarray.kind x


let layout x = Genarray.layout x


let size_in_bytes x = Genarray.size_in_bytes x


let sub_left = Genarray.sub_left


let sub_right = Genarray.sub_right


let slice_left = Genarray.slice_left


let slice_right = Genarray.slice_right


let copy x =
  let y = empty (kind x) (shape x) in
  _owl_copy (kind x) (numel x) ~ofsx:0 ~incx:1 ~ofsy:0 ~incy:1 x y;
  y


let copy_ ~out src =
  if Owl_ndarray._owl_ndarray_same_data out src = false then (
    let k = kind src in
    let n = numel src in
    let m = numel out in
    assert (m = n);
    _owl_copy k n ~ofsx:0 ~incx:1 ~ofsy:0 ~incy:1 src out
  )


let get_fancy axis x = Owl_slicing.get_fancy_list_typ axis x


let get_fancy_ ~out axis x = Owl_slicing.get_fancy_list_typ_ axis x out


let set_fancy axis x y = Owl_slicing.set_fancy_list_typ axis x y


let set_fancy_ ~out axis x y =
  if Owl_ndarray._owl_ndarray_same_data out x = false then
    copy_ ~out x;
  Owl_slicing.set_fancy_list_typ axis out y


let get_slice axis x = Owl_slicing.get_slice_list_typ axis x


let get_slice_ ~out axis x = Owl_slicing.get_slice_list_typ_ axis x out


let set_slice axis x y = Owl_slicing.set_slice_list_typ axis x y


let set_slice_ ~out axis x y =
  if Owl_ndarray._owl_ndarray_same_data out x = false then
    copy_ ~out x;
  Owl_slicing.set_slice_list_typ axis out y


let fill x a = Genarray.fill x a


let reshape x d =
  let minus_one = Owl_utils.Array.count d (-1) in
  assert (minus_one <= 1);
  if minus_one = 0 then reshape x d
  else (
    let n = numel x in
    let m = Array.fold_right ( * ) d (-1) in
    let e = Array.map (fun a -> if a = -1 then n / m else a) d in
    reshape x e
  )


let reshape_ ~out x =
  if Owl_ndarray._owl_ndarray_same_data out x = false then
    copy_ ~out x


let reset x = Genarray.fill x (Owl_const.zero (kind x))


let mmap fd ?pos kind shared dims = Unix.map_file fd ?pos kind c_layout shared dims


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
  let s = Owl_utils.calc_stride d in
  let j = Array.copy s in
  for i = 0 to n - 1 do
    Owl_utils.index_1d_nd i j s;
    Array1.unsafe_set y i (f j)
  done;
  x


let same_shape x y = (shape x) = (shape y)


let same_data x y = Owl_ndarray._owl_ndarray_same_data x y


let reverse x =
  let y = copy x in
  let n = numel x in
  _owl_copy (kind x) n ~ofsx:0 ~incx:1 ~ofsy:(n-1) ~incy:(-1) x y;
  y


let reverse_ ~out x =
  if Owl_ndarray._owl_ndarray_same_data out x = false then (
    copy_ ~out x
  );
  reverse out |> ignore


let repeat x reps =
  (* check the validity of reps *)
  if Array.exists ((>) 1) reps then
    failwith "repeat: repetition must be >= 1";
  let _kind = kind x in
  let x_dims = num_dims x in
  assert (Array.length reps = x_dims);

  (* case 1: all repeats equal to 1 *)
  if (Array.for_all ((=) 1) reps) = true then
    copy x
  else (
    let x_shape = shape x in
    let y_shape = Array.map2 ( * ) x_shape reps in
    let y = empty _kind y_shape in

    (* case 2 : vector input *)
    if (x_dims = 1) then (
      Owl_ndarray_repeat._ndarray_repeat_axis _kind x y 0 reps.(0)
    )
    (* case 3: only one axis to be repeated *)
    else if (Owl_utils_array.count reps 1 = x_dims - 1) then (
      let r = ref (-1) in
      let a = ref (-1) in
      while !r = -1 && !a < x_dims do
        a := !a + 1;
        if reps.(!a) != 1 then r := reps.(!a)
      done;
      Owl_ndarray_repeat._ndarray_repeat_axis _kind x y !a !r
    )
    (* general case *)
    else (
      let reps' = reps |> Array.map Int64.of_int
        |> Array1.of_array int64 c_layout |> genarray_of_array1 in
      let x_shape' = x_shape |> Array.map Int64.of_int
        |> Array1.of_array int64 c_layout |> genarray_of_array1 in
      Owl_ndarray_repeat._ndarray_repeat _kind x y reps' x_shape';
    );
    reshape y y_shape
  )


let repeat_ ~out x reps =
  (* check the validity of reps *)
  if Array.exists ((>) 1) reps then
    failwith "repeat: repetition must be >= 1";
  let _kind = kind x in
  let x_dims = num_dims x in
  assert (Array.length reps = x_dims);

  (* case 1: all repeats equal to 1 *)
  if (Array.for_all ((=) 1) reps) = true then
    copy_ x out
  else (
    (* case 2 : vector input *)
    if (x_dims = 1) then (
      Owl_ndarray_repeat._ndarray_repeat_axis _kind x out 0 reps.(0)
    )
    (* case 3: only one axis to be repeated *)
    else if (Owl_utils_array.count reps 1 = x_dims - 1) then (
      let r = ref (-1) in
      let a = ref (-1) in
      while !r = -1 && !a < x_dims do
        a := !a + 1;
        if reps.(!a) != 1 then r := reps.(!a)
      done;
      Owl_ndarray_repeat._ndarray_repeat_axis _kind x out !a !r
    )
    (* general case *)
    else (
      let reps' = reps |> Array.map Int64.of_int
        |> Array1.of_array int64 c_layout |> genarray_of_array1 in
      let x_shape' = shape x |> Array.map Int64.of_int
        |> Array1.of_array int64 c_layout |> genarray_of_array1 in
      Owl_ndarray_repeat._ndarray_repeat _kind x out reps' x_shape'
    )
  )

let tile x reps =
  (* check the validity of reps *)
  if Array.exists ((>) 1) reps then
    failwith "tile: repitition must be >= 1";

  (* case 1: all repeats equal to 1 *)
  if (Array.for_all ((=) 1) reps) = true then
    copy x
  else (
    (* align and promote the shape *)
    let a = num_dims x in
    let b = Array.length reps in
    let x, reps = match a < b with
      | true ->
          let d = Owl_utils.Array.pad `Left 1 (b - a) (shape x) in
          (reshape x d), reps
      | false ->
          let r = Owl_utils.Array.pad `Left 1 (a - b) reps in
          x, r
    in
    let x_shape = shape x in
    let y_shape = Array.map2 ( * ) x_shape reps in
    let _kind = kind x in
    let y = empty _kind y_shape in
    let x_dims = num_dims x in
    (* case 2 : vector input *)
    if (x_dims = 1) then (
      Owl_ndarray_repeat._ndarray_tile_axis _kind x y 0 reps.(0)
    )
    (* case 3: only one axis to be repeated *)
    else if (Owl_utils_array.count reps 1 = x_dims - 1) then (
      let r = ref (-1) in
      let ax = ref (-1) in
      while !r = -1 && !ax < x_dims do
        ax := !ax + 1;
        if reps.(!ax) != 1 then r := reps.(!ax)
      done;
      Owl_ndarray_repeat._ndarray_tile_axis _kind x y !ax !r
    )
    (* general case *)
    else (
      let reps' = reps |> Array.map Int64.of_int
        |> Array1.of_array int64 c_layout |> genarray_of_array1 in
      let x_shape' = x_shape |> Array.map Int64.of_int
        |> Array1.of_array int64 c_layout |> genarray_of_array1 in
      Owl_ndarray_repeat._ndarray_tile _kind x y reps' x_shape'
    );
    y
  )


let tile_ ~out x reps =
  (* check the validity of reps *)
  if Array.exists ((>) 1) reps then
    failwith "tile: repitition must be >= 1";

  (* case 1: all repeats equal to 1 *)
  if (Array.for_all ((=) 1) reps) = true then
    copy_ x out
  else (
    (* align and promote the shape *)
    let a = num_dims x in
    let b = Array.length reps in
    let x, reps = match a < b with
      | true ->
          let d = Owl_utils.Array.pad `Left 1 (b - a) (shape x) in
          (reshape x d), reps
      | false ->
          let r = Owl_utils.Array.pad `Left 1 (a - b) reps in
          x, r
    in
    let _kind = kind x in
    let x_dims = num_dims x in
    (* case 2 : vector input *)
    if (x_dims = 1) then (
      Owl_ndarray_repeat._ndarray_tile_axis _kind x out 0 reps.(0)
    )
    (* case 3: only one axis to be repeated *)
    else if (Owl_utils_array.count reps 1 = x_dims - 1) then (
      let r = ref (-1) in
      let ax = ref (-1) in
      while !r = -1 && !ax < x_dims do
        ax := !ax + 1;
        if reps.(!ax) != 1 then r := reps.(!ax)
      done;
      Owl_ndarray_repeat._ndarray_tile_axis _kind x out !ax !r
    )
    (* general case *)
    else (
      let reps' = reps |> Array.map Int64.of_int
        |> Array1.of_array int64 c_layout |> genarray_of_array1 in
      let x_shape' = shape x  |> Array.map Int64.of_int
        |> Array1.of_array int64 c_layout |> genarray_of_array1 in
      Owl_ndarray_repeat._ndarray_tile _kind x out reps' x_shape'
    )
  )


let concatenate ?(axis=0) xs =
  let axis = Owl_utils.adjust_index axis (num_dims xs.(0)) in
  (* get the shapes of all inputs and etc. *)
  let shapes = Array.map shape xs in
  let shape0 = Array.copy shapes.(0) in
  shape0.(axis) <- 0;
  let acc_dim = ref 0 in
  (* validate all the input shapes; update step_sz *)
  let step_sz = Array.(make (length xs) 0) in
  Array.iteri (fun i shape1 ->
    step_sz.(i) <- (Owl_utils.calc_slice shape1).(axis);
    acc_dim := !acc_dim + shape1.(axis);
    shape1.(axis) <- 0;
    assert (shape0 = shape1);
  ) shapes;
  (* allocalte space for new array *)
  let _kind = kind xs.(0) in
  shape0.(axis) <- !acc_dim;
  let y = empty _kind shape0 in
  (* calculate the number of copies *)
  let slice_sz = (Owl_utils.calc_slice shape0).(axis) in
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


let concat_vertical x1 x2 = concatenate ~axis:0 [|x1;x2|]


let concat_horizontal x1 x2 = concatenate ~axis:(num_dims x1 - 1) [|x1;x2|]


let concat_vh xs = Array.map (concatenate ~axis:1) xs |> concatenate ~axis:0


let squeeze ?(axis=[||]) x =
  let a = match Array.length axis with
    | 0 -> Array.init (num_dims x) (fun i -> i)
    | _ -> axis
  in
  let s = Owl_utils.Array.filteri (fun i v ->
    not (v == 1 && Array.mem i a)
  ) (shape x)
  in
  reshape x s


let expand ?(hi=false) x d =
  let d0 = d - (num_dims x) in
  match d0 > 0 with
  | true  -> (
      if hi = true then
        Owl_utils.Array.pad `Right 1 d0 (shape x) |> reshape x
      else
        Owl_utils.Array.pad `Left 1 d0 (shape x) |> reshape x
    )
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
      fill y (Owl_const.zero k);
      _owl_copy k n0 ~ofsx ~incx:1 ~ofsy ~incy:1 x y;
      y
    )
  | false -> (
      let _x = reshape_1 x n0 in
      let _y = Array1.sub _x ofsx n1 |> genarray_of_array1 in
      reshape _y d
    )


let sort x =
  let y = copy x in
  Owl_ndarray._owl_sort (kind y) (numel y) y;
  y

let sort_ x = Owl_ndarray._owl_sort (kind x) (numel x) x


let strides x = x |> shape |> Owl_utils.calc_stride


let slice_size x = x |> shape |> Owl_utils.calc_slice


let ind = Owl_utils.ind

let i1d = Owl_utils.i1d


(* align and calculate the output shape for broadcasting over [x0] and [x1] *)
let broadcast_align_shape x0 x1 =
  (* align the rank of inputs *)
  let d0 = num_dims x0 in
  let d1 = num_dims x1 in
  let d3 = max d0 d1 in
  let y0 = expand ~hi:false x0 d3 in
  let y1 = expand ~hi:false x1 d3 in
  (* check whether the shape is valid *)
  let s0 = shape y0 in
  let s1 = shape y1 in
  Array.iter2 (fun a b ->
    Owl_exception.(check (not(a <> 1 && b <> 1 && a <> b)) NOT_BROADCASTABLE);
  ) s0 s1;
  (* calculate the output shape *)
  let s2 = Array.map2 max s0 s1 in
  (* calculate the strides *)
  let t0 = Owl_utils.calc_stride s0 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  let t1 = Owl_utils.calc_stride s1 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  let t2 = Owl_utils.calc_stride s2 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
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


(* the following functions are for broadcasting among x, y, z three variables. *)
let broadcast_align_shape2 x0 x1 x2 =
  let s0, s1, s2 = Owl_utils_array.align3 `Left 1 (shape x0) (shape x1) (shape x2) in
  let y0 = reshape x0 s0 in
  let y1 = reshape x1 s1 in
  let y2 = reshape x2 s2 in
  let s3 = Owl_utils_array.map3 (fun a b c -> max a (max b c)) s0 s1 s2 in

  Owl_utils_array.iter4 (fun a b c d ->
    Owl_exception.(check (not(a <> 1 && a <> d)) NOT_BROADCASTABLE);
    Owl_exception.(check (not(b <> 1 && b <> d)) NOT_BROADCASTABLE);
    Owl_exception.(check (not(c <> 1 && c <> d)) NOT_BROADCASTABLE);
  ) s0 s1 s2 s3;

  (* calculate the strides *)
  let t0 = Owl_utils.calc_stride s0 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  let t1 = Owl_utils.calc_stride s1 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  let t2 = Owl_utils.calc_stride s2 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  let t3 = Owl_utils.calc_stride s3 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  (* return aligned arrays, shapes, strides *)
  y0, y1, y2, s0, s1, s2, s3, t0, t1, t2, t3


let broadcast_op2 ?out op x0 x1 x2 =
  (* align the input rank, calculate the output shape and stride *)
  let y0, y1, y2, s0, s1, s2, s3, t0, t1, t2, t3 = broadcast_align_shape2 x0 x1 x2 in
  let y3 = match out with
    | Some y3 -> y3
    | None    -> empty (kind x0) s3
  in
  (* call the specific map function *)
  op y0 t0 y1 t1 y2 t2 y3 t3;
  y3


(* mathematical functions *)

let min_i x =
  let y = flatten x |> array1_of_genarray in
  let i = _owl_min_i (kind x) (numel x) x in
  let s = Owl_utils.calc_stride (shape x) in
  let j = Array.copy s in
  Owl_utils.index_1d_nd i j s;
  y.{i}, j

let max_i x =
  let y = flatten x |> array1_of_genarray in
  let i = _owl_max_i (kind x) (numel x) x in
  let s = Owl_utils.calc_stride (shape x) in
  let j = Array.copy s in
  Owl_utils.index_1d_nd i j s;
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


let fma x y z =
  let xshp = shape x in
  let yshp = shape y in
  let zshp = shape z in
  let rshp = Owl_utils_infer_shape.broadcast2 xshp yshp zshp in
  let out = empty (kind x) rshp in
  if xshp = yshp && yshp = zshp then
    Owl_ndarray_fma._ndarray_fma (kind x) (numel x) x y z out
  else (
    let _op = Owl_ndarray_fma._ndarray_fma_broadcast (kind x) in
    broadcast_op2 _op ~out x y z |> ignore
  );
  out


let fma_ ?out x y z =
  let out = match out with Some o -> o | None -> x in
  let xshp = shape x in
  let yshp = shape y in
  let zshp = shape z in
  if xshp = yshp && yshp = zshp then
    Owl_ndarray_fma._ndarray_fma (kind x) (numel x) x y z out
  else (
    let _op = Owl_ndarray_fma._ndarray_fma_broadcast (kind x) in
    broadcast_op2 _op ~out x y z |> ignore
  )


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
  Owl_cblas_basic.scal (numel x) a x' 1;
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


let uniform k ?a ?b d =
  let a = match a with Some a -> a | None -> Owl_const.zero k in
  let b = match b with Some b -> b | None -> Owl_const.one k in
  let x = empty k d in
  _owl_uniform k (numel x) x a b;
  x


let uniform_ ?a ?b ~out =
  let k = kind out in
  let a = match a with Some a -> a | None -> Owl_const.zero k in
  let b = match b with Some b -> b | None -> Owl_const.one k in
  _owl_uniform k (numel out) out a b


let gaussian k ?mu ?sigma d =
  let mu = match mu with Some a -> a | None -> Owl_const.zero k in
  let sigma = match sigma with Some a -> a | None -> Owl_const.one k in
  let x = empty k d in
  _owl_gaussian k (numel x) x mu sigma;
  x


let gaussian_ ?mu ?sigma ~out =
  let k = kind out in
  let mu = match mu with Some a -> a | None -> Owl_const.zero k in
  let sigma = match sigma with Some a -> a | None -> Owl_const.one k in
  _owl_gaussian k (numel out) out mu sigma


let linspace k a b n =
  let x = empty k [|n|] in
  _owl_linspace k n a b x;
  x


let logspace k ?(base=Owl_const.e) a b n =
  let x = empty k [|n|] in (
    if base = 2. then
      _owl_logspace_2 k n a b x
    else if base = 10. then
      _owl_logspace_10 k n a b x
    else if base = Owl_const.e then
      _owl_logspace_e k n a b x
    else
      _owl_logspace_base k n base a b x
  );
  x


let bernoulli k ?(p=0.5) d =
  assert (p >= 0. && p <= 1.);
  let x = empty k d in
  (_owl_bernoulli k) (numel x) x p 0;
  x


let bernoulli_ ?(p=0.5) ~out =
  assert (p >= 0. && p <= 1.);
  let k = kind out in
  (_owl_bernoulli k) (numel out) out p 0


let create kind dimension a =
  let x = empty kind dimension in
  let _ = fill x a in
  x


let create_ ~out a = fill out a


let zeros kind dimension = create kind dimension (Owl_const.zero kind)


let zeros_ ~out = reset out


let ones kind dimension = create kind dimension (Owl_const.one kind)


let ones_ ~out = fill out (Owl_const.one (kind out))


let sequential k ?a ?step dimension =
  let a = match a with
    | Some a -> a
    | None   -> Owl_const.zero k
  in
  let step = match step with
    | Some step -> step
    | None      -> Owl_const.one k
  in
  let x = empty k dimension in
  _owl_sequential k (numel x) x a step;
  x


let sequential_ ?a ?step ~out =
  let k = kind out in
  let a = match a with
    | Some a -> a
    | None   -> Owl_const.zero k
  in
  let step = match step with
    | Some step -> step
    | None      -> Owl_const.one k
  in
  _owl_sequential k (numel out) out a step


let dropout ?(rate=0.5) x =
  assert (rate >= 0. && rate <= 1.);
  let x = copy x in
  _owl_dropout (kind x) (numel x) x rate 0;
  x


let argsort x =
  let y = sequential Int64 (shape x) in
  Owl_ndarray._owl_argsort (kind x) (numel x) x y;
  y


(* advanced operations *)

let iteri f x =
  let x' = flatten x |> array1_of_genarray in
  for i = 0 to (Array1.dim x') - 1 do
    let a = Array1.unsafe_get x' i in
    f i a
  done


let iter f x =
  let x' = flatten x |> array1_of_genarray in
  for i = 0 to (Array1.dim x') - 1 do
    let a = Array1.unsafe_get x' i in
    f a
  done


let iter2i f x y =
  assert (same_shape x y);
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  for i = 0 to (Array1.dim x') - 1 do
    let a = Array1.unsafe_get x' i in
    let b = Array1.unsafe_get y' i in
    f i a b
  done


let iter2 f x y =
  assert (same_shape x y);
  let x' = flatten x |> array1_of_genarray in
  let y' = flatten y |> array1_of_genarray in
  for i = 0 to (Array1.dim x') - 1 do
    let a = Array1.unsafe_get x' i in
    let b = Array1.unsafe_get y' i in
    f a b
  done


let mapi f x =
  let y = copy x in
  let y' = flatten y |> array1_of_genarray in
  for i = 0 to (Array1.dim y') - 1 do
    let a = Array1.unsafe_get y' i in
    Array1.unsafe_set y' i (f i a)
  done;
  y


let map f x =
  let y = copy x in
  let y' = flatten y |> array1_of_genarray in
  for i = 0 to (Array1.dim y') - 1 do
    let a = Array1.unsafe_get y' i in
    Array1.unsafe_set y' i (f a)
  done;
  y


let map2i f x y =
  assert (same_shape x y);
  let z = copy x in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  for i = 0 to (Array1.dim z') - 1 do
    let a = Array1.unsafe_get z' i in
    let b = Array1.unsafe_get y' i in
    Array1.unsafe_set z' i (f i a b)
  done;
  z


let map2 f x y =
  assert (same_shape x y);
  let z = copy x in
  let y' = flatten y |> array1_of_genarray in
  let z' = flatten z |> array1_of_genarray in
  for i = 0 to (Array1.dim z') - 1 do
    let a = Array1.unsafe_get z' i in
    let b = Array1.unsafe_get y' i in
    Array1.unsafe_set z' i (f a b)
  done;
  z


let iteri_nd f x = iteri (fun i a -> f (Owl_utils.ind x i) a) x


let mapi_nd f x = mapi (fun i a -> f (Owl_utils.ind x i) a) x


let iter2i_nd f x y =
  assert (same_shape x y);
  iter2i (fun i a b -> f (Owl_utils.ind x i) a b) x y


let map2i_nd f x y =
  assert (same_shape x y);
  map2i (fun i a b -> f (Owl_utils.ind x i) a b) x y


let iteri_slice ?(axis=0) f x =
  let d = num_dims x in
  let axis = Owl_utils.adjust_index axis d in
  let m = (numel x) / (strides x).(axis) in
  let s = Array.sub (shape x) (axis + 1) (d - axis - 1) in
  let n = s.(0) in
  s.(0) <- m * s.(0);
  let y = reshape x s in
  let ofs = ref (-n) in

  for i = 0 to m - 1 do
    ofs := !ofs + n;
    f i (sub_left y !ofs n)
  done


let iter_slice ?axis f x = iteri_slice ?axis (fun _ y -> f y) x


let mapi_slice ?(axis=0) f x =
  let d = num_dims x in
  let axis = Owl_utils.adjust_index axis d in
  let m = (numel x) / (strides x).(axis) in
  let s = Array.sub (shape x) (axis + 1) (d - axis - 1) in
  let n = s.(0) in
  s.(0) <- m * s.(0);
  let y = reshape x s in
  let ofs = ref (-n) in

  Array.init m (fun i ->
    ofs := !ofs + n;
    f i (sub_left y !ofs n)
  )


let map_slice ?axis f x = mapi_slice ?axis (fun _ y -> f y) x


let filteri_slice ?axis f x =
  let s = Owl_utils.Stack.make () in
  iteri_slice ?axis (fun i y ->
    if (f i y) then Owl_utils.Stack.push s y
  ) x;
  Owl_utils.Stack.to_array s


let filter_slice ?axis f x = filteri_slice ?axis (fun _ y -> f y) x


let foldi_slice ?axis f a x =
  let acc = ref a in
  iteri_slice ?axis (fun i y -> acc := f i !acc y) x;
  !acc

let fold_slice ?axis f x = foldi_slice ?axis (fun _ y -> f y) x


(* manipulation functions *)

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
  let k = kind x in
  let s = shape x in
  let m, n = s.(0), s.(1) in
  let y = empty k [|n;m|] in
  Owl_matrix._matrix_transpose k x y;
  y


let matrix_transpose_ ~out x =
  let k = kind x in
  Owl_matrix._matrix_transpose k x out


let transpose ?axis x =
  let d = num_dims x in
  let a = match axis with
    | Some a -> a
    | None   -> Array.init d (fun i -> d - i - 1)
  in
  (* trivial case *)
  if a = Array.init d (fun i -> i) then copy x
  else (
    (* check if axis is a correct permutation *)
    _check_transpose_axis a d;
    if d = 2 then matrix_transpose x
    else (
      let sx = shape x in
      let sy = Array.map (fun j -> sx.(j)) a in
      let y = empty (kind x) sy in
      (* calculate the inverse of the permutation *)
      let b = Array.make d 0 in
      Array.iteri (fun i j -> b.(j) <- i) a;
      let _incy = strides y in
      let _incy = Array.map (fun j -> Int32.of_int _incy.(j)) b in
      let _incx = Array.map Int32.of_int (strides x) in
      let incx = Array1.of_array Int32 C_layout _incx |> genarray_of_array1 in
      let incy = Array1.of_array Int32 C_layout _incy |> genarray_of_array1 in
      Owl_ndarray._ndarray_transpose (kind x) x y incx incy;
      y
    )
  )


let transpose_ ~out ?axis x =
  let d = num_dims x in
  let a = match axis with
    | Some a -> a
    | None   -> Array.init d (fun i -> d - i - 1)
  in
  (* trivial case *)
  if a = Array.init d (fun i -> i) then copy_ ~out x
  else (
    (* check if axis is a correct permutation *)
    _check_transpose_axis a d;
    if d = 2 then matrix_transpose_ ~out x
    else (
      let sx = shape x in
      let sy = Array.map (fun j -> sx.(j)) a in
      (* calculate the inverse of the permutation *)
      let b = Array.make d 0 in
      Array.iteri (fun i j -> b.(j) <- i) a;
      let _incy = Owl_utils.calc_stride sy in
      let _incy = Array.map (fun j -> Int32.of_int _incy.(j)) b in
      let _incx = Array.map Int32.of_int (strides x) in
      let incx = Array1.of_array Int32 C_layout _incx |> genarray_of_array1 in
      let incy = Array1.of_array Int32 C_layout _incy |> genarray_of_array1 in
      Owl_ndarray._ndarray_transpose (kind x) x out incx incy
    )
  )


let swap a0 a1 x =
  let d = num_dims x in
  let a = Array.init d (fun i -> i) in
  let t = a.(a0) in
  a.(a0) <- a.(a1);
  a.(a1) <- t;
  transpose ~axis:a x


let filteri f x =
  let s = Owl_utils.Stack.make () in
  iteri (fun i y ->
    if f i y = true then
      Owl_utils.Stack.push s i
  ) x;
  Owl_utils.Stack.to_array s


let filter f x = filteri (fun _ y -> f y) x


let filteri_nd f x =
  let s = Owl_utils.Stack.make () in
  iteri (fun i y ->
    let i' = Owl_utils.ind x i in
    if f i' y = true then
      Owl_utils.Stack.push s i'
  ) x;
  Owl_utils.Stack.to_array s


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
  let s = (Owl_utils.elt_to_str k) v in
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
  Owl_pretty.print_dsnda ?max_row ?max_col ?header ?elt_to_str_fun:fmt x

let pp_dsnda formatter x = Owl_pretty.pp_dsnda formatter x

let save x f = Owl_io.marshal_to_file x f

let load k f = Owl_io.marshal_from_file f

let of_array k x d =
  let n = Array.fold_left (fun a b -> a * b) 1 d in
  assert (Array.length x = n);
  let y = Array1.of_array k C_layout x |> genarray_of_array1 in
  reshape y d

let to_array x =
  let n = numel x in
  let y = flatten x |> array1_of_genarray in
  Array.init n (fun i -> y.{i})

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


(* padding and its helper functions *)

let _expand_padding_index d s =
  let ls = Array.length s in
  let ld = Array.length d in
  let d = Owl_utils.Array.pad `Right [|0;0|] (ls - ld) d in
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
    let j0 = Owl_utils.index_nd_1d i0 l0 in
    let j1 = Owl_utils.index_nd_1d i1 l1 in
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
    | None   -> Owl_const.zero k
  in
  let s0 = shape x in
  let p1 = _expand_padding_index (Owl_utils.llss2aarr d) s0 in
  let s1 = Array.map2 (fun m n -> m + n.(0) + n.(1)) s0 p1 in
  let y = create k s1 v in
  (* prepare variables for block copying *)
  let ls = Owl_utils.calc_slice s0 in
  let l0 = Owl_utils.calc_stride s0 in
  let l1 = Owl_utils.calc_stride s1 in
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
    Owl_utils_infer_shape.calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  let output = empty (kind input) [|batches; output_cols; output_rows; out_channel|] in

  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _owl_spatial_conv (kind input)
    input kernel output batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows out_channel
    row_stride col_stride pad_typ row_in_stride col_in_stride;

  output


let conv2d_ ~out ?(padding=SAME) input kernel stride =
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
    Owl_utils_infer_shape.calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _owl_spatial_conv (kind input)
    input kernel out batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows out_channel
    row_stride col_stride pad_typ row_in_stride col_in_stride


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

  _owl_spatial_conv_backward_input (kind input')
    input' kernel output' batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows out_channel
    row_stride col_stride row_in_stride col_in_stride;

  input'


let conv2d_backward_input_ ~out input kernel stride output' =
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

  _owl_spatial_conv_backward_input (kind input)
    out kernel output' batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows out_channel
    row_stride col_stride row_in_stride col_in_stride


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

  _owl_spatial_conv_backward_kernel (kind input)
    input kernel' output' batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows out_channel
    row_stride col_stride row_in_stride col_in_stride;

  kernel'


let conv2d_backward_kernel_ ~out input kernel stride output' =
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

  _owl_spatial_conv_backward_kernel (kind input)
    input out output' batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows out_channel
    row_stride col_stride row_in_stride col_in_stride


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
    Owl_utils_infer_shape.calc_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols kernel_rows kernel_dpts row_stride col_stride dpt_stride
  in
  let output = empty (kind input) [|batches; output_cols; output_rows; output_dpts; out_channel|] in

  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _owl_cuboid_conv (kind input)
    input kernel output batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts out_channel
    dpt_stride row_stride col_stride pad_typ;

  output


let conv3d_ ~out ?(padding=SAME) input kernel stride =
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
    Owl_utils_infer_shape.calc_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols kernel_rows kernel_dpts row_stride col_stride dpt_stride
  in
  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _owl_cuboid_conv (kind input)
    input kernel out batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts out_channel
    dpt_stride row_stride col_stride pad_typ


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

  _owl_cuboid_conv_backward_input (kind input')
    input' kernel output' batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts out_channel
    dpt_stride row_stride col_stride;

  input'


let conv3d_backward_input_ ~out input kernel stride output' =
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

  _owl_cuboid_conv_backward_input (kind input)
    out kernel output' batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts out_channel
    dpt_stride row_stride col_stride


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

  _owl_cuboid_conv_backward_kernel (kind input)
    input kernel' output' batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts out_channel
    dpt_stride row_stride col_stride;

  kernel'


let conv3d_backward_kernel_ ~out input kernel stride output' =
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

  _owl_cuboid_conv_backward_kernel (kind input)
    input out output' batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts out_channel
    dpt_stride row_stride col_stride


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
  let kernel = reshape kernel [|1; kernel_cols; in_channel; out_channel|] in

  let col_stride = stride.(0) in
  let stride = [|1; col_stride|] in

  let output = conv2d ~padding input kernel stride in
  let output_shp = shape output in
  let output_cols = output_shp.(2) in
  let output = reshape output [|batches; output_cols; out_channel|] in
  output


let conv1d_ ~out ?(padding=SAME) input kernel stride =
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
  let kernel = reshape kernel [|1; kernel_cols; in_channel; out_channel|] in

  let col_stride = stride.(0) in
  let stride = [|1; col_stride|] in

  conv2d_ ~out ~padding input kernel stride


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


let conv1d_backward_input_ ~out input kernel stride output' =
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

  conv2d_backward_input_ ~out input kernel stride output'


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


let conv1d_backward_kernel_ ~out input kernel stride output' =
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

  conv2d_backward_kernel_ ~out input kernel stride output'


(* dilated_conv2d: 4d input and 4d kernel, refer to tensorlfow doc
  input : [batch; input_column; input_row; input_channel]
  kernel: [kernel_column; kernel_row; input_channel; output_channel]
  stride: [column_stride; row_stride]
  rate  : [col_dilation_rate; row_dilation_rate]
  output: [batch; output_column; output_row; output_channel]
 *)
let dilated_conv2d ?(padding=SAME) input kernel stride rate =
  assert (num_dims input = 4);
  assert (num_dims kernel = 4);
  assert (Array.length stride = 2);
  assert (Array.length rate = 2);

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
  let col_in_stride = rate.(0) in
  let row_in_stride = rate.(1) in

  let kernel_cols_up = kernel_cols + (kernel_cols - 1) * (col_in_stride - 1) in
  let kernel_rows_up = kernel_rows + (kernel_rows - 1) * (row_in_stride - 1) in

  let output_cols, output_rows =
    Owl_utils_infer_shape.calc_conv2d_output_shape padding input_cols input_rows kernel_cols_up kernel_rows_up row_stride col_stride
  in
  let output = empty (kind input) [|batches; output_cols; output_rows; out_channel|] in

  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _owl_dilated_spatial_conv (kind input)
    input kernel output batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows out_channel
    row_stride col_stride pad_typ row_in_stride col_in_stride;

  output


let dilated_conv2d_ ~out ?(padding=SAME) input kernel stride rate =
  assert (num_dims input = 4);
  assert (num_dims kernel = 4);
  assert (Array.length stride = 2);
  assert (Array.length rate = 2);

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
  let col_in_stride = rate.(0) in
  let row_in_stride = rate.(1) in

  let kernel_cols_up = kernel_cols + (kernel_cols - 1) * (col_in_stride - 1) in
  let kernel_rows_up = kernel_rows + (kernel_rows - 1) * (row_in_stride - 1) in

  let output_cols, output_rows =
    Owl_utils_infer_shape.calc_conv2d_output_shape padding input_cols input_rows kernel_cols_up kernel_rows_up row_stride col_stride
  in

  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _owl_dilated_spatial_conv (kind input)
    input kernel out batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows out_channel
    row_stride col_stride pad_typ row_in_stride col_in_stride


(* gradient of dilated_conv2d w.r.t the input *)
let dilated_conv2d_backward_input input kernel stride rate output' =
  assert (num_dims input = 4);
  assert (num_dims kernel = 4);
  assert (num_dims output' = 4);
  assert (Array.length stride = 2);
  assert (Array.length rate = 2);

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
  let col_in_stride = rate.(0) in
  let row_in_stride = rate.(1) in

  let input' = empty (kind input) (shape input) in

  _owl_dilated_spatial_conv_backward_input (kind input')
    input' kernel output' batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows out_channel
    row_stride col_stride row_in_stride col_in_stride;

  input'


let dilated_conv2d_backward_input_ ~out input kernel stride rate output' =
  assert (num_dims input = 4);
  assert (num_dims kernel = 4);
  assert (num_dims output' = 4);
  assert (Array.length stride = 2);
  assert (Array.length rate = 2);

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
  let col_in_stride = rate.(0) in
  let row_in_stride = rate.(1) in

  _owl_dilated_spatial_conv_backward_input (kind input)
    out kernel output' batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows out_channel
    row_stride col_stride row_in_stride col_in_stride


(* gradient of dilated_conv2d w.r.t the kernel *)
let dilated_conv2d_backward_kernel input kernel stride rate output' =
  assert (num_dims input = 4);
  assert (num_dims kernel = 4);
  assert (num_dims output' = 4);
  assert (Array.length stride = 2);
  assert (Array.length rate = 2);

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
  let col_in_stride = rate.(0) in
  let row_in_stride = rate.(1) in

  let kernel' = empty (kind kernel) (shape kernel) in

  _owl_dilated_spatial_conv_backward_kernel (kind input)
    input kernel' output' batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows out_channel
    row_stride col_stride row_in_stride col_in_stride;

  kernel'


let dilated_conv2d_backward_kernel_ ~out input kernel stride rate output' =
  assert (num_dims input = 4);
  assert (num_dims kernel = 4);
  assert (num_dims output' = 4);
  assert (Array.length stride = 2);
  assert (Array.length rate = 2);

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
  let col_in_stride = rate.(0) in
  let row_in_stride = rate.(1) in

  _owl_dilated_spatial_conv_backward_kernel (kind input)
    input out output' batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows out_channel
    row_stride col_stride row_in_stride col_in_stride


(* dilated_conv3d: 5d input and 5d kernel, refer to tensorflow doc
  input : [batch; input_column; input_row; input_depth; input_channel]
  kernel: [kernel_column; kernel_row; kernel_depth; input_channel; output_channel]
  stride: [column_stride; row_stride; depth_stride]
  rate  : [col_dilation_rate; row_dilation_rate; depth_dilation_rate]
  output: [batch; output_column; output_row; output_dpts; output_channel]
 *)
let dilated_conv3d ?(padding=SAME) input kernel stride rate =
  assert (num_dims input = 5);
  assert (num_dims kernel = 5);
  assert (Array.length stride = 3);
  assert (Array.length rate = 3);

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

  let col_in_stride = rate.(0) in
  let row_in_stride = rate.(1) in
  let dpt_in_stride = rate.(2) in

  let kernel_cols_up = kernel_cols + (kernel_cols - 1) * (col_in_stride - 1) in
  let kernel_rows_up = kernel_rows + (kernel_rows - 1) * (row_in_stride - 1) in
  let kernel_dpts_up = kernel_dpts + (kernel_dpts - 1) * (dpt_in_stride - 1) in

  let output_cols, output_rows, output_dpts =
    Owl_utils_infer_shape.calc_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols_up kernel_rows_up kernel_dpts_up row_stride col_stride dpt_stride
  in
  let output = empty (kind input) [|batches; output_cols; output_rows; output_dpts; out_channel|] in

  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _owl_dilated_cuboid_conv (kind input)
    input kernel output batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts out_channel
    dpt_stride row_stride col_stride
    dpt_in_stride row_in_stride col_in_stride pad_typ;

  output


let dilated_conv3d_ ~out ?(padding=SAME) input kernel stride rate =
  assert (num_dims input = 5);
  assert (num_dims kernel = 5);
  assert (Array.length stride = 3);
  assert (Array.length rate = 3);

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

  let col_in_stride = rate.(0) in
  let row_in_stride = rate.(1) in
  let dpt_in_stride = rate.(2) in

  let kernel_cols_up = kernel_cols + (kernel_cols - 1) * (col_in_stride - 1) in
  let kernel_rows_up = kernel_rows + (kernel_rows - 1) * (row_in_stride - 1) in
  let kernel_dpts_up = kernel_dpts + (kernel_dpts - 1) * (dpt_in_stride - 1) in

  let output_cols, output_rows, output_dpts =
    Owl_utils_infer_shape.calc_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols_up kernel_rows_up kernel_dpts_up row_stride col_stride dpt_stride
  in

  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _owl_dilated_cuboid_conv (kind input)
    input kernel out batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts out_channel
    dpt_stride row_stride col_stride
    dpt_in_stride row_in_stride col_in_stride pad_typ


(* gradient of dilated_conv3d w.r.t the input *)
let dilated_conv3d_backward_input input kernel stride rate output' =
  assert (num_dims input = 5);
  assert (num_dims kernel = 5);
  assert (num_dims output' = 5);
  assert (Array.length stride = 3);
  assert (Array.length rate = 3);

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

  let col_in_stride = rate.(0) in
  let row_in_stride = rate.(1) in
  let dpt_in_stride = rate.(2) in

  let input' = empty (kind input) (shape input) in

  _owl_dilated_cuboid_conv_backward_input (kind input')
    input' kernel output' batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts out_channel
    dpt_stride row_stride col_stride
    dpt_in_stride row_in_stride col_in_stride;

  input'


let dilated_conv3d_backward_input_ ~out input kernel stride rate output' =
  assert (num_dims input = 5);
  assert (num_dims kernel = 5);
  assert (num_dims output' = 5);
  assert (Array.length stride = 3);
  assert (Array.length rate = 3);

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

  let col_in_stride = rate.(0) in
  let row_in_stride = rate.(1) in
  let dpt_in_stride = rate.(2) in

  _owl_dilated_cuboid_conv_backward_input (kind input)
    out kernel output' batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts out_channel
    dpt_stride row_stride col_stride
    dpt_in_stride row_in_stride col_in_stride


(* gradient of dilated_conv3d w.r.t the kernel *)
let dilated_conv3d_backward_kernel input kernel stride rate output' =
  assert (num_dims input = 5);
  assert (num_dims kernel = 5);
  assert (num_dims output' = 5);
  assert (Array.length stride = 3);
  assert (Array.length rate = 3);

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

  let col_in_stride = rate.(0) in
  let row_in_stride = rate.(1) in
  let dpt_in_stride = rate.(2) in

  let kernel' = empty (kind kernel) (shape kernel) in

  _owl_dilated_cuboid_conv_backward_kernel (kind input)
    input kernel' output' batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts out_channel
    dpt_stride row_stride col_stride
    dpt_in_stride row_in_stride col_in_stride;

  kernel'


let dilated_conv3d_backward_kernel_ ~out input kernel stride rate output' =
  assert (num_dims input = 5);
  assert (num_dims kernel = 5);
  assert (num_dims output' = 5);
  assert (Array.length stride = 3);
  assert (Array.length rate = 3);

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

  let col_in_stride = rate.(0) in
  let row_in_stride = rate.(1) in
  let dpt_in_stride = rate.(2) in

  _owl_dilated_cuboid_conv_backward_kernel (kind input)
    input out output' batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts out_channel
    dpt_stride row_stride col_stride
    dpt_in_stride row_in_stride col_in_stride


(* dilated_conv1d: 3d input and 3d kernel, refer to tensorlfow doc
  input : [batch; input_column; input_channel]
  kernel: [kernel_column; input_channel; output_channel]
  stride: [column_stride]
  reate : [column_dilation_rate]
  output: [batch; output_column; output_channel]
 *)
let dilated_conv1d ?(padding=SAME) input kernel stride rate =
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
  let kernel = reshape kernel [|1; kernel_cols; in_channel; out_channel|] in

  let col_stride = stride.(0) in
  let stride = [|1; col_stride|] in

  let output = dilated_conv2d ~padding input kernel stride rate in
  let output_shp = shape output in
  let output_cols = output_shp.(2) in
  let output = reshape output [|batches; output_cols; out_channel|] in
  output


let dilated_conv1d_ ~out ?(padding=SAME) input kernel stride rate =
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
  let kernel = reshape kernel [|1; kernel_cols; in_channel; out_channel|] in

  let col_stride = stride.(0) in
  let stride = [|1; col_stride|] in

  dilated_conv2d_ ~out ~padding input kernel stride rate


(* gradient of dilated_conv1d w.r.t the input *)
let dilated_conv1d_backward_input input kernel stride rate output' =
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

  let input' = dilated_conv2d_backward_input input kernel stride rate output' in
  reshape input' input_shp


let dilated_conv1d_backward_input_ ~out input kernel stride rate output' =
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

  dilated_conv2d_backward_input_ ~out input kernel stride rate output'


(* gradient of dilated_conv1d w.r.t the kernel *)
let dilated_conv1d_backward_kernel input kernel stride rate output' =
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

  let kernel' = dilated_conv2d_backward_kernel input kernel stride rate output' in
  reshape kernel' kernel_shp


let dilated_conv1d_backward_kernel_ ~out input kernel stride rate output' =
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

  dilated_conv2d_backward_kernel_ ~out input kernel stride rate output'


(* transpose_conv2d: 4d input and 4d kernel, refer to tensorlfow doc
  input : [batch; input_column; input_row; input_channel]
  kernel: [kernel_column; kernel_row; input_channel; output_channel]
  stride: [column_stride; row_stride]
  output: [batch; output_column; output_row; output_channel]
 *)
let transpose_conv2d ?(padding=SAME) input kernel stride =
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
    Owl_utils_infer_shape.calc_transpose_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  let output = empty (kind input) [|batches; output_cols; output_rows; out_channel|] in

  _owl_spatial_conv_backward_input (kind input)
    output kernel input batches output_cols output_rows out_channel
    kernel_cols kernel_rows input_cols input_rows in_channel
    row_stride col_stride row_in_stride col_in_stride;

  output


let transpose_conv2d_ ~out ?(padding=SAME) input kernel stride =
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
    Owl_utils_infer_shape.calc_transpose_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in

  _owl_spatial_conv_backward_input (kind input)
    out kernel input batches output_cols output_rows out_channel
    kernel_cols kernel_rows input_cols input_rows in_channel
    row_stride col_stride row_in_stride col_in_stride


(* gradient of transpose_conv2d w.r.t the kernel *)
let transpose_conv2d_backward_kernel input kernel stride output' =
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

  _owl_spatial_conv_backward_kernel (kind input)
    output' kernel' input batches output_cols output_rows out_channel
    kernel_cols kernel_rows input_cols input_rows in_channel
    row_stride col_stride row_in_stride col_in_stride;

  kernel'


let transpose_conv2d_backward_kernel_ ~out input kernel stride output' =
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

  _owl_spatial_conv_backward_kernel (kind input)
    output' out input batches output_cols output_rows out_channel
    kernel_cols kernel_rows input_cols input_rows in_channel
    row_stride col_stride row_in_stride col_in_stride


(* gradient of transpose_conv2d w.r.t the input *)
let transpose_conv2d_backward_input input kernel stride output' =
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

  let dummy_pad_typ = 0 in
  _owl_spatial_conv (kind input)
    output' kernel input' batches output_cols output_rows out_channel
    kernel_cols kernel_rows input_cols input_rows in_channel
    row_stride col_stride dummy_pad_typ row_in_stride col_in_stride;

  input'


let transpose_conv2d_backward_input_ ~out input kernel stride output' =
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

  let dummy_pad_typ = 0 in
  _owl_spatial_conv (kind input)
    output' kernel out batches output_cols output_rows out_channel
    kernel_cols kernel_rows input_cols input_rows in_channel
    row_stride col_stride dummy_pad_typ row_in_stride col_in_stride


(* transpose_conv3d: 5d input and 5d kernel, refer to tensorflow doc
  input : [batch; input_column; input_row; input_depth; input_channel]
  kernel: [kernel_column; kernel_row; kernel_depth; input_channel; output_channel]
  stride: [column_stride; row_stride; depth_stride]
  output: [batch; output_column; output_row; output_dpts; output_channel]
 *)
let transpose_conv3d ?(padding=SAME) input kernel stride =
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
    Owl_utils_infer_shape.calc_transpose_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols kernel_rows kernel_dpts row_stride col_stride dpt_stride
  in
  let output = empty (kind input) [|batches; output_cols; output_rows; output_dpts; out_channel|] in

  _owl_cuboid_conv_backward_input (kind input)
    output kernel input batches
    output_cols output_rows output_dpts out_channel
    kernel_cols kernel_rows kernel_dpts
    input_cols input_rows input_dpts in_channel
    dpt_stride row_stride col_stride;

  output


let transpose_conv3d_ ~out ?(padding=SAME) input kernel stride =
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
    Owl_utils_infer_shape.calc_transpose_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols kernel_rows kernel_dpts row_stride col_stride dpt_stride
  in

  _owl_cuboid_conv_backward_input (kind input)
    out kernel input batches
    output_cols output_rows output_dpts out_channel
    kernel_cols kernel_rows kernel_dpts
    input_cols input_rows input_dpts in_channel
    dpt_stride row_stride col_stride


(* gradient of transpose_conv3d w.r.t the input *)
let transpose_conv3d_backward_input input kernel stride output' =
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

  let dummy_pad_typ = 0 in
  _owl_cuboid_conv (kind input)
    output' kernel input' batches
    output_cols output_rows output_dpts out_channel
    kernel_cols kernel_rows kernel_dpts
    input_cols input_rows input_dpts in_channel
    dpt_stride row_stride col_stride dummy_pad_typ;

  input'


let transpose_conv3d_backward_input_ ~out input kernel stride output' =
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

  let dummy_pad_typ = 0 in
  _owl_cuboid_conv (kind input)
    output' kernel out batches
    output_cols output_rows output_dpts out_channel
    kernel_cols kernel_rows kernel_dpts
    input_cols input_rows input_dpts in_channel
    dpt_stride row_stride col_stride dummy_pad_typ


(* gradient of transpose_conv3d w.r.t the kernel *)
let transpose_conv3d_backward_kernel input kernel stride output' =
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

  _owl_cuboid_conv_backward_kernel (kind input)
    output' kernel' input batches
    output_cols output_rows output_dpts out_channel
    kernel_cols kernel_rows kernel_dpts
    input_cols input_rows input_dpts in_channel
    dpt_stride row_stride col_stride;

  kernel'


let transpose_conv3d_backward_kernel_ ~out input kernel stride output' =
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

  _owl_cuboid_conv_backward_kernel (kind input)
    output' out input batches
    output_cols output_rows output_dpts out_channel
    kernel_cols kernel_rows kernel_dpts
    input_cols input_rows input_dpts in_channel
    dpt_stride row_stride col_stride


let transpose_conv1d ?(padding=SAME) input kernel stride =
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
  let kernel = reshape kernel [|1; kernel_cols; in_channel; out_channel|] in

  let col_stride = stride.(0) in
  let stride = [|1; col_stride|] in

  let output = transpose_conv2d ~padding input kernel stride in
  let output_shp = shape output in
  let output_cols = output_shp.(2) in
  let output = reshape output [|batches; output_cols; out_channel|] in
  output


let transpose_conv1d_ ~out ?(padding=SAME) input kernel stride =
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
  let kernel = reshape kernel [|1; kernel_cols; in_channel; out_channel|] in

  let col_stride = stride.(0) in
  let stride = [|1; col_stride|] in

  transpose_conv2d_ ~out ~padding input kernel stride


(* gradient of transpose_conv1d w.r.t the input *)
let transpose_conv1d_backward_input input kernel stride output' =
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

  let input' = transpose_conv2d_backward_input input kernel stride output' in
  reshape input' input_shp


let transpose_conv1d_backward_input_ ~out input kernel stride output' =
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

  transpose_conv2d_backward_input_ ~out input kernel stride output'


(* gradient of transpose_conv1d w.r.t the kernel *)
let transpose_conv1d_backward_kernel input kernel stride output' =
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

  let kernel' = transpose_conv2d_backward_kernel input kernel stride output' in
  reshape kernel' kernel_shp


let transpose_conv1d_backward_kernel_ ~out input kernel stride output' =
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

  transpose_conv2d_backward_kernel_ ~out input kernel stride output'


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
    Owl_utils_infer_shape.calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  let output = empty (kind input) [|batches; output_cols; output_rows; in_channel|] in

  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _owl_spatial_max_pooling (kind input)
    input output batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride pad_typ row_in_stride col_in_stride;

  output


let max_pool2d_ ~out ?(padding=SAME) input kernel stride =
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
    Owl_utils_infer_shape.calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _owl_spatial_max_pooling (kind input)
    input out batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride pad_typ row_in_stride col_in_stride


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


let max_pool1d_ ~out ?(padding=SAME) input kernel stride =
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

  max_pool2d_ ~padding ~out input kernel stride


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
    Owl_utils_infer_shape.calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  let output = empty (kind input) [|batches; output_cols; output_rows; in_channel|] in

  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _owl_spatial_avg_pooling (kind input)
    input output batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride pad_typ row_in_stride col_in_stride;

  output


let avg_pool2d_ ~out ?(padding=SAME) input kernel stride =
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
    Owl_utils_infer_shape.calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _owl_spatial_avg_pooling (kind input)
    input out batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride pad_typ row_in_stride col_in_stride


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


let avg_pool1d_ ~out ?(padding=SAME) input kernel stride =
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

  avg_pool2d_ ~out ~padding input kernel stride


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
    Owl_utils_infer_shape.calc_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols kernel_rows kernel_dpts row_stride col_stride dpt_stride
  in
  let output = empty (kind input) [|batches; output_cols; output_rows; output_dpts; in_channel|] in

  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _owl_cuboid_max_pooling (kind input)
    input output batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts
    dpt_stride row_stride col_stride pad_typ;

  output


let max_pool3d_ ~out ?(padding=SAME) input kernel stride =
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
    Owl_utils_infer_shape.calc_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols kernel_rows kernel_dpts row_stride col_stride dpt_stride
  in
  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _owl_cuboid_max_pooling (kind input)
    input out batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts
    dpt_stride row_stride col_stride pad_typ


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
    Owl_utils_infer_shape.calc_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols kernel_rows kernel_dpts row_stride col_stride dpt_stride
  in
  let output = empty (kind input) [|batches; output_cols; output_rows; output_dpts; in_channel|] in

  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _owl_cuboid_avg_pooling (kind input)
    input output batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts
    dpt_stride row_stride col_stride pad_typ;

  output


let avg_pool3d_ ~out ?(padding=SAME) input kernel stride =
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
    Owl_utils_infer_shape.calc_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols kernel_rows kernel_dpts row_stride col_stride dpt_stride
  in
  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _owl_cuboid_avg_pooling (kind input)
    input out batches
    input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts
    dpt_stride row_stride col_stride pad_typ


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
    Owl_utils_infer_shape.calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  let output = empty (kind input) [|batches; output_cols; output_rows; in_channel|] in
  let argmax = Genarray.create int64 c_layout [|batches; output_cols; output_rows; in_channel|] in

  let pad_top, pad_left, _, _ =
    Owl_utils_infer_shape.calc_conv2d_padding input_cols input_rows kernel_cols kernel_rows output_cols output_rows row_stride col_stride
  in

  _owl_spatial_max_pooling_argmax (kind input)
    input output argmax
    batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride pad_top pad_left;

  output, argmax

(* calculate the gradient of max_pool2d *)
let max_pool3d_backward padding input kernel stride output' =
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
    Owl_utils_infer_shape.calc_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols kernel_rows kernel_dpts row_stride col_stride dpt_stride
  in
  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in
  let input' = empty (kind input) (shape input) in

  _owl_cuboid_max_pooling_backward (kind input)
    input output' input'
    batches input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts
    col_stride row_stride dpt_stride
    pad_typ;

  input'


let max_pool3d_backward_ ~out padding input kernel stride output' =
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
    Owl_utils_infer_shape.calc_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols kernel_rows kernel_dpts row_stride col_stride dpt_stride
  in
  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _owl_cuboid_max_pooling_backward (kind input)
    input output' out
    batches input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts
    col_stride row_stride dpt_stride
    pad_typ


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
    Owl_utils_infer_shape.calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  let pad_top, pad_left, _, _ =
    Owl_utils_infer_shape.calc_conv2d_padding input_cols input_rows kernel_cols kernel_rows output_cols output_rows row_stride col_stride
  in
  let input' = empty (kind input) (shape input) in

  _owl_spatial_max_pooling_backward (kind input)
    input output' input'
    batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride pad_top pad_left;

  input'


let max_pool2d_backward_ ~out padding input kernel stride output' =
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
    Owl_utils_infer_shape.calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  let pad_top, pad_left, _, _ =
    Owl_utils_infer_shape.calc_conv2d_padding input_cols input_rows kernel_cols kernel_rows output_cols output_rows row_stride col_stride
  in

  _owl_spatial_max_pooling_backward (kind input)
    input output' out
    batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride pad_top pad_left


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


let max_pool1d_backward_ ~out padding input kernel stride output' =
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

  max_pool2d_backward_ ~out padding input kernel stride output'


(* calculate the gradient of max_pool2d *)
let avg_pool3d_backward padding input kernel stride output' =
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
    Owl_utils_infer_shape.calc_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols kernel_rows kernel_dpts row_stride col_stride dpt_stride
  in
  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in
  let input' = empty (kind input) (shape input) in

  _owl_cuboid_avg_pooling_backward (kind input)
    input' output'
    batches input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts
    col_stride row_stride dpt_stride
    pad_typ;

  input'


let avg_pool3d_backward_ ~out padding input kernel stride output' =
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
    Owl_utils_infer_shape.calc_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols kernel_rows kernel_dpts row_stride col_stride dpt_stride
  in
  let pad_typ = match padding with SAME -> 0 | VALID -> 1 in

  _owl_cuboid_avg_pooling_backward (kind input)
    out output'
    batches input_cols input_rows input_dpts in_channel
    kernel_cols kernel_rows kernel_dpts
    output_cols output_rows output_dpts
    col_stride row_stride dpt_stride
    pad_typ


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
    Owl_utils_infer_shape.calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  let pad_top, pad_left, _, _ =
    Owl_utils_infer_shape.calc_conv2d_padding input_cols input_rows kernel_cols kernel_rows output_cols output_rows row_stride col_stride
  in
  let input' = empty (kind input) (shape input) in

  _owl_spatial_avg_pooling_backward (kind input)
    input' output'
    batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride pad_top pad_left;

  input'


let avg_pool2d_backward_ ~out padding input kernel stride output' =
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
    Owl_utils_infer_shape.calc_conv2d_output_shape padding input_cols input_rows kernel_cols kernel_rows row_stride col_stride
  in
  let pad_top, pad_left, _, _ =
    Owl_utils_infer_shape.calc_conv2d_padding input_cols input_rows kernel_cols kernel_rows output_cols output_rows row_stride col_stride
  in

  _owl_spatial_avg_pooling_backward (kind input)
    out output'
    batches input_cols input_rows in_channel
    kernel_cols kernel_rows output_cols output_rows
    row_stride col_stride pad_top pad_left


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


let avg_pool1d_backward_ ~out padding input kernel stride output' =
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

  avg_pool2d_backward_ ~out padding input kernel stride output'


let _diff a x =
  let _stride = strides x in
  let _slicez = slice_size x in
  let m = (numel x) / _slicez.(a) in
  let n = _slicez.(a) - _stride.(a) in
  let incx_m = _slicez.(a) in
  let incx_n = 1 in
  let incy_m = _slicez.(a) - _stride.(a) in
  let incy_n = 1 in
  let ofsx = _stride.(a) in
  let ofsy = 0 in

  let k = kind x in
  let s = shape x in
  s.(a) <- s.(a) - 1;
  let y = empty k s in
  _owl_diff k m n x ofsx incx_m incx_n y ofsy incy_m incy_n;
  y


let diff ?(axis=(-1)) ?(n=1) x =
  let d = num_dims x in
  let a = Owl_utils.adjust_index axis d in
  assert (n < nth_dim x a);
  let y = ref x in
  for i = 1 to n do
    y := _diff a !y
  done;
  !y


let one_hot depth idx =
  let sx = shape idx in
  let sy = Array.append sx [|depth|] in
  let k = kind idx in
  let n = numel idx in
  let y = zeros (kind idx) sy in
  _owl_one_hot k n ~ofsx:0 ~incx:1 ~ofsy:0 ~incy:depth idx y;
  y


let one_hot_ ~out depth idx =
  let k = kind idx in
  let n = numel idx in
  reset out;
  _owl_one_hot k n ~ofsx:0 ~incx:1 ~ofsy:0 ~incy:depth idx out



(* TODO: optimise performance, slow along the low dimension *)
let cumulative_op ?(axis=(-1)) _cumop x y =
  let d = num_dims x in
  let a = Owl_utils.adjust_index axis d in

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

  _cumop m n x ofsx incx_m incx_n y ofsy incy_m incy_n


let cumsum ?axis x =
  let x = copy x in
  let _cumop = _owl_cumsum (kind x) in
  cumulative_op ?axis _cumop x x;
  x


let cumprod ?axis x =
  let x = copy x in
  let _cumop = _owl_cumprod (kind x) in
  cumulative_op ?axis _cumop x x;
  x


let cummin ?axis x =
  let x = copy x in
  let _cumop = _owl_cummin (kind x) in
  cumulative_op ?axis _cumop x x;
  x


let cummax ?axis x =
  let x = copy x in
  let _cumop = _owl_cummax (kind x) in
  cumulative_op ?axis _cumop x x;
  x


let modf x =
  let x = copy x in
  let y = empty (kind x) (shape x) in
  (* the last parameter zero is just a dummy parameter *)
  _owl_modf (kind x) (numel x) x y (Owl_const.zero (kind x));
  x, y


let sub_ndarray parts x =
  let n = Array.fold_left (+) 0 parts in
  assert (n = (shape x).(0));
  let m = Array.length parts in
  let ofs = ref (-parts.(0)) in

  Array.init m (fun i ->
    ofs := !ofs + parts.(i);
    sub_left x !ofs parts.(i)
  )


let split ?(axis=0) parts x =
  let x_shp = shape x in
  let x_dim = num_dims x in
  let _d = Array.fold_left ( + ) 0 parts in

  let a = Owl_utils.adjust_index axis _d in
  assert (a < x_dim);
  assert (_d = x_shp.(a));

  let _pos = ref 0 in
  let slices = Array.map (fun d ->
    let s_def = Array.make x_dim (R_ [||]) in
    s_def.(a) <- R_ [|!_pos; !_pos + d - 1|];
    _pos := !_pos + d;
    Owl_slicing.get_slice_array_typ s_def x
  ) parts
  in
  slices


let split_vh parts x =
  assert (num_dims x >= 2);
  let parts_a0 = Array.map (fun p -> fst p.(0)) parts in
  Array.mapi (fun i part ->
    let parts_a1 = Array.map snd parts.(i) in
    split ~axis:1 parts_a1 part
  ) (sub_ndarray parts_a0 x)


let sum' x = _owl_sum (kind x) (numel x) x


let prod' x = _owl_prod (kind x) (numel x) x


(* TODO: performance can be optimised by removing embedded loops *)
(* generic fold funtion *)
let foldi ?axis f a x =
  let x' = flatten x |> array1_of_genarray in
  match axis with
  | Some axis -> (
      let m, n, o, s = Owl_utils.reduce_params axis x in
      let start_x = ref 0 in
      let start_y = ref 0 in
      let incy = ref 0 in
      let k = ref 0 in

      let y = create (kind x) s a in
      let y' = flatten y |> array1_of_genarray in

      for i = 0 to m - 1 do
        for j = 0 to n - 1 do
          let b = Array1.unsafe_get y' (!start_y + !incy) in
          let c = Array1.unsafe_get x' (!start_x + j) in
          Array1.unsafe_set y' (!start_y + !incy) (f !k b c);
          if !incy + 1 = o then incy := 0
          else incy := !incy + 1;
          k := !k + 1;
        done;
        start_x := !start_x + n;
        start_y := !start_y + o;
      done;
      y
    )
  | None   -> (
      let b = ref a in
      for i = 0 to (numel x) - 1 do
        let c = Array1.unsafe_get x' i in
        b := f i !b c
      done;
      create (kind x) [|1|] !b
    )


let fold ?axis f a x = foldi ?axis (fun _ b c ->  f b c) a x


let foldi_nd ?axis f a x =
  foldi ?axis (fun i b c ->  f (Owl_utils.ind x i) b c) a x


(* generic scan function *)
let scani ?(axis=(-1)) f x =
  let d = num_dims x in
  let a = Owl_utils.adjust_index axis d in

  let _stride = strides x in
  let _slicez = slice_size x in
  let m = (numel x) / _slicez.(a) in
  let n = _slicez.(a) - _stride.(a) in
  let incx = _slicez.(a) in
  let incy = _slicez.(a) in
  let start_x = ref 0 in
  let start_y = ref _stride.(a) in
  let k = ref 0 in

  let y = copy x in
  let y' = flatten y |> array1_of_genarray in

  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      let b = Array1.unsafe_get y' (!start_x + j) in
      let c = Array1.unsafe_get y' (!start_y + j) in
      Array1.unsafe_set y' (!start_y + j) (f !k b c);
      k := !k + 1
    done;
    start_x := !start_x + incx;
    start_y := !start_y + incy;
  done;
  y


let scan ?axis f x = scani ?axis (fun _ a b -> f a b) x


let scani_nd ?axis f x =
  scani ?axis (fun i a b -> f (Owl_utils.ind x i) a b) x


let sum ?axis x =
  let _kind = kind x in
  match axis with
  | Some a -> (
      let m, n, o, s = Owl_utils.reduce_params a x in
      let y = zeros _kind s in
      _owl_sum_along _kind m n o x y;
      y
    )
  | None   -> _owl_sum _kind (numel x) x |> create _kind [|1|]


let sum_ ~out ~axis x =
  let _kind = kind x in
  let m, n, o, s = Owl_utils.reduce_params axis x in
  (* TODO: this can be optimised, only need to reset first slice actually. *)
  reset out;
  _owl_sum_along _kind m n o x out


let prod ?axis x =
  let _kind = kind x in
  match axis with
  | Some a -> (
      let m, n, o, s = Owl_utils.reduce_params a x in
      let y = ones _kind s in
      _owl_prod_along _kind m n o x y;
      y
    )
  | None   -> _owl_prod _kind (numel x) x |> create _kind [|1|]


let min ?axis x =
  let _kind = kind x in
  match axis with
  | Some a -> (
      let m, n, o, s = Owl_utils.reduce_params a x in
      let y = create _kind s (Owl_const.pos_inf _kind) in
      _owl_min_along _kind m n o x y;
      y
    )
  | None   -> min' x |> create _kind [|1|]


let min_ ~out ~axis x =
  let _kind = kind x in
  let m, n, o, s = Owl_utils.reduce_params axis x in
  (* TODO: this can be optimised, only need to reset first slice actually. *)
  fill out (Owl_const.pos_inf _kind);
  _owl_min_along _kind m n o x out


let max ?axis x =
  let _kind = kind x in
  match axis with
  | Some a -> (
      let m, n, o, s = Owl_utils.reduce_params a x in
      let y = create _kind s (Owl_const.neg_inf _kind) in
      _owl_max_along _kind m n o x y;
      y
    )
  | None   -> max' x |> create _kind [|1|]


let max_ ~out ~axis x =
  let _kind = kind x in
  let m, n, o, s = Owl_utils.reduce_params axis x in
  (* TODO: this can be optimised, only need to reset first slice actually. *)
  fill out (Owl_const.neg_inf _kind);
  _owl_max_along _kind m n o x out


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
      let a = Owl_utils.adjust_index a (num_dims x) in
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
      let a = Owl_utils.adjust_index a (num_dims x) in
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
      let m, n, o, s = Owl_utils.reduce_params a x in
      let y = zeros _kind s in
      _owl_l1norm_along _kind m n o x y;
      y
    )
  | None   -> l1norm' x |> create _kind [|1|]


let l2norm_sqr ?axis x =
  let _kind = kind x in
  match axis with
  | Some a -> (
      let m, n, o, s = Owl_utils.reduce_params a x in
      let y = zeros _kind s in
      _owl_l2norm_sqr_along _kind m n o x y;
      y
    )
  | None   -> l2norm_sqr' x |> create _kind [|1|]


let l2norm ?axis x =
  let _kind = kind x in
  match axis with
  | Some a -> (
      let m, n, o, s = Owl_utils.reduce_params a x in
      let y = zeros _kind s in
      _owl_l2norm_sqr_along _kind m n o x y;
      _owl_sqrt _kind (numel y) y y;
      y
    )
  | None   -> l2norm' x |> create _kind [|1|]


let vecnorm ?axis ?(p=2.) x =
  if p = 1. then l1norm ?axis x
  else if p = 2. then l2norm ?axis x
  else (
    let y = abs x in
    if p = infinity then max ?axis y
    else if p = neg_infinity then min ?axis y
    else (
      let q = _float_typ_elt (kind x) (1. /. p) in
      let p = _float_typ_elt (kind x) p in
      let z = pow_scalar y p |> sum ?axis in
      pow_scalar z q
    )
  )


let vecnorm' ?p x =
  let y = vecnorm ?p x in
  get y [|0|]


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
    Owl_utils.index_1d_nd i j s;
    j
  ) idx


(* FIXME:
  the (<) and (>) functions needs to be changed for complex numbers, since
  Pervasives module may have different way to compare complex numbers.
 *)
let top x n = _search_close_to_extreme x n (Owl_const.neg_inf (kind x)) ( > )

let bottom x n = _search_close_to_extreme x n (Owl_const.pos_inf (kind x)) ( < )



(* fucntions which modify the data in-place, not so pure *)

let add_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_add (kind x) (numel x) x y out
  else (
    let so = Owl_utils_infer_shape.broadcast1 sx sy in
    assert (shape out = so);
    broadcast_op (_owl_broadcast_add (kind x)) x y ~out |> ignore
  )

let sub_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_sub (kind x) (numel x) x y out
  else (
    let so = Owl_utils_infer_shape.broadcast1 sx sy in
    assert (shape out = so);
    broadcast_op (_owl_broadcast_sub (kind x)) x y ~out |> ignore
  )

let mul_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_mul (kind x) (numel x) x y out
  else (
    let so = Owl_utils_infer_shape.broadcast1 sx sy in
    assert (shape out = so);
    broadcast_op (_owl_broadcast_mul (kind x)) x y ~out |> ignore
  )

let div_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_div (kind x) (numel x) x y out
  else (
    let so = Owl_utils_infer_shape.broadcast1 sx sy in
    assert (shape out = so);
    broadcast_op (_owl_broadcast_div (kind x)) x y ~out |> ignore
  )

let pow_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_pow (kind x) (numel x) x y out
  else (
    let so = Owl_utils_infer_shape.broadcast1 sx sy in
    assert (shape out = so);
    broadcast_op (_owl_broadcast_pow (kind x)) x y ~out |> ignore
  )

let atan2_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_atan2 (kind x) (numel x) x y out
  else (
    let so = Owl_utils_infer_shape.broadcast1 sx sy in
    assert (shape out = so);
    broadcast_op (_owl_broadcast_atan2 (kind x)) x y ~out |> ignore
  )

let hypot_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_hypot (kind x) (numel x) x y out
  else (
    let so = Owl_utils_infer_shape.broadcast1 sx sy in
    assert (shape out = so);
    broadcast_op (_owl_broadcast_hypot (kind x)) x y ~out |> ignore
  )

let fmod_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_fmod (kind x) (numel x) x y out
  else (
    let so = Owl_utils_infer_shape.broadcast1 sx sy in
    assert (shape out = so);
    broadcast_op (_owl_broadcast_fmod (kind x)) x y ~out |> ignore
  )

let min2_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_min2 (kind x) (numel x) x y out
  else (
    let so = Owl_utils_infer_shape.broadcast1 sx sy in
    assert (shape out = so);
    broadcast_op (_owl_broadcast_min2 (kind x)) x y ~out |> ignore
  )

let max2_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_max2 (kind x) (numel x) x y out
  else (
    let so = Owl_utils_infer_shape.broadcast1 sx sy in
    assert (shape out = so);
    broadcast_op (_owl_broadcast_max2 (kind x)) x y ~out |> ignore
  )

let elt_equal_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_elt_equal (kind x) (numel x) x y out
  else (
    let so = Owl_utils_infer_shape.broadcast1 sx sy in
    assert (shape out = so);
    broadcast_op (_owl_broadcast_elt_equal (kind x)) x y ~out |> ignore
  )

let elt_not_equal_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_elt_not_equal (kind x) (numel x) x y out
  else (
    let so = Owl_utils_infer_shape.broadcast1 sx sy in
    assert (shape out = so);
    broadcast_op (_owl_broadcast_elt_not_equal (kind x)) x y ~out |> ignore
  )

let elt_less_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_elt_less (kind x) (numel x) x y out
  else (
    let so = Owl_utils_infer_shape.broadcast1 sx sy in
    assert (shape out = so);
    broadcast_op (_owl_broadcast_elt_less (kind x)) x y ~out |> ignore
  )

let elt_greater_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_elt_greater (kind x) (numel x) x y out
  else (
    let so = Owl_utils_infer_shape.broadcast1 sx sy in
    assert (shape out = so);
    broadcast_op (_owl_broadcast_elt_greater (kind x)) x y ~out |> ignore
  )

let elt_less_equal_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_elt_less_equal (kind x) (numel x) x y out
  else (
    let so = Owl_utils_infer_shape.broadcast1 sx sy in
    assert (shape out = so);
    broadcast_op (_owl_broadcast_elt_less_equal (kind x)) x y ~out |> ignore
  )

let elt_greater_equal_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let sx = shape x in
  let sy = shape y in
  if sx = sy then _owl_elt_equal (kind x) (numel x) x y x
  else (
    let so = Owl_utils_infer_shape.broadcast1 sx sy in
    assert (shape out = so);
    broadcast_op (_owl_broadcast_elt_greater_equal (kind x)) x y ~out |> ignore
  )

let elt_equal_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  _owl_elt_equal_scalar (kind x) (numel x) x out a

let elt_not_equal_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  _owl_elt_not_equal_scalar (kind x) (numel x) x out a

let elt_less_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  _owl_elt_less_scalar (kind x) (numel x) x out a

let elt_greater_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  _owl_elt_greater_scalar (kind x) (numel x) x out a

let elt_less_equal_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  _owl_elt_less_equal_scalar (kind x) (numel x) x out a

let elt_greater_equal_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  _owl_elt_greater_equal_scalar (kind x) (numel x) x out a

let add_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  _owl_add_scalar (kind x) (numel x) x out a

let sub_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  add_scalar_ ~out x (_neg_elt (kind x) a)

let mul_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  _owl_mul_scalar (kind x) (numel x) x out a

let div_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  _owl_div_scalar (kind x) (numel x) x out a

let pow_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  _owl_pow_scalar (kind x) (numel x) x out a

let atan2_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  _owl_atan2_scalar (kind x) (numel x) x out a

let fmod_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  _owl_fmod_scalar (kind x) (numel x) x out a

let scalar_add_ ?out a x =
  let out = match out with Some o -> o | None -> x in
  _owl_add_scalar (kind x) (numel x) x out a

let scalar_sub_ ?out a x =
  let out = match out with Some o -> o | None -> x in
  _owl_scalar_sub (kind x) (numel x) x out a

let scalar_mul_ ?out a x =
  let out = match out with Some o -> o | None -> x in
  _owl_mul_scalar (kind x) (numel x) x out a

let scalar_div_ ?out a x =
  let out = match out with Some o -> o | None -> x in
  _owl_scalar_div (kind x) (numel x) x out a

let scalar_pow_ ?out a x =
  let out = match out with Some o -> o | None -> x in
  _owl_scalar_pow (kind x) (numel x) x out a

let scalar_atan2_ ?out a x =
  let out = match out with Some o -> o | None -> x in
  _owl_scalar_atan2 (kind x) (numel x) x out a

let scalar_fmod_ ?out a x =
  let out = match out with Some o -> o | None -> x in
  _owl_scalar_fmod (kind x) (numel x) x out a

let conj_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_conj (kind x) (numel x) x out

let abs_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_abs (kind x) (numel x) x out

let neg_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_neg (kind x) (numel x) x out

let reci_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_reci (kind x) (numel x) x out

let signum_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_signum (kind x) (numel x) x out

let sqr_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_sqr (kind x) (numel x) x out

let sqrt_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_sqrt (kind x) (numel x) x out

let cbrt_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_cbrt (kind x) (numel x) x out

let exp_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_exp (kind x) (numel x) x out

let exp2_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_exp2 (kind x) (numel x) x out

let exp10_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_exp10 (kind x) (numel x) x out

let expm1_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_expm1 (kind x) (numel x) x out

let log_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_log (kind x) (numel x) x out

let log2_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_log2 (kind x) (numel x) x out

let log10_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_log10 (kind x) (numel x) x out

let log1p_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_log1p (kind x) (numel x) x out

let sin_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_sin (kind x) (numel x) x out

let cos_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_cos (kind x) (numel x) x out

let tan_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_tan (kind x) (numel x) x out

let asin_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_asin (kind x) (numel x) x out

let acos_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_acos (kind x) (numel x) x out

let atan_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_atan (kind x) (numel x) x out

let sinh_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_sinh (kind x) (numel x) x out

let cosh_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_cosh (kind x) (numel x) x out

let tanh_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_tanh (kind x) (numel x) x out

let asinh_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_asinh (kind x) (numel x) x out

let acosh_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_acosh (kind x) (numel x) x out

let atanh_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_atanh (kind x) (numel x) x out

let floor_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_floor (kind x) (numel x) x out

let ceil_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_ceil (kind x) (numel x) x out

let round_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_round (kind x) (numel x) x out

let trunc_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_trunc (kind x) (numel x) x out

let fix_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_fix (kind x) (numel x) x out

let erf_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_erf (kind x) (numel x) x out

let erfc_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_erfc (kind x) (numel x) x out

let relu_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_relu (kind x) (numel x) x out

let softplus_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_softplus (kind x) (numel x) x out

let softsign_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_softsign (kind x) (numel x) x out

let sigmoid_ ?out x =
  let out = match out with Some o -> o | None -> x in
  _owl_sigmoid (kind x) (numel x) x out

let softmax ?(axis=(-1)) x =
  let x = copy x in
  let axis = Owl_utils.adjust_index axis (num_dims x) in
  sub_ ~out:x x (max ~axis x);
  exp_ ~out:x x;
  let a = sum ~axis x in
  div_ ~out:x x a;
  x

let softmax_ ?out ?(axis=(-1)) x =
  let out = match out with Some o -> o | None -> x in
  let axis = Owl_utils.adjust_index axis (num_dims x) in
  sub_ ~out x (max ~axis x);
  exp_ ~out x;
  let a = sum ~axis x in
  div_ ~out x a

let cumsum_ ?out ?axis x =
  let out = match out with Some o -> o | None -> x in
  let _cumop = _owl_cumsum (kind x) in
  cumulative_op ?axis _cumop x out

let cumprod_ ?out ?axis x =
  let out = match out with Some o -> o | None -> x in
  let _cumop = _owl_cumprod (kind x) in
  cumulative_op ?axis _cumop x out

let cummin_ ?out ?axis x =
  let out = match out with Some o -> o | None -> x in
  let _cumop = _owl_cummin (kind x) in
  cumulative_op ?axis _cumop x out

let cummax_ ?out ?axis x =
  let out = match out with Some o -> o | None -> x in
  let _cumop = _owl_cummax (kind x) in
  cumulative_op ?axis _cumop x out

let cross_entropy' x y =
  let y = copy y in
  log_ ~out:y y;
  mul_ ~out:y y x;
  _neg_elt (kind y) (sum' y)

let dropout_ ?out ?(rate=0.5) x =
  assert (rate >= 0. && rate <= 1.);
  let out = match out with Some o -> o | None -> x in
  if not (out == x) then copy_ ~out x;
  _owl_dropout (kind x) (numel x) out rate 0


let fused_adagrad_ ?out ~rate ~eps x =
  let out = match out with Some o -> o | None -> x in
  _owl_fused_adagrad (kind x) (numel x) rate eps x out


let clip_by_value_ ?out ?amin ?amax x =
  let out = match out with Some o -> o | None -> x in
  if same_data out x = false then copy_ ~out x;
  let k = kind x in
  let amin = match amin with
    | Some a -> a
    | None   -> Owl_const.neg_inf k
  in
  let amax = match amax with
    | Some a -> a
    | None   -> Owl_const.pos_inf k
  in
  _owl_clip_by_value k (numel x) amin amax out


let clip_by_value ?amin ?amax x =
  let out = copy x in
  clip_by_value_ ~out ?amin ?amax out;
  out


let clip_by_l2norm_ ?out t x =
  let out = match out with Some o -> o | None -> x in
  let a = l2norm' x in
  if a > t then (
    let b = _div_elt (kind x) t a in
    mul_scalar_ ~out x b
  )
  else (
    if same_data out x = false then copy_ ~out x
  )


let clip_by_l2norm t x =
  let out = copy x in
  clip_by_l2norm_ ~out t out;
  out


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
  let i = Owl_utils.adjust_index i m in
  let y = Bigarray.Genarray.slice_left x [|i|] in
  reshape y [|1;n|]


let col x j =
  let m, n = _matrix_shape x in
  let j = Owl_utils.adjust_index j n in
  let _kind = kind x in
  let y = empty _kind [|m;1|] in
  _owl_copy _kind m ~ofsx:j ~incx:n ~ofsy:0 ~incy:1 x y;
  y


let copy_row_to v x i =
  let u = row x i in
  copy_ ~out:u v


let copy_col_to v x i =
  let r1 = area_of v in
  let r2 = area_of_col x i in
  copy_area_to v r1 x r2


(* NOTE: same implementaton code as that in Owl_linalg_generic *)
let dot x1 x2 =
  let m, k = _matrix_shape x1 in
  let l, n = _matrix_shape x2 in
  assert (k = l);

  let _kind = kind x1 in
  let alpha = Owl_const.one _kind in
  let beta = Owl_const.zero _kind in
  let x3 = empty _kind [|m; n|] in
  let a = flatten x1 |> Bigarray.array1_of_genarray in
  let b = flatten x2 |> Bigarray.array1_of_genarray in
  let c = flatten x3 |> Bigarray.array1_of_genarray in

  let layout = Owl_cblas_basic.CblasRowMajor in
  let transa = Owl_cblas_basic.CblasNoTrans in
  let transb = Owl_cblas_basic.CblasNoTrans in
  Owl_cblas_basic.gemm layout transa transb m n k alpha a k b n beta c n;
  x3


let dot_ ?(transa=false) ?(transb=false) ?alpha ?beta ~c a b =
  Owl_cblas.gemm ~transa ~transb ?alpha ?beta ~a ~b ~c


let eye k n =
  let x = zeros k [|n;n|] in
  let y = Bigarray.array2_of_genarray x in
  let a = Owl_const.one k in
  for i = 0 to n - 1 do
    Bigarray.Array2.unsafe_set y i i a
  done;
  x


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


let of_arrays k x = Array2.of_array k C_layout x |> genarray_of_array2


let to_arrays x =
  let s = shape x in
  let m = s.(0) in
  let n = s.(1) in
  let a0 = Owl_const.zero (kind x) in
  let x = array2_of_genarray x in
  let y = Array.init m (fun _ -> Array.make n a0) in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      y.(i).(j) <- x.{i,j}
    done
  done;
  y


let rows x l =
  let m, n = Array.length l, col_num x in
  let y = empty (kind x) [|m;n|] in
  Array.iteri (fun i j ->
    copy_row_to (row x j) y i
  ) l;
  y


let cols x l =
  let m, n = _matrix_shape x in
  let nl = Array.length l in
  let _kind = kind x in
  let y = empty _kind [|m;nl|] in
  Array.iteri (fun i j ->
    let j = Owl_utils.adjust_index j n in
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


(*
  simiar to sum_rows in matrix, sum all the slices along an axis.
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
  let n = (Owl_utils.calc_slice s).(axis) in
  let m = (numel x) / n in
  let y = reshape x [|m;n|] in
  (* create a row vector of all ones *)
  let v = ones (kind x) [|1;m|] in
  (* sum all the rows using gemm operation *)
  let y = dot v y in
  (* reshape back into ndarray *)
  let s = Array.(sub s axis (length s - axis)) in
  reshape y s


(*
  Simiar to ``sum``, but sums the elements along multiple axes specified in an
  array. E.g., for [x] of [|2;3;4;5|], [sum_reduce ~axis:[|1;3|] x] returns an
  ndarray of shape [|2;1;4;1|]; if axis not specified, it returns an ndarray of
  shape [|1;1;1;1|].
 *)
let sum_reduce ?axis x =
  let _kind = kind x in
  let _dims = num_dims x in
  match axis with
  | Some a -> (
      let x_shape = shape x in
      let dims' = Owl_utils.squeeze_continuous_dims x_shape a in
      if Array.length dims' = 1 then (
        _owl_sum _kind (numel x) x |> create _kind (Array.make _dims 1)
      )
      else (
        (* TODO: optimise with C implementation *)
        let y = ref (reshape x dims') in
        let flag = ref (Array.mem 0 a) in
        for i = 0 to Array.length dims' - 1 do
          if !flag = true then (
            let m, n, o, s = Owl_utils.reduce_params i !y in
            let z = zeros _kind s in
            _owl_sum_along _kind m n o !y z;
            y := z
          );
          flag := not !flag
        done;
        let y_shape = Array.copy x_shape in
        Array.iter (fun j -> y_shape.(j) <- 1) a;
        reshape !y y_shape
      )
    )
  | None   ->
      _owl_sum _kind (numel x) x |> create _kind (Array.make _dims 1)


let slide ?(axis=(-1)) ?(ofs=0) ?(step=1) ~window x =
  let d = num_dims x in
  let a = if axis >= 0 then axis else d + axis in
  let sx = shape x in
  assert (a < d);
  assert (ofs + window <= sx.(a));

  let _stride = strides x in
  let _slicez = slice_size x in
  let m = (numel x) / _slicez.(a) in
  let n = (sx.(a) - ofs - window) / step + 1 in
  let o = _stride.(a) * window in
  let ofsx_m = _stride.(a) * ofs in
  let incx_m = _slicez.(a) in
  let incx_n = _stride.(a) * step in

  sx.(a) <- n * window;
  let y = empty (kind x) sx in
  let incy_m = (slice_size y).(a) in
  let incy_n = o in

  Owl_ndarray._ndarray_slide (kind x) x y m n o ofsx_m incx_m incx_n incy_m incy_n;
  let sy = Owl_utils.Array.replace a 1 sx [|n;window|] in
  reshape y sy


let draw ?(axis=0) x n =
  let axis = Owl_utils.adjust_index axis (num_dims x) in
  let b = nth_dim x axis in
  let indices = Array.init n (fun _ -> Owl_stats.uniform_int_rvs ~a:0 ~b:(b-1)) in
  let slice = Array.init (num_dims x) (fun i -> if i = axis then L_ indices else R_ [||]) in
  let samples = Owl_slicing.get_fancy_array_typ slice x in
  samples, indices


let _contract1_check_indices idx x =
  let s = shape x in
  let n = num_dims x in
  Array.for_all (fun (i,j) ->
    (i >= 0 && i < n && j >= 0 && j < n) && (s.(i) = s.(j) && i <> j)
  ) idx


let contract1 index_pairs x =
  let d = num_dims x in
  assert (d > 1);
  assert (_contract1_check_indices index_pairs x);

  let permut_1 = Owl_utils.Array.of_tuples index_pairs in
  let permut_0 = Owl_utils.Array.(complement (range 0 (d - 1)) permut_1) in
  let permut = Owl_utils.Array.(permut_0 @ permut_1) in

  let s0 = shape x in
  let i0 = strides x in
  let sa = Array.copy s0 in
  Owl_utils.Array.set_n sa permut_1 1;
  let ia = Owl_utils.calc_stride sa in

  let s1 = Owl_utils.Array.permute permut s0 in
  let i1 = Owl_utils.Array.permute permut i0 in
  let sb = Owl_utils.Array.permute permut sa in
  let ib = Owl_utils.Array.permute permut ia in

  let p = reshape x s1 in
  let q = zeros (kind x) sb in
  let incp = Array.map Int64.of_int i1 |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  let incq = Array.map Int64.of_int ib |> Array1.of_array int64 c_layout |> genarray_of_array1 in

  let rtd = d - (Array.length permut_1) in
  Owl_ndarray._ndarray_contract_one (kind x) p q incp incq (Int64.of_int rtd);
  reshape q (Array.sub sb 0 rtd)


let _contract2_check_indices idx x y =
  let sx = shape x in
  let nx = num_dims x in
  let sy = shape y in
  let ny = num_dims y in
  Array.for_all (fun (i,j) ->
    i >= 0 && i < nx && j >= 0 && j < ny && sx.(i) = sy.(j)
  ) idx


let contract2 index_pairs x y =
  assert (_contract2_check_indices index_pairs x y);

  let dx = num_dims x in
  let permut_x1 = Owl_utils.Array.map fst index_pairs in
  let permut_x0 = Owl_utils.Array.(complement (range 0 (dx - 1)) permut_x1) in
  let permut_x = Owl_utils.Array.(permut_x0 @ permut_x1) in
  let shpx = Owl_utils.Array.permute permut_x (shape x) in
  let incx = Owl_utils.Array.permute permut_x (strides x) in

  let dy = num_dims y in
  let permut_y1 = Owl_utils.Array.map snd index_pairs in
  let permut_y0 = Owl_utils.Array.(complement (range 0 (dy - 1)) permut_y1) in
  let permut_y = Owl_utils.Array.(permut_y0 @ permut_y1) in
  let shpy = Owl_utils.Array.permute permut_y (shape y) in
  let incy = Owl_utils.Array.permute permut_y (strides y) in

  let outer_nx = Array.length permut_x0 in
  let outer_ny = Array.length permut_y0 in
  let inner_nx = Array.length permut_x1 in
  let inner_ny = Array.length permut_y1 in
  assert (inner_nx = inner_ny);

  let shpz_x = Array.sub shpx 0 outer_nx in
  let shpz_y = Array.sub shpy 0 outer_ny in
  let shpz = Owl_utils.Array.(shpz_x @ shpz_y) in
  let z = zeros (kind x) shpz in

  let loop0 = Owl_utils.Array.(shpz @ (sub shpx outer_nx inner_nx)) in
  let incx0 = Owl_utils.Array.(insert incx (make outer_ny 0) outer_nx) in
  let incy0 = Owl_utils.Array.(insert incy (make outer_nx 0) 0) in
  let incz0 = Owl_utils.Array.(strides z @ (make inner_nx 0)) in
  let loop1 = Array.map Int64.of_int loop0 |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  let incx1 = Array.map Int64.of_int incx0 |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  let incy1 = Array.map Int64.of_int incy0 |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  let incz1 = Array.map Int64.of_int incz0 |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  let ndims = Array.length loop0 |> Int64.of_int in
  Owl_ndarray._ndarray_contract_two (kind x) x y z incx1 incy1 incz1 loop1 ndims;
  z


(* Helper functions *)

let float_to_elt x = x

let elt_to_float x = x


(* ends here *)
