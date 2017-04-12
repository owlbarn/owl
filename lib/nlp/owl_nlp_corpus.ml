(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_nlp_utils

type t = {
  mutable text_uri  : string option;       (* path of the text corpus *)
  mutable text_h    : in_channel option;   (* file handle of the corpus *)
  mutable token_uri : string option;       (* path of the tokenised corpus *)
  mutable token_h   : in_channel option;   (* file handle of the tokens *)
}

let _close_if_open = function
  | Some h -> close_in h
  | None   -> ()

let cleanup x =
  _close_if_open x.text_h;
  _close_if_open x.token_h

let empty () =
  let x = {
    text_uri  = None;
    text_h    = None;
    token_uri = None;
    token_h   = None;
  }
  in
  Gc.finalise cleanup x;
  x

let load fname =
  let x = {
    text_uri  = Some fname;
    text_h    = if Sys.file_exists fname then Some (open_in fname) else None;
    token_uri = Some (fname ^ ".token");
    token_h   =
      let tname = fname ^ ".token" in
      if Sys.file_exists tname then Some (open_in tname)
      else None;
  }
  in
  Gc.finalise cleanup x;
  x

let get_text_uri corpus =
  match corpus.text_uri with
  | Some x -> x
  | None   -> failwith "get_uri: no text_uri has been defined"

let get_text_h corpus =
  match corpus.text_h with
  | Some x -> x
  | None   -> corpus |> get_text_uri |> open_in

let get_token_uri corpus =
  match corpus.token_uri with
  | Some x -> x
  | None   -> failwith "get_uri: no token_uri has been defined"

let get_token_h corpus =
  match corpus.token_h with
  | Some x -> x
  | None   -> corpus |> get_token_uri |> open_in

let num_doc corpus =
  let n = ref 0 in
  let uri = get_text_uri corpus in
  Owl_nlp_utils.iteri_lines_of_file (fun i _ -> n := i) uri;
  !n + 1


(* iterate docs and tokenised docs and etc. *)

let next_doc corpus = corpus |> get_text_h |> input_line

let next_tokenised_doc corpus = corpus |> get_token_h |> Marshal.from_channel

let iteri_docs f corpus = iteri_lines_of_file f (get_text_uri corpus)

let iteri_tokenised_docs f corpus = iteri_lines_of_marshal f (get_token_uri corpus)


(* reset all the file pointers at offest 0 *)
let reset corpus =
  let _reset_offset = function
    | Some h -> seek_in h 0
    | None   -> ()
  in
  _reset_offset corpus.text_h;
  _reset_offset corpus.token_h

(* tokenise a corpus and keep the tokens in memory *)
let tokenise_mem dict fname =
  mapi_lines_of_file (fun _ s ->
    Str.split (Str.regexp " ") s
    |> List.map (Owl_nlp_vocabulary.word2index dict)
  ) fname

(* tokenise a corpus and save the outcome tokens in anther file *)
let tokenise_file dict fi_name fo_name =
  let fo = open_out fo_name in
  iteri_lines_of_file (fun _ s ->
    let t = Str.split (Str.regexp " ") s
      |> List.map (Owl_nlp_vocabulary.word2index dict)
    in
    Marshal.to_channel fo t [];
  ) fi_name;
  close_out fo

let tokenise dict corpus =
  let fi_name = get_text_uri corpus in
  let fo_name = get_token_uri corpus in
  tokenise_file dict fi_name fo_name


(* ends here *)
