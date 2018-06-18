(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let code () = [|
    (* Add new kernels in the list *)
    Owl_opencl_kernel_head.code ();
    Owl_opencl_kernel_maths.code ();
    Owl_opencl_kernel_stats.code ();
  |]
  |>
  Array.fold_left ( ^ ) ""
