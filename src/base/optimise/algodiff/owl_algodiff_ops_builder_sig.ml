module type Sig = sig
  type elt
  type arr
  type t

  module type Siso = sig
    val label : string
    val ff_f : elt -> t
    val ff_arr : arr -> t
    val df : t -> t -> t -> t
    val dr : t -> t -> t ref -> t
  end

  val build_siso : (module Siso) -> t -> t

  module type Sipo = sig
    val label : string
    val ff_f : elt -> t * t
    val ff_arr : arr -> t * t
    val df : t -> t -> t -> t
    val dr : t -> t -> t ref * t ref -> t ref * t ref -> t
  end

  val build_sipo : (module Sipo) -> t -> t * t

  module type Sito = sig
    val label : string
    val ff_f : elt -> t * t * t
    val ff_arr : arr -> t * t * t
    val df : t -> t -> t -> t
    val dr : t -> t -> t ref * t ref * t ref -> t ref * t ref * t ref -> t
  end

  val build_sito : (module Sito) -> t -> t * t * t

  module type Siao = sig
    val label : string
    val ff_f : elt -> t array
    val ff_arr : arr -> t array
    val df : t -> t -> t -> t
    val dr : t -> t -> t ref array -> t ref array -> t
  end

  val build_siao : (module Siao) -> t -> t array

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
end
