(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_types

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
      | [start] -> [|start|]
      | [start; stop] -> _enumerate_slice_def dims.(i) start stop
      | [start; stop; step] -> _enumerate_slice_def dims.(i) ~step:step start stop
      | _ -> failwith "incorrect slice definition"
  ) in
  Array.append
    (Array.of_list (List.mapi _expand_slice_index index_list)) (* for the axis where the index was specified *)
    (Array.init (rank - sdef_len) (* the rest of the axis is just all of them *)
       (fun p -> Array.init dims.(p + sdef_len) (fun i -> i)))


module type GenarrayFloatEltSig = sig
  type elt
  val element_kind: (float, elt) kind
end

module GenarrayFloat32Elt : GenarrayFloatEltSig = struct
  type elt = float32_elt
  let element_kind = float32
end

module GenarrayFloat64Elt : GenarrayFloatEltSig = struct
  type elt = float64_elt
  let element_kind = float64
end

module MakeNdarray (ELT : GenarrayFloatEltSig) : Ndarray_Algodiff = struct

  type arr = (float, ELT.elt, c_layout) Genarray.t

  type elt = float

  module Scalar = Owl_maths_pure

  let empty dims = (Genarray.create ELT.element_kind c_layout dims)

  let create dims value =
    let varr = empty dims in
    (Genarray.fill varr value; varr)

  let zeros dims = create dims 0.

  let ones dims = create dims 1.

  (* return the shape of the ndarray *)
  let shape varr = Genarray.dims varr

  (* return the number of elements in the ndarray*)
  let numel varr = let v_shape = shape varr in (Array.fold_left ( * ) 1 v_shape)

  let get varr index = (Genarray.get varr index)

  let set varr index value = (Genarray.set varr index value)


  (*TODO: make more efficient, test it is correct *)
  let get_slice index_list varr =
    let dims = shape varr in
    let rank = Array.length dims in
    let index_array = _expand_slice_indices index_list dims in
    let slice_dims = Array.map (fun a -> Array.length a) index_array in
    let slice_varr = empty slice_dims in
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

  (*TODO: make more efficient, test it is correct *)
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
    let varr_copy = empty (shape varr) in
    begin
      Genarray.blit varr varr_copy; varr_copy
    end

  (* Reset to zero *)
  let reset varr = (Genarray.fill varr 0.)

  (* The result shares the underlying buffer with original, not a copy *)
  let reshape varr newshape = (Bigarray.reshape varr newshape)

  (* Return the array as a contiguous block, without copying *)
  let _flatten varr = (reshape varr [|(numel varr)|])

  let _generate_random_ndarray dims gen_fun =
    let varr = empty dims in
    let varr_linear = _flatten varr in
    let length = numel varr_linear in
    begin
      for i = 0 to length - 1 do
        Genarray.set varr_linear [|i|] (gen_fun())
      done;
      varr
    end

  let uniform ?(a=0.) ?(b=1.) dims =
    let rand_gen = Random.State.make_self_init() in
    let uniform_gen_fun =
      (fun () -> (a +. (b -. a) *. (Random.State.float rand_gen 1.))) in (*TODO: is this actually uniform?*)
    (_generate_random_ndarray dims uniform_gen_fun)

  let bernoulli ?(p=0.5) dims =
    assert (p >= 0. && p <= 1.);
    let rand_gen = Random.State.make_self_init() in
    let bernoulli_gen_fun =
      (fun () -> if (Random.State.float rand_gen 1.) <= p then 1. else 0.) in
    (_generate_random_ndarray dims bernoulli_gen_fun)

  (* TODO: investigate whether using the Box-Muller transform is okay *)
  (* TODO: use the polar, is more efficient *)
  let gaussian ?(mu=0.) ?(sigma=1.) dims =
    let rand_gen = Random.State.make_self_init() in
    let u1 = ref 0. in
    let u2 = ref 0. in
    let case = ref false in
    let z0 = ref 0. in
    let z1 = ref 1. in
    let gaussian_gen_fun () = (
        if !case
        then (case := false; mu +. sigma *. !z1)
        else (
          case := true;
          u1 := Random.State.float rand_gen 1.;
          u2 := Random.State.float rand_gen 1.;
          z0 := (Scalar.sqrt ((~-. 2.) *. (Scalar.log (!u1)))) *. (Scalar.cos (2. *. Owl_const.pi *. (!u2)));
          z1 := (Scalar.sqrt ((~-. 2.) *. (Scalar.log (!u1)))) *. (Scalar.sin (2. *. Owl_const.pi *. (!u2)));
          mu +. sigma *. !z0
        )
      ) in
    (_generate_random_ndarray dims gaussian_gen_fun)

  (* TODO: make sure this is pure OCaml *)
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
    Owl_pretty.print ?max_row ?max_col ?header ?elt_to_str_fun:fmt varr

  (* TODO: test and optimise *)
  let tile varr reps =
    (* First ensure len(reps) = num_dims(varr) *)
    let dims = shape varr in
    let result_rank = Pervasives.max (Array.length dims) (Array.length reps) in
    let dims = _prepend_dims dims result_rank in
    let reps = _prepend_dims reps result_rank in
    let varr = reshape varr dims in
    (* now len(reps) = num_dims(varr) *)
    let result_dims = Array.map2 (fun a b -> a * b) dims reps in
    let result_varr = empty result_dims in
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

  (* TODO: optimise and ensure it is correct *)
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

  (*TODO : ensure this is correct *)
  (* Similar to draw rows for matrices *)
  let draw_along_dim0 varr count =
    let dims = shape varr in
    let indices = _draw_int_samples false dims.(0) count in
    (get_slice [(Array.to_list indices)] varr, indices)

  (* TODO: is there a more efficient way to do this? *)
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
    let result_varr = empty result_dims in
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

  (* Apply a function over a bigarray, with no copying *)
  let _apply_fun f varr =
    let varr_linear = _flatten varr in
    let length = numel varr_linear in
    begin
      for i = 0 to length - 1 do
        (Genarray.set varr_linear [|i|] (f (Genarray.get varr_linear [|i|])))
      done
    end

  (* Map a NDarray from elements x -> f(x), by copying the array *)
  let _map_fun f varr =
    let varr_copy = copy varr in
    (_apply_fun f varr_copy; varr_copy)


  (* mathematical functions *)

  (* Absolute values of all elements, in a new arrray *)
  let abs varr = (_map_fun Scalar.abs varr)

  let neg varr = (_map_fun Scalar.neg varr)

  let floor varr = (_map_fun Scalar.floor varr)

  let ceil varr = (_map_fun Scalar.ceil varr)

  let round varr =
    let round_fun = (fun x -> (Scalar.floor (x +. 0.5))) in
    (_map_fun round_fun varr)

  let sqr varr =
    let sqr_fun = (fun x -> x *. x) in
    (_map_fun sqr_fun varr)

  let sqrt varr = (_map_fun Scalar.sqrt varr)

  let log varr = (_map_fun Scalar.log varr)

  let log2 varr =
    let log2_fun = (fun x -> ((Scalar.log x) /. (Scalar.log 2.))) in
    (_map_fun log2_fun varr)

  let log10 varr = (_map_fun Scalar.log10 varr)

  let exp varr = (_map_fun Scalar.exp varr)

  let sin varr = (_map_fun Scalar.sin varr)

  let cos varr = (_map_fun Scalar.cos varr)

  let tan varr = (_map_fun Scalar.tan varr)

  let tan varr = (_map_fun Scalar.tan varr)

  let sinh varr = (_map_fun Scalar.sinh varr)

  let cosh varr = (_map_fun Scalar.cosh varr)

  let tanh varr = (_map_fun Scalar.tanh varr)

  let asin varr = (_map_fun Scalar.asin varr)

  let acos varr = (_map_fun Scalar.acos varr)

  let atan varr = (_map_fun Scalar.atan varr)

  let asinh varr = (_map_fun Scalar.asinh varr)

  let acosh varr = (_map_fun Scalar.acosh varr)

  let atanh varr = (_map_fun Scalar.atanh varr)

  (* TODO: can this be made more efficient? *)
  let sum ?(axis=0) varr =
    let old_dims = shape varr in
    let old_rank = Array.length old_dims in
    if old_rank = 0
    then varr
    else
      let old_ind = Array.make old_rank 0 in
      let new_rank = old_rank - 1 in
      let new_dims = Array.init new_rank
          (fun i -> if i < axis then old_dims.(i) else old_dims.(i + 1))
      in
      let new_varr = empty new_dims in
      let new_ind = Array.make new_rank 0 in
      let should_stop = ref false in
      let sum = ref 0. in
      begin
        while not !should_stop do
          for i = 0 to new_rank - 1 do (* copy the new index into the old one *)
            old_ind.(if i < axis then i else i + 1) <- new_ind.(i)
          done;
          sum := 0.;
          for i = 0 to old_dims.(axis) - 1 do
            old_ind.(axis) <- i;
            sum := !sum +. (Genarray.get varr old_ind)
          done;
          Genarray.set new_varr new_ind !sum;
          if not (_next_index old_ind old_dims) then
            should_stop := true
        done;
        new_varr
      end

  (* TODO: this is a stub *)
  let sum_slices ?(axis=0) varr =
    let dims = shape varr in
    let rank = Array.length dims in
    (* reshape into 2d matrix *)
    let num_rows = Array.fold_left ( * ) 1 (Array.sub dims 0 (axis + 1)) in
    let num_cols = (numel varr) / num_rows in
    let varr_mat = reshape varr [|num_rows; num_cols|] in
    let result_vec = empty [|num_cols|] in
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
  let signum varr = (_map_fun Scalar.signum varr)

  (* Apply 1 / (1 + exp (-x)) for each element x *)
  let sigmoid varr = (_map_fun Scalar.sigmoid varr)

  let relu varr = (_map_fun Scalar.relu varr)

  let _fold_left f a varr =
    let aref = ref a in
    let varr_linear = _flatten varr in
    let length = numel varr_linear in
    begin
      for i = 0 to length - 1 do
        aref := (f !aref (Genarray.get varr_linear [|i|]))
      done;
      !aref
    end

  (* Min of all elements in the NDarray *)
  let min' varr = (_fold_left (Pervasives.min) Pervasives.max_float varr)

  (* Max of all elements in the NDarray *)
  let max' varr = (_fold_left (Pervasives.max) Pervasives.min_float varr)

  (* Sum of all elements *)
  let sum' varr = (_fold_left (+.) 0. varr)

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
    (_map_fun scalar_pow_fun varr)

  (* Raise each element to power a *)
  let pow_scalar varr a =
    let pow_scalar_fun = (fun x -> (x ** a)) in
    (_map_fun pow_scalar_fun varr)

  let scalar_atan2 a varr =
    let scalar_atan2_fun = (fun x -> (Scalar.atan2 a x)) in
    (_map_fun scalar_atan2_fun varr)

  let atan2_scalar varr a =
    let atan2_scalar_fun = (fun x -> (Scalar.atan2 x a)) in
    (_map_fun atan2_scalar_fun varr)

  let _broadcasted_op varr_a varr_b op_fun =
    let (dims_a, dims_b, dims_c) =
      _get_broadcasted_dims (shape varr_a) (shape varr_b) in
    let varr_a = reshape varr_a dims_a in
    let varr_b = reshape varr_b dims_b in
    let varr_c = empty dims_c in
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

  let add varr_a varr_b = (_broadcasted_op varr_a varr_b (+.))

  let sub varr_a varr_b = (_broadcasted_op varr_a varr_b (-.))

  let mul varr_a varr_b = (_broadcasted_op varr_a varr_b ( *. ))

  let div varr_a varr_b = (_broadcasted_op varr_a varr_b ( /. ))

  let atan2 varr_a varr_b = (_broadcasted_op varr_a varr_b (Scalar.atan2))

  let pow varr_a varr_b = (_broadcasted_op varr_a varr_b ( ** ))

  let add_scalar varr a =
    let add_scalar_fun = (fun x -> (x +. a)) in
    (_map_fun add_scalar_fun varr)

  let sub_scalar varr a =
    let sub_scalar_fun = (fun x -> (x -. a)) in
    (_map_fun sub_scalar_fun varr)

  let mul_scalar varr a =
    let mul_scalar_fun = (fun x -> (x *. a)) in
    (_map_fun mul_scalar_fun varr)

  let div_scalar varr a =
    let div_scalar_fun = (fun x -> (x /. a)) in
    (_map_fun div_scalar_fun varr)

  (* Addition is commutative *)
  let scalar_add a varr = (add_scalar varr a)

  let scalar_sub a varr =
    let scalar_sub_fun = (fun x -> (a -. x)) in
    (_map_fun scalar_sub_fun varr)

  (* Multiplication is commutative *)
  let scalar_mul a varr = (mul_scalar varr a)

  let scalar_div a varr =
    let scalar_div_fun = (fun x -> (a /. x)) in
    (_map_fun scalar_div_fun varr)

  let elt_greater_equal_scalar varr b =
    let greater_equal_scalar_fun =
      (fun x -> if (Pervasives.compare x b) >= 0 then 1. else 0.) in
    (_map_fun greater_equal_scalar_fun varr)

  let clip_by_l2norm clip_norm varr =
    let l2norm_val = l2norm' varr in
    if l2norm_val > clip_norm
    then mul_scalar varr (clip_norm /. l2norm_val)
    else varr

  (* Neural network related functions *)

  (*TODO:val conv1d : ?padding:padding -> arr -> arr -> int array -> arr

  val conv2d : ?padding:padding -> arr -> arr -> int array -> arr

  val conv3d : ?padding:padding -> arr -> arr -> int array -> arr

  val max_pool1d : ?padding:padding -> arr -> int array -> int array -> arr

  val max_pool2d : ?padding:padding -> arr -> int array -> int array -> arr

  val max_pool3d : ?padding:padding -> arr -> int array -> int array -> arr

  val avg_pool1d : ?padding:padding -> arr -> int array -> int array -> arr

  val avg_pool2d : ?padding:padding -> arr -> int array -> int array -> arr

  val avg_pool3d : ?padding:padding -> arr -> int array -> int array -> arr

  val conv1d_backward_input : arr -> arr -> int array -> arr -> arr

  val conv1d_backward_kernel : arr -> arr -> int array -> arr -> arr

  val conv2d_backward_input : arr -> arr -> int array -> arr -> arr

  val conv2d_backward_kernel : arr -> arr -> int array -> arr -> arr

  val conv3d_backward_input : arr -> arr -> int array -> arr -> arr

  val conv3d_backward_kernel : arr -> arr -> int array -> arr -> arr

  val max_pool1d_backward : padding -> arr -> int array -> int array -> arr -> arr

  val max_pool2d_backward : padding -> arr -> int array -> int array -> arr -> arr

  val avg_pool1d_backward : padding -> arr -> int array -> int array -> arr -> arr

  val avg_pool2d_backward : padding -> arr -> int array -> int array -> arr -> arr
  *)

  (*TODO: this is a stub *)
  let conv1d ?(padding=SAME) varr_a varr_b intarr =
    let (dims_a, dims_b) = (shape varr_a, shape varr_b) in
    let x = intarr.(0) + 1 in
    (raise (Failure "conv1d - not implemented"); varr_a)

  (*TODO: this is a stub *)
  let conv2d ?(padding=SAME) varr_a varr_b intarr =
    let (dims_a, dims_b) = (shape varr_a, shape varr_b) in
    let x = intarr.(0) + 1 in
    (raise (Failure "conv2d - not implemented"); varr_a)

  (*TODO: this is a stub *)
  let conv3d ?(padding=SAME) varr_a varr_b intarr =
    let (dims_a, dims_b) = (shape varr_a, shape varr_b) in
    let x = intarr.(0) + 1 in
    (raise (Failure "conv3d - not implemented"); varr_a)

  (*TODO: this is a stub *)
  let max_pool1d ?(padding=SAME) varr intarr_a intarr_b =
    let dims = shape varr in
    let x = intarr_a.(0) + intarr_b.(0) + 1 in
    (raise (Failure "max_pool1d - not implemented"); varr)

  (*TODO: this is a stub *)
  let max_pool2d ?(padding=SAME) varr intarr_a intarr_b =
    let dims = shape varr in
    let x = intarr_a.(0) + intarr_b.(0) + 1 in
    (raise (Failure "max_pool2d - not implemented"); varr)

  (*TODO: this is a stub *)
  let max_pool3d ?(padding=SAME) varr intarr_a intarr_b =
    let dims = shape varr in
    let x = intarr_a.(0) + intarr_b.(0) + 1 in
    (raise (Failure "max_pool3d - not implemented"); varr)

  (*TODO: this is a stub *)
  let avg_pool1d ?(padding=SAME) varr intarr_a intarr_b =
    let dims = shape varr in
    let x = intarr_a.(0) + intarr_b.(0) + 1 in
    (raise (Failure "avg_pool1d - not implemented"); varr)

  (*TODO: this is a stub *)
  let avg_pool2d ?(padding=SAME) varr intarr_a intarr_b =
    let dims = shape varr in
    let x = intarr_a.(0) + intarr_b.(0) + 1 in
    (raise (Failure "avg_pool2d - not implemented"); varr)

  (*TODO: this is a stub *)
  let avg_pool3d ?(padding=SAME) varr intarr_a intarr_b =
    let dims = shape varr in
    let x = intarr_a.(0) + intarr_b.(0) + 1 in
    (raise (Failure "avg_pool3d - not implemented"); varr)

  (*TODO: this is a stub *)
  let conv1d_backward_input varr_a varr_b intarr varr_c =
    let (dims_a, dims_b) = (shape varr_a, shape varr_b) in
    let dims_c = shape varr_c in
    let x = intarr.(0) + 1 in
    (raise (Failure "conv1d_backward_input - not implemented"); varr_a)

  (*TODO: this is a stub *)
  let conv1d_backward_kernel varr_a varr_b intarr varr_c =
    let (dims_a, dims_b) = (shape varr_a, shape varr_b) in
    let dims_c = shape varr_c in
    let x = intarr.(0) + 1 in
    (raise (Failure "conv1d_backward_kernel - not implemented"); varr_a)

  (*TODO: this is a stub *)
  let conv2d_backward_input varr_a varr_b intarr varr_c =
    let (dims_a, dims_b) = (shape varr_a, shape varr_b) in
    let dims_c = shape varr_c in
    let x = intarr.(0) + 1 in
    (raise (Failure "conv2d_backward_input - not implemented"); varr_a)

  (*TODO: this is a stub *)
  let conv2d_backward_kernel varr_a varr_b intarr varr_c =
    let (dims_a, dims_b) = (shape varr_a, shape varr_b) in
    let dims_c = shape varr_c in
    let x = intarr.(0) + 1 in
    (raise (Failure "conv2d_backward_kernel - not implemented"); varr_a)

  (*TODO: this is a stub *)
  let conv3d_backward_input varr_a varr_b intarr varr_c =
    let (dims_a, dims_b) = (shape varr_a, shape varr_b) in
    let dims_c = shape varr_c in
    let x = intarr.(0) + 1 in
    (raise (Failure "conv3d_backward_input - not implemented"); varr_a)

  (*TODO: this is a stub *)
  let conv3d_backward_kernel varr_a varr_b intarr varr_c =
    let (dims_a, dims_b) = (shape varr_a, shape varr_b) in
    let dims_c = shape varr_c in
    let x = intarr.(0) + 1 in
    (raise (Failure "conv3d_backward_kernel - not implemented"); varr_a)

  (*TODO: this is a stub *)
  let max_pool1d_backward padding (varr_a:arr) intarr_a intarr_b (varr_b:arr) =
    let padding = (match padding with
        | SAME -> SAME
        | VALID -> VALID)
    in
    let dims_a = shape varr_a in
    let dims_b = shape varr_b in
    let x = intarr_a.(0) + intarr_b.(0) + 1 in
    (raise (Failure "max_pool1d_backward - not implemented"); varr_a)

  (*TODO: this is a stub *)
  let max_pool2d_backward padding (varr_a:arr) intarr_a intarr_b (varr_b:arr) =
    let padding = (match padding with
        | SAME -> SAME
        | VALID -> VALID)
    in
    let dims_a = shape varr_a in
    let dims_b = shape varr_b in
    let x = intarr_a.(0) + intarr_b.(0) + 1 in
    (raise (Failure "max_pool2d_backward - not implemented"); varr_a)

  (*TODO: this is a stub *)
  let avg_pool1d_backward padding (varr_a:arr) intarr_a intarr_b (varr_b:arr) =
    let padding = (match padding with
        | SAME -> SAME
        | VALID -> VALID)
    in
    let dims_a = shape varr_a in
    let dims_b = shape varr_b in
    let x = intarr_a.(0) + intarr_b.(0) + 1 in
    (raise (Failure "avg_pool1d_backward - not implemented"); varr_a)

  (*TODO: this is a stub *)
  let avg_pool2d_backward padding (varr_a:arr) intarr_a intarr_b (varr_b:arr) =
    let padding = (match padding with
        | SAME -> SAME
        | VALID -> VALID)
    in
    let dims_a = shape varr_a in
    let dims_b = shape varr_b in
    let x = intarr_a.(0) + intarr_b.(0) + 1 in
    (raise (Failure "avg_pool2d_backward - not implemented"); varr_a)

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
    let new_varr = empty [|new_rownum; new_colnum|] in
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
    let vec_linear = _flatten vec in
    if num_rows != vec_len
    then raise (Invalid_argument "Column vector does not have the same length as the number of rows in the matrix")
    else
      begin
        for i = 0 to num_rows - 1 do
          Genarray.set varr [|i; ind|] (Genarray.get vec_linear [|i|])
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
      let varr_c = empty [|m; n|] in
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
    let varr = empty dims in
    begin
      for i = 0 to m - 1 do
        Genarray.blit rows.(i) (Genarray.slice_left varr [|i|])
      done;
      varr
    end

  let of_arrays arrays =
    let m = Array.length arrays in
    let n = Array.length (arrays.(0)) in
    let varr = empty [|m; n|] in
    begin
      for i = 0 to n - 1 do
        for j = 0 to m - 1 do
          Genarray.set varr [|i; j|] (Array.get (arrays.(i)) j)
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
    let new_varr = empty new_dims in
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
  (* Implementing the following algorithm http://www.irma-international.org/viewtitle/41011/ *)
  let inv varr =
    let dims = shape varr in
    let _ = _check_is_matrix dims in
    let n = Array.get dims 0 in
    if (Array.get dims 1) != n
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

end

module NdarrayPureSingle = MakeNdarray(GenarrayFloat32Elt)
module NdarrayPureDouble = MakeNdarray(GenarrayFloat64Elt)

module PureS = Owl_algodiff_generic.Make (NdarrayPureSingle)
module PureD = Owl_algodiff_generic.Make (NdarrayPureDouble)
