(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray


(* convert an element of elt type to string *)
let elt_to_str : type a b. (a, b) kind -> (a -> string) = function
  | Char           -> fun v -> Printf.sprintf "%c" v
  | Nativeint      -> fun v -> Printf.sprintf "%nd" v
  | Int8_signed    -> fun v -> Printf.sprintf "%i" v
  | Int8_unsigned  -> fun v -> Printf.sprintf "%i" v
  | Int16_signed   -> fun v -> Printf.sprintf "%i" v
  | Int16_unsigned -> fun v -> Printf.sprintf "%i" v
  | Int            -> fun v -> Printf.sprintf "%i" v
  | Int32          -> fun v -> Printf.sprintf "%ld" v
  | Int64          -> fun v -> Printf.sprintf "%Ld" v
  | Float32        -> fun v -> Printf.sprintf "%G" v
  | Float64        -> fun v -> Printf.sprintf "%G" v
  | Complex32      -> fun v -> Printf.sprintf "(%G, %Gi)" Complex.(v.re) Complex.(v.im)
  | Complex64      -> fun v -> Printf.sprintf "(%G, %Gi)" Complex.(v.re) Complex.(v.im)


(* convert an element of string to elt type *)
let elt_of_str : type a b. (a, b) kind -> (string -> a) = function
  | Char           -> fun v -> Scanf.sscanf v "%c%!" (fun c -> c)
  | Nativeint      -> fun v -> Nativeint.of_string v
  | Int8_signed    -> fun v -> int_of_string v
  | Int8_unsigned  -> fun v -> int_of_string v
  | Int16_signed   -> fun v -> int_of_string v
  | Int16_unsigned -> fun v -> int_of_string v
  | Int            -> fun v -> int_of_string v
  | Int32          -> fun v -> Int32.of_string v
  | Int64          -> fun v -> Int64.of_string v
  | Float32        -> fun v -> float_of_string v
  | Float64        -> fun v -> float_of_string v
  | Complex32      -> fun v -> Scanf.sscanf v "(%f, %fi)%!" (fun re im -> {Complex.re; im})
  | Complex64      -> fun v -> Scanf.sscanf v "(%f, %fi)%!" (fun re im -> {Complex.re; im})


(* calculate the number of elements in an ndarray *)
let numel x = Array.fold_right (fun c a -> c * a) (Genarray.dims x) 1


(* calculate the stride of a ndarray, s is the shape.
  for [x] of shape [|2;3;4|], the return is [|12;4;1|]
 *)
let calc_stride s =
  let d = Array.length s in
  let r = Array.make d 1 in
  for i = 1 to d - 1 do
    r.(d - i - 1) <- s.(d - i) * r.(d - i)
  done;
  r


(* calculate the slice size in each dimension, s is the shape.
  for [x] of shape [|2;3;4|], the return is [|24;12;4|]
*)
let calc_slice s =
  let d = Array.length s in
  let r = Array.make d s.(d-1) in
  for i = d - 2 downto 0 do
    r.(i) <- s.(i) * r.(i+1)
  done;
  r


(* c layout index translation: 1d -> nd
  i is one-dimensional index;
  j is n-dimensional index;
  s is the stride.
  the space of j needs to be pre-allocated *)
let index_1d_nd i j s =
  j.(0) <- i / s.(0);
  for k = 1 to Array.length s - 1 do
    j.(k) <- (i mod s.(k - 1)) / s.(k);
  done


(* c layout index translation: nd -> 1d
  j is n-dimensional index;
  s is the stride. *)
let index_nd_1d j s =
  let i = ref 0 in
  Array.iteri (fun k a -> i := !i + (a * s.(k))) j;
  !i


(* given ndarray [x] and 1d index, return nd index. *)
let ind x i_1d =
  let shape = Genarray.dims x in
  let stride = calc_stride shape in
  let i_nd = Array.copy stride in
  index_1d_nd i_1d i_nd stride;
  i_nd


(* given ndarray [x] and nd index, return 1d index. *)
let i1d x i_nd =
  let shape = Genarray.dims x in
  let stride = calc_stride shape in
  index_nd_1d i_nd stride


(* Adjust the index according to the [0, m). m is the boundary, i can be negative. *)
let adjust_index i m =
  if i >= 0 && i < m then i
  else if i < 0 && i >= -m then i + m
  else raise Owl_exception.INDEX_OUT_OF_BOUND


(* prepare the parameters for reduce/fold operation, [a] is axis *)
let reduce_params a x =
  let d = Genarray.num_dims x in
  let a = adjust_index a d in

  let _shape = Genarray.dims x in
  let _stride = calc_stride _shape in
  let _slicez = calc_slice _shape in
  let m = (numel x) / _slicez.(a) in
  let n = _slicez.(a) in
  let o = _stride.(a) in
  _shape.(a) <- 1;
  m, n, o, _shape


(* check whether two shapes are broadcastable *)
let broadcastable s0 s1 =
  let sa, sb = Owl_utils_array.align `Left 1 s0 s1 in
  try (
    Array.iter2 (fun a b ->
      Owl_exception.(check (not(a <> 1 && b <> 1 && a <> b)) NOT_BROADCASTABLE);
    ) sa sb;
    true
  )
  with _exn -> false


(* ends here *)
