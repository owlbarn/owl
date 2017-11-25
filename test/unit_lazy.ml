(** Unit test for Owl_lazy module *)

open Owl

module M = Owl.Lazy.Make (Arr)

(* some test input *)
let x0 = Arr.zeros [|3; 4|]
let x1 = Arr.ones [|3; 4|]
let x2 = Arr.sequential ~a:1. [|3; 4|]
let x3 = Arr.(uniform [|3; 4|] - x1)
let x4 = Arr.(uniform [|4; 4|] -$ 1.)

(* make testable *)
(* let ndarray = Alcotest.testable (fun p (x : M.t) -> ()) (fun ) *)

(* a module with functions to test *)
module To_test = struct

  let fun00 () =
    let x = M.variable () in
    let y = M.abs x in
    M.assign_arr x x3;
    M.eval y;
    let a = M.to_arr y in
    let b = Arr.abs x3 in
    Arr.(a = b)

  let fun01 () =
    let x = M.variable () in
    let y = x |> M.sin |> M.cos in
    M.assign_arr x x3;
    M.eval y;
    let a = M.to_arr y in
    let b = x3 |> Arr.sin |> Arr.cos in
    Arr.(a = b)

  let fun02 () =
    let x = M.variable () in
    let y = x |> M.neg |> M.cosh |> M.tanh in
    M.assign_arr x x3;
    M.eval y;
    let a = M.to_arr y in
    let b = x3 |> Arr.cosh |> Arr.tanh in
    Arr.(a = b)

  let fun03 () =
    let x = M.variable () in
    let y = M.variable () in
    let z = M.add x y in
    M.assign_arr x x2;
    M.assign_arr y x3;
    M.eval z;
    let a = M.to_arr z in
    let b = Arr.add x2 x3 in
    Arr.(a = b)

  let fun04 () =
    let x = M.variable () in
    let y = M.variable () in
    let z = M.sub x y in
    M.assign_arr x x2;
    M.assign_arr y x3;
    M.eval z;
    let a = M.to_arr z in
    let b = Arr.sub x2 x3 in
    Arr.(a = b)

  let fun05 () =
    let x = M.variable () in
    let y = M.variable () in
    let z = M.mul x y in
    M.assign_arr x x2;
    M.assign_arr y x3;
    M.eval z;
    let a = M.to_arr z in
    let b = Arr.mul x2 x3 in
    Arr.(a = b)

  let fun06 () =
    let x = M.variable () in
    let y = M.variable () in
    let z = M.div x y in
    M.assign_arr x x2;
    M.assign_arr y x3;
    M.eval z;
    let a = M.to_arr z in
    let b = Arr.div x2 x3 in
    Arr.(a = b)

  let fun07 () =
    let x = M.variable () in
    let y = M.variable () in
    let z = M.pow x y in
    M.assign_arr x x2;
    M.assign_arr y x3;
    M.eval z;
    let a = M.to_arr z in
    let b = Arr.pow x2 x3 in
    Arr.(a = b)

  let fun08 () =
    let x = M.variable () in
    let y = M.variable () in
    let z = M.atan2 x y in
    M.assign_arr x x2;
    M.assign_arr y x3;
    M.eval z;
    let a = M.to_arr z in
    let b = Arr.atan2 x2 x3 in
    Arr.(a = b)

  let fun09 () =
    let x = M.variable () in
    let y = M.variable () in
    let z = M.hypot x y in
    M.assign_arr x x2;
    M.assign_arr y x3;
    M.eval z;
    let a = M.to_arr z in
    let b = Arr.hypot x2 x3 in
    Arr.(a = b)

  let fun10 () =
    let x = M.variable () in
    let y = M.variable () in
    let z = M.min2 x y in
    M.assign_arr x x2;
    M.assign_arr y x3;
    M.eval z;
    let a = M.to_arr z in
    let b = Arr.min2 x2 x3 in
    Arr.(a = b)

  let fun11 () =
    let x = M.variable () in
    let y = M.variable () in
    let z = M.max2 x y in
    M.assign_arr x x2;
    M.assign_arr y x3;
    M.eval z;
    let a = M.to_arr z in
    let b = Arr.max2 x2 x3 in
    Arr.(a = b)

  let fun12 () =
    let x = M.variable () in
    let y = M.variable () in
    let z = M.max2 x y in
    M.assign_arr x x2;
    M.assign_arr y x3;
    M.eval z;
    let a = M.to_arr z in
    let b = Arr.max2 x2 x3 in
    Arr.(a = b)

  let fun13 () =
    let x = M.variable () in
    let y = M.dot x x in
    M.assign_arr x x4;
    M.eval y;
    let a = M.to_arr y in
    let b = Arr.dot x4 x4 in
    Arr.(a = b)

end

(* the tests *)

let fun00 () =
  Alcotest.(check bool) "fun00" true (To_test.fun00 ())

let fun01 () =
  Alcotest.(check bool) "fun01" true (To_test.fun01 ())

let fun02 () =
  Alcotest.(check bool) "fun02" true (To_test.fun02 ())

let fun03 () =
  Alcotest.(check bool) "fun03" true (To_test.fun03 ())

let fun04 () =
  Alcotest.(check bool) "fun04" true (To_test.fun04 ())

let fun05 () =
  Alcotest.(check bool) "fun05" true (To_test.fun05 ())

let fun06 () =
  Alcotest.(check bool) "fun06" true (To_test.fun06 ())

let fun07 () =
  Alcotest.(check bool) "fun07" true (To_test.fun07 ())

let fun08 () =
  Alcotest.(check bool) "fun08" true (To_test.fun08 ())

let fun09 () =
  Alcotest.(check bool) "fun09" true (To_test.fun09 ())

let fun10 () =
  Alcotest.(check bool) "fun10" true (To_test.fun10 ())

let fun11 () =
  Alcotest.(check bool) "fun11" true (To_test.fun11 ())

let fun12 () =
  Alcotest.(check bool) "fun12" true (To_test.fun12 ())

let fun13 () =
  Alcotest.(check bool) "fun13" true (To_test.fun13 ())

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
  "fun12", `Slow, fun12;
  "fun13", `Slow, fun13;
]
