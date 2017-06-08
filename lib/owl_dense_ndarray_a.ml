(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_dense_common

type 'a arr = {
  mutable shape  : int array;
  mutable stride : int array;
  mutable data   : 'a array;
}

let _calc_numel_from_shape s = Array.fold_left (fun a b -> a * b) 1 s

let make_arr shape stride data = {
  shape;
  stride;
  data;
}

let create d a =
  let n = _calc_numel_from_shape d in
  make_arr d (_calc_stride d) (Array.make n a)

let init d f =
  let n = _calc_numel_from_shape d in
  let data = Array.init n (fun i -> f i) in
  make_arr d (_calc_stride d) data

let init_nd d f =
  let n = _calc_numel_from_shape d in
  let j = Array.copy d in
  let s = _calc_stride d in
  let data = Array.init n (fun i ->
    Owl_dense_common._index_1d_nd i j s;
    f j;
  )
  in
  make_arr d (_calc_stride d) data

let sequential ?(a=0.) ?(step=1.) d =
  let n = _calc_numel_from_shape d in
  let a = ref (a -. step) in
  let data = Array.init n (fun _ ->
    a := !a +. step;
    !a
  ) in
  make_arr d (_calc_stride d) data

let zeros d = create d 0.

let ones d = create d 1.

let num_dims x = Array.length x.shape

let shape x = Array.copy x.shape

let nth_dim x i = x.shape.(i)

let numel x = _calc_numel_from_shape x.shape


let get x i = x.data.(_index_nd_1d i x.stride)

let set x i a = x.data.(_index_nd_1d i x.stride) <- a

let slice_left = None

let copy src dst =
  assert (src.shape = dst.shape);
  Array.blit src.data 0 dst.data 0 (numel src)

let fill x a = Array.fill x.data 0 (numel x) a

let reshape x d =
  let m = _calc_numel_from_shape x.shape in
  let n = _calc_numel_from_shape d in
  assert (m = n);
  make_arr d x.stride x.data

let flatten x = make_arr [|Array.length x.data|] [|1|] x.data

let clone x = {
  shape  = Array.copy x.shape;
  stride = Array.copy x.stride;
  data   = Array.copy x.data;
}

let same_shape x y = x.shape = y.shape

