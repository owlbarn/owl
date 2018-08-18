(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** NLP: Vocabulary module *)


(** {6 Type definition} *)

type t
(** Type of vocabulary (or dictionary). *)


(** {6 Query vocabulary} *)

val get_w2i : t -> (string, int) Hashtbl.t
(** ``get_w2i v`` returns word -> index mapping of ``v``. *)

val get_i2w : t -> (int, string) Hashtbl.t
(** ``get_i2w v`` returns index -> word mapping of ``v``. *)

val exits_w : t -> string -> bool
(** ``exits_w v w`` returns ``true`` if word ``w`` exists in the vocabulary ``v``. *)

val exits_i : t -> int -> bool
(** ``exits_i i w`` returns ``true`` if index ``i`` exists in the vocabulary ``v``. *)

val word2index : t -> string -> int
(** ``word2index v w`` converts word ``w`` to its index using vocabulary ``v``. *)

val index2word : t -> int -> string
(** ``index2word v i`` converts index ``i`` to its corresponding word using vocabulary ``v``. *)


(** {6 Obtain properties} *)

val length : t -> int
(** ``length v`` returns the size of vocabulary ``v``. *)

val freq_i : t -> int -> int
(** ``freq_i v i`` returns the frequency of word of index ``i``. *)

val freq_w : t -> string -> int
(** ``freq_w v w`` returns the frequency of word ``w`` in the vocabulary ``v``. *)

val sort_freq : ?inc:bool -> t -> (int * int) array
(**
``sort_freq v`` returns the vocabulary as a ``(index, freq) array`` in
increasing or decreasing frequency specified by parameter ``inc``.
 *)

val top : t -> int -> (string * int) array
(** ``top v k`` returns the top ``k`` words in vocabulary ``v``. *)

val bottom : t -> int -> (string * int) array
(** ``bottom v k`` returns the bottom ``k`` words in vocabulary ``v``. *)

val re_index : t -> t
(** ``re_index v`` re-indexes the indices of words in vocabulary ``v``. *)


(** {6 Core functions} *)

val build : ?lo:float -> ?hi:float -> ?alphabet:bool -> ?stopwords:(string, 'a) Hashtbl.t -> string -> t
(**
``build ~lo ~hi ~stopwords fname`` builds a vocabulary from a text corpus file
of name ``fname``. If ``alphabet=false`` then tokens are the words separated by
white spaces; if ``alphabet=true`` then tokens are the characters and a
vocabulary of alphabets is returned.

Parameters:
  * ``lo``: percentage of lower bound of word frequency.
  * ``hi``: percentage of higher bound of word frequency.
  * ``alphabet`` : build vocabulary for alphabets or words.
  * ``fname``: file name of the text corpus, each line contains a doc.
 *)


val build_from_string : ?lo:float -> ?hi:float -> ?alphabet:bool -> ?stopwords:(string, 'a) Hashtbl.t -> string -> t
(**
``build_from_string`` is similar to ``build`` but builds the vocabulary from an
input string rather than a file.
 *)

val trim_percent : lo:float -> hi:float -> t -> t
(**
``trim_percent ~lo ~hi v`` remove extremely low and high frequency words based
on percentage of frequency.

Parameters:
  * ``lo``: the percentage of lower bound.
  * ``hi``: the percentage of higher bound.
*)

val trim_count : lo:int -> hi:int -> t -> t
(**
``trim_count ~lo ~hi v`` remove extremely low and high frequency words based
on absolute count of words.

Parameters:
  * ``lo``: the lower bound of number of occurrence.
  * ``hi``: the higher bound of number of occurrence.
 *)

val remove_stopwords : ('a, 'b) Hashtbl.t -> ('a, 'c) Hashtbl.t -> unit
(** ``remove_stopwords stopwords v`` removes the stopwords defined in a hashtbl from vocabulary ``v``. *)

val copy : t -> t
(** ``copy v`` makes a copy of vocabulary ``v``. *)

val tokenise : t -> string -> int array
(** ``tokenise v s`` tokenises the string ``s`` according to the vocabulary ``v``. *)

val w2i_to_tuples : t -> (string * int) list
(** ``w2w2i_to_tuples v`` converts vocabulary ``v`` to a list of ``(word, index)`` tuples. *)

val to_array : t -> (int * string) array
(** ``to_array v`` converts a vocabulary to a (word, index) array. *)

val of_array : (int * string) array -> t
(** ``of_array v`` converts a (word, index) array to a vocabulary. *)


(** {6 I/O functions} *)

val save : t -> string -> unit
(** ``save v fname`` serialises the vocabulary and saves it to a file of name ``s``. *)

val load : string -> t
(** ``load fname`` loads the serialised vocabulary from a file of name ``fname``. *)

val save_txt : t -> string -> unit
(** ``save_txt v fname`` saves the vocabulary in the text format to a file of name ``s``. *)

val to_string : t -> string
(** ``to_string v`` returns the summary information of a vocabulary. *)

val pp_vocab : Format.formatter -> t -> unit
(** Pretty printer for vocabulary type. *)
