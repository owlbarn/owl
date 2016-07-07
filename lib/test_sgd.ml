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
  let p = MX.uniform_int 100 10 in
  let x = centerise (MX.uniform 10000 100) in
  let y = MX.(x $@ p) in
  let q = MX.uniform_int 100 10 in
  let p' = LL.sgd ~r:LL.l2 q x y in
  MX.(pprint (p' -@ p));
  Printf.printf "error ==> %.4f\n" MX.(sum (abs (p'-@ p)))

let _ =
  test ()
