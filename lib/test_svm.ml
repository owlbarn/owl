(** [
  test stochastic gradient decent algorithm on dense metrix.
]  *)

module MX = Matrix.Dense
module LL = Learn

let generate_data () =
  let open MX in
  let c = 100 in
  let x1 = (gaussian c 2) +$ 5. in
  let x2 = (gaussian c 2) +$ 8. in
  (*let x1 = map_at_col (fun x -> x -. 2.) (gaussian c 2) 0 in
  let x2 = map_at_col (fun x -> x +. 2.) (gaussian c 2) 0 in*)
  let y1 = create c 1 ( 1.) in
  let y2 = create c 1 (-1.)in
  let x = x1 @= x2 in
  let y = y1 @= y2 in
  let _ = dump x "test_svm.data.tmp" in
  x, y

let draw_line p =
  let z = MX.empty 100 2 in
  for i = 0 to (MX.row_num z) - 1 do
    let x = (-4.) +. (0.1 *. float_of_int i) in
    let y = (p.{0,0} *.x +. p.{2,0}) /. p.{1,0} *. (-1.) in
    z.{i,0} <- x; z.{i,1} <- y
  done; MX.dump z "test_svm.model.tmp"

let test x y =
  let x = MX.(x @|| (zeros (row_num x) 1)) in
  let p = MX.uniform 3 1 in
  LL.svm p x y

let _ =
  let x, y = generate_data () in
  let p = test x y in
  draw_line p;
  MX.pprint p;
