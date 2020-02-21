(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module type Sig = sig
  type elt

  type arr

  type t

  type op

  module type Siso = sig
    val label : string

    val ff_f : elt -> t

    val ff_arr : arr -> t

    val df : t -> t -> t -> t

    val dr : t -> t -> t ref -> t
  end

  val build_siso : (module Siso) -> t -> t
  (** build single input single output operations *)

  module type Sipo = sig
    val label : string

    val ff_f : elt -> t * t

    val ff_arr : arr -> t * t

    val df : t -> t -> t -> t

    val dr : t -> t -> t ref * t ref -> t ref * t ref -> t
  end

  val build_sipo : (module Sipo) -> t -> t * t
  (** build single input pair outputs operations *)

  module type Sito = sig
    val label : string

    val ff_f : elt -> t * t * t

    val ff_arr : arr -> t * t * t

    val df : t -> t -> t -> t

    val dr : t -> t -> t ref * t ref * t ref -> t ref * t ref * t ref -> t
  end

  val build_sito : (module Sito) -> t -> t * t * t
  (** build single input triple outputs operations *)

  module type Siao = sig
    val label : string

    val ff_f : elt -> t array

    val ff_arr : arr -> t array

    val df : t -> t -> t -> t

    val dr : t -> t -> t ref array -> t ref array -> t
  end

  val build_siao : (module Siao) -> t -> t array
  (** build single input array output operations *)

  module type Piso = sig
    val label : string

    val ff_aa : elt -> elt -> t

    val ff_ab : elt -> arr -> t

    val ff_ba : arr -> elt -> t

    val ff_bb : arr -> arr -> t

    val df_da : t -> t -> t -> t -> t

    val df_db : t -> t -> t -> t -> t

    val df_dab : t -> t -> t -> t -> t -> t

    val dr_ab : t -> t -> t -> t ref -> t * t

    val dr_a : t -> t -> t -> t ref -> t

    val dr_b : t -> t -> t -> t ref -> t
  end

  val build_piso : (module Piso) -> t -> t -> t
  (** build pair inputs single output operations *)

  module type Aiso = sig
    val label : string

    val ff : t array -> t

    val df : int list -> t -> t array -> t array -> t

    val dr : int list -> t array -> t -> t ref -> t list
  end

  val build_aiso : (module Aiso) -> t array -> t
  (** build array input single output operations *)
end
