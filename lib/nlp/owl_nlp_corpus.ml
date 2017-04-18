(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_nlp_utils

type t = {
  mutable uri     : string;                       (* path of the binary corpus *)
  mutable bin_ofs : int array;                    (* index of the string corpus *)
  mutable tok_ofs : int array;                    (* index of the tokenised corpus *)
  mutable bin_fh  : in_channel option;            (* file descriptor of the binary corpus *)
  mutable tok_fh  : in_channel option;            (* file descriptor of the tokenised corpus *)
  mutable vocab   : Owl_nlp_vocabulary.t option;  (* vocabulary of the corpus *)
  mutable minlen  : int;                          (* minimum length of document to save *)
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

let create uri bin_ofs tok_ofs bin_fh tok_fh vocab minlen =
  let x = {
    uri;
    bin_ofs;
    tok_ofs;
    bin_fh;
    tok_fh;
    vocab;
    minlen;
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

let tokenise corpus s =
  let dict = get_vocab corpus in
  Str.split (Str.regexp " ") s
  |> List.filter (Owl_nlp_vocabulary.exits_w dict)
  |> List.map (Owl_nlp_vocabulary.word2index dict)
  |> Array.of_list


(* convert corpus into binary format, build dictionary, tokenise *)
let build ?stopwords ?lo ?hi ?(minlen=10) fname =
  (* build and save the vocabulary *)
  Log.info "build up vocabulary ...";
  let vocab = Owl_nlp_vocabulary.build ?lo ?hi ?stopwords fname in
  Owl_nlp_vocabulary.save vocab (fname ^ ".voc");

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

  (* binarise and tokenise at the same time *)
  Log.info "convert to binary and tokenise ...";
  iteri_lines_of_file (fun i s ->

    let t = Str.split (Str.regexp " ") s
      |> List.filter (Owl_nlp_vocabulary.exits_w vocab)
      |> List.map (Owl_nlp_vocabulary.word2index vocab)
      |> Array.of_list
    in
    (* only save those having at least minlen words *)
    if Array.length t >= minlen then (
      Marshal.to_channel bin_f s [];
      Marshal.to_channel tok_f t [];

      Owl_utils.Stack.push b_ofs (LargeFile.pos_out bin_f |> Int64.to_int);
      Owl_utils.Stack.push t_ofs (LargeFile.pos_out tok_f |> Int64.to_int);
    );

  ) fname;

  (* save the corpus file *)
  let dat_f = fname ^ ".dat" |> open_out in
  let b_ofs = Owl_utils.Stack.to_array b_ofs in
  let t_ofs = Owl_utils.Stack.to_array t_ofs in
  let corpus = create fname b_ofs t_ofs None None None minlen in
  Marshal.to_channel dat_f corpus [];

  (* done, close the files *)
  close_out bin_f;
  close_out tok_f;
  close_out dat_f;
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
        output_bytes fo s;
        output_char fo '\n';
        Hashtbl.add h s None;
      )
  ) fi_name;
  close_out fo;
  Owl_utils.Stack.to_array rm


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

let save_txt corpus f =
  let fh = open_out f in
  iteri (fun i s ->
    output_bytes fh s;
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
