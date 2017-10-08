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
  | Noop   of string
  | Map    of string
  | Reduce of string


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
  Array.fold_left (fun a i ->
      Array.append a i.events
  ) [||] x.input
  |> Array.to_list


(* FIXME: scalar is not taken into account *)
let allocate ctx x =
  let src = Owl_utils.Stack.make () in
  let dst = Owl_utils.Stack.make () in
  Array.iter (fun a ->
    let a_val = a.outval.(0) in
    let a_mem = a.outmem.(0) in
    let a_ptr = Ctypes.allocate Owl_opencl_generated.cl_mem a_mem in

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
  (* FIXME *)
  let kernel = Owl_opencl_context.(mk_kernel Float32 fun_name context.program) in

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


let eval x =
  let rec _eval x =
    Array.iter _eval x.input;
    if x.outmem = [||] then (
      match x.op with
      | Noop _   -> ()
      | Map  s   -> map s x
      | Reduce s -> failwith "eval:reduce:not implemented yet"
    )
  in
  _eval (unpack_trace x);
  let cmdq = Owl_opencl_context.(default.command_queue) in
  Owl_opencl_base.CommandQueue.finish cmdq;
  x


(* ends here *)
