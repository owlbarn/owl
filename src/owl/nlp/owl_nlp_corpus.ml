(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** NLP: Corpus module *)

open Owl_nlp_utils

type t = {
  mutable uri     : string;                       (* path of the binary corpus *)
  mutable bin_ofs : int array;                    (* index of the string corpus *)
  mutable tok_ofs : int array;                    (* index of the tokenised corpus *)
  mutable bin_fh  : in_channel option;            (* file descriptor of the binary corpus *)
  mutable tok_fh  : in_channel option;            (* file descriptor of the tokenised corpus *)
  mutable vocab   : Owl_nlp_vocabulary.t option;  (* vocabulary of the corpus *)
  mutable minlen  : int;                          (* minimum length of document to save *)
  mutable docid   : int array;                    (* document id, can refer to original data *)
}

let _close_if_open = function
  | Some h -> close_in h
  | None   -> ()

let _open_if_exists f =
  match Sys.file_exists f with
  | true  -> Some (open_in f)
  | false -> None

let cleanup x =
  _close_if_open x.bin_fh;
  _close_if_open x.tok_fh

let create uri bin_ofs tok_ofs bin_fh tok_fh vocab minlen docid =
  let x = {
    uri;
    bin_ofs;
    tok_ofs;
    bin_fh;
    tok_fh;
    vocab;
    minlen;
    docid;
  }
  in
  Gc.finalise cleanup x;
  x

let get_uri corpus = corpus.uri

let get_bin_uri corpus = corpus.uri ^ ".bin"

let get_bin_fh corpus =
  match corpus.bin_fh with
  | Some x -> x
  | None   ->
    let h = corpus |> get_bin_uri |> open_in
    in corpus.bin_fh <- Some h; h

let get_tok_uri corpus = corpus.uri ^ ".tok"

let get_tok_fh corpus =
  match corpus.tok_fh with
  | Some x -> x
  | None   ->
    let h = corpus |> get_tok_uri |> open_in
    in corpus.tok_fh <- Some h; h

let get_vocab_uri corpus = corpus.uri ^ ".voc"

let get_vocab corpus =
  match corpus.vocab with
  | Some x -> x
  | None   ->
    let h = corpus |> get_vocab_uri |> Owl_nlp_vocabulary.load
    in corpus.vocab <- Some h; h

let get_docid corpus = corpus.docid

let length corpus = Array.length corpus.bin_ofs - 1


(* iterate docs and tokenised docs and etc. *)

let next corpus : string = corpus |> get_bin_fh |> Marshal.from_channel

let next_tok corpus : int array = corpus |> get_tok_fh |> Marshal.from_channel

let iteri f corpus = iteri_lines_of_marshal f (get_bin_uri corpus)

let iteri_tok f corpus = iteri_lines_of_marshal f (get_tok_uri corpus)

let mapi f corpus = mapi_lines_of_marshal f (get_bin_uri corpus)

let mapi_tok f corpus = mapi_lines_of_marshal f (get_tok_uri corpus)

let get corpus i : string =
  let fh = get_bin_fh corpus in
  let old_pos = pos_in fh in
  seek_in fh corpus.bin_ofs.(i);
  let doc =  Marshal.from_channel fh in
  seek_in fh old_pos;
  doc

let get_tok corpus i : int array =
  let fh = get_tok_fh corpus in
  let old_pos = pos_in fh in
  seek_in fh corpus.tok_ofs.(i);
  let doc =  Marshal.from_channel fh in
  seek_in fh old_pos;
  doc

(* reset all the file pointers at offest 0 *)
let reset_iterators corpus =
  let _reset_offset = function
    | Some h -> seek_in h 0
    | None   -> ()
  in
  _reset_offset corpus.bin_fh;
  _reset_offset corpus.tok_fh

(* return a batch of documents *)
let next_batch ?(size=100) corpus =
  let batch = Owl_utils.Stack.make () in
  (
    try for i = 0 to size - 1 do
      corpus |> next |> Owl_utils.Stack.push batch
    done with exn -> ()
  );
  Owl_utils.Stack.to_array batch

(* return a batch of tokenised documents *)
let next_batch_tok ?(size=100) corpus =
  let batch = Owl_utils.Stack.make () in
  (
    try for i = 0 to size - 1 do
      corpus |> next_tok |> Owl_utils.Stack.push batch
    done with exn -> ()
  );
  Owl_utils.Stack.to_array batch

let tokenise corpus s =
  let dict = get_vocab corpus in
  Str.split (Str.regexp " ") s
  |> List.filter (Owl_nlp_vocabulary.exits_w dict)
  |> List.map (Owl_nlp_vocabulary.word2index dict)
  |> Array.of_list


(* convert corpus into binary format, build dictionary, tokenise
  lo and hi will be ignored if a vocab is passed in.

  The passed in docid can be used for tracking back to the original corpus, but
  this is not compulsory.
 *)
