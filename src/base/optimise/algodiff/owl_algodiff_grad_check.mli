module Make (AD : Owl_algodiff_generic_sig.Sig) : sig
  val generate_test_samples : int * int -> int -> AD.t list * AD.t array

  val check_grad
    :  threshold:float
    -> ?verbose:bool
    -> ?eps:float
    -> f:(AD.t -> AD.t)
    -> directions:AD.t array
    -> AD.t list
    -> bool * int
end
