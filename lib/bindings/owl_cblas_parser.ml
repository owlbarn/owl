let copyright =
"(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)
"

(* This app parses cblas.h file *)

type arg = {
  mutable typ  : string;
  mutable name : string;
}

let make_arg typ name = { typ; name }


let print_help () = print_endline "Usage: EXE cblas.h ctypes_output_file binding_output_file"


let convert_rval_to_ctypes = function
  | "float"       -> "returning float"
  | "double"      -> "returning double"
  | "void"        -> "returning void"
  | "CBLAS_INDEX" -> "returning size_t"
  |  _            -> failwith "convert_typ_to_ctypes"


let convert_rval_to_extern = function
  | "float"       -> "float"
  | "double"      -> "float"
  | "void"        -> "unit"
  | "CBLAS_INDEX" -> "Unsigned.size_t"
  |  _            -> failwith "convert_rval_to_extern"


let convert_typ_to_ctypes fun_blas typ_name =
  match typ_name with
  | "int"                    -> "int"
  | "float"                  -> "float"
  | "double"                 -> "double"
  | "float*"                 -> "ptr float"
  | "double*"                -> "ptr double"
  | "void*"                  -> (
      let prefix8 = Str.string_before fun_blas 8 in
      let prefix7 = Str.string_before fun_blas 7 in

      if prefix8 = "cblas_sc" then "ptr complex32"
      else if prefix8 = "cblas_dz" then "ptr complex64"
      else if prefix8 = "cblas_ic" then "ptr complex32"
      else if prefix8 = "cblas_iz" then "ptr complex64"
      else (
        match prefix7 with
        | "cblas_c" -> "ptr complex32"
        | "cblas_z" -> "ptr complex64"
        | _         -> failwith "convert_typ_to_ctypes:void"
      )
    )
  | "CBLAS_ORDER"            -> "int"
  | "CBLAS_TRANSPOSE"        -> "int"
  | "CBLAS_UPLO"             -> "int"
  | "CBLAS_DIAG"             -> "int"
  | "CBLAS_SIDE"             -> "int"
  | _                        -> failwith "convert_typ_to_ctypes"


(* convert c types to corresponding types in extern *)
let convert_typ_to_extern = function
  | "int"                    -> "int"
  | "float"                  -> "float"
  | "double"                 -> "float"
  | "float*"                 -> "_ CI.fatptr"
  | "double*"                -> "_ CI.fatptr"
  | "void*"                  -> "_ CI.fatptr"
  | "CBLAS_ORDER"            -> "int"
  | "CBLAS_TRANSPOSE"        -> "int"
  | "CBLAS_UPLO"             -> "int"
  | "CBLAS_DIAG"             -> "int"
  | "CBLAS_SIDE"             -> "int"
  | _                        -> failwith "convert_typ_to_extern"


let convert_typ_to_caml = function
  | "int"             -> "int"
  | "float"           -> "float"
  | "double"          -> "float"
  | "float*"          -> "(float ptr)"
  | "double*"         -> "(float ptr)"
  | "void*"           -> "(Complex.t ptr)"
  | "CBLAS_ORDER"     -> "int"
  | "CBLAS_TRANSPOSE" -> "int"
  | "CBLAS_UPLO"      -> "int"
  | "CBLAS_DIAG"      -> "int"
  | "CBLAS_SIDE"      -> "int"
  | _                 -> failwith "convert_typ_to_caml"


let _get_content h =
  let s = ref "" in
  (
    try while true do
      s := !s ^ "\n" ^ (input_line h |> String.trim);
    done with End_of_file -> ()
  );
  !s


(* parse through the lapacke header file, filter out the functions we want
  to interface to.
 *)
let parse_cblas_binding fname =
  let h = open_in fname in
  let s = _get_content h in

  let regex = Str.regexp "[ ]*\\([^ \n]+\\)[ ]+\\(cblas_[^(]+\\)(\\([^;]+\\));" in
  let ofs = ref 0 in
  let funs = ref [||] in
  (
    try while true do
      let _ofs = Str.search_forward regex s !ofs in
      let _s = Str.matched_group 0 s in
      ofs := _ofs + (String.length _s);

      let _fun_rval = Str.matched_group 1 s in
      let _fun_blas = Str.matched_group 2 s in
      let _typ_name = Str.matched_group 3 s
        |> Str.global_replace (Str.regexp "[ \n]+") " "
      in
      let _fun_caml = _fun_blas
        |> Str.global_replace (Str.regexp "cblas_") ""
        |> Str.global_replace (Str.regexp "_sub") ""
      in
      (* Printf.printf "%s @ %s @ %s\n" _fun_blas _fun_caml _typ_name; flush_all (); *)

      (* only accept high-level function *)
      if _fun_blas <> "cblas_xerbla" then
        funs := Array.append !funs [|_fun_caml, _fun_blas, _typ_name, _fun_rval|]
    done with exn -> ()
  );
  !funs


(* convert function arguments into a list of arg record *)
let process_args_to_argrec s =
  Str.split (Str.regexp ",") s
  |> List.map (fun arg ->
    let arg = arg
      |> Str.global_replace (Str.regexp " \\*") "* "
      |> Str.global_replace (Str.regexp "const") ""
      |> Str.global_replace (Str.regexp "enum") ""
      |> String.trim
      |> Str.split (Str.regexp " ")
      |> Array.of_list
    in
    assert (Array.length arg = 2);
    make_arg arg.(0) arg.(1)
  )
  |> Array.of_list



(* FOR CTYPES INTERFACE FILE *)

