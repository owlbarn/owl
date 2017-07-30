(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

let process_dir_zoo gist =
  let dir = Sys.getenv "HOME" ^ "/.owl/zoo/" ^ gist in
  (* only include ml files *)
  Sys.readdir (dir)
  |> Array.to_list
  |> List.filter (fun s -> Filename.check_suffix s "ml")
  |> List.iter (fun l ->
      let f = Printf.sprintf "%s/%s" dir l in
      Topdirs.dir_use Format.std_formatter f
    )


let add_dir_zoo () =
  Hashtbl.add Toploop.directive_table "zoo"
  (Toploop.Directive_string process_dir_zoo)


let load_libs () =

    Topdirs.dir_directory "/Users/liang/.opam/4.04.0/lib/findlib/";
    Topdirs.dir_load Format.err_formatter ("/Users/liang/.opam/4.04.0/lib/findlib/findlib.cma");
    Topdirs.dir_load Format.err_formatter ("/Users/liang/.opam/4.04.0/lib/findlib/findlib_top.cma");
    print_endline "+++"

  (*
  Topdirs.dir_directory "/Users/liang/.opam/4.04.0/lib/ctypes";
  Topdirs.dir_load Format.std_formatter "ctypes.cma";
  Topdirs.dir_directory "/Users/liang/.opam/4.04.0/lib/owl";
  Topdirs.dir_load Format.std_formatter "owl.cma"
  *)


let _ =
  add_dir_zoo ()
