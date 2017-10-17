(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let type_maps =
  (* MLTYP0, CLTYP0 *)
  [
    ("float32", "float");
    ("int32", "int")
  ]


let generate_type_specific_code type_map code =
  let mltyp0, cltyp0 = type_map in
  let regex0 = Str.regexp "MLTYP0" in
  let regex1 = Str.regexp "CLTYP0" in
  code |>
  Str.global_replace regex0 mltyp0 |>
  Str.global_replace regex1 cltyp0


let generate_all_types type_maps code =
  List.fold_left (fun s type_map ->
    s ^ (generate_type_specific_code type_map code)
  ) "" type_maps


let code () =
  let s0 = generate_all_types type_maps Owl_opencl_kernel_map.code in
  let s1 = "" in (* generate_all_types type_maps Owl_opencl_kernel_reduce.code in *)
  print_endline (s0 ^ s1); flush_all();
  s0 ^ s1
