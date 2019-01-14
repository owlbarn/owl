#!/usr/bin/env ocaml
#use "topfind"
#require "str"
#require "unix"

let copyright =
"(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)
"

(* convert c types to corresponding types in ctypes *)
let convert_c_types_to_ocaml_types = function
  | "char *"                         -> "ptr char"
  | "char **"                        -> "ptr (ptr char)"
  | "unsigned char **"               -> "ptr (ptr uchar)"
  | "size_t"                         -> "size_t"
  | "size_t *"                       -> "ptr size_t"
  | "void"                           -> "void"
  | "void *"                         -> "ptr void"
  | "void **"                        -> "ptr (ptr void)"
  | "cl_int"                         -> "int32_t"
  | "cl_int *"                       -> "ptr int32_t"
  | "cl_uint"                        -> "uint32_t"
  | "cl_uint *"                      -> "ptr uint32_t"
  | "cl_bool"                        -> "uint32_t"
  | "cl_ulong *"                     -> "ptr ulong"
  | "cl_device_type"                 -> "ulong"
  | "cl_device_type *"               -> "ptr ulong"
  | "cl_device_id"                   -> "ptr _cl_device_id"
  | "cl_device_id *"                 -> "ptr (ptr _cl_device_id)"
  | "cl_context"                     -> "ptr _cl_context"
  | "cl_context_properties *"        -> "ptr intptr_t"
  | "cl_context_info"                -> "uint32_t"
  | "cl_device_info"                 -> "uint32_t"
  | "cl_platform_id"                 -> "ptr _cl_platform_id"
  | "cl_platform_id *"               -> "ptr (ptr _cl_platform_id)"
  | "cl_platform_info"               -> "uint32_t"
  | "cl_device_partition_property"   -> "intptr_t"
  | "cl_device_partition_property *" -> "ptr intptr_t"
  | "cl_command_queue"               -> "ptr _cl_command_queue"
  | "cl_command_queue_info"          -> "uint32_t"
  | "cl_command_queue_properties"    -> "ulong"
  | "cl_mem"                         -> "ptr _cl_mem"
  | "cl_mem *"                       -> "ptr (ptr _cl_mem)"
  | "cl_mem_flags"                   -> "ulong"
  | "cl_mem_info"                    -> "uint32_t"
  | "cl_mem_object_type"             -> "uint32_t"
  | "cl_mem_migration_flags"         -> "ulong"
  | "cl_svm_mem_flags"               -> "ulong"
  | "cl_buffer_create_type"          -> "uint32_t"
  | "cl_image_info"                  -> "uint32_t"
  | "cl_addressing_mode"             -> "uint32_t"
  | "cl_filter_mode"                 -> "uint32_t"
  | "cl_sampler"                     -> "ptr _cl_sampler"
  | "cl_sampler_info"                -> "uint32_t"
  | "cl_sampler_properties *"        -> "ptr ulong"
  | "cl_program"                     -> "ptr _cl_program"
  | "cl_program *"                   -> "ptr (ptr _cl_program)"
  | "cl_program_info"                -> "uint32_t"
  | "cl_program_build_info"          -> "uint32_t"
  | "cl_kernel"                      -> "ptr _cl_kernel"
  | "cl_kernel *"                    -> "ptr (ptr _cl_kernel)"
  | "cl_kernel_info"                 -> "uint32_t"
  | "cl_kernel_arg_info"             -> "uint32_t"
  | "cl_kernel_work_group_info"      -> "uint32_t"
  | "cl_kernel_sub_group_info"       -> "uint32_t"
  | "cl_kernel_exec_info"            -> "uint32_t"
  | "cl_event"                       -> "ptr _cl_event"
  | "cl_event *"                     -> "ptr (ptr _cl_event)"
  | "cl_event_info"                  -> "uint32_t"
  | "cl_profiling_info"              -> "uint32_t"
  | "cl_map_flags"                   -> "ulong"
  | "cl_pipe_info"                   -> "uint32_t"
  | "cl_pipe_properties"             -> "intptr_t"
  | "cl_pipe_properties *"           -> "ptr intptr_t"
  | "cl_queue_properties *"          -> "ptr ulong"
  | s                                -> failwith (Printf.sprintf "convert_c_types_to_ocaml_types: %s" s)


