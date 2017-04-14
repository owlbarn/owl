(* test TF-IDF model *)

open Owl
open Owl_nlp

let _ =
  (* let s = Dataset.load_stopwords () in
  let x = Corpus.create "/Users/liang/owl_dataset/news.train" in
  let _ = Corpus.build_vocabulary ~stopwords:s x in
  let _ = Corpus.tokenise x in
  Corpus.save x "news.corpus" *)
  let x = Corpus.load "news.corpus" in
  let m = Tfidf.build x in
  Tfidf.save m "news.tfidf"
