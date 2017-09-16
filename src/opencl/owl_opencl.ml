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
    let err = clGetPlatformIDs uint32_0 cl_platform_id_ptr_null _n in
    Printf.printf "==> %i\n" (Int32.to_int err);
    !@_n

end
