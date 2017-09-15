#!/usr/bin/env ocaml
#use "topfind"
#require "str"
#require "unix"

let copyright =
"(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)
"

(* convert c types to corresponding types in ctypes *)
let convert_c_types_to_ocaml_types = function
  | "size_t"           -> "size_t"
  | "size_t *"         -> "ptr size_t"
  | "void *"           -> "ptr void"
  | "cl_int"           -> "int32_t"
  | "cl_uint"          -> "uint32_t"
  | "cl_uint *"        -> "ptr uint32_t"
  | "cl_device_type"   -> "uint64_t"
  | "cl_device_type *" -> "ptr uint64_t"
  | "cl_device_id"     -> "ptr void"
  | "cl_device_id *"   -> "ptr (ptr void)"
  | "cl_device_info"   -> "uint32_t"
  | "cl_platform_id"   -> "ptr void"
  | "cl_platform_id *" -> "ptr (ptr void)"
  | "cl_platform_info" -> "uint32_t"
  | s -> failwith (Printf.sprintf "convert_c_types_to_ocaml_types: %s" s)


(* helper functions *)

let _get_content h =
  let s = ref "" in
  (
    try while true do
      s := !s ^ "\n" ^ (input_line h |> String.trim);
    done with End_of_file -> ()
  );
  !s


let _get_funlist fname =
  let h = open_in fname in
  let t = Hashtbl.create 1024 in
  (
    try while true do
      let s = input_line h |> String.trim in
      Hashtbl.add t s None;
    done with End_of_file -> ()
  );
  t


let is_in_funlist t fun_name = Hashtbl.mem t fun_name


let _clean_up_fun_declaration s =
  let regex0 = Str.regexp "\\([ \n\r]*/\\*[^\\*]+\\*/[ \n\r]*\\)" in
  let regex1 = Str.regexp "[ \n\r]+" in
  Str.global_replace regex0 "" s |>
  Str.global_replace regex1 " "


(* parse argument string to array *)
let parse_args_to_array s =
  Str.split (Str.regexp ",") s
  |> List.map String.trim
  |> Array.of_list


(* convert the list of functions into ctypes-compatible interfaces *)
let convert_to_ctypes_fun funs =
  Array.map (fun (fun_rval, fun_name, fun_vars, fun_vers) ->
    let args = parse_args_to_array fun_vars
      |> Array.map convert_c_types_to_ocaml_types
    in
    (* assemble the function string *)
    let args_s = Array.fold_left (fun a b -> a ^ b ^ " @-> ") "" args in
    let rval_s = convert_c_types_to_ocaml_types fun_rval in
    let fun_s = Printf.sprintf
      "  let %s = foreign \"%s\" (%sreturning %s)\n" fun_name fun_name args_s rval_s
    in
    fun_s
  ) funs


(* parse through opencl header file, filter out the structs *)
let parse_opencl_header_structs fname =
  let h = open_in fname in
  let s = _get_content h in

  let regex = Str.regexp "^typedef struct [^;]+;" in
  let ofs = ref 0 in
  let structs = ref [||] in
  (
    try while true do
      let _ofs = Str.search_forward regex s !ofs in
      let _s = Str.matched_group 0 s
        |> _clean_up_fun_declaration
        |> String.trim
      in

      (* parse one function *)
      let regex1 = Str.regexp "^typedef struct [ \\*_a-z]+ \\([_a-z]+\\);" in
      Str.search_forward regex1 _s 0 |> ignore;
      let _struct = Str.matched_group 1 _s in

      structs := Array.append !structs [| _struct |];
      ofs := _ofs + (String.length _s)
    done with exn -> ()
  );
  !structs


(* parse through opencl header file, filter out the functions *)
let parse_opencl_header_funlist fname funlist =
  let h = open_in fname in
  let s = _get_content h in
  let t = _get_funlist funlist in

  let regex = Str.regexp "^extern CL_API_ENTRY [^;]+;" in
  let ofs = ref 0 in
  let funs = ref [||] in
  (
    try while true do
      let _ofs = Str.search_forward regex s !ofs in
      let _s = Str.matched_group 0 s
        |> _clean_up_fun_declaration
        |> String.trim
      in

      (* parse one function *)
      let regex1 = Str.regexp "^extern CL_API_ENTRY \\([ \\*_a-z0-9]+\\) CL_API_CALL \\([^(]+\\)(\\([^;]+\\)) \\([_A-Z0-9]+\\);" in
      Str.search_forward regex1 _s 0 |> ignore;
      let _fun_rval = Str.matched_group 1 _s in
      let _fun_name = Str.matched_group 2 _s in
      let _fun_vars = Str.matched_group 3 _s in
      let _fun_vers = Str.matched_group 4 _s in
      (* Printf.printf "%s - %s - %s\n" _fun_rval _fun_name _fun_vers; *)

      (* only accept thos in funlist *)
      if is_in_funlist t _fun_name = true then (
        funs := Array.append !funs [| (_fun_rval, _fun_name, _fun_vars, _fun_vers) |]
      );

      ofs := _ofs + (String.length _s)
    done with exn -> ()
  );
  !funs


(* generate ctypes file *)
let convert_opencl_header_to_ctypes fname funs structs =
  let h = open_out fname in
  Printf.fprintf h "(** auto-generated opencl interface file, timestamp:%.0f *)\n\n" (Unix.gettimeofday ());
  Printf.fprintf h "open Ctypes\n\n";
  Printf.fprintf h "module Bindings (F : Cstubs.FOREIGN) = struct\n\n";
  Printf.fprintf h "  open F\n\n";

  Array.iter (fun s ->
    Printf.fprintf h "  type %s\n" s;
    Printf.fprintf h "  let %s : %s structure typ = structure \"%s\"\n\n" s s s;
  ) structs;

  Array.iter (fun s ->
    Printf.fprintf h "%s\n" s;
  ) (convert_to_ctypes_fun funs);

  Printf.fprintf h "end";

  close_out h


let _ =
  if Array.length Sys.argv < 2 then
    print_endline "Usage: parser [opencl header directory]"
  else (
    let dir = Sys.argv.(1) in
    let header = Printf.sprintf "%s/cl.h" dir in
    let funlist = Printf.sprintf "%s/cl_funlist.txt" dir in
    let ctypes_file = Sys.argv.(2) in

    let funs = parse_opencl_header_funlist header funlist in
    let structs = parse_opencl_header_structs header in
    convert_opencl_header_to_ctypes ctypes_file funs structs;
  )
