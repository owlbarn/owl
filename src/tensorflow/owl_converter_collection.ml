(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Owl_converter_types
open Owl_converter_utils

let default_coll = Nodelist [|""|]


let create namelist =
  let h = Hashtbl.create 10 in
  Array.iter (fun n ->
    Hashtbl.add h n default_coll
  ) namelist;
  h


let get_coll = Array.get


let update h coll_name var =
  let c = Hashtbl.find h coll_name in
  let new_val =
    match c with
    | Nodelist c -> Nodelist (Array.append c [|var|])
    | _          -> failwith "unsupported"
  in
  Hashtbl.replace h coll_name new_val
  (* How can var be of multiple types here? *)


(* TODO: The seprator are actually not whitespace here. *)
let col_to_string coll_val =
  match coll_val with
  | Nodelist c  ->
      let s = Owl_utils_array.to_string ~sep:" " (fun x -> x) c in
      Printf.sprintf "string_list {\n%s}\n" s
  | Byteslist c ->
      let s = Owl_utils_array.to_string ~sep:" " Bytes.to_string c in
      Printf.sprintf "bytes_list {\n%s}\n" s
  | Floatlist c ->
      let s = Owl_utils_array.to_string ~sep:" " string_of_float c in
      Printf.sprintf "float_list {\n%s}\n" s


let coll_to_string collection =
  let k, v = collection in
  let v_str = col_to_string v in
  Printf.sprintf "collection_def {key: %s\n value {\n%s}\n}" k v_str


let to_string collections =
  let collections = htbl_to_arr collections in
  let coll_str = map_then_combine_string (fun (_, c) ->
    col_to_string c
  ) collections
  in
  Printf.sprintf "collection_def {%s}" coll_str
