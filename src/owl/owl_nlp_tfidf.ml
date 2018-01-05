(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** NLP: TFIDF module *)

open Owl_nlp_utils

module Vec = Owl_dense_vector_d


type tf_typ =
  | Binary
  | Count
  | Frequency
  | Log_norm

type df_typ =
  | Unary
  | Idf
  | Idf_Smooth

type t = {
  mutable uri      : string;            (* file path of the model *)
  mutable tf_typ   : tf_typ;            (* function to calculate term freq *)
  mutable df_typ   : df_typ;            (* function to calculate doc freq *)
  mutable offset   : int array;         (* record the offest each document *)
  mutable doc_freq : float array;       (* document frequency *)
  mutable corpus   : Owl_nlp_corpus.t;  (* corpus type *)
  mutable handle   : in_channel option; (* file descriptor of the tfidf *)
}

(* variouis types of TF and IDF fucntions *)

let term_freq = function
  | Binary    -> fun tc tn -> 1.
  | Count     -> fun tc tn -> tc
  | Frequency -> fun tc tn -> tc /. tn
  | Log_norm  -> fun tc tn -> 1. +. log tc

let doc_freq = function
  | Unary      -> fun dc nd -> 1.
  | Idf        -> fun dc nd -> log (nd /. dc)
  | Idf_Smooth -> fun dc nd -> log (nd /. (1. +. dc))

let tf_typ_string = function
  | Binary    -> "binary"
  | Count     -> "raw count"
  | Frequency -> "frequency"
  | Log_norm  -> "log normalised count"

let df_typ_string = function
  | Unary      -> "unary"
  | Idf        -> "inverse frequency"
  | Idf_Smooth -> "inverse frequency smooth"

let create tf_typ df_typ corpus =
  let base_uri = Owl_nlp_corpus.get_uri corpus in
  {
    uri      = base_uri ^ ".tfidf";
    tf_typ;
    df_typ;
    offset   = [||];
    doc_freq = [||];
    corpus;
    handle   = None;
  }

let get_uri m = m.uri

let get_corpus m = m.corpus

let length m = Array.length m.offset - 1

let vocab_len m = m.corpus |> Owl_nlp_corpus.get_vocab |> Owl_nlp_vocabulary.length

let get_handle m =
  match m.handle with
  | Some x -> x
  | None   ->
    let h = m |> get_uri |> open_in
    in m.handle <- Some h; h


(* calculate document frequency for a given word *)
let doc_count_of m w =
  let v = Owl_nlp_corpus.get_vocab m.corpus in
  let i = Owl_nlp_vocabulary.word2index v w in
  m.doc_freq.(i)

(* count occurrency in all documents, for all words *)
let doc_count vocab fname =
  let n_w = Owl_nlp_vocabulary.length vocab in
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


(* count the term occurrency in a document *)
let term_count _h doc =
  Array.iter (fun w ->
    match Hashtbl.mem _h w with
    | true  -> (
        let a = Hashtbl.find _h w in
        Hashtbl.replace _h w (a +. 1.)
      )
    | false -> Hashtbl.add _h w 1.
  ) doc


(* make [x] a unit vector by dividing its l2norm *)
let normalise x =
  let c = Array.fold_left (fun a (w, b) -> a +. b *. b) 0. x |> sqrt in
  Array.map (fun (w, b) -> (w, b /. c)) x


(* build TF-IDF model from an empty model, m: empty tf-idf model *)
let _build_with norm sort tf_fun df_fun m =
  let vocab = Owl_nlp_corpus.get_vocab m.corpus in
  let tfile = Owl_nlp_corpus.get_tok_uri m.corpus in
  let fname = m.uri in

  Owl_log.info "calculate document frequency ...";
  let d_f, n_d = doc_count vocab tfile in
  let n_d = Owl_nlp_corpus.length m.corpus |> float_of_int in
  m.doc_freq <- d_f;

  Owl_log.info "calculate tf-idf ...";
  let fo = open_out fname in
  (* buffer for calculate term frequency *)
  let _h = Hashtbl.create 1024 in
  (* variable for tracking the offest in output model *)
  let offset = Owl_utils.Stack.make () in
  Owl_utils.Stack.push offset 0;

  Owl_nlp_utils.iteri_lines_of_marshal (fun i doc ->
    (* first count terms in one doc *)
    term_count _h doc;

    (* prepare temporary variables *)
    let tfs = Array.make (Hashtbl.length _h) (0, 0.) in
    let tn = Array.length doc |> float_of_int in
    let j = ref 0 in

    (* calculate tf-idf values *)
    Hashtbl.iter (fun w tc ->
      let tf_df = (tf_fun tc tn) *. (df_fun d_f.(w) n_d) in
      tfs.(!j) <- w, tf_df;
      j := !j + 1;
    ) _h;

    (* check if we need to normalise *)
    let tfs = match norm with
      | true  -> normalise tfs
      | false -> tfs
    in
    (* check if we need to sort term id in increasing order *)
    let _ = match sort with
      | true  -> Array.sort (fun a b -> Pervasives.compare (fst a) (fst b)) tfs
      | false -> ()
    in

    (* save to file and update offset *)
    Marshal.to_channel fo tfs [];
    Owl_utils.Stack.push offset (LargeFile.pos_out fo |> Int64.to_int);

    (* remember to clear the buffer *)
    Hashtbl.clear _h;
  ) tfile;

  (* finished, clean up *)
  m.offset <- offset |> Owl_utils.Stack.to_array;
  close_out fo


