(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_aeos_types


let copyright =
"/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */"


let c_header_file fname tuners =
  let define_str = tuners
    |> Array.map (function
      | Sin t -> Owl_aeos_tuner_sin.(Printf.sprintf "#define %s %s" t.c_macro (to_string t))
      | Cos t -> Owl_aeos_tuner_cos.(Printf.sprintf "#define %s %s" t.c_macro (to_string t))
    )
    |> Array.fold_left (fun acc s ->
      Printf.sprintf "%s\n\n%s" acc s
    ) ""
  in
  let header_file_str = Printf.sprintf "%s%s" copyright define_str in
  Owl_io.write_file fname header_file_str
