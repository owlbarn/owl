(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* This is the module to support N-dimensional array of any types. In order to
  differentiate from others supporting numerical types, I made this module
  mostly self-contained. That means, I don't intend to make the code in this
  module reused by other modules, and some functions are copied from other
  files then locally adapted to provide the needed functionality.
 *)

open Owl_types

open Owl_ndarray


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
  make_arr d (Owl_utils.calc_stride d) (Array.make n a)

let init d f =
  let n = _calc_numel_from_shape d in
  let data = Array.init n (fun i -> f i) in
  make_arr d (Owl_utils.calc_stride d) data

let init_nd d f =
  let n = _calc_numel_from_shape d in
  let j = Array.copy d in
  let s = Owl_utils.calc_stride d in
  let data = Array.init n (fun i ->
    Owl_utils.index_1d_nd i j s;
    f j;
  )
  in
  make_arr d (Owl_utils.calc_stride d) data

let sequential ?(a=0.) ?(step=1.) d =
  let n = _calc_numel_from_shape d in
  let a = ref (a -. step) in
  let data = Array.init n (fun _ ->
    a := !a +. step;
    !a
  ) in
  make_arr d (Owl_utils.calc_stride d) data

let zeros d = create d 0.

let ones d = create d 1.

let num_dims x = Array.length x.shape

let shape x = Array.copy x.shape

let nth_dim x i = x.shape.(i)

let numel x = _calc_numel_from_shape x.shape


let get x i = x.data.(Owl_utils.index_nd_1d i x.stride)

let set x i a = x.data.(Owl_utils.index_nd_1d i x.stride) <- a

let get_index x axis =
  let d = num_dims x in
  assert (Array.length axis = d);
  let n = Array.length axis.(0) in
  let indices = Array.make_matrix d n 0 in
  Array.iteri (fun i a ->
    Array.iteri (fun j b -> indices.(i).(j) <- b) a
  ) axis;
  Array.map (fun i -> get x i) indices


let set_index x axis a =
  let d = num_dims x in
  assert (Array.length axis = d);
  let n = Array.length axis.(0) in
  let indices = Array.make_matrix d n 0 in
  Array.iteri (fun i a ->
    Array.iteri (fun j b -> indices.(i).(j) <- b) a
  ) axis;
  Array.iteri (fun i j -> set x j a.(i)) indices

let slice_left = None

let copy_to src dst =
  assert (src.shape = dst.shape);
  Array.blit src.data 0 dst.data 0 (numel src)

let fill x a = Array.fill x.data 0 (numel x) a

let reshape x d =
  let m = _calc_numel_from_shape x.shape in
  let n = _calc_numel_from_shape d in
  assert (m = n);
  make_arr d x.stride x.data

let flatten x = make_arr [|Array.length x.data|] [|1|] x.data