let build ?(norm=false) ?(sort=false) ?(tf=Count) ?(df=Idf) corpus =
  let m = create tf df corpus in
  let tf_fun = term_freq tf in
  let df_fun = doc_freq df in
  _build_with norm sort tf_fun df_fun m;
  m


(* random access and iteration function *)

let next m : (int * float) array = m |> get_handle |> Marshal.from_channel

let next_batch ?(size=100) m =
  let batch = Owl_utils.Stack.make () in
  (
    try for _i = 0 to size - 1 do
      m |> next |> Owl_utils.Stack.push batch
    done with exn -> ()
  );
  Owl_utils.Stack.to_array batch

let iteri f m = iteri_lines_of_marshal f m.uri

let mapi f m = mapi_lines_of_marshal f m.uri

let get m i : (int * float) array =
  let fh = open_in m.uri in
  seek_in fh m.offset.(i);
  let doc =  Marshal.from_channel fh in
  close_in fh;
  doc

let reset_iterators m =
  let _reset_offset = function
    | Some h -> seek_in h 0
    | None   -> ()
  in
  _reset_offset m.handle

(* convert a single document according to a given model *)
let apply m doc =
  (* FIXME *)
  let f t_f d_f n_d = t_f *. log (n_d /. (1. +. d_f))
  in
  let n_d = Owl_nlp_corpus.length m.corpus |> float_of_int in
  let d_f = m.doc_freq in
  let doc = Owl_nlp_corpus.tokenise m.corpus doc in
  let _h = Hashtbl.create 1024 in
  term_count _h doc;
  let tfs = Array.make (Hashtbl.length _h) (0, 0.) in
  let i = ref 0 in
  Hashtbl.iter (fun w t_f ->
    tfs.(!i) <- w, f t_f d_f.(w) n_d;
    i := !i + 1;
  ) _h;
  tfs


(* I/O functions *)

let save m f =
  m.corpus <- Owl_nlp_corpus.reduce_model m.corpus;
  m.handle <- None;
  Owl_utils.marshal_to_file m f

let load f : t = Owl_utils.marshal_from_file f

let to_string m =
  Printf.sprintf "TfIdf model\n" ^
  Printf.sprintf "  uri        : %s\n" m.uri ^
  Printf.sprintf "  tf_type    : %s\n" (m.tf_typ |> tf_typ_string) ^
  Printf.sprintf "  df_type    : %s\n" (m.df_typ |> df_typ_string) ^
  Printf.sprintf "  # of docs  : %i\n" (length m) ^
  Printf.sprintf "  # of vocab : %i" (vocab_len m) ^
  ""

let print m = m |> to_string |> print_endline


(* experimental functions *)

(* percentage of non-zero elements in doc-term matrix *)
let density m =
  let n_d = length m |> float_of_int in
  let n_t = vocab_len m |> float_of_int in
  let nnz = ref 0 in
  iteri (fun _ _ -> nnz := !nnz + 1) m;
  (float_of_int !nnz) /. (n_d *. n_t)

let doc_to_vec m x =
  let v = Vec.zeros (vocab_len m) in
  Array.iter (fun (i, a) -> Vec.set v i a) x;
  v

(* calculate pairwise distance for the whole model, format (id,dist) *)
let all_pairwise_distance typ m x =
  let dist_fun = Owl_nlp_similarity.distance typ in
  let l = mapi (fun i y -> i, dist_fun x y) m in
  Array.sort (fun a b -> Pervasives.compare (snd a) (snd b)) l;
  l

(* k-nearest neighbour, very slow due to linear search *)
let nearest ?(typ=Owl_nlp_similarity.Cosine) m x k =
  let l = all_pairwise_distance typ m x in
  Array.sub l 0 k


(* ends here *)
