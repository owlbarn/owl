open Bigarray

module Utils = Owl_parallel_utils

(* Exit the program with calling [at_exit] handlers *)
external sys_exit : int -> 'a = "caml_sys_exit"

let default_ncores = Utils.numcores () - 1

let log_debug fmt =
  Printf.kprintf (
    (fun s -> Format.eprintf "[Parallel]: %s@." s)
  ) fmt

let marshal fd v =
  let s = Marshal.to_string v [Marshal.Closures] in
  ignore(Bytearray.mmap_of_string fd s)

(* unmarshal from a mmap seen as a bigarray *)
let unmarshal fd =
 let a =
   Bigarray.Array1.map_file fd Bigarray.char Bigarray.c_layout true (-1) in
 let res = Bytearray.unmarshal a 0 in
 Unix.close fd;
 res

let init_shared_buffer x =
  let s = Array1.dim x in
  let f = Utils.tempfd () in
  let k = Array1.kind x in
  let y = Bigarray.Array1.map_file f k c_layout true s in
  Unix.close f; y

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

let simplemapper ncores compute opid x =
  (* flush everything *)
  flush_all();
  (* init task parameters *)
  let ln = Array1.dim x in
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
        j lo hi chunksize (hi - lo + 1) (Printexc.to_string e) i;
      exit 1
    in
    let v = compute x lo hi opid exc_handler in
    marshal fdarr.(i) v
  );
  (* read in all data *)
  let res = ref [] in
  (* iterate in reverse order, to accumulate in the right order *)
  for i = 0 to ncores - 1 do
      res:= ((unmarshal fdarr.((ncores-1)-i)):'d)::!res;
  done

let simpleiter ncores compute x =
  (* flush everything *)
  flush_all();
  (* init task parameters *)
  let ln = Array1.dim x in
  let ncores = min ln (max 1 ncores) in
  let chunksize = max 1 (ln / ncores) in
  log_debug
    "simplemapper on %d elements, on %d cores, chunksize = %d%!"
    ln ncores chunksize;
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
	      j lo hi chunksize (hi - lo + 1) (Printexc.to_string e) i;
      exit 1
    in
    compute x lo hi exc_handler
  )

let mymap f x =
  let y = init_shared_buffer x in
  let compute _ lo hi _ exc_handler =
    try
      for i = lo to hi do
        Array1.unsafe_set y i (f i (Array1.unsafe_get x i))
      done
    with e -> exc_handler e lo
  in
  simplemapper default_ncores compute () x;
  y

let map_block
  (f : int -> int -> ('a, 'b, c_layout) Bigarray.Array1.t -> ('a, 'b, c_layout) Bigarray.Array1.t -> unit)
  (x : ('a, 'b, c_layout) Bigarray.Array1.t) =
  let y = init_shared_buffer x in
  let compute _ lo hi exc_handler =
    try f lo hi x y
    with e -> exc_handler e lo
  in
  simpleiter default_ncores compute x;
  y
