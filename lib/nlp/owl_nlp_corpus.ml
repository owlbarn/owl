(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_nlp_utils

type t = {
  mutable uri      : string option;       (* file path *)
  mutable text_h   : in_channel option;   (* file handle of the corpus *)
  mutable token_h  : in_channel option;   (* file handle of the tokens *)
}

let cleanup x =
  let _close_if_open = function
    | Some h -> close_in h
    | None   -> ()
  in
  _close_if_open x.text_h;
  _close_if_open x.token_h

let empty () =
  let x = {
    uri      = None;
    text_h   = None;
    token_h  = None;
  }
  in
  Gc.finalise cleanup x;
  x

let load fname =
  let x = {
    uri     = Some fname;
    text_h  = Some (open_in fname);
    token_h = None;
  }
  in
  Gc.finalise cleanup x;
  x

let get_uri corpus =
  match corpus.uri with
  | Some x -> x
  | None   -> failwith "get_uri: no uri has been defined"

let get_text_h corpus =
  match corpus.text_h with
  | Some x -> x
  | None   -> failwith "get_uri: no text_h has been defined"

let get_token_h corpus =
  match corpus.token_h with
  | Some x -> x
  | None   -> failwith "get_uri: no token_h has been defined"

let num_doc corpus =
  let n = ref 0 in
  let uri = get_uri corpus in
  Owl_nlp_utils.iteri_lines_of_file (fun i _ -> n := i) uri;
  !n + 1

let next_doc corpus = corpus |> get_text_h |> input_line

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
  let fi_name = get_uri corpus in
  let fo_name = fi_name ^ ".token" in
  tokenise_file dict fi_name fo_name


(* ends here *)
