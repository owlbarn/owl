open Owl_converter_types
open Owl_converter_utils

let create () =
  let value = Nodelist [|"node1"; "node2"|] in
  [| { col_key = "empty_collection"; col_value = value } |]


let col_to_string collection = collection.col_key

let to_string (collections : collection_pair array) =
  let collection_arr = Array.map (fun c ->
    col_to_string c
  ) collections
  in
  let collection_str = array_to_string (fun s -> s) collection_arr in
  Printf.sprintf "collection_def {%s}" collection_str
