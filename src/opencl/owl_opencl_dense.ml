(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_dense_ndarray_s

open Owl_opencl_generated


type t =
  | F     of float
  | Arr   of arr
  | Buf   of cl_mem
  | Trace of trace
and trace = {
  mutable op     : trace_op;
  mutable input  : t array;
  mutable output : t array option;
  mutable events : cl_event array;
  mutable in_shape : int array array;
  mutable out_shape : int array array;
}
and trace_op =
  | Noop
  | Add
  | Sub
  | Mul
  | Div


let pack_input = function
  | Trace x -> Trace x
  | x       -> Trace {
      op     = Noop;
      input  = [|x|];
      output = None;
      events = [||];
      in_shape = [||];
      out_shape = [||];
    }


let pack_op op input output =
  let input = Array.map pack_input input in
  let events = [||] in
  Trace {
    op;
    input;
    output;
    events;
    in_shape = [||];
    out_shape = [||];
  }


let add x y = pack_op Add [|x; y|] None


let sub x y = pack_op Sub [|x; y|] None


let mul x y = pack_op Mul [|x; y|] None


let div x y = pack_op Div [|x; y|] None


module Add = struct

  let run x y = pack_op Add [|x; y|] None


  let eval ctx cmdq kernel x =
    let z = empty x.out_shape.(0) in
    let z' = Owl_opencl_base.Buffer.create ~flags:[Owl_opencl_generated.cl_MEM_USE_HOST_PTR] ctx z in
    let _x = Ctypes.allocate Owl_opencl_generated.cl_mem z' in
    let _y = Ctypes.allocate Owl_opencl_generated.cl_mem z' in
    let _z = Ctypes.allocate Owl_opencl_generated.cl_mem z' in
    let len = Ctypes.sizeof Owl_opencl_generated.cl_mem in
    Owl_opencl_base.Kernel.set_arg kernel 0 len _x;
    Owl_opencl_base.Kernel.set_arg kernel 1 len _y;
    Owl_opencl_base.Kernel.set_arg kernel 2 len _z;

    let _size = numel z in
    let event = Owl_opencl_base.Kernel.enqueue_ndrange cmdq kernel 1 [_size] in
    x.events <- [|event|]


end


(* graph related function *)


let op_to_kernel x =
  match x.op with
  | Noop -> ()
  | Add -> ()
  | _ -> failwith "op_to_kernel"


let rec eval x =
  match x with
  | F x     -> print_endline "float"
  | Arr x   -> print_endline "arr"
  | Buf x   -> print_endline "buf"
  | Trace x -> (
      match x.output with
      | Some o -> print_endline "stop"
      | None   -> (
          let _ =
            match x.op with
            | Noop -> print_endline "Noop"
            | Add  -> print_endline "Add"
            | Sub  -> print_endline "Sub"
            | Mul  -> print_endline "Mul"
            | Div  -> print_endline "Div"
          in
          Array.iter eval x.input
        )
    )


(* ends here *)
