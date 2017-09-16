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
  | "cl_device_id"     -> "ptr _cl_device_id"
  | "cl_device_id *"   -> "ptr (ptr _cl_device_id)"
  | "cl_device_info"   -> "uint32_t"
  | "cl_platform_id"   -> "ptr _cl_platform_id"
  | "cl_platform_id *" -> "ptr (ptr _cl_platform_id)"
  | "cl_platform_info" -> "uint32_t"
  | s                  -> failwith (Printf.sprintf "convert_c_types_to_ocaml_types: %s" s)


(* convert c types to ocaml types in ml file *)
let convert_c_types_to_ml_types = function
  | "size_t"           -> "Unsigned.size_t"
  | "size_t *"         -> "_ CI.fatptr"
  | "void *"           -> "_ CI.fatptr"
  | "cl_int"           -> "int32"
  | "cl_uint"          -> "Unsigned.uint32"
  | "cl_uint *"        -> "_ CI.fatptr"
  | "cl_device_type"   -> "Unsigned.uint64"
  | "cl_device_type *" -> "_ CI.fatptr"
  | "cl_device_id"     -> "_ CI.fatptr"
  | "cl_device_id *"   -> "_ CI.fatptr"
  | "cl_device_info"   -> "Unsigned.uint32"
  | "cl_platform_id"   -> "_ CI.fatptr"
  | "cl_platform_id *" -> "_ CI.fatptr"
  | "cl_platform_info" -> "Unsigned.uint32"
  | s                  -> failwith (Printf.sprintf "convert_c_types_to_ml_types: %s" s)


(* convert c types to ocaml types in mli file *)
let convert_c_types_to_mli_types = function
  | "size_t"           -> "Unsigned.size_t"
  | "size_t *"         -> "Unsigned.size_t ptr"
  | "void *"           -> "unit ptr"
  | "cl_int"           -> "int32"
  | "cl_uint"          -> "Unsigned.uint32"
  | "cl_uint *"        -> "Unsigned.uint32 ptr"
  | "cl_device_type"   -> "Unsigned.uint64"
  | "cl_device_type *" -> "unit64_t ptr"
  | "cl_device_id"     -> "cl_device_id"
  | "cl_device_id *"   -> "cl_device_id ptr"
  | "cl_device_info"   -> "Unsigned.uint32"
  | "cl_platform_id"   -> "cl_platform_id"
  | "cl_platform_id *" -> "cl_platform_id ptr"
  | "cl_platform_info" -> "Unsigned.uint32"
  | s                  -> failwith (Printf.sprintf "convert_c_types_to_ml_types: %s" s)


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
    (* assemble the function string *)
    let args_s = parse_args_to_array fun_vars
      |> Array.map convert_c_types_to_ocaml_types
      |> Array.fold_left (fun a b -> a ^ b ^ " @-> ") ""
    in
    let rval_s = convert_c_types_to_ocaml_types fun_rval in
    let fun_s = Printf.sprintf
      "  let %s = foreign \"%s\" (%sreturning %s)\n" fun_name fun_name args_s rval_s
    in
    fun_s
  ) funs


(* convert the list of functions into ocaml stub fun *)
let convert_to_ocaml_fun funs structs =
  Array.map (fun (fun_rval, fun_name, fun_vars, fun_vers) ->
    (* assemble the function string *)
    let args = parse_args_to_array fun_vars in
    let vars_s = Array.mapi (fun i _ -> Printf.sprintf "x%i" i) args
      |> Array.fold_left (fun a b -> a ^ b ^ " ") ""
    in
    let args_s = Array.mapi (fun i arg ->
      if String.get arg (String.length arg - 1) = '*' || Array.mem arg structs = true
      then Printf.sprintf "(CI.cptr x%i)" i
      else Printf.sprintf "x%i" i
    ) args |> Array.fold_left (fun a b -> a ^ b ^ " ") ""
    in
    let fun_s = Printf.sprintf
      "let %s %s=\n  owl_opencl_%s %s\n" fun_name vars_s fun_name args_s
    in
    fun_s
  ) funs


