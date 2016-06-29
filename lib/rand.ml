(** [
  random generators
  ]  *)

type t = Gsl.Rng.t

let rng =
  let r = Gsl.Rng.make Gsl.Rng.RAND in
  let s = Nativeint.of_float (Unix.gettimeofday () *. 1000000.) in
  Gsl.Rng.set r s; r

let seed s = Gsl.Rng.set rng (Nativeint.of_int s)

let uniform_int ?(a=0) ?(b=65535) ()=
  (Gsl.Rng.uniform_int rng (b - a + 1)) + a

let uniform () = Gsl.Rng.uniform rng

let gaussian ?(sigma=1.) () = Gsl.Randist.gaussian rng sigma
