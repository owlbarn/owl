(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type arg = {
  mutable typ  : string;
  mutable name : string;
}

let make_arg typ name = { typ; name }


let print_help () = print_endline "Usage: EXE cblas.h ctypes_output_file binding_output_file"


(* convert c types to corresponding types in ctypes *)
let convert_typ_to_ctypes = function
  | "int"                    -> "int"
  | "char"                   -> "char"
  | "float"                  -> "float"
  | "double"                 -> "double"
  | "lapack_int"             -> "int"
  | "lapack_logical"         -> "int"
  | "lapack_complex_float"   -> "complex32"
  | "lapack_complex_double"  -> "complex64"
  | "char*"                  -> "ptr char"
  | "float*"                 -> "ptr float"
  | "double*"                -> "ptr double"
  | "lapack_int*"            -> "ptr int"
  | "lapack_logical*"        -> "ptr int"
  | "lapack_complex_float*"  -> "ptr complex32"
  | "lapack_complex_double*" -> "ptr complex64"
  (* FIXME ? *)
  | "LAPACK_C_SELECT1"       -> "ptr void"
  | "LAPACK_Z_SELECT1"       -> "ptr void"
  | "LAPACK_S_SELECT2"       -> "ptr void"
  | "LAPACK_D_SELECT2"       -> "ptr void"
  | "LAPACK_C_SELECT2"       -> "ptr void"
  | "LAPACK_Z_SELECT2"       -> "ptr void"
  | "LAPACK_S_SELECT3"       -> "ptr void"
  | "LAPACK_D_SELECT3"       -> "ptr void"
  | _                        -> failwith "convert_typ_to_ctypes"


(* convert c types to corresponding types in extern *)
let convert_typ_to_extern = function
  | "int"                    -> "int"
  | "char"                   -> "char"
  | "float"                  -> "float"
  | "double"                 -> "float"
  | "lapack_int"             -> "int"
  | "lapack_logical"         -> "int"
  | "lapack_complex_float"   -> "Complex.t"
  | "lapack_complex_double"  -> "Complex.t"
  | "char*"                  -> "char ptr"
  | "float*"                 -> "float ptr"
  | "double*"                -> "float ptr"
  | "lapack_int*"            -> "int ptr"
  | "lapack_logical*"        -> "int ptr"
  | "lapack_complex_float*"  -> "Complex.t ptr"
  | "lapack_complex_double*" -> "Complex.t ptr"
  (* FIXME ? *)
  | "LAPACK_C_SELECT1"       -> "unit ptr"
  | "LAPACK_Z_SELECT1"       -> "unit ptr"
  | "LAPACK_S_SELECT2"       -> "unit ptr"
  | "LAPACK_D_SELECT2"       -> "unit ptr"
  | "LAPACK_C_SELECT2"       -> "unit ptr"
  | "LAPACK_Z_SELECT2"       -> "unit ptr"
  | "LAPACK_S_SELECT3"       -> "unit ptr"
  | "LAPACK_D_SELECT3"       -> "unit ptr"
  | _                        -> failwith "convert_typ_to_extern"


let _get_content h =
  let s = ref "" in
  (
    try while true do
      s := !s ^ "\n" ^ input_line h;
    done with End_of_file -> ()
  );
  !s


(* check is it ???_work function *)
let is_work_fun s =
  let regex = Str.regexp "_work(" in
  try
    Str.search_forward regex s 0 |> ignore;
    true
  with Not_found -> false


(* parse through the lapacke header file, filter out the functions we want
  to interface to.
 *)
let parse_cblas_header fname =
  let h = open_in fname in
  let s = _get_content h in

  let regex = Str.regexp "^[^ ]+[ ]+cblas_[^;]+;" in
  let ofs = ref 0 in
  let funs = ref [||] in
  (
    try while true do
      let _ofs = Str.search_forward regex s !ofs in
      let _s = Str.matched_group 0 s in
      ofs := _ofs + (String.length _s);

      (* only accept high-level function *)
      let regex = Str.regexp "[ \n]+" in
      let _s = Str.global_replace regex " " _s in
      funs := Array.append !funs [|_s|]
    done with exn -> ()
  );
  (* FIXME : DEBUG *)
  (* funs := Array.sub !funs 0 0; *)
  !funs


(* convert function arguments into a list of arg record *)
let process_args_to_argrec s =
  let regex = Str.regexp "\\(const\\)*[ ]*\\([^ ]+\\)" in
  let regex0 = Str.regexp "const" in
  let regex1 = Str.regexp "[ ]+" in
  Str.split (Str.regexp ",") s
  |> List.map (fun arg ->
    let arg = String.trim arg in
    print_endline arg; flush_all();
    let _ = Str.search_forward regex arg 0 in
    let _const = Str.matched_group 1 arg in
    let _var_typ = Str.matched_group 2 arg in
    Printf.printf "c:%s t:%s\n" _const _var_typ;
    flush_all ();

    let arg = Str.global_replace regex0 "" arg in
    let args = Str.split regex1 arg |> Array.of_list in
    assert (Array.length args = 2);
    make_arg args.(0) args.(1)
  )
  |> Array.of_list



(* FOR CTYPES INTERFACE FILE *)


(* convert argrec to ctype string, also append returning value *)
let convert_argrec_to_ctypes args =
  let s = Array.fold_left (fun a arg ->
    let ctyp = convert_typ_to_ctypes arg.typ in
    a ^ ctyp ^ " @-> ") "" args in
  "( " ^ s ^ "returning int )"


(* convert the list of functions into ctypes-compatible interfaces *)
let convert_to_ctypes_fun funs =
  let regex = Str.regexp "^[^ ]+[ ]+cblas_\\([^(]+\\)(\\([^;]+\\));" in

  Array.map (fun s ->
    let _ = Str.search_forward regex s 0 in
    let _fun_name = Str.matched_group 1 s in
    let _fun_args = Str.matched_group 2 s in
    let args = process_args_to_argrec _fun_args in
    let args = convert_argrec_to_ctypes args in

    (* assemble the function string *)
    let fun_s = Printf.sprintf
      "  let %s = foreign \"cblas_%s\" %s\n" _fun_name _fun_name args
    in
    fun_s
  ) funs


(* convert the list of functions into extern c interfaces *)
let convert_to_ctypes_fun funs =
  let regex = Str.regexp "^[^ ]+[ ]+cblas_\\([^(]+\\)(\\([^;]+\\));" in

  Array.map (fun s ->
    let _ = Str.search_forward regex s 0 in
    let _fun_name = Str.matched_group 1 s in
    let _fun_args = Str.matched_group 2 s in
    let args = process_args_to_argrec _fun_args in
    let args_s = convert_argrec_to_ctypes args in

    (* assemble the function string *)
    let fun_s = Printf.sprintf
      "  let %s = foreign \"cblas_%s\" %s\n" _fun_name _fun_name args_s
    in
    fun_s
  ) funs


let convert_cblas_header_to_ctypes fname funs =
  let h = open_out fname in
  Printf.fprintf h "(* auto-generated lapacke interface file, timestamp:%.0f *)\n\n" (Unix.gettimeofday ());
  Printf.fprintf h "open Ctypes\n\n";
  Printf.fprintf h "module Bindings (F : Cstubs.FOREIGN) = struct\n\n";
  Printf.fprintf h "  open F\n\n";

  Array.iter (fun s ->
    Printf.fprintf h "%s\n" s;
  ) (convert_to_ctypes_fun funs);
  Printf.fprintf h "end";

  close_out h



(* FOR EXTERN INTERFACE FILE *)

let convert_argrec_to_extern args =
  let s = Array.fold_left (fun a arg ->
    let ctyp = convert_typ_to_extern arg.typ in
    a ^ ctyp ^ " -> ") "" args in
    s ^ "unit "


let convert_to_extern_fun funs =
  let regex = Str.regexp "^lapack_int LAPACKE_\\([^(]+\\)(\\([^;]+\\));" in

  Array.mapi (fun i s ->
    let _ = Str.search_forward regex s 0 in
    let _fun_name = Str.matched_group 1 s in
    let _fun_args = Str.matched_group 2 s in
    let args = process_args_to_argrec _fun_args in
    let args_s = convert_argrec_to_extern args in

    (* NOTE: naming needs to be consistent with Ctypes *)
    let fun_native_s = Printf.sprintf "owl_stub_%i_LAPACKE_%s" (i + 1) _fun_name in
    let fun_byte_s = Printf.sprintf "owl_stub_%i_LAPACKE_%s_byte%i" (i + 1) _fun_name (Array.length args) in
    let fun_extern_s =
      match Array.length args < 6 with
      | true  -> Printf.sprintf "\"%s\"" fun_native_s
      | false -> Printf.sprintf "\"%s\" \"%s\"" fun_byte_s fun_native_s
    in
    (* assemble the function string *)
    let fun_s = Printf.sprintf
      "external %s\n  : %s\n = %s\n" _fun_name args_s fun_extern_s
    in
    fun_s
  ) funs


let convert_cblas_header_to_extern fname funs =
  let h = open_out fname in
  Printf.fprintf h "(* auto-generated lapacke interface file, timestamp:%.0f *)\n\n" (Unix.gettimeofday ());
  Printf.fprintf h "open Ctypes\n\n";

  Array.iter (fun s ->
    Printf.fprintf h "%s\n" s;
  ) (convert_to_extern_fun funs);

  close_out h


let _ =
  if Array.length Sys.argv = 1 then
    print_help ()
  else (
    let header_file = Sys.argv.(1) in
    let ctypes_file = Sys.argv.(2) in
    let binding_file = Sys.argv.(3) in

    let funs = parse_cblas_header header_file in
    convert_cblas_header_to_ctypes ctypes_file funs;
    convert_cblas_header_to_extern binding_file funs;
)
