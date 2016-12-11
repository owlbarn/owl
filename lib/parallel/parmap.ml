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

module Utils = Parmap_utils

(* OS related constants *)

(* sequence type, subsuming lists and arrays *)
type 'a sequence = L of 'a list | A of 'a array

let debug_enabled = ref false

(* toggle debugging *)
let debugging b = debug_enabled:=b

(* default number of cores, and a setter function *)

let default_ncores=ref (max 2 (Utils.numcores()-1));;

let set_default_ncores n = default_ncores := n;;
let get_default_ncores () = !default_ncores;;

(* exception handling code *)

let handle_exc core msg =
  Utils.log_error "aborting due to exception on core %d: %s" core msg; exit 1;;

(* Helper functions for stdout/stderr redirection *)

let can_redirect path =
  if not(Sys.file_exists path) then
    try
      Unix.mkdir path 0o777; true
    with Unix.Unix_error(e,_s,_s') ->
      (* another job may have created it between the check and the mkdir *)
      if e == Unix.EEXIST then true
      else begin
	      (Printf.eprintf "[Pid %d]: Error creating %s : %s; proceeding \
			       without stdout/stderr redirection\n%!"
		 (Unix.getpid ()) path (Unix.error_message e));
	      false
	end
  else true

let log_debug fmt =
  Printf.kprintf (
    if !debug_enabled then begin
      (fun s -> Format.eprintf "[Parmap]: %s@." s)
    end else ignore
  ) fmt

(* freopen emulation, from Xavier's suggestion on OCaml mailing list *)
let reopen_out outchan path fname =
  if can_redirect path then
    begin
      flush outchan;
      let filename = Filename.concat path fname in
      let fd1 = Unix.descr_of_out_channel outchan in
      let fd2 = Unix.openfile
                  filename [Unix.O_WRONLY; Unix.O_CREAT; Unix.O_TRUNC] 0o666 in
      Unix.dup2 fd2 fd1;
      Unix.close fd2
    end
  else ()

(* send stdout and stderr to a file to avoid mixing output from different
   cores, if enabled *)
let redirect ?(path = (Printf.sprintf "/tmp/.parmap.%d" (Unix.getpid ()))) ~id =
      reopen_out stdout path (Printf.sprintf "stdout.%d" id);
      reopen_out stderr path (Printf.sprintf "stderr.%d" id);;

(* unmarshal from a mmap seen as a bigarray *)
let unmarshal fd =
 let a =
   Bigarray.Array1.map_file fd Bigarray.char Bigarray.c_layout true (-1) in
 let res = Bytearray.unmarshal a 0 in
 Unix.close fd;
 res

(* marshal to a mmap seen as a bigarray *)

(* System dependent notes:

    (* a reasonable size for mmapping a file containing even huge result data *)
    let huge_size = if Sys.word_size = 64 then 1 lsl 32 else 1 lsl 26

    - on Linux kernels, we might allocate a mmapped memory area of huge_size
      and marshal into it directly

      let ba = Bigarray.Array1.map_file
                 fd Bigarray.char Bigarray.c_layout true huge_size in
      ignore(Bytearray.marshal_to_buffer ba 0 v [Marshal.Closures]);
      Unix.close fd

    - to be compatible with other systems, notably Mac OS X, which insist in
      allocating *all*
      the declared memory area even for a sparse file, we must choose a less
      efficient approach:
       * marshal the value v to a string s, and compute its size
       * allocate a mmap of that exact size,
       * copy the string to that mmap
      this allocates twice as much memory, and incurs an extra copy of the
      value v
*)

let marshal fd v =
  let s = Marshal.to_string v [Marshal.Closures] in
  ignore(Bytearray.mmap_of_string fd s)

(* Exit the program with calling [at_exit] handlers *)
external sys_exit : int -> 'a = "caml_sys_exit"

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

(* a simple mapper function that computes 1/nth of the data on each of the n
   cores in one iteration *)
let simplemapper (init:int -> unit) (finalize: unit -> unit) ncores compute opid al collect =
  (* flush everything *)
  flush_all();
  (* init task parameters *)
  let ln = Array.length al in
  let ncores = min ln (max 1 ncores) in
  let chunksize = max 1 (ln/ncores) in
  log_debug
    "simplemapper on %d elements, on %d cores, chunksize = %d%!"
    ln ncores chunksize;
  (* create descriptors to mmap *)
  let fdarr=Array.init ncores (fun _ -> Utils.tempfd()) in
  (* call the GC before forking *)
  Gc.compact ();
  (* run children *)
  run_many ncores ~in_subprocess:(fun i ->
    init i;  (* call initialization function *)
    Pervasives.at_exit finalize; (* register finalization function *)
    let lo=i*chunksize in
    let hi=if i=ncores-1 then ln-1 else (i+1)*chunksize-1 in
    let exc_handler e j = (* handle an exception at index j *)
      Utils.log_error
        "error at index j=%d in (%d,%d), chunksize=%d of a total of \
         %d got exception %s on core %d \n%!"
        j lo hi chunksize (hi-lo+1) (Printexc.to_string e) i;
      exit 1
    in
    let v = compute al lo hi opid exc_handler in
    marshal fdarr.(i) v);
  (* read in all data *)
  let res = ref [] in
  (* iterate in reverse order, to accumulate in the right order *)
  for i = 0 to ncores-1 do
      res:= ((unmarshal fdarr.((ncores-1)-i)):'d)::!res;
  done;
  (* collect all results *)
  collect !res

(* a simple iteration function that iterates on 1/nth of the data on each of
   the n cores *)
let simpleiter init finalize ncores compute al =
  (* flush everything *)
  flush_all();
  (* init task parameters *)
  let ln = Array.length al in
  let ncores = min ln (max 1 ncores) in
  let chunksize = max 1 (ln/ncores) in
  log_debug
    "simplemapper on %d elements, on %d cores, chunksize = %d%!"
    ln ncores chunksize;
  (* call the GC before forking *)
  Gc.compact ();
  (* run children *)
  run_many ncores ~in_subprocess:(fun i ->
    init i;  (* call initialization function *)
    Pervasives.at_exit finalize; (* register finalization function *)
    let lo=i*chunksize in
    let hi=if i=ncores-1 then ln-1 else (i+1)*chunksize-1 in
    let exc_handler e j = (* handle an exception at index j *)
      Utils.log_error
        "error at index j=%d in (%d,%d), chunksize=%d of a total of \
         %d got exception %s on core %d \n%!"
	j lo hi chunksize (hi-lo+1) (Printexc.to_string e) i;
      exit 1
    in
    compute al lo hi exc_handler);
  (* return with no value *)

(* a more sophisticated mapper function, with automatic load balancing *)

(* the type of messages exchanged between master and workers *)
type msg_to_master = Ready of int | Error of int * string
type msg_to_worker = Finished | Task of int

let setup_children_chans oc pipedown ?fdarr i =
  Utils.setcore i;
  (* close the other ends of the pipe and convert my ends to ic/oc *)
  Unix.close (snd pipedown.(i));
  let pid = Unix.getpid() in
  let ic = Unix.in_channel_of_descr (fst pipedown.(i)) in
  let receive () = Marshal.from_channel ic in
  let signal v = Marshal.to_channel oc v []; flush oc in
  let return v =
    let d = Unix.gettimeofday() in
    let _ = match fdarr with Some fdarr -> marshal fdarr.(i) v | None -> () in
    log_debug "worker elapsed %f in marshalling" (Unix.gettimeofday() -. d) in
  let finish () =
    (log_debug "shutting down (pid=%d)\n%!" pid;
     try close_in ic; close_out oc with _ -> ()
    );
    exit 0 in
  receive, signal, return, finish, pid

(* parametric mapper primitive that captures the parallel structure *)
let mapper (init:int -> unit) (finalize:unit -> unit) ncores ~chunksize compute opid al collect =
  let ln = Array.length al in
  if ln=0 then (collect []) else
  begin
   let ncores = min ln (max 1 ncores) in
   log_debug "mapper on %d elements, on %d cores%!" ln ncores;
   match chunksize with
     None ->
       (* no need of load balancing *)
       simplemapper init finalize ncores compute opid al collect
   | Some v when ncores >= ln/v ->
       (* no need of load balancing if more cores than tasks *)
       simplemapper init finalize ncores compute opid al collect
   | Some v ->
       (* init task parameters : ntasks > 0 here,
          as otherwise ncores >= 1 >= ln/v = ntasks and we would take
          the branch above *)
       let chunksize = v and ntasks = ln/v in
       (* flush everything *)
       flush_all ();
       (* create descriptors to mmap *)
       let fdarr=Array.init ncores (fun _ -> Utils.tempfd()) in
       (* setup communication channel with the workers *)
       let pipedown=Array.init ncores (fun _ -> Unix.pipe ()) in
       let pipeup_rd,pipeup_wr=Unix.pipe () in
       let oc_up = Unix.out_channel_of_descr pipeup_wr in
       (* call the GC before forking *)
       Gc.compact ();
       (* run children *)
       let pids =
         spawn_many ncores ~in_subprocess:(fun i ->
	   init i; (* call initialization function *)
	   Pervasives.at_exit finalize; (* register finalization function *)
           let d=Unix.gettimeofday()  in
           (* primitives for communication *)
           Unix.close pipeup_rd;
           let receive,signal,return,finish,pid =
             setup_children_chans oc_up pipedown ~fdarr i in
           let reschunk=ref opid in
           let computetask n = (* compute chunk number n *)
             let lo=n*chunksize in
             let hi=if n=ntasks-1 then ln-1 else (n+1)*chunksize-1 in
             let exc_handler e j = (* handle an exception at index j *)
               begin
                 let errmsg = Printexc.to_string e in
                 Utils.log_error
                   "error at index j=%d in (%d,%d), chunksize=%d of a \
                    total of %d got exception %s on core %d \n%!"
         	   j lo hi chunksize (hi-lo+1) errmsg i;
                 signal (Error (i,errmsg): msg_to_master);
                 finish()
               end
             in
             reschunk:= compute al lo hi !reschunk exc_handler;
             log_debug
               "worker on core %d (pid=%d), segment (%d,%d) of data of \
                length %d, chunksize=%d finished in %f seconds"
               i pid lo hi ln chunksize (Unix.gettimeofday() -. d)
           in
           while true do
             (* ask for work until we are finished *)
             signal (Ready i);
             match receive() with
             | Finished -> return (!reschunk:'d); finish ()
             | Task n -> computetask n
           done)
       in

       (* close unused ends of the pipes *)
       Array.iter (fun (rfd,_) -> Unix.close rfd) pipedown;
       Unix.close pipeup_wr;

       (* get ic/oc/wfdl *)
       let ocs=
         Array.init ncores
           (fun n -> Unix.out_channel_of_descr (snd pipedown.(n))) in
       let ic=Unix.in_channel_of_descr pipeup_rd in

       (* feed workers until all tasks are finished *)
       for i=0 to ntasks-1 do
         match Marshal.from_channel ic with
           Ready w ->
             (log_debug "sending task %d to worker %d" i w;
              let oc = ocs.(w) in
              (Marshal.to_channel oc (Task i) []); flush oc)
         | (Error (core,msg): msg_to_master) -> handle_exc core msg
       done;

       (* send termination token to all children *)
       Array.iter (fun oc ->
         Marshal.to_channel oc Finished [];
         flush oc;
         close_out oc
       ) ocs;

       (* wait for all children to terminate *)
       wait_for_pids pids;

       (* read in all data *)
       let res = ref [] in
       (* iterate in reverse order, to accumulate in the right order *)
       for i = 0 to ncores-1 do
         res:= ((unmarshal fdarr.((ncores-1)-i)):'d)::!res;
       done;
       (* collect all results *)
       collect !res
  end

(* parametric iteration primitive that captures the parallel structure *)
let geniter init finalize ncores ~chunksize compute al =
  let ln = Array.length al in
  if ln=0 then () else
  begin
   let ncores = min ln (max 1 ncores) in
   log_debug "geniter on %d elements, on %d cores%!" ln ncores;
   match chunksize with
     None ->
       simpleiter init finalize ncores compute al (* no need of load balancing *)
   | Some v when ncores >= ln/v ->
       simpleiter init finalize ncores compute al (* no need of load balancing *)
   | Some v ->
       (* init task parameters *)
       let chunksize = v and ntasks = ln/v in
       (* flush everything *)
       flush_all ();
       (* setup communication channel with the workers *)
       let pipedown=Array.init ncores (fun _ -> Unix.pipe ()) in
       let pipeup_rd,pipeup_wr=Unix.pipe () in
       let oc_up = Unix.out_channel_of_descr pipeup_wr in
       (* call the GC before forking *)
       Gc.compact ();
       (* spawn children *)
       let pids =
         spawn_many ncores ~in_subprocess:(fun i ->
	   init i; (* call initialization function *)
	   Pervasives.at_exit finalize; (* register finalization function *)
           let d=Unix.gettimeofday()  in
           (* primitives for communication *)
           Unix.close pipeup_rd;
           let receive,signal,return,finish,pid =
             setup_children_chans oc_up pipedown i in
           let computetask n = (* compute chunk number n *)
 	     let lo=n*chunksize in
 	     let hi=if n=ntasks-1 then ln-1 else (n+1)*chunksize-1 in
 	     let exc_handler e j = (* handle an exception at index j *)
 	       begin
 		 let errmsg = Printexc.to_string e in
                 Utils.log_error
                   "error at index j=%d in (%d,%d), chunksize=%d of \
                    a total of %d got exception %s on core %d \n%!"
 		   j lo hi chunksize (hi-lo+1) errmsg i;
 		 signal (Error (i,errmsg): msg_to_master);
                 finish()
 	       end
 	     in
 	     compute al lo hi exc_handler;
 	     log_debug
               "worker on core %d (pid=%d), segment (%d,%d) of data \
                of length %d, chunksize=%d finished in %f seconds"
 	       i pid lo hi ln chunksize (Unix.gettimeofday() -. d)
 	   in
 	   while true do
 	     (* ask for work until we are finished *)
 	     signal (Ready i);
 	     match receive() with
 	     | Finished -> return(); finish ()
 	     | Task n -> computetask n
           done)
       in

       (* close unused ends of the pipes *)
       Array.iter (fun (rfd,_) -> Unix.close rfd) pipedown;
       Unix.close pipeup_wr;

       (* get ic/oc/wfdl *)
       let ocs=Array.init ncores
         (fun n -> Unix.out_channel_of_descr (snd pipedown.(n))) in
       let ic=Unix.in_channel_of_descr pipeup_rd in

       (* feed workers until all tasks are finished *)
       for i=0 to ntasks-1 do
 	match Marshal.from_channel ic with
 	  Ready w ->
 	    (log_debug "sending task %d to worker %d" i w;
 	     let oc = ocs.(w) in
 	     (Marshal.to_channel oc (Task i) []); flush oc)
 	| (Error (core,msg): msg_to_master) -> handle_exc core msg
       done;

       (* send termination token to all children *)
       Array.iter (fun oc ->
 	Marshal.to_channel oc Finished [];
         flush oc;
         close_out oc
       ) ocs;

       (* wait for all children to terminate *)
       wait_for_pids pids;
       (* no data to return *)
  end

(* the parallel mapfold function *)

let parmapifold
    ?(init = fun _ -> ())
    ?(finalize = fun () -> ())
    ?(ncores= !default_ncores)
    ?(chunksize)
    (f:int -> 'a -> 'b)
    (s:'a sequence)
    (op:'b->'c->'c)
    (opid:'c)
    (concat:'c->'c->'c) : 'c=
  (* enforce array to speed up access to the list elements *)
  let al = match s with A al -> al | L l  -> Array.of_list l in
  let compute al lo hi previous exc_handler =
    (* iterate in reverse order, to accumulate in the right order *)
    let r = ref previous in
    for j=0 to (hi-lo) do
      try
        let idx = hi-j in
	r := op (f idx (Array.unsafe_get al idx)) !r;
      with e -> exc_handler e j
    done; !r
  in
  mapper
    init finalize ncores ~chunksize compute opid al (fun r -> Utils.fold_right concat r opid)

let parmapfold
    ?(init = fun _ -> ())
    ?(finalize = fun () -> ())
    ?ncores
    ?(chunksize)
    (f:'a -> 'b)
    (s:'a sequence)
    (op:'b->'c->'c)
    (opid:'c)
    (concat:'c->'c->'c) : 'c=
  parmapifold ~init ~finalize ?ncores ?chunksize (fun _ x -> f x) s op opid concat

(* the parallel map function *)

let parmapi
    ?(init = fun _ -> ())
    ?(finalize = fun () -> ())
    ?(ncores= !default_ncores)
    ?chunksize
    (f:int ->'a -> 'b)
    (s:'a sequence) : 'b list=
  (* enforce array to speed up access to the list elements *)
  let al = match s with A al -> al | L l  -> Array.of_list l in
  let compute al lo hi previous exc_handler =
    (* iterate in reverse order, to accumulate in the right order,
       and add to acc *)
    let f' j =
      try let idx = lo+j in f idx (Array.unsafe_get al idx)
      with e -> exc_handler e j in
    let rec aux acc =
      function
	  0 ->  (f' 0)::acc
	| n ->  aux ((f' n)::acc) (n-1)
    in aux previous (hi-lo)
  in
  mapper init finalize ncores ~chunksize compute [] al  (fun r -> Utils.concat_tr r)

let parmap ?init ?finalize ?ncores ?chunksize (f:'a -> 'b) (s:'a sequence) : 'b list=
    parmapi ?init ?finalize ?ncores ?chunksize (fun _ x -> f x) s

(* the parallel fold function *)

let parfold
    ?(init = fun _ -> ())
    ?(finalize = fun () -> ())
    ?(ncores= !default_ncores)
    ?chunksize
    (op:'a -> 'b -> 'b)
    (s:'a sequence)
    (opid:'b)
    (concat:'b->'b->'b) : 'b=
    parmapfold ~init ~finalize ~ncores ?chunksize (fun x -> x) s op opid concat

(* the parallel map function, on arrays *)

let mapi_range lo hi (f:int -> 'a -> 'b) a =
  let l = hi-lo in
  if l < 0 then [||] else begin
    let r = Array.make (l+1) (f 0 (Array.unsafe_get a lo)) in
    for i = 1 to l do
      let idx = lo+i in
      Array.unsafe_set r i (f idx (Array.unsafe_get a idx))
    done;
    r
  end

let array_parmapi
    ?(init = fun _ -> ())
    ?(finalize = fun () -> ())
    ?(ncores= !default_ncores)
    ?chunksize
    (f:int -> 'a -> 'b)
    (al:'a array) : 'b array=
  let compute a lo hi previous exc_handler =
    try
      Array.concat [(mapi_range lo hi f a);previous]
    with e -> exc_handler e lo
  in
  mapper init finalize ncores ~chunksize compute [||] al  (fun r -> Array.concat r)

let array_parmap ?init ?finalize ?ncores ?chunksize (f:'a -> 'b) (al:'a array) : 'b array=
  array_parmapi ?init ?finalize ?ncores ?chunksize (fun _ x -> f x) al

(* This code is highly optimised for operations on float arrays:

   - knowing in advance the size of the result allows to
     pre-allocate it in a shared memory space as a Bigarray;

   - to write in the Bigarray memory area using the unsafe
     functions for Arrays, we trick the OCaml compiler into
     using the Bigarray memory as an Array as follows

       Array.unsafe_get (Obj.magic arr_out) 1

     This works because OCaml compiles access to float arrays
     as unboxed data, without further integrity checks;

   - the final copy into a real OCaml array is done via a memcpy in C.

     This approach gives a performance which is 2 to 3 times higher
     w.r.t. array_parmap, at the price of using Obj.magic and
     knowledge on the internal representation of arrays and bigarrays.
 *)

exception WrongArraySize

type buf=
    (float, Bigarray.float64_elt, Bigarray.c_layout) Bigarray.Array1.t *
      int;; (* should be a long int some day *)

let init_shared_buffer a =
  let size = Array.length a in
  let fd = Utils.tempfd() in
  let arr =
    Bigarray.Array1.map_file fd Bigarray.float64 Bigarray.c_layout true size in

  (* The mmap() function shall add an extra reference to the file associated
     with the file descriptor fildes which is not removed by a subsequent
     close() on that file descriptor.
     http://pubs.opengroup.org/onlinepubs/009695399/functions/mmap.html
  *)
  Unix.close fd; (arr,size)

let array_float_parmapi
    ?(init = fun _ -> ())
    ?(finalize = fun () -> ())
    ?(ncores= !default_ncores)
    ?chunksize
    ?result
    ?sharedbuffer
    (f:int -> 'a -> float)
    (al:'a array) : float array =
  let size = Array.length al in
  if size=0 then [| |] else
  begin
   let barr_out =
     match sharedbuffer with
       Some (arr,s) ->
         if s<size then
           (Utils.log_error
              "shared buffer is too small to hold the input in \
               array_float_parmap";
            raise WrongArraySize)
         else arr
     | None -> fst (init_shared_buffer al)
   in
   (* trick the compiler into accessing the Bigarray memory area as a float
      array: the data in Bigarray is placed at offset 1 w.r.t. a normal array,
      so we get a pointer to that zone into arr_out_as_array, and have it typed
      as a float array *)
   let barr_out_as_array = Array.unsafe_get (Obj.magic barr_out) 1 in
   let compute _ lo hi _ exc_handler =
     try
       for i=lo to hi do
         Array.unsafe_set barr_out_as_array i (f i (Array.unsafe_get al i))
       done
     with e -> exc_handler e lo
   in
   mapper init finalize ncores ~chunksize compute () al (fun _r -> ());
   let res =
     match result with
       None -> Bytearray.to_floatarray barr_out size
     | Some a ->
         if Array.length a < size then
           (Utils.log_error
              "result array is too small to hold the result in \
               array_float_parmap";
            raise WrongArraySize)
         else
           Bytearray.to_this_floatarray a barr_out size
   in res
  end

let array_float_parmap
    ?(init = fun _ -> ())
    ?(finalize = fun () -> ())
    ?ncores
    ?chunksize
    ?result
    ?sharedbuffer
    (f:'a -> float)
    (al:'a array) : float array =
  array_float_parmapi
    ~init ~finalize ?ncores ?chunksize ?result ?sharedbuffer (fun _ x -> f x) al

(* the parallel iteration function *)

let pariteri
    ?(init = fun _ -> ())
    ?(finalize = fun () -> ())
    ?(ncores= !default_ncores)
    ?chunksize
    (f:int -> 'a -> unit)
    (s:'a sequence) : unit=
  (* enforce array to speed up access to the list elements *)
  let al = match s with A al -> al | L l  -> Array.of_list l in
  let compute al lo hi exc_handler =
    (* iterate on the given segment *)
    let f' j =
      try let idx = lo+j in f idx (Array.unsafe_get al idx)
      with e -> exc_handler e j in
    for i = 0 to hi-lo do
      f' i
    done
  in
  geniter init finalize ncores ~chunksize compute al

let pariter ?init ?finalize ?ncores ?chunksize (f:'a -> unit) (s:'a sequence) : unit=
  pariteri ?init ?finalize ?ncores ?chunksize (fun _ x -> f x) s
