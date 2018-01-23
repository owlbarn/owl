(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types

open Owl_dense_common_types


(* local functions, since we will not use ndarray_generic module *)
let empty kind d = Bigarray.Genarray.create kind Bigarray.c_layout d
let kind x = Bigarray.Genarray.kind x
let shape x = Bigarray.Genarray.dims x
let numel x = Array.fold_right (fun c a -> c * a) (shape x) 1


(* convert from a list of slice definition to array for internal use *)
let sdlist_to_sdarray axis =
  List.map (function
    | I i -> I_ i
    | L i -> L_ (Array.of_list i)
    | R i -> R_ (Array.of_list i)
  ) axis
  |> Array.of_list


(* return true if slicing (all R_) or false if fancy indexing (has L_) *)
let is_basic_slicing = Array.for_all (function R_ _ -> true | _ -> false)


(* check the validity of the slice definition, also re-format slice definition,
   axis: slice definition;
   shp: shape of the original ndarray;
 *)
let check_slice_definition axis shp =
  let axis_len = Array.length axis in
  let shp_len = Array.length shp in
  assert (axis_len <= shp_len);
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
    | I_ x -> (
        let x = if x >= 0 then x else n + x in
        assert (x < n);
        R_ [|x;x;1|]
      )
    | L_ x -> (
        let is_cont = ref true in
        if Array.length x <> n then is_cont := false;
        let x = Array.mapi (fun i j ->
          let j = if j >= 0 then j else n + j in
          assert (j < n);
          if i <> j then is_cont := false;
          j
        ) x
        in
        if !is_cont = true then R_ [|0;n-1;1|] else L_ x
      )
    | R_ x -> (
        match Array.length x with
        | 0 -> R_ [|0;n-1;1|]
        | 1 -> (
            let a = if x.(0) >= 0 then x.(0) else n + x.(0) in
            assert (a < n);
            R_ [|a;a;1|]
          )
        | 2 -> (
            let a = if x.(0) >= 0 then x.(0) else n + x.(0) in
            let b = if x.(1) >= 0 then x.(1) else n + x.(1) in
            let c = if a <= b then 1 else -1 in
            assert (not (a >= n || b >= n));
            R_ [|a;b;c|]
          )
        | 3 -> (
            let a = if x.(0) >= 0 then x.(0) else n + x.(0) in
            let b = if x.(1) >= 0 then x.(1) else n + x.(1) in
            let c = x.(2) in
            assert (not (a >= n || b >= n || c = 0));
            assert (not ((a < b && c < 0) || (a > b && c > 0)));
            R_ [|a;b;c|]
          )
        | _ -> failwith "check_slice_definition: error"
      )
  ) axis shp


(* calculate the minimum continuous block size and its corresponding dimension
   axis: slice definition;
   shp: shape of the original ndarray;
 *)
let calc_continuous_blksz axis shp =
  let slice_sz = Owl_dense_common._calc_slice shp in
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
      | I_ x -> failwith "stop" (* never reached *)
      | L_ x -> failwith "stop"
      | R_ x -> (
          if x.(0) = 0 && x.(1) = shp.(l) - 1 && x.(2) = 1 then
            ssz := slice_sz.(l)
          else failwith "stop"
        )
    done
  with exn -> ()
  in !d, !ssz


(* calculat the shape according to the slice definition
   axis: slice definition
 *)
let calc_slice_shape axis =
  Array.map (function
    | I_ x -> 1 (* never reached *)
    | L_ x -> Array.length x
    | R_ x ->
        let a, b, c = x.(0), x.(1), x.(2) in
        Pervasives.(abs ((b - a) / c)) + 1
  ) axis


(* recursively copy the continuous block, stop at its corresponding dimension d
   a: slice definition
   d: the corresponding dimension of continuous block + 1
   j: current dimension index
   i: current index of the data for copying
   f: copy function of the continuous block
 *)
