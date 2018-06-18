(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_opencl_utils

open Owl_opencl_generated


type t =
  | F     of float
  | F32   of (float, Bigarray.float32_elt) Owl_dense_ndarray_generic.t
  | F64   of (float, Bigarray.float64_elt) Owl_dense_ndarray_generic.t
  | Trace of trace
and trace = {
  mutable op     : op;
  mutable input  : trace array;
  mutable outval : t array;        (* output value, not Trace *)
  mutable outmem : cl_mem array;
  mutable events : cl_event array;
  mutable refnum : int;
}
and op =
  | Noop         of string
  | Map          of string
  | MapN         of string
  | MapArrScalar of string
  | Reduce       of string


let pack_input = function
  | Trace x -> (
      x.refnum <- x.refnum + 1;
      x
    )
  | F32 x   -> (
      let ctx = Owl_opencl_context.(default.context) in
      let x_mem = Owl_opencl_base.Buffer.create_bigarray ~flags:[Owl_opencl_generated.cl_MEM_USE_HOST_PTR] ctx x in
      {
        op      = Noop "";
        input   = [| |];
        outval  = [|F32 x|];
        outmem  = [|x_mem|];
        events  = [| |];
        refnum  = 1;
      }
    )
  | x       -> {
      op      = Noop "";
      input   = [| |];
      outval  = [|x|];
      outmem  = [| |];
      events  = [| |];
      refnum  = 1;
    }


let pack_op op input = Trace {
  op;
  input  = Array.map pack_input input;
  outval = [||];
  outmem = [||];
  events = [||];
  refnum = 0;
}


let pack_flt x = F x


let unpack_flt = function
  | F x   -> x
  | _     -> failwith "owl_opencl_operand:unpack_flt"


let unpack_trace = function
  | Trace x -> x
  | _       -> failwith "owl_opencl_operand:unpack_trace"


let pack_arr
  : type a b. (a, b) Owl_dense_ndarray_generic.t -> t
  = fun x ->
  match Owl_dense_ndarray_generic.kind x with
  | Bigarray.Float32 -> F32 x
  | Bigarray.Float64 -> F64 x
  | _                -> failwith "owl_opencl_operand:pack_arr"


let unpack_arr = function
  | F32 x -> Obj.magic x
  | F64 x -> Obj.magic x
  | _     -> failwith "owl_opencl_operand:unpack_arr"


let get_input_event x =
  x.input
  |> Array.fold_left (fun a i -> Array.append a i.events) [||]
  |> Array.to_list


let get_input_kind x i =
  assert (Array.length x.input > i);
  let input_i = x.input.(i) in
  input_i.outval.(i) |> unpack_arr |> Owl_dense_ndarray_generic.kind


let get_val_mem_ptr x i =
  let x_val = x.outval.(0) in
  let x_mem = x.outmem.(0) in
  let x_ptr = Ctypes.allocate Owl_opencl_generated.cl_mem x_mem in
  x_val, x_mem, x_ptr


let allocate_from_arr ctx a =
  let a_val, a_mem, a_ptr = get_val_mem_ptr a 0 in
  let b_val, b_mem, b_ptr =
    if a.refnum = 1 then
      a_val, a_mem, a_ptr
    else (
      let a_upk = a_val |> unpack_arr in
      let a_knd = Owl_dense_ndarray_generic.kind a_upk in
      let a_shp = Owl_dense_ndarray_generic.shape a_upk in
      let b_val = Owl_dense_ndarray_generic.empty a_knd a_shp in
      let b_mem = Owl_opencl_base.Buffer.create_bigarray ~flags:[Owl_opencl_generated.cl_MEM_USE_HOST_PTR] ctx b_val in
      let b_ptr = Ctypes.allocate Owl_opencl_generated.cl_mem b_mem in
      F32 b_val, b_mem, b_ptr
    )
  in
  (a_val, a_mem, a_ptr), (b_val, b_mem, b_ptr)


(* evalution function for the map-reduce primitives *)


(* FIXME: scalar is not taken into account *)
let allocate_from_inputs ctx x =
  let src = Owl_utils.Stack.make () in
  let dst = Owl_utils.Stack.make () in
  Array.iter (fun a ->
    let a_val, a_mem, a_ptr = get_val_mem_ptr a 0 in

    let b_val, b_mem, b_ptr =
      if a.refnum = 1 then
        a_val, a_mem, a_ptr
      else (
        let a_upk = a_val |> unpack_arr in
        let a_knd = Owl_dense_ndarray_generic.kind a_upk in
        let a_shp = Owl_dense_ndarray_generic.shape a_upk in
        let b_val = Owl_dense_ndarray_generic.empty a_knd a_shp in
        let b_mem = Owl_opencl_base.Buffer.create_bigarray ~flags:[Owl_opencl_generated.cl_MEM_USE_HOST_PTR] ctx b_val in
        let b_ptr = Ctypes.allocate Owl_opencl_generated.cl_mem b_mem in
        F32 b_val, b_mem, b_ptr
      )
    in

    Owl_utils.Stack.push src (a_val, a_mem, a_ptr);
    Owl_utils.Stack.push dst (b_val, b_mem, b_ptr);
  ) x.input;
  Owl_utils.Stack.(to_array src, to_array dst)


let map_arr_eval param fun_name x =
  let ctx, cmdq, program = param in
  let kind = get_input_kind x 0 in
  let kernel = Owl_opencl_context.(ba_kernel kind fun_name program) in

  let src, dst = allocate_from_inputs ctx x in
  let a_val, a_mem, a_ptr = src.(0) in
  let b_val, b_mem, b_ptr = dst.(0) in
  let _size = a_val |> unpack_arr |> Owl_dense_ndarray_generic.numel in
  let wait_for = get_input_event x in

  Owl_opencl_base.Kernel.set_arg kernel 0 sizeof_cl_mem a_ptr;
  Owl_opencl_base.Kernel.set_arg kernel 1 sizeof_cl_mem b_ptr;
  let event = Owl_opencl_base.Kernel.enqueue_ndrange ~wait_for cmdq kernel 1 [_size] in
  x.outval <- [|b_val|];
  x.outmem <- [|b_mem|];
  x.events <- [|event|]


let mapn_arr_eval param fun_name x =
  let ctx, cmdq, program = param in
  let kind = get_input_kind x 0 in
  let kernel = Owl_opencl_context.(ba_kernel kind fun_name program) in

  let src = Array.mapi (fun i a -> get_val_mem_ptr a i) x.input in
  let tmp = Owl_utils.Array.filteri_v (fun i a -> a.refnum = 1, i) x.input in
  let dst = match Array.length tmp > 0 with
    | true  -> (allocate_from_inputs ctx x |> snd).(tmp.(0))
    | false -> (allocate_from_inputs ctx x |> snd).(0)
  in

  let b_val, b_mem, _ = dst in
  let _size = b_val |> unpack_arr |> Owl_dense_ndarray_generic.numel in
  let wait_for = Array.fold_left (fun a b -> a @ (get_input_event b)) [] x.input in

  let args = Array.append src [|dst|] in
  Array.iteri (fun i (_, _, a_ptr) -> Owl_opencl_base.Kernel.set_arg kernel i sizeof_cl_mem a_ptr) args;
  let event = Owl_opencl_base.Kernel.enqueue_ndrange ~wait_for cmdq kernel 1 [_size] in
  x.outval <- [|b_val|];
  x.outmem <- [|b_mem|];
  x.events <- [|event|]


let map_arr_scalar_eval param fun_name x =
  let ctx, cmdq, program = param in
  let kind = get_input_kind x 0 in
  let kernel = Owl_opencl_context.(ba_kernel kind fun_name program) in

  let src, dst = allocate_from_arr ctx x.input.(0) in
  let a_val, a_mem, a_ptr = src in
  let b_val, b_mem, b_ptr = dst in

  let c_val = x.input.(1).outval.(0) |> unpack_flt in
  let c_ptr = Ctypes.allocate Ctypes.float c_val in
  let _size = a_val |> unpack_arr |> Owl_dense_ndarray_generic.numel in
  let wait_for = get_input_event x in

  Owl_opencl_base.Kernel.set_arg kernel 0 sizeof_cl_mem a_ptr;
  Owl_opencl_base.Kernel.set_arg kernel 1 sizeof_float_ptr c_ptr;
  Owl_opencl_base.Kernel.set_arg kernel 2 sizeof_cl_mem b_ptr;
  let event = Owl_opencl_base.Kernel.enqueue_ndrange ~wait_for cmdq kernel 1 [_size] in
  x.outval <- [|b_val|];
  x.outmem <- [|b_mem|];
  x.events <- [|event|]


let _reduce_eval param fun_name wait_for num_groups group_size a_val a_ptr =
  let ctx, cmdq, program = param in
  let kind = Owl_dense_ndarray_generic.kind a_val in
  let kernel = Owl_opencl_context.(ba_kernel kind fun_name program) in

  let a_knd = Owl_dense_ndarray_generic.kind a_val in
  let b_val = Owl_dense_ndarray_generic.empty a_knd [|num_groups|] in
  let b_mem = Owl_opencl_base.Buffer.create_bigarray ~flags:[Owl_opencl_generated.cl_MEM_USE_HOST_PTR] ctx b_val in
  let b_ptr = Ctypes.allocate Owl_opencl_generated.cl_mem b_mem in
  let s_ptr = a_val |> Owl_dense_ndarray_generic.numel |> Ctypes.(allocate int) in

  let global_work_size = [ num_groups * group_size ] in
  let local_work_size = [ group_size ] in

  Owl_opencl_base.Kernel.set_arg kernel 0 sizeof_cl_mem a_ptr;
  Owl_opencl_base.Kernel.set_arg kernel 1 sizeof_cl_mem b_ptr;
  Owl_opencl_base.Kernel.set_arg kernel 2 num_groups magic_null;
  Owl_opencl_base.Kernel.set_arg kernel 3 sizeof_int s_ptr;
  let event = Owl_opencl_base.Kernel.enqueue_ndrange ~wait_for ~local_work_size cmdq kernel 1 global_work_size in
  event, b_val, b_mem, b_ptr


let reduce_eval param fun_name x =
  (* FIXME: need to query the device to decide *)
  (* min-len needs to be group_size * 2 *)
  let num_groups = 64 in
  let group_size = 64 in
  let wait_for = get_input_event x in
  let a_val, a_mem, a_ptr = get_val_mem_ptr x.input.(0) 0 in
  let event, b_val, b_mem, b_ptr = _reduce_eval param fun_name wait_for (num_groups * 2) group_size (unpack_arr a_val) a_ptr in
  let event, b_val, b_mem, b_ptr = _reduce_eval param fun_name [event] 1 group_size b_val b_ptr in
  x.outval <- [|F32 b_val|];
  x.outmem <- [|b_mem|];
  x.events <- [|event|]


(* interface of map-reduce primitives *)


let map_arr fun_name x = pack_op (Map fun_name) [|x|]


let mapn_arr fun_name x = pack_op (MapN fun_name) x


let map2_arr fun_name x y = pack_op (MapN fun_name) [|x; y|]


let map_arr_scalar fun_name x a = pack_op (MapArrScalar fun_name) [|x; a|]


let reduce fun_name x = pack_op (Reduce fun_name) [|x|]


(* recursively evaluate an expression *)
let eval ?(dev_id=0) x =
  let ctx = Owl_opencl_context.(get_opencl_ctx default) in
  let dev = Owl_opencl_context.(get_dev default dev_id) in
  let cmdq = Owl_opencl_context.(get_cmdq default dev) in
  let prog = Owl_opencl_context.(get_program default) in
  let p = (ctx, cmdq, prog) in

  let rec _eval x =
    Array.iter _eval x.input;
    if x.outmem = [||] then (
      match x.op with
      | Noop _         -> ()
      | Map s          -> map_arr_eval p s x
      | MapN s         -> mapn_arr_eval p s x
      | MapArrScalar s -> map_arr_scalar_eval p s x
      | Reduce s       -> reduce_eval p s x
    )
  in
  _eval (unpack_trace x);
  Owl_opencl_base.CommandQueue.finish cmdq;
  x


(* ends here *)
