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

(*
let test_news_lda () =
  let s = Dataset.load_stopwords () in
  let x = Corpus.build ~stopwords:s "/Users/liang/owl_dataset/news.train" in
  let v = Corpus.get_vocab x |> Vocabulary.get_w2i in
  let m = Owl_nlp_lda0.init ~iter:20 1000 v x in
  Owl_nlp_lda0.(train SimpleLDA m)
*)


let test () =
  let data_path = Sys.getenv "HOME" ^ "/.owl/dataset/news.train.clean.dat" in 
  let x = Corpus.load data_path in
  let v = Corpus.get_vocab x |> Vocabulary.get_w2i in
  let m = Owl_nlp_lda.init ~iter:20 500 v x in
  Owl_nlp_lda.(train SimpleLDA m)

let _ = test ()
