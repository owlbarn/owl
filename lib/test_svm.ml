(** [
  test stochastic gradient decent algorithm on dense metrix.
]  *)

module MX = Matrix.Dense
module LL = Learn

let generate_data () =
  let open MX in
  let x1 = gaussian 100 2 in
  let x2 = (gaussian 100 2) +$ 5. in
  let y1 = ones 100 1 in
  let y2 = zeros 100 1 in
  let x = x1 @= x2 in
  let y = y1 @|| y2 in
  dump x "test_svm.tmp"

let _ =
  generate_data ()
