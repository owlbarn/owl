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
  (* The type of Count-Min sketches *)
  type 'a sketch

  (* `init epsilon delta` initializes a sketch with approximation
   * ratio (1 + epsilon) and failure probability delta *)
  val init : epsilon:float -> delta:float -> 'a sketch

  (* `incr s x` increments the frequency count of `x` in sketch `s` in-place *)
  val incr : 'a sketch -> 'a -> unit

  (* `count s x` returns the estimated frequency of element `x` in `s` *)
  val count : 'a sketch -> 'a -> int
end
