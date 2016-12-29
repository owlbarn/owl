(* Build with the following command
  `ocamlbuild -use-ocamlfind -package alcotest,owl unit_sparse_ndarray.native`
  *)

open Bigarray
module M = Owl_sparse_ndarray

(* make testable *)
let ndarray = Alcotest.testable (fun p (x : (float, float64_elt) M.t) -> ()) M.is_equal

(* some test input *)
let x0 = M.zeros Float64 [|2;2;3|]
let _ =
  M.set x0 [|0;0;1|] 1.;
  M.set x0 [|0;1;0|] 2.;
  M.set x0 [|1;0;0|] 3.

let x1 = M.zeros Float64 [|2;2;3|]
let _ =
  M.set x1 [|0;0;1|] 1.;
  M.set x1 [|0;0;2|] 2.;
  M.set x1 [|0;1;1|] 3.;
  M.set x1 [|1;0;0|] 4.

let x2 = M.zeros Float64 [|2;2;3|]
let _ =
  M.set x2 [|0;0;1|] 2.;
  M.set x2 [|0;0;2|] 2.;
  M.set x2 [|0;1;0|] 2.;
  M.set x2 [|0;1;1|] 3.;
  M.set x2 [|1;0;0|] 7.

(* a module with functions to test *)
module To_test = struct

  let shape () = M.shape x0 = [|2;2;3|]

  let num_dims () = M.num_dims x0 = 3

  let nth_dim () = M.nth_dim x0 2 = 3

  let numel () = M.numel x0 = 12

  let nnz () = M.nnz x0 = 3

  let density () = M.density x0 = (3. /. 12.)

  let get () = M.get x0 [|0;1;0|] = 2.

  let set () =
    let x = M.zeros Float64 [|2;2;3|] in
    M.set x [|1;0;1|] 5.;
    M.get x [|1;0;1|] = 5.

  let slice () =
    let y = M.slice [|None; Some 0; Some 0|] x0 in
    let z = M.zeros Float64 [|2|] in
    M.set z [|1|] 3.;
    M.is_equal y z

  let clone () = (M.clone x0) = x0

  let map () = M.map (fun a -> a +. 1.) x0 |> M.sum = 18.

  let map_nz () = M.map_nz (fun a -> a +. 1.) x0 |> M.sum = 9.

  let fold () = M.fold (fun c a -> c +. a) 0. x0 = 6.

  let foldi () =
    let a = M.foldi (fun i c a ->
      if i.(2) = 0 then c +. a else c
    ) 0. x0
    in a = 5.

  let fold_nz () = M.fold ~axis:[|None; None; Some 0|] (fun c a -> c +. a) 1. x0 = 6.

  let foldi_nz () =
    M.fold ~axis:[|None; None; Some 0|] (fun c a ->
      if a > 2. then c +. a else c
    ) 1. x0 = 4.

  let add () = M.is_equal (M.add x0 x1) x2

  let mul () = M.mul x0 x1 |> M.sum = 13.

  let add_scalar () = M.add_scalar x0 2. |> M.sum = 12.

  let mul_scalar () = M.mul_scalar x0 2. |> M.sum = 12.

  let abs () = M.is_equal (M.abs x0) x0

  let neg () = M.is_equal (M.map (fun a -> (-1.) *. a) x0) (M.neg x0)

  let sum () = M.sum x0 = 6.

  let min () = M.min x0 = 0.

  let max () = M.max x0 = 3.

  let is_zero () = M.is_zero x0

  let is_positive () = M.is_positive x0

  let is_negative () = M.is_negative x0

  let is_nonnegative () = M.is_nonnegative x0

  let is_equal () = M.is_equal x0 x1

  let is_greater () = M.is_greater x2 x0

  let equal_or_greater () = M.equal_or_greater x2 x0

  let filter () = M.filter ((=) 3.) x0 = [| [|1;0;0|] |]

  let filteri () = M.filteri (fun i a ->
    i.(2) = 1 && a = 3.
    ) x1 = [| [|0;1;1|] |]

  let filteri_nz () = M.filteri (fun i a ->
    i.(0) = 1 && a = 4.
    ) x1 = [| [|1;0;0|] |]

  let transpose () =
    let y = M.clone x0 in
    let y = M.transpose y in
    M.get y [|1;0;0|] = 1. &&
    M.get y [|0;1;0|] = 2. &&
    M.get y [|0;0;1|] = 3.

  let flatten () = M.get (M.flatten x0) [|3|] = 2.

  let reshape () = M.get (M.reshape x0 [|2;3;2|]) [|0;1;1|] = 2.

  let save_load () =
    M.save x0 "ds_nda.tmp";
    let y = M.load Float64 "ds_nda.tmp" in
    M.is_equal x0 y

end

(* the tests *)

let shape () =
  Alcotest.(check bool) "shape" true (To_test.shape ())

let num_dims () =
  Alcotest.(check bool) "num_dims" true (To_test.num_dims ())

let nth_dim () =
  Alcotest.(check bool) "nth_dim" true (To_test.nth_dim ())

