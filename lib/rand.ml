(** [
  random generators
  ]  *)


let rng = Gsl.Rng.make Gsl.Rng.RAND

let gaussian () = Gsl.Randist.gaussian rng 1.
