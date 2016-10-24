(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [
  Machine learning library
  Note: C layout row-major matrix
  ]  *)

module MX = Owl_dense_real
module UT = Owl_utils

(** [
  K-means clustering algorithm
  x is the row-based data points and c is the number of clusters.
]  *)
let kmeans x c = let open MX in
  let cpts0 = fst (draw_rows x c) in
  let cpts1 = zeros c (col_num x) in
  let assignment = Array.make (row_num x) (0, max_float) in
  let _ = try for counter = 1 to 100 do
  Log.info "iteration %i ..." counter; flush stdout;
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
let numerical_gradient l p x y y' =
  let open MX in
  let h = 0.00001 in
  let f = l y in
  let g = mapi_by_row ~d:(col_num p)
  (fun i v ->
    let fa = f (x $@ (replace_row (v -$ h) p i)) in
    let fb = f (x $@ (replace_row (v +$ h) p i)) in
    (fb -@ fa) /$ (2. *. h)
  ) p in g


(* Regularisation functions *)

(** [ L1 regularisation and its subgradient ] *)
let l1 p = MX.(average_rows (abs p))

let l1_grad p =  (* TODO: I may change it to noisy unbiased subgradient in future *)
  MX.map (fun x ->
    if x > 0. then 1. else if x < 0. then (-1.) else 0.
  ) p

(** [ L2 regularisation and its grandient ]  *)
let l2 p = MX.(0.5 $* (average_rows (p *@ p)))

let l2_grad p = p

(** [ Elastic net regularisation and its gradient
  "a" is the weight on l1 regularisation term. ]  *)
let elastic a x = MX.(a $* (l1 x) +@ ((1. -. a) $* (l2 x)))

let elastic_grad a x =
  let g1 = l1_grad x in
  let g2 = l2_grad x in
  MX.(a $* g1 +@ (a $* g2))

(** [ No regularisation and its gradient ]  *)
let noreg x = MX.(zeros 1 (col_num x))

let noreg_grad x = MX.(zeros (row_num x) (col_num x))


(* Loss functions *)