(* convert c types to ocaml types in ml file *)
let convert_c_types_to_ml_types = function
  | "char *"                         -> "_ CI.fatptr"
  | "char **"                        -> "_ CI.fatptr"
  | "unsigned char **"               -> "_ CI.fatptr"
  | "size_t"                         -> "Unsigned.size_t"
  | "void"                           -> "unit"
  | "size_t *"                       -> "_ CI.fatptr"
  | "void *"                         -> "_ CI.fatptr"
  | "void **"                        -> "_ CI.fatptr"
  | "cl_int"                         -> "int32"
  | "cl_int *"                       -> "_ CI.fatptr"
  | "cl_uint"                        -> "Unsigned.uint32"
  | "cl_uint *"                      -> "_ CI.fatptr"
  | "cl_bool"                        -> "Unsigned.uint32"
  | "cl_ulong *"                     -> "_ CI.fatptr"
  | "cl_device_type"                 -> "Unsigned.ULong.t"
  | "cl_device_type *"               -> "_ CI.fatptr"
  | "cl_device_id"                   -> "_ CI.fatptr"
  | "cl_device_id *"                 -> "_ CI.fatptr"
  | "cl_context"                     -> "_ CI.fatptr"
  | "cl_context_info"                -> "Unsigned.uint32"
  | "cl_context_properties *"        -> "_ CI.fatptr"
  | "cl_device_info"                 -> "Unsigned.uint32"
  | "cl_platform_id"                 -> "_ CI.fatptr"
  | "cl_platform_id *"               -> "_ CI.fatptr"
  | "cl_platform_info"               -> "Unsigned.uint32"
  | "cl_device_partition_property"   -> "intptr_t"
  | "cl_device_partition_property *" -> "_ CI.fatptr"
  | "cl_command_queue"               -> "_ CI.fatptr"
  | "cl_command_queue_info"          -> "Unsigned.uint32"
  | "cl_command_queue_properties"    -> "Unsigned.ULong.t"
  | "cl_mem"                         -> "_ CI.fatptr"
  | "cl_mem *"                       -> "_ CI.fatptr"
  | "cl_mem_flags"                   -> "Unsigned.ULong.t"
  | "cl_mem_info"                    -> "Unsigned.uint32"
  | "cl_mem_object_type"             -> "Unsigned.uint32"
  | "cl_mem_migration_flags"         -> "Unsigned.ULong.t"
  | "cl_svm_mem_flags"               -> "Unsigned.ULong.t"
  | "cl_buffer_create_type"          -> "Unsigned.uint32"
  | "cl_image_info"                  -> "Unsigned.uint32"
  | "cl_addressing_mode"             -> "Unsigned.uint32"
  | "cl_filter_mode"                 -> "Unsigned.uint32"
  | "cl_sampler"                     -> "_ CI.fatptr"
  | "cl_sampler_info"                -> "Unsigned.uint32"
  | "cl_sampler_properties *"        -> "_ CI.fatptr"
  | "cl_program"                     -> "_ CI.fatptr"
  | "cl_program *"                   -> "_ CI.fatptr"
  | "cl_program_info"                -> "Unsigned.uint32"
  | "cl_program_build_info"          -> "Unsigned.uint32"
  | "cl_kernel"                      -> "_ CI.fatptr"
  | "cl_kernel *"                    -> "_ CI.fatptr"
  | "cl_kernel_info"                 -> "Unsigned.uint32"
  | "cl_kernel_arg_info"             -> "Unsigned.uint32"
  | "cl_kernel_work_group_info"      -> "Unsigned.uint32"
  | "cl_kernel_sub_group_info"       -> "Unsigned.uint32"
  | "cl_kernel_exec_info"            -> "Unsigned.uint32"
  | "cl_event"                       -> "_ CI.fatptr"
  | "cl_event *"                     -> "_ CI.fatptr"
  | "cl_event_info"                  -> "Unsigned.uint32"
  | "cl_profiling_info"              -> "Unsigned.uint32"
  | "cl_map_flags"                   -> "Unsigned.ULong.t"
  | "cl_pipe_info"                   -> "Unsigned.uint32"
  | "cl_pipe_properties"             -> "intptr_t"
  | "cl_pipe_properties *"           -> "_ CI.fatptr"
  | "cl_queue_properties *"          -> "_ CI.fatptr"
  | s                                -> failwith (Printf.sprintf "convert_c_types_to_ml_types: %s" s)


