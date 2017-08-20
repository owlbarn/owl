(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_dense_common

(* type of slice definition *)

type index =
  | I of int       (* single index *)
  | L of int list  (* list of indices *)
  | R of int list  (* index range *)

type slice = index list

(* type of slice definition for internal use *)

type index_ =
  | I_ of int
  | L_ of int array
  | R_ of int array

type slice_ = index_ array


(* local functions, since we will not use ndarray_generic module *)
let empty kind d = Bigarray.Genarray.create kind Bigarray.c_layout d
let kind x = Bigarray.Genarray.kind x
let shape x = Bigarray.Genarray.dims x
let numel x = Array.fold_right (fun c a -> c * a) (shape x) 1


(* check the validity of the slice definition, also re-format slice definition,
  axis: slice definition;
  shp: shape of the original ndarray;
 *)
let check_slice_definition axis shp =
  let error_msg = "check_slice_definition: error" in
  let axis_len = Array.length axis in
  let shp_len = Array.length shp in
  if axis_len > shp_len then failwith error_msg;
  (* add missing definition on higher dimensions *)
  let axis =
    if axis_len < shp_len then
      let suffix = Array.make (shp_len - axis_len) (R_ [||]) in
      Array.append axis suffix
    else axis
  in
  (* re-format slice definition, note I_ will be replaced with L_ *)
  Array.map2 (fun i n ->
    match i with
    | I_ x -> L_ [|x|]
    | L_ x -> L_ x
    | R_ x -> (
        match Array.length x with
        | 0 -> R_ [|0;n-1;1|]
        | 1 -> (
            let a = if x.(0) >= 0 then x.(0) else n + x.(0) in
            if a >= n then failwith error_msg;
            L_ [|a|]
          )
        | 2 -> (
            let a = if x.(0) >= 0 then x.(0) else n + x.(0) in
            let b = if x.(1) >= 0 then x.(1) else n + x.(1) in
            let c = if a <= b then 1 else -1 in
            if a >= n || b >= n then failwith error_msg;
            R_ [|a;b;c|]
          )
        | 3 -> (
            let a = if x.(0) >= 0 then x.(0) else n + x.(0) in
            let b = if x.(1) >= 0 then x.(1) else n + x.(1) in
            let c = x.(2) in
            if a >= n || b >= n || c = 0 then failwith error_msg;
            if (a < b && c < 0) || (a > b && c > 0) then failwith error_msg;
            R_ [|a;b;c|]
          )
        | _ -> failwith error_msg
      )
  ) axis shp


(* calculate the minimum continuous block size and its corresponding dimension
  axis: slice definition;
  shp: shape of the original ndarray;
 *)
let calc_continuous_blksz axis shp =
  let slice_sz = _calc_slice shp in
  let ssz = ref 1 in
  let d = ref 0 in
  let _ = try
    for l = Array.length shp - 1 downto -1 do
      (* note: d is actually the corresponding dimension of continuous block
        plus one; also note the loop is down to -1 so the lowest dimension is
        also considered, in which case the whole array is copied. *)
      d := l + 1;
      if l < 0 then failwith "stop";
      match axis.(l) with
      | I_ x -> (
          (* this will never be reached since we already removed all [I_] in
            the previous [check_slice_definition] function. *)
        )
      | L_ x -> (
          if Array.length x <> shp.(l) then failwith "stop";
          Array.iteri (fun i j -> if i <> j then failwith "stop") x;
          ssz := slice_sz.(l)
        )
      | R_ x -> (
          if x.(0) = 0 && x.(1) = shp.(l) - 1 && x.(2) = 1 then
            ssz := slice_sz.(l)
          else failwith "stop"
        )
    done
  with exn -> ()
  in !d, !ssz


(* calculat the shape according the slice definition
  axis: slice definition
 *)
let calc_slice_shape axis =
  Array.map (function
    | I_ x -> 1
    | L_ x -> Array.length x
    | R_ x ->
        let a, b, c = x.(0), x.(1), x.(2) in
        Pervasives.(abs ((b - a) / c)) + 1
  ) axis


(* ends here *)
