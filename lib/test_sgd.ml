(** [
  test stochastic gradient decent algorithm on dense metrix.
]  *)

module MX = Matrix.Dense
module LL = Learn

let centerise x =
  let open MX in
  let v = average_rows x in
  map_by_row (fun x -> x -@ v) x

let test () =
  let p = MX.uniform_int 200 10 in
  let x = centerise (MX.uniform 10000 200) in
  let y = MX.(x $@ p) in
  let q = MX.uniform_int 200 10 in
  let p' = LL.sgd q x y in
  MX.(pprint (p' -@ p));
  Printf.printf "error ==> %.4f\n" MX.(sum (abs (p'-@ p)))

let test_small () =
  let p = MX.uniform_int 5 3 in
  let p = MX.map_at_row (fun _ -> 0.) p 4 in
  let x = MX.uniform 1000 5 in
  let x = MX.map_at_col (fun _ -> 1.) x 4 in
  let y = MX.(x $@ p) in
  let q = MX.uniform_int 5 3 in
  let p' = LL.sgd q x y in
  MX.(pprint (p));
  MX.(pprint (p'));
  MX.(pprint (p' -@ p));
  Printf.printf "error ==> %.4f\n" MX.(sum (abs (p'-@ p)))

let _ =
  test ()
