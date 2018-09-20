(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

[@@@warning "-32"]

open Bigarray

open Owl_types

type ('a, 'b) t = ('a, 'b, c_layout) Genarray.t

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

module Scalar = Owl_base_maths


(* Prepend an array with ones to the given length *)
let _prepend_dims dims desired_len =
  let dims_len = Array.length dims in
  if dims_len >= desired_len then dims
  else (Array.append (Array.make (desired_len - dims_len) 1) dims)


let _get_broadcasted_dims dims_a dims_b =
  let len_c = Pervasives.max (Array.length dims_a) (Array.length dims_b) in
  let ext_dims_a = _prepend_dims dims_a len_c in
  let ext_dims_b = _prepend_dims dims_b len_c in
  let dims_c = Array.make len_c 0 in

  for i = 0 to len_c - 1 do
    let val_a = ext_dims_a.(i) in
    let val_b = ext_dims_b.(i) in
    if val_a = val_b then
      dims_c.(i) <- val_a
    else
      if val_a != 1 && val_b != 1
      then raise (Invalid_argument "The arrays cannot be broadcast into the same shape")
      else dims_c.(i) <- (Pervasives.max val_a val_b)
  done;
  (ext_dims_a, ext_dims_b, dims_c)


(* Increment the index array, with respect to the dimensions array *)
let _next_index ind dims =
  let num_dims = Array.length ind in
  let p = ref (num_dims - 1) in
  let ok = ref false in
  while !p >= 0 && not !ok do
    if ind.(!p) + 1 < dims.(!p) then (
      ind.(!p) <- (ind.(!p) + 1);
      ok := true;
    )
    else (
      ind.(!p) <- 0;
      p := !p - 1;
    )
  done;
  !ok


let _get_broadcasted_index ind dims =
  let num_dims = Array.length dims in
  let calc_fun =
    (fun i ->
       let max_ind = dims.(i) in
       let ind_val = ind.(i) in
       if ind_val < max_ind
       then ind_val
       else (
         if max_ind = 1
         then 0
         else raise (Invalid_argument "not broadcasted correctly")
       )
    ) in
  (Array.init num_dims calc_fun)


let _apply_perm arr perm =
  Array.init (Array.length arr) (fun i -> arr.(perm.(i)))


let _draw_int_samples replacement range count =
  if not replacement && count > range then
    raise (Invalid_argument "cannot draw that many samples from the given range, without replacement")
  else (
    let pop_cnt = ref range in
    let pop = Array.init !pop_cnt (fun i -> i) in
    let rand_gen = Random.State.make_self_init() in
    let draw_fun = (fun _ ->
        let index = Random.State.int rand_gen !pop_cnt in
        let sample = pop.(index) in
        if replacement then
          sample
        else (
          pop_cnt := !pop_cnt - 1;
          pop.(index) <- pop.(!pop_cnt); (* eliminate sample by swapping with last element *)
          sample
        )
      )
    in
    Array.init count draw_fun
  )


let _enumerate_slice_def dim ?(step) start stop =
  let start = if start < 0 then dim + start else start in
  let stop = if stop < 0 then dim + stop else stop in
  let step = match step with
    | Some x -> x
    | None   -> if (start <= stop) then 1 else -1
  in
  assert (((start <= stop) && (step > 0)) || ((start > stop) && (step < 0)));
  let step_abs = Pervasives.abs step in
  let len = ((Pervasives.abs (stop - start)) + step_abs) / step_abs in
  (Array.init len (fun i -> start + i * step))


(* Rewrite the indices s.t. for each dimension they are a list of explicit indices *)
let _expand_slice_indices index_list dims =
  let rank = Array.length dims in
  let sdef_len = List.length index_list in (* the number of dimensions this slice specifies *)
  let _expand_slice_index = (
    fun i ind -> match ind with
      | []                  -> Array.init dims.(i) (fun i -> i)
      | [start]             -> _enumerate_slice_def dims.(i) start start
      | [start; stop]       -> _enumerate_slice_def dims.(i) start stop
      | [start; stop; step] -> _enumerate_slice_def dims.(i) ~step:step start stop
      | x                   -> Array.of_list x
  ) in
  Array.append
    (Array.of_list (List.mapi _expand_slice_index index_list)) (* for the axis where the index was specified *)
    (Array.init (rank - sdef_len) (* the rest of the axis is just all of them *)
       (fun p -> Array.init dims.(p + sdef_len) (fun i -> i)))


let reset x =
  let _kind = Genarray.kind x in
  Genarray.fill x (Owl_const.zero _kind)


let empty kind dims = Genarray.create kind c_layout dims


let create kind dims value =
  let x = empty kind dims in
  Genarray.fill x value;
  x


let create_ ~out a = Genarray.fill out a


let zeros kind dims = create kind dims (Owl_const.zero kind)


let zeros_ ~out = reset out


let ones kind dims = create kind dims (Owl_const.one kind)


let ones_ ~out = Genarray.(fill out (Owl_const.one (kind out)))


let shape x = Genarray.dims x


let nth_dim x i = Genarray.nth_dim x i


let num_dims x = Array.length (shape x)


let numel x = Owl_utils.numel x


let kind x = Genarray.kind x


let get x index = (Genarray.get x index)


let set x index value = (Genarray.set x index value)


(*TODO: optimise, test *)
let get_slice index_list varr =
  let dims = shape varr in
  let rank = Array.length dims in
  let index_array = _expand_slice_indices index_list dims in
  let slice_dims = Array.map (fun a -> Array.length a) index_array in
  let slice_varr = empty (kind varr) slice_dims in
  let slice_ind = Array.make rank 0 in
  let original_ind = Array.make rank 0 in
  let should_stop = ref false in
  while not !should_stop do
    for i = 0 to rank - 1 do
      original_ind.(i) <- (index_array.(i)).(slice_ind.(i))
    done;
    Genarray.set slice_varr slice_ind (Genarray.get varr original_ind);
    if not (_next_index slice_ind slice_dims) then
      should_stop := true
  done;
  slice_varr


(*TODO: optimise, test *)
let set_slice index_list varr slice_varr =
  let dims = shape varr in
  let rank = Array.length dims in
  let index_array = _expand_slice_indices index_list dims in
  let slice_dims = Array.map (fun a -> Array.length a) index_array in
  let slice_varr = reshape slice_varr slice_dims in
  let slice_ind = Array.make rank 0 in
  let original_ind = Array.make rank 0 in
  let should_stop = ref false in
  while not !should_stop do
    for i = 0 to rank - 1 do
      original_ind.(i) <- (index_array.(i)).(slice_ind.(i))
    done;
    Genarray.set varr original_ind (Genarray.get slice_varr slice_ind);
    if not (_next_index slice_ind slice_dims) then
      should_stop := true
  done


(* The result shares the underlying buffer with original, not a copy *)
let reshape x d =
  let minus_one = Owl_utils.Array.count d (-1) in
  assert (minus_one <= 1);
  if minus_one = 0 then reshape x d
  else (
    let n = numel x in
    let m = Array.fold_right ( * ) d (-1) in
    let e = Array.map (fun a -> if a = -1 then n / m else a) d in
    reshape x e
  )


(* Return the array as a contiguous block, without copying *)
let flatten x = reshape x [|(numel x)|]


let fill x a = Genarray.fill x a


let copy x =
  let y = empty (kind x) (shape x) in
  Genarray.blit x y;
  y


let copy_ ~out x =
  let src = flatten x in
  let dst = flatten out in
  Genarray.blit src dst


let reshape_ ~out x =
  if not (x == out) then
    copy_ ~out x


let reverse x =
  let n = numel x in
  let y = empty (kind x) (shape x) in
  let y_flat = reshape y [|n|] in
  let x_flat = reshape x [|n|] in
  for i = 0 to n - 1 do
    set y_flat [|i|] (get x_flat [|n - 1 - i|])
  done;
  y


let reverse_ ~out x =
  let n = numel x in
  let y_flat = reshape out [|n|] in
  let x_flat = reshape x [|n|] in
  for i = 0 to n - 1 do
    set y_flat [|i|] (get x_flat [|n - 1 - i|])
  done


let map_ f x =
  let y = flatten x |> array1_of_genarray in
  let length = numel x in
  for i = 0 to length - 1 do
    (Array1.unsafe_set y i (f (Array1.unsafe_get y i)))
  done


let mapi_ f x =
  let y = flatten x |> array1_of_genarray in
  let length = numel x in
  for i = 0 to length - 1 do
    (Array1.unsafe_set y i (f i (Array1.unsafe_get y i)))
  done


let init kind dims f =
  let varr = empty kind dims in
  let varr_flat = flatten varr |> array1_of_genarray in
  let n = numel varr in
  for i = 0 to n - 1 do
    Array1.unsafe_set varr_flat i (f i)
  done;
  varr


let init_nd k d f =
  let x = empty k d in
  let y = array1_of_genarray (flatten x) in
  let n = numel x in
  let s = Owl_utils.calc_stride d in
  let j = Array.copy s in
  for i = 0 to n - 1 do
    Owl_utils.index_1d_nd i j s;
    Array1.unsafe_set y i (f j)
  done;
  x


(* Map a NDarray from elements x -> f(x), by copying the array *)
let map f x =
  let y = copy x in
  map_ f y;
  y


let mapi f x =
  let y = copy x in
  let y' = flatten y |> array1_of_genarray in
  for i = 0 to (Array1.dim y') - 1 do
    let a = Array1.unsafe_get y' i in
    Array1.unsafe_set y' i (f i a)
  done;
  y

let strides x = x |> shape |> Owl_utils.calc_stride


let slice_size x = x |> shape |> Owl_utils.calc_slice


(* TODO: performance can be optimised by removing embedded loops *)
(* generic fold funtion *)
let foldi ?axis f a x =
  let x' = flatten x |> array1_of_genarray in
  match axis with
  | Some axis -> (
      let m, n, o, s = Owl_utils.reduce_params axis x in
      let start_x = ref 0 in
      let start_y = ref 0 in
      let incy = ref 0 in
      let k = ref 0 in

      let y = create (kind x) s a in
      let y' = flatten y |> array1_of_genarray in

      for _i = 0 to m - 1 do
        for j = 0 to n - 1 do
          let b = Array1.unsafe_get y' (!start_y + !incy) in
          let c = Array1.unsafe_get x' (!start_x + j) in
          Array1.unsafe_set y' (!start_y + !incy) (f !k b c);
          if !incy + 1 = o then incy := 0
          else incy := !incy + 1;
          k := !k + 1;
        done;
        start_x := !start_x + n;
        start_y := !start_y + o;
      done;
      y
    )
  | None   -> (
      let b = ref a in
      for i = 0 to (numel x) - 1 do
        let c = Array1.unsafe_get x' i in
        b := f i !b c
      done;
      create (kind x) [|1|] !b
    )


let fold ?axis f a x = foldi ?axis (fun _ b c ->  f b c) a x


(* generic scan function *)
let scani ?axis f x =
  let d = num_dims x in
  let a = match axis with
    | Some a -> a
    | None   -> d - 1
  in
  assert (0 <= a && a < d);

  let _stride = strides x in
  let _slicez = slice_size x in
  let m = (numel x) / _slicez.(a) in
  let n = _slicez.(a) - _stride.(a) in
  let incx = _slicez.(a) in
  let incy = _slicez.(a) in
  let start_x = ref 0 in
  let start_y = ref _stride.(a) in
  let k = ref 0 in

  let y = copy x in
  let y' = flatten y |> array1_of_genarray in

  for _i = 0 to m - 1 do
    for j = 0 to n - 1 do
      let b = Array1.unsafe_get y' (!start_x + j) in
      let c = Array1.unsafe_get y' (!start_y + j) in
      Array1.unsafe_set y' (!start_y + j) (f !k b c);
      k := !k + 1
    done;
    start_x := !start_x + incx;
    start_y := !start_y + incy;
  done;
  y


let scan ?axis f x = scani ?axis (fun _ a b -> f a b) x


let iteri f x =
  let x' = flatten x |> array1_of_genarray in
  for i = 0 to (Array1.dim x') - 1 do
    let a = Array1.unsafe_get x' i in
    f i a
  done


let iter f x =
  let x' = flatten x |> array1_of_genarray in
  for i = 0 to (Array1.dim x') - 1 do
    let a = Array1.unsafe_get x' i in
    f a
  done


let filteri f x =
  let s = Owl_utils.Stack.make () in
  iteri (fun i y ->
      if f i y = true then
        Owl_utils.Stack.push s i
    ) x;
  Owl_utils.Stack.to_array s


let filter f x = filteri (fun _ y -> f y) x


let sequential_ ?a ?step ~out =
  let k = kind out in
  let a = match a with
    | Some a -> a
    | None   -> Owl_const.zero k
  in
  let step = match step with
    | Some step -> step
    | None      -> Owl_const.one k
  in
  let _add = Owl_base_dense_common._add_elt k in
  let _mul = Owl_base_dense_common._mul_elt k in
  let _flt = Owl_base_dense_common._float_typ_elt k in
  mapi_ (fun i _ ->
    _add a (_mul (_flt (float_of_int i)) step)
  ) out


let sequential k ?a ?step dimension =
  let x = empty k dimension in
  sequential_ ?a ?step ~out:x;
  x


let of_array kind arr dims =
  let varr = empty kind dims in
  let flat_varr = flatten varr |> array1_of_genarray in
  let n = numel varr in
  for i = 0 to n - 1 do
    Array1.unsafe_set flat_varr i arr.(i)
  done;
  varr


let uniform k ?a ?b dims =
  let a = match a with Some a -> a | None -> Owl_const.zero k in
  let b = match b with Some b -> b | None -> Owl_const.one k in
  let uniform_fun = Owl_base_dense_common._uniform_elt k a b in
  let x = empty k dims in
  map_ uniform_fun x;
  x


let uniform_ ?a ?b ~out =
  let k = kind out in
  let a = match a with Some a -> a | None -> Owl_const.zero k in
  let b = match b with Some b -> b | None -> Owl_const.one k in
  let uniform_fun = Owl_base_dense_common._uniform_elt k a b in
  map_ uniform_fun out


let bernoulli k ?(p=0.5) dims =
  let bernoulli_fun = fun _ ->
    let a = Owl_base_stats.bernoulli_rvs ~p in
    Owl_base_dense_common._float_typ_elt k a
  in
  let x = empty k dims in
  map_ bernoulli_fun x;
  x


let bernoulli_ ?(p=0.5) ~out =
  let k = kind out in
  let bernoulli_fun = fun _ ->
    let a = Owl_base_stats.bernoulli_rvs ~p in
    Owl_base_dense_common._float_typ_elt k a
  in
  map_ bernoulli_fun out


let gaussian k ?mu ?sigma dims =
  let mu = match mu with Some a -> a | None -> Owl_const.zero k in
  let sigma = match sigma with Some a -> a | None -> Owl_const.one k in
  let gaussian_fun = Owl_base_dense_common._gaussian_elt k mu sigma in
  let x = empty k dims in
  map_ gaussian_fun x;
  x


let gaussian_ ?mu ?sigma ~out =
  let k = kind out in
  let mu = match mu with Some a -> a | None -> Owl_const.zero k in
  let sigma = match sigma with Some a -> a | None -> Owl_const.one k in
  let gaussian_fun = Owl_base_dense_common._gaussian_elt k mu sigma in
  map_ gaussian_fun out


let print ?max_row ?max_col ?header ?fmt x =
  let dims = shape x in
  let rank = Array.length dims in
  let n = dims.(rank - 1) in
  let max_row = match max_row with
    | Some a -> Some a
    | None   -> Some ((numel x) / n)
  in
  let max_col = match max_col with
    | Some a -> Some a
    | None   -> Some n
  in
  Owl_pretty.print_dsnda ?max_row ?max_col ?header ?elt_to_str_fun:fmt x


(* TODO: optimise *)
let tile varr reps =
  (* First ensure len(reps) = num_dims(varr) *)
  let dims = shape varr in
  let result_rank = Pervasives.max (Array.length dims) (Array.length reps) in
  let dims = _prepend_dims dims result_rank in
  let reps = _prepend_dims reps result_rank in
  let varr = reshape varr dims in
  (* now len(reps) = num_dims(varr) *)
  let result_dims = Array.map2 (fun a b -> a * b) dims reps in
  let result_varr = empty (kind varr) result_dims in
  let result_ind = Array.make result_rank 0 in
  let original_ind = Array.make result_rank 0 in
  let should_stop = ref false in

  while not !should_stop do
    for i = 0 to result_rank - 1 do
      original_ind.(i) <- (Pervasives.(mod) result_ind.(i) dims.(i))
    done;
    Genarray.set result_varr result_ind (Genarray.get varr original_ind);
    if not (_next_index result_ind result_dims) then
      should_stop := true
  done;
  result_varr


(* TODO: optimise *)
let split ?(axis=0) parts varr =
  let dims = shape varr in
  let rank = Array.length dims in
  let pos = ref 0 in
  let axis_indices = Array.map (fun d -> (pos := !pos + d; [!pos - d; !pos - 1])) parts in
  let slices_defs =
    Array.map (fun ind ->
        Array.to_list (Array.init rank
                         (fun i -> if i = axis then ind else [])))
      axis_indices
  in
  (Array.map (fun def -> get_slice def varr) slices_defs)


(* TODO : ensure this is desired behaviour *)
(* Similar to draw rows for matrices *)
let draw ?(axis=0) varr count =
  let dims = shape varr in
  let rank = Array.length dims in
  let indices = _draw_int_samples false dims.(axis) count in
  (get_slice
     (List.init rank
        (fun i -> if i = axis then (Array.to_list indices) else []))
     varr,
   indices)


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
    (* _owl_copy (kind x0) ls.(d0) ~ofsx:j0 ~incx:1 ~ofsy:j1 ~incy:1 x0 x1 *)
    Printf.fprintf stderr "sub:: %d, %d, (%d)\n" j0 j1 ls.(d0);
    let subx = Genarray.sub_left x0 j0 ls.(d0) in
    let suby = Genarray.sub_left x1 j1 ls.(d0) in
    Genarray.blit subx suby
  )


let _highest_padding_dimension p =
  let l = Array.length p - 1 in
  let d = ref l in
  (try for i = l downto 0 do
    d := i;
    if p.(i) <> [|0;0|] then failwith "stop"
  done with _exn -> ());
  !d


let pad ?v d x =
  let k = kind x in
  let v = match v with
    | Some v -> v
    | None   -> Owl_const.zero k
  in
  let s0 = shape x in
  let x' = flatten x in
  let p1 = _expand_padding_index (Owl_utils.llss2aarr d) s0 in
  let s1 = Array.map2 (fun m n -> m + n.(0) + n.(1)) s0 p1 in
  let s' = Owl_utils_array.fold_right ( * ) s1 1 in
  let y' = create k [|s'|] v in
  let ls = Owl_utils.calc_slice s0 in
  Printf.fprintf stderr "ls: %s\n" (Owl_utils_array.to_string string_of_int ls);
  let l0 = Owl_utils.calc_stride s0 in
  Printf.fprintf stderr "l0: %s\n" (Owl_utils_array.to_string string_of_int l0);
  let l1 = Owl_utils.calc_stride s1 in
  Printf.fprintf stderr "s1: %s\n" (Owl_utils_array.to_string string_of_int s1);
  let i0 = Array.make (num_dims x) 0 in
  let i1 = Array.map (fun a -> a.(0)) p1 in
  Printf.fprintf stderr "i1: %s\n" (Owl_utils_array.to_string string_of_int i1);
  let d0 = 0 in
  let d1 = _highest_padding_dimension p1 in
  Printf.fprintf stderr "d1: %d\n" d1;
  _copy_to_padding p1 ls l0 l1 i0 i1 d0 d1 s0 s1 x' y';
  reshape y' s1


(* TODO: optimise? *)
let concatenate ?(axis=0) varrs =
  let varrs_num = Array.length varrs in
  (* dimensions of all NDarrays *)
  let all_dims = Array.map shape varrs in
  (* the dimensions before the axis *)
  let prefix_dims = Array.sub all_dims.(0) 0 axis in
  (* the sum of the dimensions of each NDarray along given axis *)
  let sum_axis_dims = Array.fold_left (fun x a -> x + a.(axis)) 0 all_dims in
  (* the dimensions after the axis *)
  let suffix_dims = Array.sub all_dims.(0)
      (axis + 1) ((Array.length all_dims.(0)) - axis - 1)
  in
  let result_dims =
    Array.concat [prefix_dims; [|sum_axis_dims|]; suffix_dims]
  in
  let result_varr = empty (kind varrs.(0)) result_dims in
  let prefix_dims_product = Array.fold_left ( * ) 1 prefix_dims in
  let suffix_dims_product = Array.fold_left ( * ) 1 suffix_dims in
  let reshaper_fun = (
    (* Reshape the variable as [prefix_dims_product, rest] *)
    fun varr ->
      let old_shape = shape varr in
      let new_shape =
        [|prefix_dims_product; old_shape.(axis) * suffix_dims_product|]
      in
      reshape varr new_shape
  ) in
  let reshaped_result = reshaper_fun result_varr in
  let reshaped_varrs = Array.map reshaper_fun varrs in
  begin
    for i = 0 to prefix_dims_product - 1 do
      let start_index = ref 0 in
      let result_slice = Genarray.slice_left reshaped_result [|i|] in
      for j = 0 to varrs_num - 1 do
        let src_slice = Genarray.slice_left reshaped_varrs.(j) [|i|] in
        let block_len = all_dims.(j).(axis) * suffix_dims_product in
        let result_sub =
          Genarray.sub_left result_slice !start_index block_len in
        Genarray.blit src_slice result_sub;
        start_index := !start_index + block_len
      done
    done;
    result_varr
  end


(* TODO: is there a more efficient way to do copy? *)
let repeat x reps =
  (* check the validity of reps *)
  if Array.exists ((>) 1) reps then
    failwith "repeat: repetition must be >= 1";
  let x_dims = num_dims x in
  assert (Array.length reps = x_dims);

  if (Array.for_all ((=) 1) reps) = true then
    copy x
  else (
    let _kind = kind x in
    let x' = flatten x in
    let x_shape = shape x in
    let y_shape = Array.map2 ( * ) x_shape reps in
    let num = Owl_utils_array.fold_right ( * ) y_shape 1 in
    let y' = empty _kind [|num|] in

    if x_dims = 1 then (
      let ofsy = ref 0 in
      for i = 0 to numel x - 1 do
        let elemx = get x' [|i|] in
        for _j = 0 to reps.(0) - 1 do
          set y' [|!ofsy|] elemx;
          ofsy := !ofsy + 1
        done
      done
    )
    else (
      let highest_dim = x_dims - 1 in
      let slice_x  = Owl_utils.calc_slice x_shape in
      let stride_y = Owl_utils.calc_stride y_shape in

      let hd = ref (highest_dim + 1) in
      while !hd > 1 && reps.(!hd - 1) = 1 do
        hd := !hd - 1;
      done;
      let hd = if !hd = highest_dim + 1 then highest_dim else !hd in

      (* Copy the HD dimension from x to y *)

      let block_num = Array.make hd 0 in
      for i = 0 to hd - 1 do
        block_num.(i) <- slice_x.(i) / slice_x.(hd);
      done;
      let counter = Array.make hd 0 in

      let ofsx = ref 0 in
      let ofsy = ref 0 in
      let block_sz = reps.(hd) in

      for _i = 0 to block_num.(0) - 1 do
        let ofsy_sub = ref !ofsy in
        if block_sz = 1 then (
          let subx = Genarray.sub_left x' !ofsx slice_x.(hd) in
          let suby = Genarray.sub_left y' !ofsy_sub slice_x.(hd) in
          Genarray.blit subx suby
        )
        else (
          for j = 0 to slice_x.(hd) - 1 do
            let elemx = get x' [|!ofsx + j|] in
            for k = 0 to block_sz - 1 do
              set y' [|!ofsy_sub + k|] elemx
            done;
            ofsy_sub := !ofsy_sub + block_sz
          done
        );
        ofsx := !ofsx + slice_x.(hd);
        ofsy := !ofsy + stride_y.(hd - 1) * reps.(hd - 1);
        for j = hd - 1 downto 1 do
          let c = counter.(j) in
          if c + 1 = block_num.(j) then (
            ofsy := !ofsy + stride_y.(j - 1) * (reps.(j - 1) - 1);
          );
          counter.(j) <- if c + 1 = block_num.(j) then 0 else c + 1
        done
      done;

      (* Copy the lower dimensions within y *)

      for d = hd - 1 downto 0 do
        let block_num = Array.make (d + 1) 0 in
        for i = 0 to d do
          block_num.(i) <- slice_x.(i) / slice_x.(d + 1);
        done;
        let ofsy = ref 0 in
        let block_sz = stride_y.(d) in
        let counter = Array.make hd 0 in

        for _i = 0 to block_num.(0) - 1 do
          let ofsy_sub = ref (!ofsy + block_sz) in
          for _j = 1 to reps.(d) - 1 do
            let subx = Genarray.sub_left y' !ofsy block_sz in
            let suby = Genarray.sub_left y' !ofsy_sub block_sz in
            Genarray.blit subx suby;
            ofsy_sub := !ofsy_sub + block_sz
          done;

          ofsy := !ofsy + stride_y.(d) * reps.(d);
          for j = d - 1 downto 0 do
            let c = counter.(j) in
            if c + 1 = block_num.(j + 1) then (
              ofsy := !ofsy + stride_y.(j) * (reps.(j) - 1);
            );
            counter.(j) <- if c + 1 = block_num.(j + 1) then 0 else c + 1
          done
        done
      done
    );
    reshape y' y_shape
  )


(* mathematical functions *)

let abs x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._abs_elt _kind in
  map _func x


let abs_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._abs_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let conj x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._conj_elt _kind in
  map _func x


let conj_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._conj_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map _func out


let neg x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._neg_elt _kind in
  map _func x


let neg_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._neg_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let reci x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._inv_elt _kind in
  map _func x


let reci_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._inv_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let floor x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._floor_elt _kind in
  map _func x


let floor_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._floor_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let ceil x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._ceil_elt _kind in
  map _func x


let ceil_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._ceil_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let round x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._round_elt _kind in
  map _func x


let round_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._round_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let trunc x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._trunc_elt _kind in
  map _func x


let trunc_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._trunc_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let fix x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._fix_elt _kind in
  map _func x


let fix_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._fix_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let erf _x = raise Owl_exception.NOT_IMPLEMENTED


let erf_ ?_out _x = raise Owl_exception.NOT_IMPLEMENTED


let erfc _x = raise Owl_exception.NOT_IMPLEMENTED


let erfc_ ?_out _x = raise Owl_exception.NOT_IMPLEMENTED


let sqr x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._sqr_elt _kind in
  map _func x


let sqr_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._sqr_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let sqrt x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._sqrt_elt _kind in
  map _func x


let sqrt_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._sqrt_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let cbrt x =
  let _kind = kind x in
  let b = Owl_base_dense_common._float_typ_elt _kind (1. /. 3.) in
  let _func = fun a -> Owl_base_dense_common._pow_elt _kind a b in
  map _func x


let cbrt_ ?out x =
  let _kind = kind x in
  let b = Owl_base_dense_common._float_typ_elt _kind (1. /. 3.) in
  let _func = fun a -> Owl_base_dense_common._pow_elt _kind a b in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let log x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._log_elt _kind in
  map _func x


let log_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._log_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ Scalar.log out


let log2 x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._log2_elt _kind in
  map _func x


let log2_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._log2_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let log10 x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._log10_elt _kind in
  map _func x


let log10_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._log10_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let log1p x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._log1p_elt _kind in
  map _func x


let log1p_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._log1p_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let exp x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._exp_elt _kind in
  map _func x


let exp_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._exp_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let exp2 x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._exp2_elt _kind in
  map _func x


let exp2_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._exp2_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let exp10 x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._exp10_elt _kind in
  map _func x


let exp10_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._exp10_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let expm1 x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._expm1_elt _kind in
  map _func x


let expm1_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._expm1_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let sin x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._sin_elt _kind in
  map _func x


let sin_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._sin_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let cos x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._cos_elt _kind in
  map _func x


let cos_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._cos_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let tan x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._tan_elt _kind in
  map _func x


let tan_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._tan_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let sinh x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._sinh_elt _kind in
  map _func x


let sinh_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._sinh_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let cosh x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._cosh_elt _kind in
  map _func x


let cosh_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._cosh_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let tanh x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._tanh_elt _kind in
  map _func x


let tanh_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._tanh_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let asin x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._asin_elt _kind in
  map _func x


let asin_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._asin_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let acos x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._acos_elt _kind in
  map _func x


let acos_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._acos_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let atan x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._atan_elt _kind in
  map _func x


let atan_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._atan_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let asinh x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._asinh_elt _kind in
  map _func x


let asinh_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._asinh_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let acosh x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._acosh_elt _kind in
  map _func x


let acosh_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._acosh_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let atanh x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._atanh_elt _kind in
  map _func x


let atanh_ ?out x =
  let _kind = kind x in
  let _func = Owl_base_dense_common._atanh_elt _kind in
  let out = match out with Some o -> o | None -> x in
  map_ _func out


let sum_slices ?(axis=0) varr =
  let dims = shape varr in
  let rank = Array.length dims in
  (* reshape into 2d matrix *)
  let num_rows = Array.fold_left ( * ) 1 (Array.sub dims 0 (axis + 1)) in
  let num_cols = (numel varr) / num_rows in
  let varr_mat = reshape varr [|num_rows; num_cols|] in
  let result_vec = empty (kind varr) [|num_cols|] in
  let result_varr = reshape result_vec
      (Array.sub dims (axis + 1) (rank - axis - 1))
  in
  let row_sum = ref 0. in

  for j = 0 to num_cols - 1 do
    row_sum := 0.;
    for i = 0 to num_rows - 1 do
      row_sum := !row_sum +. (Genarray.get varr_mat [|i; j|])
    done;
    Genarray.set result_vec [|j|] !row_sum
  done;
  result_varr


(* -1. for negative numbers, 0 or (-0) for 0,
 1 for positive numbers, nan for nan*)
let signum x = map Scalar.signum x


let signum_ ?out x =
  let out = match out with Some o -> o | None -> x in
  map_ Scalar.signum out


(* Apply 1 / (1 + exp (-x)) for each element x *)
let sigmoid x = map Scalar.sigmoid x


let sigmoid_ ?out x =
  let out = match out with Some o -> o | None -> x in
  map_ Scalar.sigmoid out


let relu x = map Scalar.relu x


let relu_ ?out x =
  let out = match out with Some o -> o | None -> x in
  map_ Scalar.relu out


let softsign x = map Scalar.softsign x


let softsign_ ?out x =
  let out = match out with Some o -> o | None -> x in
  map_ Scalar.softsign out


let softplus x = map Scalar.softplus x


let softplus_ ?out x =
  let out = match out with Some o -> o | None -> x in
  map_ Scalar.softplus out


let _fold_left f a varr =
  let aref = ref a in
  let varr_linear = flatten varr |> array1_of_genarray in
  let length = numel varr in
  begin
    for i = 0 to length - 1 do
      aref := (f !aref (Array1.unsafe_get varr_linear i))
    done;
    !aref
  end


(* Min of all elements in the NDarray *)
let min' x =
  let _kind = kind x in
  let _max_val = Owl_base_dense_common._max_val_elt _kind in
  _fold_left (Owl_base_dense_common._min_elt _kind) _max_val x


(* Max of all elements in the NDarray *)
let max' x =
  let _kind = kind x in
  let _min_val = Owl_base_dense_common._min_val_elt _kind in
  _fold_left (Owl_base_dense_common._max_elt _kind) _min_val x


(* Sum of all elements *)
let sum' x =
  let _kind = kind x in
  _fold_left (Owl_base_dense_common._add_elt _kind) (Owl_const.zero _kind) x


(* Folding along a specified axis, aka reduction. The
   f: function of type 'a -> 'a -> 'a.
   m: number of slices.
   n: x's slice size.
   o: x's strides, also y's slice size.
   x: source; y: shape of destination. Note that o <= n.
 *)
let _fold_along ?out f m n o x ys nelem =
  let x = flatten x in
  let y = match out with
    | Some o -> o |> flatten
    | None   -> create (kind x) ys nelem |> flatten
  in
  let idx = ref 0 in
  let idy = ref 0 in
  let incy = ref 0 in
  for _i = 0 to (m - 1) do
    for j = 0 to (n - 1) do
      let addon = Genarray.get x [|!idx + j|] in
      let orig  = Genarray.get y [|!idy + !incy|] in
      Genarray.set y [|!idy + !incy|] (f orig addon);
      incy := if (!incy + 1 = o) then 0 else !incy + 1
    done;
    idx := !idx + n;
    idy := !idy + o;
  done;
  reshape y ys


let sum ?axis x =
  let _kind = kind x in
  let zero = Owl_const.zero _kind in
  match axis with
  | Some a -> (
      let m, n, o, s = Owl_utils.reduce_params a x in
      let _op = Owl_base_dense_common._add_elt _kind in
      _fold_along _op m n o x s zero
    )
  | None   -> create (kind x) (Array.make 1 1) (sum' x)


let sum_ ~out ~axis x =
  let _kind = kind x in
  let zero = Owl_const.zero _kind in
  Genarray.fill out zero;
  match axis with
  | Some a -> (
      let m, n, o, s = Owl_utils.reduce_params a x in
      let _op = Owl_base_dense_common._add_elt _kind in
      _fold_along _op ~out m n o x s zero
      |> ignore
    )
  | None   -> (
      let y = flatten out in
      set y [|0|] (sum' x)
    )


let sum_reduce ?axis x =
  let _kind = kind x in
  let _dims = num_dims x in
  let zero = Owl_const.zero _kind in
  match axis with
  | Some a -> (
      let x_shape = shape x in
      let dims' = Owl_utils.squeeze_continuous_dims x_shape a in
      if Array.length dims' = 1 then (
        create (kind x) (Array.make _dims 1) (sum' x)
      )
      else (
        let y = ref (reshape x dims') in
        let flag = ref (Array.mem 0 a) in
        for i = 0 to Array.length dims' - 1 do
          if !flag = true then (
            let m, n, o, s = Owl_utils.reduce_params i !y in
            y := _fold_along (Owl_base_dense_common._add_elt _kind) m n o !y s zero
          );
          flag := not !flag
        done;
        let y_shape = Array.copy x_shape in
        Array.iter (fun j -> y_shape.(j) <- 1) a;
        reshape !y y_shape
      )
    )
  | None   -> create (kind x) (Array.make _dims 1) (sum' x)


let min ?axis x =
  let _kind = kind x in
  let max_val = Owl_base_dense_common._max_val_elt _kind in
  match axis with
  | Some a -> (
      let m, n, o, s = Owl_utils.reduce_params a x in
      _fold_along (Owl_base_dense_common._min_elt _kind) m n o x s max_val
    )
  | None   -> min' x |> create _kind [|1|]


let min_ ~out ~axis x =
  let _kind = kind x in
  let max_val = Owl_base_dense_common._max_val_elt _kind in
  Genarray.fill out max_val;
  match axis with
  | Some a -> (
      let m, n, o, s = Owl_utils.reduce_params a x in
      let _op = Owl_base_dense_common._min_elt _kind in
      _fold_along ~out _op m n o x s max_val
      |> ignore
    )
  | None   -> (
      let y = flatten out in
      set y [|0|] (min' x)
    )


let max ?axis x =
  let _kind = kind x in
  let min_val = Owl_base_dense_common._min_val_elt _kind in
  match axis with
  | Some a -> (
      let m, n, o, s = Owl_utils.reduce_params a x in
      _fold_along (Owl_base_dense_common._max_elt _kind) m n o x s min_val
    )
  | None   -> max' x |> create _kind [|1|]


let max_ ~out ~axis x =
  let _kind = kind x in
  let min_val = Owl_base_dense_common._min_val_elt _kind in
  Genarray.fill out min_val;
  match axis with
  | Some a -> (
      let m, n, o, s = Owl_utils.reduce_params a x in
      _fold_along ~out (Owl_base_dense_common._max_elt _kind) m n o x s min_val
      |> ignore
    )
  | None   -> (
      let y = flatten out in
      set y [|0|] (max' x)
    )


let l1norm' varr =
  let l1norm_fun =
    (fun aggregate elem -> (aggregate +. (Scalar.abs (elem)))) in
  (_fold_left l1norm_fun 0. varr)


let l2norm_sqr' varr =
  let l2norm_sqr_fun =
    (fun aggregate elem -> (aggregate +. (elem *. elem))) in
  (_fold_left l2norm_sqr_fun 0. varr)


let l2norm' varr =
  let l2norm_sqr_val = l2norm_sqr' varr in
  (Scalar.sqrt l2norm_sqr_val)


let _broadcasted_op ?out varr_a varr_b op_fun =
  let (dims_a, dims_b, dims_c) =
    _get_broadcasted_dims (shape varr_a) (shape varr_b)
  in
  let _kind = kind varr_a in
  let varr_a = reshape varr_a dims_a in
  let varr_b = reshape varr_b dims_b in
  let varr_c = match out with
    | Some out -> out
    | None     -> empty _kind dims_c
  in
  let ind = Array.make (Array.length dims_c) 0 in
  let should_stop = ref false in
  begin
    while not !should_stop do
      let ind_a = _get_broadcasted_index ind dims_a in
      let ind_b = _get_broadcasted_index ind dims_b in
      Genarray.set varr_c ind
        (op_fun (Genarray.get varr_a ind_a) (Genarray.get varr_b ind_b));
      if not (_next_index ind dims_c) then
        should_stop := true
    done;
    varr_c
  end


let add x y =
  let _op = Owl_base_dense_common._add_elt (kind x) in
  _broadcasted_op x y _op


let add_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let _op = Owl_base_dense_common._add_elt (kind x) in
  let sx = shape x in
  let sy = shape y in
  let so = Owl_utils_infer_shape.broadcast1 sx sy in
  assert (shape out = so);
  _broadcasted_op ~out x y _op
  |> ignore


let sub x y =
  let _op = Owl_base_dense_common._sub_elt (kind x) in
  _broadcasted_op x y _op


let sub_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let _op = Owl_base_dense_common._sub_elt (kind x) in
  let sx = shape x in
  let sy = shape y in
  let so = Owl_utils_infer_shape.broadcast1 sx sy in
  assert (shape out = so);
  _broadcasted_op ~out x y _op
  |> ignore


let mul x y =
  let _op = Owl_base_dense_common._mul_elt (kind x) in
  _broadcasted_op x y _op


let mul_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let _op = Owl_base_dense_common._mul_elt (kind x) in
  let sx = shape x in
  let sy = shape y in
  let so = Owl_utils_infer_shape.broadcast1 sx sy in
  assert (shape out = so);
  _broadcasted_op ~out x y _op
  |> ignore


let div x y =
  let _op = Owl_base_dense_common._div_elt (kind x) in
  _broadcasted_op x y _op


let div_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let _op = Owl_base_dense_common._div_elt (kind x) in
  let sx = shape x in
  let sy = shape y in
  let so = Owl_utils_infer_shape.broadcast1 sx sy in
  assert (shape out = so);
  _broadcasted_op ~out x y _op
  |> ignore


let atan2 x y = _broadcasted_op x y (Scalar.atan2)


let atan2_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let sx = shape x in
  let sy = shape y in
  let so = Owl_utils_infer_shape.broadcast1 sx sy in
  assert (shape out = so);
  _broadcasted_op x y (Scalar.atan2)
  |> ignore


let hypot x y = _broadcasted_op x y (Scalar.hypot)


let hypot_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let sx = shape x in
  let sy = shape y in
  let so = Owl_utils_infer_shape.broadcast1 sx sy in
  assert (shape out = so);
  _broadcasted_op x y (Scalar.hypot)
  |> ignore


let pow x y =
  let _kind = kind x in
  let _op = Owl_base_dense_common._pow_elt _kind in
  _broadcasted_op x y _op


let pow_ ?out x y =
  let _kind = kind x in
  let _op = Owl_base_dense_common._pow_elt _kind in
  let out = match out with Some o -> o | None -> x in
  let sx = shape x in
  let sy = shape y in
  let so = Owl_utils_infer_shape.broadcast1 sx sy in
  assert (shape out = so);
  _broadcasted_op ~out x y _op
  |> ignore


let fmod x y = _broadcasted_op x y (Scalar.fmod)


let fmod_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let sx = shape x in
  let sy = shape y in
  let so = Owl_utils_infer_shape.broadcast1 sx sy in
  assert (shape out = so);
  _broadcasted_op x y (Scalar.fmod)
  |> ignore


let min2 x y =
  let _op = Owl_base_dense_common._min_elt (kind x) in
  _broadcasted_op x y _op


let min2_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let _op = Owl_base_dense_common._min_elt (kind x) in
  let sx = shape x in
  let sy = shape y in
  let so = Owl_utils_infer_shape.broadcast1 sx sy in
  assert (shape out = so);
  _broadcasted_op ~out x y _op
  |> ignore


let max2 x y =
  let _op = Owl_base_dense_common._max_elt (kind x) in
  _broadcasted_op x y _op


let max2_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let _op = Owl_base_dense_common._max_elt (kind x) in
  let sx = shape x in
  let sy = shape y in
  let so = Owl_utils_infer_shape.broadcast1 sx sy in
  assert (shape out = so);
  _broadcasted_op ~out x y _op
  |> ignore


let add_scalar x a =
  let _op = Owl_base_dense_common._add_elt (kind x) in
  map (fun y -> _op y a) x


let add_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  let _op = Owl_base_dense_common._add_elt (kind x) in
  map_ (fun y -> _op y a) out


let sub_scalar x a =
  let _op = Owl_base_dense_common._sub_elt (kind x) in
  map (fun y -> _op y a) x


let sub_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  let _op = Owl_base_dense_common._sub_elt (kind x) in
  map_ (fun y -> _op y a) out


let mul_scalar x a =
  let _op = Owl_base_dense_common._mul_elt (kind x) in
  map (fun y -> _op y a) x


let mul_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  let _op = Owl_base_dense_common._mul_elt (kind x) in
  map_ (fun y -> _op y a) out


let div_scalar x a =
  let _op = Owl_base_dense_common._div_elt (kind x) in
  map (fun y -> _op y a) x


let div_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  let _op = Owl_base_dense_common._div_elt (kind x) in
  map_ (fun y -> _op y a) out


let pow_scalar x a =
  let _op = Owl_base_dense_common._pow_elt (kind x) in
  map (fun y -> _op y a) x


let pow_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  let _op = Owl_base_dense_common._pow_elt (kind x) in
  map_ (fun y -> _op y a) out


let atan2_scalar x a =
  let _op = Scalar.atan2 in
  map (fun y -> _op y a) x


let atan2_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  let _op = Scalar.atan2 in
  map_ (fun y -> _op y a) out


let fmod_scalar x a =
  let _op = Scalar.fmod in
  map (fun y -> _op y a) x


let fmod_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  let _op = Scalar.fmod in
  map_ (fun y -> _op y a) out


(* TODO *)
let fma _x _y _z = failwith "Owl_base_dense_ndarray_generic:fma: not implemented"


let scalar_add a x =
  let _op = Owl_base_dense_common._add_elt (kind x) in
  map (fun y -> _op a y) x


let scalar_add_ ?out a x =
  let out = match out with Some o -> o | None -> x in
  let _op = Owl_base_dense_common._add_elt (kind x) in
  map_ (fun y -> _op a y) out


let scalar_sub a x =
  let _op = Owl_base_dense_common._sub_elt (kind x) in
  map (fun y -> _op a y) x


let scalar_sub_ ?out a x =
  let out = match out with Some o -> o | None -> x in
  let _op = Owl_base_dense_common._sub_elt (kind x) in
  map_ (fun y -> _op a y) out


let scalar_mul a x =
  let _op = Owl_base_dense_common._mul_elt (kind x) in
  map (fun y -> _op a y) x


let scalar_mul_ ?out a x =
  let out = match out with Some o -> o | None -> x in
  let _op = Owl_base_dense_common._mul_elt (kind x) in
  map_ (fun y -> _op a y) out


let scalar_div a x =
  let _op = Owl_base_dense_common._div_elt (kind x) in
  map (fun y -> _op a y) x


let scalar_div_ ?out a x =
  let out = match out with Some o -> o | None -> x in
  let _op = Owl_base_dense_common._div_elt (kind x) in
  map_ (fun y -> _op a y) out


let scalar_pow a x =
  let _op = Owl_base_dense_common._pow_elt (kind x) in
  map (fun y -> _op a y) x


let scalar_pow_ ?out a x =
  let out = match out with Some o -> o | None -> x in
  let _op = Owl_base_dense_common._pow_elt (kind x) in
  map_ (fun y -> _op a y) out


let scalar_atan2 a x =
  let _op = Scalar.atan2 in
  map (fun y -> _op a y) x


let scalar_atan2_ ?out a x =
  let out = match out with Some o -> o | None -> x in
  let _op = Scalar.atan2 in
  map_ (fun y -> _op a y) out


let scalar_fmod a x =
  let _op =Scalar.fmod in
  map (fun y -> _op a y) x


let scalar_fmod_ ?out a x =
  let out = match out with Some o -> o | None -> x in
  let _op = Scalar.fmod in
  map_ (fun y -> _op a y) out


let clip_by_value ?(amin=Pervasives.min_float) ?(amax=Pervasives.max_float) x =
  let _op = (fun y -> Pervasives.min amax (Pervasives.max amin y)) in
  map _op x


let clip_by_l2norm clip_norm x =
  let l2norm_val = l2norm' x in
  if l2norm_val > clip_norm then
    mul_scalar x (clip_norm /. l2norm_val)
  else x


let softmax ?(axis=(-1)) x =
  let x = copy x in
  let axis = Owl_utils.adjust_index axis (num_dims x) in
  sub_ ~out:x x (max ~axis x);
  exp_ ~out:x x;
  let a = sum ~axis x in
  div_ ~out:x x a;
  x


let softmax_ ?out ?(axis=(-1)) x =
  let out = match out with Some o -> o | None -> x in
  let axis = Owl_utils.adjust_index axis (num_dims x) in
  sub_ ~out x (max ~axis x);
  exp_ ~out x;
  let a = sum ~axis x in
  div_ ~out x a


(* Comparison functions *)

(** Return true if for all elements comp_fun (xa, xb) == true, false otherwise.
    Returns false as soon as it finds a counterexample. (NOT broadcasted) *)
let _compare_util_shortcircuit varr_a varr_b comp_fun =
  let n = numel varr_a in
  let m = numel varr_b in
  if n != m then
    false
  else
    let varr_a = flatten varr_a |> array1_of_genarray in
    let varr_b = flatten varr_b |> array1_of_genarray in
    let all_ok = ref true in
    let i = ref 0 in (
      while !all_ok && (!i < n) do
        let x = Array1.unsafe_get varr_a !i in
        let y = Array1.unsafe_get varr_b !i in
        if (not (comp_fun x y)) then all_ok := false;
        i := !i + 1
      done;
      !all_ok
    )


let approx_equal ?eps varr_a varr_b =
  let eps = match eps with
    | Some eps -> eps
    | None     -> Owl_utils.eps Float32
  in
  let approx_equal_fun = (fun x y -> (Scalar.abs (Scalar.sub x y)) < eps) in
  (_compare_util_shortcircuit varr_a varr_b approx_equal_fun)


let equal x y =
  (_compare_util_shortcircuit x y Pervasives.(=))


let not_equal x y =
  (_compare_util_shortcircuit x y Pervasives.(<>))


let less x y =
  (_compare_util_shortcircuit x y Pervasives.(<))


let greater x y =
  (_compare_util_shortcircuit x y Pervasives.(>))


let less_equal x y =
  (_compare_util_shortcircuit x y Pervasives.(<=))


let greater_equal x y =
  (_compare_util_shortcircuit x y Pervasives.(>=))


(** Return true if for all elements of a comp_fun (xa, bb) == true, false otherwise.
    Returns false as soon as it finds a counterexample. (NOT broadcasted) *)
let _compare_util_shortcircuit_scalar varr_a b comp_fun =
  let n = numel varr_a in
  let varr_a = flatten varr_a |> array1_of_genarray in
  let all_ok = ref true in
  let i = ref 0 in (
    while !all_ok && (!i < n) do
      let x = Array1.unsafe_get varr_a !i in
      if (not (comp_fun x b))
      then all_ok := false;
      i := !i + 1
    done;
    !all_ok
  )


let approx_equal_scalar ?eps varr_a b =
  let eps = match eps with
    | Some eps -> eps
    | None     -> Owl_utils.eps Float32
  in
  let approx_equal_scalar_fun = (fun x y -> (Scalar.abs (Scalar.sub x y)) < eps) in
  (_compare_util_shortcircuit_scalar varr_a b approx_equal_scalar_fun)


let equal_scalar x a =
  (_compare_util_shortcircuit_scalar x a Pervasives.(=))


let not_equal_scalar x a =
  (_compare_util_shortcircuit_scalar x a Pervasives.(<>))


let less_scalar x a =
  (_compare_util_shortcircuit_scalar x a Pervasives.(<))


let greater_scalar x a =
  (_compare_util_shortcircuit_scalar x a Pervasives.(>))


let less_equal_scalar varr_a b =
  (_compare_util_shortcircuit_scalar varr_a b Pervasives.(<=))


let greater_equal_scalar x a =
  (_compare_util_shortcircuit_scalar x a Pervasives.(>=))


(* Broadcasted operation, return an array with values of 1
   if (one_fun elem_from_a elem_from_b) == true, 0 otherwise *)
let _make_elt_compare_fun kind cmp_fun =
  let c0 = Owl_const.zero kind in
  let c1 = Owl_const.one kind in
  let _func a b = if cmp_fun a b then c1 else c0 in
  _func


let elt_equal x y =
  let _func = _make_elt_compare_fun (kind x) Pervasives.(=) in
  _broadcasted_op x y _func


let elt_equal_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let _func = _make_elt_compare_fun (kind x) Pervasives.(=) in
  _broadcasted_op ~out x y _func


let approx_elt_equal ?eps x y =
  let eps = match eps with
    | Some eps -> eps
    | None     -> Owl_utils.eps Float32
  in
  let approx_equal_fun = (fun x y -> (Scalar.abs (Scalar.sub x y)) < eps) in
  let _func = _make_elt_compare_fun (kind x) approx_equal_fun in
  _broadcasted_op x y _func


let elt_not_equal x y =
  let _func = _make_elt_compare_fun (kind x) Pervasives.(<>) in
  _broadcasted_op x y _func


let elt_not_equal_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let _func = _make_elt_compare_fun (kind x) Pervasives.(<>) in
  _broadcasted_op ~out x y _func


let elt_less x y =
  let _func = _make_elt_compare_fun (kind x) Pervasives.(<) in
  _broadcasted_op x y _func


let elt_less_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let _func = _make_elt_compare_fun (kind x) Pervasives.(<) in
  _broadcasted_op ~out x y _func


let elt_greater x y =
  let _func = _make_elt_compare_fun (kind x) Pervasives.(>) in
  _broadcasted_op x y _func


let elt_greater_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let _func = _make_elt_compare_fun (kind x) Pervasives.(>) in
  _broadcasted_op ~out x y _func


let elt_less_equal x y =
  let _func = _make_elt_compare_fun (kind x) Pervasives.(<=) in
  _broadcasted_op x y _func


let elt_less_equal_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let _func = _make_elt_compare_fun (kind x) Pervasives.(<=) in
  _broadcasted_op ~out x y _func


let elt_greater_equal x y =
  let _func = _make_elt_compare_fun (kind x) Pervasives.(>=) in
  _broadcasted_op x y _func


let elt_greater_equal_ ?out x y =
  let out = match out with Some o -> o | None -> x in
  let _func = _make_elt_compare_fun (kind x) Pervasives.(>=) in
  _broadcasted_op ~out x y _func


(* Util function, return an array with values of 1
    if (one_fun elem_from_a b) == true, 0 otherwise *)
let _make_elt_compare_scalar x cmp_fun =
  let _kind = kind x in
  let c0 = Owl_const.zero _kind in
  let c1 = Owl_const.one _kind in
  let _func a = if cmp_fun a then c1 else c0 in
  _func


let elt_equal_scalar x a =
  let cmp_fun = (fun y -> y = a) in
  let _func = _make_elt_compare_scalar x cmp_fun in
  map _func x


let elt_equal_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  let cmp_fun = (fun y -> y = a) in
  let _func = _make_elt_compare_scalar x cmp_fun in
  map_ _func out


let approx_elt_equal_scalar ?eps x a =
  let eps = match eps with
    | Some eps -> eps
    | None     -> Owl_utils.eps Float32
  in
  let cmp_fun = (fun y -> (Scalar.abs (Scalar.sub y a)) < eps) in
  let _func = _make_elt_compare_scalar x cmp_fun in
  map _func x


let elt_not_equal_scalar x a =
  let cmp_fun = (fun y -> y <> a) in
  let _func = _make_elt_compare_scalar x cmp_fun in
  map _func x


let elt_not_equal_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  let cmp_fun = (fun y -> y <> a) in
  let _func = _make_elt_compare_scalar x cmp_fun in
  map_ _func out


let elt_less_scalar x a =
  let cmp_fun = (fun y -> y < a) in
  let _func = _make_elt_compare_scalar x cmp_fun in
  map _func x


let elt_less_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  let cmp_fun = (fun y -> y < a) in
  let _func = _make_elt_compare_scalar x cmp_fun in
  map_ _func out


let elt_greater_scalar x a =
  let cmp_fun = (fun y -> y > a) in
  let _func = _make_elt_compare_scalar x cmp_fun in
  map _func x


let elt_greater_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  let cmp_fun = (fun y -> y > a) in
  let _func = _make_elt_compare_scalar x cmp_fun in
  map_ _func out


let elt_less_equal_scalar x a =
  let cmp_fun = (fun y -> y <= a) in
  let _func = _make_elt_compare_scalar x cmp_fun in
  map _func x


let elt_less_equal_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  let cmp_fun = (fun y -> y <= a) in
  let _func = _make_elt_compare_scalar x cmp_fun in
  map_ _func out


let elt_greater_equal_scalar x a =
  let cmp_fun = (fun y -> y >= a) in
  let _func = _make_elt_compare_scalar x cmp_fun in
  map _func x


let elt_greater_equal_scalar_ ?out x a =
  let out = match out with Some o -> o | None -> x in
  let cmp_fun = (fun y -> y >= a) in
  let _func = _make_elt_compare_scalar x cmp_fun in
  map _func out


let exists f x =
  let n = numel x in
  let x = flatten x |> array1_of_genarray in
  let found = ref false in
  let i = ref 0 in
  while (!i < n) && (not !found) do
    let a = Array1.unsafe_get x !i in
    if f a then found := true;
    i := !i + 1
  done;
  !found


let not_exists f varr = (not (exists f varr))


let for_all f varr =
  let not_f = (fun x -> not (f x)) in
  (not_exists not_f varr)


let is_zero varr =
  let k = kind varr in
  let c0 = Owl_const.zero k in
  let non_zero_fun = (fun x -> x <> c0) in
  (not_exists non_zero_fun varr)


let is_positive varr =
  let k = kind varr in
  let c0 = Owl_const.zero k in
  let non_positive_fun = (fun x -> x <= c0) in
  (not_exists non_positive_fun varr)


let is_negative varr =
  let k = kind varr in
  let c0 = Owl_const.zero k in
  let non_negative_fun = (fun x -> x >= c0) in
  (not_exists non_negative_fun varr)


let is_nonpositive varr =
  let k = kind varr in
  let c0 = Owl_const.zero k in
  let positive_fun = (fun x -> x > c0) in
  (not_exists positive_fun varr)


let is_nonnegative varr =
  let k = kind varr in
  let c0 = Owl_const.zero k in
  let negative_fun = (fun x -> x < c0) in
  (not_exists negative_fun varr)


let is_normal x =
  let _kind = kind x in
  let is_normal_fun = Owl_base_dense_common._is_normal_elt _kind in
  for_all is_normal_fun x


let not_nan x =
  let _kind = kind x in
  let is_nan_fun = Owl_base_dense_common._is_nan_elt _kind in
  not_exists is_nan_fun x


let not_inf x =
  let _kind = kind x in
  let is_inf_fun = Owl_base_dense_common._is_inf_elt _kind in
  not_exists is_inf_fun x


(* Neural network related functions *)

(*TODO: optimise *)
(* conv2d: 4d input and 4d kernel, refer to tensorlfow doc
   input : [batch; input_column; input_row; input_channel]
   kernel: [kernel_column; kernel_row; input_channel; output_channel]
   stride: [column_stride; row_stride]
   output: [batch; output_column; output_row; output_channel]
*)
let conv2d ?(padding=SAME) input kernel stride =
  assert (num_dims input = 4);
  assert (num_dims kernel = 4);
  assert (Array.length stride = 2);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let in_channel = input_shp.(3) in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let kernel_rows = kernel_shp.(1) in
  let out_channel = kernel_shp.(3) in
  assert (in_channel = kernel_shp.(2));

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in

  let (output_cols, output_rows) =
    Owl_utils_infer_shape.calc_conv2d_output_shape padding input_cols input_rows
      kernel_cols kernel_rows row_stride col_stride
  in
  let _kind = kind input in
  let output = empty _kind [|batches; output_cols; output_rows; out_channel|] in
  let (pad_top, pad_left, _, _) = Owl_utils_infer_shape.calc_conv2d_padding
      input_cols input_rows kernel_cols kernel_rows output_cols output_rows
      row_stride col_stride
  in
  let sum = ref 0. in
  begin
    for b = 0 to batches - 1 do
      for i = 0 to output_cols - 1 do
        for j = 0 to output_rows - 1 do
          for k = 0 to out_channel - 1 do
            sum := 0.;

            for di = 0 to kernel_cols - 1 do
              for dj = 0 to kernel_rows - 1 do
                for q = 0 to in_channel - 1 do
                  let in_col = i * col_stride + di - pad_left in
                  let in_row = j * row_stride + dj - pad_top in
                  let in_val = (
                    if ((0 <= in_col) && (in_col < input_cols) &&
                        (0 <= in_row) && (in_row < input_rows))
                    then (get input [|b; in_col; in_row; q|])
                    else 0.
                  ) in
                  sum := !sum +. in_val *. (get kernel [|di; dj; q; k|])
                done; (*q*)
              done; (*dj*)
            done; (*di*)

            (set output [|b; i; j; k|] !sum)
          done; (*k*)
        done; (*j*)
      done; (*i*)
    done; (*b*)
    output
  end


(* conv1d: 3d input and 3d kernel, refer to tensorlfow doc
   input : [batch; input_column; input_channel]
   kernel: [kernel_column; input_channel; output_channel]
   stride: [column_stride]
   output: [batch; output_column; output_channel]
*)
let conv1d ?(padding=SAME) input kernel stride =
  assert (num_dims input = 3);
  assert (num_dims kernel = 3);
  assert (Array.length stride = 1);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let in_channel = input_shp.(2) in
  let input = reshape input [|batches; 1; input_cols; in_channel|] in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let out_channel = kernel_shp.(2) in
  assert (in_channel = kernel_shp.(1));
  let kernel = reshape kernel [|1; kernel_cols; in_channel; out_channel|] in

  let col_stride = stride.(0) in
  let stride = [|1; col_stride|] in

  let output = conv2d ~padding input kernel stride in
  let output_shp = shape output in
  let output_cols = output_shp.(2) in
  let output = reshape output [|batches; output_cols; out_channel|] in
  output

  (* TODO: optimise *)
  (* conv3d: 5d input and 5d kernel, refer to tensorflow doc
    input : [batch; input_column; input_row; input_depth; input_channel]
    kernel: [kernel_column; kernel_row; kernel_depth; input_channel; output_channel]
    stride: [column_stride; row_stride; depth_stride]
    output: [batch; output_column; output_row; output_dpts; output_channel]
   *)
  let conv3d ?(padding=SAME) input kernel stride =
    assert (num_dims input = 5);
    assert (num_dims kernel = 5);
    assert (Array.length stride = 3);

    let input_shp = shape input in
    let batches = input_shp.(0) in
    let input_cols = input_shp.(1) in
    let input_rows = input_shp.(2) in
    let input_dpts = input_shp.(3) in
    let in_channel = input_shp.(4) in

    let kernel_shp = shape kernel in
    let kernel_cols = kernel_shp.(0) in
    let kernel_rows = kernel_shp.(1) in
    let kernel_dpts = kernel_shp.(2) in
    let out_channel = kernel_shp.(4) in
    assert (in_channel = kernel_shp.(3));

    let col_stride = stride.(0) in
    let row_stride = stride.(1) in
    let dpt_stride = stride.(2) in

    let output_cols, output_rows, output_dpts =
      Owl_utils_infer_shape.calc_conv3d_output_shape padding
        input_cols input_rows input_dpts
        kernel_cols kernel_rows kernel_dpts
        row_stride col_stride dpt_stride
    in
    let _kind = kind input in
    let output =
      empty _kind [|batches; output_cols; output_rows; output_dpts; out_channel|] in
    let (pad_top, pad_left, pad_shallow, _, _, _) =
      Owl_utils_infer_shape.calc_conv3d_padding
        input_cols input_rows input_dpts
        kernel_cols kernel_rows kernel_dpts
        output_cols output_rows output_dpts
        row_stride col_stride dpt_stride
    in
    let sum = ref 0. in
    begin
      for b = 0 to batches - 1 do
        for i = 0 to output_cols - 1 do
          for j = 0 to output_rows - 1 do
            for dpt = 0 to output_dpts - 1 do
              for k = 0 to out_channel - 1 do
                sum := 0.;

                for di = 0 to kernel_cols - 1 do
                  for dj = 0 to kernel_rows - 1 do
                    for d_dpt = 0 to kernel_dpts -1 do
                      for q = 0 to in_channel - 1 do
                        let in_col = i * col_stride + di - pad_left in
                        let in_row = j * row_stride + dj - pad_top in
                        let in_dpt = dpt * dpt_stride + d_dpt - pad_shallow in
                        let in_val = (
                          if ((0 <= in_col) && (in_col < input_cols) &&
                              (0 <= in_row) && (in_row < input_rows) &&
                              (0 <= in_dpt) && (in_dpt < input_dpts))
                          then (get input [|b; in_col; in_row; in_dpt; q|])
                          else 0.
                        ) in
                        sum := !sum +. in_val *. (get kernel [|di; dj; d_dpt; q; k|])
                      done; (*q*)
                    done; (*d_dpt*)
                  done; (*dj*)
                done; (*di*)

                (set output [|b; i; j; dpt; k|] !sum)
              done; (*k*)
            done; (*dpt*)
          done; (*j*)
        done; (*i*)
      done; (*b*)
      output
    end


(* General function for avg_pool2d and max_pool2d *)
let _pool2d ?(padding=SAME) input kernel stride
      init_pool_fun add_val_pool_fun end_pool_fun =
  assert (num_dims input = 4);
  assert (Array.length kernel = 2);
  assert (Array.length stride = 2);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let in_channel = input_shp.(3) in

  let kernel_cols = kernel.(0) in
  let kernel_rows = kernel.(1) in

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in

  let (output_cols, output_rows) =
    Owl_utils_infer_shape.calc_conv2d_output_shape padding
      input_cols input_rows
      kernel_cols kernel_rows
      row_stride col_stride
  in
  let _kind = kind input in
  let output = empty _kind [|batches; output_cols; output_rows; in_channel|] in
  let (pad_top, pad_left, _, _) = Owl_utils_infer_shape.calc_conv2d_padding
      input_cols input_rows kernel_cols kernel_rows output_cols output_rows
      row_stride col_stride
  in
  begin
    for b = 0 to batches - 1 do
      for i = 0 to output_cols - 1 do
        for j = 0 to output_rows - 1 do
          for k = 0 to in_channel - 1 do
            init_pool_fun ();

            for di = 0 to kernel_cols - 1 do
              for dj = 0 to kernel_rows - 1 do
                let in_col = i * col_stride + di - pad_left in
                let in_row = j * row_stride + dj - pad_top in
                if ((0 <= in_col) && (in_col < input_cols) &&
                    (0 <= in_row) && (in_row < input_rows))
                then add_val_pool_fun (get input [|b; in_col; in_row; k|])
              done; (*dj*)
            done; (*di*)

            (set output [|b; i; j; k|] (end_pool_fun ()))
          done; (*k*)
        done; (*j*)
      done; (*i*)
    done; (*b*)
    output
  end


let _pool3d ?(padding=SAME) input kernel stride
    init_pool_fun add_val_pool_fun end_pool_fun =
  assert (num_dims input = 5);
  assert (Array.length kernel = 3);
  assert (Array.length stride = 3);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let input_dpts = input_shp.(3) in
  let in_channel = input_shp.(4) in

  let kernel_cols = kernel.(0) in
  let kernel_rows = kernel.(1) in
  let kernel_dpts = kernel.(2) in

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in
  let dpt_stride = stride.(2) in

  let output_cols, output_rows, output_dpts =
    Owl_utils_infer_shape.calc_conv3d_output_shape padding
      input_cols input_rows input_dpts
      kernel_cols kernel_rows kernel_dpts
      row_stride col_stride dpt_stride
  in
  let _kind = kind input in
  let output = empty _kind [|batches; output_cols; output_rows; output_dpts; in_channel|] in
  let (pad_top, pad_left, pad_shallow, _, _, _) =
    Owl_utils_infer_shape.calc_conv3d_padding
      input_cols input_rows input_dpts
      kernel_cols kernel_rows kernel_dpts
      output_cols output_rows output_dpts
      row_stride col_stride dpt_stride
  in
  begin
    for b = 0 to batches - 1 do
      for i = 0 to output_cols - 1 do
        for j = 0 to output_rows - 1 do
          for dpt = 0 to output_dpts - 1 do
            for k = 0 to in_channel - 1 do
              init_pool_fun ();

              for di = 0 to kernel_cols - 1 do
                for dj = 0 to kernel_rows - 1 do
                  for d_dpt = 0 to kernel_dpts - 1 do
                    let in_col = i * col_stride + di - pad_left in
                    let in_row = j * row_stride + dj - pad_top in
                    let in_dpt = dpt * dpt_stride + d_dpt - pad_shallow in
                    if ((0 <= in_col) && (in_col < input_cols) &&
                        (0 <= in_row) && (in_row < input_rows)  &&
                        (0 <= in_dpt) && (in_dpt < input_dpts))
                    then add_val_pool_fun
                        (get input [|b; in_col; in_row; in_dpt; k|])
                  done; (*d_dpt*)
                done; (*dj*)
              done; (*di*)

              (set output [|b; i; j; dpt; k|] (end_pool_fun ()))
            done; (*k*)
          done; (*dpt*)
        done; (*j*)
      done; (*i*)
    done; (*b*)
    output
  end


(* max_pool2d: 4d input and 2d kernel, refer to tensorlfow doc
   input : [batch; input_column; input_row; input_channel]
   kernel: [kernel_column; kernel_row]
   stride: [column_stride; row_stride]
   output: [batch; output_column; output_row; input_channel]
*)
let max_pool2d ?(padding=SAME) input kernel stride =
  let max_pool = ref 0. in
  let init_pool_fun = (fun () -> max_pool := Pervasives.min_float) in
  let add_val_pool_fun =
    (fun v -> max_pool := Pervasives.max !max_pool v)
  in
  let end_pool_fun = (fun () -> !max_pool) in
  (_pool2d ~padding:padding input kernel stride
     init_pool_fun add_val_pool_fun end_pool_fun)

(* max_pool1d: 3d input and 1d kernel, refer to tensorlfow doc
   input : [batch; input_column; input_channel]
   kernel: [kernel_column]
   stride: [column_stride]
   output: [batch; output_column; input_channel]
*)
let max_pool1d ?(padding=SAME) input kernel stride =
  assert (num_dims input = 3);
  assert (Array.length kernel = 1);
  assert (Array.length stride = 1);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let in_channel = input_shp.(2) in
  let input = reshape input [|batches; 1; input_cols; in_channel|] in

  let kernel_cols = kernel.(0) in
  let kernel = [|1; kernel_cols|] in

  let col_stride = stride.(0) in
  let stride = [|1; col_stride|] in

  let output = max_pool2d ~padding input kernel stride in
  let output_shp = shape output in
  let output_cols = output_shp.(2) in
  let output = reshape output [|batches; output_cols; in_channel|] in
  output


(* max_pool3d: 5d input and 3d kernel, refer to tensorflow doc
input : [batch; input_column; input_row; input_depth; input_channel]
kernel: [kernel_column; kernel_row; kernel_depth]
stride: [column_stride; row_stride; depth_stride]
output: [batch; output_column; output_row; output_dpts; input_channel]
*)
let max_pool3d ?(padding=SAME) input kernel stride =
  let max_pool = ref 0. in
  let init_pool_fun = (fun () -> max_pool := Pervasives.min_float) in
  let add_val_pool_fun =
    (fun v -> max_pool := Pervasives.max !max_pool v)
  in
  let end_pool_fun = (fun () -> !max_pool) in
  (_pool3d ~padding:padding input kernel stride
     init_pool_fun add_val_pool_fun end_pool_fun)


(* similar to max_pool2d *)
let avg_pool2d ?(padding=SAME) input kernel stride =
  let sum_pool = ref 0. in
  let cnt = ref 0. in
  let init_pool_fun = (fun () -> (sum_pool := 0.; cnt := 0.)) in
  let add_val_pool_fun =
    (fun v -> sum_pool := !sum_pool +. v; cnt := !cnt +. 1.)
  in
  let end_pool_fun = (fun () -> (!sum_pool /. !cnt)) in
  (_pool2d ~padding:padding input kernel stride
     init_pool_fun add_val_pool_fun end_pool_fun)


(* similar to max_pool1d *)
let avg_pool1d ?(padding=SAME) input kernel stride =
  assert (num_dims input = 3);
  assert (Array.length kernel = 1);
  assert (Array.length stride = 1);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let in_channel = input_shp.(2) in
  let input = reshape input [|batches; 1; input_cols; in_channel|] in

  let kernel_cols = kernel.(0) in
  let kernel = [|1; kernel_cols|] in

  let col_stride = stride.(0) in
  let stride = [|1; col_stride|] in

  let output = avg_pool2d ~padding input kernel stride in
  let output_shp = shape output in
  let output_cols = output_shp.(2) in
  let output = reshape output [|batches; output_cols; in_channel|] in
  output


(* simiar to max_pool3d *)
let avg_pool3d ?(padding=SAME) input kernel stride =
  let sum_pool = ref 0. in
  let cnt = ref 0. in
  let init_pool_fun = (fun () -> (sum_pool := 0.; cnt := 0.)) in
  let add_val_pool_fun =
    (fun v -> sum_pool := !sum_pool +. v; cnt := !cnt +. 1.)
  in
  let end_pool_fun = (fun () -> (!sum_pool /. !cnt)) in
  (_pool3d ~padding:padding input kernel stride
     init_pool_fun add_val_pool_fun end_pool_fun)


(*TODO: optimise *)
(* gradient of conv2d w.r.t the input *)
let conv2d_backward_input input kernel stride output' =
  assert (num_dims input = 4);
  assert (num_dims kernel = 4);
  assert (num_dims output' = 4);
  assert (Array.length stride = 2);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let in_channel = input_shp.(3) in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let kernel_rows = kernel_shp.(1) in
  let out_channel = kernel_shp.(3) in
  assert (in_channel = kernel_shp.(2));

  let output_shp = shape output' in
  let output_cols = output_shp.(1) in
  let output_rows = output_shp.(2) in
  assert (batches = output_shp.(0));
  assert (out_channel = output_shp.(3));

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in

  let input' = empty (kind input) (shape input) in
  let (pad_top, pad_left, _, _) = Owl_utils_infer_shape.calc_conv2d_padding
      input_cols input_rows kernel_cols kernel_rows output_cols output_rows
      row_stride col_stride
  in
  begin
    for b = 0 to batches - 1 do
      for in_i = 0 to input_cols - 1 do
        for in_j = 0 to input_rows - 1 do
          for q = 0 to in_channel - 1 do
            let sum = ref 0. in

            for di = 0 to kernel_cols - 1 do
              for dj = 0 to kernel_rows - 1 do
                if ( ((Pervasives.(mod) (in_i + pad_left - di) col_stride) = 0) &&
                     ((Pervasives.(mod) (in_j + pad_top - dj) row_stride) = 0) )
                then
                  begin
                    let out_col = (in_i + pad_left - di) / col_stride in
                    let out_row = (in_j + pad_top - dj) / row_stride in
                    if ((0 <= out_col) && (out_col < output_cols) &&
                        (0 <= out_row) && (out_row < output_rows))
                    then
                      for k = 0 to out_channel - 1 do
                        let out_grad = get output' [|b; out_col; out_row; k|] in
                        let kernel_val = get kernel [|di; dj; q; k|] in
                        sum := !sum +. out_grad *. kernel_val
                      done; (*k*)
                  end
              done; (*dj*)
            done; (*di*)

            (set input' [|b; in_i; in_j; q|] !sum)
          done; (*q*)
        done; (*in_j*)
      done; (*in_i*)
    done; (*b*)
    input'
  end


(* gradient of conv2d w.r.t the kernel *)
let conv2d_backward_kernel input kernel stride output' =
  assert (num_dims input = 4);
  assert (num_dims kernel = 4);
  assert (num_dims output' = 4);
  assert (Array.length stride = 2);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let in_channel = input_shp.(3) in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let kernel_rows = kernel_shp.(1) in
  let out_channel = kernel_shp.(3) in
  assert (in_channel = kernel_shp.(2));

  let output_shp = shape output' in
  let output_cols = output_shp.(1) in
  let output_rows = output_shp.(2) in
  assert (batches = output_shp.(0));
  assert (out_channel = output_shp.(3));

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in

  let kernel' = empty (kind kernel) (shape kernel) in

  let (pad_top, pad_left, _, _) = Owl_utils_infer_shape.calc_conv2d_padding
      input_cols input_rows kernel_cols kernel_rows output_cols output_rows
      row_stride col_stride
  in
  begin
    for di = 0 to kernel_cols - 1 do
      for dj = 0 to kernel_rows - 1 do
        for q = 0 to in_channel - 1 do
          for k = 0 to out_channel - 1 do
            let sum = ref 0. in

            for b = 0 to batches - 1 do
              for i = 0 to output_cols - 1 do
                for j = 0 to output_rows - 1 do
                  let in_col = i * col_stride + di - pad_left in
                  let in_row = j * row_stride + dj - pad_top in
                  if ((0 <= in_col) && (in_col < input_cols) &&
                      (0 <= in_row) && (in_row < input_rows))
                  then
                    let out_grad = get output' [|b; i; j; k|] in
                    let input_val = get input [|b; in_col; in_row; q|] in
                    sum := !sum +. out_grad *. input_val
                done; (*j*)
              done; (*i*)
            done; (*b*)

            set kernel' [|di; dj; q; k|] !sum
          done; (*k*)
        done; (*q*)
      done; (*dj*)
    done; (*di*)
    kernel'
  end


let transpose ?axis varr =
  let dims = shape varr in
  let rank = Array.length dims in
  let axis_perm = match axis with
    | Some perm -> perm
    | None -> Array.init rank (fun i -> rank - i - 1)
  in
  let new_dims = _apply_perm dims axis_perm in
  let new_varr = empty (kind varr) new_dims in
  let ind = Array.make rank 0 in
  let should_stop = ref false in
  begin
    while not !should_stop do
      Genarray.set new_varr
        (_apply_perm ind axis_perm) (Genarray.get varr ind);
      if not (_next_index ind dims) then
        should_stop := true
    done;
    new_varr
  end


(* transpose_conv2d: 4d input and 4d kernel, refer to tensorlfow doc
  input : [batch; input_column; input_row; input_channel]
  kernel: [kernel_column; kernel_row; input_channel; output_channel]
  stride: [column_stride; row_stride]
  output: [batch; output_column; output_row; output_channel]
 *)
let transpose_conv2d ?(padding=SAME) input kernel stride =
  assert (num_dims input = 4);
  assert (num_dims kernel = 4);
  assert (Array.length stride = 2);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let in_channel = input_shp.(3) in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let kernel_rows = kernel_shp.(1) in
  let out_channel = kernel_shp.(3) in
  assert (in_channel = kernel_shp.(2));

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in

  let output_cols, output_rows = Owl_utils_infer_shape.calc_transpose_conv2d_output_shape
    padding input_cols input_rows kernel_cols kernel_rows
    row_stride col_stride
  in
  let output' = empty (kind input) [|batches; output_cols; output_rows;
    out_channel|]
  in
  let kernel = transpose ~axis:[|0;1;3;2|] kernel in
  conv2d_backward_input output' kernel stride input


(* gradient of transpose_conv2d w.r.t the input *)
let transpose_conv2d_backward_input input kernel stride output' =
  assert (num_dims input = 4);
  assert (num_dims kernel = 4);
  assert (num_dims output' = 4);
  assert (Array.length stride = 2);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let in_channel = input_shp.(3) in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let kernel_rows = kernel_shp.(1) in
  let out_channel = kernel_shp.(3) in
  assert (in_channel = kernel_shp.(2));

  let output_shp = shape output' in
  let output_cols = output_shp.(1) in
  let output_rows = output_shp.(2) in
  assert (batches = output_shp.(0));
  assert (out_channel = output_shp.(3));

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in

  let padding = SAME in
  let output_cols_same, output_rows_same =
    Owl_utils_infer_shape.calc_transpose_conv2d_output_shape
      padding input_cols input_rows kernel_cols kernel_rows
      row_stride col_stride
  in

  let p = if ((output_cols_same = output_cols)
    && (output_rows_same = output_rows) ) then SAME else VALID
  in
  let kernel = transpose ~axis:[|0;1;3;2|] kernel in
  conv2d ~padding:p output' kernel stride


(* gradient of transpose_conv2d w.r.t the kernel *)
let transpose_conv2d_backward_kernel input kernel stride output' =
  conv2d_backward_kernel output' kernel stride input


(* transpose_conv1d: 3d input and 3d kernel, refer to tensorlfow doc
   input : [batch; input_column; input_channel]
   kernel: [kernel_column; input_channel; output_channel]
   stride: [column_stride]
   output: [batch; output_column; output_channel]
 *)
let transpose_conv1d ?(padding=SAME) input kernel stride =
  assert (num_dims input = 3);
  assert (num_dims kernel = 3);
  assert (Array.length stride = 1);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let in_channel = input_shp.(2) in
  let input = reshape input [|batches; 1; input_cols; in_channel|] in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let out_channel = kernel_shp.(2) in
  assert (in_channel = kernel_shp.(1));
  let kernel = reshape kernel [|1; kernel_cols; in_channel; out_channel|] in

  let col_stride = stride.(0) in
  let stride = [|1; col_stride|] in

  let output = transpose_conv2d ~padding input kernel stride in
  let output_shp = shape output in
  let output_cols = output_shp.(2) in
  let output = reshape output [|batches; output_cols; out_channel|] in
  output


(* gradient of conv1d w.r.t the input *)
let conv1d_backward_input input kernel stride output' =
  assert (num_dims input = 3);
  assert (num_dims kernel = 3);
  assert (num_dims output' = 3);
  assert (Array.length stride = 1);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let in_channel = input_shp.(2) in
  let input_rows = 1 in
  let input = reshape input [|batches; input_rows; input_cols; in_channel|] in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let out_channel = kernel_shp.(2) in
  assert (in_channel = kernel_shp.(1));
  let kernel_rows = 1 in
  let kernel = reshape kernel [|kernel_rows; kernel_cols; in_channel; out_channel|] in

  let output'_shp = shape output' in
  let output_cols = output'_shp.(1) in
  assert (batches = output'_shp.(0));
  assert (out_channel = output'_shp.(2));
  let output_rows = 1 in
  let output' = reshape output' [|batches; output_rows; output_cols; out_channel|] in

  let col_stride = stride.(0) in
  let row_stride = 1 in
  let stride = [|row_stride; col_stride|] in

  let input' = conv2d_backward_input input kernel stride output' in
  reshape input' input_shp


(* gradient of conv1d w.r.t the kernel *)
let conv1d_backward_kernel input kernel stride output' =
  assert (num_dims input = 3);
  assert (num_dims kernel = 3);
  assert (num_dims output' = 3);
  assert (Array.length stride = 1);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let in_channel = input_shp.(2) in
  let input_rows = 1 in
  let input = reshape input [|batches; input_rows; input_cols; in_channel|] in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let out_channel = kernel_shp.(2) in
  assert (in_channel = kernel_shp.(1));
  let kernel_rows = 1 in
  let kernel = reshape kernel [|kernel_rows; kernel_cols; in_channel; out_channel|] in

  let output'_shp = shape output' in
  let output_cols = output'_shp.(1) in
  assert (batches = output'_shp.(0));
  assert (out_channel = output'_shp.(2));
  let output_rows = 1 in
  let output' = reshape output' [|batches; output_rows; output_cols; out_channel|] in

  let col_stride = stride.(0) in
  let row_stride = 1 in
  let stride = [|row_stride; col_stride|] in

  let kernel' = conv2d_backward_kernel input kernel stride output' in
  reshape kernel' kernel_shp


(* gradient of transpose_conv1d w.r.t the input *)
let transpose_conv1d_backward_input input kernel stride output' =
  assert (num_dims input = 3);
  assert (num_dims kernel = 3);
  assert (num_dims output' = 3);
  assert (Array.length stride = 1);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let in_channel = input_shp.(2) in
  let input_rows = 1 in
  let input = reshape input [|batches; input_rows; input_cols; in_channel|] in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let out_channel = kernel_shp.(2) in
  assert (in_channel = kernel_shp.(1));
  let kernel_rows = 1 in
  let kernel = reshape kernel [|kernel_rows; kernel_cols; in_channel; out_channel|] in

  let output'_shp = shape output' in
  let output_cols = output'_shp.(1) in
  assert (batches = output'_shp.(0));
  assert (out_channel = output'_shp.(2));
  let output_rows = 1 in
  let output' = reshape output' [|batches; output_rows; output_cols; out_channel|] in

  let col_stride = stride.(0) in
  let row_stride = 1 in
  let stride = [|row_stride; col_stride|] in

  let input' = transpose_conv2d_backward_input input kernel stride output' in
  reshape input' input_shp


(* gradient of conv1d w.r.t the kernel *)
let transpose_conv1d_backward_kernel input kernel stride output' =
  assert (num_dims input = 3);
  assert (num_dims kernel = 3);
  assert (num_dims output' = 3);
  assert (Array.length stride = 1);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let in_channel = input_shp.(2) in
  let input_rows = 1 in
  let input = reshape input [|batches; input_rows; input_cols; in_channel|] in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let out_channel = kernel_shp.(2) in
  assert (in_channel = kernel_shp.(1));
  let kernel_rows = 1 in
  let kernel = reshape kernel [|kernel_rows; kernel_cols; in_channel; out_channel|] in

  let output'_shp = shape output' in
  let output_cols = output'_shp.(1) in
  assert (batches = output'_shp.(0));
  assert (out_channel = output'_shp.(2));
  let output_rows = 1 in
  let output' = reshape output' [|batches; output_rows; output_cols; out_channel|] in

  let col_stride = stride.(0) in
  let row_stride = 1 in
  let stride = [|row_stride; col_stride|] in

  let kernel' = transpose_conv2d_backward_kernel input kernel stride output' in
  reshape kernel' kernel_shp


(*TODO: optimise *)
(* gradient of conv3d w.r.t the input *)
let conv3d_backward_input input kernel stride output' =
  assert (num_dims input = 5);
  assert (num_dims kernel = 5);
  assert (num_dims output' = 5);
  assert (Array.length stride = 3);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let input_dpts = input_shp.(3) in
  let in_channel = input_shp.(4) in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let kernel_rows = kernel_shp.(1) in
  let kernel_dpts = kernel_shp.(2) in
  let out_channel = kernel_shp.(4) in
  assert (in_channel = kernel_shp.(3));

  let output_shp = shape output' in
  let output_cols = output_shp.(1) in
  let output_rows = output_shp.(2) in
  let output_dpts =  output_shp.(3) in
  assert (batches = output_shp.(0));
  assert (out_channel = output_shp.(4));

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in
  let dpt_stride = stride.(2) in

  let input' = empty (kind input) (shape input) in
  let (pad_top, pad_left, pad_shallow, _, _, _) =
    Owl_utils_infer_shape.calc_conv3d_padding
      input_cols input_rows input_dpts
      kernel_cols kernel_rows kernel_dpts
      output_cols output_rows output_dpts
      row_stride col_stride dpt_stride
  in
  begin
    for b = 0 to batches - 1 do
      for in_i = 0 to input_cols - 1 do
        for in_j = 0 to input_rows - 1 do
          for in_dpt = 0 to input_dpts - 1 do
            for q = 0 to in_channel - 1 do
              let sum = ref 0. in

              for di = 0 to kernel_cols - 1 do
                for dj = 0 to kernel_rows - 1 do
                  for d_dpt = 0 to kernel_dpts - 1 do
                    if ( ((Pervasives.(mod) (in_i + pad_left - di) col_stride) = 0) &&
                         ((Pervasives.(mod) (in_j + pad_top - dj) row_stride) = 0) &&
                         ((Pervasives.(mod) (in_dpt + pad_shallow - d_dpt) dpt_stride) = 0))
                    then
                      begin
                        let out_col = (in_i + pad_left - di) / col_stride in
                        let out_row = (in_j + pad_top - dj) / row_stride in
                        let out_dpt = (in_dpt + pad_shallow - d_dpt) / dpt_stride in
                        if ((0 <= out_col) && (out_col < output_cols) &&
                            (0 <= out_row) && (out_row < output_rows) &&
                            (0 <= out_dpt) && (out_dpt < output_dpts))
                        then
                          for k = 0 to out_channel - 1 do
                            let out_grad = get output' [|b; out_col; out_row; out_dpt; k|] in
                            let kernel_val = get kernel [|di; dj; d_dpt; q; k|] in
                            sum := !sum +. out_grad *. kernel_val
                          done; (*k*)
                      end
                done; (*d_dpt*)
                done; (*dj*)
              done; (*di*)

              (set input' [|b; in_i; in_j; in_dpt; q|] !sum)
            done; (*q*)
          done; (*in_dpt*)
        done; (*in_j*)
      done; (*in_i*)
    done; (*b*)
    input'
  end


  (* gradient of conv3d w.r.t the kernel *)
let conv3d_backward_kernel input kernel stride output' =
  assert (num_dims input = 5);
  assert (num_dims kernel = 5);
  assert (num_dims output' = 5);
  assert (Array.length stride = 3);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let input_dpts = input_shp.(3) in
  let in_channel = input_shp.(4) in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let kernel_rows = kernel_shp.(1) in
  let kernel_dpts = kernel_shp.(2) in
  let out_channel = kernel_shp.(4) in
  assert (in_channel = kernel_shp.(3));

  let output_shp = shape output' in
  let output_cols = output_shp.(1) in
  let output_rows = output_shp.(2) in
  let output_dpts =  output_shp.(3) in
  assert (batches = output_shp.(0));
  assert (out_channel = output_shp.(4));

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in
  let dpt_stride = stride.(2) in

  let kernel' = empty (kind kernel) (shape kernel) in

  let (pad_top, pad_left, pad_shallow, _, _, _) =
    Owl_utils_infer_shape.calc_conv3d_padding
      input_cols input_rows input_dpts
      kernel_cols kernel_rows kernel_dpts
      output_cols output_rows output_dpts
      row_stride col_stride dpt_stride
  in
  begin
    for di = 0 to kernel_cols - 1 do
      for dj = 0 to kernel_rows - 1 do
        for d_dpt = 0 to kernel_dpts - 1 do
          for q = 0 to in_channel - 1 do
            for k = 0 to out_channel - 1 do
              let sum = ref 0. in

              for b = 0 to batches - 1 do
                for i = 0 to output_cols - 1 do
                  for j = 0 to output_rows - 1 do
                    for dpt = 0 to output_dpts - 1 do
                      let in_col = i * col_stride + di - pad_left in
                      let in_row = j * row_stride + dj - pad_top in
                      let in_dpt = dpt * dpt_stride + d_dpt - pad_shallow in
                      if ((0 <= in_col) && (in_col < input_cols) &&
                          (0 <= in_row) && (in_row < input_rows) &&
                          (0 <= in_dpt) && (in_dpt < input_dpts))
                      then
                        let out_grad = get output' [|b; i; j; dpt; k|] in
                        let input_val = get input [|b; in_col; in_row; in_dpt; q|] in
                        sum := !sum +. out_grad *. input_val
                    done; (*dpt*)
                  done; (*j*)
                done; (*i*)
              done; (*b*)

              set kernel' [|di; dj; d_dpt; q; k|] !sum
            done; (*k*)
          done; (*q*)
        done; (*d_dpt*)
      done; (*dj*)
    done; (*di*)
    kernel'
  end


(* transpose_conv3d: 5d input and 5d kernel, refer to tensorflow doc
  input : [batch; input_column; input_row; input_depth; input_channel]
  kernel: [kernel_column; kernel_row; kernel_depth; input_channel; output_channel]
  stride: [column_stride; row_stride; depth_stride]
  output: [batch; output_column; output_row; output_dpts; output_channel]
 *)
let transpose_conv3d ?(padding=SAME) input kernel stride =
  assert (num_dims input = 5);
  assert (num_dims kernel = 5);
  assert (Array.length stride = 3);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let input_dpts = input_shp.(3) in
  let in_channel = input_shp.(4) in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let kernel_rows = kernel_shp.(1) in
  let kernel_dpts = kernel_shp.(2) in
  let out_channel = kernel_shp.(4) in
  assert (in_channel = kernel_shp.(3));

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in
  let dpt_stride = stride.(2) in

  let output_cols, output_rows, output_dpts =
    Owl_utils_infer_shape.calc_conv3d_output_shape padding input_cols input_rows input_dpts kernel_cols kernel_rows kernel_dpts row_stride col_stride dpt_stride
  in
  let output = empty (kind input) [|batches; output_cols; output_rows; output_dpts; out_channel|] in

  let kernel = transpose ~axis:[|0;1;2;4;3|] kernel in
  conv3d_backward_input output kernel stride input


(* gradient of transpose_conv3d w.r.t the input *)
let transpose_conv3d_backward_input input kernel stride output' =
  assert (num_dims input = 5);
  assert (num_dims kernel = 5);
  assert (num_dims output' = 5);
  assert (Array.length stride = 3);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let input_dpts = input_shp.(3) in
  let in_channel = input_shp.(4) in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let kernel_rows = kernel_shp.(1) in
  let kernel_dpts = kernel_shp.(2) in
  let out_channel = kernel_shp.(4) in
  assert (in_channel = kernel_shp.(3));

  let output_shp = shape output' in
  let output_cols = output_shp.(1) in
  let output_rows = output_shp.(2) in
  let output_dpts =  output_shp.(3) in
  assert (batches = output_shp.(0));
  assert (out_channel = output_shp.(4));

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in
  let dpt_stride = stride.(2) in

  let padding = SAME in
  let output_cols_same, output_rows_same, output_dpts_same =
    Owl_utils_infer_shape.calc_conv3d_output_shape padding
      input_cols input_rows input_dpts
      kernel_cols kernel_rows kernel_dpts
      row_stride col_stride dpt_stride
  in
  let p = if ((output_cols_same = output_cols)
    && (output_rows_same = output_rows)
    && (output_dpts_same = output_dpts)) then SAME else VALID
  in
  let kernel = transpose ~axis:[|0;1;2;4;3|] kernel in
  conv3d ~padding:p output' kernel stride


(* gradient of transpose_conv3d w.r.t the kernel *)
let transpose_conv3d_backward_kernel input kernel stride output' =
  conv3d_backward_kernel output' kernel stride input


(* TODO: definitely optimise *)
(* General function for avg_pool2d and max_pool2d *)
let _pool2d_backward _padding input kernel stride output'
    init_pool_fun add_val_pool_fun end_pool_fun compute_grad_fun =
  assert (num_dims input = 4);
  assert (Array.length kernel = 2);
  assert (Array.length stride = 2);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let in_channel = input_shp.(3) in

  let kernel_cols = kernel.(0) in
  let kernel_rows = kernel.(1) in

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in

  let output_shp = shape output' in
  let output_cols = output_shp.(1) in
  let output_rows = output_shp.(2) in
  assert (batches = output_shp.(0));
  assert (in_channel = output_shp.(3));

  let (pad_top, pad_left, _, _) = Owl_utils_infer_shape.calc_conv2d_padding
      input_cols input_rows kernel_cols kernel_rows output_cols output_rows
      row_stride col_stride
  in
  let input' = zeros (kind input) (shape input) in
  begin
    for b = 0 to batches - 1 do
      for i = 0 to output_cols - 1 do
        for j = 0 to output_rows - 1 do
          for k = 0 to in_channel - 1 do
            init_pool_fun ();

            for di = 0 to kernel_cols - 1 do
              for dj = 0 to kernel_rows - 1 do
                let in_col = i * col_stride + di - pad_left in
                let in_row = j * row_stride + dj - pad_top in
                if ((0 <= in_col) && (in_col < input_cols) &&
                    (0 <= in_row) && (in_row < input_rows))
                then add_val_pool_fun (get input [|b; in_col; in_row; k|])
              done; (*dj*)
            done; (*di*)

            let output_val = end_pool_fun () in
            let output_grad = get output' [|b; i; j; k|] in
            for di = 0 to kernel_cols - 1 do
              for dj = 0 to kernel_rows - 1 do
                let in_col = i * col_stride + di - pad_left in
                let in_row = j * row_stride + dj - pad_top in
                if ((0 <= in_col) && (in_col < input_cols) &&
                    (0 <= in_row) && (in_row < input_rows))
                then
                  let input_val = (get input [|b; in_col; in_row; k|]) in
                  let input_grad = (get input' [|b; in_col; in_row; k|]) in
                  set input' [|b; in_col; in_row; k|] (compute_grad_fun input_val input_grad output_val output_grad)
              done; (*dj*)
            done; (*di*)

          done; (*k*)
        done; (*j*)
      done; (*i*)
    done; (*b*)
    input'
  end


(* calculate the gradient of max_pool2d *)
let max_pool2d_backward padding input kernel stride output' =
  let max_pool = ref 0. in
  let init_pool_fun = (fun () -> max_pool := Pervasives.min_float) in
  let add_val_pool_fun =
    (fun v -> max_pool := Pervasives.max !max_pool v)
  in
  let end_pool_fun = (fun () -> !max_pool) in
  let compute_grad_fun = (fun input_val input_grad output_val output_grad ->
      if ((Scalar.abs (input_val -. output_val)) < 1e-8) (*TODO: change comparison here *)
      then input_grad +. output_grad
      else input_grad
    ) in
  (_pool2d_backward padding input kernel stride output'
     init_pool_fun add_val_pool_fun end_pool_fun compute_grad_fun)


(* calculate the gradient of avg_pool2d *)
let avg_pool2d_backward padding input kernel stride output' =
  let sum_pool = ref 0. in
  let cnt = ref 0. in
  let init_pool_fun = (fun () -> (sum_pool := 0.; cnt := 0.)) in
  let add_val_pool_fun =
    (fun v -> sum_pool := !sum_pool +. v; cnt := !cnt +. 1.)
  in
  let end_pool_fun = (fun () -> (!sum_pool /. !cnt)) in
  let compute_grad_fun =
    (fun _input_val input_grad _output_val output_grad ->
       input_grad +. output_grad /. !cnt)
  in
  (_pool2d_backward padding input kernel stride output'
     init_pool_fun add_val_pool_fun end_pool_fun compute_grad_fun)


(* TODO: definitely optimise *)
(* General function for avg_pool3d and max_pool3d *)
let _pool3d_backward _padding input kernel stride output'
    init_pool_fun add_val_pool_fun end_pool_fun compute_grad_fun =
  assert (num_dims input = 5);
  assert (Array.length kernel = 3);
  assert (Array.length stride = 3);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let input_dpts = input_shp.(3) in
  let in_channel = input_shp.(4) in

  let kernel_cols = kernel.(0) in
  let kernel_rows = kernel.(1) in
  let kernel_dpts = kernel.(2) in

  let col_stride = stride.(0) in
  let row_stride = stride.(1) in
  let dpt_stride = stride.(2) in

  let output_shp = shape output' in
  let output_cols = output_shp.(1) in
  let output_rows = output_shp.(2) in
  let output_dpts = output_shp.(3) in
  assert (batches = output_shp.(0));
  assert (in_channel = output_shp.(4));

  let (pad_top, pad_left, pad_shallow, _, _, _) =
    Owl_utils_infer_shape.calc_conv3d_padding
      input_cols input_rows input_dpts
      kernel_cols kernel_rows kernel_dpts
      output_cols output_rows output_dpts
      row_stride col_stride dpt_stride
  in
  let input' = zeros (kind input) (shape input) in
  begin
    for b = 0 to batches - 1 do
      for i = 0 to output_cols - 1 do
        for j = 0 to output_rows - 1 do
          for dpt = 0 to output_dpts - 1 do
            for k = 0 to in_channel - 1 do
              init_pool_fun ();

              for di = 0 to kernel_cols - 1 do
                for dj = 0 to kernel_rows - 1 do
                  for dk = 0 to kernel_dpts - 1 do
                    let in_col = i * col_stride + di - pad_left in
                    let in_row = j * row_stride + dj - pad_top in
                    let in_dpt = dpt * dpt_stride + dk - pad_shallow in
                    if ((0 <= in_col) && (in_col < input_cols) &&
                        (0 <= in_row) && (in_row < input_rows) &&
                        (0 <= in_dpt) && (in_dpt < input_dpts))
                    then add_val_pool_fun (get input [|b; in_col; in_row; in_dpt; k|])
                  done; (*dk*)
                done; (*dj*)
              done; (*di*)

              let output_val = end_pool_fun () in
              let output_grad = get output' [|b; i; j; dpt; k|] in
              for di = 0 to kernel_cols - 1 do
                for dj = 0 to kernel_rows - 1 do
                  for dk = 0 to kernel_dpts - 1 do
                    let in_col = i * col_stride + di - pad_left in
                    let in_row = j * row_stride + dj - pad_top in
                    let in_dpt = dpt * dpt_stride + dk - pad_shallow in
                    if ((0 <= in_col) && (in_col < input_cols) &&
                        (0 <= in_row) && (in_row < input_rows) &&
                        (0 <= in_dpt) && (in_dpt < input_dpts))
                    then
                      let input_val = (get input [|b; in_col; in_row; in_dpt; k|]) in
                      let input_grad = (get input' [|b; in_col; in_row; in_dpt; k|]) in
                      set input' [|b; in_col; in_row; in_dpt; k|]
                       (compute_grad_fun input_val input_grad output_val output_grad)
                  done; (*dk*)
                done; (*dj*)
              done; (*di*)

            done; (*k*)
          done; (*dpt*)
        done; (*j*)
      done; (*i*)
    done; (*b*)
    input'
  end


(* calculate the gradient of max_pool3d *)
let max_pool3d_backward padding input kernel stride output' =
  let max_pool = ref 0. in
  let init_pool_fun = (fun () -> max_pool := Pervasives.min_float) in
  let add_val_pool_fun =
    (fun v -> max_pool := Pervasives.max !max_pool v)
  in
  let end_pool_fun = (fun () -> !max_pool) in
  let compute_grad_fun = (fun input_val input_grad output_val output_grad ->
      if ((Scalar.abs (input_val -. output_val)) < 1e-8) (*TODO: change comparison here *)
      then input_grad +. output_grad
      else input_grad
    ) in
  (_pool3d_backward padding input kernel stride output'
     init_pool_fun add_val_pool_fun end_pool_fun compute_grad_fun)


(* calculate the gradient of avg_pool3d *)
let avg_pool3d_backward padding input kernel stride output' =
  let sum_pool = ref 0. in
  let cnt = ref 0. in
  let init_pool_fun = (fun () -> (sum_pool := 0.; cnt := 0.)) in
  let add_val_pool_fun =
    (fun v -> sum_pool := !sum_pool +. v; cnt := !cnt +. 1.)
  in
  let end_pool_fun = (fun () -> (!sum_pool /. !cnt)) in
  let compute_grad_fun =
    (fun _input_val input_grad _output_val output_grad ->
       input_grad +. output_grad /. !cnt)
  in
  (_pool3d_backward padding input kernel stride output'
     init_pool_fun add_val_pool_fun end_pool_fun compute_grad_fun)


(* calculate the gradient of max_pool1d *)
let max_pool1d_backward padding input kernel stride output' =
  assert (num_dims input = 3);
  assert (Array.length kernel = 1);
  assert (Array.length stride = 1);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = 1 in
  let in_channel = input_shp.(2) in
  let input = reshape input [|batches; input_rows; input_cols; in_channel|] in

  let kernel_cols = kernel.(0) in
  let kernel_rows = 1 in
  let kernel = [|kernel_rows; kernel_cols|] in

  let col_stride = stride.(0) in
  let row_stride = 1 in
  let stride = [|row_stride; col_stride|] in

  let output'_shp = shape output' in
  let output_cols = output'_shp.(1) in
  let output_rows = 1 in
  let out_channel = output'_shp.(2) in
  let output' = reshape output' [|batches; output_rows; output_cols; out_channel|] in

  let input' = max_pool2d_backward padding input kernel stride output' in
  reshape input' input_shp


(* calculate the gradient of avg_pool1d *)
let avg_pool1d_backward padding input kernel stride output' =
  assert (num_dims input = 3);
  assert (Array.length kernel = 1);
  assert (Array.length stride = 1);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = 1 in
  let in_channel = input_shp.(2) in
  let input = reshape input [|batches; input_rows; input_cols; in_channel|] in

  let kernel_cols = kernel.(0) in
  let kernel_rows = 1 in
  let kernel = [|kernel_rows; kernel_cols|] in

  let col_stride = stride.(0) in
  let row_stride = 1 in
  let stride = [|row_stride; col_stride|] in

  let output'_shp = shape output' in
  let output_cols = output'_shp.(1) in
  let output_rows = 1 in
  let out_channel = output'_shp.(2) in
  let output' = reshape output' [|batches; output_rows; output_cols; out_channel|] in

  let input' = avg_pool2d_backward padding input kernel stride output' in
  reshape input' input_shp


(* create a dilated 2d kernel *)
let upsample_kernel2d kernel rate =
  if rate = [|1; 1|] then kernel else (
    let kernel_shp  = shape kernel in
    let kernel_cols = kernel_shp.(0) in
    let kernel_rows = kernel_shp.(1) in
    let in_channel  = kernel_shp.(2) in
    let out_channel = kernel_shp.(3) in
    let col_rate    = rate.(0) in
    let row_rate    = rate.(1) in

    let col_up = kernel_cols + (kernel_cols - 1) * (col_rate - 1) in
    let row_up = kernel_rows + (kernel_rows - 1) * (row_rate - 1) in
    let new_kernel = zeros (kind kernel)
      [|col_up; row_up; in_channel; out_channel|] in

    for c = 0 to (kernel_cols - 1) do
      for r = 0 to (kernel_rows - 1) do
        for i = 0 to (in_channel - 1) do
          for o = 0 to (out_channel - 1) do
            let v = get kernel [|c; r; i; o|] in
            set new_kernel [|c * col_rate; r * row_rate; i; o|] v;
          done
        done
      done
    done;
    new_kernel
  )


(* change a dilated 2d kernel back to normal *)
let downsample_kernel2d kernel rate =
  if rate = [|1; 1|] then kernel else (
    let kernel_shp  = shape kernel in
    let kernel_cols = kernel_shp.(0) in
    let kernel_rows = kernel_shp.(1) in
    let in_channel  = kernel_shp.(2) in
    let out_channel = kernel_shp.(3) in
    let col_rate    = rate.(0) in
    let row_rate    = rate.(1) in

    let col_down = (kernel_cols + (col_rate - 1)) / col_rate in
    let row_down = (kernel_rows + (row_rate - 1)) / row_rate in
    let new_kernel = zeros (kind kernel)
      [|col_down; row_down; in_channel; out_channel|] in

    for c = 0 to (col_down - 1) do
      for r = 0 to (row_down - 1) do
        for i = 0 to (in_channel - 1) do
          for o = 0 to (out_channel - 1) do
            let v = get kernel [|c * col_rate; r * row_rate; i; o|] in
            set new_kernel [|c; r; i; o|] v
          done
        done
      done
    done;
    new_kernel
  )


(* dilated_conv2d: 4d input and 4d kernel, refer to tensorlfow doc
  input : [batch; input_column; input_row; input_channel]
  kernel: [kernel_column; kernel_row; input_channel; output_channel]
  stride: [column_stride; row_stride]
  rate  : [col_dilation_rate; row_dilation_rate]
  output: [batch; output_column; output_row; output_channel]
 *)
let dilated_conv2d ?(padding=SAME) input kernel stride rate =
  assert (Array.length rate = 2);
  let kernel = upsample_kernel2d kernel rate in
  conv2d ~padding input kernel stride


(* gradient of dilated_conv2d w.r.t the input *)
let dilated_conv2d_backward_input input kernel stride rate output' =
  assert (Array.length rate = 2);
  let kernel = upsample_kernel2d kernel rate in
  conv2d_backward_input input kernel stride output'


(* gradient of dilated_conv2d w.r.t the kernel *)
let dilated_conv2d_backward_kernel input kernel stride rate output' =
  assert (Array.length rate = 2);
  let kernel  = upsample_kernel2d kernel rate in
  let kernel' = conv2d_backward_kernel input kernel stride output' in
  downsample_kernel2d kernel' rate


(* create a dilated 3d kernel *)
let upsample_kernel3d kernel rate =
  if rate = [|1; 1; 1|] then kernel else (
    let kernel_shp  = shape kernel in
    let kernel_cols = kernel_shp.(0) in
    let kernel_rows = kernel_shp.(1) in
    let kernel_dpts = kernel_shp.(2) in
    let in_channel  = kernel_shp.(3) in
    let out_channel = kernel_shp.(4) in
    let col_rate    = rate.(0) in
    let row_rate    = rate.(1) in
    let dpt_rate    = rate.(2) in

    let col_up = kernel_cols + (kernel_cols - 1) * (col_rate - 1) in
    let row_up = kernel_rows + (kernel_rows - 1) * (row_rate - 1) in
    let dpt_up = kernel_dpts + (kernel_dpts - 1) * (dpt_rate - 1) in
    let new_kernel = zeros (kind kernel)
      [|col_up; row_up; dpt_up; in_channel; out_channel|] in

    for c = 0 to (kernel_cols - 1) do
      for r = 0 to (kernel_rows - 1) do
        for d = 0 to (kernel_dpts - 1) do
          for i = 0 to (in_channel - 1) do
            for o = 0 to (out_channel - 1) do
              let v = get kernel [|c; r; d; i; o|] in
              set new_kernel [|c * col_rate; r * row_rate; d * dpt_rate; i; o|] v;
            done
          done
        done
      done
    done;
    new_kernel
  )


(* change a dilated 3d kernel back to normal *)
let downsample_kernel3d kernel rate =
  if rate = [|1; 1; 1|] then kernel else (
    let kernel_shp  = shape kernel in
    let kernel_cols = kernel_shp.(0) in
    let kernel_rows = kernel_shp.(1) in
    let kernel_dpts = kernel_shp.(2) in
    let in_channel  = kernel_shp.(3) in
    let out_channel = kernel_shp.(4) in
    let col_rate    = rate.(0) in
    let row_rate    = rate.(1) in
    let dpt_rate    = rate.(2) in

    let col_down = (kernel_cols + (col_rate - 1)) / col_rate in
    let row_down = (kernel_rows + (row_rate - 1)) / row_rate in
    let dpt_down = (kernel_dpts + (dpt_rate - 1)) / dpt_rate in
    let new_kernel = zeros (kind kernel)
      [|col_down; row_down; dpt_down; in_channel; out_channel|] in

    for c = 0 to (col_down - 1) do
      for r = 0 to (row_down - 1) do
        for d = 0 to (dpt_down - 1) do
          for i = 0 to (in_channel - 1) do
            for o = 0 to (out_channel - 1) do
              let v = get kernel [|c * col_rate; r * row_rate; d * dpt_rate; i; o|] in
              set new_kernel [|c; r; d; i; o|] v
            done
          done
        done
      done
    done;
    new_kernel
  )


(* dilated_conv3d: 5d input and 5d kernel, refer to tensorflow doc
  input : [batch; input_column; input_row; input_depth; input_channel]
  kernel: [kernel_column; kernel_row; kernel_depth; input_channel; output_channel]
  stride: [column_stride; row_stride; depth_stride]
  rate  : [col_dilation_rate; row_dilation_rate; depth_dilation_rate]
  output: [batch; output_column; output_row; output_dpts; output_channel]
 *)
let dilated_conv3d ?(padding=SAME) input kernel stride rate =
  assert (Array.length rate = 3);
  let kernel = upsample_kernel3d kernel rate in
  conv3d ~padding input kernel stride


(* gradient of dilated_conv3d w.r.t the input *)
let dilated_conv3d_backward_input input kernel stride rate output' =
  assert (Array.length rate = 3);
  let kernel = upsample_kernel3d kernel rate in
  conv3d_backward_input input kernel stride output'


(* gradient of dilated_conv3d w.r.t the kernel *)
let dilated_conv3d_backward_kernel input kernel stride rate output' =
  assert (Array.length rate = 3);
  let kernel  = upsample_kernel3d kernel rate in
  let kernel' = conv3d_backward_kernel input kernel stride output' in
  downsample_kernel3d kernel' rate


(* dilated_conv1d: 3d input and 3d kernel, refer to tensorlfow doc
  input : [batch; input_column; input_channel]
  kernel: [kernel_column; input_channel; output_channel]
  stride: [column_rate]
  output: [batch; output_column; output_channel]
 *)
let dilated_conv1d ?(padding=SAME) input kernel stride rate =
  assert (num_dims input = 3);
  assert (num_dims kernel = 3);
  assert (Array.length stride = 1);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let in_channel = input_shp.(2) in
  let input = reshape input [|batches; 1; input_cols; in_channel|] in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let out_channel = kernel_shp.(2) in
  assert (in_channel = kernel_shp.(1));
  let kernel = reshape kernel [|1; kernel_cols; in_channel; out_channel|] in

  let col_stride = stride.(0) in
  let stride = [|1; col_stride|] in

  let output = dilated_conv2d ~padding input kernel stride rate in
  let output_shp = shape output in
  let output_cols = output_shp.(2) in
  let output = reshape output [|batches; output_cols; out_channel|] in
  output


(* gradient of dilated_conv1d w.r.t the input *)
let dilated_conv1d_backward_input input kernel stride rate output' =
  assert (num_dims input = 3);
  assert (num_dims kernel = 3);
  assert (num_dims output' = 3);
  assert (Array.length stride = 1);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let in_channel = input_shp.(2) in
  let input_rows = 1 in
  let input = reshape input [|batches; input_rows; input_cols; in_channel|] in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let out_channel = kernel_shp.(2) in
  assert (in_channel = kernel_shp.(1));
  let kernel_rows = 1 in
  let kernel = reshape kernel [|kernel_rows; kernel_cols; in_channel; out_channel|] in

  let output'_shp = shape output' in
  let output_cols = output'_shp.(1) in
  assert (batches = output'_shp.(0));
  assert (out_channel = output'_shp.(2));
  let output_rows = 1 in
  let output' = reshape output' [|batches; output_rows; output_cols; out_channel|] in

  let col_stride = stride.(0) in
  let row_stride = 1 in
  let stride = [|row_stride; col_stride|] in

  let input' = dilated_conv2d_backward_input input kernel stride rate output' in
  reshape input' input_shp


(* gradient of dilated_conv1d w.r.t the kernel *)
let dilated_conv1d_backward_kernel input kernel stride rate output' =
  assert (num_dims input = 3);
  assert (num_dims kernel = 3);
  assert (num_dims output' = 3);
  assert (Array.length stride = 1);

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let in_channel = input_shp.(2) in
  let input_rows = 1 in
  let input = reshape input [|batches; input_rows; input_cols; in_channel|] in

  let kernel_shp = shape kernel in
  let kernel_cols = kernel_shp.(0) in
  let out_channel = kernel_shp.(2) in
  assert (in_channel = kernel_shp.(1));
  let kernel_rows = 1 in
  let kernel = reshape kernel [|kernel_rows; kernel_cols; in_channel; out_channel|] in

  let output'_shp = shape output' in
  let output_cols = output'_shp.(1) in
  assert (batches = output'_shp.(0));
  assert (out_channel = output'_shp.(2));
  let output_rows = 1 in
  let output' = reshape output' [|batches; output_rows; output_cols; out_channel|] in

  let col_stride = stride.(0) in
  let row_stride = 1 in
  let stride = [|row_stride; col_stride|] in

  let kernel' = dilated_conv2d_backward_kernel input kernel stride rate output' in
  reshape kernel' kernel_shp


let upsampling2d input size =
  assert (num_dims input = 4);
  assert (Array.length size = 2);
  repeat input [|1; size.(0); size.(1); 1|]


let upsampling2d_backward input size output =
  assert (num_dims input = 4);
  assert (Array.length size = 2);

  let _kind = kind input in

  let input_shp = shape input in
  let batches = input_shp.(0) in
  let input_cols = input_shp.(1) in
  let input_rows = input_shp.(2) in
  let in_channel = input_shp.(3) in

  let col_scale = size.(0) in
  let row_scale = size.(1) in

  let output_shp = shape output in
  let output_cols = input_cols * col_scale in
  let output_rows = input_rows * row_scale in
  assert (output_cols = output_shp.(1));
  assert (output_rows = output_shp.(2));

  let input' = zeros _kind input_shp in

  for b = 0 to batches - 1 do
    for c = 0 to output_cols - 1 do
      let in_c = c / col_scale in
      let in_c = Pervasives.min in_c (input_cols - 1) in
      for r = 0 to output_rows - 1 do
        let in_r = r / row_scale in
        let in_r = Pervasives.min in_r (input_rows - 1) in
        for i = 0 to in_channel - 1 do
          let in_val = get input' [|b; in_c; in_r; i|] in
          let out_val = get output [|b; c; r; i|] in
          set input' [|b; in_c; in_r; i|] (in_val +. out_val)
        done
      done
    done
  done;

  input'


(* matrix functions *)

let _remove_unit_dims dims =
  let removed_ones_list = List.filter (fun x -> x > 1) (Array.to_list dims) in
  let not_empty_list = match removed_ones_list with
    | [] -> [1]
    | _ -> removed_ones_list
  in
  (Array.of_list not_empty_list)


let _check_is_matrix dims =
  if (Array.length dims) != 2
  then raise (Invalid_argument "The given NDarray is not a matrix!")
  else ()


let row_num varr =
  let dims = shape varr in
  (_check_is_matrix dims; dims.(0))


let col_num varr =
  let dims = shape varr in
  (_check_is_matrix dims; dims.(1))


(* NOTE: this is a view into the original array *)
let row varr ind =
  let dims = shape varr in
  (_check_is_matrix dims; Genarray.slice_left varr [|ind|])


let rows varr indices =
  let dims = shape varr in
  let _ = _check_is_matrix dims in
  let new_rownum = Array.length indices in
  let new_colnum = dims.(1) in
  let new_varr = empty (kind varr) [|new_rownum; new_colnum|] in
  begin
    for i = 0 to new_rownum - 1 do
      Genarray.blit
        (Genarray.slice_left varr [|indices.(i)|]) (* indices[i] row of the original *)
        (Genarray.slice_left new_varr [|i|]) (* i-th row of the new matrix *)
    done;
    new_varr
  end


let copy_row_to vec varr ind =
  let dims = shape varr in
  let _ = _check_is_matrix dims in
  (Genarray.blit vec (Genarray.slice_left varr [|ind|]))


let copy_col_to vec varr ind =
  let dims = shape varr in
  let _ = _check_is_matrix dims in
  let vec_dims = _remove_unit_dims(shape vec) in
  let vec_len =
    if (Array.length vec_dims) = 1
    then vec_dims.(0)
    else raise (Invalid_argument "Vector is not a column vector")
  in
  let num_rows = dims.(0) in
  let vec_linear = flatten vec |> array1_of_genarray in
  if num_rows != vec_len
  then raise (Invalid_argument "Column vector does not have the same length as the number of rows in the matrix")
  else
    begin
      for i = 0 to num_rows - 1 do
        Genarray.set varr [|i; ind|] (Array1.unsafe_get vec_linear i)
      done
    end


let dot varr_a varr_b =
  let (dims_a, dims_b) = (shape varr_a, shape varr_b) in
  let (_, _) = (_check_is_matrix dims_a, _check_is_matrix dims_b) in
  let m = dims_a.(0) in
  let cdim = dims_a.(1) in
  let n = dims_b.(1) in
  if (dims_b.(0)) != cdim
  then raise (Invalid_argument "Matrices cannot be multipled")
  else
    let varr_c = empty (kind varr_a) [|m; n|] in
    let sum = ref 0. in
    begin
      for i = 0 to m - 1 do
        for j = 0 to n - 1 do
          sum := 0.;
          for k = 0 to cdim - 1 do
            sum := !sum +. ((Genarray.get varr_a [|i; k|]) *. (Genarray.get varr_b [|k; j|]))
          done;
          Genarray.set varr_c [|i; j|] !sum
        done
      done;
      varr_c
    end


let trace varr =
  let dims = shape varr in
  let _ = _check_is_matrix dims in
  let n = dims.(0) in
  if dims.(1) != n
  then raise (Invalid_argument "Argument is not a square matrix")
  else
    let sum = ref 0. in
    begin
      for i = 0 to n - 1 do
        sum := !sum +. (Genarray.get varr [|i; i|])
      done;
      !sum
    end


(* NOTE: each row is actually a view in the original matrix, no copying involved *)
let to_rows varr =
  let dims = shape varr in
  let _ = _check_is_matrix dims in
  let m = dims.(0) in
  (Array.init m (fun i -> (Genarray.slice_left varr [|i|])))


let of_rows rows =
  let m = Array.length rows in
  let row_dim = shape (rows.(0)) in
  let dims = Array.append [|m|] row_dim in
  let varr = empty (kind rows.(0)) dims in
  begin
    for i = 0 to m - 1 do
      Genarray.blit rows.(i) (Genarray.slice_left varr [|i|])
    done;
    varr
  end


let of_arrays kind arrays =
  let m = Array.length arrays in
  let n = Array.length (arrays.(0)) in
  let varr = empty kind [|m; n|] in
  begin
    for i = 0 to m - 1 do
      for j = 0 to n - 1 do
        Genarray.set varr [|i; j|] (Array.unsafe_get (arrays.(i)) j)
      done
    done;
    varr
  end


let draw_rows ?(replacement=true) varr count =
  let dims = shape varr in
  let indices = _draw_int_samples replacement (Array.length dims) count in
  let extracted = rows varr indices in
  (extracted, indices)


let draw_rows2 ?(replacement=true) varr_a varr_b count =
  let extracted_a, indices =
    draw_rows ~replacement:replacement varr_a count in
  let extracted_b = rows varr_b indices in
  (extracted_a, extracted_b, indices)


(* TODO: optimise and test *)
(*
 Implementing the following algorithm:
 http://www.irma-international.org/viewtitle/41011/ *)
let inv varr =
  let dims = shape varr in
  let _ = _check_is_matrix dims in
  let n = Array.unsafe_get dims 0 in
  if (Array.unsafe_get dims 1) != n
  then failwith "no inverse - the matrix is not square"
  else
    let pivot_row = Array.make n 0. in
    let result_varr = copy varr in
    begin
      for p = 0 to n - 1 do
        let pivot_elem = get result_varr [|p; p|] in
        if get result_varr [|p; p|] = 0.
        then failwith "the matrix does not have an inverse";
        (* update elements of the pivot row, save old vals *)
        for j = 0 to n - 1 do
          pivot_row.(j) <- get result_varr [|p; j|];
          if j != p
          then set result_varr [|p; j|] (pivot_row.(j) /. pivot_elem)
        done;
        (* update elements of the pivot col *)
        for i = 0 to n - 1 do
          if i != p
          then set result_varr [|i; p|]
              ((get result_varr [|i; p|]) /. (~-. pivot_elem))
        done;
        (* update the rest of the matrix *)
        for i = 0 to n - 1 do
          let pivot_col_elem = get result_varr [|i; p|] in
          for j = 0 to n - 1 do
            if i != p && j != p
            then
              let pivot_row_elem = pivot_row.(j) in (* use old value *)
              let old_val = get result_varr [|i; j|] in
              let new_val = old_val +. (pivot_row_elem *. pivot_col_elem) in
              (set result_varr [|i; j|] new_val)
          done;
        done;
        (* update the pivot element *)
        set result_varr [|p; p|] (1. /. pivot_elem)
      done;
      result_varr
    end


(* TODO: here k is not used, but neither is it in nonbase dense array? - investigate *)
let load _k f = Owl_io.marshal_from_file f


let max_rows varr =
  let dims = shape varr in
  let _ = _check_is_matrix dims in
  let r, c = dims.(0), dims.(1) in
  let result = Array.make r (0., 0, 0) in
  begin
    for i = 0 to r - 1 do
      let best = ref Pervasives.min_float in
      let best_pos = ref ~- 1 in
      for j = 0 to c - 1 do
        let x = get varr [|i; j|] in
        if (x > !best)
        then (best := x; best_pos := j)
      done;
      result.(i) <- (!best, i, !best_pos)
    done;
    result
  end

let one_hot _depth _x = failwith "Owl_base_dense_ndarray_generic:one_hot: not implemented"


(* Helper functions *)

let float_to_elt x = x

let elt_to_float x = x



(* ends here *)
