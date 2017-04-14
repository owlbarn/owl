(* test TF-IDF model *)

open Owl
open Owl_nlp

let _ =
  let x = Corpus.load "news.corpus" in
  let m = Tfidf.create x in
  Tfidf.build m
