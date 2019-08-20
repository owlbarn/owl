(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

module S = Stdlib


(* Functor of making a View module of given Ndarray module *)

module Make
  (A : Ndarray_Basic)
  = struct

  type t = {
    shape : int array;         (* shape of the view *)
    slice : int array array;   (* slice definition projected on original data *)
    ofstr : int array array;   (* [|offset; stride|] array of view projected on original data *)
    data  : A.arr;             (* original data object *)
    dvec  : A.arr;             (* one-dimensional vector of original data *)
  }


  (* calculate (offset, stride) from the [shape] of original data and [slice] *)
  let calc_ofstr shape slice =
    let dims = Array.length shape in
    let strides = Owl_utils.calc_stride shape in
    Array.init dims (fun i ->
      let offset = slice.(i).(0) * strides.(i) in
      let stride = strides.(i) * slice.(i).(2) in
      [|offset; stride|]
    )


  let make_view shape slice data = {
    shape;
    slice;
    ofstr = calc_ofstr (A.shape data) slice;
    data;
    dvec = A.reshape data [|A.numel data|];
  }


  (* check whether two views are equivalent *)
  let is_same_view x y = (x.data == y.data) && (x.slice = y.slice)


  (* core functions *)


  (* project slice s1 to to s0 on one dimension *)
  let project_slice_dim s0 s1 =
    let start_0, _stop_0, stride_0 = s0.(0), s0.(1), s0.(2) in
    let start_1, stop_1, stride_1 = s1.(0), s1.(1), s1.(2) in
    let start_2 = start_0 + start_1 * stride_0 in
    let stop_2 = start_0 + stop_1 * stride_0 in
    let stride_2 = stride_0 * stride_1 in
    [| start_2; stop_2; stride_2 |]


  (* project slice s1 to s0 on all dimensions *)
  let project_slice s0 s1 = Array.map2 project_slice_dim s0 s1


  (* project the index onto the slice on one dimension *)
  let project_index_dim s i =
    let start_, _stop_, stride_ = s.(0), s.(1), s.(2) in
    start_ + i * stride_


  (* project indices onto the slice on all dimensions *)
  let project_index s i = Array.map2 project_index_dim s i


  let of_arr x =
    let shape = A.shape x in
    let s0 = Array.(make (length shape)) (R_ [||]) in
    let s1 = Owl_base_slicing.check_slice_definition s0 shape
      |> Array.map (function R_ a -> a | _ -> failwith "owl_view:of_arr")
    in
    make_view shape s1 x


  let to_arr x =
    let slice = Array.(map (fun a -> to_list a) x.slice |> to_list) in
    A.get_slice slice x.data


  (* manipulation functions *)


  let shape x = x.shape

  let num_dims x = Array.length x.shape

  let nth_dim x i = x.shape.(i)

  let numel x = Array.fold_left ( * ) 1 x.shape


  let get x i =
    let i' = project_index x.slice i in
    A.get x.data i'


  let set x i a =
    let i' = project_index x.slice i in
    A.set x.data i' a


  let get_slice axis x =
    let s0 = Array.of_list axis |> Array.(map of_list) in
    let s1 = Array.map (fun a -> R_ a) s0 in
    let s1 = Owl_base_slicing.check_slice_definition s1 x.shape in
    let s2 = Array.map (function R_ a -> a | _ -> failwith "owl_view:of_arr") s1 in
    let slice = project_slice x.slice s2 in
    let shape = Owl_base_slicing.calc_slice_shape s1 in
    make_view shape slice x.data


  (* iteration functions *)


  (* iterate using 1d-index and x.dvec, fast *)
  let rec _iteri f x i dim =
    let offset = x.ofstr.(dim).(0) in
    let stride = x.ofstr.(dim).(1) in
    let i = [|i + offset|] in
    if dim = num_dims x - 1 then (
      for _j = 0 to x.shape.(dim) - 1 do
        f i (A.get x.dvec i);
        i.(0) <- i.(0) + stride;
      done
    )
    else (
      for _j = 0 to x.shape.(dim) - 1 do
        _iteri f x i.(0) (dim + 1);
        i.(0) <- i.(0) + stride;
      done
    )


  (* iterate using both 1d-index i and its adjusted 1d-index k *)
  let rec _iteri_adjusted f x i k dim =
    let offset = x.ofstr.(dim).(0) in
    let stride = x.ofstr.(dim).(1) in
    let i = [|i + offset|] in
    if dim = num_dims x - 1 then (
      for _j = 0 to x.shape.(dim) - 1 do
        f (i, !k) (A.get x.dvec i);
        i.(0) <- i.(0) + stride;
        k := !k + 1;
      done
    )
    else (
      for _j = 0 to x.shape.(dim) - 1 do
        _iteri_adjusted f x i.(0) k (dim + 1);
        i.(0) <- i.(0) + stride;
      done
    )


  (* iterate using nd-index and x.data, slow *)
  let rec _iteri_nd f x i dim =
    if dim = num_dims x - 1 then (
      for j = 0 to x.shape.(dim) - 1 do
        i.(dim) <- j;
        f i (get x i)
      done
    )
    else (
      for j = 0 to x.shape.(dim) - 1 do
        i.(dim) <- j;
        _iteri_nd f x i (dim + 1)
      done
    )


  let rec _iter2 f x y i_x i_y dim =
    let offset_x = x.ofstr.(dim).(0) in
    let stride_x = x.ofstr.(dim).(1) in
    let offset_y = y.ofstr.(dim).(0) in
    let stride_y = y.ofstr.(dim).(1) in
    let i_x = [|i_x + offset_x|] in
    let i_y = [|i_y + offset_y|] in
    if dim = num_dims x - 1 then (
      for _j = 0 to x.shape.(dim) - 1 do
        f i_x i_y (A.get x.dvec i_x) (A.get y.dvec i_y);
        i_x.(0) <- i_x.(0) + stride_x;
        i_y.(0) <- i_y.(0) + stride_y;
      done
    )
    else (
      for _j = 0 to x.shape.(dim) - 1 do
        _iter2 f x y i_x.(0) i_y.(0) (dim + 1);
        i_x.(0) <- i_x.(0) + stride_x;
        i_y.(0) <- i_y.(0) + stride_y;
      done
    )


  let iter f x = _iteri (fun _ a -> f a) x 0 0


  let iteri f x = _iteri_adjusted (fun (_i, k) a -> f k a) x 0 (ref 0) 0


  let iteri_nd f x = _iteri_nd f x (Array.make (num_dims x) 0) 0


  let map f x = _iteri (fun i a -> A.set x.dvec i (f a)) x 0 0


  let mapi f x = _iteri_adjusted (fun (i, k) a -> A.set x.dvec i (f k a)) x 0 (ref 0) 0


  let mapi_nd f x = iteri_nd (fun i a -> set x i (f i a)) x


  let _fold ?_axis _f _x = ()


  let iter2 f x y =
    assert (x.shape = y.shape);
    if is_same_view x y then
      _iteri (fun _ a -> f a a) x 0 0
    else
      _iter2 (fun _ _ a b -> f a b) x y 0 0 0


  let map2 f x y =
    assert (x.shape = y.shape);
    if is_same_view x y then
      _iteri (fun i a -> A.set x.dvec i (f a a)) x 0 0
    else
      _iter2 (fun _i j a b -> A.set y.dvec j (f a b)) x y 0 0 0


  let set_slice axis x y =
    let x = get_slice axis x in
    map2 (fun b _ -> b) y x


  (* Examination & Comparison *)

  let equal x y =
    let r = ref true in
    (
      try iter2 (fun a b -> assert (a = b)) x y
      with _exn -> r := false
    );
    !r


  let not_equal x y = not (equal x y)


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


end
