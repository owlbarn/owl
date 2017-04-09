(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_dense_common
open Owl_dense_ndarray_generic

type slice = int list list

let check_slice_definition axis shp =
  let error_msg = "check_slice_definition: index error" in
  if Array.length axis <> Array.length shp then failwith error_msg;
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
        if a >= n || b >= n then failwith error_msg;
        [|a;b;1|]
      )
    | 3 -> (
        let a = if x.(0) >= 0 then x.(0) else n + x.(0) in
        let b = if x.(1) >= 0 then x.(1) else n + x.(1) in
        let c = x.(2) in
        if a >= n || b >= n || c = 0 then failwith error_msg;
        [|a;b;c|]
      )
    | _ -> failwith error_msg
  ) axis shp

let calc_continuous_blksz axis shp =
  let slice_sz = _calc_slice shp in
  let stride_sz = _calc_slice shp in
  let ssz = ref 1 in
  let d = ref 0 in
  (try
    for l = Array.length shp - 1 downto 0 do
      d := l + 1;
      let x = axis.(l) in
      match Array.length x with
      | 0 -> ssz := slice_sz.(l)
      | 1 -> failwith "stop"
      | 2 -> (
          if x.(0) = 0 && x.(1) = shp.(l) - 1 then
            ssz := slice_sz.(l)
          else (
            let a = x.(1) - x.(0) in
            let a = if a > 0 then a else 1 in
            ssz := a * stride_sz.(l);
            failwith "stop"
          )
        )
      | 3 -> (
          if x.(0) = 0 && x.(1) = shp.(l) - 1 && x.(2) = 1 then
            ssz := slice_sz.(l)
          else failwith "stop"
        )
      | _ -> failwith "stop"
    done
  with exn -> ());
  !d, !ssz

let calc_slice_shape axis =
  Array.map (fun x ->
    let a, b, c = x.(0), x.(1), x.(2) in
    Pervasives.(abs ((b - a) / c)) + 1
  ) axis

let rec __foreach_continuous_blk d j i l h s f =
  if j = d then f i
  else (
    if s.(j) > 0 then (
      let k = ref l.(j) in
      while !k <= h.(j)  do
        i.(j) <- !k;
        k := !k + s.(j);
        __foreach_continuous_blk d (j + 1) i l h s f
      done
    )
    else (
      let k = ref l.(j) in
      while !k >= h.(j)  do
        i.(j) <- !k;
        k := !k + s.(j);
        __foreach_continuous_blk d (j + 1) i l h s f
      done
    )
  )

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

let slice_block axis x =
  let s0 = shape x in
  (* check axis is within boundary then normalise *)
  let axis = check_slice_definition axis s0 in
  let s1 = calc_slice_shape axis in
  let y = empty (kind x) s1 in
  (* transform into 1d array *)
  let x' = Bigarray.reshape_1 x (numel x) in
  let y' = Bigarray.reshape_1 y (numel y) in
  (* prepare function of copying blocks *)
  let d1, b = calc_continuous_blksz axis s0 in
  let s = _calc_stride s0 in
  let _cp_op = _owl_copy (kind x) in
  let ofsy_i = ref 0 in
  let f = fun i -> (
    let ofsx = _index_nd_1d i s in
    let ofsy = !ofsy_i * b in
    let _ = _cp_op b ~ofsy ~ofsx x' y' in
    ofsy_i := !ofsy_i + 1
  ) in
  (* start copying blocks *)
  _foreach_continuous_blk (Array.length s1) d1 axis f;
  (* reshape the ndarray *)
  let z = Bigarray.genarray_of_array1 y' in
  let z = Bigarray.reshape z s1 in
  z

let slice axis x =
  (* if block size is > 99 byte ... maybe another strategy *)
  let d, s = calc_continuous_blksz axis (shape x) in
  match s > 99 with
  | true  -> slice_block axis x
  | false -> slice_block axis x


(* ends here *)
