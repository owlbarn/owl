__kernel void owl_opencl_float32_add(
  __global float *a,
  __global float *b,
  __global float *c)
{
  int gid = get_global_id(0);
  c[gid] = a[gid] + b[gid];
}


__kernel void owl_opencl_float32_sin(
  __global float *a,
  __global float *b
)
{
  int gid = get_global_id(0);
  b[gid] = sin(a[gid]);
}


__kernel void owl_opencl_float32_cos(
  __global float *a,
  __global float *b
)
{
  int gid = get_global_id(0);
  b[gid] = cos(a[gid]);
}
