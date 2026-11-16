(** Unit test for the building blocks of [Owl_optimise] and for [minimise_fun].

    Expected values are computed with plain OCaml floats from the textbook
    formulas, so a test failing here means Owl disagrees with the formula, not
    with an earlier version of itself.

    Tests registered with [known_bug] describe the correct behaviour of a defect
    that is still present. They are skipped unless [OWL_TEST_KNOWN_BUGS=1] is
    set; once the defect is fixed, turn them into ordinary tests. *)

open Owl_optimise.D
open Algodiff

let tol = 1e-9

(* a 1 x n row vector, the layout used by Owl's optimisers *)
let row l = Arr (A.of_array (Array.of_list l) [| 1; List.length l |])

let to_list x = unpack_arr x |> Owl_dense_ndarray.D.to_array |> Array.to_list

let close ?(tol = tol) a b = Float.abs (a -. b) <= tol

let close_list ?tol x l =
  let x = to_list x in
  List.length x = List.length l && List.for_all2 (close ?tol) x l


let scalar x = unpack_flt x

let dot a b = List.fold_left2 (fun s a b -> s +. (a *. b)) 0. a b

let sub a b = List.map2 ( -. ) a b

let neg a = List.map (fun a -> -.a) a

let axpy alpha x y = List.map2 (fun x y -> (alpha *. x) +. y) x y

(* data shared by the loss tests: y is the target, y' the prediction *)
let y = [ 1.; 0.; -1.; 2. ]

let y' = [ 0.5; 0.5; -1.; 0. ]

let loss typ = Loss.run typ (row y) (row y') |> scalar

(* data shared by the gradient tests: previous gradient [g], previous
   direction [p] and current gradient [g'] *)
let g = [ 1.; 2.; -0.5 ]

let p = [ -1.; -2.; 0.5 ]

let g' = [ 0.5; -1.; 0.25 ]

let direction typ =
  let w = row [ 0.; 0.; 0. ] in
  Gradient.run typ (fun x -> x) w (row g) (row p) (row g')


let raises_failure f =
  try
    ignore (f ());
    false
  with
  | Failure _ -> true


let quiet_params ?gradient ?learning_rate ?momentum ?stopping ?checkpoint epochs =
  Params.config
    ?gradient
    ?learning_rate
    ?momentum
    ?stopping
    ?checkpoint
    ~verbosity:false
    epochs


(* f(x) = sum ((x - t)^2), minimised at t *)
let target = [ 3.; -1.; 0.5; 2. ]

let quadratic x = Maths.(l2norm_sqr' (x - row target))

let x0 () = row [ 0.; 0.; 0.; 0. ]

module To_test = struct
  (* Loss *)

  let loss_quadratic () = close (loss Loss.Quadratic) 4.5

  let loss_l1norm () = close (loss Loss.L1norm) 3.

  let loss_l2norm () = close (loss Loss.L2norm) (sqrt 4.5)

  (* sum (max 0 (1 - y * y')) = 0.5 + 1 + 0 + 1 *)
  let loss_hinge () = close (loss Loss.Hinge) 2.5

  (* -sum (y * log y') with a one-hot target *)
  let loss_cross_entropy () =
    let l = Loss.run Loss.Cross_entropy (row [ 0.; 1.; 0. ]) (row [ 0.2; 0.7; 0.1 ]) in
    close (scalar l) (-.log 0.7)


  let loss_custom () =
    let l = Loss.run (Loss.Custom (fun a b -> Maths.(sum' (a * b)))) (row y) (row y') in
    close (scalar l) (dot y y')


  (* Gradient: the conjugate-gradient family is [-g' + beta * p] *)

  let gradient_gd () = close_list (direction Gradient.GD) (neg g')

  (* Hestenes-Stiefel *)
  let gradient_cg () =
    let yk = sub g' g in
    let beta = dot g' yk /. (dot p yk +. 1e-32) in
    close_list (direction Gradient.CG) (axpy beta p (neg g'))


  (* Fletcher's conjugate descent *)
  let gradient_cd () =
    let beta = dot g' g' /. dot (neg p) g in
    close_list (direction Gradient.CD) (axpy beta p (neg g'))


  (* Fletcher-Reeves *)
  let gradient_nonlinear_cg () =
    let beta = dot g' g' /. dot g g in
    close_list (direction Gradient.NonlinearCG) (axpy beta p (neg g'))


  let gradient_dai_yuan_cg () =
    let beta = dot g' g' /. dot p (sub g' g) in
    close_list (direction Gradient.DaiYuanCG) (axpy beta p (neg g'))


  (* one Newton step reaches the minimum of a quadratic exactly *)
  let gradient_newton () =
    let f x = Maths.(sum' (sqr (x - row [ 1.; -2. ]) * row [ 2.; 5. ])) in
    let w = row [ 4.; 7. ] in
    let d = Gradient.run Gradient.Newton f w (row [ 0.; 0. ]) (row [ 0.; 0. ]) (grad f w) in
    close_list Maths.(w + d) [ 1.; -2. ]


  (* Momentum: [u] is the previous update, [u'] the new one *)

  let u = [ 1.; -2. ]

  let u' = [ 0.5; 0.5 ]

  let momentum_none () = close_list (Momentum.run Momentum.None (row u) (row u')) u'

  let momentum_standard () =
    close_list (Momentum.run (Momentum.Standard 0.9) (row u) (row u')) (axpy 0.9 u u')


  let momentum_nesterov () =
    let m = 0.9 in
    let expected = axpy (m *. m) u (List.map (fun a -> (1. +. m) *. a) u') in
    close_list (Momentum.run (Momentum.Nesterov m) (row u) (row u')) expected


  (* Regularisation *)

  let w = [ 3.; -4. ]

  let regularisation_none () = close (Regularisation.run Regularisation.None (row w) |> scalar) 0.

  let regularisation_l1 () =
    close (Regularisation.run (Regularisation.L1norm 0.1) (row w) |> scalar) 0.7


  (* the L2 term is the plain norm, not the squared norm *)
  let regularisation_l2 () =
    close (Regularisation.run (Regularisation.L2norm 0.1) (row w) |> scalar) 0.5


  let regularisation_elastic_net () =
    let r = Regularisation.run (Regularisation.Elastic_net (0.1, 0.2)) (row w) in
    close (scalar r) ((0.1 *. 7.) +. (0.2 *. 5.))


  (* Clipping *)

  let clipping_none () = close_list (Clipping.run Clipping.None (row [ 3.; 4. ])) [ 3.; 4. ]

  let clipping_l2norm_large () =
    close_list (Clipping.run (Clipping.L2norm 1.) (row [ 3.; 4. ])) [ 0.6; 0.8 ]


  let clipping_l2norm_small () =
    close_list (Clipping.run (Clipping.L2norm 1.) (row [ 0.3; 0.4 ])) [ 0.3; 0.4 ]


  let clipping_value () =
    close_list
      (Clipping.run (Clipping.Value (-1., 1.)) (row [ -3.; 0.5; 2. ]))
      [ -1.; 0.5; 1. ]


  (* Learning_Rate: the schedules that do not depend on the gradient cache
     (Adagrad and RMSprop are covered by [Unit_learning_rate]) *)

  let rate typ i = Learning_Rate.run typ i (_f 0.) [| _f 0.; _f 0. |] |> scalar

  let learning_rate_const () = List.for_all (fun i -> close (rate (Learning_Rate.Const 0.3) i) 0.3) [ 0; 1; 7 ]

  let learning_rate_decay () =
    List.for_all
      (fun i ->
        close (rate (Learning_Rate.Decay (0.5, 0.1)) i) (0.5 /. (1. +. (0.1 *. float_of_int i))))
      [ 0; 1; 7 ]


  let learning_rate_exp_decay () =
    List.for_all
      (fun i ->
        close
          (rate (Learning_Rate.Exp_decay (0.5, 0.1)) i)
          (0.5 *. exp (-0.1 *. float_of_int i)))
      [ 0; 1; 7 ]


  let learning_rate_schedule () =
    let s = Learning_Rate.Schedule [| 0.1; 0.2; 0.3 |] in
    List.for_all2 (fun i r -> close (rate s i) r) [ 0; 1; 2; 3; 5 ] [ 0.1; 0.2; 0.3; 0.1; 0.3 ]


  (* Adam through [Stepper], against Kingma & Ba (2015), Algorithm 1 with the
     "more efficient" ordering of Section 2 *)
  let adam_reference ~a ~b1 ~b2 grads w =
    let n = List.length w in
    let m = ref (List.init n (fun _ -> 0.))
    and v = ref (List.init n (fun _ -> 0.))
    and w = ref w in
    List.iteri
      (fun i g ->
        let t = float_of_int (i + 1) in
        m := List.map2 (fun m g -> (b1 *. m) +. ((1. -. b1) *. g)) !m g;
        v := List.map2 (fun v g -> (b2 *. v) +. ((1. -. b2) *. g *. g)) !v g;
        let at = a *. sqrt (1. -. (b2 ** t)) /. (1. -. (b1 ** t)) in
        let step = List.map2 (fun m v -> at *. m /. (sqrt v +. 1e-8)) !m !v in
        w := List.map2 ( -. ) !w step)
      grads;
    !w


  let adam_with_stepper ~a ~b1 ~b2 grads w =
    let params = quiet_params ~learning_rate:(Learning_Rate.Adam (a, b1, b2)) 1. in
    let w = ref [| [| row w |] |] in
    let state = Stepper.init params !w in
    List.iter (fun g -> w := Stepper.step state !w [| [| row g |] |]) grads;
    !w.(0).(0)


  let adam_matches grads =
    let w = [ 1.; 1.; 1. ] in
    let a, b1, b2 = 0.1, 0.9, 0.999 in
    close_list ~tol:1e-7 (adam_with_stepper ~a ~b1 ~b2 grads w) (adam_reference ~a ~b1 ~b2 grads w)


  (* every gradient element is non-zero, so the current formula agrees *)
  let adam_nonzero_gradients () =
    adam_matches [ [ 1.; -2.; 0.5 ]; [ 0.5; -1.; 0.25 ]; [ -0.3; 0.7; 2. ] ]


  (* KNOWN BUG: the update is [m / (sqrt v + eps)] multiplied by [g / g], so an
     element whose current gradient is zero does not move even though its
     first moment is not zero *)
  let adam_zero_gradient () = adam_matches [ [ 1.; 1.; 1. ]; [ 1.; 0.; 1. ] ]

  (* KNOWN BUG: dividing by [g + 1e-32] blows up when [g = -1e-32] *)
  let adam_tiny_negative_gradient () = adam_matches [ [ 1.; -1e-32; 1. ] ]

  (* Batch: row [i] of [x] holds [i] and so does row [i] of [y], which lets us
     check that the rows of a batch stay paired *)

  let batch_data n =
    let col () = Arr (Owl_dense_ndarray.D.init [| n; 1 |] float_of_int) in
    col (), col ()


  let first_column x = to_list x

  let paired x y = first_column x = first_column y

  let batch_full () =
    let x, y = batch_data 10 in
    let x', y' = Batch.run Batch.Full x y 3 in
    first_column x' = first_column x && paired x' y' && Batch.batches Batch.Full x = 1


  let batch_mini () =
    let x, y = batch_data 10 in
    let rows i =
      let x', y' = Batch.run (Batch.Mini 4) x y i in
      if paired x' y' then first_column x' else []
    in
    rows 0 = [ 0.; 1.; 2.; 3. ]
    && rows 1 = [ 4.; 5.; 6.; 7. ]
    && (* the third chunk wraps around to the start *)
    rows 2 = [ 8.; 9.; 0.; 1. ]
    && (* the incomplete last chunk is not counted as a batch *)
    Batch.batches (Batch.Mini 4) x = 2


  let batch_sample () =
    let x, y = batch_data 10 in
    let x', y' = Batch.run (Batch.Sample 3) x y 0 in
    let r = first_column x' in
    List.length r = 3
    && paired x' y'
    && List.for_all (fun v -> v >= 0. && v <= 9.) r
    && Batch.batches (Batch.Sample 3) x = 3


  let batch_stochastic () =
    let x, y = batch_data 10 in
    let x', y' = Batch.run Batch.Stochastic x y 0 in
    List.length (first_column x') = 1 && paired x' y' && Batch.batches Batch.Stochastic x = 10


  (* Stopping *)

  let stopping_const () =
    Stopping.run (Stopping.Const 0.1) 0.05 && not (Stopping.run (Stopping.Const 0.1) 0.2)


  let stopping_none () = not (Stopping.run Stopping.None 0.)

  (* minimise_fun *)

  let minimise ?gradient ?momentum ?stopping ?checkpoint ~learning_rate epochs =
    let params =
      quiet_params ?gradient ?momentum ?stopping ?checkpoint ~learning_rate epochs
    in
    minimise_fun params quadratic (x0 ())


  let converges (_, x) = close_list ~tol:1e-6 x target

  let minimise_gd () = converges (minimise ~learning_rate:(Learning_Rate.Const 0.1) 200.)

  let minimise_momentum () =
    converges
      (minimise
         ~momentum:(Momentum.Standard 0.5)
         ~learning_rate:(Learning_Rate.Const 0.1)
         200.)


  let minimise_adam () =
    let _, x = minimise ~learning_rate:(Learning_Rate.Adam (0.1, 0.9, 0.999)) 1000. in
    close_list ~tol:1e-3 x target


  let minimise_newton () =
    converges
      (minimise ~gradient:Gradient.Newton ~learning_rate:(Learning_Rate.Const 1.) 2.)


  (* [epochs] iterations, and every loss is recorded *)
  let minimise_state () =
    let state, _ = minimise ~learning_rate:(Learning_Rate.Const 0.1) 20. in
    let loss = Array.map scalar Checkpoint.(state.loss) in
    Checkpoint.(state.batches = 20 && state.current_batch = 21)
    && Array.length loss = 21
    && close loss.(0) (dot target target)
    && (* gradient descent on a convex quadratic never increases the loss *)
    Array.for_all Fun.id (Array.init 20 (fun i -> loss.(i + 1) <= loss.(i)))


  (* the custom checkpoint is called once per batch, except on the last one *)
  let minimise_checkpoint () =
    let calls = ref 0 in
    let _ =
      minimise
        ~checkpoint:(Checkpoint.Custom (fun _ -> incr calls))
        ~learning_rate:(Learning_Rate.Const 0.1)
        10.
    in
    !calls = 9


  (* passing the state back in resumes the run where it stopped *)
  let minimise_resume () =
    let params = quiet_params ~learning_rate:(Learning_Rate.Const 0.1) 10. in
    let state, x = minimise_fun params quadratic (x0 ()) in
    (* extend the finished 10-batch run to 20 batches *)
    Checkpoint.(state.batches <- 20);
    Checkpoint.(state.loss <- Array.append state.loss (Array.make 10 (_f 0.)));
    Checkpoint.(state.stop <- false);
    let _, x' = minimise_fun ~state params quadratic x in
    let _, x20 =
      minimise_fun (quiet_params ~learning_rate:(Learning_Rate.Const 0.1) 20.) quadratic (x0 ())
    in
    close_list x' (to_list x20)


  (* KNOWN BUG: [Checkpoint.run] overwrites [state.stop] right after the
     stopping criterion sets it, so [Stopping.Const] never ends a run early *)
  let minimise_stops_early () =
    let state, _ =
      minimise
        ~stopping:(Stopping.Const 1e10)
        ~learning_rate:(Learning_Rate.Const 0.1)
        50.
    in
    Checkpoint.(state.current_batch) <= 2


  (* KNOWN BUG: [Stopping.Early] is not implemented *)
  let stopping_early () =
    not (raises_failure (fun () -> Stopping.run (Stopping.Early (10, 10)) 1.))
end

let check name f () = Alcotest.(check bool) name true (f ())

let known_bugs_enabled = Sys.getenv_opt "OWL_TEST_KNOWN_BUGS" = Some "1"

let known_bug name f () = if known_bugs_enabled then check name f () else Alcotest.skip ()

let test_set =
  let open To_test in
  [ "loss quadratic", `Quick, check "loss quadratic" loss_quadratic
  ; "loss l1norm", `Quick, check "loss l1norm" loss_l1norm
  ; "loss l2norm", `Quick, check "loss l2norm" loss_l2norm
  ; "loss hinge", `Quick, check "loss hinge" loss_hinge
  ; "loss cross entropy", `Quick, check "loss cross entropy" loss_cross_entropy
  ; "loss custom", `Quick, check "loss custom" loss_custom
  ; "gradient gd", `Quick, check "gradient gd" gradient_gd
  ; "gradient cg", `Quick, check "gradient cg" gradient_cg
  ; "gradient cd", `Quick, check "gradient cd" gradient_cd
  ; "gradient nonlinear cg", `Quick, check "gradient nonlinear cg" gradient_nonlinear_cg
  ; "gradient dai yuan cg", `Quick, check "gradient dai yuan cg" gradient_dai_yuan_cg
  ; "gradient newton", `Quick, check "gradient newton" gradient_newton
  ; "momentum none", `Quick, check "momentum none" momentum_none
  ; "momentum standard", `Quick, check "momentum standard" momentum_standard
  ; "momentum nesterov", `Quick, check "momentum nesterov" momentum_nesterov
  ; "regularisation none", `Quick, check "regularisation none" regularisation_none
  ; "regularisation l1", `Quick, check "regularisation l1" regularisation_l1
  ; "regularisation l2", `Quick, check "regularisation l2" regularisation_l2
  ; "regularisation elastic net", `Quick, check "regularisation elastic net" regularisation_elastic_net
  ; "clipping none", `Quick, check "clipping none" clipping_none
  ; "clipping l2norm large", `Quick, check "clipping l2norm large" clipping_l2norm_large
  ; "clipping l2norm small", `Quick, check "clipping l2norm small" clipping_l2norm_small
  ; "clipping value", `Quick, check "clipping value" clipping_value
  ; "learning rate const", `Quick, check "learning rate const" learning_rate_const
  ; "learning rate decay", `Quick, check "learning rate decay" learning_rate_decay
  ; "learning rate exp decay", `Quick, check "learning rate exp decay" learning_rate_exp_decay
  ; "learning rate schedule", `Quick, check "learning rate schedule" learning_rate_schedule
  ; "adam nonzero gradients", `Quick, check "adam nonzero gradients" adam_nonzero_gradients
  ; "batch full", `Quick, check "batch full" batch_full
  ; "batch mini", `Quick, check "batch mini" batch_mini
  ; "batch sample", `Quick, check "batch sample" batch_sample
  ; "batch stochastic", `Quick, check "batch stochastic" batch_stochastic
  ; "stopping const", `Quick, check "stopping const" stopping_const
  ; "stopping none", `Quick, check "stopping none" stopping_none
  ; "minimise gd", `Slow, check "minimise gd" minimise_gd
  ; "minimise momentum", `Slow, check "minimise momentum" minimise_momentum
  ; "minimise adam", `Slow, check "minimise adam" minimise_adam
  ; "minimise newton", `Slow, check "minimise newton" minimise_newton
  ; "minimise state", `Slow, check "minimise state" minimise_state
  ; "minimise checkpoint", `Slow, check "minimise checkpoint" minimise_checkpoint
  ; "minimise resume", `Slow, check "minimise resume" minimise_resume
  ; "known bug: adam zero gradient", `Quick, known_bug "adam zero gradient" adam_zero_gradient
  ; ( "known bug: adam tiny negative gradient"
    , `Quick
    , known_bug "adam tiny negative gradient" adam_tiny_negative_gradient )
  ; "known bug: stopping const ends run", `Slow, known_bug "stopping const ends run" minimise_stops_early
  ; "known bug: stopping early", `Quick, known_bug "stopping early" stopping_early ]
