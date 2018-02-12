(** Unit test for Ndarray primitives *)

open Owl

(* some test input *)

let x0 = Arr.sequential [|10|]

let x1 = Arr.sequential [|10;10|]

let x2 = Arr.sequential [|10;10;10|]


(* a module with functions to test *)
module To_test = struct

  let test_01 () =
    let b = ref 0. in
    Arr.iter (fun a -> b := !b +. a) x0;
    let c = Arr.sum' x0 in
    !b = c

  let test_02 () =
    let b = ref 0. in
    Arr.iter (fun a -> b := !b +. a) x1;
    let c = Arr.sum' x1 in
    !b = c

  let test_03 () =
    let b = ref 0. in
    Arr.iter (fun a -> b := !b +. a) x2;
    let c = Arr.sum' x2 in
    !b = c

  let test_04 () =
    let y = Arr.map (fun a -> a +. 1.) x0 in
    let z = Arr.(x0 +$ 1.) in
    Arr.(y = z)

  let test_05 () =
    let y = Arr.map (fun a -> a +. 1.) x1 in
    let z = Arr.(x1 +$ 1.) in
    Arr.(y = z)

  let test_06 () =
    let y = Arr.map (fun a -> a +. 1.) x2 in
    let z = Arr.(x2 +$ 1.) in
    Arr.(y = z)

  let test_07 () =
    let y = Arr.fold (fun a b -> a +. b) 0. x0 in
    Arr.get y [|0|] = 45.

  let test_08 () =
    let y = Arr.fold (fun a b -> a +. b) 0. x1 in
    Arr.get y [|0|] = 4950.

  let test_09 () =
    let y = Arr.fold ~axis:0 (fun a b -> a +. b) 0. x0 in
    Arr.get y [|0|] = 45.

  let test_10 () =
    let y = Arr.fold ~axis:0 (fun a b -> a +. b) 0. x1 in
    let z = Arr.of_array [|
      450.;460.;470.;480.;490.;500.;510.;520.;530.;540.
    |] [|1;10|] in
    Arr.(y = z)

  let test_11 () =
    let y = Arr.fold ~axis:1 (fun a b -> a +. b) 0. x1 in
    let z = Arr.of_array [|
      45.;145.;245.;345.;445.;545.;645.;745.;845.;945.
    |] [|10;1|] in
    Arr.(y = z)

  let test_12 () =
    let y = Arr.scan ~axis:0 (fun a b -> a +. b) x0 in
    let z = Arr.of_array [|
      0.;1.;3.;6.;10.;15.;21.;28.;36.;45.
    |] [|10|] in
    Arr.(y = z)

  let test_13 () =
    let y = Arr.scan ~axis:0 (fun a b -> a +. b) x1 in
    let z = Arr.of_array [|
      30.;33.;36.;39.;42.;45.;48.;51.;54.;57.
    |] [|1;10|] in
    Arr.(y.Arr.${[[2];[]]} = z)

  let test_14 () =
    let y = Arr.scan ~axis:1 (fun a b -> a +. b) x1 in
    let z = Arr.of_array [|
      6.;46.;86.;126.;166.;206.;246.;286.;326.;366.
    |] [|10;1|] in
    Arr.(y.Arr.${ [[];[3]] } = z)

  let test_15 () =
    let y = Arr.scan ~axis:0 (fun a b -> a +. b) x2 in
    let z = Arr.of_array [|
      140.;142.;144.;146.;148.;150.;152.;154.;156.;158.
    |] [|1;1;10|] in
    Arr.(y.Arr.${ [[1];[2];[]] } = z)

  let test_16 () =
    let y = Arr.scan ~axis:1 (fun a b -> a +. b) x2 in
    let z = Arr.of_array [|
      860.;864.;868.;872.;876.;880.;884.;888.;892.;896.
    |] [|1;1;10|] in
    Arr.(y.Arr.${ [[2];[3];[]] } = z)

  let test_17 () =
    let y = Arr.scan ~axis:2 (fun a b -> a +. b) x2 in
    let z = Arr.of_array [|
      340.;681.;1023.;1366.;1710.;2055.;2401.;2748.;3096.;3445.
    |] [|1;1;10|] in
    Arr.(y.Arr.${ [[3];[4];[]] } = z)

  let test_18 () =
    let y = Arr.filter (fun a -> a = 3.) x0 in
    y = [|3|]

  let test_19 () =
    let y = Arr.filter (fun a -> a < 3.) x0 in
    y = [|0;1;2|]

  let test_20 () =
    let y = Arr.filter (fun a -> a > 4. && a < 10.) x0 in
    y = [|5;6;7;8;9|]

  let test_21 () =
    let y = Arr.filter (fun a -> a = 5.) x1 in
    y = [|5|]

  let test_22 () =
    let y = Arr.filter (fun a -> a > 1. && a < 5.) x1 in
    y = [|2;3;4|]

  let test_23 () =
    let y = Arr.filter (fun a -> a > 35. && a < 41.) x1 in
    y = [|36;37;38;39;40|]

  let test_24 () =
    let y = Arr.filter (fun a -> a *. a = 16.) x2 in
    y = [|4|]

  let test_25 () =
    let y = Arr.filter (fun a -> a *. a < 16.) x2 in
    y = [|0;1;2;3|]

