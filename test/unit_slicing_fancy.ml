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
    let y = Arr.get_fancy s x0 in
    Arr.(y = x0)

  let test_02 () =
    let s = [L[1]] in
    let y = Arr.get_fancy s x0 in
    let z = Arr.of_array [|1.|] [|1|] in
    Arr.(y = z)

  let test_03 () =
    let s = [L[5;1;2]] in
    let y = Arr.get_fancy s x0 in
    let z = Arr.of_array [|5.;1.;2.|] [|3|] in
    Arr.(y = z)

  let test_04 () =
    let s = [R[];L[1]] in
    let y = Arr.get_fancy s x1 in
    let z = Arr.of_array [|1.;11.;21.;31.;41.;51.;61.;71.;81.;91.|] [|10;1|] in
    Arr.(y = z)

  let test_05 () =
    let s = [R[2];L[1]] in
    let y = Arr.get_fancy s x1 in
    let z = Arr.of_array [|21.|] [|1;1|] in
    Arr.(y = z)

  let test_06 () =
    let s = [R[2;3];L[5;4]] in
    let y = Arr.get_fancy s x1 in
    let z = Arr.of_array [|25.;24.;35.;34.|] [|2;2|] in
    Arr.(y = z)

  let test_07 () =
    let s = [L[3;2];R[5;4]] in
    let y = Arr.get_fancy s x1 in
    let z = Arr.of_array [|35.;34.;25.;24.|] [|2;2|] in
    Arr.(y = z)

  let test_08 () =
    let s = [L[-1;-2];L[5;4]] in
    let y = Arr.get_fancy s x1 in
    let z = Arr.of_array [|95.;94.;85.;84.|] [|2;2|] in
    Arr.(y = z)

  let test_09 () =
    let s = [I 5;L[5;4]] in
    let y = Arr.get_fancy s x1 in
    let z = Arr.of_array [|55.;54.|] [|1;2|] in
    Arr.(y = z)

  let test_10 () =
    let s = [L[5;4];I (-4)] in
    let y = Arr.get_fancy s x1 in
    let z = Arr.of_array [|56.;46.|] [|2;1|] in
    Arr.(y = z)

  let test_11 () =
    let s = [I 5;I (-4)] in
    let y = Arr.get_fancy s x1 in
    let z = Arr.of_array [|56.|] [|1;1|] in
    Arr.(y = z)

  let test_12 () =
    let s = [I 1; L[5]; L[-4]] in
    let y = Arr.get_fancy s x2 in
    let z = Arr.of_array [|156.|] [|1;1;1|] in
    Arr.(y = z)

  let test_13 () =
    let s = [I 1;I 5;I (-4)] in
    let y = Arr.get_fancy s x2 in
    let z = Arr.of_array [|156.|] [|1;1;1|] in
    Arr.(y = z)

  let test_14 () =
    let s = [R[5;5]; L[6]; L[-4]] in
    let y = Arr.get_fancy s x2 in
    let z = Arr.of_array [|566.|] [|1;1;1|] in
    Arr.(y = z)

  let test_15 () =
    let s = [L[5]; L[6]; L[-4]] in
    let y = Arr.get_fancy s x2 in
    let z = Arr.of_array [|566.|] [|1;1;1|] in
    Arr.(y = z)

  let test_16 () =
    let s = [L[5]; L[6;-1]; L[-4]] in
    let y = Arr.get_fancy s x2 in
    let z = Arr.of_array [|566.;596.|] [|1;2;1|] in
    Arr.(y = z)

  let test_17 () =
    let s = [L[8;5]; L[6;-1]; L[-4]] in
    let y = Arr.get_fancy s x2 in
    let z = Arr.of_array [|866.;896.;566.;596.|] [|2;2;1|] in
    Arr.(y = z)

  let test_18 () =
    let s = [L[2]; L[3]; L[-1]; L[1]] in
    let y = Arr.get_fancy s x3 in
    let z = Arr.of_array [|346.|] [|1;1;1;1|] in
    Arr.(y = z)

  let test_19 () =
    let s = [I 2; I 3; L[-1;2]; L[3;1;0]] in
    let y = Arr.get_fancy s x3 in
    let z = Arr.of_array [|348.;346.;345.;338.;336.;335.|] [|1;1;2;3|] in
    Arr.(y = z)

  let test_20 () =
    let s = [L[2]; R[3;3]; L[-1;2]; L[3;1;0]] in
    let y = Arr.get_fancy s x3 in
    let z = Arr.of_array [|348.;346.;345.;338.;336.;335.|] [|1;1;2;3|] in
    Arr.(y = z)

  let test_21 () =
    let s = [I 1;I 2;I 3] in
    let y = Arr.get_fancy s x2 in
    let z = Arr.of_array [|123.|] [|1;1;1|] in
    Arr.(y = z)

  let test_22 () =
    let s = [I 1;I (-2);I 3] in
    let y = Arr.get_fancy s x2 in
    let z = Arr.of_array [|183.|] [|1;1;1|] in
    Arr.(y = z)

  let test_23 () =
    let s = [I 1;I (-2);I (-3)] in
    let y = Arr.get_fancy s x2 in
    let z = Arr.of_array [|187.|] [|1;1;1|] in
    Arr.(y = z)

  let test_24 () =
    let s = [I (-1);I (-2);I (-3)] in
    let y = Arr.get_fancy s x2 in
    let z = Arr.of_array [|987.|] [|1;1;1|] in
    Arr.(y = z)

  let test_25 () =
    let s = [L[-1];I 2;L[-3]] in
    let y = Arr.get_fancy s x2 in
    let z = Arr.of_array [|927.|] [|1;1;1|] in
    Arr.(y = z)

  let test_26 () =
    let s = [R[3;2];L[5;4]] in
    let y = Arr.get_fancy s x1 in
    let z = Arr.of_array [|35.;34.;25.;24.|] [|2;2|] in
    Arr.(y = z)

  let test_27 () =
    let s = [L[0;1;2]] in
    let x = Arr.copy x0 in
    let y = Arr.of_array [|2.;3.;5.|] [|3|] in
    Arr.set_fancy s x y;
    let z = Arr.of_array [|2.;3.;5.;3.;4.;5.;6.;7.;8.;9.|] [|10|] in
    Arr.(x = z)

  let test_28 () =
    let s = [L[5;4;3]] in
    let x = Arr.copy x0 in
    let y = Arr.of_array [|2.;3.;5.|] [|3|] in
    Arr.set_fancy s x y;
    let z = Arr.of_array [|0.;1.;2.;5.;3.;2.;6.;7.;8.;9.|] [|10|] in
    Arr.(x = z)

  let test_29 () =
    let s = [R[2;8;3]] in
    let x = Arr.copy x0 in
    let y = Arr.of_array [|2.;3.;5.|] [|3|] in
    Arr.set_fancy s x y;
    let z = Arr.of_array [|0.;1.;2.;3.;4.;3.;6.;7.;5.;9.|] [|10|] in
    Arr.(x = z)

  let test_30 () =
    let s = [L[-1];R[-1]] in
    let x = Arr.copy x1 in
    let y = Arr.of_array [|0.|] [|1;1|] in
    Arr.set_fancy s x y;
    let z = Arr.copy x1 in
    Arr.set z [|9;9|] 0.;
    Arr.(x = z)

  let test_31 () =
    let s = [R[0;9;9];R[0;9;9]] in
    let x = Arr.copy x1 in
    let y = Arr.of_array [|5.;6.;7.;8.;|] [|2;2|] in
    Arr.set_fancy s x y;
    let z = Arr.copy x1 in
    Arr.set z [|0;0|] 5.;
    Arr.set z [|0;9|] 6.;
    Arr.set z [|9;0|] 7.;
    Arr.set z [|9;9|] 8.;
    Arr.(x = z)

  let test_32 () =
    let s = [R[-1;0;-9];R[-1;0;-9]] in
    let x = Arr.copy x1 in
    let y = Arr.of_array [|5.;6.;7.;8.;|] [|2;2|] in
    Arr.set_fancy s x y;
    let z = Arr.copy x1 in
    Arr.set z [|0;0|] 8.;
    Arr.set z [|0;9|] 7.;
    Arr.set z [|9;0|] 6.;
    Arr.set z [|9;9|] 5.;
    Arr.(x = z)

  let test_33 () =
    let s = [I(-1);L[-1];R[-2]] in
    let x = Arr.copy x2 in
    let y = Arr.of_array [|5.|] [|1;1;1|] in
    Arr.set_fancy s x y;
    let z = Arr.copy x2 in
    Arr.set z [|9;9;8|] 5.;
    Arr.(x = z)

  let test_34 () =
    let s = [I(-1);L[5;6];L[0]] in
    let x = Arr.copy x2 in
    let y = Arr.of_array [|1.;2.|] [|1;2;1|] in
    Arr.set_fancy s x y;
    let z = Arr.copy x2 in
    Arr.set z [|9;5;0|] 1.;
    Arr.set z [|9;6;0|] 2.;
    Arr.(x = z)

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

let test_26 () =
  Alcotest.(check bool) "test 26" true (To_test.test_26 ())

let test_27 () =
  Alcotest.(check bool) "test 27" true (To_test.test_27 ())

let test_28 () =
  Alcotest.(check bool) "test 28" true (To_test.test_28 ())

let test_29 () =
  Alcotest.(check bool) "test 29" true (To_test.test_29 ())

let test_30 () =
  Alcotest.(check bool) "test 30" true (To_test.test_30 ())

let test_31 () =
  Alcotest.(check bool) "test 31" true (To_test.test_31 ())

let test_32 () =
  Alcotest.(check bool) "test 32" true (To_test.test_32 ())

let test_33 () =
  Alcotest.(check bool) "test 33" true (To_test.test_33 ())

let test_34 () =
  Alcotest.(check bool) "test 34" true (To_test.test_34 ())

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
  "test 26", `Slow, test_26;
  "test 27", `Slow, test_27;
  "test 28", `Slow, test_28;
  "test 29", `Slow, test_29;
  "test 30", `Slow, test_30;
  "test 31", `Slow, test_31;
  "test 32", `Slow, test_32;
  "test 33", `Slow, test_33;
  "test 34", `Slow, test_34;
]
