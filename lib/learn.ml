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
  a numberical way of calculating gradient.
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


(* Regularisation functions *)

(** [ L1 regularisation and its gradient ]  *)
let l1 p = MX.(average_rows (abs p))

let l1_grad p =
  MX.map (fun x ->
    if x > 0. then 1. else if x < 0. then (-1.) else 0.
  ) p

(** [ L2 regularisation and its grandient ]  *)
let l2 p = MX.(0.5 $* (average_rows (p *@ p)))

let l2_grad p = p

(** [ Elastic net regularisation and its gradient
  "a" is l1 ration ]  *)
let elastic a x = MX.(a $* (l1 x) +@ ((1. -. a) $* (l2 x)))

let elastic_grad a x =
  let g1 = l1_grad x in
  let g2 = l2_grad x in
  MX.(a $* g1 +@ (a $* g2))

(** [ No regularisation ]  *)
let noreg x = MX.(zeros 1 (col_num x))

let noreg_grad x = MX.(zeros (row_num x) (col_num x))

(* Loss functions *)

(** [ hinge loss function ]  *)
let hinge_loss y y' =
  let open MX in
  let z = 1. $- ( y *@ y' ) in
  map (Pervasives.max 0.) z

let hinge_grad x = None

let squaredhinge_loss y y' =
  let z = hinge_loss y y' in
  MX.(z *@ z)

(** [ softmax loss function ]  *)
let softmax_loss y y' = None

let softmax_grad y y' = None

let log_loss y y' = None


(** [
  least square loss function for testing
  p is the model parameters.
  y' is the prediction.
  y is the labeled data.
]  *)

let leastsquare_loss y y' =
  let open MX in
  average_rows ((y' -@ y) **@ 2.)
  (*if a = 0. then l else l +$ (a *. (r p))*)

let leastsquare_grad x y y' =
  let open MX in
  let z = y' -@ y in
  mapi_by_col ~d:(col_num x)
  (fun i v ->
    let k = mapi_by_row ~d:(col_num x) (fun j u -> u *$ v.{j,0}) x in
    transpose (average_rows k)
  ) z

(* learning rate scheduling *)

let constant_rate () = 0.1

let optimal_rate () = 0.1

(** [
  Stochastic Gradient Descent (SGD) algorithm
  b : batch size
  s : step size
  t : stop criteria
  l : loss function
  g : gradient function of the loss function
  r : regularisation function
  o : gradient fucntion of the regularisation function
  a : weight on the regularisation term, common setting is 0.0001
  p : model parameters (k * m), each column is a classifier. So we have m classifier of k features.
  x : data matrix (n x k), each row is a data point. So we have n datea points of k features each.
  y : labeled data (n x m), n data points and each is labeled with m classifiers
]  *)
let _sgd_basic b s t l g r o a p x y =
  let p = ref p in
  let obj0 = ref max_float in
  let obj1 = ref min_float in
  let counter = ref 0 in
  while (abs_float (!obj1 -. !obj0)) > t do
    let _ = obj0 := !obj1 in
    (* draw random samples for data *)
    let xt, idx = MX.draw_rows x b in
    let yt = MX.rows y idx in
    (* predict then estimate the loss and gradient *)
    let yt' = MX.(xt $@ !p) in
    let lt = l yt yt' in
    let dt = g xt yt yt' in
    (* check if it is regularised *)
    let lt = if a = 0. then lt else MX.(lt +@ (a $* (r !p))) in
    let dt = if a = 0. then dt else MX.(dt +@ (a $* (o !p))) in
    (* update the gradient with step size *)
    let _ = p := MX.(!p -@ (dt *$ s)) in
    let _ = obj1 := MX.sum lt in
    let _ = counter := !counter + 1 in
    Printf.printf "iteration #%i: %.4f\n" !counter !obj1;
    flush stdout
  done; !p

(** [
  wrapper for _sgd_basic fucntion
]  *)
let _sgd ?(b=1) ?(s=0.1) ?(t=0.00001) ?(l=leastsquare_loss) ?(g=leastsquare_grad) ?(r=noreg) ?(o=noreg_grad) ?(a=0.) p x y = _sgd_basic b s t l g r o a p x y

let sgd ?(b=1) ?(s=0.1) ?(t=0.00001) ?(l=leastsquare_loss) ?(g=leastsquare_grad) ?(r=noreg) ?(o=noreg_grad) ?(a=0.0001) p x y = _sgd_basic b s t l g r o a p x y


(* TODO: step size scheduling needs to be implemented *)


(* ends here *)
