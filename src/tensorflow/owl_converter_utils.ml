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
  (* not fancy slicing, so keep stride s to ones for now *)
  let s = Array.make (List.length idx) 1 in
  List.iteri (fun i lst ->
    let arr = Array.of_list lst in
    let len = Array.length arr in
    if (len = 0) then (
      b.(i) <- 0;
      e.(i) <- full_shp.(i) + 1;
    ) else if (len = 1) then (
      b.(i) <- arr.(0);
      e.(i) <- arr.(0) + 1;
    ) else if (len = 2) then (
      b.(i) <- arr.(0);
      e.(i) <- arr.(1) + 1;
    ) else if (len > 2) then (
      failwith "Converter: slicing index format error"
    )
  ) idx;
  b, e, s


(* A very rudimentary template *)
let generate_py_templated prefix =
  let s = Printf.sprintf "#!/usr/bin/env python

from __future__ import print_function

import numpy as np
import os
import tensorflow as tf
from google.protobuf import text_format
from tensorflow.python.framework import graph_io


def eval(meta_file):
  with tf.Graph().as_default():
    sess = tf.Session()
    saver = tf.train.import_meta_graph(meta_file)
    graph = tf.get_default_graph()
    init = tf.global_variables_initializer()
    sess.run(init)

    # get inputs
    # x = graph.get_tensor_by_name('x:0')
    # x_shp = sess.run(tf.shape(x))

    # get outputs
    # result = tf.get_collection('result')[0]

    # create input data
    # x_data  = np.ones(x_shp)

    # execute cgraph
    # y = sess.run(result, feed_dict={x:x_data})

    # return result
    # print(y)


filename = '%s'
with open(filename + '.pbtxt', 'r') as f:
    metagraph_def = tf.MetaGraphDef()
    file_content = f.read()
    text_format.Merge(file_content,metagraph_def)
    graph_io.write_graph(metagraph_def,
        os.path.dirname(filename),
        os.path.basename(filename) + '.pb',
        as_text=False)


y = eval(filename + '.pb')
" prefix
  in
  Owl_io.write_file (prefix ^ ".py") s