let build ?docid ?stopwords ?lo ?hi ?vocab ?(minlen=10) fname =

  (* build and save the vocabulary if necessary *)
  let vocab = match vocab with
    | Some vocab -> vocab
    | None       -> (
        Owl_log.info "build up vocabulary ...";
        Owl_nlp_vocabulary.build ?lo ?hi ?stopwords fname
      )
  in
  Owl_nlp_vocabulary.save vocab (fname ^ ".voc");
  Owl_nlp_vocabulary.save_txt vocab (fname ^ ".voc.txt");

  (* prepare the output file *)
  let bin_f = fname ^ ".bin" |> open_out in
  let tok_f = fname ^ ".tok" |> open_out in
  set_binary_mode_out bin_f true;
  set_binary_mode_out tok_f true;

  (* initalise the offset array *)
  let b_ofs = Owl_utils.Stack.make () in
  let t_ofs = Owl_utils.Stack.make () in
  Owl_utils.Stack.push b_ofs 0;
  Owl_utils.Stack.push t_ofs 0;

  (* initalise the doc_id stack *)
  let doc_s = Owl_utils.Stack.make () in

  (* binarise and tokenise at the same time *)
  Owl_log.info "convert to binary and tokenise ...";
  iteri_lines_of_file (fun i s ->

    let t = Str.split Owl_nlp_utils.regexp_split s
      |> List.filter (Owl_nlp_vocabulary.exits_w vocab)
      |> List.map (Owl_nlp_vocabulary.word2index vocab)
      |> Array.of_list
    in
    (* only save those having at least minlen words *)
    if Array.length t >= minlen then (
      Marshal.to_channel bin_f s [];
      Marshal.to_channel tok_f t [];

      (* keep tracking of doc id *)
      let id = match docid with Some d -> d.(i) | None -> i in
      Owl_utils.Stack.push doc_s id;

      (* keep tracking of doc offset *)
      Owl_utils.Stack.push b_ofs (LargeFile.pos_out bin_f |> Int64.to_int);
      Owl_utils.Stack.push t_ofs (LargeFile.pos_out tok_f |> Int64.to_int);
    );

  ) fname;

  (* save the corpus file *)
  let mdl_f = fname ^ ".mdl" |> open_out in
  let b_ofs = Owl_utils.Stack.to_array b_ofs in
  let t_ofs = Owl_utils.Stack.to_array t_ofs in
  let doc_s = Owl_utils.Stack.to_array doc_s in
  let corpus = create fname b_ofs t_ofs None None None minlen doc_s in
  Marshal.to_channel mdl_f corpus [];

  (* done, close the files *)
  close_out bin_f;
  close_out tok_f;
  close_out mdl_f;
  (* return the finished corpus *)
  get_bin_fh corpus |> ignore;
  get_tok_fh corpus |> ignore;
  get_vocab corpus  |> ignore;
  corpus


(* remove duplicates in a text corpus, the ids of the removed files are returned *)
let unique fi_name fo_name =
  let h = Hashtbl.create 1024 in
  let rm = Owl_utils.Stack.make () in
  let fo = open_out fo_name in
  Owl_nlp_utils.iteri_lines_of_file (fun i s ->
    match Hashtbl.mem h s with
    | true  -> Owl_utils.Stack.push rm i
    | false -> (
        output_string fo s;
        output_char fo '\n';
        Hashtbl.add h s None;
      )
  ) fi_name;
  close_out fo;
  Owl_utils.Stack.to_array rm


(* a simple function for pre-processing a given string *)
let simple_process s =
  Str.split Owl_nlp_utils.regexp_split s
  |> List.filter (fun x -> String.length x > 1)
  |> String.concat " "
  |> String.lowercase_ascii


(* pre-process a given file with the passed in function
  e.g., you can plug in [simple_process] function to clean up the text.
  Note this function will not change the number of lines in a corpus.
 *)
let preprocess f fi_name fo_name =
  let fo = open_out fo_name in
  Owl_nlp_utils.iteri_lines_of_file (fun i s ->
    output_bytes fo (f s);
    output_char fo '\n';
  ) fi_name;
  close_out fo


(* i/o: save and load corpus *)

(* set some fields to None so it can be safely saved *)
let reduce_model corpus = {
  uri     = corpus.uri;
  bin_ofs = corpus.bin_ofs;
  tok_ofs = corpus.tok_ofs;
  bin_fh  = None;
  tok_fh  = None;
  vocab   = None;
  minlen  = corpus.minlen;
  docid   = corpus.docid;
}

let save corpus f =
  let x = reduce_model corpus in
  Owl_utils.marshal_to_file x f

let load f : t =
  let corpus = Owl_utils.marshal_from_file f in
  get_bin_fh corpus |> ignore;
  get_tok_fh corpus |> ignore;
  get_vocab corpus  |> ignore;
  corpus

(* convert tokenised corpus back to text file *)
let save_txt corpus f =
  let fh = open_out f in
  let vocab = get_vocab corpus in
  let i2w_f = Owl_nlp_vocabulary.index2word vocab in
  iteri_tok (fun i t ->
    let s = t
      |> Array.map i2w_f
      |> Array.to_list
      |> String.concat " "
    in
    output_string fh s;
    output_char fh '\n';
  ) corpus;
  close_out fh

let to_string corpus =
  Printf.sprintf "corpus info\n" ^
  Printf.sprintf "  file path  : %s\n" (corpus |> get_uri) ^
  Printf.sprintf "  # of docs  : %i\n" (corpus |> length) ^
  Printf.sprintf "  doc minlen : %i" (corpus.minlen)

let print corpus = corpus |> to_string |> print_endline



(* ends here *)
