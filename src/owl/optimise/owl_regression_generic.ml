(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

module Make (Optimise : Owl_optimise_generic_sig.Sig) = struct
  module Optimise = Optimise
  open Optimise
  open Optimise.Algodiff

  (* iterative sovler for linear regression *)
  let _linear_reg bias params x y =
    let s = A.shape x in
    let l, m = s.(0), s.(1) in
    let n = A.col_num y in
    let o = if bias = true then m + 1 else m in
    let x = if bias = true then A.concatenate ~axis:1 [| x; A.ones [| l; 1 |] |] else x in
    (* initialise the matrices according to fan_in/out *)
    let r = 1. /. float_of_int o in
    let p = Arr A.(uniform ~a:(float_to_elt (-.r)) ~b:(float_to_elt r) [| o; n |]) in
    (* make the function to minimise *)
    let f w x =
      let w = Mat.reshape o n w in
      Maths.(x *@ w)
    in
    (* get the result, reshape, then return *)
    let w =
      minimise_weight params f (Maths.flatten p) (Arr x) (Arr y)
      |> snd
      |> Mat.reshape o n
      |> unpack_arr
    in
    match bias with
    | true  -> A.split ~axis:0 [| m; 1 |] w
    | false -> [| w |]


  (* Direct solvers. The heavy lifting (SVD, linear solves) is done by LAPACK
     through [A.Linalg]; the small scalar loops run on OCaml floats, which is
     exact for float64 and more precise than needed for float32. *)

  let _check_rows fname x y =
    if A.row_num x <> A.row_num y
    then
      invalid_arg
        (Printf.sprintf
           "Owl_regression.%s: x has %i rows but y has %i"
           fname
           (A.row_num x)
           (A.row_num y))


  let _to_rows a =
    Array.init (A.row_num a) (fun i ->
        Array.init (A.col_num a) (fun j -> A.get a [| i; j |] |> A.elt_to_float))


  let _of_rows r c rows =
    let data = Array.make (r * c) (A.float_to_elt 0.) in
    Array.iteri
      (fun i row -> Array.iteri (fun j v -> data.((i * c) + j) <- A.float_to_elt v) row)
      rows;
    A.of_array data [| r; c |]


  (* machine epsilon of the element type, float32 or float64 *)
  let _eps =
    if A.elt_to_float (A.float_to_elt (1. +. 1e-10)) = 1.
    then 1.1920928955078125e-07
    else epsilon_float


  (* [_svd_solve filter x y] returns [V diag (filter s) U' y] for the thin SVD
     [x = U diag s V']; [filter] maps the singular values to the diagonal *)
  let _svd_solve filter x y =
    let u, s, vt = A.Linalg.svd ~thin:true x in
    let k = A.numel s in
    let s = Array.init k (fun i -> A.get s [| 0; i |] |> A.elt_to_float) in
    let d = filter s |> Array.map (fun v -> [| v |]) |> _of_rows k 1 in
    A.(dot (transpose vt) (mul d (dot (transpose u) y)))


  (* singular values below this are treated as zero, as in numpy.linalg.lstsq *)
  let _cutoff x s =
    let s_max = Array.fold_left Float.max 0. s in
    _eps *. float_of_int (max (A.row_num x) (A.col_num x)) *. s_max


  (* minimum-norm least-squares solution of [x w = y] *)
  let _lstsq x y =
    _svd_solve
      (fun s ->
        let c = _cutoff x s in
        Array.map (fun v -> if v > c then 1. /. v else 0.) s)
      x
      y


  (* minimiser of [||y - x w||^2 + alpha ||w||^2] *)
  let _ridge_solve alpha x y =
    _svd_solve
      (fun s ->
        let c = _cutoff x s in
        Array.map (fun v -> if v > c then v /. ((v *. v) +. alpha) else 0.) s)
      x
      y


  let _soft_threshold v t = if v > t then v -. t else if v < -.t then v +. t else 0.

  (* Cyclic coordinate descent for [||y - x w||^2 + l1 ||w||_1 + l2 ||w||^2],
     one output column at a time. *)
  let _coordinate_descent ?(tol = 1e-10) ?(max_iter = 10_000) ~l1 ~l2 x y =
    let xr = _to_rows x
    and yr = _to_rows y in
    let l = A.row_num x
    and m = A.col_num x
    and n = A.col_num y in
    let cols = Array.init m (fun j -> Array.init l (fun i -> xr.(i).(j))) in
    let sq = Array.map (Array.fold_left (fun a v -> a +. (v *. v)) 0.) cols in
    let w = Array.make_matrix m n 0. in
    for k = 0 to n - 1 do
      (* residual of the current weights, which start at zero *)
      let r = Array.init l (fun i -> yr.(i).(k)) in
      let converged = ref false
      and iter = ref 0 in
      while (not !converged) && !iter < max_iter do
        incr iter;
        let max_delta = ref 0.
        and max_w = ref 0. in
        for j = 0 to m - 1 do
          let xj = cols.(j)
          and wj = w.(j).(k) in
          let rho = ref (sq.(j) *. wj) in
          for i = 0 to l - 1 do
            rho := !rho +. (xj.(i) *. r.(i))
          done;
          let denom = sq.(j) +. l2 in
          let wj' = if denom = 0. then 0. else _soft_threshold !rho (l1 /. 2.) /. denom in
          let d = wj' -. wj in
          if d <> 0.
          then (
            for i = 0 to l - 1 do
              r.(i) <- r.(i) -. (xj.(i) *. d)
            done;
            w.(j).(k) <- wj';
            max_delta := Float.max !max_delta (Float.abs d));
          max_w := Float.max !max_w (Float.abs wj')
        done;
        if !max_delta <= tol *. Float.max 1. !max_w then converged := true
      done
    done;
    _of_rows m n w


  (* Fits a linear model with [solve] and returns [[| w |]] or, with an
     intercept, [[| w; b |]]. With an intercept the columns of [x] and [y] are
     centred first, so that a penalty in [solve] never applies to [b]. *)
  let _fit_linear fname i solve x y =
    _check_rows fname x y;
    if i
    then (
      let l = A.row_num x in
      let avg = _of_rows 1 l [| Array.make l (1. /. float_of_int l) |] in
      let xm = A.dot avg x
      and ym = A.dot avg y in
      let w = solve A.(sub x xm) A.(sub y ym) in
      [| w; A.(sub ym (dot xm w)) |])
    else [| solve x y |]


  let ols ?(i = false) x y = _fit_linear "ols" i _lstsq x y

  let ridge ?(i = false) ?(alpha = 0.001) x y =
    if alpha < 0. then invalid_arg "Owl_regression.ridge: alpha must be non-negative";
    _fit_linear "ridge" i (_ridge_solve alpha) x y


  let lasso ?(i = false) ?(alpha = 0.001) x y =
    if alpha < 0. then invalid_arg "Owl_regression.lasso: alpha must be non-negative";
    _fit_linear "lasso" i (_coordinate_descent ~l1:alpha ~l2:0.) x y


  let elastic_net ?(i = false) ?(alpha = 1.0) ?(l1_ratio = 0.5) x y =
    if alpha < 0. then invalid_arg "Owl_regression.elastic_net: alpha must be non-negative";
    if l1_ratio < 0. || l1_ratio > 1.
    then invalid_arg "Owl_regression.elastic_net: l1_ratio must be in [0, 1]";
    let l1 = alpha *. l1_ratio in
    let l2 = alpha *. (1. -. l1_ratio) /. 2. in
    _fit_linear "elastic_net" i (_coordinate_descent ~l1 ~l2) x y


  let svm ?(i = false) ?(a = 0.001) x y =
    let params =
      Params.config
        ~batch:Batch.Full
        ~learning_rate:(Learning_Rate.Adagrad 1.)
        ~gradient:Gradient.GD
        ~loss:Loss.Hinge
        ~regularisation:(Regularisation.L2norm a)
        ~verbosity:false
        ~stopping:(Stopping.Const 1e-16)
        1000.
    in
    _linear_reg i params x y


  (* log (1 + exp z) and 1 / (1 + exp (-z)) without overflow *)
  let _softplus z = if z > 0. then z +. log1p (exp (-.z)) else log1p (exp z)

  let _sigmoid z =
    if z >= 0.
    then 1. /. (1. +. exp (-.z))
    else (
      let e = exp z in
      e /. (1. +. e))


  let _dot a b =
    let s = ref 0. in
    Array.iteri (fun i v -> s := !s +. (v *. b.(i))) a;
    !s


  (* Newton's method with backtracking line search on the negative
     log-likelihood [sum (softplus z - y z)], [z = x w], for one column [y] of
     targets in [0, 1]. On separable data the likelihood has no maximiser; the
     iteration then stops after [max_iter] steps with large weights that still
     classify every point correctly. Otherwise it stops when the gradient
     vanishes or the line search can no longer decrease the loss. *)
  let _logistic_column ?(max_iter = 100) xr y =
    let l = Array.length xr in
    let o = if l = 0 then 0 else Array.length xr.(0) in
    let loss w =
      let s = ref 0. in
      Array.iteri
        (fun i row ->
          let z = _dot row w in
          s := !s +. _softplus z -. (y.(i) *. z))
        xr;
      !s
    in
    let w = ref (Array.make o 0.) in
    let finished = ref false
    and iter = ref 0 in
    while (not !finished) && !iter < max_iter do
      incr iter;
      let p = Array.map (fun row -> _sigmoid (_dot row !w)) xr in
      let g = Array.make o 0. in
      let h = Array.make_matrix o o 0. in
      Array.iteri
        (fun i row ->
          let e = p.(i) -. y.(i)
          and c = p.(i) *. (1. -. p.(i)) in
          for a = 0 to o - 1 do
            g.(a) <- g.(a) +. (row.(a) *. e);
            for b = 0 to o - 1 do
              h.(a).(b) <- h.(a).(b) +. (c *. row.(a) *. row.(b))
            done
          done)
        xr;
      if Array.for_all (fun v -> Float.abs v <= 1e-12 *. float_of_int (max l 1)) g
      then finished := true
      else (
        (* a tiny damping keeps the system solvable when [h] is singular *)
        let trace = ref 0. in
        for a = 0 to o - 1 do
          trace := !trace +. h.(a).(a)
        done;
        let delta = 1e-10 *. (1. +. (!trace /. float_of_int o)) in
        for a = 0 to o - 1 do
          h.(a).(a) <- h.(a).(a) +. delta
        done;
        let d =
          A.Linalg.linsolve (_of_rows o o h) (_of_rows o 1 (Array.map (fun v -> [| v |]) g))
          |> _to_rows
          |> Array.map (fun r -> r.(0))
        in
        let f0 = loss !w
        and slope = _dot g d in
        let step t = Array.mapi (fun a v -> v -. (t *. d.(a))) !w in
        let t = ref 1. in
        while loss (step !t) > f0 -. (1e-4 *. !t *. slope) && !t > 1e-12 do
          t := !t /. 2.
        done;
        (* no further decrease is possible at this precision *)
        if !t <= 1e-12 || slope <= 0. then finished := true else w := step !t)
    done;
    !w


  let logistic ?(i = false) x y =
    _check_rows "logistic" x y;
    let yr = _to_rows y in
    if not (Array.for_all (Array.for_all (fun v -> v >= 0. && v <= 1.)) yr)
    then invalid_arg "Owl_regression.logistic: targets must be in [0, 1]";
    let m = A.col_num x
    and n = A.col_num y in
    let xr = _to_rows x in
    let xr = if i then Array.map (fun r -> Array.append r [| 1. |]) xr else xr in
    let o = if i then m + 1 else m in
    let ws =
      Array.init n (fun k -> _logistic_column xr (Array.map (fun r -> r.(k)) yr))
    in
    let w = _of_rows o n (Array.init o (fun a -> Array.init n (fun k -> ws.(k).(a)))) in
    if i then A.split ~axis:0 [| m; 1 |] w else [| w |]


  (* Variable projection: for a fixed rate [l] the model [a exp (-l x) + b] is
     linear in [a] and [b], so the residual can be minimised over [l] alone.
     [l] is searched on a grid of [l * range x] in [-50, 50] and refined by
     golden-section search. *)
  let exponential ?(_i = false) x y =
    if A.numel x <> A.numel y
    then invalid_arg "Owl_regression.exponential: x and y must have the same size";
    let n = A.numel x in
    let flat a = A.reshape a [| n; 1 |] |> _to_rows |> Array.map (fun r -> r.(0)) in
    let xs = flat x
    and ys = flat y in
    let x0 = Array.fold_left Float.min infinity xs
    and x1 = Array.fold_left Float.max neg_infinity xs in
    let range = x1 -. x0 in
    if n < 3 || not (range > 0.)
    then invalid_arg "Owl_regression.exponential: needs at least 3 distinct x values";
    let ym = Array.fold_left ( +. ) 0. ys /. float_of_int n in
    (* best [a'] and [b] for [a' exp (-l (x - x0)) + b], and the residual *)
    let fit l =
      let e = Array.map (fun x -> exp (-.l *. (x -. x0))) xs in
      let em = Array.fold_left ( +. ) 0. e /. float_of_int n in
      let sxy = ref 0.
      and sxx = ref 0. in
      Array.iteri
        (fun k ek ->
          sxy := !sxy +. ((ek -. em) *. (ys.(k) -. ym));
          sxx := !sxx +. ((ek -. em) *. (ek -. em)))
        e;
      let a' = if !sxx > 0. then !sxy /. !sxx else 0. in
      let b = ym -. (a' *. em) in
      let r = ref 0. in
      Array.iteri
        (fun k ek ->
          let d = ys.(k) -. (a' *. ek) -. b in
          r := !r +. (d *. d))
        e;
      a', b, !r
    in
    let cost t =
      let _, _, r = fit (t /. range) in
      r
    in
    let steps = 400 in
    let grid = Array.init (steps + 1) (fun k -> -50. +. (100. *. float_of_int k /. float_of_int steps)) in
    let costs = Array.map cost grid in
    let best = ref 0 in
    Array.iteri (fun k c -> if c < costs.(!best) then best := k) costs;
    let lo = ref grid.(max 0 (!best - 1))
    and hi = ref grid.(min steps (!best + 1)) in
    let phi = (sqrt 5. -. 1.) /. 2. in
    for _ = 1 to 200 do
      let c = !hi -. (phi *. (!hi -. !lo))
      and d = !lo +. (phi *. (!hi -. !lo)) in
      if cost c < cost d then hi := d else lo := c
    done;
    let t = (!lo +. !hi) /. 2. in
    let t = if cost t <= costs.(!best) then t else grid.(!best) in
    let l = t /. range in
    let a', b, _ = fit l in
    let a = a' *. exp (l *. x0) in
    A.float_to_elt a, A.float_to_elt l, A.float_to_elt b


  let poly x y n =
    let z =
      Array.init (n + 1) (fun i -> A.(pow_scalar x (float_of_int i |> float_to_elt)))
    in
    let x = A.concatenate ~axis:1 z in
    let params =
      Params.config
        ~batch:Batch.Full
        ~learning_rate:(Learning_Rate.Const 1.)
        ~gradient:Gradient.Newton
        ~loss:Loss.Quadratic
        ~verbosity:false
        ~stopping:(Stopping.Const 1e-16)
        100.
    in
    (_linear_reg false params x y).(0)
end
