(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Ctypes

module CI = Cstubs_internals


type streams = unit ptr
let streams : streams typ = ptr void
let streams_null : streams = Ctypes.null


type status = unit ptr
let status : status typ = ptr void
let status_null : status = Ctypes.null


external _destroy_streams : _ CI.fatptr -> unit = "owl_clrng_philox_destroy_streams_stub"

external _create_streams : int -> CI.voidp = "owl_clrng_philox_create_streams_stub"


let destroy_streams stream =
  Owl_log.info "destroy stream ...";
  _destroy_streams (CI.cptr stream)


let create_streams n =
  let streams_voidp = _create_streams n in
  let streams = CI.make_ptr streams streams_voidp in
  Gc.finalise destroy_streams streams;
  streams