(** [ least square loss function ]  *)
let square_loss y y' =
  let open MX in
  average_rows ((y' -@ y) **@ 2.)

let square_grad x y y' =
  let open MX in
  (transpose x) $@ (y' -@ y) /$ (float_of_int (row_num x))

(** [ hinge loss function ]  *)
let hinge_loss y y' =
  let open MX in
  let z = 1. $- ( y *@ y' ) in
  let z = map (Pervasives.max 0.) z in
  average_rows z

let hinge_grad x y y' =
  let open MX in
  let z = mapi (fun i j x ->
    if x < 1. then (0. -. y.{i,j}) else 0.
  ) (y *@ y') in
  (transpose x) $@ z /$ (float_of_int (row_num x))

(** [ squared hinge loss function ]  *)
let hinge2_loss y y' =
  let z = hinge_loss y y' in
  MX.(z *@ z)

let hinge2_grad x y y' = None

(** [ softmax loss function ]  *)
let softmax_loss y y' = None

let softmax_grad x y y' = None

(** [ logistic loss function ]  *)

let log_loss y y' =
  let z = MX.map (fun x ->
    if x > 18. then exp (-1. *. x)
    else if x < (-18.) then (-1. *. x)
    else log (1. +. exp(-1. *. x))
  ) MX.(y *@ y') in
  MX.average_rows z

let log_grad x y y' =
  let open MX in
  let y' = sigmoid y' in
  (transpose x) $@ (y' -@ y) /$ (float_of_int (row_num x))


(* Stochastic Gradient Descent related functions *)

let constant_rate a s c = 0.1

let optimal_rate a s c =
  let c = float_of_int c in
  s /. ((1. +. (a *. s *. c)) ** 0.75)

let decr_rate a s c = min 0.5 (1. /. (a *. float_of_int c))

let when_stable v c = v < 0.00001

let when_enough v c = (v < 0.00001 && c > 1000) || (c > 5000)


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
  i : whether to include intercept or not, default value is false
  p : model parameters (k * m), each column is a classifier. So we have m classifier of k features.
  x : data matrix (n x k), each row is a data point. So we have n datea points of k features each.
  y : labeled data (n x m), n data points and each is labeled with m classifiers
]  *)
let _sgd_basic b s t l g r o a i p x y =
  (* check whether the intercept is needed or not *)
  let p = if i = false then ref p
    else ref MX.(p @= uniform 1 (col_num p)) in
  let x = if i = false then x
    else MX.(x @|| ones (row_num x) 1) in
  let st = ref 0.1 in
  let cost = ref (Array.make 5000 0.) in
  let obj0 = ref max_float in
  let obj1 = ref min_float in
  let counter = ref 0 in
  while not (t (abs_float (!obj1 -. !obj0)) !counter) do
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
    let _ = st := s a !st !counter in
    let _ = p := MX.(!p -@ (dt *$ !st)) in
    let _ = obj1 := MX.sum lt in
    let _ = if !counter < (Array.length !cost) then !cost.(!counter) <- !obj1 in
    let _ = counter := !counter + 1 in
    Log.info "iteration #%i: %.4f" !counter !obj1;
    flush stdout
  done; !p

(** [
  wrapper of the _sgd_basic fucntion
]  *)
let sgd ?(b=1) ?(s=optimal_rate) ?(t=when_stable) ?(l=square_loss) ?(g=square_grad) ?(r=noreg) ?(o=noreg_grad) ?(a=0.) ?(i=false) p x y = _sgd_basic b s t l g r o a i p x y

let gradient_descent = None

(* TODO: wrap parameters into a record type *)


(** [ Support Vector Machine regression
  i : whether to include intercept bias in parameters
  note that the values in y are either +1 or -1.
 ]  *)
let svm_regression ?(i=false) p x y =
  let b = min 50 (MX.(row_num x) / 2) in
  let s = decr_rate in
  let t = when_enough in
  let l = hinge_loss in
  let g = hinge_grad in
  let r = l2 in
  let o = l2_grad in
  let a = 1. /. (float_of_int 100) in
  _sgd_basic b s t l g r o a i p x y

(** [ Ordinary Least Square regression
  i : whether to include intercept bias in parameters
]  *)
let ols_regression ?(i=true) x y =
  let b = 1 in
  let s = optimal_rate in
  let t = when_stable in
  let l = square_loss in
  let g = square_grad in
  let r = noreg in
  let o = noreg_grad in
  let a = 0. in
  let p = MX.(uniform (col_num x) (col_num y)) in
  _sgd_basic b s t l g r o a i p x y

(** [ Ridge regression
  i : whether to include intercept bias in parameters
  a : weight on the regularisation term
  TODO: how to choose a automatically
]  *)
let ridge_regression ?(i=true) ?(a=0.001) x y =
  let b = 1 in
  let s = optimal_rate in
  let t = when_stable in
  let l = square_loss in
  let g = square_grad in
  let r = l2 in
  let o = l2_grad in
  let p = MX.(uniform (col_num x) (col_num y)) in
  _sgd_basic b s t l g r o a i p x y

(** [ Lasso regression
  i : whether to include intercept bias in parameters
  a : weight on the regularisation term
  TODO: how to choose a automatically
]  *)
let lasso_regression ?(i=true) ?(a=0.001) x y =
  let b = 1 in
  let s = optimal_rate in
  let t = when_stable in
  let l = square_loss in
  let g = square_grad in
  let r = l1 in
  let o = l1_grad in
  let p = MX.(uniform (col_num x) (col_num y)) in
  _sgd_basic b s t l g r o a i p x y

(** [ Logistic regression
  i : whether to include intercept bias in parameters
  a : weight on the regularisation term
  note that the values in y are either +1 or 0.
]  *)
let logistic_regression ?(i=true) x y =
  let b = 1 in
  let s = optimal_rate in
  let t = when_stable in
  let l = log_loss in
  let g = log_grad in
  let r = noreg in
  let o = noreg_grad in
  let a = 0. in
  let p = MX.(uniform (col_num x) (col_num y)) in
  _sgd_basic b s t l g r o a i p x y





(* TODO: 'lbfgs', 'newton-cg', 'liblinear', 'sag' solvers *)
(* TODO: Simulated Annealing *)

(* ends here *)
