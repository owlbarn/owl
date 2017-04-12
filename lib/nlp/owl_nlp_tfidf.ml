(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let build_from_file file_name = None

let doc_freq d tl =
  Log.info "start doc_freq ...";
  let n = Owl_nlp_vocabulary.size d in
  let df = Hashtbl.create n in
  let _h = Hashtbl.create 1024 in
  Array.iteri (fun i doc ->
    Hashtbl.reset _h;
    List.iter (fun token ->
      match Hashtbl.mem _h token with
      | true  -> ()
      | false -> Hashtbl.add _h token 0
    ) doc;
    Hashtbl.iter (fun token _ ->
      match Hashtbl.mem df token with
      | true  ->
          let freq = Hashtbl.find df token in
          Hashtbl.replace df token (freq + 1)
      | false -> Hashtbl.add df token 0
    ) _h
  ) tl;
  Log.info "done ...";
  df
