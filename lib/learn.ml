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
  let cpts0 = fst (draw_rows x c) in
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
  x is a k x m matrix containing m classifiers of k features.
]  *)
let numerical_gradient f x =
  let open MX in
  let h = 0.00001 in
  let g = mapi_by_row ~d:(col_num x)
  (fun i v ->
    let fa = f (replace_row (v -$ h) x i) in
    let fb = f (replace_row (v +$ h) x i) in
    (fb -@ fa) /$ (2. *. h)
  ) x in g

(*let gradient f x =
  let h = 0.00001 in
  let fa = f MX.mapi () x
  let fb = f MX.(x +$ h) in
  MX.((fb -@ fa) /$ (2. *. h))*)


(** [ L1 regularisation ]  *)
let l1 x = MX.(sum (abs x))

(** [ L2 regularisation ]  *)
let l2 x = MX.(sum (x **@ 2.))

(** [ softmax loss function ]  *)
let hinge x = None

(** [
  a loss function for testing
  p is the model parameters.
  y' is the prediction.
  y is the labeled data.
]  *)
let loss y x p =
  let open MX in
  let y' = x $@ p in
  let r = (y' -@ y) **@ 2. in
  average_rows r

(** [
  Stochastic Gradient Descent (SGD) algorithm
  b : batch size
  s : step size
  t : stop criteria
  l : loss function
  g : gradient function
  p : model parameters (k * m), each column is a classifier. So we have m classifier of k features.
  x : data matrix (n x k), each row is a data point. So we have n datea points of k features each.
  y : labeled data (n x m), n data points and each is labeled with m classifiers
]  *)
let sgd ?(b=1) ?(s=0.01) ?(t=0.001) ?(l=loss) ?(g=numerical_gradient) p x y =
  let p = ref p in
  let imp = ref max_float in
  for i = 0 to 1000 do
    let xt, idx = MX.draw_rows x b in
    let yt = MX.rows y idx in
    let obj = MX.sum (l yt xt !p) in
    let _ = Printf.printf "iteration: %.4f\n" obj in
    let dt = g (l yt xt) !p in
    p := MX.(!p -@ (dt *$ s))
  done; p





(* ends here *)
