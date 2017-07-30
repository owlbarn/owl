(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let write_file f s =
  let h = open_out f in
  Printf.fprintf h "%s" s;
  close_out h


let preprocess script =
  let new_script = "." ^ (Filename.basename script) in
  let content =
    "#require \"owl\"\n" ^
    "#require \"owl_zoo\"\n" ^
    Printf.sprintf "#use \"%s\"\n" script
  in
  write_file new_script content;
  new_script


let run script =
  let new_script = preprocess script in
  let cmd = "utop " ^ new_script in
  Sys.command cmd


(*
let run script =
  Toploop.initialize_toplevel_env ();
  Topdirs.dir_use Format.std_formatter "/Users/liang/Desktop/tmp/yyy/a.ml";
  Toploop.use_file Format.std_formatter script
  if (Toploop.run_script Format.std_formatter script [|""|]) then
    print_endline "true"
  else
    print_endline "false"
  let cmd = "ocaml " ^ script in
  Sys.command cmd *)


let _ = run Sys.argv.(1)

(*
open Owl

let read_file f =
  let h = open_in f in
  let s = Utils.Stack.make () in
  (
    try while true do
      let l = input_line h |> String.trim in
      Utils.Stack.push s l;
    done with End_of_file -> ()
  );
  close_in h;
  Utils.Stack.to_array s


let write_file f s =
  let h = open_out f in
  Printf.fprintf h "%s" s;
  close_out h


let process_macro_zoo x =
  let id = String.(sub x 4 (length x - 4) |> trim) in
  let dir = Sys.getenv "HOME" ^ "/.owl/zoo/" ^ id in
  (* only include ml files *)
  let mls = Sys.readdir (dir)
    |> Utils.array_filter (fun s ->
        Filename.check_suffix s "ml"
      )
  in
  Array.fold_left (fun a l ->
    Printf.sprintf "%s#use \"%s/%s\"\n" a dir l
  ) "" mls


let preprocess script =
  let lines = read_file script in
  (* FIXME: drop the first line *)
  let lines = Array.(sub lines 1 (length lines - 1)) in
  (* insert default configurations *)
  let lines = Utils.array_insert lines 0 "#use \"topfind\"" in
  let lines = Utils.array_insert lines 1 "#require \"owl\"" in
  (* process zoo macros *)
  let lines = Array.map (fun l ->
    if String.length l >= 4 && String.sub l 0 4 = "#zoo" then (
      process_macro_zoo l
    )
    else l
  ) lines in
  (* join all the lines *)
  let s = Array.fold_left (fun a l -> a ^ l ^ "\n") "" lines in
  let new_script = "." ^ (Filename.basename script) in
  write_file new_script s;
  new_script


let run script =
  let cmd = "ocaml " ^ script in
  Sys.command cmd


let _ =
  print_endline "Owl's Zoo System";
  let processed = preprocess Sys.argv.(1) in
  run processed
*)
