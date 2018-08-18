(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** NLP: LDA module *)


(** {6 Type definition} *)

type lda_typ = SimpleLDA | FTreeLDA | LightLDA | SparseLDA
(** Type of LDA training algorithms. *)

type model
(** Type of LDA model. *)


(** {6 Core functions} *)

val init : ?iter:int -> int -> (string, int) Hashtbl.t -> Owl_nlp_corpus.t -> model
(**
``init ~iter k v d`` inits an LDA model for training. The default iteration is
100.

Parameters:
  * ``iter``: number of iterations.
  * ``k``: number of topics.
  * ``v``: vocabulary.
  * ``d``: corpus.
 *)

val train : lda_typ -> model -> unit
(** After calling ``init``, calling this function starts the training. *)


(** {6 Helper functions} *)

val show_info : model -> int -> float -> unit
(** Function for printing out log information, tailored for LDA training. *)

val include_token : model -> int -> int -> int -> unit
(** Include a token in model, used in training and you are not supposed to use it. *)

val exclude_token : model -> int -> int -> int -> unit
(** Exclude a token in model, used in training and you are not supposed to use it. *)
