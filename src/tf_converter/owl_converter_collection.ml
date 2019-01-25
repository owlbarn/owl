(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_types
open Owl_converter_utils

let create () = [| |]


let col_to_string collection =
  match collection with
  | Nodelist c  -> c.(0)
  | Byteslist c -> Bytes.to_string c.(0)
  | Floatlist c -> string_of_float c.(0)


let to_string collections =
  let coll_str = map_then_combine_string (fun (_, c) ->
    col_to_string c
  ) collections
  in
  Printf.sprintf "collection_def {%s}" coll_str
