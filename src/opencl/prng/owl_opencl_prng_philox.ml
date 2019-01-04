(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Ctypes

open Owl_opencl_base

open Owl_opencl_utils

open Owl_opencl_generated

module CI = Cstubs_internals


(* type definitions *)

type creator = unit ptr
let creator : creator typ = ptr void
let creator_null : creator = Ctypes.null

type streams = unit ptr
let streams : streams typ = ptr void
let streams_null : streams = Ctypes.null

type status = unit ptr
let status : status typ = ptr void
let status_null : status = Ctypes.null

type t = {
  mutable streams  : streams ptr;
  mutable length   : int;
  mutable bufsize  : int;
}


(* raw interface to C functions *)

external _create_streams : int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> CI.voidp = "owl_clrng_philox_create_streams_stub"

external _destroy_streams : _ CI.fatptr -> unit = "owl_clrng_philox_destroy_streams_stub"

external _create_over_streams : int -> _ CI.fatptr -> _ CI.fatptr -> unit = "owl_clrng_philox_create_over_streams_stub"

external _rewind_streams : Unsigned.size_t -> _ CI.fatptr -> unit = "owl_clrng_philox_rewind_streams_stub"

external _uniform_float : _ CI.fatptr -> float = "owl_clrng_philox_uniform_float_stub"

external _uniform_double : _ CI.fatptr -> float = "owl_clrng_philox_uniform_double_stub"


(* middle-level interfaces on stream pointer *)

let destroy_streams stream =
  Owl_log.debug "destroy stream ...";
  _destroy_streams (CI.cptr stream)


let create_streams n =
  let bufsz_p = allocate size_t size_0 in
  let status_p = allocate status status_null in
  let creator_p = creator_null in

  let bufsz_c = CI.cptr bufsz_p in
  let status_c = CI.cptr status_p in
  let creator_c = CI.cptr creator_p in

  let streams_c = _create_streams n creator_c bufsz_c status_c in
  let streams_p = CI.make_ptr streams streams_c in
  Gc.finalise destroy_streams streams_p;
  streams_p, bufsz_p


let create_over_streams n streams =
  let creator_p = creator_null in
  let creator_c = CI.cptr creator_p in
  let streams_c = CI.cptr streams in
  _create_over_streams n creator_c streams_c


let rewind_streams n streams =
  let n_t = Unsigned.Size_t.of_int n in
  let streams_p = CI.cptr streams in
  _rewind_streams n_t streams_p


let uniform stream =
  let stream_c = CI.cptr stream in
  _uniform_double stream_c


(* high-level interfaces on stream record type *)

let make length =
  let streams, buf_size_p = create_streams length in
  let bufsize = Unsigned.Size_t.to_int !@buf_size_p in
  { streams; length; bufsize }


let rewind streams_t =
  let n = streams_t.length in
  let streams = streams_t.streams in
  rewind_streams n streams


let get_nth_stream streams_t n =
  let streams_p = streams_t.streams in
  let nth_stream_p = streams_p +@ n in
  nth_stream_p


let make_stream_buffer ctx streams_t =
  let streams = streams_t.streams in
  let bufsize = streams_t.bufsize in
  let flags = [ cl_MEM_USE_HOST_PTR ] in
  Owl_log.info "stream bufsize = %i" bufsize;
  Buffer.create ~flags ctx bufsize (Obj.magic streams)



(* ends here *)
