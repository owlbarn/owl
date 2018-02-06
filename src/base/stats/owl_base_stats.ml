(** Owl - Experimental *)

let rand_gen = Random.State.make_self_init ()

let get_uniform a b =
  a +. (b -. a) *. (Random.State.float rand_gen 1.)

let get_bernoulli p =
  assert (p >= 0. && p <= 1.);
  if (Random.State.float rand_gen 1.) <= p
  then 1.
  else 0.

let _u1 = ref 0.
let _u2 = ref 0.
let _case = ref false
let _z0 = ref 0.
let _z1 = ref 1.

(* TODO: use the polar, is more efficient *)
let get_gaussian mu sigma =
  if !_case
  then (_case := false; mu +. sigma *. !_z1)
  else (
    _case := true;
    _u1 := Random.State.float rand_gen 1.;
    _u2 := Random.State.float rand_gen 1.;
    _z0 := (sqrt ((~-. 2.) *. (log (!_u1)))) *.
           (cos (2. *. Owl_const.pi *. (!_u2)));
    _z1 := (sqrt ((~-. 2.) *. (log (!_u1)))) *.
           (sin (2. *. Owl_const.pi *. (!_u2)));
    mu +. sigma *. !_z0
  )