(* convert to fun in ml and mli files *)
let convert_to_extern_fun funs =
  Array.mapi (fun i (fun_rval, fun_name, fun_vars, fun_vers) ->
    let args = parse_args_to_array fun_vars in
    let args_l = Array.length args in
    let args_ml_s = args
      |> Array.map convert_c_types_to_ml_types
      |> Array.fold_left (fun a b -> a ^ b ^ " -> ") ""
    in
    let rval_ml_s = convert_c_types_to_ml_types fun_rval in

    (* NOTE: naming needs to be consistent with Ctypes *)
    let fun_native_s = Printf.sprintf "owl_opencl_stub_%i_%s" (i + 1) fun_name in
    let fun_byte_s = Printf.sprintf "owl_opencl_stub_%i_%s_byte%i" (i + 1) fun_name args_l in
    let fun_extern_s = match args_l < 6 with
      | true  -> Printf.sprintf "\"%s\"" fun_native_s
      | false -> Printf.sprintf "\"%s\" \"%s\"" fun_byte_s fun_native_s
    in
    let fun_ml_s = Printf.sprintf
      "external owl_opencl_%s\n  : %s%s\n  = %s\n" fun_name args_ml_s rval_ml_s fun_extern_s
    in

    let args_mli_s = args
      |> Array.map convert_c_types_to_mli_types
      |> Array.fold_left (fun a b -> a ^ b ^ " -> ") ""
    in
    let rval_mli_s = convert_c_types_to_mli_types fun_rval in
    let fun_mli_s = Printf.sprintf
      "val %s : %s%s\n" fun_name args_mli_s rval_mli_s
    in

    fun_ml_s, fun_mli_s
  ) funs


(* replace certain strings in constant value definition *)
let replace_const_val s =
  let regex0 = Str.regexp "CL_FALSE" in
  let regex1 = Str.regexp "CL_TRUE" in
  let regex2 = Str.regexp "<<" in
  String.trim s
  |> Str.global_replace regex0 "0"
  |> Str.global_replace regex1 "1"
  |> Str.global_replace regex2 "lsl"

(* parse through opencl header file, filter out the constants *)
let parse_opencl_header_consts fname =
  let h = open_in fname in
  let s = _get_content h in

  let regex = Str.regexp "^#define CL_[^\n^\r]+" in
  let ofs = ref 0 in
  let consts = ref [||] in
  (
    try while true do
      let _ofs = Str.search_forward regex s !ofs in
      let _s = Str.matched_group 0 s
        |> _clean_up_fun_declaration
        |> String.trim
      in

      (* parse one function *)
      let regex1 = Str.regexp "^#define CL_\\([_a-zA-Z0-9]+\\)\\([^\n]+\\)$" in
      Str.search_forward regex1 _s 0 |> ignore;
      let _const_name = Str.matched_group 1 _s |> String.trim in
      let _const_val = Str.matched_group 2 _s |> replace_const_val in

      consts := Array.append !consts [| (_const_name, _const_val) |];
      ofs := _ofs + (String.length _s)
    done with exn -> ()
  );
  !consts


(* parse through opencl header file to filtr out exception typs *)
let parse_opencl_header_exnfun fname =
  let h = open_in fname in
  let s = _get_content h in

  let regex = Str.regexp "/\\* Error Codes \\*/\\([^\\*]+\\)/" in
  Str.search_forward regex s 0 |> ignore;
  let s = Str.matched_group 0 s in

  let regex = Str.regexp "^#define CL_[^\n^\r]+" in
  let ofs = ref 0 in
  let exns = ref [||] in
  (
    try while true do
      let _ofs = Str.search_forward regex s !ofs in
      let _s = Str.matched_group 0 s
        |> _clean_up_fun_declaration
        |> String.trim
      in

      (* parse one function *)
      let regex1 = Str.regexp "^#define CL_\\([_a-zA-Z0-9]+\\)\\([^\n]+\\)$" in
      Str.search_forward regex1 _s 0 |> ignore;
      let _const_name = Str.matched_group 1 _s |> String.trim |> Printf.sprintf "EXN_%s" in
      let _const_val = Str.matched_group 2 _s |> replace_const_val in

      exns := Array.append !exns [| (_const_name, _const_val) |];
      ofs := _ofs + (String.length _s)
    done with exn -> ()
  );
  !exns


(* make check_err function for exns *)
let make_check_err_fun exns =
  let fun_s = "let cl_check_err = function\n" in
  let end_s = Printf.sprintf "  | %4s -> failwith \"owl_opencl:unknown\"\n" "_" in
  let cases = Array.map (fun (const_name, const_val) ->
    if const_val = "0" then Printf.sprintf "  | %3sl -> ()\n" "0"
    else Printf.sprintf "  | %3sl -> raise %s\n" const_val const_name
  ) exns
  |> Array.fold_left (fun a b -> a ^ b) ""
  in
  fun_s ^ cases ^ end_s


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
    Printf.fprintf h "  type _%s\n" s;
    Printf.fprintf h "  let _%s : _%s structure typ = structure \"_%s\"\n\n" s s s;
  ) structs;

  Array.iter (fun s ->
    Printf.fprintf h "%s\n" s;
  ) (convert_to_ctypes_fun funs);

  Printf.fprintf h "end";

  close_out h


