(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

open Owl_dense_common


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
        assert (x < n);
        if n = 1 then R_ [|0;0;1|] else L_ [|x|]
      )
    | L_ x -> (
        let is_cont = ref true in
        if Array.length x <> n then is_cont := false;
        Array.iteri (fun i j ->
          assert (j < n);
          if i <> j then is_cont := false
        ) x;
        if !is_cont = true then R_ [|0;n-1;1|] else L_ x
      )
    | R_ x -> (
        match Array.length x with
        | 0 -> R_ [|0;n-1;1|]
        | 1 -> (
            let a = if x.(0) >= 0 then x.(0) else n + x.(0) in
            assert (a < n);
            if n = 1 then R_ [|0;0;1|] else L_ [|a|]
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


(* calculat the shape according the slice definition
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


(* core slice function
   axis: index array, slice definition, e.g., format [start;stop;step]
   x: ndarray
 *)
let get_slice_array_typ axis x =
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
  (* two copying strategies based on the size of the minimum continuous block.
     also, consider the special case wherein the highest-dimension equals to 1.
   *)
  let high_dim_list = (function L_ _ -> true | _ -> false) axis.(d0 - 1) in
  if cb > 1 || s0.(d0 - 1) = 1 || high_dim_list = true then (
    (* yay, there are at least some continuous blocks *)
    let b = cb in
    let f = fun i -> (
      let ofsx = _index_nd_1d i sd in
      let ofsy = !ofsy_i * b in
      _cp_op b ~ofsx ~ofsy ~incx:1 ~incy:1 x' y';
      ofsy_i := !ofsy_i + 1
    )
    in
    (* start copying blocks *)
    _foreach_continuous_blk axis d1 f;
    (* reshape the ndarray *)
    let z = Bigarray.genarray_of_array1 y' in
    let z = Bigarray.reshape z s1 in
    z
  )
  else (
    (* copy happens at the highest dimension, no continuous block *)
    let b = s1.(d0 - 1) in
    (* do the math yourself, [dd] is actually reduced from
       s0.(d0 - 1) + (b - 1) * c - (s0.(d0 - 1) - axis.(d0 - 1).(0) - 1) - 1
    *)
    let c, dd =
      match axis.(d0 - 1) with
      | R_ i -> (
          if i.(2) > 0 then i.(2), i.(0)
          else i.(2), i.(0) + (b - 1) * i.(2)
        )
      | _    -> failwith "owl_slicing:slice_array_typ"
    in
    let cx = if c > 0 then c else -c in
    let cy = if c > 0 then 1 else -1 in
    let f = fun i -> (
      let ofsx = _index_nd_1d i sd + dd in
      let ofsy = !ofsy_i * b in
      _cp_op b ~ofsx ~ofsy ~incx:cx ~incy:cy x' y';
      ofsy_i := !ofsy_i + 1
    )
    in
    (* start copying blocks *)
    _foreach_continuous_blk axis (d1 - 1) f;
    (* reshape the ndarray *)
    let z = Bigarray.genarray_of_array1 y' in
    let z = Bigarray.reshape z s1 in
    z
  )


(* set slice in [x] according to [y] *)
let set_slice_array_typ axis x y =
  (* check axis is within boundary then re-format *)
  let s0 = shape x in
  let axis = check_slice_definition axis s0 in
  (* validate the slice shape is the same as y's *)
  let s1 = calc_slice_shape axis in
  assert (shape y = s1);
  (* transform into 1d array *)
  let x' = Bigarray.reshape_1 x (numel x) in
  let y' = Bigarray.reshape_1 y (numel y) in
  (* prepare function of copying blocks *)
  let d0 = Array.length s1 in
  let d1, cb = calc_continuous_blksz axis s0 in
  let sd = _calc_stride s0 in
  let _cp_op = _owl_copy (kind x) in
  let ofsy_i = ref 0 in
  (* two copying strategies based on the size of the minimum continuous block.
     also, consider the special case wherein the highest-dimension equals to 1.
   *)
  let high_dim_list = (function L_ _ -> true | _ -> false) axis.(d0 - 1) in
  if cb > 1 || s0.(d0 - 1) = 1 || high_dim_list = true then (
    (* yay, there are at least some continuous blocks *)
    let b = cb in
    let f = fun i -> (
      let ofsx = _index_nd_1d i sd in
      let ofsy = !ofsy_i * b in
      _cp_op b ~ofsx:ofsy ~ofsy:ofsx ~incx:1 ~incy:1 y' x';
      ofsy_i := !ofsy_i + 1
    )
    in
    (* start copying blocks *)
    _foreach_continuous_blk axis d1 f
  )
  else (
    (* copy happens at the highest dimension, no continuous block *)
    let b = s1.(d0 - 1) in
    (* do the math yourself, [dd] is actually reduced from
       s0.(d0 - 1) + (b - 1) * c - (s0.(d0 - 1) - axis.(d0 - 1).(0) - 1) - 1
    *)
    let c, dd =
      match axis.(d0 - 1) with
      | R_ i -> (
          if i.(2) > 0 then i.(2), i.(0)
          else i.(2), i.(0) + (b - 1) * i.(2)
        )
      | _    -> failwith "owl_slicing:set_slice_array_typ"
    in
    let cx = if c > 0 then c else -c in
    let cy = if c > 0 then 1 else -1 in
    let f = fun i -> (
      let ofsx = _index_nd_1d i sd + dd in
      let ofsy = !ofsy_i * b in
      _cp_op b ~ofsx:ofsy ~ofsy:ofsx ~incx:cy ~incy:cx y' x';
      ofsy_i := !ofsy_i + 1
    )
    in
    (* start copying blocks *)
    _foreach_continuous_blk axis (d1 - 1) f
  )


(* convert from a list of slice definition to array for internal use *)
let sdlist_to_sdarray axis =
  List.map (function
    | I i -> I_ i
    | L i -> L_ (Array.of_list i)
    | R i -> R_ (Array.of_list i)
  ) axis
  |> Array.of_list


(* same as slice_array_typ function but take list type as slice definition *)
let get_slice_list_typ axis x = get_slice_array_typ (sdlist_to_sdarray axis) x


(* same as set_slice_array_typ function but take list type as slice definition *)
let set_slice_list_typ axis x y = set_slice_array_typ (sdlist_to_sdarray axis) x y



(* ends here *)
