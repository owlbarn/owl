(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Ctypes

open Owl_opencl_utils

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
  mutable streams  : streams;
  mutable count    : int;
  mutable buf_size : int;
}


(* raw interface to C functions *)

external _create_streams : int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> CI.voidp = "owl_clrng_philox_create_streams_stub"

external _destroy_streams : _ CI.fatptr -> unit = "owl_clrng_philox_destroy_streams_stub"

external _create_over_streams : int -> _ CI.fatptr -> _ CI.fatptr -> unit = "owl_clrng_philox_create_over_streams_stub"


(* high-level interfaces *)

let destroy_streams stream =
  Owl_log.debug "destroy stream ...";
  _destroy_streams (CI.cptr stream)


let create_streams n =
  let bufsz_p = allocate size_t size_0 in
  let status_p = allocate status status_null in
  let creator_p = allocate status creator_null in

  let bufsz_c = CI.cptr bufsz_p in
  let status_c = CI.cptr status_p in
  let creator_c = CI.cptr creator_p in

  let streams_voidp = _create_streams n creator_c bufsz_c status_c in
  let streams = CI.make_ptr streams streams_voidp in
  Owl_log.debug "buf = %i B" (Unsigned.Size_t.to_int !@bufsz_p);

  Gc.finalise destroy_streams streams;
  streams


let create_over_streams n streams =
  let creator_p = allocate status creator_null in
  let creator_c = CI.cptr creator_p in
  let streams_c = CI.cptr streams in
  _create_over_streams n creator_c streams_c
