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



let of_array x d = make_arr d (_calc_stride d) x

let to_array x = x.data



(* ends here *)
