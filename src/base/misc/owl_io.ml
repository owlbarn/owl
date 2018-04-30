(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_utils


(* read a file of a given path *)
let read_file ?(trim=true) f =
  let h = open_in f in
  let s = Stack.make () in
  (
    try while true do
      let l = match trim with
        | true  -> input_line h |> String.trim
        | false -> input_line h
      in
      Stack.push s l;
    done with End_of_file -> ()
  );
  close_in h;
  Stack.to_array s


let read_file_string f =
  let ic = open_in f in
  let n = in_channel_length ic in
  let s = Bytes.create n in
  really_input ic s 0 n;
  close_in ic;
  Bytes.to_string s


(* write a file of a given path *)
let write_file f s =
  let h = open_out f in
  Printf.fprintf h "%s" s;
  close_out h


(* iterate every doc in the corpus without loading the whole corpus in the
  memory, then apply passed in function f. note that each line is a doc.
 *)
let iteri_lines_of_file ?(verbose=true) f fname =
  let i = ref 0 in
  let h = open_in fname in
  (
    let t0 = Unix.gettimeofday () in
    let t1 = ref (Unix.gettimeofday ()) in
    try while true do
      f !i (input_line h);
      i := !i + 1;
      (* output summary if in verbose mode *)
      if verbose = true then (
        let t2 = Unix.gettimeofday () in
        if t2 -. !t1 > 5. then (
          t1 := t2;
          let speed = float_of_int !i /. (t2 -. t0) |> int_of_float in
          Owl_log.info "processed %i, avg. %i docs/s" !i speed
        )
      )
    done with End_of_file -> ()
  );
  close_in h


(* map every doc in the corpus into another type *)
let mapi_lines_of_file f fname =
  let stack = Owl_utils.Stack.make () in
  iteri_lines_of_file (fun i s ->
    Owl_utils.Stack.push stack (f i s)
  ) fname;
  Owl_utils.Stack.to_array stack


(* similar to iteri_lines_of_file but for marshaled file *)
let iteri_lines_of_marshal ?(verbose=true) f fname =
  let i = ref 0 in
  let h = open_in fname in
  (
    let t1 = ref (Unix.gettimeofday ()) in
    let i1 = ref 0 in

    try while true do
      f !i (Marshal.from_channel h);
      i := !i + 1;
      (* output summary if in verbose mode *)
      if verbose = true then (
        let t2 = Unix.gettimeofday () in
        if t2 -. !t1 > 5. then (
          let speed = float_of_int (!i - !i1) /. (t2 -. !t1) |> int_of_float in
          i1 := !i;
          t1 := t2;
          Owl_log.info "processed %i, avg. %i docs/s" !i speed
        )
      )
    done with End_of_file -> ()
  );
  close_in h


(* similar to mapi_lines_of_file but for marshaled file *)
let mapi_lines_of_marshal f fname =
  let stack = Owl_utils.Stack.make () in
  iteri_lines_of_marshal (fun i s ->
    Owl_utils.Stack.push stack (f i s)
  ) fname;
  Owl_utils.Stack.to_array stack


(* save a marshalled object to a file *)
let marshal_to_file x f =
  let s = Marshal.to_string x [] in
  let h = open_out f in
  output_string h s;
  close_out h


(* load a marshalled object from a file *)
let marshal_from_file f =
  let h = open_in f in
  let s = really_input_string h (in_channel_length h) in
  Marshal.from_string s 0


let head n fname =
  let lines = Owl_utils.Stack.make () in
  (
    try
      iteri_lines_of_file (fun i s ->
        assert (i < n);
        Owl_utils.Stack.push lines s
      ) fname
    with exn -> ()
  );
  Owl_utils.Stack.to_array lines


(* TODO *)
let tail n fname = raise Owl_exception.NOT_IMPLEMENTED


let read_csv ?(sep='\t') fname =
  let lines = Owl_utils.Stack.make () in
  iteri_lines_of_file (fun i s ->
    String.trim s
    |> String.split_on_char sep
    |> Array.of_list
    |> Owl_utils.Stack.push lines
  ) fname;
  Owl_utils.Stack.to_array lines


let write_csv ?(sep='\t') x fname =
  let h = open_out fname in
  Array.iter (fun row ->
    let s = Array.fold_left (fun acc elt ->
      Printf.sprintf "%s%s%c" acc elt sep
    ) "" row
    in
    Printf.fprintf h "%s\n" s
  ) x;
  close_out h


let read_csv_proc ?(sep='\t') proc fname =
  iteri_lines_of_file (fun i s ->
    String.trim s
    |> String.split_on_char sep
    |> Array.of_list
    |> proc i
  ) fname


let write_csv_proc ?(sep='\t') x proc fname =
  let h = open_out fname in
  Array.iter (fun row ->
    let s = Array.fold_left (fun acc elt ->
      Printf.sprintf "%s%s%c" acc (proc elt) sep
    ) "" row
    in
    Printf.fprintf h "%s\n" s
  ) x;
  close_out h


let csv_head ?(sep='\t') idx fname =
  let h = open_in fname in
  for i = 1 to idx - 1 do
    input_line h |> ignore
  done;
  input_line h
  |> String.trim
  |> String.split_on_char sep
  |> Array.of_list
