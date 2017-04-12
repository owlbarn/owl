(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_nlp_utils

type t = {
  mutable w2i : (string, int) Hashtbl.t;  (* word -> index *)
  mutable i2w : (int, string) Hashtbl.t;  (* index -> word *)
  mutable i2f : (int, int) Hashtbl.t      (* index -> freq *)
}

let exits_w d w = Hashtbl.mem d.w2i w

let exits_i d i = Hashtbl.mem d.i2w i

let word2index d w = Hashtbl.find d.w2i w

let index2word d i = Hashtbl.find d.i2w i

let size d = Hashtbl.length d.w2i

let freq_i d i = Hashtbl.find d.i2f i

let freq_w d w = w |> word2index d |> freq_i d

let save d fname = Owl_utils.marshal_to_file d fname

let load fname : t = Owl_utils.marshal_from_file fname

(* remove extremely low and high frequency words
  lo: the percentage of lower bound
  hi: the percentage of higher bound
  h: the hashtbl of the vocabulary (word, freq)
 *)
let trim_freq lo hi h =
  let n = Hashtbl.length h in
  let all_freq = Array.make n 0 in
  let i = ref 0 in
  Hashtbl.iter (fun _ freq ->
    all_freq.(!i) <- freq;
    i := !i + 1;
  ) h;
  Array.sort Pervasives.compare all_freq;
  let l0 = float_of_int n *. lo |> int_of_float in
  let h0 = float_of_int n *. hi |> int_of_float in
  let lo = all_freq.(l0) in
  let hi = all_freq.(h0) in
  Hashtbl.filter_map_inplace (fun _ freq ->
    match freq >= lo, freq <= hi with
    | true, true -> Some freq
    | _          -> None
  ) h

(* similar to trim_freq, but trim all three hashtbls *)
let trim lo hi d =
  trim_freq lo hi d.i2f;
  Hashtbl.filter_map_inplace (fun i w ->
    match Hashtbl.mem d.i2f i with
    | true  -> Some w
    | false -> Hashtbl.remove d.w2i w; None
  ) d.i2w

(* remove stopwords from vocabulary
  sw: hashtbl contains the vocabulary
 *)
let remove_stopwords sw h =
Hashtbl.filter_map_inplace (fun w v ->
  match Hashtbl.mem sw w with
  | true  -> None
  | false -> Some v
) h

(* return both word->index and index->word hashtbl
  lo: percentage of lower bound of word frequency
  hi: percentage of higher bound of word frequency
  fname: file name of the corpus, each line contains a doc
 *)
let build_from_file ?(lo=0.) ?(hi=1.) ?stopwords fname =
  let w2f = Hashtbl.create (64 * 1024) in
  let f s =
    Str.split (Str.regexp " ") s
    |> List.iter (fun w ->
      match Hashtbl.mem w2f w with
      | true  -> (
          let freq = Hashtbl.find w2f w in
          Hashtbl.replace w2f w (freq + 1)
        )
      | false -> Hashtbl.add w2f w 1
    )
  in
  iteri_lines_of_file (fun _ s -> f s) fname;
  (* trim frequency if necessary *)
  if lo <> 0. || hi <> 1. then
    trim_freq lo hi w2f;
  (* trim stopwords if necessary *)
  (
    match stopwords with
    | Some sw  -> remove_stopwords sw w2f
    | None     -> ()
  );
  (* build w2i and i2w tables from trimmed w2f *)
  let w2i = Hashtbl.(create (length w2f)) in
  let i2w = Hashtbl.(create (length w2f)) in
  let i2f = Hashtbl.(create (length w2f)) in
  let i = ref 0 in
  Hashtbl.iter (fun w f ->
    Hashtbl.add w2i w !i;
    Hashtbl.add i2w !i w;
    Hashtbl.add i2f !i f;
    i := !i + 1;
  ) w2f;
  { w2i; i2w; i2f }

(* return (index, freq) array in increasing or decreasing freq *)
let sort_freq ?(inc=true) d =
  let all_freq = Array.make (size d) (0, 0) in
  let i = ref 0 in
  Hashtbl.iter (fun j freq ->
    all_freq.(!i) <- (j, freq);
    i := !i + 1;
  ) d.i2f;
  let f = match inc with
    | true  -> fun a b -> Pervasives.compare (snd a) (snd b)
    | false -> fun a b -> Pervasives.compare (snd b) (snd a)
  in
  Array.sort f all_freq;
  all_freq

(* return k most popular words *)
let top d k =
  let all_freq = sort_freq ~inc:false d in
  Array.sub all_freq 0 k |>
  Array.map (fun (i, freq) -> (index2word d i, freq))

(* return k least popular words *)
let bottom d k =
  let all_freq = sort_freq ~inc:true d in
  Array.sub all_freq 0 k |>
  Array.map (fun (i, freq) -> (index2word d i, freq))


(* ends here *)
