let copyright =
"(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)
"

(* This app parses lapacke.h file *)

type arg = {
  mutable typ  : string;
  mutable name : string;
}

let make_arg typ name = { typ; name }


let print_help () = print_endline "Usage: EXE lapacke.h ctypes_output_file binding_output_file"


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
  | "char*"                  -> "_ CI.fatptr"
  | "float*"                 -> "_ CI.fatptr"
  | "double*"                -> "_ CI.fatptr"
  | "lapack_int*"            -> "_ CI.fatptr"
  | "lapack_logical*"        -> "_ CI.fatptr"
  | "lapack_complex_float*"  -> "_ CI.fatptr"
  | "lapack_complex_double*" -> "_ CI.fatptr"
  (* FIXME ? *)
  | "LAPACK_C_SELECT1"       -> "_ CI.fatptr"
  | "LAPACK_Z_SELECT1"       -> "_ CI.fatptr"
  | "LAPACK_S_SELECT2"       -> "_ CI.fatptr"
  | "LAPACK_D_SELECT2"       -> "_ CI.fatptr"
  | "LAPACK_C_SELECT2"       -> "_ CI.fatptr"
  | "LAPACK_Z_SELECT2"       -> "_ CI.fatptr"
  | "LAPACK_S_SELECT3"       -> "_ CI.fatptr"
  | "LAPACK_D_SELECT3"       -> "_ CI.fatptr"
  | _                        -> failwith "convert_typ_to_extern"


let convert_typ_to_caml = function
  | "int"                    -> "int"
  | "char"                   -> "char"
  | "float"                  -> "float"
  | "double"                 -> "float"
  | "lapack_complex_float"   -> "Complex.t"
  | "lapack_complex_double"  -> "Complex.t"
  | "lapack_int"             -> "int"
  | "lapack_logical"         -> "int"
  | "char*"                  -> "(char ptr)"
  | "float*"                 -> "(float ptr)"
  | "double*"                -> "(float ptr)"
  | "lapack_complex_float*"  -> "(Complex.t ptr)"
  | "lapack_complex_double*" -> "(Complex.t ptr)"
  | "lapack_int*"            -> "(int32 ptr)"
  | "lapack_logical*"        -> "(int32 ptr)"
  | "LAPACK_C_SELECT1"       -> "(unit ptr)"
  | "LAPACK_Z_SELECT1"       -> "(unit ptr)"
  | "LAPACK_S_SELECT2"       -> "(unit ptr)"
  | "LAPACK_D_SELECT2"       -> "(unit ptr)"
  | "LAPACK_C_SELECT2"       -> "(unit ptr)"
  | "LAPACK_Z_SELECT2"       -> "(unit ptr)"
  | "LAPACK_S_SELECT3"       -> "(unit ptr)"
  | "LAPACK_D_SELECT3"       -> "(unit ptr)"
  | _                        -> failwith "convert_typ_to_caml"


