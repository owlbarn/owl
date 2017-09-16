(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Ctypes

open Owl_opencl_generated


module Platform = struct

  let uint32_0 = Unsigned.UInt32.of_int 0

  let get_platform_ids () =
    let _n = allocate uint32_t uint32_0 in
    clGetPlatformIDs uint32_0 cl_platform_id_ptr_null _n |> cl_check_err;
    let n = Unsigned.UInt32.to_int !@_n in
    let _platforms = allocate_n cl_platform_id n in
    clGetPlatformIDs !@_n _platforms (Obj.magic null) |> cl_check_err;
    Array.init n (fun i -> !@(_platforms +@ i))

  let get_platform_info id =
    let _buf = allocate_n char ~count:1024 in
    clGetPlatformInfo id (Unsigned.UInt32.of_int 0x0902) (Unsigned.Size_t.of_int 1024) (coerce (ptr char) (ptr void) _buf) (Obj.magic null) |> cl_check_err;
    Array.init 1024 (fun i -> !@(_buf +@ i))

end
