(** Unit test for training a compiled network ([Owl_neural_compiler]).

    The compiled graph is static, so the step-dependent factor of the learning
    rate is fed in before every step (see [Learning_Rate.scale]). It used to be
    fixed at step 999, which made Adam's bias correction wrong and turned
    [Decay], [Exp_decay] and [Schedule] into constant rates; Adam also divided
    by the gradient. Each test trains the same small network compiled and
    eagerly and compares the weights. *)

module CPU_Engine = Owl_computation_cpu_engine.Make (Owl_algodiff_primal_ops.D)
module C = Owl_neural_compiler.Make (CPU_Engine)
module E = Owl_neural.D
module N = Owl_dense_ndarray.D

let data () =
  Owl_stats_prng.init 21;
  N.uniform [| 8; 3 |], N.uniform [| 8; 2 |]


(* weights of a compiled network as plain arrays *)
let compiled_weights nn =
  C.Neural.Graph.mkpri nn
  |> Owl_utils.aarr_map (fun w ->
         let w = C.Neural.Algodiff.unpack_arr w in
         C.Engine.eval_arr [| w |];
         C.Engine.unpack_arr w)


let train_compiled learning_rate epochs =
  let open C.Neural in
  let open Graph in
  Owl_stats_prng.init 4;
  let nn = input [| 3 |] |> linear 4 ~act_typ:Activation.Tanh |> linear 2 |> get_network in
  let x, y = data () in
  let pack a = C.Engine.pack_arr a |> Algodiff.pack_arr in
  let params =
    Params.config
      ~batch:Batch.Full
      ~loss:Loss.Quadratic
      ~learning_rate
      ~verbosity:false
      epochs
  in
  ignore (C.train ~params nn (pack x) (pack y));
  compiled_weights nn


(* the same optimisation, eagerly, from the same initial weights, for [steps]
   steps of [Stepper] *)
let train_eager learning_rate w0 steps =
  let open E in
  let open Algodiff in
  let open Graph in
  let nn = input [| 3 |] |> linear 4 ~act_typ:Activation.Tanh |> linear 2 |> get_network in
  init nn;
  update nn (Owl_utils.aarr_map (fun w -> Arr (N.copy w)) w0);
  let x, y = data () in
  let x = Arr x
  and y = Arr y in
  let params = Params.config ~batch:Batch.Full ~loss:Loss.Quadratic ~learning_rate 1. in
  let state = Stepper.init params (mkpri nn) in
  for _ = 1 to steps do
    let y', _ = forward nn x in
    let loss = Maths.(Loss.run Loss.Quadratic y y' / _f 8.) in
    let ws, gs = backward nn loss in
    update nn (Stepper.step state ws gs)
  done;
  mkpri nn |> Owl_utils.aarr_map unpack_arr


let max_diff a b =
  Array.fold_left
    Float.max
    0.
    (Array.concat
       (Array.to_list
          (Array.map2 (Array.map2 (fun a b -> N.(sub a b |> abs |> max'))) a b)))


(* [epochs] of compiled training are [epochs + 1] steps: bootstrapping the
   optimisation already updates the weights *)
let matches_eager ~compiled ~eager epochs =
  let w0 = train_compiled (C.Neural.Learning_Rate.Const 0.) 1. in
  let wc = train_compiled compiled epochs in
  let we = train_eager eager w0 (int_of_float epochs + 1) in
  max_diff wc we < 1e-10 && max_diff wc w0 > 1e-3


let adam () =
  matches_eager
    ~compiled:(C.Neural.Learning_Rate.Adam (0.05, 0.9, 0.999))
    ~eager:(E.Learning_Rate.Adam (0.05, 0.9, 0.999))
    5.


let decay () =
  matches_eager
    ~compiled:(C.Neural.Learning_Rate.Decay (0.5, 1.))
    ~eager:(E.Learning_Rate.Decay (0.5, 1.))
    5.


let exp_decay () =
  matches_eager
    ~compiled:(C.Neural.Learning_Rate.Exp_decay (0.5, 0.5))
    ~eager:(E.Learning_Rate.Exp_decay (0.5, 0.5))
    5.


let schedule () =
  matches_eager
    ~compiled:(C.Neural.Learning_Rate.Schedule [| 0.3; 0.01; 0.1 |])
    ~eager:(E.Learning_Rate.Schedule [| 0.3; 0.01; 0.1 |])
    5.


(* strategies that never depended on the step behave as before *)
let const () =
  matches_eager
    ~compiled:(C.Neural.Learning_Rate.Const 0.1)
    ~eager:(E.Learning_Rate.Const 0.1)
    5.


let adagrad () =
  matches_eager
    ~compiled:(C.Neural.Learning_Rate.Adagrad 0.1)
    ~eager:(E.Learning_Rate.Adagrad 0.1)
    5.


(* [scale i * unscaled_update] reproduces [update i] for every strategy *)
let split () =
  let open Owl_optimise.D in
  let open Algodiff in
  let arr l = Arr (N.of_array (Array.of_list l) [| 1; List.length l |]) in
  let p = arr [ -1.; 0.5; 2. ]
  and g = arr [ 1.; -0.5; -2. ]
  and c = [| arr [ 0.3; -0.1; 0.2 ]; arr [ 0.5; 0.25; 4. ] |] in
  List.for_all
    (fun typ ->
      List.for_all
        (fun i ->
          let u = Learning_Rate.update typ i p g c
          and u' = Maths.(_f (Learning_Rate.scale typ i) * Learning_Rate.unscaled_update typ p g c) in
          N.(sub (unpack_arr u) (unpack_arr u') |> abs |> max') < 1e-12)
        [ 1; 2; 7 ])
    Learning_Rate.
      [ Const 0.1; Decay (0.5, 0.2); Exp_decay (0.5, 0.2); Schedule [| 0.1; 0.2; 0.3 |]
      ; Adagrad 0.1; RMSprop (0.01, 0.9); Adam (0.001, 0.9, 0.999) ]


let check name f () = Alcotest.(check bool) name true (f ())

let test_set =
  [ "learning rate split", `Quick, check "learning rate split" split
  ; "adam", `Slow, check "adam" adam
  ; "decay", `Slow, check "decay" decay
  ; "exp decay", `Slow, check "exp decay" exp_decay
  ; "schedule", `Slow, check "schedule" schedule
  ; "const", `Slow, check "const" const
  ; "adagrad", `Slow, check "adagrad" adagrad ]
