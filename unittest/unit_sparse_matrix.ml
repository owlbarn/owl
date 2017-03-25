(* Build with the following command
  `ocamlbuild -use-ocamlfind -package alcotest,owl unit_sparse_matrix.native`
  *)

open Bigarray
module M = Owl_sparse_matrix_generic

(* make testable *)
let matrix = Alcotest.testable (fun p x -> ()) M.is_equal

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

  let transpose () =
    let y = M.zeros Float64 4 3 in
    let y = M.mapi (fun i j _ ->
      (i + (M.row_num y) * j) |> float_of_int
    ) y in
    M.is_equal y (M.transpose x2)

  let fill () =
    let x = M.zeros Float64 3 4 in
    M.fill x 1.; x

  let get x = M.get x 1 2

  let set x =
    let x = M.zeros Float64 3 4 in
    M.set x 2 1 5.;
    M.get x 2 1

  let row () = Owl_dense_matrix_generic.of_arrays Float64 [| [|4.;5.;6.;7.|] |] |> M.of_dense

  let col () = Owl_dense_matrix_generic.of_arrays Float64 [| [|1.|];[|5.|];[|9.|] |] |> M.of_dense

  let trace x = M.trace x

  let sum x = M.sum x

  let exists x = M.exists (fun a -> a = 6.) x

  let not_exists x = M.not_exists (fun a -> a > 13.) x

  let for_all x = M.for_all (fun a -> a < 11.) x

  let is_equal x y = M.is_equal x y

  let is_unequal x y = M.is_unequal x y

  let is_smaller () =
    let x = M.ones Float64 3 4 in
    let y = M.ones Float64 3 4 in
    let y = M.mul_scalar y 2. in
    M.is_smaller x y

  let is_greater () =
    let x = M.ones Float64 3 4 in
    let y = M.ones Float64 3 4 in
    M.set y 0 0 0.; M.set y 0 1 2.;
    M.is_greater x y

  let equal_or_greater x = M.equal_or_greater x x

  let equal_or_smaller x = M.equal_or_smaller x x

  let is_zero x = M.is_zero x

  let is_positive x = M.is_positive x

  let is_negative x = M.is_negative x

  let is_nonnegative x = M.is_nonnegative x

  let is_nonpositive x = M.is_nonpositive x

  let add x =
    let y0 = M.mul_scalar x 2. in
    let y1 = M.add x x in
    M.is_equal y0 y1

  let mul x =
    let y0 = M.mul_scalar x 2. in
    let m, n = M.shape x in
    let y1 = M.zeros Float64 m n in
    M.fill y1 2.;
    let y2 = M.mul x y1 in
    M.is_equal y0 y2

  let dot () =
    let x = M.sequential Float64 2 3 in
    let x = M.map ((+.) 1.) x in
    let y = M.sequential Float64 3 2 in
    let y = M.map ((+.) 1.) y in
    let a = M.dot x y in
    let b = Owl_dense_matrix_generic.of_arrays Float64 [| [|22.;28.|]; [|49.;64.|] |] |> M.of_dense in
    M.is_equal a b

  let add_scalar () = M.add_scalar x1 2. |> M.sum = 36.

  let mul_scalar () = M.mul_scalar x1 2. |> M.sum = 24.

  let min () =
    let x = M.add_scalar x2 1. in
    M.min x = 0.

  let max () =
    let x = M.add_scalar x2 1. in
    M.max x = 12.

  let map () =
    let x = M.ones Float64 3 4 in
    let y = M.sequential Float64 3 4 in
    let z0 = M.add x y in
    let z1 = M.map (fun a -> a +. 1.) y in
    M.is_equal z0 z1

  let fold x = M.fold (+.) 0. x

  let foldi () =
    let a = M.foldi (fun i j c a ->
      if i <> 0 then c +. a else c
    ) 0. x2
    in a = 60.

  let foldi_nz () =
    let a = M.foldi_nz (fun i j c a ->
      if i <> 2 then c +. a else c
    ) 0. x2
    in a = 28.

  let filter () = M.filter ((=) 3.) x2 = [| (0,3) |]

  let fold_rows () =
    let x = M.fold_rows (fun c a -> M.add c a) (M.zeros Float64 1 4) x2
    |> M.to_dense |> Owl_dense_matrix_generic.to_arrays in
    x = [| [|12.;15.;18.;21.|] |]

  let fold_cols () =
    let x = M.fold_cols (fun c a -> M.add c a) (M.zeros Float64 3 1) x2
    |> M.to_dense |> Owl_dense_matrix_generic.to_arrays in
    x = [| [|6.|]; [|22.|]; [|38.|] |]

  let sum_rows () =
    let x = M.sum_rows x2 |> M.to_dense |> Owl_dense_matrix_generic.to_arrays in
    x = [| [|12.;15.;18.;21.|] |]

  let sum_cols () =
    let x = M.sum_cols x2 |> M.to_dense |> Owl_dense_matrix_generic.to_arrays in
    x = [| [|6.|]; [|22.|]; [|38.|] |]

  let of_array () =
    let a = [|([|0; 1|], 1.); ([|0; 2|], 2.); ([|0; 3|], 3.); ([|1; 0|], 4.);
              ([|1; 1|], 5.); ([|1; 2|], 6.); ([|1; 3|], 7.); ([|2; 0|], 8.);
              ([|2; 1|], 9.); ([|2; 2|], 10.); ([|2; 3|], 11.)|] in
    let y = M.of_array Float64 3 4 a in
    M.is_equal y x2

  let save_load () =
    M.save x2 "sp_mat.tmp";
    let y = M.load Float64 "sp_mat.tmp" in
    M.is_equal x2 y

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

