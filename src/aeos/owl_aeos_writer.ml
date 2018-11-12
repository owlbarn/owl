(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_aeos_tuners


let copyright =
"/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */"


let write_full fname tuners =
  let fun_join_str =
    Array.fold_left (fun acc s ->
      Printf.sprintf "%s\n%s" acc s
    ) ""
  in
  let define_str = tuners
    |> Array.map to_string_array
    |> Array.map fun_join_str
    |> fun_join_str
  in
  let header_file_str = Printf.sprintf "%s%s" copyright define_str in
  Owl_io.write_file fname header_file_str


let write_partial fname tuners =
  if (Sys.file_exists fname = false) then (
    write_full fname Owl_aeos_tuners.all
  );
  let kv = ref [] in
  Array.iter (fun t ->
    let key = get_params t in
    let value = to_string_array t in
    let len_key = Array.length key in
    let len_val = Array.length value in
    assert (len_key = len_val);
    for i = 0 to len_key - 1 do
      kv := List.append !kv [(key.(i), value.(i))]
    done
  ) tuners;

  List.iter (fun (k, v) ->
    Owl_aeos_utils.replace_lines_in_file fname k v
  ) !kv
