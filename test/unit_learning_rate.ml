(** Unit test for optimiser learning rates *)

open Owl_algodiff.S

module LR = Owl_optimise.S.Learning_Rate


let close a b =
  Maths.(a - b < F (1e-5))

let init_ch = [|F 0.; F 0.|]

let rate_adagrad = LR.Adagrad 3.
let rate_rmsprop = LR.RMSprop (3., 0.9)
let rate_adam    = LR.Adam (0.001, 0.9, 0.999)

(* Function for testing an optimiser's `update_ch` and `run` implementation *)
let test_optimiser rate_fun c g x =
  let ch = init_ch in
  let _  = Array.mapi (fun i ci -> (ch.(i) <- F ci)) c in
  let c  = ref ch in
  let x  = ref (F x) in
  let g  = F g in

  for i = 1 to 3 do
    c := LR.update_ch rate_fun g !c;
    let lr = LR.run rate_fun i g !c in
    x := Maths.(!x - lr * g)
  done;
  !x


(* Test adagrad optimiser *)
module To_test_adagrad = struct

  let fun00 () =
    let o = test_optimiser rate_adagrad [|0.1|] 0.1 1. in
    close o (F (-1.6026098728179932))

  let fun01 () =
    let o = test_optimiser rate_adagrad [|0.1|] 0.1 2. in
    close o (F (-0.6026098728179932))

  let fun02 () =
    let o = test_optimiser rate_adagrad [|0.1|] 0.01 3. in
    close o (F 2.715679168701172)

  let fun03 () =
    let o = test_optimiser rate_adagrad [|0.1|] 0.01 4. in
    close o (F 3.715679168701172)

end


(* Test RMSprop optimiser *)
module To_test_rmsprop = struct

  let fun00 () =
    let o = test_optimiser rate_rmsprop [|1.|] 0.1 1. in
    close o (F 2.91705132e-04)

  let fun01 () =
    let o = test_optimiser rate_rmsprop [|1.|] 0.1 2. in
    close o (F 1.00029182)

  let fun02 () =
    let o = test_optimiser rate_rmsprop [|1.|] 0.01 3. in
    close o (F 2.89990854)

  let fun03 () =
    let o = test_optimiser rate_rmsprop [|1.|] 0.01 4. in
    close o (F 3.89990854)

end


(* Test Adam optimiser *)
module To_test_adam = struct

  let fun00 () =
    let o = test_optimiser rate_adam [|0.; 0.|] 0.1 1. in
    close o (F 0.998)

  let fun01 () =
    let o = test_optimiser rate_adam [|0.; 0.|] 0.1 2. in
    close o (F 1.998)

  let fun02 () =
    let o = test_optimiser rate_adam [|0.; 0.|] 0.01 3. in
    close o (F 2.999)

  let fun03 () =
    let o = test_optimiser rate_adam [|0.; 0.|] 0.01 4. in
    close o (F 3.999)

end


(* tests for adagrad *)

let fun00 () =
  Alcotest.(check bool) "fun00" true (To_test_adagrad.fun00 ())

let fun01 () =
  Alcotest.(check bool) "fun01" true (To_test_adagrad.fun01 ())

let fun02 () =
  Alcotest.(check bool) "fun02" true (To_test_adagrad.fun02 ())

let fun03 () =
  Alcotest.(check bool) "fun03" true (To_test_adagrad.fun03 ())

(* tests for rmsprop *)

let fun04 () =
  Alcotest.(check bool) "fun04" true (To_test_rmsprop.fun00 ())

let fun05 () =
  Alcotest.(check bool) "fun05" true (To_test_rmsprop.fun01 ())

let fun06 () =
  Alcotest.(check bool) "fun06" true (To_test_rmsprop.fun02 ())

let fun07 () =
  Alcotest.(check bool) "fun07" true (To_test_rmsprop.fun03 ())

(* tests for adam *)

let fun08 () =
  Alcotest.(check bool) "fun08" true (To_test_adam.fun00 ())

let fun09 () =
  Alcotest.(check bool) "fun09" true (To_test_adam.fun01 ())

let fun10 () =
  Alcotest.(check bool) "fun10" true (To_test_adam.fun02 ())

let fun11 () =
  Alcotest.(check bool) "fun11" true (To_test_adam.fun03 ())


let test_set = [
  "fun00", `Slow, fun00;
  "fun01", `Slow, fun01;
  "fun02", `Slow, fun02;
  "fun03", `Slow, fun03;
  "fun04", `Slow, fun04;
  "fun05", `Slow, fun05;
  "fun06", `Slow, fun06;
  "fun07", `Slow, fun07;
  "fun08", `Slow, fun08;
  "fun09", `Slow, fun09;
  "fun10", `Slow, fun10;
  "fun11", `Slow, fun11;
]
