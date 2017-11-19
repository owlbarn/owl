(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

module S = Pervasives


(* Functor of making Lazy module of different number types *)

module Make
  (A : InpureSig)
  = struct

  (* type definitions *)

  type elt = A.elt

  type t = {
    mutable op     : op;
    mutable refnum : int;
    mutable outval : A.arr array;
  }
  and arr = t
  and op =
    | Noop
    | Fun00       of t * (A.arr -> A.arr)
    | Fun01       of t * (A.arr -> unit)
    | Fun02       of t * t * (A.arr -> A.arr -> unit) * (A.arr -> A.arr -> A.arr)
    | Fun03       of t array * (A.arr array -> A.arr)
    | Fun04       of t * elt * (A.arr -> elt -> unit)
    | Fun05       of elt * t * (elt -> A.arr -> unit)
    | Split       of t * int option * int array
    | Item_I      of t * int (* select the ith item in an array *)


  let unpack_operands = function
    | Noop                        -> [| |]
    | Fun00 (a, f)                -> [|a|]
    | Fun01 (a, f)                -> [|a|]
    | Fun02 (a, b, f, g)          -> [|a; b|]
    | Fun03 (a, f)                -> a
    | Fun04 (a, b, f)             -> [|a|]
    | Fun05 (a, b, f)             -> [|b|]
    | Split (a, b, c)             -> [|a|]
    | Item_I (a, b)               -> [|a|]


  let inc_operand_refnum x =
    let operands = unpack_operands x in
    let s = Owl_utils.Stack.make () in
    Array.iter (fun a ->
      (* avoid increasing twice for the same operand *)
      if Owl_utils.Stack.memq s a = false then (
        Owl_utils.Stack.push s a;
        a.refnum <- a.refnum + 1
      )
    ) operands



  let inc_refnum x = x.refnum <- x.refnum + 1


  let make_t ?(outval=[||]) ?(refnum=0) op =
    inc_operand_refnum op;
    {
      op;
      refnum;
      outval;
    }


  let allocate_1 operands =
    let a = operands.(0) in
    if a.refnum = 1 then a.outval.(0)
    else A.copy a.outval.(0)


  let allocate_2 operands =
    let a = operands.(0) in
    let b = operands.(1) in
    let a_val = a.outval.(0) in
    let b_val = b.outval.(0) in
    let a_shp = A.shape a_val in
    let b_shp = A.shape b_val in
    if a_shp = b_shp then (
      if a.refnum = 1 then Some (a_val, b_val)
      else if b.refnum = 1 then Some (b_val, a_val)
      else Some (A.copy a_val, b_val)
    )
    (* FIXME *)
    (*
    else if Owl_utils.array_greater_eqaul a_shp b_shp && a.refnum = 1 then Some (a_val, b_val)
    else if Owl_utils.array_greater_eqaul b_shp a_shp && b.refnum = 1 then Some (b_val, a_val)
    *)
    else None


  (* recursively evaluate an expression *)

  let rec _eval_term x =
    if Array.length x.outval = 0 then (
      match x.op with
      | Noop                        -> ()
      | Fun00 (a, f)                -> _eval_map5 x f
      | Fun01 (a, f)                -> _eval_map1 x f
      | Fun02 (a, b, f, g)          -> _eval_map2 x f g
      | Fun03 (a, f)                -> _eval_map6 x f
      | Fun04 (a, b, f)             -> _eval_map3 x b f
      | Fun05 (a, b, f)             -> _eval_map4 x a f
      | Split (a, b, c)             -> _eval_map7 x (fun x -> A.split ?axis:b c x)
      | Item_I (a, b)               -> _item_i x b
    )

  (* [f] is inpure, for [arr -> arr] *)
  and _eval_map1 x f =
    let operands = unpack_operands x.op in
    _eval_term operands.(0);
    let a = allocate_1 operands in
    f a;
    x.outval <- [|a|]

  (* [f] is inpure and [g] is pure, for [arr -> arr -> arr] *)
  and _eval_map2 x f g =
    let operands = unpack_operands x.op in
    _eval_term operands.(0);
    _eval_term operands.(1);
    let a = operands.(0).outval.(0) in
    let b = operands.(1).outval.(0) in
    let c = match allocate_2 operands with
      | Some (p, q) -> f p q; p    (* in-place function, p will be written *)
      | None        -> g a b       (* pure function without touching a and b *)
    in
    x.outval <- [|c|]

  (* [f] is inpure, for [arr -> elt -> arr] *)
  and _eval_map3 x b f =
    let operands = unpack_operands x.op in
    _eval_term operands.(0);
    let a = allocate_1 operands in
    f a b;
    x.outval <- [|a|]

  (* [f] is inpure, for [elt -> arr -> arr] *)
  and _eval_map4 x a f =
    let operands = unpack_operands x.op in
    _eval_term operands.(0);
    let b = allocate_1 operands in
    f a b;
    x.outval <- [|b|]

  (* [f] is pure, shape changes so always allocate mem, for [arr -> arr] *)
  and _eval_map5 x f =
    let operands = unpack_operands x.op in
    _eval_term operands.(0);
    let a = operands.(0).outval.(0) in
    x.outval <- [|f a|]

  (* [f] is pure, shape changes so always allocate mem, for [arr array -> arr] *)
  and _eval_map6 x f =
    let operands = unpack_operands x.op in
    let a = Array.map (fun x -> _eval_term x; x.outval.(0)) operands in
    x.outval <- [|f a|]

  (* [f] is pure, allocate mem, for [arr -> arr array] *)
  and _eval_map7 x f =
    let operands = unpack_operands x.op in
    _eval_term operands.(0);
    let a = operands.(0).outval.(0) in
    x.outval <- f a

  (* get the specific output val of [x] for a given index *)
  and _item_i x i =
    let operands = unpack_operands x.op in
    _eval_term operands.(0);
    assert (i < Array.length operands.(0).outval);
    x.outval <- [|operands.(0).outval.(i)|]


  let of_ndarray x = make_t ~outval:[|x|] Noop


  let to_ndarray x =
    _eval_term x;
    x.outval.(0)


  let eval x = _eval_term x


  (* creation functions *)

  let empty d = A.empty d |> of_ndarray

  let zeros d = A.zeros d |> of_ndarray

  let ones d = A.ones d |> of_ndarray

  let uniform ?scale d = A.uniform ?scale d |> of_ndarray

  let gaussian ?sigma d = A.gaussian ?sigma d |> of_ndarray

  let bernoulli ?p ?seed d = A.bernoulli ?p ?seed d |> of_ndarray


  (* properties and manipulations *)

  let shape x = to_ndarray x |> A.shape

  let numel x = to_ndarray x |> A.numel

  let row_num x = to_ndarray x |> A.row_num

  let col_num x = to_ndarray x |> A.col_num

  let get x i = A.get (to_ndarray x) i

  let set x i a = A.set (to_ndarray x) i a

  let get_slice axis x = A.get_slice axis (to_ndarray x) |> of_ndarray

  let set_slice axis x y = A.set_slice axis (to_ndarray x) (to_ndarray y)

  let copy_row_to x v i = A.copy_row_to (to_ndarray x) (to_ndarray v) i

  let copy_col_to x v i = A.copy_col_to (to_ndarray x) (to_ndarray v) i

  let row x i = A.row (to_ndarray x) i |> of_ndarray

  let rows x l = A.rows (to_ndarray x) l |> of_ndarray

  let trace x = A.trace (to_ndarray x)

  let copy x = make_t (Fun01 (x, ignore))

  let reset x = A.reset (to_ndarray x)

  let reshape x d = make_t (Fun00 (x, (fun x -> A.(reshape (copy x) d)))) (* FIXME *)

  let tile x reps = make_t (Fun00 (x, (fun x -> A.tile x reps)))

  let repeat ?axis x reps = make_t (Fun00 (x, (fun x -> A.repeat ?axis x reps)))

  let concatenate ?axis x = make_t (Fun03 (x, (fun x -> A.concatenate ?axis x)))

  let split ?axis parts x =
    let t = make_t (Split (x, axis, parts)) in
    Array.mapi (fun i _ -> make_t (Item_I (t, i))) parts

  let to_rows x = A.to_rows (to_ndarray x) |> Array.map of_ndarray

  let of_rows x = Array.map to_ndarray x |> A.of_rows |> of_ndarray

  let of_arrays x = A.of_arrays x |> of_ndarray

  let sum_slices ?axis x = A.sum_slices ?axis (to_ndarray x) |> of_ndarray

  let draw_along_dim0 x n =
    let y, indices = A.draw_along_dim0 (to_ndarray x) n in
    of_ndarray y, indices

  let draw_rows ?replacement x c =
    let x, l = A.draw_rows (to_ndarray x) c in
    of_ndarray x, l

  let draw_rows2 ?replacement x y c =
    let x, y, l = A.draw_rows2 (to_ndarray x) (to_ndarray y) c in
    of_ndarray x, of_ndarray y, l

  let elt_greater_equal_scalar x a = A.elt_greater_equal_scalar (to_ndarray x) a |> of_ndarray

  let print ?max_row ?max_col ?header ?fmt x = Printf.printf "lazy t"


  (* reduce to scalar *)

  let sum' x = to_ndarray x |> A.sum'

  let prod' x = to_ndarray x |> A.prod'

  let min' x = to_ndarray x |> A.min'

  let max' x = to_ndarray x |> A.max'

  let mean' x = to_ndarray x |> A.mean'

  let var' x = to_ndarray x |> A.var'

  let std' x = to_ndarray x |> A.std'

  let l1norm' x = to_ndarray x |> A.l1norm'

  let l2norm' x = to_ndarray x |> A.l2norm'

  let l2norm_sqr' x = to_ndarray x |> A.l2norm_sqr'


  (* math functions *)

  let add x y = make_t (Fun02 (x, y, A.add_, A.add))

  let sub x y = make_t (Fun02 (x, y, A.sub_, A.sub))

  let mul x y = make_t (Fun02 (x, y, A.mul_, A.mul))

  let div x y = make_t (Fun02 (x, y, A.div_, A.div))

  let pow x y = make_t (Fun02 (x, y, A.pow_, A.pow))

  let atan2 x y = make_t (Fun02 (x, y, A.atan2_, A.atan2))

  let hypot x y = make_t (Fun02 (x, y, A.hypot_, A.hypot))

  let fmod x y = make_t (Fun02 (x, y, A.fmod_, A.fmod))

  let min2 x y = make_t (Fun02 (x, y, A.min2_, A.min2))

  let max2 x y = make_t (Fun02 (x, y, A.max2_, A.max2))

  let dot x y = make_t (Fun03 ([|x; y|], (fun x -> A.dot x.(0) x.(1))))

  let add_scalar x a = make_t (Fun04 (x, a, A.add_scalar_))

  let sub_scalar x a = make_t (Fun04 (x, a, A.sub_scalar_))

  let mul_scalar x a = make_t (Fun04 (x, a, A.mul_scalar_))

  let div_scalar x a = make_t (Fun04 (x, a, A.div_scalar_))

  let pow_scalar x a = make_t (Fun04 (x, a, A.pow_scalar_))

  let atan2_scalar x a = make_t (Fun04 (x, a, A.atan2_scalar_))

  let fmod_scalar x a = make_t (Fun04 (x, a, A.fmod_scalar_))

  let scalar_add a x = make_t (Fun05 (a, x, A.scalar_add_))

  let scalar_sub a x = make_t (Fun05 (a, x, A.scalar_sub_))

  let scalar_mul a x = make_t (Fun05 (a, x, A.scalar_mul_))

  let scalar_div a x = make_t (Fun05 (a, x, A.scalar_div_))

  let scalar_pow a x = make_t (Fun05 (a, x, A.scalar_pow_))

  let scalar_atan2 a x = make_t (Fun05 (a, x, A.scalar_atan2_))

  let scalar_fmod a x = make_t (Fun05 (a, x, A.scalar_fmod_))

  let abs x = make_t (Fun01 (x, A.abs_))

  let neg x = make_t (Fun01 (x, A.neg_))

  let conj x = make_t (Fun01 (x, A.conj_))

  let reci x = make_t (Fun01 (x, A.reci_))

  let signum x = make_t (Fun01 (x, A.signum_))

  let sqr x = make_t (Fun01 (x, A.sqr_))

  let sqrt x = make_t (Fun01 (x, A.sqrt_))

  let cbrt x = make_t (Fun01 (x, A.cbrt_))

  let exp x = make_t (Fun01 (x, A.exp_))

  let exp2 x = make_t (Fun01 (x, A.exp2_))

  let exp10 x = make_t (Fun01 (x, A.exp10_))

  let expm1 x = make_t (Fun01 (x, A.expm1_))

  let log x = make_t (Fun01 (x, A.log_))

  let log2 x = make_t (Fun01 (x, A.log2_))

  let log10 x = make_t (Fun01 (x, A.log10_))

  let log1p x = make_t (Fun01 (x, A.log1p_))

  let sin x = make_t (Fun01 (x, A.sin_))

  let cos x = make_t (Fun01 (x, A.cos_))

  let tan x = make_t (Fun01 (x, A.tan_))

  let asin x = make_t (Fun01 (x, A.asin_))

  let acos x = make_t (Fun01 (x, A.acos_))

  let atan x = make_t (Fun01 (x, A.atan_))

  let sinh x = make_t (Fun01 (x, A.sinh_))

  let cosh x = make_t (Fun01 (x, A.cosh_))

  let tanh x = make_t (Fun01 (x, A.tanh_))

  let asinh x = make_t (Fun01 (x, A.asinh_))

  let acosh x = make_t (Fun01 (x, A.acosh_))

  let atanh x = make_t (Fun01 (x, A.atanh_))

  let floor x = make_t (Fun01 (x, A.floor_))

  let ceil x = make_t (Fun01 (x, A.ceil_))

  let round x = make_t (Fun01 (x, A.round_))

  let trunc x = make_t (Fun01 (x, A.trunc_))

  let fix x = make_t (Fun01 (x, A.fix_))

  let erf x = make_t (Fun01 (x, A.erf_))

  let erfc x = make_t (Fun01 (x, A.erfc_))

  let relu x = make_t (Fun01 (x, A.relu_))

  let softplus x = make_t (Fun01 (x, A.softplus_))

  let softsign x = make_t (Fun01 (x, A.softsign_))

  let softmax x = make_t (Fun01 (x, A.softmax_))

  let sigmoid x = make_t (Fun01 (x, A.sigmoid_))

  let sum ?axis x = make_t (Fun00 (x, A.sum))

  let prod ?axis x = make_t (Fun00 (x, A.prod))

  let min ?axis x = make_t (Fun00 (x, A.min))

  let max ?axis x = make_t (Fun00 (x, A.max))

  let mean ?axis x = make_t (Fun00 (x, A.mean))

  let var ?axis x = make_t (Fun00 (x, A.var))

  let std ?axis x = make_t (Fun00 (x, A.std))

  let l1norm ?axis x = make_t (Fun00 (x, A.l1norm))

  let l2norm ?axis x = make_t (Fun00 (x, A.l2norm))

  let cumsum ?axis x = make_t (Fun01 (x, A.cumsum_))

  let cumprod ?axis x = make_t (Fun01 (x, A.cumprod_))

  let cummin ?axis x = make_t (Fun01 (x, A.cummin_))

  let cummax ?axis x = make_t (Fun01 (x, A.cummax_))

  let inv x = make_t (Fun00 (x, A.inv))

  let transpose ?axis x = make_t (Fun00 (x, A.transpose))

  let clip_by_l2norm a x = make_t (Fun00 (x, (fun x -> A.clip_by_l2norm a x)))

  let conv1d ?padding input kernel stride = make_t (Fun03 ([|input; kernel|], (fun x -> A.conv1d ?padding x.(0) x.(1) stride)))

  let conv2d ?padding input kernel stride = make_t (Fun03 ([|input; kernel|], (fun x -> A.conv2d ?padding x.(0) x.(1) stride)))

  let conv3d ?padding input kernel stride = make_t (Fun03 ([|input; kernel|], (fun x -> A.conv3d ?padding x.(0) x.(1) stride)))

  let max_pool1d ?padding input kernel stride = make_t (Fun00 (input, (fun x -> A.max_pool1d ?padding x kernel stride)))

  let max_pool2d ?padding input kernel stride = make_t (Fun00 (input, (fun x -> A.max_pool2d ?padding x kernel stride)))

  let max_pool3d ?padding input kernel stride = make_t (Fun00 (input, (fun x -> A.max_pool3d ?padding x kernel stride)))

  let avg_pool1d ?padding input kernel stride = make_t (Fun00 (input, (fun x -> A.avg_pool1d ?padding x kernel stride)))

  let avg_pool2d ?padding input kernel stride = make_t (Fun00 (input, (fun x -> A.avg_pool2d ?padding x kernel stride)))

  let avg_pool3d ?padding input kernel stride = make_t (Fun00 (input, (fun x -> A.avg_pool3d ?padding x kernel stride)))

  let conv1d_backward_input input kernel stride output' = make_t (Fun03 ([|input; kernel; output'|], (fun x -> A.conv1d_backward_input x.(0) x.(1) stride x.(2))))

  let conv1d_backward_kernel input kernel stride output' = make_t (Fun03 ([|input; kernel; output'|], (fun x -> A.conv1d_backward_kernel x.(0) x.(1) stride x.(2))))

  let conv2d_backward_input input kernel stride output' = make_t (Fun03 ([|input; kernel; output'|], (fun x -> A.conv2d_backward_input x.(0) x.(1) stride x.(2))))

  let conv2d_backward_kernel input kernel stride output' = make_t (Fun03 ([|input; kernel; output'|], (fun x -> A.conv2d_backward_kernel x.(0) x.(1) stride x.(2))))

  let conv3d_backward_input input kernel stride output' = make_t (Fun03 ([|input; kernel; output'|], (fun x -> A.conv3d_backward_input x.(0) x.(1) stride x.(2))))

  let conv3d_backward_kernel input kernel stride output' = make_t (Fun03 ([|input; kernel; output'|], (fun x -> A.conv3d_backward_kernel x.(0) x.(1) stride x.(2))))

  let max_pool1d_backward padding input kernel stride output' = make_t (Fun03 ([|input; output'|], (fun x -> A.max_pool1d_backward padding x.(0) kernel stride x.(1))))

  let max_pool2d_backward padding input kernel stride output' = make_t (Fun03 ([|input; output'|], (fun x -> A.max_pool2d_backward padding x.(0) kernel stride x.(1))))

  let avg_pool1d_backward padding input kernel stride output' = make_t (Fun03 ([|input; output'|], (fun x -> A.avg_pool1d_backward padding x.(0) kernel stride x.(1))))

  let avg_pool2d_backward padding input kernel stride output' = make_t (Fun03 ([|input; output'|], (fun x -> A.avg_pool2d_backward padding x.(0) kernel stride x.(1))))


  (* comparion functions *)

  let equal x y = A.equal (to_ndarray x) (to_ndarray y)

  let not_equal x y = A.not_equal (to_ndarray x) (to_ndarray y)

  let less x y = A.less (to_ndarray x) (to_ndarray y)

  let greater x y = A.greater (to_ndarray x) (to_ndarray y)

  let less_equal x y = A.less_equal (to_ndarray x) (to_ndarray y)

  let greater_equal x y = A.greater_equal (to_ndarray x) (to_ndarray y)


end
