(** [ Test Topic Module ]
  The test only works when you have the corresponding text corpus on your
  mahcine. Appologies for the temporary hard-coding path.
 *)

let _ =
  let s = Owl_topic_utils.load_stopwords "../lib/topic/stopwords.txt" in
  let x = Owl_topic_utils.load_data ~stopwords:s "nips.test" in
  let v = Owl_topic_utils.build_vocabulary x in
  let d = Owl_topic_utils.tokenisation v x in
  let _ = Owl_topic_lda.init 100 v d in
  Owl_topic_lda.(train SparseLDA)
