(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_opencl_utils

open Owl_opencl_generated

open Owl_dense_ndarray_s


type t =
  | F     of float
  | Arr   of arr
  | Trace of trace
and trace = {
  mutable op     : trace_op;
  mutable input  : trace array;
  mutable outval : t array;        (* output value, not Trace *)
  mutable outmem : cl_mem array;
  mutable events : cl_event array;
  mutable refnum : int;
}
and trace_op =
  | Noop    of string
  | Map     of string
  | Reduce  of string
  | Combine of string


let pack_input = function
  | Trace x -> (
      x.refnum <- x.refnum + 1;
      x
    )
  | Arr x   -> (
      let ctx = Owl_opencl_context.(default.context) in
      let x_mem = Owl_opencl_base.Buffer.create ~flags:[Owl_opencl_generated.cl_MEM_USE_HOST_PTR] ctx x in
      {
        op      = Noop "";
        input   = [| |];
        outval  = [|Arr x|];
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


let unpack_arr = function
  | Arr x -> x
  | _     -> failwith "owl_opencl_operand:unpack_arr"


let unpack_trace = function
  | Trace x -> x
  | _       -> failwith "owl_opencl_operand:unpack_trace"


let get_input_event x =
  x.input
  |> Array.fold_left (fun a i -> Array.append a i.events) [||]
  |> Array.to_list


let get_input_kind x i =
  assert (Array.length x.input > i);
  let input_i = x.input.(i) in
  match input_i.outval.(i) with
  | Arr y -> Owl_dense_ndarray_generic.kind y
  | _     -> failwith "owl_opencl_operand:get_input_kind"


let get_val_mem_ptr x i =
  let x_val = x.outval.(0) in
  let x_mem = x.outmem.(0) in
  let x_ptr = Ctypes.allocate Owl_opencl_generated.cl_mem x_mem in
  x_val, x_mem, x_ptr


(* FIXME: scalar is not taken into account *)
let allocate ctx x =
  let src = Owl_utils.Stack.make () in
  let dst = Owl_utils.Stack.make () in
  Array.iter (fun a ->
    let a_val, a_mem, a_ptr = get_val_mem_ptr a 0 in

    let b_val, b_mem, b_ptr =
      match a.refnum = 1 with
      | true  -> a_val, a_mem, a_ptr
      | false -> (
          let b_val = empty (a_val |> unpack_arr |> shape) in
          let b_mem = Owl_opencl_base.Buffer.create ~flags:[Owl_opencl_generated.cl_MEM_USE_HOST_PTR] ctx b_val in
          let b_ptr = Ctypes.allocate Owl_opencl_generated.cl_mem b_mem in
          Arr b_val, b_mem, b_ptr
        )
    in

    Owl_utils.Stack.push src (a_val, a_mem, a_ptr);
    Owl_utils.Stack.push dst (b_val, b_mem, b_ptr);
  ) x.input;
  Owl_utils.Stack.(to_array src, to_array dst)


let map fun_name x =
  let context = Owl_opencl_context.default in
  let ctx = Owl_opencl_context.(context.context) in
  let cmdq = Owl_opencl_context.(context.command_queue) in
  let kind = get_input_kind x 0 in
  let kernel = Owl_opencl_context.(mk_kernel kind fun_name context.program) in

  let src, dst = allocate ctx x in
  let a_val, a_mem, a_ptr = src.(0) in
  let b_val, b_mem, b_ptr = dst.(0) in
  let _size = a_val |> unpack_arr |> numel in
  let wait_for = get_input_event x in

  Owl_opencl_base.Kernel.set_arg kernel 0 sizeof_cl_mem a_ptr;
  Owl_opencl_base.Kernel.set_arg kernel 1 sizeof_cl_mem b_ptr;
  let event = Owl_opencl_base.Kernel.enqueue_ndrange ~wait_for cmdq kernel 1 [_size] in
  x.outval <- [|b_val|];
  x.outmem <- [|b_mem|];
  x.events <- [|event|]


(* TODO *)
let reduce () = ()


let combine fun_name x =
  let context = Owl_opencl_context.default in
  let ctx = Owl_opencl_context.(context.context) in
  let cmdq = Owl_opencl_context.(context.command_queue) in
  let kind = get_input_kind x 0 in
  let kernel = Owl_opencl_context.(mk_kernel kind fun_name context.program) in

  let src = Array.mapi (fun i a -> get_val_mem_ptr a i) x.input in
  let tmp = Owl_utils.array_filteri_v (fun i a -> a.refnum = 1, i) x.input in
  let dst = match Array.length tmp > 0 with
    | true  -> (allocate ctx x |> snd).(tmp.(0))
    | false -> (allocate ctx x |> snd).(0)
  in

  let b_val, b_mem, _ = dst in
  let _size = b_val |> unpack_arr |> numel in
  let wait_for = Array.fold_left (fun a b -> a @ (get_input_event b)) [] x.input in

  let args = Array.append src [|dst|] in
  Array.iteri (fun i (_, _, a_ptr) -> Owl_opencl_base.Kernel.set_arg kernel i sizeof_cl_mem a_ptr) args;
  let event = Owl_opencl_base.Kernel.enqueue_ndrange ~wait_for cmdq kernel 1 [_size] in
  x.outval <- [|b_val|];
  x.outmem <- [|b_mem|];
  x.events <- [|event|]


let eval x =
  let rec _eval x =
    Array.iter _eval x.input;
    if x.outmem = [||] then (
      match x.op with
      | Noop _    -> ()
      | Map s     -> map s x
      | Reduce s  -> failwith "eval:reduce:not implemented yet"
      | Combine s -> combine s x
    )
  in
  _eval (unpack_trace x);
  let cmdq = Owl_opencl_context.(default.command_queue) in
  Owl_opencl_base.CommandQueue.finish cmdq;
  x


(* ends here *)
