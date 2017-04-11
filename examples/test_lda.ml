(* Test Topic Module *)

let _ =
  let s = Owl_dataset.load_stopwords () in
  let x = Owl_dataset.load_nips_train_data s in
  let v = Owl_nlp_utils.build_vocabulary x |> fst in
  let d = Owl_nlp_utils.tokenise_all v x in
  let m = Owl_nlp_lda.init ~iter:20 10 v d in
  Owl_nlp_lda.(train SparseLDA m);
  Owl_nlp_utils.save_lda_model m "mylda"
