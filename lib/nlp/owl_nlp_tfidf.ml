(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* weird, I need to initialise this again? *)
let _ = Log.color_on (); Log.(set_log_level INFO)

type t = {
  mutable model_uri : string;          (* file path of the model *)
  mutable doc_freq  : float array;      (* document frequency *)
  mutable corpus    : Owl_nlp_corpus.t  (* corpus type *)
}

let create corpus =
  let text_uri = Owl_nlp_corpus.get_uri corpus in
  {
    model_uri = text_uri ^ ".tfidf";
    doc_freq = [||];
    corpus;
  }

(* calculate document frequency of all words, also return the number of docs *)
let doc_freq vocab fname =
  let n_w = Owl_nlp_vocabulary.size vocab in
  let d_f = Array.make n_w 0. in
  let _h = Hashtbl.create 1024 in
  let n_d = ref 0 in
  Owl_nlp_utils.iteri_lines_of_marshal (fun i doc ->
    Hashtbl.clear _h;
    Array.iter (fun w ->
      match Hashtbl.mem _h w with
      | true  -> ()
      | false -> Hashtbl.add _h w 0
    ) doc;
    Hashtbl.iter (fun w _ ->
      d_f.(w) <- d_f.(w) +. 1.
    ) _h;
    n_d := i;
  ) fname;
  d_f, !n_d

(* calculate the term frequency in a document *)
let term_freq _h doc =
  Array.iter (fun w ->
    match Hashtbl.mem _h w with
    | true  -> (
        let a = Hashtbl.find _h w in
        Hashtbl.replace _h w (a +. 1.)
      )
    | false -> Hashtbl.add _h w 1.
  ) doc

(* calculate document frequency for a given word *)
let doc_freq_of m w =
  let v = Owl_nlp_corpus.get_vocab m.corpus in
  let i = Owl_nlp_vocabulary.word2index v w in
  m.doc_freq.(i)

(* build TF-IDF model from an empty model
  m: empty tf-idf model;
  f: function to calculate tf-idf value;
 *)
let _build_with m f =
  let vocab = Owl_nlp_corpus.get_vocab m.corpus in
  let tfile = Owl_nlp_corpus.get_tok_uri m.corpus in
  let fname = m.model_uri in

  Log.info "calculate document frequency ...";
  let d_f, n_d = doc_freq vocab tfile in
  let n_d = Owl_nlp_corpus.length m.corpus |> float_of_int in
  m.doc_freq <- d_f;

  Log.info "calculate tf-idf ...";
  (* buffer for calculate term frequency *)
  let _h = Hashtbl.create 1024 in
  let fo = open_out fname in

  Owl_nlp_utils.iteri_lines_of_marshal (fun i doc ->
    term_freq _h doc;
    let tfs = Array.make (Hashtbl.length _h) (0,0.) in
    let i = ref 0 in
    Hashtbl.iter (fun w t_f ->
      tfs.(!i) <- w, f t_f d_f.(w) n_d;
      i := !i + 1;
    ) _h;

    Marshal.to_channel fo tfs [];
    (* remember to clear the buffer *)
    Hashtbl.clear _h;

  ) tfile;
  close_out fo

let build corpus =
  let f t_f d_f n_d = t_f *. log (n_d /. (1. +. d_f))
  in
  let m = create corpus in
  _build_with m f;
  m

(* convert a single document according to a given model *)
let appy m doc =
  (* FIXME *)
  let f t_f d_f n_d = t_f *. log (n_d /. (1. +. d_f))
  in
  let n_d = Owl_nlp_corpus.length m.corpus |> float_of_int in
  let d_f = m.doc_freq in
  let doc = Owl_nlp_corpus.tokenise m.corpus doc in
  let _h = Hashtbl.create 1024 in
  term_freq _h doc;
  let tfs = Array.make (Hashtbl.length _h) (0,0.) in
  let i = ref 0 in
  Hashtbl.iter (fun w t_f ->
    tfs.(!i) <- w, f t_f d_f.(w) n_d;
    i := !i + 1;
  ) _h;
  tfs

let save m f =
  m.corpus <- Owl_nlp_corpus.reduce_model m.corpus;
  Owl_utils.marshal_to_file m f

let load f : t = Owl_utils.marshal_from_file f


(* ends here *)
