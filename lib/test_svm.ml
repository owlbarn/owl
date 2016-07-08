(** [
  test stochastic gradient decent algorithm on dense metrix.
]  *)

module MX = Matrix.Dense
module LL = Learn

let generate_data () =
  let open MX in
  let c = 500 in
  let x1 = (gaussian c 2 *$ 2.) in
  let a, b = float_of_int (Random.int 15), float_of_int (Random.int 15) in
  let x1 = map_at_col (fun x -> x +. a) x1 0 in
  let x1 = map_at_col (fun x -> x +. b) x1 1 in
  let x2 = (gaussian c 2 *$ 2.) in
  let a, b = float_of_int (Random.int 15), float_of_int (Random.int 15) in
  let x2 = map_at_col (fun x -> x +. a) x2 0 in
  let x2 = map_at_col (fun x -> x +. b) x2 1 in
  (*let x1 = map_at_col (fun x -> x -. 2.) (gaussian c 2) 0 in
  let x2 = map_at_col (fun x -> x +. 2.) (gaussian c 2) 0 in*)
  (*let x1 = map_at_col (fun x -> x -. 3.) (gaussian c 2) 0 in
  let x1 = map_at_col (fun x -> x +. 3.) x1 1 in
  let x2 = map_at_col (fun x -> x +. 3.) (gaussian c 2) 0 in
  let x2 = map_at_col (fun x -> x -. 3.) x2 1 in*)
  let y1 = create c 1 ( 1.) in
  let y2 = create c 1 (-1.)in
  let x = x1 @= x2 in
  let y = y1 @= y2 in
  let _ = dump x1 "test_svm.data1.tmp" in
  let _ = dump x2 "test_svm.data2.tmp" in
  x, y

let draw_line p =
  let a, b, c = 0., 20., 100 in
  let z = MX.empty c 2 in
  for i = 0 to c - 1 do
    let x = a +. (float_of_int i *. (b -. a) /. float_of_int c) in
    let y = (p.{0,0} *. x +. p.{2,0}) /. (p.{1,0} *. (-1.)) in
    z.{i,0} <- x; z.{i,1} <- y
  done; MX.dump z "test_svm.model.tmp"

let test x y =
  let x = MX.(x @|| (create (row_num x) 1 1.)) in
  let p = MX.uniform 3 1 in
  LL.svm p x y

let _ =
  let _ = Random.self_init () in
  let x, y = generate_data () in
  let p = test x y in
  draw_line p;
  MX.pprint p;