(* convert c types to ocaml types in mli file *)
let convert_c_types_to_mli_types = function
  | "char *"                         -> "char ptr"
  | "char **"                        -> "char ptr ptr"
  | "unsigned char **"               -> "Unsigned.UChar.t ptr ptr"
  | "size_t"                         -> "Unsigned.size_t"
  | "size_t *"                       -> "Unsigned.size_t ptr"
  | "void"                           -> "unit"
  | "void *"                         -> "unit ptr"
  | "void **"                        -> "unit ptr ptr"
  | "cl_int"                         -> "int32"
  | "cl_int *"                       -> "int32 ptr"
  | "cl_uint"                        -> "Unsigned.uint32"
  | "cl_uint *"                      -> "Unsigned.uint32 ptr"
  | "cl_bool"                        -> "Unsigned.uint32"
  | "cl_ulong *"                     -> "Unsigned.ULong.t ptr"
  | "cl_device_type"                 -> "Unsigned.ULong.t"
  | "cl_device_type *"               -> "unit64_t ptr"
  | "cl_device_id"                   -> "cl_device_id"
  | "cl_device_id *"                 -> "cl_device_id ptr"
  | "cl_context"                     -> "cl_context"
  | "cl_context_info"                -> "Unsigned.uint32"
  | "cl_context_properties *"        -> "Intptr.t ptr"
  | "cl_device_info"                 -> "Unsigned.uint32"
  | "cl_platform_id"                 -> "cl_platform_id"
  | "cl_platform_id *"               -> "cl_platform_id ptr"
  | "cl_platform_info"               -> "Unsigned.uint32"
  | "cl_device_partition_property"   -> "Intptr.t"
  | "cl_device_partition_property *" -> "Intptr.t ptr"
  | "cl_command_queue"               -> "cl_command_queue"
  | "cl_command_queue_info"          -> "Unsigned.uint32"
  | "cl_command_queue_properties"    -> "Unsigned.ULong.t"
  | "cl_mem"                         -> "cl_mem"
  | "cl_mem *"                       -> "cl_mem ptr"
  | "cl_mem_flags"                   -> "Unsigned.ULong.t"
  | "cl_mem_info"                    -> "Unsigned.uint32"
  | "cl_mem_object_type"             -> "Unsigned.uint32"
  | "cl_mem_migration_flags"         -> "Unsigned.ULong.t"
  | "cl_svm_mem_flags"               -> "Unsigned.ULong.t"
  | "cl_buffer_create_type"          -> "Unsigned.uint32"
  | "cl_image_info"                  -> "Unsigned.uint32"
  | "cl_addressing_mode"             -> "Unsigned.uint32"
  | "cl_filter_mode"                 -> "Unsigned.uint32"
  | "cl_sampler"                     -> "cl_sampler"
  | "cl_sampler_info"                -> "Unsigned.uint32"
  | "cl_sampler_properties *"        -> "Unsigned.ULong.t ptr"
  | "cl_program"                     -> "cl_program"
  | "cl_program *"                   -> "cl_program ptr"
  | "cl_program_info"                -> "Unsigned.uint32"
  | "cl_program_build_info"          -> "Unsigned.uint32"
  | "cl_kernel"                      -> "cl_kernel"
  | "cl_kernel *"                    -> "cl_kernel ptr"
  | "cl_kernel_info"                 -> "Unsigned.uint32"
  | "cl_kernel_arg_info"             -> "Unsigned.uint32"
  | "cl_kernel_work_group_info"      -> "Unsigned.uint32"
  | "cl_kernel_sub_group_info"       -> "Unsigned.uint32"
  | "cl_kernel_exec_info"            -> "Unsigned.uint32"
  | "cl_event"                       -> "cl_event"
  | "cl_event *"                     -> "cl_event ptr"
  | "cl_event_info"                  -> "Unsigned.uint32"
  | "cl_profiling_info"              -> "Unsigned.uint32"
  | "cl_map_flags"                   -> "Unsigned.ULong.t"
  | "cl_pipe_info"                   -> "Unsigned.uint32"
  | "cl_pipe_properties"             -> "Intptr.t"
  | "cl_pipe_properties *"           -> "Intptr.t ptr"
  | "cl_queue_properties *"          -> "Unsigned.ULong.t ptr"
  | s                                -> failwith (Printf.sprintf "convert_c_types_to_ml_types: %s" s)


