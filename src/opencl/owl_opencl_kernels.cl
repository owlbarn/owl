__kernel void add(__global const float *a,
                  __global const float *b,
                  __global float *result)
{
  int gid = get_global_id(0);
  result[gid] = a[gid] + b[gid];
}


__kernel void sub(__global const float *a,
                  __global const float *b,
                  __global float *result)
{
  int gid = get_global_id(0);
  result[gid] = a[gid] - b[gid];
}


__kernel void mul(__global const float *a,
                  __global const float *b,
                  __global float *result)
{
  int gid = get_global_id(0);
  result[gid] = a[gid] * b[gid];
}


__kernel void div(__global const float *a,
                  __global const float *b,
                  __global float *result)
{
  int gid = get_global_id(0);
  result[gid] = a[gid] / b[gid];
}
