(* A sketch to get the approximate heavy hitters from a dataset.
 * A heavy-hitters sketch with threshold `k` will output all elements
 * that have been added to it at least `n/k` times (where `n` is the
 * total number of elements that have been added).
 * Approximation behavior: with probability at least 1 - delta, the data
 * structure outputs every element that appears at least `n/k` times, and
 * every element output appears at least `n/k - (epsilon * n)` times.
 * This implementation uses the Count-Min sketch implemented in
 * `owl-countmin-sketch.ml`.
 * Refer to http://dimacs.rutgers.edu/~graham/pubs/papers/cm-full.pdf
 * section 5.2 (page 12) for more details. *)

module type Sig = sig
  (** {6 Type definition} *)

  type 'a t
  (** The type of heavy-hitters sketches *)

  (** {6 Core functions} *)

  val init : k:float -> epsilon:float -> delta:float -> 'a t
  (**
`init k epsilon delta` initializes a sketch with threshold k, approximation
factor epsilon, and failure probability delta.
  *)

  val add : 'a t -> 'a -> unit
  (** `add h x` adds value `x` to sketch `h` in-place. *)

  val get : 'a t -> ('a * int) list
  (**
`get h` returns a list of all heavy-hitters in sketch `h`, as a
(value, frequency) pair, sorted in decreasing order of frequency.
  *)
end
