(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let philox_code = "
#pragma OPENCL EXTENSION cl_amd_fp64 : enable

typedef double cl_double;
typedef float cl_float;
typedef int cl_int;
typedef uint cl_uint;
typedef long cl_long;
typedef ulong cl_ulong;
typedef enum clrngStatus_ {
  CLRNG_SUCCESS = 0,
  CLRNG_INVALID_VALUE = -1
} clrngStatus;


typedef struct clrngPhilox432SB_ {
  cl_uint msb, lsb;
} clrngPhilox432SB;

typedef struct clrngPhilox432Counter_ {
  clrngPhilox432SB H, L;
} clrngPhilox432Counter;

typedef struct {
  clrngPhilox432Counter ctr;
  cl_uint deck[4];
  cl_uint deckIndex;
} clrngPhilox432StreamState;

struct clrngPhilox432Stream_ {
  clrngPhilox432StreamState current;
  __global const clrngPhilox432StreamState* initial;
};
typedef struct clrngPhilox432Stream_ clrngPhilox432Stream;

struct clrngPhilox432HostStream_ {
  clrngPhilox432StreamState current;
  clrngPhilox432StreamState initial;
  clrngPhilox432StreamState substream;
};
typedef struct clrngPhilox432HostStream_ clrngPhilox432HostStream;

clrngStatus clrngPhilox432CopyOverStreamsFromGlobal(size_t count, clrngPhilox432Stream* destStreams, __global const clrngPhilox432HostStream* srcStreams);
clrngStatus clrngPhilox432CopyOverStreamsToGlobal(size_t count, __global clrngPhilox432HostStream* destStreams, const clrngPhilox432Stream* srcStreams);
clrngStatus clrngPhilox432CopyOverStreams(size_t count, clrngPhilox432Stream* destStreams, const clrngPhilox432Stream* srcStreams);

clrngStatus clrngPhilox432RewindStreams(size_t count, clrngPhilox432Stream* streams);
clrngStatus clrngPhilox432CopyOverStreamsFromGlobal(size_t count, clrngPhilox432Stream* destStreams, __global const clrngPhilox432HostStream* srcStreams)
{
  if (!destStreams)
    return (CLRNG_INVALID_VALUE);
  if (!srcStreams)
    return (CLRNG_INVALID_VALUE);

  for (size_t i = 0; i < count; i++) {
    destStreams[i].current = srcStreams[i].current;
    destStreams[i].initial = &srcStreams[i].initial;
  }

  return CLRNG_SUCCESS;
}

clrngStatus clrngPhilox432CopyOverStreamsToGlobal(size_t count, __global clrngPhilox432HostStream* destStreams, const clrngPhilox432Stream* srcStreams)
{
  if (!destStreams)
    return (CLRNG_INVALID_VALUE);
  if (!srcStreams)
    return (CLRNG_INVALID_VALUE);

  for (size_t i = 0; i < count; i++) {
    destStreams[i].current = srcStreams[i].current;
    destStreams[i].initial = *srcStreams[i].initial;
  }

  return CLRNG_SUCCESS;
}


typedef ulong uint64_t;
typedef uint uint32_t;
typedef uchar uint8_t;

struct r123array1x32{ uint32_t v[1]; };
struct r123array2x32{ uint32_t v[2]; };
struct r123array4x32{ uint32_t v[4]; };
struct r123array8x32{ uint32_t v[8]; };

struct r123array1x64{ uint64_t v[1]; };
struct r123array2x64{ uint64_t v[2]; };
struct r123array4x64{ uint64_t v[4]; };

struct r123array16x8{ uint8_t v[16]; };
inline uint32_t mulhilo32(uint32_t a, uint32_t b, uint32_t* hip){ uint64_t product = ((uint64_t)a)*((uint64_t)b); *hip = product>>32; return (uint32_t)product; }
inline uint64_t mulhilo64(uint64_t a, uint64_t b, uint64_t* hip){ *hip = mul_hi(a, b); return a*b; }
inline struct r123array1x32 _philox2x32bumpkey( struct r123array1x32 key) { key.v[0] += ((uint32_t)0x9E3779B9); return key; }
inline struct r123array2x32 _philox4x32bumpkey( struct r123array2x32 key) { key.v[0] += ((uint32_t)0x9E3779B9); key.v[1] += ((uint32_t)0xBB67AE85); return key; }
inline struct r123array2x32 _philox2x32round(struct r123array2x32 ctr, struct r123array1x32 key) __attribute__((always_inline)); inline struct r123array2x32 _philox2x32round(struct r123array2x32 ctr, struct r123array1x32 key){ uint32_t hi; uint32_t lo = mulhilo32(((uint32_t)0xd256d193), ctr.v[0], &hi); struct r123array2x32 out = {{hi^key.v[0]^ctr.v[1], lo}}; return out; }
inline struct r123array4x32 _philox4x32round(struct r123array4x32 ctr, struct r123array2x32 key) __attribute__((always_inline)); inline struct r123array4x32 _philox4x32round(struct r123array4x32 ctr, struct r123array2x32 key){ uint32_t hi0; uint32_t hi1; uint32_t lo0 = mulhilo32(((uint32_t)0xD2511F53), ctr.v[0], &hi0); uint32_t lo1 = mulhilo32(((uint32_t)0xCD9E8D57), ctr.v[2], &hi1); struct r123array4x32 out = {{hi1^ctr.v[1]^key.v[0], lo1, hi0^ctr.v[3]^key.v[1], lo0}}; return out; }

enum r123_enum_philox2x32 { philox2x32_rounds = 10 }; typedef struct r123array2x32 philox2x32_ctr_t; typedef struct r123array1x32 philox2x32_key_t; typedef struct r123array1x32 philox2x32_ukey_t; inline philox2x32_key_t philox2x32keyinit(philox2x32_ukey_t uk) { return uk; } inline philox2x32_ctr_t philox2x32_R(unsigned int R, philox2x32_ctr_t ctr, philox2x32_key_t key) __attribute__((always_inline)); inline philox2x32_ctr_t philox2x32_R(unsigned int R, philox2x32_ctr_t ctr, philox2x32_key_t key) { ; if(R>0){ ctr = _philox2x32round(ctr, key); } if(R>1){ key = _philox2x32bumpkey(key); ctr = _philox2x32round(ctr, key); } if(R>2){ key = _philox2x32bumpkey(key); ctr = _philox2x32round(ctr, key); } if(R>3){ key = _philox2x32bumpkey(key); ctr = _philox2x32round(ctr, key); } if(R>4){ key = _philox2x32bumpkey(key); ctr = _philox2x32round(ctr, key); } if(R>5){ key = _philox2x32bumpkey(key); ctr = _philox2x32round(ctr, key); } if(R>6){ key = _philox2x32bumpkey(key); ctr = _philox2x32round(ctr, key); } if(R>7){ key = _philox2x32bumpkey(key); ctr = _philox2x32round(ctr, key); } if(R>8){ key = _philox2x32bumpkey(key); ctr = _philox2x32round(ctr, key); } if(R>9){ key = _philox2x32bumpkey(key); ctr = _philox2x32round(ctr, key); } if(R>10){ key = _philox2x32bumpkey(key); ctr = _philox2x32round(ctr, key); } if(R>11){ key = _philox2x32bumpkey(key); ctr = _philox2x32round(ctr, key); } if(R>12){ key = _philox2x32bumpkey(key); ctr = _philox2x32round(ctr, key); } if(R>13){ key = _philox2x32bumpkey(key); ctr = _philox2x32round(ctr, key); } if(R>14){ key = _philox2x32bumpkey(key); ctr = _philox2x32round(ctr, key); } if(R>15){ key = _philox2x32bumpkey(key); ctr = _philox2x32round(ctr, key); } return ctr; }
enum r123_enum_philox4x32 { philox4x32_rounds = 10 }; typedef struct r123array4x32 philox4x32_ctr_t; typedef struct r123array2x32 philox4x32_key_t; typedef struct r123array2x32 philox4x32_ukey_t; inline philox4x32_key_t philox4x32keyinit(philox4x32_ukey_t uk) { return uk; } inline philox4x32_ctr_t philox4x32_R(unsigned int R, philox4x32_ctr_t ctr, philox4x32_key_t key) __attribute__((always_inline)); inline philox4x32_ctr_t philox4x32_R(unsigned int R, philox4x32_ctr_t ctr, philox4x32_key_t key) { ; if(R>0){ ctr = _philox4x32round(ctr, key); } if(R>1){ key = _philox4x32bumpkey(key); ctr = _philox4x32round(ctr, key); } if(R>2){ key = _philox4x32bumpkey(key); ctr = _philox4x32round(ctr, key); } if(R>3){ key = _philox4x32bumpkey(key); ctr = _philox4x32round(ctr, key); } if(R>4){ key = _philox4x32bumpkey(key); ctr = _philox4x32round(ctr, key); } if(R>5){ key = _philox4x32bumpkey(key); ctr = _philox4x32round(ctr, key); } if(R>6){ key = _philox4x32bumpkey(key); ctr = _philox4x32round(ctr, key); } if(R>7){ key = _philox4x32bumpkey(key); ctr = _philox4x32round(ctr, key); } if(R>8){ key = _philox4x32bumpkey(key); ctr = _philox4x32round(ctr, key); } if(R>9){ key = _philox4x32bumpkey(key); ctr = _philox4x32round(ctr, key); } if(R>10){ key = _philox4x32bumpkey(key); ctr = _philox4x32round(ctr, key); } if(R>11){ key = _philox4x32bumpkey(key); ctr = _philox4x32round(ctr, key); } if(R>12){ key = _philox4x32bumpkey(key); ctr = _philox4x32round(ctr, key); } if(R>13){ key = _philox4x32bumpkey(key); ctr = _philox4x32round(ctr, key); } if(R>14){ key = _philox4x32bumpkey(key); ctr = _philox4x32round(ctr, key); } if(R>15){ key = _philox4x32bumpkey(key); ctr = _philox4x32round(ctr, key); } return ctr; }


inline struct r123array1x64 _philox2x64bumpkey( struct r123array1x64 key) { key.v[0] += ((ulong)(0x9E3779B97F4A7C15UL)); return key; }
inline struct r123array2x64 _philox4x64bumpkey( struct r123array2x64 key) { key.v[0] += ((ulong)(0x9E3779B97F4A7C15UL)); key.v[1] += ((ulong)(0xBB67AE8584CAA73BUL)); return key; }
inline struct r123array2x64 _philox2x64round(struct r123array2x64 ctr, struct r123array1x64 key) __attribute__((always_inline)); inline struct r123array2x64 _philox2x64round(struct r123array2x64 ctr, struct r123array1x64 key){ uint64_t hi; uint64_t lo = mulhilo64(((ulong)(0xD2B74407B1CE6E93UL)), ctr.v[0], &hi); struct r123array2x64 out = {{hi^key.v[0]^ctr.v[1], lo}}; return out; }
inline struct r123array4x64 _philox4x64round(struct r123array4x64 ctr, struct r123array2x64 key) __attribute__((always_inline)); inline struct r123array4x64 _philox4x64round(struct r123array4x64 ctr, struct r123array2x64 key){ uint64_t hi0; uint64_t hi1; uint64_t lo0 = mulhilo64(((ulong)(0xD2E7470EE14C6C93UL)), ctr.v[0], &hi0); uint64_t lo1 = mulhilo64(((ulong)(0xCA5A826395121157UL)), ctr.v[2], &hi1); struct r123array4x64 out = {{hi1^ctr.v[1]^key.v[0], lo1, hi0^ctr.v[3]^key.v[1], lo0}}; return out; }

enum r123_enum_philox2x64 { philox2x64_rounds = 10 }; typedef struct r123array2x64 philox2x64_ctr_t; typedef struct r123array1x64 philox2x64_key_t; typedef struct r123array1x64 philox2x64_ukey_t; inline philox2x64_key_t philox2x64keyinit(philox2x64_ukey_t uk) { return uk; } inline philox2x64_ctr_t philox2x64_R(unsigned int R, philox2x64_ctr_t ctr, philox2x64_key_t key) __attribute__((always_inline)); inline philox2x64_ctr_t philox2x64_R(unsigned int R, philox2x64_ctr_t ctr, philox2x64_key_t key) { ; if(R>0){ ctr = _philox2x64round(ctr, key); } if(R>1){ key = _philox2x64bumpkey(key); ctr = _philox2x64round(ctr, key); } if(R>2){ key = _philox2x64bumpkey(key); ctr = _philox2x64round(ctr, key); } if(R>3){ key = _philox2x64bumpkey(key); ctr = _philox2x64round(ctr, key); } if(R>4){ key = _philox2x64bumpkey(key); ctr = _philox2x64round(ctr, key); } if(R>5){ key = _philox2x64bumpkey(key); ctr = _philox2x64round(ctr, key); } if(R>6){ key = _philox2x64bumpkey(key); ctr = _philox2x64round(ctr, key); } if(R>7){ key = _philox2x64bumpkey(key); ctr = _philox2x64round(ctr, key); } if(R>8){ key = _philox2x64bumpkey(key); ctr = _philox2x64round(ctr, key); } if(R>9){ key = _philox2x64bumpkey(key); ctr = _philox2x64round(ctr, key); } if(R>10){ key = _philox2x64bumpkey(key); ctr = _philox2x64round(ctr, key); } if(R>11){ key = _philox2x64bumpkey(key); ctr = _philox2x64round(ctr, key); } if(R>12){ key = _philox2x64bumpkey(key); ctr = _philox2x64round(ctr, key); } if(R>13){ key = _philox2x64bumpkey(key); ctr = _philox2x64round(ctr, key); } if(R>14){ key = _philox2x64bumpkey(key); ctr = _philox2x64round(ctr, key); } if(R>15){ key = _philox2x64bumpkey(key); ctr = _philox2x64round(ctr, key); } return ctr; }
enum r123_enum_philox4x64 { philox4x64_rounds = 10 }; typedef struct r123array4x64 philox4x64_ctr_t; typedef struct r123array2x64 philox4x64_key_t; typedef struct r123array2x64 philox4x64_ukey_t; inline philox4x64_key_t philox4x64keyinit(philox4x64_ukey_t uk) { return uk; } inline philox4x64_ctr_t philox4x64_R(unsigned int R, philox4x64_ctr_t ctr, philox4x64_key_t key) __attribute__((always_inline)); inline philox4x64_ctr_t philox4x64_R(unsigned int R, philox4x64_ctr_t ctr, philox4x64_key_t key) { ; if(R>0){ ctr = _philox4x64round(ctr, key); } if(R>1){ key = _philox4x64bumpkey(key); ctr = _philox4x64round(ctr, key); } if(R>2){ key = _philox4x64bumpkey(key); ctr = _philox4x64round(ctr, key); } if(R>3){ key = _philox4x64bumpkey(key); ctr = _philox4x64round(ctr, key); } if(R>4){ key = _philox4x64bumpkey(key); ctr = _philox4x64round(ctr, key); } if(R>5){ key = _philox4x64bumpkey(key); ctr = _philox4x64round(ctr, key); } if(R>6){ key = _philox4x64bumpkey(key); ctr = _philox4x64round(ctr, key); } if(R>7){ key = _philox4x64bumpkey(key); ctr = _philox4x64round(ctr, key); } if(R>8){ key = _philox4x64bumpkey(key); ctr = _philox4x64round(ctr, key); } if(R>9){ key = _philox4x64bumpkey(key); ctr = _philox4x64round(ctr, key); } if(R>10){ key = _philox4x64bumpkey(key); ctr = _philox4x64round(ctr, key); } if(R>11){ key = _philox4x64bumpkey(key); ctr = _philox4x64round(ctr, key); } if(R>12){ key = _philox4x64bumpkey(key); ctr = _philox4x64round(ctr, key); } if(R>13){ key = _philox4x64bumpkey(key); ctr = _philox4x64round(ctr, key); } if(R>14){ key = _philox4x64bumpkey(key); ctr = _philox4x64round(ctr, key); } if(R>15){ key = _philox4x64bumpkey(key); ctr = _philox4x64round(ctr, key); } return ctr; }


clrngPhilox432Counter clrngPhilox432Add(clrngPhilox432Counter a, clrngPhilox432Counter b)
{
  clrngPhilox432Counter c;

  c.L.lsb = a.L.lsb + b.L.lsb;
  c.L.msb = a.L.msb + b.L.msb + (c.L.lsb < a.L.lsb);

  c.H.lsb = a.H.lsb + b.H.lsb + (c.L.msb < a.L.msb);
  c.H.msb = a.H.msb + b.H.msb + (c.H.lsb < a.H.lsb);

  return c;
}

clrngPhilox432Counter clrngPhilox432Substract(clrngPhilox432Counter a, clrngPhilox432Counter b)
{
  clrngPhilox432Counter c;

  c.L.lsb = a.L.lsb - b.L.lsb;
  c.L.msb = a.L.msb - b.L.msb - (c.L.lsb > a.L.lsb);

  c.H.lsb = a.H.lsb - b.H.lsb - (c.L.msb > a.L.msb);
  c.H.msb = a.H.msb - b.H.msb - (c.H.lsb > a.H.lsb);

  return c;
}

clrngStatus clrngPhilox432CopyOverStreams(size_t count, clrngPhilox432Stream* destStreams, const clrngPhilox432Stream* srcStreams)
{

  if (!destStreams)
    return (CLRNG_INVALID_VALUE);
  if (!srcStreams)
    return (CLRNG_INVALID_VALUE);

  for (size_t i = 0; i < count; i++)
    destStreams[i] = srcStreams[i];

  return CLRNG_SUCCESS;
}

void clrngPhilox432GenerateDeck(clrngPhilox432StreamState *currentState)
{
  philox4x32_key_t k = { { 0, 0 } };
  philox4x32_ctr_t c = { { 0 } };
  c.v[0] = currentState->ctr.L.lsb;
  c.v[1] = currentState->ctr.L.msb;
  c.v[2] = currentState->ctr.H.lsb;
  c.v[3] = currentState->ctr.H.msb;

  philox4x32_ctr_t r = philox4x32_R(philox4x32_rounds, c, k);
  currentState->deck[3] = r.v[0];
  currentState->deck[2] = r.v[1];
  currentState->deck[1] = r.v[2];
  currentState->deck[0] = r.v[3];
}

static cl_uint clrngPhilox432NextState(clrngPhilox432StreamState *currentState) {
  if ((currentState->deckIndex == 0))
  {
    clrngPhilox432GenerateDeck(currentState);
  }

  cl_uint result = currentState->deck[currentState->deckIndex];

  currentState->deckIndex++;

  if (currentState->deckIndex == 4) {
    clrngPhilox432Counter incBy1 = { { 0, 0 }, { 0, 1 } };
    currentState->ctr = clrngPhilox432Add(currentState->ctr, incBy1);

    currentState->deckIndex = 0;
    clrngPhilox432GenerateDeck(currentState);
  }

  return result;
}
cl_float clrngPhilox432RandomU01_cl_float(clrngPhilox432Stream* stream) { return (clrngPhilox432NextState(&stream->current) + 0.5) * 1.0 / 0x100000000L; }
cl_int clrngPhilox432RandomInteger_cl_float(clrngPhilox432Stream* stream, cl_int i, cl_int j) { return i + (cl_int)((j - i + 1) * clrngPhilox432RandomU01_cl_float(stream)); }
clrngStatus clrngPhilox432RandomU01Array_cl_float(clrngPhilox432Stream* stream, size_t count, cl_float* buffer) { if (!stream) return (CLRNG_INVALID_VALUE); if (!buffer) return (CLRNG_INVALID_VALUE); for (size_t i = 0; i < count; i++) buffer[i] = clrngPhilox432RandomU01_cl_float(stream); return CLRNG_SUCCESS; }
clrngStatus clrngPhilox432RandomIntegerArray_cl_float(clrngPhilox432Stream* stream, cl_int i, cl_int j, size_t count, cl_int* buffer) { if (!stream) return (CLRNG_INVALID_VALUE); if (!buffer) return (CLRNG_INVALID_VALUE); for (size_t k = 0; k < count; k++) buffer[k] = clrngPhilox432RandomInteger_cl_float(stream, i, j); return CLRNG_SUCCESS; }


clrngStatus clrngPhilox432RewindStreams(size_t count, clrngPhilox432Stream* streams)
{
  if (!streams)
    return (CLRNG_INVALID_VALUE);

  for (size_t j = 0; j < count; j++) {
    streams[j].current = *streams[j].initial;
  }

  return CLRNG_SUCCESS;
}
"
;;


let uniform_code = "
__kernel void owl_opencl_float32_rand_std_uniform (__global float* out, __global clrngPhilox432HostStream* streams) {
  int gid = get_global_id(0);
  clrngPhilox432Stream private_stream;
  clrngPhilox432CopyOverStreamsFromGlobal(1, &private_stream, &streams[gid]);
  out[gid] = clrngPhilox432RandomU01_cl_float(&private_stream);
}

__kernel void owl_opencl_float32_rand_uniform (float a, float b, __global float* out, __global clrngPhilox432HostStream* streams) {
  int gid = get_global_id(0);
  clrngPhilox432Stream private_stream;
  clrngPhilox432CopyOverStreamsFromGlobal(1, &private_stream, &streams[gid]);
  float scale = clrngPhilox432RandomU01_cl_float(&private_stream);
  out[gid] = a + (b - a) * scale;
}

"
;;


let _ =
  Owl_log.info "OpenCL: compile philox432 kernels ...";
  let code = Printf.sprintf "%s\n%s\n" philox_code uniform_code in
  Owl_opencl.Context.(add_kernels default [| code |]);
  Owl_log.info "OpenCL: add philox432 kernels ..."
