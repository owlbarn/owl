(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let rvs_code () = "
__kernel void owl_opencl_float32_std_uniform (__global float* out, __global clrngPhilox432HostStream* streams) {
  int gid = get_global_id(0);
  clrngPhilox432Stream private_stream;
  clrngPhilox432CopyOverStreamsFromGlobal(1, &private_stream, &streams[gid]);
  out[gid] = clrngPhilox432RandomU01_cl_float(&private_stream);
}

__kernel void owl_opencl_float32_uniform (float a, float b, __global float* out, __global clrngPhilox432HostStream* streams) {
  int gid = get_global_id(0);
  clrngPhilox432Stream private_stream;
  clrngPhilox432CopyOverStreamsFromGlobal(1, &private_stream, &streams[gid]);
  float scale = clrngPhilox432RandomU01_cl_float(&private_stream);
  out[gid] = a + (b - a) * scale;
}
"


let code () =
  let code_0 = Owl_opencl_prng_philox_code.code () in
  let code_1 = rvs_code () in
  Printf.sprintf "%s\n%s" code_0 code_1
