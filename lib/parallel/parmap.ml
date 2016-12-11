(**************************************************************************)
(* ParMap: a simple library to perform Map computations on a multi-core   *)
(*                                                                        *)
(*  Author(s):  Marco Danelutto, Roberto Di Cosmo                         *)
(*                                                                        *)
(*  This library is free software: you can redistribute it and/or modify  *)
(*  it under the terms of the GNU Lesser General Public License as        *)
(*  published by the Free Software Foundation, either version 2 of the    *)
(*  License, or (at your option) any later version.  A special linking    *)
(*  exception to the GNU Lesser General Public License applies to this    *)
(*  library, see the LICENSE file for more information.                   *)
(**************************************************************************)

open Bigarray

module Utils = Parmap_utils

(* Exit the program with calling [at_exit] handlers *)
external sys_exit : int -> 'a = "caml_sys_exit"

let log_debug fmt =
  Printf.kprintf (
    (fun s -> Format.eprintf "[Parmap]: %s@." s)
  ) fmt

let init_shared_buffer a =
  let sz = Array1.dim a in
  let fd = Utils.tempfd () in
  let ar = Bigarray.Array1.map_file fd Bigarray.float64 Bigarray.c_layout true sz in
  Unix.close fd; ar

let spawn_many n ~in_subprocess =
  let rec loop i acc =
    if i = n then
      acc
    else
      match Unix.fork() with
        0 ->
        (* [at_exit] handlers are called in reverse order of registration.
           By registering a handler that exits prematurely, we prevent the
           execution of handlers registered before the fork.

           This ignores the exit code provided by the user, but we ignore
           it anyway in [wait_for_pids].
        *)
        at_exit (fun () -> sys_exit 0);
        in_subprocess i;
        exit 0
      | -1 ->
        Utils.log_error "fork error: pid %d; i=%d" (Unix.getpid()) i;
        loop (i + 1) acc
      | pid ->
        loop (i + 1) (pid :: acc)
  in
  loop 0 []

let wait_for_pids pids =
  let rec wait_for_pid pid =
    try ignore(Unix.waitpid [] pid : int * Unix.process_status)
    with
    | Unix.Unix_error (Unix.ECHILD, _, _) -> ()
    | Unix.Unix_error (Unix.EINTR, _, _) -> wait_for_pid pid
  in
  List.iter wait_for_pid pids

let run_many n ~in_subprocess =
  wait_for_pids (spawn_many n ~in_subprocess)

let simplemapper ncores compute opid al =
  (* flush everything *)
  flush_all();
  (* init task parameters *)
  let ln = Array1.dim al in
  let ncores = min ln (max 1 ncores) in
  let chunksize = max 1 (ln / ncores) in
  log_debug "parmap on %d elements, on %d cores, chunksize = %d%!" ln ncores chunksize;
  (* create descriptors to mmap *)
  let fdarr=Array.init ncores (fun _ -> Utils.tempfd()) in
  (* call the GC before forking *)
  Gc.compact ();
  (* run children *)
  run_many ncores ~in_subprocess:(fun i ->
    let lo = i * chunksize in
    let hi = if i = ncores - 1 then ln - 1 else (i + 1) * chunksize - 1 in
    let exc_handler e j = (* handle an exception at index j *)
      Utils.log_error
        "error at index j=%d in (%d,%d), chunksize=%d of a total of \
         %d got exception %s on core %d \n%!"
        j lo hi chunksize (hi-lo+1) (Printexc.to_string e) i;
      exit 1
    in
    compute al lo hi opid exc_handler
  )

let mymap f x =
  let size = Array1.dim x in
  let barr_out = init_shared_buffer x in
  let compute _ lo hi _ exc_handler =
    try
      for i=lo to hi do
        Array1.unsafe_set barr_out i (f i (Array1.unsafe_get x i))
      done
    with e -> exc_handler e lo
  in
  ()
