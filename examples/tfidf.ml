#!/usr/bin/env owl
(* test TF-IDF model *)

open Owl
open Owl_nlp

let _ =
  let stopwords = Dataset.load_stopwords () in
  let data_path = Sys.getenv "HOME" ^ "/.owl/dataset/news.train" in
  let x = Corpus.build ~stopwords data_path in
  let m = Tfidf.build ~norm:true x in
  Tfidf.save m "news.tfidf"
