(** Unit test for the standalone single-step optimiser *)

open Owl_neural.S
open Algodiff
open Graph

let steps = 5

let make_data () = A.uniform [| 8; 3 |], A.uniform [| 8; 2 |]

let make_network () =
  let nn = input [| 3 |] |> linear 4 ~act_typ:Activation.Tanh |> linear 2 |> get_network in
  init nn;
  nn


let make_params ?(gradient = Gradient.GD) ?(momentum = Momentum.None)
    ?(clipping = Clipping.None) learning_rate
  =
  Params.config
    ~batch:Batch.Full
    ~loss:Loss.Quadratic
    ~gradient
    ~learning_rate
    ~momentum
    ~clipping
    ~verbosity:false
    (float_of_int steps)


let max_diff a b = A.(sub (unpack_arr a) (unpack_arr b) |> abs |> max' |> elt_to_float)

let same_weights nn0 nn1 =
  let ws0 = mkpri nn0
  and ws1 = mkpri nn1 in
  Array.for_all2 (Array.for_all2 (fun a b -> max_diff a b = 0.)) ws0 ws1


(* train with a hand-written loop driven by [Stepper], the way an RL agent would *)
let train_with_stepper ~bootstrap params nn x y =
  let x = Arr x
  and y = Arr y in
  let n = Arr.(shape x).(0) |> float_of_int in
  let grads () =
    let y', _ = forward nn x in
    let loss = Maths.(Loss.run params.Params.loss y y' / _f n) in
    backward nn loss
  in
  let state =
    if bootstrap
    then (
      let ws, gs = grads () in
      update nn ws;
      Stepper.init ~gs params ws)
    else Stepper.init params (mkpri nn)
  in
  for _ = 1 to steps do
    let ws, gs = grads () in
    update nn (Stepper.step state ws gs)
  done;
  state


(* [Stepper] must reproduce [Graph.train] bit for bit *)
let same_as_train ?(bootstrap = false) params =
  let x, y = make_data () in
  let nn0 = make_network () in
  let nn1 = copy nn0 in
  ignore (train ~params ~init_model:false nn0 x y);
  let state = train_with_stepper ~bootstrap params nn1 x y in
  same_weights nn0 nn1 && Stepper.count state = steps


let raises_invalid_arg f =
  try
    ignore (f ());
    false
  with
  | Invalid_argument _ -> true


module To_test = struct
  let const () = same_as_train (make_params (Learning_Rate.Const 0.1))

  let adam () = same_as_train (make_params (Learning_Rate.Adam (0.01, 0.9, 0.999)))

  let rmsprop () = same_as_train (make_params (Learning_Rate.RMSprop (0.01, 0.9)))

  let adagrad () = same_as_train (make_params (Learning_Rate.Adagrad 0.1))

  let decay () = same_as_train (make_params (Learning_Rate.Decay (0.1, 0.1)))

  let momentum () =
    same_as_train
      (make_params ~momentum:(Momentum.Standard 0.9) (Learning_Rate.Const 0.1))


  let nesterov () =
    same_as_train
      (make_params ~momentum:(Momentum.Nesterov 0.9) (Learning_Rate.Adam (0.01, 0.9, 0.999)))


  let clipping () =
    same_as_train
      (make_params ~clipping:(Clipping.L2norm 0.01) (Learning_Rate.Const 0.1))


  let cg () =
    same_as_train
      ~bootstrap:true
      (make_params ~gradient:Gradient.CG (Learning_Rate.Const 0.1))


  let cg_needs_history () =
    raises_invalid_arg (fun () ->
        Stepper.init
          (make_params ~gradient:Gradient.CG (Learning_Rate.Const 0.1))
          (mkpri (make_network ())))


  let newton_rejected () =
    raises_invalid_arg (fun () ->
        Stepper.init
          ~gs:[||]
          (make_params ~gradient:Gradient.Newton (Learning_Rate.Const 0.1))
          [||])


  (* minimise sum ((w - 3)^2) with [Stepper] alone, no network involved *)
  let converge () =
    let target = Arr (A.create [| 4 |] (A.float_to_elt 3.)) in
    let f w = Maths.(l2norm_sqr' (w - target)) in
    let params = make_params (Learning_Rate.Adam (0.1, 0.9, 0.999)) in
    let w = ref (Arr (A.zeros [| 4 |])) in
    let state = Stepper.init params [| [| !w |] |] in
    for _ = 1 to 500 do
      let g = grad f !w in
      w := (Stepper.step state [| [| !w |] |] [| [| g |] |]).(0).(0)
    done;
    max_diff !w target < 1e-3
end

let check name f () = Alcotest.(check bool) name true (f ())

let test_set =
  [ "const", `Slow, check "const" To_test.const
  ; "adam", `Slow, check "adam" To_test.adam
  ; "rmsprop", `Slow, check "rmsprop" To_test.rmsprop
  ; "adagrad", `Slow, check "adagrad" To_test.adagrad
  ; "decay", `Slow, check "decay" To_test.decay
  ; "momentum", `Slow, check "momentum" To_test.momentum
  ; "nesterov", `Slow, check "nesterov" To_test.nesterov
  ; "clipping", `Slow, check "clipping" To_test.clipping
  ; "cg", `Slow, check "cg" To_test.cg
  ; "cg needs history", `Slow, check "cg needs history" To_test.cg_needs_history
  ; "newton rejected", `Slow, check "newton rejected" To_test.newton_rejected
  ; "converge", `Slow, check "converge" To_test.converge ]
