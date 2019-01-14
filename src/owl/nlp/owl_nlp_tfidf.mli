(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** NLP: TFIDF module *)


(** {6 Type definition} *)

type tf_typ = Binary | Count | Frequency | Log_norm
(** Type of term frequency. *)

type df_typ = Unary | Idf | Idf_Smooth
(** Type of inverse document frequency. *)

type t
(** Type of a TFIDF model *)


(** {6 Query model} *)

val length : t -> int
(** Size of Tfidf model, i.e. number of documents contained. *)

val term_freq : tf_typ -> float -> float -> float
(** ``term_freq term_count num_words`` calculates the term frequency weight. *)

val doc_freq : df_typ -> float -> float -> float
(** ``doc_freq doc_count num_docs`` calculates the document frequency weight. *)

val get_uri : t -> string
(** Return the path of the TFIDF model. *)

val get_corpus : t -> Owl_nlp_corpus.t
(** Return the corpus contained in TFIDF model *)

val vocab_len : t -> int
(** Return the size of the vocabulary contained in the TFIDF model. *)

val get_handle : t -> in_channel
(** Geht the file handle associated with TFIDF model. *)

val doc_count_of : t -> string -> float
(** ``doc_count_of tfidf w`` calculate document frequency for a given word ``w``. *)

val doc_count : Owl_nlp_vocabulary.t -> string -> float array * int
(** ``doc_count vocab fname``count occurrency in all documents contained in the raw text corpus of file ``fname``, for all words *)

val term_count : ('a, float) Hashtbl.t -> 'a array -> unit
(** ``term_count count doc`` counts the term occurrency in a document, and saves the result in count hashtbl. *)

val density : t -> float
(** Return the percentage of non-zero elements in doc-term matrix. *)

val doc_to_vec : (float, 'a) Bigarray.kind -> t -> (int * float) array -> (float, 'a) Owl_dense.Ndarray.Generic.t
(** ``doc_to_vec kind tfidf vec`` converts a TFIDF vector from its sparse represents to dense ndarray vector whose length equals the vocabulary size. *)


(** {6 Iteration functions} *)

val get : t -> int -> (int * float) array
(** Return the ith TFIDF vector in the model. The format of return is ``(vocabulary index, weight)`` tuple array of a document. *)

val next : t -> (int * float) array
(** Return the next document vector in the model. The format of return is ``(vocabulary index, weight)`` tuple array of a document. *)

val next_batch : ?size:int -> t -> (int * float) array array
(** Return the next batch of document vectors in the model, the default size is 100. *)

val iteri : (int -> (int * float) array -> unit) -> t -> unit
(** Iterate all the document vectors in a TFIDF model. The format of document vector is ``(vocabulary index, weight)`` tuple array of a document. *)

val mapi : (int -> (int * float) array -> 'a) -> t -> 'a array
(** Map all the document vectors in a TFIDF model. The format of document vector is ``(vocabulary index, weight)`` tuple array of a document. *)

val reset_iterators : t -> unit
(** Reset the iterator to the begining of the TFIDF model. *)


(** {6 Core functions} *)

val build : ?norm:bool -> ?sort:bool -> ?tf:tf_typ -> ?df:df_typ -> Owl_nlp_corpus.t -> t
(**
This function builds up a TFIDF model according to the passed in paramaters.

Parameters:
* ``norm``: whether to normalise the vectors in the TFIDF model, default is ``false``.
* ``sort``: whether to sort the terms in a TFIDF vector in increasing order w.r.t their vocabulary indices. The default is ``false``.
* ``tf``: type of term frequency used in building TFIDF. The default is ``Count``.
* ``df``: type of document frequency used in building TFIDF. The default is ``Idf``.
* ``corpus``: the corpus built by ``Owl_nlp_corpus`` model atop of which TFIDF will be built.
 *)


(** {6 I/O functions} *)

val save : t -> string -> unit
(** ``save tfidf fname`` saves the TFIDF to a file of given file name ``fname``. *)

val load : string -> t
(** ``load fname`` loads a TFIDF from a file of name ``fname``. *)

val to_string : t -> string
(** Convert a TFIDF to its string representation, contains summary information. *)

val print : t -> unit
(** Pretty print out the summary information of a TFIDF model. *)


(** {6 Helper functions} *)

val tf_typ_string : tf_typ -> string
(** Convert term frequency type into string. *)

val df_typ_string : df_typ -> string
(** Convert document frequency type into string. *)

val apply : t -> string -> (int * float) array
(** Convert a single document according to a given model *)

val normalise : ('a * float) array -> ('a * float) array
(** ``normalise x`` makes ``x`` a unit vector by dividing its l2norm. *)

val create : tf_typ -> df_typ -> Owl_nlp_corpus.t -> t
(** Wrap up a TFIDF model type. Low-level function and you are not supposed to use it. *)

val all_pairwise_distance : Owl_nlp_similarity.t -> t -> ('a * float) array -> (int * float) array
(** Calculate pairwise distance for the whole model, return format is ``(id,dist)`` array. *)

val nearest : ?typ:Owl_nlp_similarity.t -> t -> ('a * float) array -> int -> (int * float) array
(** Return K-nearest neighbours, it is very slow due to linear search. *)
