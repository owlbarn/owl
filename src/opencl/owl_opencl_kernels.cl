__kernel void owl_opencl_float32_add(__global const float *a,
                  __global const float *b,
                  __global float *result)
{
  int gid = get_global_id(0);
  result[gid] = a[gid] + b[gid];
}


__kernel void owl_opencl_float32_sub(__global const float *a,
                  __global const float *b,
                  __global float *result)
{
  int gid = get_global_id(0);
  result[gid] = a[gid] - b[gid];
}


__kernel void owl_opencl_float32_mul(__global const float *a,
                  __global const float *b,
                  __global float *result)
{
  int gid = get_global_id(0);
  result[gid] = a[gid] * b[gid];
}


__kernel void owl_opencl_float32_div(__global const float *a,
                  __global const float *b,
                  __global float *result)
{
  int gid = get_global_id(0);
  result[gid] = a[gid] / b[gid];
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