let transpose () =
  Alcotest.(check bool) "transpose" true (To_test.transpose ())

let get () =
  Alcotest.(check float) "get" 6. (To_test.get x2)

let set () =
  Alcotest.(check float) "set" 5. (To_test.set x2)

let fill () =
  Alcotest.(check matrix) "fill" x1 (To_test.fill ())

let row () =
  Alcotest.(check matrix) "row" (M.row x2 1) (To_test.row ())

let col () =
  Alcotest.(check matrix) "col" (M.col x2 1) (To_test.col ())

let trace () =
  Alcotest.(check float) "trace" 15. (To_test.trace x2)

let sum () =
  Alcotest.(check float) "sum" 66. (To_test.sum x2)

let exists () =
  Alcotest.(check bool) "exits" true (To_test.exists x2)

let not_exists () =
  Alcotest.(check bool) "not_exists" true (To_test.not_exists x2)

let for_all () =
  Alcotest.(check bool) "for_all" false (To_test.for_all x2)

let is_equal () =
  Alcotest.(check bool) "is_equal" true (To_test.is_equal x1 (M.map ((+.) 1.) x0))

let is_unequal () =
  Alcotest.(check bool) "is_unequal" true (To_test.is_unequal x0 x1)

let is_smaller () =
  Alcotest.(check bool) "is_smaller" true (To_test.is_smaller ())

let is_greater () =
  Alcotest.(check bool) "is_greater" false (To_test.is_greater ())

let equal_or_greater () =
  Alcotest.(check bool) "equal_or_greater" true (To_test.equal_or_greater x2)

let equal_or_smaller () =
  Alcotest.(check bool) "equal_or_smaller" true (To_test.equal_or_smaller x2)

let is_zero () =
  Alcotest.(check bool) "is_zero" true (To_test.is_zero x0)

let is_positive () =
  Alcotest.(check bool) "is_positive" true (To_test.is_positive x1)

let is_negative () =
  Alcotest.(check bool) "is_negative" false (To_test.is_negative x1)

