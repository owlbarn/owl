#!/usr/bin/env ocaml
#use "topfind"
#require "topkg-jbuilder"

open Topkg

let () =
  let opams =
    let install = false in [
        Pkg.opam_file ~install "owl-base.opam";
        Pkg.opam_file ~install "owl.opam";
        Pkg.opam_file ~install "owl-zoo.opam";
        Pkg.opam_file ~install "owl-top.opam";
      ]
  in
  Pkg.describe ~opams "owl-base"
  @@ fun c ->
     match Conf.pkg_name c with
     | ( "owl-base" | "owl" | "owl-zoo" | "owl-top")  as n
       -> Ok [ Pkg.lib (n ^ ".opam") ~dst:"opam"; ]
     | other
       -> R.error_msgf "unknown package name: %s" other
