(* An implementation of the Count-Min sketch introduced by
 * Cormode and Muthukrishnan. The Count-Min sketch provides an approximate
 * frequency table whose space and time complexity are independent of the
 * number of elements inserted.  It provides the following guarantee:
 * - Estimated frequency >= True frequency
 * - With probability at least 1 - delta:
 *      Estimated frequency - True frequency < epsilon * L
 * where L is the L1 norm of the data entered, equal to the total number of
 * times `incr` has been called.
 * Space usage will be O((1/epsilon) log (1/delta)) and the time to complete
 * `incr` or `count` will be O(log(1/delta)).
 * Refer to http://dimacs.rutgers.edu/~graham/pubs/papers/cm-full.pdf
 * for more details. *)

module type Sig = sig
  (** {6 Type definition} *)

  type 'a sketch
  (** The type of Count-Min sketches *)

  (** {6 Core functions} *)

  val init : epsilon:float -> delta:float -> 'a sketch
  (**
``init epsilon delta`` initializes a sketch with approximation ratio
``(1 + epsilon)`` and failure probability ``delta``.
  *)

  val incr : 'a sketch -> 'a -> unit
  (** ``incr s x`` increments the frequency count of ``x`` in sketch ``s`` in-place. *)

  val count : 'a sketch -> 'a -> int
  (** ``count s x`` returns the estimated frequency of element ``x`` in ``s``. *)

  val init_from : 'a sketch -> 'a sketch
  (** 
  ``init_from s`` initializes a new empty sketch with the same parameters as ``s``, which
  can later be merged with ``s``.
  *)

  val merge : 'a sketch -> 'a sketch -> 'a sketch
  (** 
  ``merge s1 s2`` returns a new sketch whose counts are the sum of those in ``s1`` and ``s2``.
  Raises ``INVALID_ARGUMENT`` if the parameters of ``s1`` and ``s2`` do not match.
  *)
end