let is_nonnegative () =
  Alcotest.(check bool) "is_nonnegative" true (To_test.is_nonnegative x0)

let is_nonpositive () =
  Alcotest.(check bool) "is_nonpositive" true (To_test.is_nonpositive x0)

let add () =
  Alcotest.(check bool) "add" true (To_test.add x2)

let mul () =
  Alcotest.(check bool) "mul" true (To_test.mul x2)

let dot () =
  Alcotest.(check bool) "dot" true (To_test.dot ())

let add_scalar () =
  Alcotest.(check bool) "add_scalar" true (To_test.add_scalar ())

let mul_scalar () =
  Alcotest.(check bool) "mul_scalar" true (To_test.mul_scalar ())

let min x =
  Alcotest.(check bool) "min" true (To_test.min ())

let max x =
  Alcotest.(check bool) "max" true (To_test.max ())

let map x =
  Alcotest.(check bool) "map" true (To_test.map ())

let fold () =
  Alcotest.(check float) "fold" (M.sum x2) (To_test.fold x2)

let foldi () =
  Alcotest.(check bool) "foldi" true (To_test.foldi ())

let foldi_nz () =
  Alcotest.(check bool) "foldi_nz" true (To_test.foldi_nz ())

let filter () =
  Alcotest.(check bool) "filter" true (To_test.filter ())

let fold_rows () =
  Alcotest.(check bool) "fold_rows" true (To_test.fold_rows ())

let fold_cols () =
  Alcotest.(check bool) "fold_cols" true (To_test.fold_cols ())

let sum_rows () =
  Alcotest.(check bool) "sum_rows" true (To_test.sum_rows ())

let sum_cols () =
  Alcotest.(check bool) "sum_cols" true (To_test.sum_cols ())

let of_array () =
  Alcotest.(check bool) "of_array" true (To_test.of_array ())

let save_load () =
  Alcotest.(check bool) "save_load" true (To_test.save_load ())

let test_set = [
  "sequential", `Slow, sequential;
  "row_num", `Slow, row_num;
  "col_num", `Slow, col_num;
  "numel", `Slow, numel;
  "transpose", `Slow, transpose;
  "get", `Slow, get;
  "set", `Slow, set;
  "row", `Slow, row;
  "col", `Slow, col;
  "fill", `Slow, fill;
  "trace", `Slow, trace;
  "sum", `Slow, sum;
  "exists", `Slow, exists;
  "not_exists", `Slow, not_exists;
  "for_all", `Slow, for_all;
  "is_equal", `Slow, is_equal;
  "is_unequal", `Slow, is_unequal;
  "is_smaller", `Slow, is_smaller;
  "is_greater", `Slow, is_greater;
  "equal_or_greater", `Slow, equal_or_greater;
  "equal_or_smaller", `Slow, equal_or_smaller;
  "is_zero", `Slow, is_zero;
  "is_positive", `Slow, is_positive;
  "is_negative", `Slow, is_negative;
  "is_nonnegative", `Slow, is_nonnegative;
  "is_nonpositive", `Slow, is_nonpositive;
  "add", `Slow, add;
  "mul", `Slow, mul;
  "dot", `Slow, dot;
  "add_scalar", `Slow, add_scalar;
  "mul_scalar", `Slow, mul_scalar;
  "min", `Slow, min;
  "max", `Slow, max;
  "map", `Slow, map;
  "fold", `Slow, fold;
  "foldi", `Slow, foldi;
  "foldi_nz", `Slow, foldi_nz;
  "filter", `Slow, filter;
  "fold_rows", `Slow, fold_rows;
  "fold_cols", `Slow, fold_cols;
  "sum_rows", `Slow, sum_rows;
  "sum_cols", `Slow, sum_cols;
  "of_array", `Slow, of_array;
  "save_load", `Slow, save_load;
]

(* Run it *)
let () =
  Alcotest.run "Test M." [ "sparse matrix", test_set; ]
