(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl

let read_file f =
  let h = open_in f in
  let s = Utils.Stack.make () in
  (
    try while true do
      let l = input_line h in
      Utils.Stack.push s l;
    done with End_of_file -> ()
  );
  close_in h;
  Utils.Stack.to_array s

let write_file f s =
  let h = open_out f in
  Printf.fprintf h "%s" s;
  close_out h

let preprocess script =
  let lines = read_file script in
  (* insert default configurations *)
  
  (* join all the lines *)
  let s = Array.fold_left (fun a l -> a ^ l ^ "\n") "" lines in
  print_endline s;
  let new_script = "_" ^ (Filename.basename script) in
  write_file new_script s;
  script

let run script =
  let cmd = "ocaml " ^ script in
  Sys.command cmd

let _ =
  print_endline "Owl's Zoo System";
  let processed = preprocess Sys.argv.(1) in
  run processed
  (* run Sys.argv.(1) *)
