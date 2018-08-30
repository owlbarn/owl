#!/usr/bin/env owl
(* This example demonstrates the use of OpenCL's Ndarray module *)

#require "owl-opencl"
open Owl

module M = Owl_computation_opencl_engine.Make (Dense.Ndarray.S);;


let test_01 a =
  let x = M.var_arr "x" in
  M.assign_arr x a;
  let y = M.sin x in
  M.eval_arr ~dev_id:0 [|y|];
  M.unpack_arr y


let test_02 a =
  let x = M.uniform [|100; 100|] in
  let y = M.cos x in
  M.eval_arr ~dev_id:0 [|y|];
  M.unpack_arr y


let test_05 a =
  let x = M.var_arr "x" in
  M.assign_arr x (Dense.Ndarray.S.ones [|10; 10|]);
  let y = M.cos x in
  M.eval_arr ~dev_id:0 [|y|];
  M.unpack_arr y


let test_06 a =
  let x = M.var_arr "x" in
  let y = M.var_arr "y" in
  M.assign_arr x (Dense.Ndarray.S.ones [|10; 10|]);
  M.assign_arr y (Dense.Ndarray.S.ones [|10; 10|]);
  let z = M.(add (cos x) y) in
  M.eval_arr ~dev_id:0 [|z|];
  M.unpack_arr z


let test_03 a =
  let x = M.var_arr "x" in
  let y = M.var_arr "y" in
  M.assign_arr x (Dense.Ndarray.S.ones [|100; 100|]);
  M.assign_arr y (Dense.Ndarray.S.ones [|1; 100|]);
  let z = M.add x y in
  M.eval_arr ~dev_id:0 [|z|];
  M.unpack_arr z


let get_strides_buf ctx x =
  let open Owl_opencl in
  let open Owl_opencl_utils in
  let open Owl_opencl_generated in

  let x_shp = [| Array.length x |] in
  let x = Dense.Ndarray.Generic.of_array Int32 x x_shp in
  let flags = [ cl_MEM_USE_HOST_PTR ] in
  let x_buf = Base.Buffer.create_bigarray ~flags ctx x in
  let x_gpu = Ctypes.allocate cl_mem x_buf in
  x_gpu


let test_04 a =
  let open Owl_opencl in
  let open Owl_opencl_utils in
  let open Owl_opencl_generated in

  let dev_id = 1 in
  let context = Context.default in
  let ctx = Owl_opencl_context.(get_opencl_ctx default) in
  let dev = Owl_opencl_context.(get_dev default dev_id) in
  let cmdq = Owl_opencl_context.(get_cmdq default dev) in

  let x = Dense.Ndarray.S.sequential [|10; 10|] in
  let y = Dense.Ndarray.S.ones [|1; 10|] in
  let z = Dense.Ndarray.S.zeros [|10; 10|] in


  let kernel = Context.make_kernel context "owl_opencl_float32_broadcast_sub" in
  let flags = [ cl_MEM_USE_HOST_PTR ] in
  let x_buf = Base.Buffer.create_bigarray ~flags ctx x in
  let y_buf = Base.Buffer.create_bigarray ~flags ctx y in
  let z_buf = Base.Buffer.create_bigarray ~flags ctx z in

  let x_gpu = Ctypes.allocate cl_mem x_buf in
  let y_gpu = Ctypes.allocate cl_mem y_buf in
  let z_gpu = Ctypes.allocate cl_mem z_buf in
  let z_cpu = Ctypes.(bigarray_start genarray z) in

  let dim = Int32.of_int (Dense.Ndarray.S.num_dims z) in
  let dim_ptr = Ctypes.(allocate int32_t dim) in
  let sizeof_int32 = Ctypes.(sizeof (ptr int32_t)) in

  let x_stride_gpu = get_strides_buf ctx [|10l;1l|] in
  let y_stride_gpu = get_strides_buf ctx [|0l;1l|] in
  let z_stride_gpu = get_strides_buf ctx [|10l;1l|] in

  Base.Kernel.set_arg kernel 0 sizeof_cl_mem x_gpu;
  Base.Kernel.set_arg kernel 1 sizeof_cl_mem y_gpu;
  Base.Kernel.set_arg kernel 2 sizeof_cl_mem z_gpu;
  Base.Kernel.set_arg kernel 3 sizeof_int32 dim_ptr;
  Base.Kernel.set_arg kernel 4 sizeof_int32 x_stride_gpu;
  Base.Kernel.set_arg kernel 5 sizeof_int32 y_stride_gpu;
  Base.Kernel.set_arg kernel 6 sizeof_int32 z_stride_gpu;

  let num_items = Dense.Ndarray.S.numel z in
  let event = Base.Kernel.enqueue_ndrange ~wait_for:[] cmdq kernel 1 [num_items] in
  let buf_size = Dense.Ndarray.S.size_in_bytes z in
  let _ = Base.Buffer.enqueue_read ~wait_for:[event] cmdq z_buf 0 buf_size (Ctypes.to_voidp z_cpu) in
  z


let _ =
  Owl_log.(set_level DEBUG);
  let a = Dense.Ndarray.S.ones [|2000; 2000|] in
  let b = test_06 a in
  Dense.Ndarray.Generic.pp_dsnda Format.std_formatter b
