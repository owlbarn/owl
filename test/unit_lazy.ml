(** Unit test for Owl_lazy module *)

open Owl

module M = Owl.Lazy.Make (Arr)

(* some test input *)
let x0 = Arr.zeros [|3; 4|]
let x1 = Arr.ones [|3; 4|]
let x2 = Arr.sequential [|3; 4|]
let x3 = Arr.(uniform [|3; 4|] - x1)

(* make testable *)
let ndarray = Alcotest.testable (fun p (x : M.t) -> ()) M.equal

(* a module with functions to test *)
module To_test = struct

  let fun00 () =
    let a = Arr.copy x3 |> M.of_ndarray |> M.abs |> M.to_ndarray in
    let b = Arr.abs x3 in
    Arr.(a = b)

  let fun01 () =
    let a = Arr.copy x3 |> M.of_ndarray |> M.sin |> M.cos |> M.to_ndarray in
    let b = x3 |> Arr.sin |> Arr.cos in
    Arr.(a = b)

  let fun02 () =
    let a = Arr.copy x3 |> M.of_ndarray |> M.neg |> M.cosh |> M.tanh |> M.to_ndarray in
    let b = x3 |> Arr.cosh |> Arr.tanh in
    Arr.(a = b)

  let fun03 () =
    let a = M.add (M.of_ndarray (Arr.copy x2)) (M.of_ndarray (Arr.copy x3)) |> M.to_ndarray in
    let b = Arr.add x2 x3 in
    Arr.(a = b)

  let fun04 () =
    let a = M.sub (M.of_ndarray (Arr.copy x2)) (M.of_ndarray (Arr.copy x3)) |> M.to_ndarray in
    let b = Arr.sub x2 x3 in
    Arr.(a = b)

  let fun05 () =
    let a = M.mul (M.of_ndarray (Arr.copy x2)) (M.of_ndarray (Arr.copy x3)) |> M.to_ndarray in
    let b = Arr.mul x2 x3 in
    Arr.(a = b)

  let fun06 () =
    let a = M.div (M.of_ndarray (Arr.copy x2)) (M.of_ndarray (Arr.copy x3)) |> M.to_ndarray in
    let b = Arr.div x2 x3 in
    Arr.(a = b)

  let fun07 () =
    let a = M.pow (M.of_ndarray (Arr.copy x2)) (M.of_ndarray (Arr.copy x3)) |> M.to_ndarray in
    let b = Arr.pow x2 x3 in
    Arr.(a = b)

  let fun08 () =
    let a = M.atan2 (M.of_ndarray (Arr.copy x2)) (M.of_ndarray (Arr.copy x3)) |> M.to_ndarray in
    let b = Arr.atan2 x2 x3 in
    Arr.(a = b)

  let fun09 () =
    let a = M.hypot (M.of_ndarray (Arr.copy x2)) (M.of_ndarray (Arr.copy x3)) |> M.to_ndarray in
    let b = Arr.hypot x2 x3 in
    Arr.(a = b)

  let fun10 () =
    let a = M.min2 (M.of_ndarray (Arr.copy x2)) (M.of_ndarray (Arr.copy x3)) |> M.to_ndarray in
    let b = Arr.min2 x2 x3 in
    Arr.(a = b)

  let fun11 () =
    let a = M.max2 (M.of_ndarray (Arr.copy x2)) (M.of_ndarray (Arr.copy x3)) |> M.to_ndarray in
    let b = Arr.max2 x2 x3 in
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
