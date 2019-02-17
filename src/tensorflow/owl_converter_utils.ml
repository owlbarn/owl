(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 * Copyright (c) 2019-2019 Jianxin Zhao <jianxin.zhao@cl.cam.ac.uk>
 *)

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


(* TODO: rewrite to more formal method.
 * Ref: https://goo.gl/ipu2gZ, https://goo.gl/ZtyGNj
 *)
let serialise_tensor_content dtype lst_str =
  (* format of lst_str: 5,5,1,32; dtype: int32/float32/... *)
  let cmd = Printf.sprintf "python -c 'import numpy as np; x = np.array([%s], dtype=np.%s); print(repr(x.tostring()))'" lst_str dtype in
  let str = syscall cmd in
  let len = String.length str in
  assert (len > 3);
  String.sub str 1 (len - 3) |> Bytes.of_string


let get_slice_param (idx : int list list) full_shp =
  let b = Array.make (List.length idx) 0 in
  let e = Array.make (List.length idx) 0 in
  (* not fancy slicing, so keep stride s to zeros for now *)
  let s = Array.make (List.length idx) 0 in
  List.iteri (fun i lst ->
    let arr = Array.of_list lst in
    let len = Array.length arr in
    if (len = 0) then (
      b.(i) <- 0;
      e.(i) <- full_shp.(i)
    ) else if (len = 1) then (
      b.(i) <- arr.(0);
      e.(i) <- full_shp.(i);
    ) else if (len = 2) then (
      b.(i) <- arr.(0);
      e.(i) <- arr.(0);
    ) else if (len > 2) then (
      failwith "Converter: slicing index format error"
    )
  ) idx;
  b, e, s
