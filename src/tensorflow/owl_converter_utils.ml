(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 * Copyright (c) 2019-2019 Jianxin Zhao <jianxin.zhao@cl.cam.ac.uk>
 *)

(* ...actually a useless wrapper *)
let map_then_combine_string ?(sep="") fn x =
  Owl_utils_array.to_string ~sep fn x


let htbl_to_arr htbl =
  Hashtbl.fold (fun k v acc ->
    Array.append acc [| (k,v) |]
  ) htbl [| |]