let rec __foreach_continuous_blk a d j i f =
  if j = d then f i
  else (
    match a.(j) with
    | I_ x -> ( (* never reache here *) )
    | L_ x -> (
        Array.iter (fun k ->
          i.(j) <- k;
          __foreach_continuous_blk a d (j + 1) i f
        ) x
      )
    | R_ x -> (
        let k = ref x.(0) in
        if x.(2) > 0 then (
          while !k <= x.(1)  do
            i.(j) <- !k;
            k := !k + x.(2);
            __foreach_continuous_blk a d (j + 1) i f
          done
        )
        else (
          while !k >= x.(1)  do
            i.(j) <- !k;
            k := !k + x.(2);
            __foreach_continuous_blk a d (j + 1) i f
          done
        )
      )
  )


(* a : slice definition, same rank as original ndarray
   d : the corresponding dimension of the continuous block +1
   f : the copy function for the continuous block
 *)
let _foreach_continuous_blk a d f =
  let i = Array.(make (length a) 0) in
  __foreach_continuous_blk a d 0 i f


(* reshape inputs in order to optimise the slicing performance *)
let optimise_input_shape axis x y =
  let n = Genarray.num_dims x in
  let sx = Genarray.dims x in
  let sy = Genarray.dims y in
  let dim = ref (n - 1) in
  let acx = ref 1 in
  let acy = ref 1 in
  (try
    for i = !dim downto 0 do
      match axis.(i) with
      | R_ a ->
          if a.(0) = 0 && a.(1) = sx.(i) - 1 && a.(2) = 1 then (
            acx := !acx * sx.(i);
            acy := !acy * sy.(i);
            dim := i;
          )
          else failwith "stop"
      | _    -> failwith "stop"
    done
  with exn -> ());
  if n - !dim > 1 then (
    (* can be optimised *)
    let axis' = Array.sub axis 0 (!dim + 1) in
    let sx' = Array.sub sx 0 (!dim + 1) in
    let sy' = Array.sub sy 0 (!dim + 1) in
    sx'.(!dim) <- !acx;
    sy'.(!dim) <- !acy;
    let x' = reshape x sx' in
    let y' = reshape y sy' in
    axis', x', y'
  )
  else
    (* cannot be optimised *)
    axis, x, y


(* core slice function
   axis: index array, slice definition, e.g., format [start;stop;step]
   x: ndarray
 *)
let get_slice_array_typ axis x =
  let _kind = kind x in
  (* check axis is within boundary then re-format *)
  let sx = shape x in
  let axis = check_slice_definition axis sx in
  (* calculate the new shape for slice *)
  let sy = calc_slice_shape axis in
  let y = empty _kind sy in
  (* optimise the shape if possible *)
  let axis', x', y' = optimise_input_shape axis x y in
  (* slicing vs. fancy indexing *)
  if is_basic_slicing axis = true then (
    Owl_slicing_basic.get _kind axis' x' y';
    y
  )
  else (
    Owl_slicing_fancy.get _kind axis' x' y';
    y
  )


(* set slice in [x] according to [y] *)
let set_slice_array_typ axis x y =
  let _kind = kind x in
  (* check axis is within boundary then re-format *)
  let sx = shape x in
  let axis = check_slice_definition axis sx in
  (* validate the slice shape is the same as y's *)
  let sy = calc_slice_shape axis in
  assert (shape y = sy);
  (* optimise the shape if possible *)
  let axis', x', y' = optimise_input_shape axis x y in
  (* slicing vs. fancy indexing *)
  if is_basic_slicing axis = true then
    Owl_slicing_basic.set _kind axis' x' y'
  else
    Owl_slicing_fancy.set _kind axis' x' y'


(* same as slice_array_typ function but take list type as slice definition *)
let get_slice_list_typ axis x = get_slice_array_typ (sdlist_to_sdarray axis) x


(* same as set_slice_array_typ function but take list type as slice definition *)
let set_slice_list_typ axis x y = set_slice_array_typ (sdlist_to_sdarray axis) x y


(* simplified get_slice function which accept list of list as slice definition *)
let get_slice_simple axis x =
  let axis = List.map (fun i -> R_ (Array.of_list i)) axis |> Array.of_list in
  get_slice_array_typ axis x


(* simplified set_slice function which accept list of list as slice definition *)
let set_slice_simple axis x y =
  let axis = List.map (fun i -> R_ (Array.of_list i)) axis |> Array.of_list in
  set_slice_array_typ axis x y



(* ends here *)
