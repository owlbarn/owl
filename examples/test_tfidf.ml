(* test TF-IDF model *)

open Owl
open Owl_nlp

let _ =
  let stopwords = Dataset.load_stopwords () in
  let x = Corpus.build ~stopwords "/Users/liang/owl_dataset/news.train" in
  let m = Tfidf.build ~norm:true x in
  Tfidf.save m "news.tfidf"

  (* let x = Corpus.load "/Users/liang/owl_dataset/news.train.dat" in
  let m = Tfidf.build x in
  Tfidf.save m "news.tfidf" *)

  (* This is fast, achieves 120k docs/s on my slow macbook.
  let x = "/Users/liang/owl_dataset/news.train" in
  let y = "/Users/liang/owl_dataset/news.train.reduced" in
  Corpus.unique x y *)
