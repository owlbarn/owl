module MX = Matrix.Dense
module LL = Learn

let centerise x =
  let open MX in
  let v = average_rows x in
  map_by_row (fun x -> x -@ v) x

let test () =
  let p = MX.uniform_int 4 3 in
  let x = centerise (MX.uniform 100 4) in
  let y = MX.(x $@ p) in
  let q = MX.uniform_int 4 3 in
  let p' = LL.sgd ~r:LL.l2 q x y in
  print_endline "p' ==>";
  MX.pprint p';
  print_endline "p ==>";
  MX.pprint p


let _ =
  test ()
