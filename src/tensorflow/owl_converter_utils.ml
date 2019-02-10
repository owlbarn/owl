(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* ...actually a useless wrapper *)
let map_then_combine_string ?(sep="") fn x =
  Owl_utils_array.to_string ~sep fn x


let htbl_to_arr htbl =
  Hashtbl.fold (fun k v acc ->
    Array.append acc [| (k,v) |]
  ) htbl [| |]


let syscall cmd =
  let ic, oc = Unix.open_process cmd in
  let buf = Buffer.create 50 in
  (
    try
      while true do
        Buffer.add_channel buf ic 1
      done
    with End_of_file -> ()
  );
  Unix.close_process (ic, oc) |> ignore;
  Buffer.contents buf


(* TODO: still have issues; rewrite to more formal method. Ref: https://goo.gl/ipu2gZ
 * https://github.com/tensorflow/tensorflow/blob/master/tensorflow/python/framework/tensor_util_test.py
 *)
let serialise_tensor_content dtype lst_str =
  (* format of lst_str: 5,5,1,32; dtype: int32/float32/... *)
  let cmd = Printf.sprintf "python -c 'import numpy as np; x = np.array([%s], dtype=np.%s); print(repr(x.tostring()))'" lst_str dtype in
  let str = syscall cmd in
  let len = String.length str in
  assert (len > 3);
  String.sub str 1 (len - 3)
