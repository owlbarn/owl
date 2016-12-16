(* Build with the following command
  `ocamlbuild -use-ocamlfind -package alcotest,owl unit_dense_matrix.native`
  *)

open Bigarray
module M = Owl_dense_matrix

(* make testable *)
let matrix = Alcotest.testable Owl_pretty.pp_fmat M.is_equal

(* some test input *)
let x0 = M.zeros Float64 3 4
let x1 = M.ones Float64 3 4
let x2 = M.sequential Float64 3 4

(* a module with functions to test *)
module To_test = struct
  let sequential () = M.sequential Float64 3 4

  let row_num x = M.row_num x

  let col_num x = M.col_num x

  let numel x = M.numel x

  let fill () =
    let x = M.empty Float64 3 4 in
    M.fill x 1.; x

  let get x = M.get x 1 2

  let set x =
    let x = M.empty Float64 3 4 in
    M.set x 2 1 5.;
    M.get x 2 1

  let row () = M.of_arrays [| [|5.;6.;7.;8.|] |]

  let col () = M.of_arrays [| [|2.|];[|6.|];[|10.|] |]

  let trace x = M.trace x

  let add_diag () =
    let x = M.zeros Float64 3 3 in
    M.add_diag x 1.

  let sum x = M.sum x

  let fold x = M.fold (+.) 0. x

  let exists x = M.exists (fun a -> a = 6.) x

  let not_exists x = M.not_exists (fun a -> a > 13.) x

  let for_all x = M.for_all (fun a -> a < 12.) x

  let is_equal x y = M.is_equal x y

  let is_unequal x y = M.is_unequal x y

  let is_greater () =
    let x = M.uniform Float64 3 3 in
    let y = M.uniform Float64 3 3 in
    y.{2,2} <- (-99.); y.{2,1} <- 99.;
    M.is_greater x y

  let is_smaller () =
    let x = M.uniform Float64 3 3 in
    let y = M.neg x in
    M.is_smaller y x

  let is_zero x = M.is_zero x

  let add x =
    let y0 = M.mul_scalar x 2. in
    let y1 = M.add x x in
    M.is_equal y0 y1

  let mul x =
    let y0 = M.mul_scalar x 2. in
    let m, n = M.shape x in
    let y1 = M.create Float64 m n 2. in
    let y2 = M.mul x y1 in
    M.is_equal y0 y2

  let min x = M.min x

  let max x = M.max x

  let map () =
    let x = M.ones Float64 3 4 in
    let y = M.sequential Float64 3 4 in
    let z0 = M.add x y in
    let z1 = M.map (fun a -> a +. 1.) y in
    M.is_equal z0 z1

end

(* the tests *)

let sequential () =
  Alcotest.(check matrix) "sequential" x2 (To_test.sequential ())

let row_num () =
  Alcotest.(check int) "row_num" 3 (To_test.row_num x2)

let col_num () =
  Alcotest.(check int) "col_num" 4 (To_test.col_num x0)

let numel () =
  Alcotest.(check int) "numel" 12 (To_test.numel x0)

let get () =
  Alcotest.(check float) "get" 7. (To_test.get x2)

let set () =
  Alcotest.(check float) "set" 5. (To_test.set x2)

let fill () =
  Alcotest.(check matrix) "fill" x1 (To_test.fill ())

let row () =
  Alcotest.(check matrix) "row" (M.row x2 1) (To_test.row ())

let col () =
  Alcotest.(check matrix) "col" (M.col x2 1) (To_test.col ())

let trace () =
  Alcotest.(check float) "trace" 18. (To_test.trace x2)

let add_diag () =
  Alcotest.(check matrix) "add_diag" (M.eye Float64 3) (To_test.add_diag ())

let sum () =
  Alcotest.(check float) "sum" 78. (To_test.sum x2)

let fold () =
  Alcotest.(check float) "fold" (M.sum x2) (To_test.fold x2)

let exists () =
  Alcotest.(check bool) "exits" true (To_test.exists x2)

let not_exists () =
  Alcotest.(check bool) "not_exists" true (To_test.not_exists x2)

let for_all () =
  Alcotest.(check bool) "for_all" false (To_test.for_all x2)

let is_equal () =
  Alcotest.(check bool) "is_equal" true (To_test.is_equal x1 (M.add_scalar x0 1.))

let is_unequal () =
  Alcotest.(check bool) "is_unequal" true (To_test.is_unequal x0 x1)

let is_greater () =
  Alcotest.(check bool) "is_greater" false (To_test.is_greater ())

let is_smaller () =
  Alcotest.(check bool) "is_smaller" true (To_test.is_smaller ())

let is_zero () =
  Alcotest.(check bool) "is_zero" true (To_test.is_zero x0)

let add () =
  Alcotest.(check bool) "add" true (To_test.add x2)

let mul () =
  Alcotest.(check bool) "mul" true (To_test.mul x2)

let min x =
  Alcotest.(check float) "min" 1. (To_test.min x2)

let max x =
  Alcotest.(check float) "max" 12. (To_test.max x2)

let map x =
  Alcotest.(check bool) "map" true (To_test.map ())

let test_set = [
  "sequential", `Slow, sequential;
  "row_num", `Slow, row_num;
  "col_num", `Slow, col_num;
  "numel", `Slow, col_num;
  "get", `Slow, get;
  "set", `Slow, set;
  "row", `Slow, row;
  "col", `Slow, col;
  "fill", `Slow, fill;
  "trace", `Slow, trace;
  "add_diag", `Slow, add_diag;
  "sum", `Slow, sum;
  "fold", `Slow, fold;
  "exists", `Slow, exists;
  "not_exists", `Slow, not_exists;
  "for_all", `Slow, for_all;
  "is_equal", `Slow, is_equal;
  "is_unequal", `Slow, is_unequal;
  "is_greater", `Slow, is_greater;
  "is_smaller", `Slow, is_smaller;
  "is_zero", `Slow, is_zero;
  "add", `Slow, add;
  "mul", `Slow, mul;
  "min", `Slow, min;
  "max", `Slow, max;
  "map", `Slow, map;
]

(* Run it *)
let () =
  Alcotest.run "Test M." [ "dense matrix", test_set; ]
