(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type arg = {
  mutable typ  : string;
  mutable name : string;
}

let make_arg typ name = { typ; name }


let print_help () = print_endline "Usage: EXE lapacke.h"


(* convert c types to corresponding types in ctypes *)
let convert_typ_to_ctyp = function
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
  (* FIXME *)
  | "LAPACK_C_SELECT1"       -> "ptr void"
  | "LAPACK_Z_SELECT1"       -> "ptr void"
  | "LAPACK_S_SELECT2"       -> "ptr void"
  | "LAPACK_D_SELECT2"       -> "ptr void"
  | "LAPACK_C_SELECT2"       -> "ptr void"
  | "LAPACK_Z_SELECT2"       -> "ptr void"
  | "LAPACK_S_SELECT3"       -> "ptr void"
  | "LAPACK_D_SELECT3"       -> "ptr void"
  | _                        -> failwith "convert_typ_to_ctyp"


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
let parse_lapacke_header fname =
  let h = open_in fname in
  let s = _get_content h in

  let regex = Str.regexp "^lapack_int [^;]+;" in
  let ofs = ref 0 in
  let funs = ref [||] in
  (
    try while true do
      let _ofs = Str.search_forward regex s !ofs in
      let _s = Str.matched_group 0 s in
      ofs := _ofs + (String.length _s);

      (* only accept high-level function *)
      match is_work_fun _s with
      | true -> ()
      | false -> (
          let regex = Str.regexp "[ \n]+" in
          let _s = Str.global_replace regex " " _s in
          funs := Array.append !funs [|_s|]
        )
    done with exn -> ()
  );
  (* funs := Array.sub !funs 0 100; *)
  !funs


(* convert function arguments into a list of arg record *)
let process_args_to_argrec s =
  let regex0 = Str.regexp "const" in
  let regex1 = Str.regexp "[ ]+" in
  Str.split (Str.regexp ",") s
  |> List.map (fun arg ->
    let arg = Str.global_replace regex0 "" arg in
    let args = Str.split regex1 arg |> Array.of_list in
    assert (Array.length args = 2);
    make_arg args.(0) args.(1)
  )
  |> Array.of_list


(* convert argrec to ctype string, also append returning value *)
let convert_argrec_to_ctypes args =
  let s = Array.fold_left (fun a arg ->
    let ctyp = convert_typ_to_ctyp arg.typ in
    a ^ ctyp ^ " @-> ") "" args in
  "( " ^ s ^ "returning int )"


(* convert the list of functions into ctypes-compatible interfaces *)
let convert_to_ctypes_fun funs =
  let regex = Str.regexp "^lapack_int LAPACKE_\\([^(]+\\)(\\([^;]+\\));" in

  Array.iter (fun s ->
    let _ = Str.search_forward regex s 0 in
    let _fun_name = Str.matched_group 1 s in
    let _fun_args = Str.matched_group 2 s in
    let args = process_args_to_argrec _fun_args in
    let args = convert_argrec_to_ctypes args in

    (* assemble the function string *)
    let fun_s = Printf.sprintf
      "  let %s = foreign \"LAPACKE_%s\" %s\n" _fun_name _fun_name args
    in
    print_endline fun_s
  ) funs


let convert_lapacke_header funs =
  Printf.printf "(* auto-generated lapacke interface file *)\n\n";
  Printf.printf "open Ctypes\n\n";
  Printf.printf "module Bindings (F : Cstubs.FOREIGN) = struct\n\n";
  Printf.printf "  open F\n\n";
  convert_to_ctypes_fun funs;
  Printf.printf "end"


let _ =
  if Array.length Sys.argv = 1 then
    print_help ()
  else (
    let fname = Sys.argv.(1) in
    let funs = parse_lapacke_header fname in
    convert_lapacke_header funs
)