end


(* the tests *)

let test_01 () =
  Alcotest.(check bool) "test 01" true (To_test.test_01 ())

let test_02 () =
  Alcotest.(check bool) "test 02" true (To_test.test_02 ())

let test_03 () =
  Alcotest.(check bool) "test 03" true (To_test.test_03 ())

let test_04 () =
  Alcotest.(check bool) "test 04" true (To_test.test_04 ())

let test_05 () =
  Alcotest.(check bool) "test 05" true (To_test.test_05 ())

let test_06 () =
  Alcotest.(check bool) "test 06" true (To_test.test_06 ())

let test_07 () =
  Alcotest.(check bool) "test 07" true (To_test.test_07 ())

let test_08 () =
  Alcotest.(check bool) "test 08" true (To_test.test_08 ())

let test_09 () =
  Alcotest.(check bool) "test 09" true (To_test.test_09 ())

let test_10 () =
  Alcotest.(check bool) "test 10" true (To_test.test_10 ())

let test_11 () =
  Alcotest.(check bool) "test 11" true (To_test.test_11 ())

let test_12 () =
  Alcotest.(check bool) "test 12" true (To_test.test_12 ())

let test_13 () =
  Alcotest.(check bool) "test 13" true (To_test.test_13 ())

let test_14 () =
  Alcotest.(check bool) "test 14" true (To_test.test_14 ())

let test_15 () =
  Alcotest.(check bool) "test 15" true (To_test.test_15 ())

let test_16 () =
  Alcotest.(check bool) "test 16" true (To_test.test_16 ())

let test_17 () =
  Alcotest.(check bool) "test 17" true (To_test.test_17 ())

let test_18 () =
  Alcotest.(check bool) "test 18" true (To_test.test_18 ())

let test_19 () =
  Alcotest.(check bool) "test 19" true (To_test.test_19 ())

let test_20 () =
  Alcotest.(check bool) "test 20" true (To_test.test_20 ())

let test_21 () =
  Alcotest.(check bool) "test 21" true (To_test.test_21 ())

let test_22 () =
  Alcotest.(check bool) "test 22" true (To_test.test_22 ())

let test_23 () =
  Alcotest.(check bool) "test 23" true (To_test.test_23 ())

let test_24 () =
  Alcotest.(check bool) "test 24" true (To_test.test_24 ())

let test_25 () =
  Alcotest.(check bool) "test 25" true (To_test.test_25 ())

let test_set = [
  "test 01", `Slow, test_01;
  "test 02", `Slow, test_02;
  "test 03", `Slow, test_03;
  "test 04", `Slow, test_04;
  "test 05", `Slow, test_05;
  "test 06", `Slow, test_06;
  "test 07", `Slow, test_07;
  "test 08", `Slow, test_08;
  "test 09", `Slow, test_09;
  "test 10", `Slow, test_10;
  "test 11", `Slow, test_11;
  "test 12", `Slow, test_12;
  "test 13", `Slow, test_13;
  "test 14", `Slow, test_14;
  "test 15", `Slow, test_15;
  "test 16", `Slow, test_16;
  "test 17", `Slow, test_17;
  "test 18", `Slow, test_18;
  "test 19", `Slow, test_19;
  "test 20", `Slow, test_20;
  "test 21", `Slow, test_21;
  "test 22", `Slow, test_22;
  "test 23", `Slow, test_23;
  "test 24", `Slow, test_24;
  "test 25", `Slow, test_25;
]
