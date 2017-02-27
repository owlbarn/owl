(** [ Test Topic Module ]
  The test only works when you have the corresponding text corpus on your
  mahcine. Appologies for the temporary hard-coding path.
 *)

let prepare_data () =
  let p = Owl_utils.local_data_path () in
  if Sys.file_exists (p ^ "stopwords.txt") = false then
    Owl_utils.download_all ();
  p

let _ =
  let p = prepare_data () in
  let s = Owl_topic_utils.load_stopwords (p ^ "stopwords.txt") in
  let x = Owl_topic_utils.load_data ~stopwords:s (p ^ "nips.train") in
  let v = Owl_topic_utils.build_vocabulary x in
  let d = Owl_topic_utils.tokenisation v x in
  let m = Owl_topic_lda.init ~iter:20 10 v d in
  Owl_topic_lda.(train SparseLDA m);
  Owl_topic_utils.save_lda_model m "mylda"
