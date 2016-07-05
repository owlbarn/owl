(** [
  Machine learning library
  Note: Fortran layout column-based matrix
  ]  *)

module MX = Matrix.Dense
module UT = Utils

(** [
  k-means clustering algorithm
  x is the row-based data points and c is the number of clusters.
]  *)
let kmeans x c = let open MX in
  let cpts0 = draw_rows x c in
  let cpts1 = zeros c (col_num x) in
  let assignment = Array.make (row_num x) (0, max_float) in
  let _ = try for counter = 1 to 100 do
  Printf.printf "iteration %i ...\n" counter; flush stdout;
  iteri_rows (fun i v ->
    iteri_rows (fun j u ->
      let e = sum((v -@ u) **@ 2.) in
      if e < snd assignment.(i) then assignment.(i) <- (j, e)
    ) cpts0
  ) x;
  iteri_rows (fun j u ->
    let l = UT.filteri_array (fun i y -> fst y = j, i) assignment in
    let z = average_rows (rows x l) in
    let _ = copy_row_to z cpts1 j in ()
  ) cpts0;
  if cpts0 =@ cpts1 then failwith "converged" else ignore (cpts0 << cpts1)
  done with exn -> () in
  cpts1, UT.map_array fst assignment


(** [
  numberical way to calculate gradient.
  x is a matrix containing the varialbles.
]  *)
let numerical_gradient f x =
  let h = 0.00001 in
  let fa = MX.map f MX.(x -$ h) in
  let fb = MX.map f MX.(x +$ h) in
  MX.((fb -@ fa) /$ (2. *. h))

(** [
  Stochastic Gradient Descent (SGD) algorithm
  b : batch size
  s : step size
  t : stop criteria
  f : loss function
  p : model parameters
  x : data points
  y : labels
]  *)
let sgd b s t f p x  = None


(* ends here *)
