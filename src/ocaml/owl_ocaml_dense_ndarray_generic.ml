(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl

let pi_val = 3.141592653589793238462643383279502884197169399375105820974944592307816

(* TODO: add : Ndarraysig *)
module Ndarray32float = struct

  type arr = (float, float32_elt, c_layout) Genarray.t

  type elt = float

  let empty dims = (Genarray.create float32 c_layout dims)

  let zeros dims = let varr = empty dims in (Genarray.fill varr 0.; varr)

  let ones dims = let varr = empty dims in (Genarray.fill varr 1.; varr)

  (* return the shape of the ndarray *)
  let shape varr = Genarray.dims varr

  (* return the number of elements in the ndarray*)
  let numel varr = let v_shape = shape varr in (Array.fold_left ( * ) 1 v_shape)

  let get varr index = (Genarray.get varr index)

  let set varr index value = (Genarray.set varr index value)

  (*TODO: val get_slice : index list -> arr -> arr *)

  (*TODO: val set_slice : index list -> arr -> arr -> unit *)

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

  let uniform ?(scale=1.) dims =
    let rand_gen = Random.State.make_self_init() in
    let uniform_gen_fun =
      (fun () -> (scale *. (Random.State.float rand_gen 1.))) in (*TODO: is this actually uniform?*)
    (_generate_random_ndarray dims uniform_gen_fun)

  let bernoulli ?(p=0.5) ?seed dims =
    assert (p >= 0. && p <= 1.);
    let rand_gen = match seed with
      | Some seedval -> Random.State.make [|seedval|]
      | None -> Random.State.make_self_init()
    in
    let bernoulli_gen_fun =
      (fun () -> if (Random.State.float rand_gen 1.) <= p then 1. else 0.) in
    (_generate_random_ndarray dims bernoulli_gen_fun)

  (* TODO: investigate whether using the Box-Muller transform is okay *)
  let gaussian ?(sigma=1.) dims =
    let rand_gen = Random.State.make_self_init() in
    let u1 = ref 0. in
    let u2 = ref 0. in
    let case = ref false in
    let z0 = ref 0. in
    let z1 = ref 1. in
    let gaussian_gen_fun () = (
        if !case
        then (case := false; sigma *. !z1)
        else (
          case := true;
          u1 := Random.State.float rand_gen 1.;
          u2 := Random.State.float rand_gen 1.;
          z0 := (Pervasives.sqrt ((~-. 2.) *. (Pervasives.log (!u1)))) *. (Pervasives.cos (2. *. pi_val *. (!u2)));
          z1 := (Pervasives.sqrt ((~-. 2.) *. (Pervasives.log (!u1)))) *. (Pervasives.sin (2. *. pi_val *. (!u2)));
          sigma *. !z0
        )
      ) in
    (_generate_random_ndarray dims gaussian_gen_fun)

  (*TODO: val tile : arr -> int array -> arr

  TODO:val split : ?axis:int -> int array -> arr -> arr array

  TODO:val print : ?max_row:int -> ?max_col:int -> ?header:bool -> ?fmt:(elt -> string) -> arr -> unit

    TODO:val draw_along_dim0 : arr -> int -> arr * int array *)

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
  let abs varr = (_map_fun Pervasives.abs_float varr)

  let neg varr = (_map_fun Pervasives.(~-.) varr)

  let floor varr = (_map_fun Pervasives.floor varr)

  let ceil varr = (_map_fun Pervasives.ceil varr)

  let round varr =
    let round_fun = (fun x -> (Pervasives.floor (x +. 0.5))) in
    (_map_fun round_fun varr)

  let sqr varr =
    let sqr_fun = (fun x -> x *. x) in
    (_map_fun sqr_fun varr)

  let sqrt varr = (_map_fun Pervasives.sqrt varr)

  let log varr = (_map_fun Pervasives.log varr)

  let log2 varr =
    let log2_fun = (fun x -> ((Pervasives.log x) /. (Pervasives.log 2.))) in
    (_map_fun log2_fun varr)

  let log10 varr = (_map_fun Pervasives.log10 varr)

  let exp varr = (_map_fun Pervasives.exp varr)

  let sin varr = (_map_fun Pervasives.sin varr)

  let cos varr = (_map_fun Pervasives.cos varr)

  let tan varr = (_map_fun Pervasives.tan varr)

  let tan varr = (_map_fun Pervasives.tan varr)

  let sinh varr = (_map_fun Pervasives.sinh varr)

  let cosh varr = (_map_fun Pervasives.cosh varr)

  let tanh varr = (_map_fun Pervasives.tanh varr)

  let asin varr = (_map_fun Pervasives.asin varr)

  let acos varr = (_map_fun Pervasives.acos varr)

  let atan varr = (_map_fun Pervasives.atan varr)

  let asinh varr =
    (* asinh(x) is log(x + sqrt(x * x + 1)) TODO: check this is precise enough*)
    let asinh_fun =
      (fun x -> (Pervasives.log (x +. (Pervasives.sqrt ((x *. x) +. 1.))))) in
    (_map_fun asinh_fun varr)

  let acosh varr =
    (* acosh(x) is log(x + sqrt(x * x - 1)) TODO: check this is precise enough*)
    let acosh_fun =
      (fun x -> (Pervasives.log (x +. (Pervasives.sqrt ((x *. x) -. 1.))))) in
    (_map_fun acosh_fun varr)

  let atanh varr =
    (* atanh(x) is 1/2 * log((1 + x)/(1-x)))TODO: check this is precise enough*)
    let atanh_fun =
      (fun x -> (0.5 *. (Pervasives.log ((1. +. x) /. (1. -. x))))) in
    (_map_fun atanh_fun varr)

      (* TODO:
  val sum : ?axis:int -> arr -> arr

  val sum_slices : ?axis:int -> arr -> arr*)

  (* -1. for negative numbers, 0 or (-0) for 0,
   1 for positive numbers, nan for nan*)
  let signum varr =
    let signum_fun =
      (fun x ->
         if ((compare x nan) = 0)
         then nan
         else (
           if (x > 0.)
           then 1.
           else (
             if x < 0.
             then (~-. 1.)
             else 0.
           )
         )
      ) in
    (_map_fun signum_fun varr)

  (* Apply 1 / (1 + exp (-x)) for each element x *)
  let sigmoid varr =
    let sigmoid_fun = (fun x -> (1. /. (1. +. (Pervasives.log (~-. x)) ) )) in
    (_map_fun sigmoid_fun varr)

  let relu varr =
    let relu_fun = (fun x -> Pervasives.max 0. x) in
    (_map_fun relu_fun varr)

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
      (fun aggregate elem -> (aggregate +. (Pervasives.abs_float (elem)))) in
    (_fold_left l1norm_fun 0. varr)

  let l2norm_sqr' varr =
    let l2norm_sqr_fun =
      (fun aggregate elem -> (aggregate +. (elem *. elem))) in
    (_fold_left l2norm_sqr_fun 0. varr)

  let l2norm' varr =
    let l2norm_sqr_val = l2norm_sqr' varr in
    (Pervasives.sqrt l2norm_sqr_val)

  (* scalar_pow a varr computes the power of scalar to each element of varr *)
  let scalar_pow a varr =
    let scalar_pow_fun = (fun x -> (a ** x)) in
    (_map_fun scalar_pow_fun varr)

  (* Raise each element to power a *)
  let pow_scalar varr a =
    let pow_scalar_fun = (fun x -> (x ** a)) in
    (_map_fun pow_scalar_fun varr)

  let scalar_atan2 a varr =
    let scalar_atan2_fun = (fun x -> (Pervasives.atan2 a x)) in
    (_map_fun scalar_atan2_fun varr)

  let atan2_scalar varr a =
    let atan2_scalar_fun = (fun x -> (Pervasives.atan2 x a)) in
    (_map_fun atan2_scalar_fun varr)

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

  let atan2 varr_a varr_b = (_broadcasted_op varr_a varr_b (Pervasives.atan2))

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

  (*val conv1d : ?padding:padding -> arr -> arr -> int array -> arr

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

  (* TODO:

  val inv : arr -> arr

  val transpose : ?axis:int array -> arr -> arr

  val draw_rows : ?replacement:bool -> arr -> int -> arr * int array

  val draw_rows2 : ?replacement:bool -> arr -> arr -> int -> arr * arr * int array

*)
end