(* convert c types to ocaml returning types in ml file *)
let convert_c_types_to_ml_rvals = function
  | "cl_platform_id"   -> "CI.voidp"
  | "cl_device_id"     -> "CI.voidp"
  | "cl_context"       -> "CI.voidp"
  | "cl_command_queue" -> "CI.voidp"
  | "cl_mem"           -> "CI.voidp"
  | "cl_program"       -> "CI.voidp"
  | "cl_kernel"        -> "CI.voidp"
  | "cl_event"         -> "CI.voidp"
  | "cl_sampler"       -> "CI.voidp"
  | "void *"           -> "CI.voidp"
  | a                  -> convert_c_types_to_mli_types a

(* convert c types to ocaml returning types in mli file *)
let convert_c_types_to_mli_rvals = function
  | "cl_platform_id"   -> "cl_platform_id"
  | "cl_device_id"     -> "cl_device_id"
  | "cl_context"       -> "cl_context"
  | "cl_command_queue" -> "cl_command_queue"
  | "cl_mem"           -> "cl_mem"
  | "cl_program"       -> "cl_program"
  | "cl_kernel"        -> "cl_kernel"
  | "cl_event"         -> "cl_event"
  | "cl_sampler"       -> "cl_sampler"
  | "void *"           -> "unit ptr"
  | a            -> convert_c_types_to_mli_types a


(* check if we need to call make_ptr *)
let is_rval_ptr s =
  let l = [
    "cl_platform_id";
    "cl_device_id";
    "cl_context";
    "cl_command_queue";
    "cl_mem";
    "cl_program";
    "cl_kernel";
    "cl_event";
    "cl_sampler";
    "void *"
  ]
  in
  List.mem s l


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


