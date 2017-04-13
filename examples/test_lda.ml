(* Test Topic Module *)

(*
let _ =
  let s = Owl_dataset.load_stopwords () in
  let x = Owl_dataset.load_nips_train_data s in
  let v = Owl_nlp_utils.build_vocabulary x |> fst in
  let d = Owl_nlp_utils.tokenise_all v x in
  let m = Owl_nlp_lda.init ~iter:20 10 v d in
  Owl_nlp_lda.(train SparseLDA m);
  Owl_nlp_utils.save_lda_model m "mylda"
*)


open Owl
open Owl_nlp

let test_news_lda () =
  let s = Dataset.load_stopwords () in
  let x = Corpus.create "/Users/liang/owl_dataset/news.train" in
  let v = Corpus.build_vocabulary ~stopwords:s x in
  let _ = Corpus.tokenise x in
  let _ = Corpus.save x "news.corpus" in
  let m = Owl_nlp_lda0.init ~iter:20 1000 v.w2i x in
  Owl_nlp_lda0.(train SimpleLDA m)


let test_news_vocb () =
  let s = Dataset.load_stopwords () in
  let x = Corpus.create "/Users/liang/owl_dataset/news.train" in
  let _ = Corpus.build_vocabulary ~stopwords:s x in
  Corpus.tokenise x;
  Corpus.save x "news.corpus"


let test () =
  let x = Corpus.load "news.corpus" in
  let v = Corpus.get_vocabulary x in
  let m = Owl_nlp_lda0.init ~iter:20 1000 v.w2i x in
  Owl_nlp_lda0.(train SimpleLDA m)

let _ = test ()
