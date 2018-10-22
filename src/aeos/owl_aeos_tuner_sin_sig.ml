module type Sig = sig

module Sin : sig

  type t = {
    mutable c_macro : string;
    mutable params  : int;
    mutable x       : int array;
  }

  val make : unit -> t

  val tune : t -> unit

  val to_string : t -> string

end

type tuner =
  | Sin of Sin.t

end
