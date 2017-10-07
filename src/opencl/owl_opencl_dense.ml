(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_dense_ndarray_s

open Owl_opencl_generated


type mem = {
  arr : arr;
  mem : cl_mem;
}

type t =
  | F     of float
  | Arr   of arr
  | Buf   of cl_mem
  | Trace of trace
and trace = {
  mutable op        : trace_op;
  mutable input     : t array;
  mutable output    : cl_mem array;
  mutable events    : cl_event array;
  mutable in_shape  : int array array;
  mutable out_shape : int array array;
  mutable reference : int;
}
and trace_op =
  | Noop
  | Add
  | Sub
  | Mul
  | Div
  | Sin


(* helper functions *)

let pack_input = function
  | Trace x -> (
      x.reference <- x.reference + 1;
      Trace x
    )
  | x       -> Trace {
      op        = Noop;
      input     = [|x|];
      output    = [||];
      events    = [||];
      in_shape  = [||];
      out_shape = [||];
      reference = 1;
    }


let pack_op op input output =
  let input = Array.map pack_input input in
  let events = [||] in
  Trace {
    op;
    input;
    output;
    events;
    in_shape  = [||];
    out_shape = [||];
    reference = 0;
  }


let get_trace = function
  | Trace x -> x
  | _       -> failwith "owl_opencl_dense:get_trace"


let get_input_event x =
  Array.fold_left (fun a i ->
      Array.append a (get_trace i).events
  ) [||] x.input


(* math functions *)

let add x y = pack_op Add [|x; y|] [||]


let sub x y = pack_op Sub [|x; y|] [||]


let mul x y = pack_op Mul [|x; y|] [||]


let div x y = pack_op Div [|x; y|] [||]



module Noop = struct

  let eval context x =
    print_endline "@@@"; flush_all ();
    let ctx = Owl_opencl_kernels.(context.context) in
    match x.input.(0) with
    | Arr y -> (
        let y' = Owl_opencl_base.Buffer.create ~flags:[Owl_opencl_generated.cl_MEM_USE_HOST_PTR] ctx y in
        x.output <- [|y'|]
      )
    | _ -> failwith "noop: not implemented yet"

end


module Add = struct

  let run x y = pack_op Add [|x; y|] [||]


  let eval ctx cmdq kernel x =
    let z = zeros x.out_shape.(0) in
    let z' = Owl_opencl_base.Buffer.create ~flags:[Owl_opencl_generated.cl_MEM_USE_HOST_PTR] ctx z in
    let _x = Ctypes.allocate Owl_opencl_generated.cl_mem x.output.(0) in
    let _y = Ctypes.allocate Owl_opencl_generated.cl_mem x.output.(1) in
    let _z = Ctypes.allocate Owl_opencl_generated.cl_mem z' in
    let len = Ctypes.sizeof Owl_opencl_generated.cl_mem in
    Owl_opencl_base.Kernel.set_arg kernel 0 len _x;
    Owl_opencl_base.Kernel.set_arg kernel 1 len _y;
    Owl_opencl_base.Kernel.set_arg kernel 2 len _z;

    let _size = numel z in
    let event = Owl_opencl_base.Kernel.enqueue_ndrange cmdq kernel 1 [_size] in
    x.output <- [|z'|];
    x.events <- [|event|]


end


module Sin = struct

  let run x = pack_op Sin [|x|] [||]

  let mk_kernel program = Owl_opencl_base.Kernel.create program "owl_opencl_sin"

  let eval context x =
    print_endline "==="; flush_all ();
    let ctx = Owl_opencl_kernels.(context.context) in
    let cmdq = Owl_opencl_kernels.(context.command_queue) in
    let kernel = mk_kernel Owl_opencl_kernels.(context.program) in

    let input = x.input.(0) |> get_trace in
    if input.reference = 1 then (
      let a = input.output.(0) in
      let _a = Ctypes.allocate Owl_opencl_generated.cl_mem a in
      let l = Ctypes.sizeof Owl_opencl_generated.cl_mem in
      Owl_opencl_base.Kernel.set_arg kernel 0 l _a;
      Owl_opencl_base.Kernel.set_arg kernel 1 l _a;

      (* FIXME: let _size = Array.fold_left ( * ) 1 x.out_shape.(0) in *)
      let _size = 10 in
      let wait_for = get_input_event x |> Array.to_list in
      let event = Owl_opencl_base.Kernel.enqueue_ndrange ~wait_for cmdq kernel 1 [_size] in
      x.output <- [|a|];
      x.events <- [|event|]
    )
    else (
      let a = input.output.(0) in
      let b = zeros x.out_shape.(0) in
      let b_buf = Owl_opencl_base.Buffer.create ~flags:[Owl_opencl_generated.cl_MEM_USE_HOST_PTR] ctx b in
      let _b = Ctypes.allocate Owl_opencl_generated.cl_mem b_buf in
      let l = Ctypes.sizeof Owl_opencl_generated.cl_mem in

      let wait_for = get_input_event x |> Array.to_list in
      let event0 = Owl_opencl_base.Buffer.enqueue_read ~blocking:false ~wait_for cmdq a 0 l (Ctypes.to_voidp _b) in
      Owl_opencl_base.Kernel.set_arg kernel 0 l _b;
      Owl_opencl_base.Kernel.set_arg kernel 1 l _b;

      (* FIXME: let _size = Array.fold_left ( * ) 1 x.out_shape.(0) in *)
      let _size = 10 in
      let wait_for = [|event0|] |> Array.to_list in
      let event1 = Owl_opencl_base.Kernel.enqueue_ndrange ~wait_for cmdq kernel 1 [_size] in
      x.output <- [|b_buf|];
      x.events <- [|event1|]
    )


end


(* graph related function *)


let op_to_kernel x =
  match x.op with
  | Noop -> ()
  | Add -> ()
  | _ -> failwith "op_to_kernel"


let eval x =
  let rec _eval x =
    match x with
    | F x     -> print_endline "float"
    | Arr x   -> print_endline "arr"
    | Buf x   -> print_endline "buf"
    | Trace x -> (
        Array.iter _eval x.input;
        if x.output = [||] then (
          match x.op with
          | Noop -> Noop.eval Owl_opencl_kernels.default x
          | Sin  -> Sin.eval Owl_opencl_kernels.default x
          | _    -> failwith "not implemented yet"
        )
        else (
          print_endline "stop"
        )
      )
  in
  _eval x;
  let cmdq = Owl_opencl_kernels.(default.command_queue) in
  Owl_opencl_base.CommandQueue.finish cmdq;
  x



(* ends here *)
