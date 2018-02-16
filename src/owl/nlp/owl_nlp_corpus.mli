(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** NLP: Corpus module *)


(** {6 Type definition} *)

type t
(** Type of a text corpus. *)


val cleanup : t -> unit
(** TODO *)

val create : string -> int array -> int array -> in_channel option -> in_channel option -> Owl_nlp_vocabulary.t option -> int -> int array -> t
(** TODO *)

val get_uri : t -> string
(** TODO *)

val get_bin_uri : t -> string
(** TODO *)

val get_bin_fh : t -> in_channel
(** TODO *)

val get_tok_uri : t -> string
(** TODO *)

val get_tok_fh : t -> in_channel
(** TODO *)

val get_vocab_uri : t -> string
(** TODO *)

val get_vocab : t -> Owl_nlp_vocabulary.t
(** TODO *)

val get_docid : t -> int array
(** TODO *)

val length : t -> int
(** TODO *)

val next : t -> string
(** TODO *)

val next_tok : t -> int array
(** TODO *)

val iteri : (int -> 'a -> 'b) -> t -> unit
(** TODO *)

val iteri_tok : (int -> 'a -> 'b) -> t -> unit
(** TODO *)

val mapi : (int -> 'a -> 'b) -> t -> 'b array
(** TODO *)

val mapi_tok : (int -> 'a -> 'b) -> t -> 'b array
(** TODO *)

val get : t -> int -> string
(** TODO *)

val get_tok : t -> int -> int array
(** TODO *)

val reset_iterators : t -> unit
(** TODO *)

val next_batch : ?size:int -> t -> string array
(** TODO *)

val next_batch_tok : ?size:int -> t -> int array array
(** TODO *)

val tokenise : t -> string -> int array
(** TODO *)

val build : ?docid:int array -> ?stopwords:(string, 'a) Hashtbl.t -> ?lo:float -> ?hi:float -> ?vocab:Owl_nlp_vocabulary.t -> ?minlen:int -> string -> t
(** TODO *)

val unique : string -> string -> int array
(** TODO *)

val simple_process : string -> string
(** TODO *)

val preprocess : (string -> bytes) -> string -> string -> unit
(** TODO *)

val reduce_model : t -> t
(** TODO *)

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