let convert_argrec_to_ctypes fun_blas fun_rval args =
  let s = Array.fold_left (fun a arg ->
    let ctyp = convert_typ_to_ctypes fun_blas arg.typ in
    a ^ ctyp ^ " @-> ") "" args in
    s ^ (convert_rval_to_ctypes fun_rval)


let convert_to_ctypes_fun funs =
  Array.mapi (fun i (_fun_caml, _fun_blas, _typ_s, _fun_rval) ->

    let args = process_args_to_argrec _typ_s in
    let args_s = convert_argrec_to_ctypes _fun_blas _fun_rval args in
    (* assemble the function string *)
    let fun_s = Printf.sprintf
      "let cblas_%s = foreign \"%s\" (%s)\n" _fun_caml _fun_blas args_s
    in
    fun_s
  ) funs


let convert_cblas_header_to_ctypes fname funs =
  let h_ml = open_out fname in
  Printf.fprintf h_ml "%s\n" copyright;
  Printf.fprintf h_ml "(* auto-generated cblas interface file, timestamp:%.0f *)\n\n" (Unix.gettimeofday ());
  Printf.fprintf h_ml "open Ctypes\n\n";
  Printf.fprintf h_ml "module Bindings (F : Cstubs.FOREIGN) = struct\n\n  open F\n\n";

  Array.iter (fun fun_s ->
    Printf.fprintf h_ml "  %s\n" fun_s;
  ) (convert_to_ctypes_fun funs);

  Printf.fprintf h_ml "end\n\n";
  close_out h_ml



(* FOR EXTERN INTERFACE FILE *)

let convert_argrec_to_extern fun_rval args =
  let s = Array.fold_left (fun a arg ->
    let ctyp = convert_typ_to_extern arg.typ in
    a ^ ctyp ^ " -> ") "" args in
    s ^ (convert_rval_to_extern fun_rval)


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
      if String.get t (String.length t - 1) = '*' then
        Printf.sprintf "(CI.cptr %s)" s
      else s
    in
    Printf.sprintf "%s %s" a s
  ) "" args
  in
  Printf.sprintf "let %s%s =\n  cblas_%s%s\n" fun_caml arg_names fun_caml fun_param


let convert_argrec_to_vals fun_caml args fun_rval =
  let fun_param = Array.fold_left (fun a arg ->
    let s = String.trim arg.name |> String.lowercase_ascii in
    let t = String.trim arg.typ in
    let t = convert_typ_to_caml t in
    Printf.sprintf "%s %s:%s ->" a s t
  ) "" args
  in
  let fun_param = Printf.sprintf "%s %s" fun_param (convert_rval_to_extern fun_rval) in
  Printf.sprintf "val %s :%s \n" fun_caml fun_param


let convert_to_extern_fun funs =
  Array.mapi (fun i (_fun_caml, _fun_blas, _typ_s, _fun_rval) ->

    let args = process_args_to_argrec _typ_s in
    let args_s = convert_argrec_to_extern _fun_rval args in
    let args_l = Array.length args in

    (* NOTE: naming needs to be consistent with Ctypes *)
    let fun_native_s = Printf.sprintf "owl_stub_%i_%s" (i + 1) _fun_blas in
    let fun_byte_s = Printf.sprintf "owl_stub_%i_%s_byte%i" (i + 1) _fun_blas args_l in
    let fun_extern_s = match args_l < 6 with
      | true  -> Printf.sprintf "\"%s\"" fun_native_s
      | false -> Printf.sprintf "\"%s\" \"%s\"" fun_byte_s fun_native_s
    in
    (* assemble the function string *)
    let fun_stub_s = Printf.sprintf
      "external cblas_%s\n  : %s\n  = %s\n" _fun_caml args_s fun_extern_s
    in
    _fun_caml, fun_stub_s, args, _fun_rval
  ) funs


let convert_cblas_header_to_extern fname funs =
  let h_ml = open_out fname in
  Printf.fprintf h_ml "%s\n" copyright;
  Printf.fprintf h_ml "(* auto-generated cblas interface file, timestamp:%.0f *)\n\n" (Unix.gettimeofday ());
  Printf.fprintf h_ml "open Ctypes\n\n";
  Printf.fprintf h_ml "module CI = Cstubs_internals\n\n";

  Array.iter (fun (fun_caml, fun_stub_s, args, fun_rval) ->
    Printf.fprintf h_ml "%s\n" fun_stub_s;
  ) (convert_to_extern_fun funs);

  Array.iter (fun (fun_caml, fun_stub_s, args, fun_rval) ->
    Printf.fprintf h_ml "%s\n" (convert_argrec_to_caml fun_caml args);
  ) (convert_to_extern_fun funs);

  close_out h_ml;

  let h_mli = open_out (fname ^ "i") in
  Printf.fprintf h_mli "%s\n" copyright;
  Printf.fprintf h_mli "(* auto-generated cblas interface file, timestamp:%.0f *)\n\n" (Unix.gettimeofday ());
  Printf.fprintf h_mli "open Ctypes\n\n";

  Array.iter (fun (fun_caml, fun_stub_s, args, fun_rval) ->
    Printf.fprintf h_mli "%s\n" (convert_argrec_to_vals fun_caml args fun_rval);
  ) (convert_to_extern_fun funs);

  close_out h_mli


let _ =
  if Array.length Sys.argv = 1 then
    print_help ()
  else (
    let header_file = Sys.argv.(1) in
    let ctypes_file = Sys.argv.(2) in
    let out_ml_file = Sys.argv.(3) in

    let funs = parse_cblas_binding header_file in
    convert_cblas_header_to_ctypes ctypes_file funs;
    convert_cblas_header_to_extern out_ml_file funs
)
