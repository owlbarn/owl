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

let sequential d =
  let n = _calc_numel_from_shape d in
  let data = Array.init n (fun i -> i) in
  make_arr d (_calc_stride d) data

let get x i = x.data.(_index_nd_1d i x.stride)

let set x i a = x.data.(_index_nd_1d i x.stride) <- a

let num_dims x = Array.length x.shape

let shape x = x.shape

let nth_dim x i = x.shape.(i)

let numel x = _calc_numel_from_shape x.shape

let sub_left = None

let slice_left = None

let copy src dst = None

let fill x a = x.data <- Array.(make (length x.data) a)

let reshape x d =
  let m = _calc_numel_from_shape x.shape in
  let n = _calc_numel_from_shape d in
  assert (m = n);
  make_arr d x.stride x.data

let flatten x = x.shape <- [|Array.length x.data|]

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
    f x.data.(i)
  done

let iteri f x =
  for i = 0 to (numel x) - 1 do
    f i x.data.(i)
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
    f x.data.(i) y.data.(i)
  done

let iter2i f x y =
  assert (x.shape = y.shape);
  for i = 0 to (numel x) - 1 do
    f i x.data.(i) y.data.(i)
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



(* ends here *)
