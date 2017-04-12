(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let build_from_file file_name = None

let doc_freq d tl =
  let n = Owl_nlp_vocabulary.size d in
  let df = Hashtbl.create n in
  List.iteri (fun i tokens ->

  ) tl