let _get_content h =
  let s = ref "" in
  (
    try while true do
      s := !s ^ "\n" ^ input_line h;
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


(* check is it ???_work function *)
let is_work_fun s =
  let regex = Str.regexp "_work(" in
  try
    Str.search_forward regex s 0 |> ignore;
    true
  with Not_found -> false


let is_in_funlist t s =
  let regex = Str.regexp "^lapack_int LAPACKE_\\([^(]+\\)(\\([^;]+\\));" in
  let s = String.trim s in
  let _ = Str.search_forward regex s 0 in
  let _fun_name = Str.matched_group 1 s in
  Hashtbl.mem t _fun_name


(* parse through the lapacke header file, filter out the functions we want
  to interface to.
 *)
 let parse_lapacke_header fname =
   let h = open_in fname in
   let s = _get_content h in
   let t = _get_funlist "lapacke_funlist.txt" in

   let regex = Str.regexp "^lapack_int [^;]+;" in
   let ofs = ref 0 in
   let funs = ref [||] in
   (
     try while true do
       let _ofs = Str.search_forward regex s !ofs in
       let _s = Str.matched_group 0 s in

       (* only accept high-level function *)
       if is_work_fun _s = false then (
         let regex = Str.regexp "[ \n]+" in
         let _s = Str.global_replace regex " " _s in
         if is_in_funlist t _s = true then
          funs := Array.append !funs [|_s|]
        );

        ofs := _ofs + (String.length _s);
     done with exn -> ()
   );
   (* FIXME : DEBUG *)
   (* funs := Array.sub !funs 0 1; *)
   !funs


(* convert function arguments into a list of arg record *)
let process_args_to_argrec s =
  Str.split (Str.regexp ",") s
  |> List.map (fun arg ->
    let args = arg
      |> Str.global_replace (Str.regexp "const") ""
      |> Str.global_replace (Str.regexp "type") "typ"
      |> Str.global_replace (Str.regexp "matrix_layout") "layout"
      |> String.trim
      |> Str.split (Str.regexp "[ ]+")
      |> Array.of_list
    in
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
  let regex = Str.regexp "^lapack_int LAPACKE_\\([^(]+\\)(\\([^;]+\\));" in

  Array.map (fun s ->
    let _ = Str.search_forward regex s 0 in
    let _fun_name = Str.matched_group 1 s in
    let _fun_args = Str.matched_group 2 s in
    let args = process_args_to_argrec _fun_args in
    let args = convert_argrec_to_ctypes args in

    (* assemble the function string *)
    let fun_s = Printf.sprintf
      "  let %s = foreign \"LAPACKE_%s\" %s\n" _fun_name _fun_name args
    in
    fun_s
  ) funs


(* convert the list of functions into extern c interfaces *)
let convert_to_ctypes_fun funs =
  let regex = Str.regexp "^lapack_int LAPACKE_\\([^(]+\\)(\\([^;]+\\));" in

  Array.map (fun s ->
    let _ = Str.search_forward regex s 0 in
    let _fun_name = Str.matched_group 1 s in
    let _fun_args = Str.matched_group 2 s in
    let args = process_args_to_argrec _fun_args in
    let args_s = convert_argrec_to_ctypes args in

    (* assemble the function string *)
    let fun_s = Printf.sprintf
      "  let %s = foreign \"LAPACKE_%s\" %s\n" _fun_name _fun_name args_s
    in
    fun_s
  ) funs


let convert_lapacke_header_to_ctypes fname funs =
  let h = open_out fname in
  Printf.fprintf h "(** auto-generated lapacke interface file, timestamp:%.0f *)\n\n" (Unix.gettimeofday ());
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
    s ^ "int "


let convert_argrec_to_caml fun_caml args =
  let arg_names = Array.fold_left (fun a arg ->
    let s = String.trim arg.name |> String.lowercase_ascii in
    Printf.sprintf "%s ~%s" a s
  ) "" args
  in
  let fun_param = Array.fold_left (fun a arg ->
    let s = String.trim arg.name |> String.lowercase_ascii in
    let t = String.trim arg.typ in
    let s =
      (* this is for LAPACK_X_SELECTX cases *)
      if (String.length t > 7) && (Str.string_before t 7 = "LAPACK_") then
        Printf.sprintf "(CI.cptr %s)" s
      else if String.get t (String.length t - 1) = '*' then
        Printf.sprintf "(CI.cptr %s)" s
      else s
    in
    Printf.sprintf "%s %s" a s
  ) "" args
  in
  Printf.sprintf "let %s%s =\n  lapacke_%s%s\n" fun_caml arg_names fun_caml fun_param


let convert_argrec_to_vals fun_caml args =
  let fun_param = Array.fold_left (fun a arg ->
    let s = String.trim arg.name |> String.lowercase_ascii in
    let t = String.trim arg.typ in
    let t = convert_typ_to_caml t in
    Printf.sprintf "%s %s:%s ->" a s t
  ) "" args
  in
  let fun_param = Printf.sprintf "%s int" fun_param in
  Printf.sprintf "val %s :%s \n" fun_caml fun_param


let convert_to_extern_fun funs =
  let regex = Str.regexp "^lapack_int LAPACKE_\\([^(]+\\)(\\([^;]+\\));" in

  Array.mapi (fun i s ->
    let _ = Str.search_forward regex s 0 in
    let _fun_caml = Str.matched_group 1 s in
    let _fun_args = Str.matched_group 2 s in
    let args = process_args_to_argrec _fun_args in
    let args_s = convert_argrec_to_extern args in

    (* NOTE: naming needs to be consistent with Ctypes *)
    let fun_native_s = Printf.sprintf "owl_stub_%i_LAPACKE_%s" (i + 1) _fun_caml in
    let fun_byte_s = Printf.sprintf "owl_stub_%i_LAPACKE_%s_byte%i" (i + 1) _fun_caml (Array.length args) in
    let fun_extern_s =
      match Array.length args < 6 with
      | true  -> Printf.sprintf "\"%s\"" fun_native_s
      | false -> Printf.sprintf "\"%s\" \"%s\"" fun_byte_s fun_native_s
    in
    (* assemble the function string *)
    let fun_stub_s = Printf.sprintf
      "external lapacke_%s\n  : %s\n  = %s\n" _fun_caml args_s fun_extern_s
    in
    _fun_caml, fun_stub_s, args
  ) funs


let convert_lapacke_header_to_extern fname funs =
  let h_ml = open_out fname in
  Printf.fprintf h_ml "%s\n" copyright;
  Printf.fprintf h_ml "(** auto-generated lapacke interface file, timestamp:%.0f *)\n\n" (Unix.gettimeofday ());
  Printf.fprintf h_ml "open Ctypes\n\n";
  Printf.fprintf h_ml "module CI = Cstubs_internals\n\n";

  Array.iter (fun (fun_caml, fun_stub_s, args) ->
    Printf.fprintf h_ml "%s\n" fun_stub_s;
  ) (convert_to_extern_fun funs);

  Array.iter (fun (fun_caml, fun_stub_s, args) ->
    Printf.fprintf h_ml "%s\n" (convert_argrec_to_caml fun_caml args);
  ) (convert_to_extern_fun funs);

  close_out h_ml;

  let h_mli = open_out (fname ^ "i") in
  Printf.fprintf h_mli "%s\n" copyright;
  Printf.fprintf h_mli "(** LAPACKE interface: low-level interface to the LAPACKE functions *) \n\n";
  Printf.fprintf h_mli "(** auto-generated lapacke interface file, timestamp:%.0f *)\n\n" (Unix.gettimeofday ());
  Printf.fprintf h_mli "open Ctypes\n\n";

  Array.iter (fun (fun_caml, fun_stub_s, args) ->
    let val_s = convert_argrec_to_vals fun_caml args in
    Printf.fprintf h_mli "%s\n" val_s;
  ) (convert_to_extern_fun funs);

  close_out h_mli


let _ =
  if Array.length Sys.argv = 1 then
    print_help ()
  else (
    let header_file = Sys.argv.(1) in
    let ctypes_file = Sys.argv.(2) in
    let binding_file = Sys.argv.(3) in

    let funs = parse_lapacke_header header_file in
    convert_lapacke_header_to_ctypes ctypes_file funs;
    convert_lapacke_header_to_extern binding_file funs;
)
