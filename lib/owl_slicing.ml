(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_dense_common

type slice = int list list


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
      let suffix = Array.make (shp_len - axis_len) [||] in
      Array.append axis suffix
    else axis
  in
  Array.map2 (fun x n ->
    match Array.length x with
    | 0 -> [|0;n-1;1|]
    | 1 -> (
        let a = if x.(0) >= 0 then x.(0) else n + x.(0) in
        if a >= n then failwith error_msg;
        [|a;a;1|]
      )
    | 2 -> (
        let a = if x.(0) >= 0 then x.(0) else n + x.(0) in
        let b = if x.(1) >= 0 then x.(1) else n + x.(1) in
        let c = if a <= b then 1 else -1 in
        if a >= n || b >= n then failwith error_msg;
        [|a;b;c|]
      )
    | 3 -> (
        let a = if x.(0) >= 0 then x.(0) else n + x.(0) in
        let b = if x.(1) >= 0 then x.(1) else n + x.(1) in
        let c = x.(2) in
        if a >= n || b >= n || c = 0 then failwith error_msg;
        if a < b && c < 0 then failwith error_msg;
        [|a;b;c|]
      )
    | _ -> failwith error_msg
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
        plue one; also note the loop is down to -1 so the lowest dimension is
        also considered, in which case the whole array is copied. *)
      d := l + 1;
      if l < 0 then failwith "stop";
      let x = axis.(l) in
      if x.(0) = 0 && x.(1) = shp.(l) - 1 && x.(2) = 1 then
        ssz := slice_sz.(l)
      else failwith "stop"
    done
  with exn -> ()
  in !d, !ssz


(* calculat the shape according the slice definition
  axis: slice definition
 *)
let calc_slice_shape axis =
  Array.map (fun x ->
    let a, b, c = x.(0), x.(1), x.(2) in
    Pervasives.(abs ((b - a) / c)) + 1
  ) axis


(* recursively copy the continuous block, stop at its corresponding dimension d
   d: the corresponding dimension of continuous block + 1
   j: current dimension index
   i: current index of the data for copying
   l: lower bound of the index i
   h: higher bound of the index i
   f: copy function of the continuous block
 *)
let rec __foreach_continuous_blk d j i l h s f =
  if j = d then f i
  else (
    let k = ref l.(j) in
    if s.(j) > 0 then (
      while !k <= h.(j)  do
        i.(j) <- !k;
        k := !k + s.(j);
        __foreach_continuous_blk d (j + 1) i l h s f
      done
    )
    else (
      while !k >= h.(j)  do
        i.(j) <- !k;
        k := !k + s.(j);
        __foreach_continuous_blk d (j + 1) i l h s f
      done
    )
  )


(* d0: the total dimension of the ndarray;
   d1: the corresponding dimension of the continuous block +1
   axis: slice definition
   f: the copy function for the continuous block
 *)
let _foreach_continuous_blk d0 d1 axis f =
  let i = Array.make d0 0 in
  let l = Array.make d0 0 in
  let h = Array.make d0 0 in
  let s = Array.make d0 0 in
  Array.iteri (fun j a ->
    l.(j) <- a.(0);
    h.(j) <- a.(1);
    s.(j) <- a.(2);
  ) axis;
  __foreach_continuous_blk d1 0 i l h s f


(* core slice function
  axis: int array array, slice definition, format [start;stop;step]
  x: ndarray
 *)
let slice_array_typ axis x =
  (* check axis is within boundary then re-format *)
  let s0 = shape x in
  let axis = check_slice_definition axis s0 in
  (* calculate the new shape for slice *)
  let s1 = calc_slice_shape axis in
  let y = empty (kind x) s1 in
  (* transform into 1d array *)
  let x' = Bigarray.reshape_1 x (numel x) in
  let y' = Bigarray.reshape_1 y (numel y) in
  (* prepare function of copying blocks *)
  let d0 = Array.length s1 in
  let d1, cb = calc_continuous_blksz axis s0 in
  let sd = _calc_stride s0 in
  let _cp_op = _owl_copy (kind x) in
  let ofsy_i = ref 0 in
  (* two copy strategy based on the size of the minimum continuous block *)
  match cb > 1 with
  | true  -> (
      (* yay, there are at least some continuous blocks *)
      let b = cb in
      let f = fun i -> (
        let ofsx = _index_nd_1d i sd in
        let ofsy = !ofsy_i * b in
        (* Printf.printf "%i %i\n" ofsx ofsy; *)
        let _ = _cp_op b ~ofsx ~ofsy ~incx:1 ~incy:1 x' y' in
        ofsy_i := !ofsy_i + 1
      )
      in
      (* start copying blocks *)
      _foreach_continuous_blk d0 d1 axis f;
      (* reshape the ndarray *)
      let z = Bigarray.genarray_of_array1 y' in
      let z = Bigarray.reshape z s1 in
      z
    )
  | false -> (
      (* copy happens at the highest dimension, no continuous block *)
      let b = s1.(d0 - 1) in
      let c = axis.(d0 - 1).(2) in
      let cx = if c > 0 then c else -c in
      let cy = if c > 0 then 1 else -1 in
      let dd =
        if c > 0 then axis.(d0 - 1).(0)
        (* do the math yourself, it is actually reduced from
          s0.(d0 - 1) + (b - 1) * c - (s0.(d0 - 1) - axis.(d0 - 1).(0) - 1) - 1
        *)
        else axis.(d0 - 1).(0) + (b - 1) * c
      in
      let f = fun i -> (
        let ofsx = _index_nd_1d i sd + dd in
        let ofsy = !ofsy_i * b in
        (* Printf.printf "%i %i\n" ofsx ofsy; *)
        let _ = _cp_op b ~ofsx ~ofsy ~incx:cx ~incy:cy x' y' in
        ofsy_i := !ofsy_i + 1
      )
      in
      (* start copying blocks *)
      _foreach_continuous_blk d0 (d1 - 1) axis f;
      (* reshape the ndarray *)
      let z = Bigarray.genarray_of_array1 y' in
      let z = Bigarray.reshape z s1 in
      z
    )


(* same as slice_array_typ function but take list type as slice definition *)
let slice_list_typ axis x = slice_array_typ (Owl_utils.llss2aarr axis) x


(* ends here *)