let numel () =
  Alcotest.(check bool) "numel" true (To_test.numel ())

let nnz () =
  Alcotest.(check bool) "nnz" true (To_test.nnz ())

let density () =
  Alcotest.(check bool) "density" true (To_test.density ())

let get () =
  Alcotest.(check bool) "get" true (To_test.get ())

let set () =
  Alcotest.(check bool) "set" true (To_test.set ())

let slice () =
  Alcotest.(check bool) "slice" true (To_test.slice ())

let clone () =
  Alcotest.(check bool) "clone" true (To_test.clone ())

let map () =
  Alcotest.(check bool) "map" true (To_test.map ())

let map_nz () =
  Alcotest.(check bool) "map_nz" true (To_test.map_nz ())

let fold () =
  Alcotest.(check bool) "fold" true (To_test.fold ())

let foldi () =
  Alcotest.(check bool) "foldi" true (To_test.foldi ())

let fold_nz () =
  Alcotest.(check bool) "fold_nz" true (To_test.fold_nz ())

let foldi_nz () =
  Alcotest.(check bool) "foldi_nz" true (To_test.foldi_nz ())

let add () =
  Alcotest.(check bool) "add" true (To_test.add ())

let mul () =
  Alcotest.(check bool) "mul" true (To_test.mul ())

let add_scalar () =
  Alcotest.(check bool) "add_scalar" true (To_test.add_scalar ())

let mul_scalar () =
  Alcotest.(check bool) "mul_scalar" true (To_test.mul_scalar ())

let abs () =
  Alcotest.(check bool) "abs" true (To_test.abs ())

let neg () =
  Alcotest.(check bool) "neg" true (To_test.neg ())

let sum () =
  Alcotest.(check bool) "sum" true (To_test.sum ())

let min () =
  Alcotest.(check bool) "min" true (To_test.min ())

let max () =
  Alcotest.(check bool) "max" true (To_test.max ())

let is_zero () =
  Alcotest.(check bool) "is_zero" false (To_test.is_zero ())

let is_positive () =
  Alcotest.(check bool) "is_positive" false (To_test.is_positive ())

let is_negative () =
  Alcotest.(check bool) "is_negative" false (To_test.is_negative ())

let is_nonnegative () =
  Alcotest.(check bool) "is_nonnegative" true (To_test.is_nonnegative ())

let is_equal () =
  Alcotest.(check bool) "is_equal" false (To_test.is_equal ())

let is_greater () =
  Alcotest.(check bool) "is_greater" false (To_test.is_greater ())

let equal_or_greater () =
  Alcotest.(check bool) "equal_or_greater" true (To_test.equal_or_greater ())

let filter () =
  Alcotest.(check bool) "filter" true (To_test.filter ())

let filteri () =
  Alcotest.(check bool) "filteri" true (To_test.filteri ())

let filteri_nz () =
  Alcotest.(check bool) "filteri_nz" true (To_test.filteri_nz ())

let transpose () =
  Alcotest.(check bool) "transpose" true (To_test.transpose ())

let flatten () =
  Alcotest.(check bool) "flatten" true (To_test.flatten ())

let reshape () =
  Alcotest.(check bool) "reshape" true (To_test.reshape ())

let save_load () =
  Alcotest.(check bool) "save_load" true (To_test.save_load ())

let test_set = [
  "shape", `Slow, shape;
  "num_dims", `Slow, num_dims;
  "nth_dim", `Slow, nth_dim;
  "numel", `Slow, numel;
  "nnz", `Slow, nnz;
  "density", `Slow, density;
  "get", `Slow, get;
  "set", `Slow, set;
  "slice", `Slow, slice;
  "clone", `Slow, clone;
  "map", `Slow, map;
  "map_nz", `Slow, map_nz;
  "fold", `Slow, fold;
  "foldi", `Slow, foldi;
  "fold_nz", `Slow, fold_nz;
  "foldi_nz", `Slow, foldi_nz;
  "add", `Slow, add;
  "mul", `Slow, mul;
  "add_scalar", `Slow, add_scalar;
  "mul_scalar", `Slow, mul_scalar;
  "abs", `Slow, abs;
  "neg", `Slow, neg;
  "sum", `Slow, sum;
  "min", `Slow, min;
  "max", `Slow, max;
  "is_zero", `Slow, is_zero;
  "is_positive", `Slow, is_positive;
  "is_negative", `Slow, is_negative;
  "is_nonnegative", `Slow, is_nonnegative;
  "is_equal", `Slow, is_equal;
  "is_greater", `Slow, is_greater;
  "equal_or_greater", `Slow, equal_or_greater;
  "filter", `Slow, filter;
  "filteri", `Slow, filteri;
  "filteri_nz", `Slow, filteri_nz;
  "transpose", `Slow, transpose;
  "flatten", `Slow, flatten;
  "reshape", `Slow, reshape;
  "save_load", `Slow, save_load;
]

(* Run it *)
let () =
  Alcotest.run "Test M." [ "sparse ndarray", test_set; ]
