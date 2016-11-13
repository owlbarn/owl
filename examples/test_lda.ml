
let _ =
  let s = Owl_topic_utils.load_stopwords "/Users/liang/code/owl/lib/topic/stopwords.txt" in
  let x = Owl_topic_utils.load_data ~stopwords:s "/Users/liang/code/experimental-lda/data/nips.test" in
  let v = Owl_topic_utils.build_vocabuary x in
  let d = Owl_topic_utils.tokenisation v x in
  let _ = Owl_lda.init 100 (Hashtbl.length v) d in
  Owl_lda.(train SimpleLDA)
