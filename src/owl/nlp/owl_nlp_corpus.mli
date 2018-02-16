(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** NLP: Corpus module *)


(** {6 Type definition} *)

type t
(** Type of a text corpus. *)


(** {6 Query corpus} *)

val length : t -> int
(** Return the size of the corpus, i.e. number of documents. *)

val get : t -> int -> string
(** Return the ith document in the corpus. *)

val get_tok : t -> int -> int array
(** Return the ith tokenised document in the corpus. *)

val get_uri : t -> string
(** Return the path of the corpus. *)

val get_bin_uri : t -> string
(** Return the path of the binary format of corpus. *)

val get_bin_fh : t -> in_channel
(** Return the file handle of the binary formation of corpus. *)

val get_tok_uri : t -> string
(** Return the path of tokenised corpus. *)

val get_tok_fh : t -> in_channel
(** Return the file handle of the tokenised corpus. *)

val get_vocab_uri : t -> string
(** Return the path of vocabulary file associated with the corpus. *)

val get_vocab : t -> Owl_nlp_vocabulary.t
(** Return the vocabulary associated with the corpus. *)

val get_docid : t -> int array
(** Return a list of document ids which are mapped back to the original file where the corpus is built. *)


(** {6 Iterate functions} *)

val next : t -> string
(** Return the next document in the corpus. *)

val next_tok : t -> int array
(** Return the next tokenised document in the corpus. *)

val iteri : (int -> string -> unit) -> t -> unit
(** Iterate all the documents in the corpus, the index (line number) is passed in. *)

val iteri_tok : (int -> int array -> unit) -> t -> unit
(** Iterate the tokenised documents in the corpus, the index (line number) is passed in. *)

val mapi : (int -> string -> 'a) -> t -> 'a array
(** Map all the documents in a corpus into another array. The index (line number) is passed in. *)

val mapi_tok : (int -> 'a -> 'b) -> t -> 'b array
(** Map all the tokenised ocuments in a corpus into another array. The index (line number) is passed in. *)

val next_batch : ?size:int -> t -> string array
(** Return the next batch of documents in a corpus as a string array. The default ``size`` is 100. *)

val next_batch_tok : ?size:int -> t -> int array array
(** Return the next batch of tokenised documents in a corpus as a string array. The default ``size`` is 100. *)

val reset_iterators : t -> unit
(** Reset the iterator to the begining of the corpus. *)


(** {6 Core functions} *)

val build : ?docid:int array -> ?stopwords:(string, 'a) Hashtbl.t -> ?lo:float -> ?hi:float -> ?vocab:Owl_nlp_vocabulary.t -> ?minlen:int -> string -> t
(** TODO *)

val tokenise : t -> string -> int array
(** TODO *)

val unique : string -> string -> int array
(** TODO *)

val simple_process : string -> string
(** TODO *)

val preprocess : (string -> bytes) -> string -> string -> unit
(** TODO *)

val reduce_model : t -> t
(** TODO *)

val cleanup : t -> unit
(** Close the opened file handles associated with the corpus. *)

val create : string -> int array -> int array -> in_channel option -> in_channel option -> Owl_nlp_vocabulary.t option -> int -> int array -> t
(** TODO *)


(** {6 I/O functions} *)

val save : t -> string -> unit
(** TODO *)

val load : string -> t
(** TODO *)

val save_txt : t -> string -> unit
(** TODO *)

val to_string : t -> string
(** TODO *)

val print : t -> unit
(** TODO *)