(* generate ml and mli files *)
let convert_opencl_header_to_extern fname funs structs consts exns =
  (* generate opencl ml file *)
  let h_ml = open_out fname in
  Printf.fprintf h_ml "%s\n" copyright;
  Printf.fprintf h_ml "(** auto-generated opencl interface file, timestamp:%.0f *)\n\n" (Unix.gettimeofday ());
  Printf.fprintf h_ml "open Ctypes\n\n";
  Printf.fprintf h_ml "module CI = Cstubs_internals\n\n";

  Printf.fprintf h_ml "\n\n(** type definition *)\n\n";
  Array.iter (fun s ->
    Printf.fprintf h_ml "type %s = unit Ctypes.ptr\n" s;
    Printf.fprintf h_ml "let %s : %s Ctypes.typ = Ctypes.(ptr void)\n" s s;
    Printf.fprintf h_ml "let %s_null : %s = Ctypes.null\n" s s;
    Printf.fprintf h_ml "let %s_ptr_null : %s Ctypes.ptr = Obj.magic Ctypes.null\n\n" s s;
  ) structs;

  Printf.fprintf h_ml "\n\n(** function definition *)\n\n";
  Array.iter (fun (fun_ml_s, fun_mli_s) ->
    Printf.fprintf h_ml "%s\n" fun_ml_s;
  ) (convert_to_extern_fun funs);

  Printf.fprintf h_ml "\n\n(** stub function definition *)\n\n";
  Array.iter (fun fun_ml_s ->
    Printf.fprintf h_ml "%s\n" fun_ml_s;
  ) (convert_to_ocaml_fun funs structs);

  Printf.fprintf h_ml "\n\n(** constant definition *)\n\n";
  Array.iter (fun (const_name, const_val) ->
    Printf.fprintf h_ml "let cl_%s = %s\n\n" const_name const_val;
  ) consts;

  Printf.fprintf h_ml "\n\n(** exception definition *)\n\n";
  Array.iter (fun (const_name, const_val) ->
    Printf.fprintf h_ml "exception %s\n\n" const_name;
  ) exns;
  Printf.fprintf h_ml "%s\n" (make_check_err_fun exns);

  close_out h_ml;

  (* generate mli file *)
  let h_mli = open_out (fname ^ "i") in
  Printf.fprintf h_mli "%s\n" copyright;
  Printf.fprintf h_mli "(** auto-generated opencl interface file, timestamp:%.0f *)\n\n" (Unix.gettimeofday ());
  Printf.fprintf h_mli "open Ctypes\n\n";

  Printf.fprintf h_mli "\n\n(** type definition *)\n\n";
  Array.iter (fun s ->
    Printf.fprintf h_mli "type %s\n" s;
    Printf.fprintf h_mli "val %s : %s Ctypes.typ\n" s s;
    Printf.fprintf h_mli "val %s_null : %s\n" s s;
    Printf.fprintf h_mli "val %s_ptr_null : %s Ctypes.ptr\n\n" s s;
  ) structs;

  Printf.fprintf h_mli "\n\n(** function definition *)\n\n";
  Printf.fprintf h_mli "val cl_check_err : int32 -> unit\n\n";
  Array.iter (fun (fun_ml_s, fun_mli_s) ->
    Printf.fprintf h_mli "%s\n" fun_mli_s;
  ) (convert_to_extern_fun funs);

  Printf.fprintf h_mli "\n\n(** constant definition *)\n\n";
  Array.iter (fun (const_name, const_val) ->
    Printf.fprintf h_mli "val cl_%s : int\n\n" const_name;
  ) consts;

  Printf.fprintf h_mli "\n\n(** exception definition *)\n\n";
  Array.iter (fun (const_name, const_val) ->
    Printf.fprintf h_mli "exception %s\n\n" const_name;
  ) exns;

  close_out h_mli


let _ =
  if Array.length Sys.argv < 2 then
    print_endline "Usage: parser [opencl header directory]"
  else (
    let dir = Sys.argv.(1) in
    let header = Printf.sprintf "%s/cl.h" dir in
    let funlist = Printf.sprintf "%s/cl_funlist.txt" dir in
    let ctypes_file = Sys.argv.(2) in
    let out_ml_file = Sys.argv.(3) in

    let funs = parse_opencl_header_funlist header funlist in
    let structs = parse_opencl_header_structs header in
    let consts = parse_opencl_header_consts header in
    let exns = parse_opencl_header_exnfun header in
    convert_opencl_header_to_ctypes ctypes_file funs structs;
    convert_opencl_header_to_extern out_ml_file funs structs consts exns;
  )
