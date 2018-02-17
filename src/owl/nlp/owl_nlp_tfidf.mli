(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** NLP: TFIDF module *)

module Vec = Owl_dense.Ndarray.D


(** {6 Type definition} *)

type tf_typ = Binary | Count | Frequency | Log_norm
(** TODO *)

type df_typ = Unary | Idf | Idf_Smooth
(** TODO *)

type t
(** TODO *)


(** {6 Query model} *)

val length : t -> int
(** TODO *)

val term_freq : tf_typ -> float -> float -> float
(** TODO *)

val doc_freq : df_typ -> float -> float -> float
(** TODO *)

val tf_typ_string : tf_typ -> string
(** TODO *)

val df_typ_string : df_typ -> string
(** TODO *)

val get_uri : t -> string
(** TODO *)

val get_corpus : t -> Owl_nlp_corpus.t
(** TODO *)

val vocab_len : t -> int
(** TODO *)

val get_handle : t -> in_channel
(** TODO *)

val doc_count_of : t -> string -> float
(** TODO *)

val doc_count : Owl_nlp_vocabulary.t -> string -> float array * int
(** TODO *)

val term_count : ('a, float) Hashtbl.t -> 'a array -> unit
(** TODO *)

val normalise : ('a * float) array -> ('a * float) array
(** TODO *)


(** {6 Iterate functions} *)

val next : t -> (int * float) array
(** TODO *)

val next_batch : ?size:int -> t -> (int * float) array array
(** TODO *)

val iteri : (int -> 'a -> 'b) -> t -> unit
(** TODO *)

val mapi : (int -> 'a -> 'b) -> t -> 'b array
(** TODO *)

val get : t -> int -> (int * float) array
(** TODO *)

val reset_iterators : t -> unit
(** TODO *)

val apply : t -> string -> (int * float) array
(** TODO *)


(** {6 Core functions} *)

val build : ?norm:bool -> ?sort:bool -> ?tf:tf_typ -> ?df:df_typ -> Owl_nlp_corpus.t -> t
(** TODO *)

val doc_to_vec : t -> (int * float) array -> Vec.arr
(** TODO *)


(** {6 I/O functions} *)

val save : t -> string -> unit
(** TODO *)

val load : string -> t
(** TODO *)

val to_string : t -> string
(** TODO *)

val print : t -> unit
(** TODO *)

val density : t -> float
(** TODO *)




(** {6 Helper functions} *)

val create : tf_typ -> df_typ -> Owl_nlp_corpus.t -> t
(** TODO *)

val all_pairwise_distance : Owl_nlp_similarity.t -> t -> ('a * float) array -> (int * float) array
(** TODO *)

val nearest : ?typ:Owl_nlp_similarity.t -> t -> ('a * float) array -> int -> (int * float) array
(** TODO *)
