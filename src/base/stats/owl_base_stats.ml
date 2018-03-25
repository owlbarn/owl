(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let rand_gen = Random.State.make_self_init ()


let std_uniform_rvs () = Random.State.float rand_gen 1.

(* return [0, n - 1] *)
let uniform_int_rvs n = Random.State.int rand_gen n


let uniform a b =
  a +. (b -. a) *. (Random.State.float rand_gen 1.)

let bernoulli p =
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
let gaussian mu sigma =
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


(* Randomisation function *)

let shuffle x =
  let y = Array.copy x in
  let n = Array.length x in

  for i = n - 1 downto 1 do
    let s = float_of_int (i + 1) in
    let j = int_of_float (std_uniform_rvs () *. s) in
    Owl_utils_array.swap y i j
  done;

  y


let choose x k =
  let n = Array.length x in
  assert (n >= k);
  let y = Array.make k x.(0) in
  let i = ref 0 in
  let j = ref 0 in

  while !i < n && !j < k do
    let s = float_of_int (n - !i) in
    let l = int_of_float (s *. std_uniform_rvs ()) in
    if l < (k - !j) then (
      y.(!j) <- x.(!i);
      j := !j + 1;
    );
    i := !i + 1;
  done;

  y


let sample x k =
  let y = Array.make k x.(0) in
  let n = Array.length x in

  for i = 0 to k - 1 do
    let j = uniform_int_rvs n in
    y.(i) <- x.(j)
  done;

  y


(* Basic statistical functions *)

let sum x = Array.fold_left ( +. ) 0. x


let mean x =
  let n = float_of_int (Array.length x) in
  sum x /. n


let _get_mean m x =
  match m with
  | Some a -> a
  | None   -> mean x


let var ?mean x =
  let m = _get_mean mean x in
  let t = ref 0. in

  Array.iter (fun a ->
    let d = a -. m in
    t := !t +. d *. d
  ) x;

  let l = float_of_int (Array.length x) in
  let n = if l = 1. then 1. else l -. 1. in
  !t /. n


let std ?mean x = sqrt (var ?mean x)


let sem ?mean x =
  let s = std ?mean x in
  let n = float_of_int (Array.length x) in
  s /. (sqrt n)


let absdev ?mean x =
  let m = _get_mean mean x in
  let t = ref 0. in

  Array.iter (fun a ->
    let d = abs_float (a -. m) in
    t := !t +. d
  ) x;

  let n = float_of_int (Array.length x) in
  !t /. n


let skew ?mean ?sd x =
  let m = _get_mean mean x in
  let s = match sd with
    | Some a -> a
    | None   -> std ~mean:m x
  in
  let t = ref 0. in

  Array.iter (fun a ->
    let s = (a -. m) /. s in
    t := !t +. s *. s *. s
  ) x;

  let n = float_of_int (Array.length x) in
  !t /. n


let kurtosis ?mean ?sd x =
  let m = _get_mean mean x in
  let s = match sd with
    | Some a -> a
    | None   -> std ~mean:m x
  in
  let t = ref 0. in

  Array.iter (fun a ->
    let s = (a -. m) /. s in
    let u = s *. s in
    t := !t +. u *. u
  ) x;

  let n = float_of_int (Array.length x) in
  !t /. n



(* ends here *)
