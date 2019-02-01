(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let map_then_combine_string ?(sep=" ") fn x =
  let mapped = Array.map fn x in
  Owl_utils_array.to_string ~sep (fun x -> x) mapped


let htbl_to_arr htbl =
  Hashtbl.fold (fun k v acc ->
    Array.append acc [| (k,v) |]
  ) htbl [| |]
