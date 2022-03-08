(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(** NLP: LDA module *)

(** {5 Type definition} *)

type lda_typ =
  | SimpleLDA
  | FTreeLDA
  | LightLDA
  | SparseLDA (** Type of LDA training algorithms. *)

type model
(** Type of LDA model. *)

(** {5 Core functions} *)

val init : ?iter:int -> int -> Owl_nlp_corpus.t -> model
(**
``init ~iter k v d`` inits an LDA model for training. The default iteration is
100.

Parameters:
  * ``iter``: number of iterations.
  * ``k``: number of topics.
  * ``d``: corpus.
 *)

val train : lda_typ -> model -> unit
(** After calling ``init``, calling this function starts the training. *)

(** {5 Helper functions} *)

val show_info : model -> int -> float -> unit
(** Function for printing out log information, tailored for LDA training. *)

val include_token : model -> int -> int -> int -> unit
(** Include a token in model, used in training and you are not supposed to use it. *)

val exclude_token : model -> int -> int -> int -> unit
(** Exclude a token in model, used in training and you are not supposed to use it. *)