let copy x = {
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
  let i = Owl_utils.Array.pad `Right 0 pad_len i in
  let start_pos = Owl_utils.index_nd_1d i x.stride in
  let data_y = Array.sub x.data start_pos s_len in
  let shape_y = Array.sub x.shape i_len pad_len in
  let stride_y = Array.sub x.stride i_len pad_len in
  make_arr shape_y stride_y data_y

let squeeze ?(axis=[||]) x =
  let a = match Array.length axis with
    | 0 -> Array.init (num_dims x) (fun i -> i)
    | _ -> axis
  in
  let s = Owl_utils.Array.filteri (fun i v ->
    not (v == 1 && Array.mem i a)
  ) (shape x)
  in
  reshape x s

let expand ?(hi=false) x d =
  let d0 = d - (num_dims x) in
  match d0 > 0 with
  | true  -> (
      if hi = true then
        Owl_utils.Array.pad `Right 1 d0 (shape x) |> reshape x
      else
        Owl_utils.Array.pad `Left 1 d0 (shape x) |> reshape x
    )
  | false -> x

let reverse x =
  let y = copy x in
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

let filteri f x =
  let s = Owl_utils.Stack.make () in
  iteri (fun i y ->
    match f i y with
    | true  -> Owl_utils.Stack.push s i
    | false -> ()
  ) x;
  Owl_utils.Stack.to_array s

let filter f x = filteri (fun _ y -> f y) x

let fold f a x = Array.fold_left f a x.data

let foldi f a x =
  let a = ref a in
  for i = 0 to numel x - 1 do
    a := f i !a x.data.(i)
  done;
  !a

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

let sort ?(cmp=Pervasives.compare) x = Array.sort cmp x.data

let max ?(cmp=Pervasives.compare) x =
  let r = ref x.data.(0) in
  iter (fun a ->
    match cmp a !r with
    | 1 -> r := a
    | _ -> ()
  ) x;
  !r

let min ?(cmp=Pervasives.compare) x =
  let r = ref x.data.(0) in
  iter (fun a ->
    match cmp !r a with
    | 1 -> r := a
    | _ -> ()
  ) x;
  !r

let max_i ?(cmp=Pervasives.compare) x =
  let r = ref x.data.(0) in
  let j = ref 0 in
  iteri (fun i a ->
    match cmp a !r with
    | 1 -> r := a; j := i
    | _ -> ()
  ) x;
  !r, !j

let min_i ?(cmp=Pervasives.compare) x =
  let r = ref x.data.(0) in
  let j = ref 0 in
  iteri (fun i a ->
    match cmp !r a with
    | 1 -> r := a; j := i
    | _ -> ()
  ) x;
  !r, !j


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
  let y = make_arr s1 (Owl_utils.calc_stride s1) (Array.copy x.data) in
  iteri (fun i_1d z ->
    Owl_utils.index_1d_nd i_1d i x.stride;
    Array.iteri (fun k j -> i'.(k) <- i.(j)) a;
    set y i' z
  ) x;
  y


let tile x reps =
  (* check the validity of reps *)
  if Array.exists ((>) 1) reps then
    failwith "tile: repetition must be >= 1";
  (* align and promote the shape *)
  let a = num_dims x in
  let b = Array.length reps in
  let x, reps = match a < b with
    | true -> (
      let d = Owl_utils.Array.pad `Left 1 (b - a) (shape x) in
      (reshape x d), reps
      )
    | false -> (
      let r = Owl_utils.Array.pad `Left 1 (a - b) reps in
      x, r
      )
  in
  (* calculate the smallest continuous slice dx *)
  let i = ref (Array.length reps - 1) in
  let sx = shape x in
  let dx = ref sx.(!i) in
  while reps.(!i) = 1 && !i - 1 >= 0 do
    i := !i - 1;
    dx := !dx * sx.(!i);
  done;
  (* make the array to store the result *)
  let sy = Owl_utils.Array.map2i (fun _ a b -> a * b) sx reps in
  let y_data = Array.make (_calc_numel_from_shape sy) x.data.(0) in
  let y = make_arr sy (Owl_utils.calc_stride sy) y_data in
  (* project x and y to 1-dimensional arrays *)
  let x1 = x.data in
  let y1 = y.data in
  let stride_x = Owl_utils.calc_stride (shape x) in
  let stride_y = Owl_utils.calc_stride (shape y) in
  (* recursively tile the data within y *)
  let rec _tile ofsx ofsy lvl =
    if lvl = !i then (
      for k = 0 to reps.(lvl) - 1 do
        let ofsy' = ofsy + (k * !dx) in
        Array.blit x1 ofsx y1 ofsy' !dx;
      done;
    ) else (
      for j = 0 to sx.(lvl) - 1 do
        let ofsx' = ofsx + j * stride_x.(lvl) in
        let ofsy' = ofsy + j * stride_y.(lvl) in
        _tile ofsx' ofsy' (lvl + 1);
      done;
      let _len = stride_y.(lvl) * sx.(lvl) in
      for k = 1 to reps.(lvl) - 1 do
        let ofsy' = ofsy + (k * _len) in
        Array.blit y1 ofsy y1 ofsy' _len
      done
    )
  in
  _tile 0 0 0; y


let repeat x reps =
  (* check the validity of reps *)
  if Array.exists ((>) 1) reps then
    failwith "repeat: repetition must be >= 1";
  let highest_dim = Array.length (shape x) - 1 in
  let _shape_x = shape x in
  if Array.length reps != Array.length _shape_x then
    failwith "repeat: repetition must be of the same dimension as input ndarray";

  if (Array.for_all (fun x -> x = 1) reps) = true then x else (
    let _shape_y = Array.map2 ( * ) _shape_x reps in
    let y_data = Array.make (_calc_numel_from_shape _shape_y) x.data.(0) in
    let y = make_arr _shape_y (Owl_utils.calc_stride _shape_y) y_data in
    (* transform into a flat array first *)
    let x' = x.data in
    let y' = y.data in

    if Array.length reps = 1 then (
      (* TODO: omg, cannot use blit, so have to copy one by one, I need to
      fiugre out a more efficient way to copy at the highest dimension. *)
      let ofsy = ref 0 in
      for i = 0 to numel x - 1 do
        for j = 0 to reps.(0) - 1 do
          y'.(!ofsy) <- x'.(i);
          ofsy := !ofsy + 1;
        done
      done
    )
    else (
      let stride_x = Owl_utils.calc_stride _shape_x in
      let slice_y = Owl_utils.calc_slice _shape_y in

      let rep_slice = Owl_utils.calc_slice reps in
      let block_idx = Array.map2 ( * ) rep_slice stride_x in

      let hd = ref (highest_dim + 1) in
      let flag_one = true in
      for i = highest_dim downto 0 do
        let flag_one = if reps.(i) != 0 then false else flag_one in
        if flag_one && reps.(i) = 0 then hd := !hd - 1
      done;
      let hd = if !hd = highest_dim + 1 then highest_dim else !hd in

      let h = ref 0 in
      let d = ref 0 in
      let ofsx = ref 0 in
      let tag = ref true in
      let stack = Stack.create () in

      while ((!d != hd) && !tag) || not (Stack.is_empty stack) do

        while (!d != hd) && !tag do
          for i = _shape_x.(!d) - 1 downto 0 do
            let flag = if i = 0 then false else true in
            Stack.push (!h + i * block_idx.(!d), !d + 1,
              !ofsx + i * stride_x.(!d), flag) stack
          done;
          d := !d + 1
        done;

        if not (Stack.is_empty stack) then (
          let t1, t2, t3, t4 = Stack.pop stack in
          h := t1; d := t2; ofsx := t3; tag := t4;

          if !tag && (!d < hd) then (
            Stack.push (t1, t2, t3, false) stack
          )
          else (
            if !d = hd then (
              let repsd = reps.(!d) in
              if repsd = 1 then (
                Array.blit x' !ofsx y' !h slice_y.(!d)
              )
              else (
                for i = 0 to _shape_x.(!d) - 1 do
                  let elemx = x'.(!ofsx + i) in
                  for j = 0 to repsd - 1 do
                    y'.(!h + i * repsd + j) <- elemx
                  done
                done
              )
            );
            let block_sz = slice_y.(!d) in
            for j = 1 to (reps.(!d - 1) - 1) do
              let ofsy = !h + j * block_sz in
              Array.blit y' !h y' ofsy block_sz
            done
          )
        )
      done
    );
    y
  )


let concatenate ?(axis=0) xs =
  (* get the shapes of all inputs and etc. *)
  let shapes = Array.map shape xs in
  let shape0 = Array.copy shapes.(0) in
  shape0.(axis) <- 0;
  let acc_dim = ref 0 in
  (* validate all the input shapes; update step_sz *)
  let step_sz = Array.(make (length xs) 0) in
  Array.iteri (fun i shape1 ->
    step_sz.(i) <- (Owl_utils.calc_slice shape1).(axis);
    acc_dim := !acc_dim + shape1.(axis);
    shape1.(axis) <- 0;
    assert (shape0 = shape1);
  ) shapes;
  (* allocalte space for new array *)
  shape0.(axis) <- !acc_dim;
  let y_data = Array.make (_calc_numel_from_shape shape0) xs.(0).data.(0) in
  let y = make_arr shape0 (Owl_utils.calc_stride shape0) y_data in
  (* flatten y then calculate the number of copies *)
  let z = y.data in
  let slice_sz = (Owl_utils.calc_slice shape0).(axis) in
  let m = numel y / slice_sz in
  let n = Array.length xs in
  (* flatten all the inputs and init the copy location *)
  let x_flt = Array.map (fun x -> x.data) xs in
  let x_ofs = Array.make n 0 in
  (* copy data in the flattened space *)
  let z_ofs = ref 0 in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      Array.blit x_flt.(j) x_ofs.(j) z !z_ofs step_sz.(j);
      x_ofs.(j) <- x_ofs.(j) + step_sz.(j);
      z_ofs := !z_ofs + step_sz.(j);
    done;
  done;
  (* all done, return the combined result *)
  y


(* the following four padding related functions, they are simply the replica
  from Owl_dense_ndarray_generic module, so please refer to that module. *)

let _expand_padding_index d s =
  let ls = Array.length s in
  let ld = Array.length d in
  let d = Owl_utils.Array.pad `Right [|0;0|] (ls - ld) d in
  Array.map (function
    | [||]  -> [|0;0|]
    | [|x|] -> [|x;x|]
    | x     -> x
  ) d

let rec _copy_to_padding p1 ls l0 l1 i0 i1 d0 d1 s0 s1 x0 x1 =
  if d0 < d1 then (
    for i = 0 to s0.(d0) - 1 do
      i0.(d0) <- i;
      i1.(d0) <- i + p1.(d0).(0);
      _copy_to_padding p1 ls l0 l1 i0 i1 (d0 + 1) d1 s0 s1 x0 x1;
      i0.(d0) <- 0;
      i1.(d0) <- p1.(d0).(0);
    done
  )
  else (
    let j0 = Owl_utils.index_nd_1d i0 l0 in
    let j1 = Owl_utils.index_nd_1d i1 l1 in
    Array.blit x0 j0 x1 j1 ls.(d0)
  )

let _highest_padding_dimension p =
  let l = Array.length p - 1 in
  let d = ref l in
  (try for i = l downto 0 do
    d := i;
    if p.(i) <> [|0;0|] then failwith "stop"
  done with exn -> ());
  !d

let pad v d x =
  let s0 = shape x in
  let p1 = _expand_padding_index (Owl_utils.llss2aarr d) s0 in
  let s1 = Array.map2 (fun m n -> m + n.(0) + n.(1)) s0 p1 in
  (* create ndarray y for storing the result *)
  let y_data = Array.make (_calc_numel_from_shape s1) v in
  let y = make_arr s1 (Owl_utils.calc_stride s1) y_data in
  (* prepare variables for block copying *)
  let ls = Owl_utils.calc_slice s0 in
  let l0 = Owl_utils.calc_stride s0 in
  let l1 = Owl_utils.calc_stride s1 in
  let i0 = Array.make (num_dims x) 0 in
  let i1 = Array.map (fun a -> a.(0)) p1 in
  let d0 = 0 in
  let d1 = _highest_padding_dimension p1 in
  let x0 = x.data in
  let x1 = y.data in
  _copy_to_padding p1 ls l0 l1 i0 i1 d0 d1 s0 s1 x0 x1;
  y


(* get_fancy function is adapted from its original implementation in owl_slicing
   module, refer to Owl_slicing module for more information
 *)
let get_fancy axis x =
  let axis = Owl_slicing.sdlist_to_sdarray axis in
  (* check axis is within boundary then re-format *)
  let s0 = shape x in
  let axis = Owl_slicing.check_slice_definition axis s0 in
  (* calculate the new shape for slice *)
  let s1 = Owl_slicing.calc_slice_shape axis in
  let y_data = Array.make (_calc_numel_from_shape s1) x.data.(0) in
  let y = make_arr s1 (Owl_utils.calc_stride s1) y_data in
  (* transform into 1d array *)
  let x' = x.data in
  let y' = y.data in
  (* prepare function of copying blocks *)
  let d0 = Array.length s1 in
  let d1, cb = Owl_slicing.calc_continuous_blksz axis s0 in
  let sd = Owl_utils.calc_stride s0 in
  let ofsy_i = ref 0 in
  (* two copying strategies based on the size of the minimum continuous block *)
  let high_dim_list = (function L_ _ -> true | _ -> false) axis.(d0 - 1) in
  if cb > 1 || s0.(d0 - 1) = 1 || high_dim_list = true then (
    (* yay, there are at least some continuous blocks *)
    let b = cb in
    let f = fun i -> (
      let ofsx = Owl_utils.index_nd_1d i sd in
      let ofsy = !ofsy_i * b in
      Array.blit x' ofsx y' ofsy b;
      ofsy_i := !ofsy_i + 1
    )
    in
    (* start copying blocks *)
    Owl_slicing._foreach_continuous_blk axis d1 f;
    (* all done, return the result *)
    y
  )
  else (
    (* copy happens at the highest dimension, no continuous block *)
    let b = s1.(d0 - 1) in
    let c, dd =
      match axis.(d0 - 1) with
      | R_ i -> (
          if i.(2) > 0 then i.(2), i.(0)
          else i.(2), i.(0) + (b - 1) * i.(2)
        )
      | _    -> failwith "owl_dense_ndarray_a:slice_array_typ"
    in
    let cx = if c > 0 then c else -c in
    let cy = if c > 0 then 1 else -1 in
    (* TODO: blit cannot be used, have to copy one by one *)
    let f = fun i -> (
      let ofsx = ref (Owl_utils.index_nd_1d i sd + dd) in
      let ofsy =
        if c > 0 then ref (!ofsy_i * b)
        else ref ((!ofsy_i + 1) * b - 1)
      in
      for i = 0 to b - 1 do
        y'.(!ofsy) <- x'.(!ofsx);
        ofsx := !ofsx + cx;
        ofsy := !ofsy + cy;
      done;
      ofsy_i := !ofsy_i + 1
    )
    in
    (* start copying blocks *)
    Owl_slicing._foreach_continuous_blk axis (d1 - 1) f;
    (* all done, return the result *)
    y
  )


(* set_fancy function is adapted from its original implementation in owl_slicing
   module, refer to Owl_slicing module for more information
 *)
let set_fancy axis x y =
  let axis = Owl_slicing.sdlist_to_sdarray axis in
  (* check axis is within boundary then re-format *)
  let s0 = shape x in
  let axis = Owl_slicing.check_slice_definition axis s0 in
  (* calculate the new shape for slice *)
  let s1 = Owl_slicing.calc_slice_shape axis in
  assert (shape y = s1);
  (* transform into 1d array *)
  let x' = x.data in
  let y' = y.data in
  (* prepare function of copying blocks *)
  let d0 = Array.length s1 in
  let d1, cb = Owl_slicing.calc_continuous_blksz axis s0 in
  let sd = Owl_utils.calc_stride s0 in
  let ofsy_i = ref 0 in
  (* two copying strategies based on the size of the minimum continuous block *)
  let high_dim_list = (function L_ _ -> true | _ -> false) axis.(d0 - 1) in
  if cb > 1 || s0.(d0 - 1) = 1 || high_dim_list = true then (
    (* yay, there are at least some continuous blocks *)
    let b = cb in
    let f = fun i -> (
      let ofsx = Owl_utils.index_nd_1d i sd in
      let ofsy = !ofsy_i * b in
      Array.blit y' ofsy x' ofsx b;
      ofsy_i := !ofsy_i + 1
    )
    in
    (* start copying blocks *)
    Owl_slicing._foreach_continuous_blk axis d1 f
  )
  else (
    (* copy happens at the highest dimension, no continuous block *)
    let b = s1.(d0 - 1) in
    let c, dd =
      match axis.(d0 - 1) with
      | R_ i -> (
          if i.(2) > 0 then i.(2), i.(0)
          else i.(2), i.(0) + (b - 1) * i.(2)
        )
      | _    -> failwith "owl_dense_ndarray_a:slice_array_typ"
    in
    let cx = if c > 0 then c else -c in
    let cy = if c > 0 then 1 else -1 in
    (* TODO: blit cannot be used, have to copy one by one *)
    let f = fun i -> (
      let ofsx = ref (Owl_utils.index_nd_1d i sd + dd) in
      let ofsy =
        if c > 0 then ref (!ofsy_i * b)
        else ref ((!ofsy_i + 1) * b - 1)
      in
      for i = 0 to b - 1 do
        x'.(!ofsx) <- y'.(!ofsy);
        ofsx := !ofsx + cx;
        ofsy := !ofsy + cy;
      done;
      ofsy_i := !ofsy_i + 1
    )
    in
    (* start copying blocks *)
    Owl_slicing._foreach_continuous_blk axis (d1 - 1) f
  )

(* simplified get_fancy function which accept list of list as slice definition.
  adapted from owl_slicing module, refer to Owl_slicing for more information.
 *)
let get_slice axis x =
  let axis = List.map (fun i -> R i) axis in
  get_fancy axis x


(* simplified set_slice function which accept list of list as slice definition
  adapted from owl_slicing module, refer to Owl_slicing for more information.
*)
let set_slice axis x y =
  let axis = List.map (fun i -> R i) axis in
  set_fancy axis x y


let swap a0 a1 x =
  let d = num_dims x in
  let a = Array.init d (fun i -> i) in
  let t = a.(a0) in
  a.(a0) <- a.(a1);
  a.(a1) <- t;
  transpose ~axis:a x

let strides x = x |> shape |> Owl_utils.calc_stride

let slice_size x = x |> shape |> Owl_utils.calc_slice

let index_nd_1d i_nd _stride =
  Owl_utils.index_nd_1d i_nd _stride

let index_1d_nd i_1d _stride =
  let i_nd = Array.copy _stride in
  Owl_utils.index_1d_nd i_1d i_nd _stride;
  i_nd


(* input/output functions *)

let of_array x d = make_arr d (Owl_utils.calc_stride d) x

let to_array x = x.data



(* ends here *)
