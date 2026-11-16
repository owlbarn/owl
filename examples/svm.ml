(* This example trains a linear SVM on two Gaussian clusters and reports the
   separating line and the training accuracy. *)

open Owl

let generate_data () =
  let open Mat in
  let c = 500 in
  let x1 = (gaussian c 2 *$ 2.) in
  let a, b = float_of_int (Random.int 15), float_of_int (Random.int 15) in
  let x1 = map_at_col (fun x -> x +. a) x1 0 in
  let x1 = map_at_col (fun x -> x +. b) x1 1 in
  let x2 = (gaussian c 2 *$ 2.) in
  let a, b = float_of_int (Random.int 15), float_of_int (Random.int 15) in
  let x2 = map_at_col (fun x -> x +. a) x2 0 in
  let x2 = map_at_col (fun x -> x +. b) x2 1 in
  let y1 = create c 1 ( 1.) in
  let y2 = create c 1 ( -1.)in
  let x = concat_vertical x1 x2 in
  let y = concat_vertical y1 y2 in
  x, y


(* the decision boundary is w0 * x + w1 * y + b = 0 *)
let report x y w b =
  let w0 = Mat.get w 0 0
  and w1 = Mat.get w 1 0
  and b = Mat.get b 0 0 in
  Printf.printf "separating line: %.4f * x + %.4f * y + %.4f = 0\n" w0 w1 b;
  let pred = Mat.(signum ((x *@ w) +$ b)) in
  let hits = Mat.(elt_equal pred y |> sum') in
  Printf.printf "training accuracy: %.1f%%\n" (100. *. hits /. float_of_int (Mat.row_num y))


let _ =
  let _ = Random.self_init () in
  let x, y = generate_data () in
  let r = Regression.D.svm ~i:true x y in
  report x y r.(0) r.(1)
