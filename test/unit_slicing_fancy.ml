(** Unit test for Owl_stats module *)

open Owl

open Owl_types


(* some test input *)

let x0 = Arr.sequential [|10|]

let x1 = Arr.sequential [|10;10|]

let x2 = Arr.sequential [|10;10;10|]

let x3 = Arr.sequential [|5;5;5;5|]


(* a module with functions to test *)
module To_test = struct

  let test_01 () =
    let s = [R[]] in
    let y = Arr.get_slice s x0 in
    Arr.(y = x0)

  let test_02 () =
    let s = [L[1]] in
    let y = Arr.get_slice s x0 in
    let z = Arr.of_array [|1.|] [|1|] in
    Arr.(y = z)

  let test_03 () =
    let s = [L[5;1;2]] in
    let y = Arr.get_slice s x0 in
    let z = Arr.of_array [|5.;1.;2.|] [|3|] in
    Arr.(y = z)

  let test_04 () =
    let s = [R[];L[1]] in
    let y = Arr.get_slice s x1 in
    let z = Arr.of_array [|1.;11.;21.;31.;41.;51.;61.;71.;81.;91.|] [|10;1|] in
    Arr.(y = z)

  let test_05 () =
    let s = [R[2];L[1]] in
    let y = Arr.get_slice s x1 in
    let z = Arr.of_array [|21.|] [|1;1|] in
    Arr.(y = z)

  let test_06 () =
    let s = [R[2;3];L[5;4]] in
    let y = Arr.get_slice s x1 in
    let z = Arr.of_array [|25.;24.;35.;34.|] [|2;2|] in
    Arr.(y = z)

  let test_07 () =
    let s = [L[3;2];R[5;4]] in
    let y = Arr.get_slice s x1 in
    let z = Arr.of_array [|35.;34.;25.;24.|] [|2;2|] in
    Arr.(y = z)

  let test_08 () =
    let s = [L[-1;-2];L[5;4]] in
    let y = Arr.get_slice s x1 in
    let z = Arr.of_array [|95.;94.;85.;84.|] [|2;2|] in
    Arr.(y = z)

  let test_09 () =
    let s = [I 5;L[5;4]] in
    let y = Arr.get_slice s x1 in
    let z = Arr.of_array [|55.;54.|] [|1;2|] in
    Arr.(y = z)

  let test_10 () =
    let s = [L[5;4];I (-4)] in
    let y = Arr.get_slice s x1 in
    let z = Arr.of_array [|56.;46.|] [|2;1|] in
    Arr.(y = z)

  let test_11 () =
    let s = [I 5;I (-4)] in
    let y = Arr.get_slice s x1 in
    let z = Arr.of_array [|56.|] [|1;1|] in
    Arr.(y = z)

  let test_12 () =
    let s = [I 1; L[5]; L[-4]] in
    let y = Arr.get_slice s x2 in
    let z = Arr.of_array [|156.|] [|1;1;1|] in
    Arr.(y = z)

  let test_13 () =
    let s = [I 1;I 5;I (-4)] in
    let y = Arr.get_slice s x2 in
    let z = Arr.of_array [|156.|] [|1;1;1|] in
    Arr.(y = z)

  let test_14 () =
    let s = [R[5;5]; L[6]; L[-4]] in
    let y = Arr.get_slice s x2 in
    let z = Arr.of_array [|566.|] [|1;1;1|] in
    Arr.(y = z)

  let test_15 () =
    let s = [L[5]; L[6]; L[-4]] in
    let y = Arr.get_slice s x2 in
    let z = Arr.of_array [|566.|] [|1;1;1|] in
    Arr.(y = z)

  let test_16 () =
    let s = [L[5]; L[6;-1]; L[-4]] in
    let y = Arr.get_slice s x2 in
    let z = Arr.of_array [|566.;596.|] [|1;2;1|] in
    Arr.(y = z)

  let test_17 () =
    let s = [L[8;5]; L[6;-1]; L[-4]] in
    let y = Arr.get_slice s x2 in
    let z = Arr.of_array [|866.;896.;566.;596.|] [|2;2;1|] in
    Arr.(y = z)

  let test_18 () =
    let s = [L[2]; L[3]; L[-1]; L[1]] in
    let y = Arr.get_slice s x3 in
    let z = Arr.of_array [|346.|] [|1;1;1;1|] in
    Arr.(y = z)

  let test_19 () =
    let s = [I 2; I 3; L[-1;2]; L[3;1;0]] in
    let y = Arr.get_slice s x3 in
    let z = Arr.of_array [|348.;346.;345.;338.;336.;335.|] [|1;1;2;3|] in
    Arr.(y = z)

  let test_20 () =
    let s = [L[2]; R[3;3]; L[-1;2]; L[3;1;0]] in
    let y = Arr.get_slice s x3 in
    let z = Arr.of_array [|348.;346.;345.;338.;336.;335.|] [|1;1;2;3|] in
    Arr.(y = z)

  let test_21 () =
    let s = [I 1;I 2;I 3] in
    let y = Arr.get_slice s x2 in
    let z = Arr.of_array [|123.|] [|1;1;1|] in
    Arr.(y = z)

  let test_22 () =
    let s = [I 1;I (-2);I 3] in
    let y = Arr.get_slice s x2 in
    let z = Arr.of_array [|183.|] [|1;1;1|] in
    Arr.(y = z)

  let test_23 () =
    let s = [I 1;I (-2);I (-3)] in
    let y = Arr.get_slice s x2 in
    let z = Arr.of_array [|187.|] [|1;1;1|] in
    Arr.(y = z)

  let test_24 () =
    let s = [I (-1);I (-2);I (-3)] in
    let y = Arr.get_slice s x2 in
    let z = Arr.of_array [|987.|] [|1;1;1|] in
    Arr.(y = z)

  let test_25 () =
    let s = [L[-1];I 2;L[-3]] in
    let y = Arr.get_slice s x2 in
    let z = Arr.of_array [|927.|] [|1;1;1|] in
    Arr.(y = z)

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
