module Make (AD : Owl_algodiff_generic_sig.Sig) : sig
  val generate_test_samples : int * int -> int -> AD.t array * AD.t array

  module Reverse : sig

  val check
    :  threshold:float
    -> ?verbose:bool
    -> ?eps:float
    -> f:(AD.t -> AD.t)
    -> directions:AD.t array
    -> AD.t array
    -> bool * int
  end
   module Forward : sig

  val check
    :  threshold:float
    -> f:(AD.t -> AD.t)
    -> directions:AD.t array
    -> AD.t array
    -> bool  * int
  end 
end