let sub_left x i =
  let i_len = Array.length i in
  let s_len = x.stride.(i_len - 1) in
  let pad_len = num_dims x - i_len in
  assert (pad_len > 0);
  let i = Owl_utils.array_pad `Right i 0 pad_len in
  let start_pos = _index_nd_1d i x.stride in
  let data_y = Array.sub x.data start_pos s_len in
  let shape_y = Array.sub x.shape i_len pad_len in
  let stride_y = Array.sub x.stride i_len pad_len in
  make_arr shape_y stride_y data_y

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

let reverse x =
  let y = clone x in
  Owl_utils.array_reverse y.data;
  y


(* iteration functions *)

let iter f x =
  for i = 0 to (numel x) - 1 do
    f x.data.(i) |> ignore
  done

let iteri f x =
  for i = 0 to (numel x) - 1 do
    f i x.data.(i) |> ignore
  done

let map f x =
  make_arr x.shape x.stride (
  Array.init (numel x) (fun i ->
    f x.data.(i)
  ))

let mapi f x =
  make_arr x.shape x.stride (
  Array.init (numel x) (fun i ->
    f i x.data.(i)
  ))

let iter2 f x y =
  assert (x.shape = y.shape);
  for i = 0 to (numel x) - 1 do
    f x.data.(i) y.data.(i) |> ignore
  done

let iter2i f x y =
  assert (x.shape = y.shape);
  for i = 0 to (numel x) - 1 do
    f i x.data.(i) y.data.(i) |> ignore
  done

let map2 f x y =
  assert (x.shape = y.shape);
  make_arr x.shape x.stride (
  Array.init (numel x) (fun i ->
    f x.data.(i) y.data.(i)
  ))

let map2i f x y =
  assert (x.shape = y.shape);
  make_arr x.shape x.stride (
  Array.init (numel x) (fun i ->
    f i x.data.(i) y.data.(i)
  ))

let exists f x = Array.exists f x.data

let not_exists f x = not (exists f x)

let for_all f x = Array.for_all f x.data


(* some comparison functions *)

let is_equal ?(cmp=Pervasives.compare) x y =
  assert (x.shape = y.shape);
  let r = ref true in
  try iter2 (fun a b ->
    if (cmp a b) <> 0 then (
      r := false;
      failwith "found";
    )
  ) x y; !r
  with Failure _ -> !r

let not_equal ?(cmp=Pervasives.compare) x y =
  assert (x.shape = y.shape);
  let r = ref true in
  try iter2 (fun a b ->
    if (cmp a b) = 0 then (
      r := false;
      failwith "found";
    )
  ) x y; !r
  with Failure _ -> !r

let greater ?(cmp=Pervasives.compare) x y =
  assert (x.shape = y.shape);
  let r = ref true in
  try iter2 (fun a b ->
    if (cmp a b) <> 1 then (
      r := false;
      failwith "found";
    )
  ) x y; !r
  with Failure _ -> !r

let less ?(cmp=Pervasives.compare) x y =
  assert (x.shape = y.shape);
  let r = ref true in
  try iter2 (fun a b ->
    if (cmp a b) <> (-1) then (
      r := false;
      failwith "found";
    )
  ) x y; !r
  with Failure _ -> !r

let greater_equal ?(cmp=Pervasives.compare) x y =
  assert (x.shape = y.shape);
  let r = ref true in
  try iter2 (fun a b ->
    if (cmp a b) = (-1) then (
      r := false;
      failwith "found";
    )
  ) x y; !r
  with Failure _ -> !r

let less_equal ?(cmp=Pervasives.compare) x y =
  assert (x.shape = y.shape);
  let r = ref true in
  try iter2 (fun a b ->
    if (cmp a b) = 1 then (
      r := false;
      failwith "found";
    )
  ) x y; !r
  with Failure _ -> !r

let elt_equal ?(cmp=Pervasives.compare) x y = map2 (fun a b -> cmp a b = 0) x y

let elt_not_equal ?(cmp=Pervasives.compare) x y = map2 (fun a b -> cmp a b <> 0) x y

let elt_greater ?(cmp=Pervasives.compare) x y = map2 (fun a b -> cmp a b = 1) x y

let elt_less ?(cmp=Pervasives.compare) x y = map2 (fun a b -> cmp a b = (-1)) x y

let elt_greater_equal ?(cmp=Pervasives.compare) x y = map2 (fun a b -> cmp a b <> (-1)) x y

let elt_less_equal ?(cmp=Pervasives.compare) x y = map2 (fun a b -> cmp a b <> 1) x y

let elt_equal_scalar ?(cmp=Pervasives.compare) x b = map (fun a -> cmp a b = 0) x

let elt_not_equal_scalar ?(cmp=Pervasives.compare) x b = map (fun a -> cmp a b <> 0) x

let elt_greater_scalar ?(cmp=Pervasives.compare) x b = map (fun a -> cmp a b = 1) x

let elt_less_scalar ?(cmp=Pervasives.compare) x b = map (fun a -> cmp a b = (-1)) x

let elt_greater_equal_scalar ?(cmp=Pervasives.compare) x b = map (fun a -> cmp a b <> (-1)) x

let elt_less_equal_scalar ?(cmp=Pervasives.compare) x b = map (fun a -> cmp a b <> 1) x


(* operational functions *)

let _check_transpose_axis axis d =
  assert (Array.length axis = d);
  let h = Hashtbl.create 16 in
  Array.iter (fun x ->
    assert (0 <= x && x < d);
    assert (Hashtbl.mem h x = false);
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
  let i = Array.make d 0 in
  let y = make_arr s1 (_calc_stride s1) (Array.copy x.data) in
  iteri (fun i_1d z ->
    Owl_dense_common._index_1d_nd i_1d i x.stride;
    Array.iteri (fun k j -> i'.(k) <- i.(j)) a;
    set y i' z
  ) x;
  y


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
  let y_data = Array.make (_calc_numel_from_shape shape0) xs.(0).data.(0) in
  let y = make_arr shape0 (_calc_stride shape0) y_data in
  (* flatten y then calculate the number of copies *)
  let z = y.data in
  let slice_sz = (_calc_slice shape0).(axis) in
  let m = numel y / slice_sz in
  let n = Array.length xs in
  (* flatten all the inputs and init the copy location *)
  let x_flt = Array.map (fun x -> x.data) xs in
  let x_ofs = Array.make n 0 in
  (* copy data in the flattened space *)
  let z_ofs = ref 0 in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      (* ignore(_cp_op step_sz.(j) ~ofsx:x_ofs.(j) ~incx:1 ~ofsy:!z_ofs ~incy:1 x_flt.(j) z); *)
      Array.blit x_flt.(j) x_ofs.(j) z !z_ofs step_sz.(j);
      x_ofs.(j) <- x_ofs.(j) + step_sz.(j);
      z_ofs := !z_ofs + step_sz.(j);
    done;
  done;
  (* all done, return the combined result *)
  y


(* input/output functions *)

let of_array x d = make_arr d (_calc_stride d) x

let to_array x = x.data



(* ends here *)
