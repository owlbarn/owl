(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types

type ('a, 'b) t = ('a, 'b, c_layout) Genarray.t

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

module Scalar = Owl_base_maths


(* Prepend an array with ones to the given length *)
let _prepend_dims dims desired_len =
  let dims_len = Array.length dims in
  if dims_len >= desired_len
  then dims
  else (Array.append (Array.make (desired_len - dims_len) 1) dims)


let _get_broadcasted_dims dims_a dims_b =
  let len_c = Pervasives.max (Array.length dims_a) (Array.length dims_b) in
  let ext_dims_a = _prepend_dims dims_a len_c in
  let ext_dims_b = _prepend_dims dims_b len_c in
  let dims_c = Array.make len_c 0 in
  begin
    for i = 0 to len_c - 1 do
      let val_a = ext_dims_a.(i) in
      let val_b = ext_dims_b.(i) in
      if val_a = val_b
      then dims_c.(i) <- val_a
      else
        begin
          if val_a != 1 && val_b != 1
          then raise (Invalid_argument "The arrays cannot be broadcast into the same shape")
          else dims_c.(i) <- (Pervasives.max val_a val_b)
        end
    done;
    (ext_dims_a, ext_dims_b, dims_c)
  end


(* Increment the index array, with respect to the dimensions array *)
let _next_index ind dims =
  let num_dims = Array.length ind in
  let p = ref (num_dims - 1) in
  let ok = ref false in
  begin
    while !p >= 0 && not !ok do
      if ind.(!p) + 1 < dims.(!p) then
        begin
          ind.(!p) <- (ind.(!p) + 1);
          ok := true;
        end
      else
        begin
          ind.(!p) <- 0;
          p := !p - 1;
        end
    done;
    !ok
  end


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
  if not replacement && count > range
  then raise (Invalid_argument "cannot draw that many samples from the given range, without replacement")
  else (
    let pop_cnt = ref range in
    let pop = Array.init !pop_cnt (fun i -> i) in
    let rand_gen = Random.State.make_self_init() in
    let draw_fun = (fun _ ->
        let index = Random.State.int rand_gen !pop_cnt in
        let sample = pop.(index) in
        if replacement
        then sample
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
    | None -> if (start <= stop) then 1 else -1
  in
  let _ =
    assert (((start <= stop) && (step > 0)) || ((start > stop) && (step < 0)))
  in
  let step_abs = Pervasives.abs step in
  let len = ((Pervasives.abs (stop - start)) + step_abs) / step_abs in
  (Array.init len (fun i -> start + i * step))


(* Rewrite the indices s.t. for each dimension they are a list of explicit indices *)
let _expand_slice_indices index_list dims =
  let rank = Array.length dims in
  let sdef_len = List.length index_list in (* the number of dimensions this slice specifies *)
  let _expand_slice_index = (
    fun i ind -> match ind with
      | [] -> Array.init dims.(i) (fun i -> i)
      | [start] -> _enumerate_slice_def dims.(i) start start
      | [start; stop] -> _enumerate_slice_def dims.(i) start stop
      | [start; stop; step] -> _enumerate_slice_def dims.(i) ~step:step start stop
      | _ -> failwith "incorrect slice definition"
  ) in
  Array.append
    (Array.of_list (List.mapi _expand_slice_index index_list)) (* for the axis where the index was specified *)
    (Array.init (rank - sdef_len) (* the rest of the axis is just all of them *)
       (fun p -> Array.init dims.(p + sdef_len) (fun i -> i)))



let empty kind dims = Genarray.create kind c_layout dims


let create kind dims value =
  let varr = empty kind dims in
  Genarray.fill varr value;
  varr

let zeros kind dims = create kind dims (Owl_const.zero kind)


let ones kind dims = create kind dims (Owl_const.one kind)


(* return the shape of the ndarray *)
let shape varr = Genarray.dims varr


(* return the rank of the ndarray *)
let num_dims varr = Array.length (shape varr)


(* return the number of elements in the ndarray*)
let numel varr =
  let v_shape = shape varr in
  Array.fold_left ( * ) 1 v_shape


let kind varr = Genarray.kind varr


let get varr index = (Genarray.get varr index)


let set varr index value = (Genarray.set varr index value)


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
  begin
    while not !should_stop do
      for i = 0 to rank - 1 do
        original_ind.(i) <- (index_array.(i)).(slice_ind.(i))
      done;
      Genarray.set slice_varr slice_ind (Genarray.get varr original_ind);
      if not (_next_index slice_ind slice_dims) then
        should_stop := true
    done;
    slice_varr
  end


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
  begin
    while not !should_stop do
      for i = 0 to rank - 1 do
        original_ind.(i) <- (index_array.(i)).(slice_ind.(i))
      done;
      Genarray.set varr original_ind (Genarray.get slice_varr slice_ind);
      if not (_next_index slice_ind slice_dims) then
        should_stop := true
    done;
  end


(*TODO: This is clone, not copying from one to another, maybe should specify this in documentation *)
let copy varr =
  let varr_copy = empty (kind varr) (shape varr) in
  begin
    Genarray.blit varr varr_copy; varr_copy
  end


let copy_to x = failwith "Owl_base_dense_ndarray_generic:copy_to: not implemented"


(* Reset to zero *)
let reset varr = (Genarray.fill varr 0.)


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
let flatten varr = (reshape varr [|(numel varr)|])

let reverse varr =
  let n = numel varr in
  let ret = empty (kind varr) (shape varr) in
  let ret_flat = reshape ret [|n|] in
  let varr_flat = reshape varr [|n|] in
  begin
    for i = 0 to n - 1 do
      set ret_flat [|i|] (get varr_flat [|n - 1 - i|])
    done;
    ret
  end


(* Apply a function over a bigarray, with no copying *)
let _apply_fun f varr =
  let varr_linear = flatten varr |> array1_of_genarray in
  let length = numel varr in
  begin
    for i = 0 to length - 1 do
      (Array1.unsafe_set varr_linear i (f (Array1.unsafe_get varr_linear i)))
    done
  end

let init kind dims f =
  let varr = empty kind dims in
  let varr_flat = flatten varr |> array1_of_genarray in
  let n = numel varr in
  begin
    for i = 0 to n - 1 do
      Array1.unsafe_set varr_flat i (f i)
    done;
    varr
  end

(* Map a NDarray from elements x -> f(x), by copying the array *)
let map f varr =
  let varr_copy = copy varr in
  (_apply_fun f varr_copy; varr_copy)

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

      for i = 0 to m - 1 do
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

  for i = 0 to m - 1 do
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

let sequential kind ?(a=0.) ?(step=1.) dims =
  let varr = empty kind dims in
  let count = ref 0. in
  let seq_fun =
    (fun x -> (count := !count +. 1.; a +. (!count -. 1.) *. step))
  in
  _apply_fun seq_fun varr;
  varr


let of_array kind arr dims =
  let varr = empty kind dims in
  let flat_varr = flatten varr |> array1_of_genarray in
  let n = numel varr in
  begin
    for i = 0 to n - 1 do
      Array1.unsafe_set flat_varr i arr.(i)
    done;
    varr
  end


let uniform kind ?(a=0.) ?(b=1.) dims =
  let uniform_gen_fun = (fun _ -> Owl_base_stats.uniform_rvs ~a ~b) in
  let varr = empty kind dims in
  _apply_fun uniform_gen_fun varr;
  varr


let bernoulli kind ?(p=0.5) dims =
  let bernoulli_gen_fun = (fun _ -> Owl_base_stats.bernoulli_rvs ~p) in
  let varr = empty kind dims in
  _apply_fun bernoulli_gen_fun varr;
  varr


let gaussian kind ?(mu=0.) ?(sigma=1.) dims =
  let gaussian_gen_fun = (fun _ -> Owl_base_stats.gaussian_rvs ~mu ~sigma) in
  let varr = empty kind dims in
  _apply_fun gaussian_gen_fun varr;
  varr


let print ?max_row ?max_col ?header ?fmt varr =
  let dims = shape varr in
  let rank = Array.length dims in
  let n = dims.(rank - 1) in
  let max_row = match max_row with
    | Some a -> Some a
    | None   -> Some ((numel varr) / n)
  in
  let max_col = match max_col with
    | Some a -> Some a
    | None   -> Some n
  in
  Owl_pretty.print_dsnda ?max_row ?max_col ?header ?elt_to_str_fun:fmt varr


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
  begin
    while not !should_stop do
      for i = 0 to result_rank - 1 do
        original_ind.(i) <- (Pervasives.(mod) result_ind.(i) dims.(i))
      done;
      Genarray.set result_varr result_ind (Genarray.get varr original_ind);
      if not (_next_index result_ind result_dims) then
        should_stop := true
    done;
    result_varr
  end


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


(*TODO : ensure this is desired behaviour *)
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


(* TODO: is there a more efficient way to do this? *)
let repeat ?(axis=0) varr reps =
  let varrs = Array.make reps varr in
  (concatenate ~axis:axis varrs)


(* mathematical functions *)

(* Absolute values of all elements, in a new arrray *)
let abs varr = (map Scalar.abs varr)


let neg varr = (map Scalar.neg varr)


let floor varr = (map Scalar.floor varr)


let ceil varr = (map Scalar.ceil varr)


let round varr = (map Scalar.round varr)


let sqr varr = (map Scalar.sqr varr)


let sqrt varr = (map Scalar.sqrt varr)


let log varr = (map Scalar.log varr)


let log2 varr = (map Scalar.log2 varr)


let log10 varr = (map Scalar.log10 varr)


let exp varr = (map Scalar.exp varr)


let sin varr = (map Scalar.sin varr)


let cos varr = (map Scalar.cos varr)


let tan varr = (map Scalar.tan varr)


let tan varr = (map Scalar.tan varr)


let sinh varr = (map Scalar.sinh varr)


let cosh varr = (map Scalar.cosh varr)


let tanh varr = (map Scalar.tanh varr)


let asin varr = (map Scalar.asin varr)


let acos varr = (map Scalar.acos varr)


let atan varr = (map Scalar.atan varr)


let asinh varr = (map Scalar.asinh varr)


let acosh varr = (map Scalar.acosh varr)


let atanh varr = (map Scalar.atanh varr)


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
  begin
    for j = 0 to num_cols - 1 do
      row_sum := 0.;
      for i = 0 to num_rows - 1 do
        row_sum := !row_sum +. (Genarray.get varr_mat [|i; j|])
      done;
      Genarray.set result_vec [|j|] !row_sum
    done;
    result_varr
  end


(* -1. for negative numbers, 0 or (-0) for 0,
 1 for positive numbers, nan for nan*)
let signum varr = (map Scalar.signum varr)


(* Apply 1 / (1 + exp (-x)) for each element x *)
let sigmoid varr = (map Scalar.sigmoid varr)


let relu varr = (map Scalar.relu varr)


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
let min' varr = (_fold_left (Pervasives.min) Pervasives.max_float varr)


(* Max of all elements in the NDarray *)
let max' varr = (_fold_left (Pervasives.max) Pervasives.min_float varr)

(* TODO: revise functions with float type to 'a *)

(* Sum of all elements *)
let sum' varr =
  let _kind = kind varr in
  _fold_left (Owl_base_dense_common._add_elt _kind) (Owl_const.zero _kind) varr


(* Folding along a specified axis, aka reduction. The
   f: function of type 'a -> 'a -> 'a.
   m: number of slices.
   n: x's slice size.
   o: x's strides, also y's slice size.
   x: source; y: shape of destination. Note that o <= n.
 *)
let fold_along f m n o x ys =
  let x = flatten x in
  let y = zeros (kind x) ys |> flatten in
  let idx = ref 0 in
  let idy = ref 0 in
  let incy = ref 0 in
  for i = 0 to (m - 1) do
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
  match axis with
  | Some a -> (
      let m, n, o, s = Owl_utils.reduce_params a x in
      fold_along (Owl_base_dense_common._add_elt _kind) m n o x s
    )
  | None   -> create (kind x) (Array.make 1 1) (sum' x)


let sum_reduce ?axis x =
  let _kind = kind x in
  let _dims = num_dims x in
  match axis with
  | Some a -> (
      let y = ref x in
      Array.iter (fun i ->
        assert (i < _dims);
        let m, n, o, s = Owl_utils.reduce_params i !y in
        y := fold_along (Owl_base_dense_common._add_elt _kind) m n o !y s
      ) a;
      !y
    )
  | None   -> create (kind x) (Array.make _dims 1) (sum' x)


let min ?axis x = failwith "not implemented"


let max ?axis x = failwith "not implemented"


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


(* scalar_pow a varr computes the power of scalar to each element of varr *)
let scalar_pow a varr =
  let scalar_pow_fun = (fun x -> (a ** x)) in
  (map scalar_pow_fun varr)


(* Raise each element to power a *)
let pow_scalar varr a =
  let pow_scalar_fun = (fun x -> (x ** a)) in
  (map pow_scalar_fun varr)


let scalar_atan2 a varr =
  let scalar_atan2_fun = (fun x -> (Scalar.atan2 a x)) in
  (map scalar_atan2_fun varr)


let atan2_scalar varr a =
  let atan2_scalar_fun = (fun x -> (Scalar.atan2 x a)) in
  (map atan2_scalar_fun varr)


let _broadcasted_op varr_a varr_b op_fun =
  let (dims_a, dims_b, dims_c) =
    _get_broadcasted_dims (shape varr_a) (shape varr_b)
  in
  let _kind = kind varr_a in
  let varr_a = reshape varr_a dims_a in
  let varr_b = reshape varr_b dims_b in
  let varr_c = empty _kind dims_c in
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


let add varr_a varr_b =
  let _op = Owl_base_dense_common._add_elt (kind varr_a) in
  _broadcasted_op varr_a varr_b _op


let sub varr_a varr_b =
  let _op = Owl_base_dense_common._sub_elt (kind varr_a) in
  _broadcasted_op varr_a varr_b _op


let mul varr_a varr_b =
  let _op = Owl_base_dense_common._mul_elt (kind varr_a) in
  _broadcasted_op varr_a varr_b _op


let div varr_a varr_b =
  let _op = Owl_base_dense_common._div_elt (kind varr_a) in
  _broadcasted_op varr_a varr_b _op


let atan2 varr_a varr_b = (_broadcasted_op varr_a varr_b (Scalar.atan2))


let pow varr_a varr_b = (_broadcasted_op varr_a varr_b ( ** ))


let add_scalar varr a =
  let _op = Owl_base_dense_common._add_elt (kind varr) in
  let add_scalar_fun = (fun x -> _op x a) in
  (map add_scalar_fun varr)


let sub_scalar varr a =
  let _op = Owl_base_dense_common._sub_elt (kind varr) in
  let sub_scalar_fun = (fun x -> _op x a) in
  (map sub_scalar_fun varr)


let mul_scalar varr a =
  let _op = Owl_base_dense_common._mul_elt (kind varr) in
  let mul_scalar_fun = (fun x -> _op x a) in
  (map mul_scalar_fun varr)


let div_scalar varr a =
  let _op = Owl_base_dense_common._div_elt (kind varr) in
  let div_scalar_fun = (fun x -> _op x a) in
  (map div_scalar_fun varr)


let clip_by_value ?(amin=Pervasives.min_float) ?(amax=Pervasives.max_float) varr =
  let clip_by_val_fun = (fun x -> Pervasives.min amax (Pervasives.max amin x)) in
  (map clip_by_val_fun varr)


(* TODO *)
let fma x y z = failwith "Owl_base_dense_ndarray_generic:fma: not implemented"


(* Addition is commutative *)
let scalar_add a varr = (add_scalar varr a)


let scalar_sub a varr =
  let _op = Owl_base_dense_common._sub_elt (kind varr) in
  let scalar_sub_fun = (fun x -> _op a x) in
  (map scalar_sub_fun varr)


(* Multiplication is commutative *)
let scalar_mul a varr = (mul_scalar varr a)


let scalar_div a varr =
  let _op = Owl_base_dense_common._div_elt (kind varr) in
  let scalar_div_fun = (fun x -> _op a x) in
  (map scalar_div_fun varr)


let clip_by_l2norm clip_norm varr =
  let l2norm_val = l2norm' varr in
  if l2norm_val > clip_norm
  then mul_scalar varr (clip_norm /. l2norm_val)
  else varr


(* Comparison functions *)

(** Return true if for all elements comp_fun (xa, xb) == true, false otherwise.
    Returns false as soon as it finds a counterexample. (NOT broadcasted) *)
let _compare_util_shortcircuit varr_a varr_b comp_fun =
  let n = numel varr_a in
  let m = numel varr_b in
  if n != m
  then false
  else
    let varr_a = flatten varr_a |> array1_of_genarray in
    let varr_b = flatten varr_b |> array1_of_genarray in
    let all_ok = ref true in
    let i = ref 0 in
    begin
      while !all_ok && (!i < n) do
        let x = Array1.unsafe_get varr_a !i in
        let y = Array1.unsafe_get varr_b !i in
        if (not (comp_fun x y))
        then all_ok := false;
        i := !i + 1
      done;
      !all_ok
    end


let approx_equal ?eps varr_a varr_b =
  let eps = match eps with
    | Some eps -> eps
    | None     -> Owl_utils.eps Float32
  in
  let approx_equal_fun = (fun x y -> (Scalar.abs (Scalar.sub x y)) < eps) in
  (_compare_util_shortcircuit varr_a varr_b approx_equal_fun)


let equal varr_a varr_b =
  (_compare_util_shortcircuit varr_a varr_b Pervasives.(=))


let not_equal varr_a varr_b =
  (_compare_util_shortcircuit varr_a varr_b Pervasives.(<>))


let less varr_a varr_b =
  (_compare_util_shortcircuit varr_a varr_b Pervasives.(<))


let greater varr_a varr_b =
  (_compare_util_shortcircuit varr_a varr_b Pervasives.(>))


let less_equal varr_a varr_b =
  (_compare_util_shortcircuit varr_a varr_b Pervasives.(<=))


let greater_equal varr_a varr_b =
  (_compare_util_shortcircuit varr_a varr_b Pervasives.(>=))


(** Return true if for all elements of a comp_fun (xa, bb) == true, false otherwise.
    Returns false as soon as it finds a counterexample. (NOT broadcasted) *)
let _compare_util_shortcircuit_scalar varr_a b comp_fun =
  let n = numel varr_a in
  let varr_a = flatten varr_a |> array1_of_genarray in
  let all_ok = ref true in
  let i = ref 0 in
  begin
    while !all_ok && (!i < n) do
      let x = Array1.unsafe_get varr_a !i in
      if (not (comp_fun x b))
      then all_ok := false;
      i := !i + 1
    done;
    !all_ok
  end


let approx_equal_scalar ?eps varr_a b =
  let eps = match eps with
    | Some eps -> eps
    | None     -> Owl_utils.eps Float32
  in
  let approx_equal_scalar_fun = (fun x y -> (Scalar.abs (Scalar.sub x y)) < eps) in
  (_compare_util_shortcircuit_scalar varr_a b approx_equal_scalar_fun)


let equal_scalar varr_a b =
  (_compare_util_shortcircuit_scalar varr_a b Pervasives.(=))


let not_equal_scalar varr_a b =
  (_compare_util_shortcircuit_scalar varr_a b Pervasives.(<>))


let less_scalar varr_a b =
  (_compare_util_shortcircuit_scalar varr_a b Pervasives.(<))


let greater_scalar varr_a b =
  (_compare_util_shortcircuit_scalar varr_a b Pervasives.(>))


let less_equal_scalar varr_a b =
  (_compare_util_shortcircuit_scalar varr_a b Pervasives.(<=))


let greater_equal_scalar varr_a b =
  (_compare_util_shortcircuit_scalar varr_a b Pervasives.(>=))


(* Broadcasted operation, return an array with values of 1
   if (one_fun elem_from_a elem_from_b) == true, 0 otherwise *)
let _elt_compare_util varr_a varr_b one_fun =
  let _kind = kind varr_a in
  let c0 = Owl_const.zero _kind in
  let c1 = Owl_const.one _kind in
  let comp_fun = (fun x y -> if (one_fun x y) then c1 else c0) in
  (_broadcasted_op varr_a varr_b comp_fun)


let elt_equal varr_a varr_b =
  (_elt_compare_util varr_a varr_b Pervasives.(=))


let approx_elt_equal ?eps varr_a varr_b =
  let eps = match eps with
    | Some eps -> eps
    | None     -> Owl_utils.eps Float32
  in
  let approx_equal_fun = (fun x y -> (Scalar.abs (Scalar.sub x y)) < eps) in
  (_elt_compare_util varr_a varr_b approx_equal_fun)


let elt_not_equal varr_a varr_b =
  (_elt_compare_util varr_a varr_b Pervasives.(<>))


let elt_less varr_a varr_b =
  (_elt_compare_util varr_a varr_b Pervasives.(<))


let elt_greater varr_a varr_b =
  (_elt_compare_util varr_a varr_b Pervasives.(>))


let elt_less_equal varr_a varr_b =
  (_elt_compare_util varr_a varr_b Pervasives.(<=))


let elt_greater_equal varr_a varr_b =
  (_elt_compare_util varr_a varr_b Pervasives.(>=))


(* Util function, return an array with values of 1
    if (one_fun elem_from_a b) == true, 0 otherwise *)
let _elt_compare_scalar_util varr_a one_fun =
  let _kind = kind varr_a in
  let c0 = Owl_const.zero _kind in
  let c1 = Owl_const.one _kind in
  let comp_fun = (fun x -> if one_fun x then c1 else c0) in
  (map comp_fun varr_a)


let elt_equal_scalar varr_a b =
  let equal_scalar_fun = (fun x -> x = b) in
  (_elt_compare_scalar_util varr_a equal_scalar_fun)


let approx_elt_equal_scalar ?eps varr_a b =
  let eps = match eps with
    | Some eps -> eps
    | None     -> Owl_utils.eps Float32
  in
  let approx_equal_scalar_fun = (fun x -> (Scalar.abs (Scalar.sub x b)) < eps) in
  (_elt_compare_scalar_util varr_a approx_equal_scalar_fun)


let elt_not_equal_scalar varr_a b =
  let not_equal_scalar_fun = (fun x -> x <> b) in
  (_elt_compare_scalar_util varr_a not_equal_scalar_fun)


let elt_less_scalar varr_a b =
  let less_scalar_fun = (fun x -> x < b) in
  (_elt_compare_scalar_util varr_a less_scalar_fun)


let elt_greater_scalar varr_a b =
  let greater_scalar_fun = (fun x -> x > b) in
  (_elt_compare_scalar_util varr_a greater_scalar_fun)


let elt_less_equal_scalar varr_a b =
  let less_equal_scalar_fun = (fun x -> x <= b) in
  (_elt_compare_scalar_util varr_a less_equal_scalar_fun)


let elt_greater_equal_scalar varr_a b =
  let greater_equal_scalar_fun = (fun x -> x > b) in
  (_elt_compare_scalar_util varr_a greater_equal_scalar_fun)


let exists f varr =
  let n = numel varr in
  let varr = flatten varr |> array1_of_genarray in
  let found = ref false in
  let i = ref 0 in
  begin
    while (!i < n) && (not !found) do
      let x = Array1.unsafe_get varr !i in
      if f x
      then found := true;
      i := !i + 1
    done;
    !found
  end


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


let is_normal varr =
  let not_normal_fun = (
    fun x -> match Pervasives.classify_float x with
      | FP_subnormal -> true
      | FP_infinite -> true
      | FP_nan -> true
      | _ -> false
  ) in
  (not_exists not_normal_fun varr)


let not_nan varr =
  let is_nan_fun = (
    fun x -> match Pervasives.classify_float x with
      | FP_nan -> true
      | _ -> false
  ) in
  (not_exists is_nan_fun varr)


let not_inf varr =
  let is_inf_fun = (
    fun x -> match Pervasives.classify_float x with
      | FP_infinite -> true
      | _ -> false
  ) in
  (not_exists is_inf_fun varr)


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
    Owl_utils_conv.calc_conv2d_output_shape padding input_cols input_rows
      kernel_cols kernel_rows row_stride col_stride
  in
  let _kind = kind input in
  let output = empty _kind [|batches; output_cols; output_rows; out_channel|] in
  let (pad_top, pad_left, _, _) = Owl_utils_conv.calc_conv2d_padding
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
      Owl_utils_conv.calc_conv3d_output_shape padding
        input_cols input_rows input_dpts
        kernel_cols kernel_rows kernel_dpts
        row_stride col_stride dpt_stride
    in
    let _kind = kind input in
    let output =
      empty _kind [|batches; output_cols; output_rows; output_dpts; out_channel|] in
    let (pad_top, pad_left, pad_shallow, _, _, _) =
      Owl_utils_conv.calc_conv3d_padding
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
    Owl_utils_conv.calc_conv2d_output_shape padding
      input_cols input_rows
      kernel_cols kernel_rows
      row_stride col_stride
  in
  let _kind = kind input in
  let output = empty _kind [|batches; output_cols; output_rows; in_channel|] in
  let (pad_top, pad_left, _, _) = Owl_utils_conv.calc_conv2d_padding
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
    Owl_utils_conv.calc_conv3d_output_shape padding
      input_cols input_rows input_dpts
      kernel_cols kernel_rows kernel_dpts
      row_stride col_stride dpt_stride
  in
  let _kind = kind input in
  let output = empty _kind [|batches; output_cols; output_rows; output_dpts; in_channel|] in
  let (pad_top, pad_left, pad_shallow, _, _, _) =
    Owl_utils_conv.calc_conv3d_padding
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
  let (pad_top, pad_left, _, _) = Owl_utils_conv.calc_conv2d_padding
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

  let (pad_top, pad_left, _, _) = Owl_utils_conv.calc_conv2d_padding
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


(* TODO: add correct implementaton into these placeholders *)
let transpose_conv2d = conv2d
let transpose_conv2d_backward_input = conv2d_backward_input
let transpose_conv2d_backward_kernel = conv2d_backward_kernel

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
    Owl_utils_conv.calc_conv3d_padding
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
    Owl_utils_conv.calc_conv3d_padding
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


(* TODO: definitely optimise *)
(* General function for avg_pool2d and max_pool2d *)
let _pool2d_backward padding input kernel stride output'
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

  let (pad_top, pad_left, _, _) = Owl_utils_conv.calc_conv2d_padding
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
    (fun input_val input_grad output_val output_grad ->
       input_grad +. output_grad /. !cnt)
  in
  (_pool2d_backward padding input kernel stride output'
     init_pool_fun add_val_pool_fun end_pool_fun compute_grad_fun)


(* TODO: definitely optimise *)
(* General function for avg_pool3d and max_pool3d *)
let _pool3d_backward padding input kernel stride output'
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
    Owl_utils_conv.calc_conv3d_padding
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
    (fun input_val input_grad output_val output_grad ->
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
let load k f = Owl_io.marshal_from_file f


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


let one_hot depth x = failwith "Owl_base_dense_ndarray_generic:one_hot: not implemented"


(* Helper functions *)

let arr_to_var x = x

let float_to_elt x = x

let elt_to_float x = x

let eval_elt x = ()

let eval_arr x = ()



(* ends here *)