(* get rid of the stuff I don't really want to deal with atm *)
let _clean_up_fun_declaration s =
  let regex0 = Str.regexp "\\([ \n\r]*/\\*[^\\*]+\\*/[ \n\r]*\\)" in
  let regex1 = Str.regexp "[ \n\r]+" in
  let regex2 = Str.regexp "const" in
  let regex6 = Str.regexp "void\\*" in
  let regex4 = Str.regexp "void \\*\\[\\]" in
  let regex5 = Str.regexp "ulong\\*" in
  let regex7 = Str.regexp "cl_int\\*" in
  let regex8 = Str.regexp "size_t\\*" in
  let regex3 = Str.regexp "void (CL_CALLBACK \\*)([ ,_\\*a-zA-Z0-9]+)" in
  Str.global_replace regex0 "" s |>
  Str.global_replace regex1 " " |>
  Str.global_replace regex2 "" |>
  Str.global_replace regex6 "void *" |>
  Str.global_replace regex4 "void **" |>
  Str.global_replace regex5 "ulong *" |>
  Str.global_replace regex7 "cl_int *" |>
  Str.global_replace regex8 "size_t *" |>
  Str.global_replace regex3 "void *"


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
    let rval_s =
      let s = convert_c_types_to_ocaml_types fun_rval in
      if List.length (Str.split (Str.regexp " ") s) = 1 then s
      else Printf.sprintf "(%s)" s
    in
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
    let fun_s =
      if is_rval_ptr fun_rval = false then
        Printf.sprintf "let %s %s=\n  owl_opencl_%s %s\n" fun_name vars_s fun_name args_s
      else
        Printf.sprintf "let %s %s=\n  ( owl_opencl_%s %s)\n  |> CI.make_ptr void\n" fun_name vars_s fun_name args_s
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
    let rval_ml_s = convert_c_types_to_ml_rvals fun_rval in

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
    let rval_mli_s = convert_c_types_to_mli_rvals fun_rval in
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
      )
      else Printf.printf "opencl %s @ %s\n" _fun_name _fun_vars;

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

  Printf.fprintf h_ml "\n\n(** {6 Type definition} *)\n\n";
  Array.iter (fun s ->
    Printf.fprintf h_ml "type %s = unit Ctypes.ptr\n" s;
    Printf.fprintf h_ml "let %s : %s Ctypes.typ = Ctypes.(ptr void)\n" s s;
    Printf.fprintf h_ml "let %s_null : %s = Ctypes.null\n" s s;
    Printf.fprintf h_ml "let %s_ptr_null : %s Ctypes.ptr = Obj.magic Ctypes.null\n\n" s s;
  ) structs;

  Printf.fprintf h_ml "\n\n(** {6 Function definition} *)\n\n";
  Array.iter (fun (fun_ml_s, fun_mli_s) ->
    Printf.fprintf h_ml "%s\n" fun_ml_s;
  ) (convert_to_extern_fun funs);

  Printf.fprintf h_ml "\n\n(** {6 Stub function definition} *)\n\n";
  Array.iter (fun fun_ml_s ->
    Printf.fprintf h_ml "%s\n" fun_ml_s;
  ) (convert_to_ocaml_fun funs structs);

  Printf.fprintf h_ml "\n\n(** {6 Constants definition} *)\n\n";
  Array.iter (fun (const_name, const_val) ->
    Printf.fprintf h_ml "let cl_%s = %s\n\n" const_name const_val;
  ) consts;

  Printf.fprintf h_ml "\n\n(** {6 Exception definition} *)\n\n";
  Array.iter (fun (exn_name, exn_val) ->
    Printf.fprintf h_ml "exception %s\n\n" exn_name;
  ) exns;
  Printf.fprintf h_ml "%s\n" (make_check_err_fun exns);

  close_out h_ml;

  (* generate mli file *)
  let h_mli = open_out (fname ^ "i") in
  Printf.fprintf h_mli "%s\n" copyright;
  Printf.fprintf h_mli "(** auto-generated opencl interface file, timestamp:%.0f *)\n\n" (Unix.gettimeofday ());
  Printf.fprintf h_mli "open Ctypes\n\n";

  Printf.fprintf h_mli "\n\n(** {6 Type definition} *)\n\n";
  Array.iter (fun s ->
    Printf.fprintf h_mli "type %s\n" s;
    Printf.fprintf h_mli "(** Type of %s *)\n\n" s;

    Printf.fprintf h_mli "val %s : %s Ctypes.typ\n" s s;
    Printf.fprintf h_mli "(** Value of %s *)\n\n" s;

    Printf.fprintf h_mli "val %s_null : %s\n" s s;
    Printf.fprintf h_mli "(** Null value of %s *)\n\n" s;

    Printf.fprintf h_mli "val %s_ptr_null : %s Ctypes.ptr\n" s s;
    Printf.fprintf h_mli "(** Null pointer of %s *)\n\n\n" s;
  ) structs;

  Printf.fprintf h_mli "\n\n(** {6 Function definition} *)\n\n";

  Printf.fprintf h_mli "val cl_check_err : int32 -> unit\n";
  Printf.fprintf h_mli "(** ``cl_check_err`` checks error code of return value. *)\n\n";

  Array.iter (fun (fun_ml_s, fun_mli_s) ->
    Printf.fprintf h_mli "%s\n" (String.trim fun_mli_s);
    Printf.fprintf h_mli "(** Refer to `OpenCL <https://www.khronos.org/opencl/>`_ *)\n\n";
  ) (convert_to_extern_fun funs);

  Printf.fprintf h_mli "\n\n(** {6 Constant definition} *)\n\n";
  Array.iter (fun (const_name, const_val) ->
    Printf.fprintf h_mli "val cl_%s : int\n" const_name;
    Printf.fprintf h_mli "(** Constant ``%s = %s``. *)\n\n" const_name const_val;
  ) consts;

  Printf.fprintf h_mli "\n\n(** {6 Exception definition} *)\n\n";
  Array.iter (fun (exn_name, exn_val) ->
    Printf.fprintf h_mli "exception %s\n" exn_name;
    Printf.fprintf h_mli "(** Exception ``%s``. *)\n\n" exn_name;
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
