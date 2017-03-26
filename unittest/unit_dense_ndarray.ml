(* Build with the following command
  `ocamlbuild -use-ocamlfind -package alcotest,owl unit_dense_ndarray.native`
  *)

open Bigarray
module M = Owl_dense_ndarray_generic

(* make testable *)
let ndarray = Alcotest.testable (fun p (x : (float, float64_elt) M.t) -> ()) M.equal

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
    M.equal y z

  let clone () = (M.clone x0) = x0

  let fill () =
    let y = M.empty Float64 [|2;2;3|] in
    M.fill y 2.;
    M.sum y = 24.

  let map () = M.map (fun a -> a +. 1.) x0 |> M.sum = 18.

  let fold () = M.fold (fun c a -> c +. a) 0. x0 = 6.

  let foldi () =
    let a = M.foldi (fun i c a ->
      if i.(2) = 0 then c +. a else c
    ) 0. x0
    in a = 5.

  let add () = M.equal (M.add x0 x1) x2

  let mul () = M.mul x0 x1 |> M.sum = 13.

  let add_scalar () = M.add_scalar x0 2. |> M.sum = 30.

  let mul_scalar () = M.mul_scalar x0 2. |> M.sum = 12.

  let abs () = M.equal (M.abs x0) x0

  let neg () = M.equal (M.map (fun a -> (-1.) *. a) x0) (M.neg x0)

  let sum () = M.sum x0 = 6.

  let min () = M.min x0 = 0.

  let max () = M.max x0 = 3.

  let minmax_i () =
    let (a, i), (b, j) = M.minmax_i x0 in
    a = 0. && i = [|0;0;0|] &&
    b = 3. && j = [|1;0;0|]

  let is_zero () = M.is_zero x0

  let is_positive () = M.is_positive x0

  let is_negative () = M.is_negative x0

  let is_nonnegative () = M.is_nonnegative x0

  let equal () = M.equal x0 x1

  let greater () = M.greater x2 x0

  let greater_equal () = M.greater_equal x2 x0

  let exists () = M.exists ((<) 0.) x0

  let not_exists () = M.not_exists ((>) 0.) x0

  let for_all () = M.for_all ((<=) 0.) x0

  let filter () = M.filter ((=) 3.) x0 = [| [|1;0;0|] |]

  let filteri () = M.filteri (fun i a ->
    i.(2) = 1 && a = 3.
    ) x1 = [| [|0;1;1|] |]

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
    M.equal x0 y

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

let fill () =
  Alcotest.(check bool) "fill" true (To_test.fill ())

let map () =
  Alcotest.(check bool) "map" true (To_test.map ())

let fold () =
  Alcotest.(check bool) "fold" true (To_test.fold ())

let foldi () =
  Alcotest.(check bool) "foldi" true (To_test.foldi ())

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

let minmax_i () =
  Alcotest.(check bool) "minmax_i" true (To_test.minmax_i ())

let is_zero () =
  Alcotest.(check bool) "is_zero" false (To_test.is_zero ())

let is_positive () =
  Alcotest.(check bool) "is_positive" false (To_test.is_positive ())

let is_negative () =
  Alcotest.(check bool) "is_negative" false (To_test.is_negative ())

let is_nonnegative () =
  Alcotest.(check bool) "is_nonnegative" true (To_test.is_nonnegative ())

let equal () =
  Alcotest.(check bool) "equal" false (To_test.equal ())

let greater () =
  Alcotest.(check bool) "greater" false (To_test.greater ())

let greater_equal () =
  Alcotest.(check bool) "greater_equal" true (To_test.greater_equal ())

let exists () =
  Alcotest.(check bool) "exists" true (To_test.exists ())

let not_exists () =
  Alcotest.(check bool) "not_exists" true (To_test.not_exists ())

let for_all () =
  Alcotest.(check bool) "for_all" true (To_test.for_all ())

let filter () =
  Alcotest.(check bool) "filter" true (To_test.filter ())

let filteri () =
  Alcotest.(check bool) "filteri" true (To_test.filteri ())

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
  "fill", `Slow, fill;
  "map", `Slow, map;
  "fold", `Slow, fold;
  "foldi", `Slow, foldi;
  "add", `Slow, add;
  "mul", `Slow, mul;
  "add_scalar", `Slow, add_scalar;
  "mul_scalar", `Slow, mul_scalar;
  "abs", `Slow, abs;
  "neg", `Slow, neg;
  "sum", `Slow, sum;
  "min", `Slow, min;
  "max", `Slow, max;
  "minmax_i", `Slow, minmax_i;
  "is_zero", `Slow, is_zero;
  "is_positive", `Slow, is_positive;
  "is_negative", `Slow, is_negative;
  "is_nonnegative", `Slow, is_nonnegative;
  "equal", `Slow, equal;
  "greater", `Slow, greater;
  "greater_equal", `Slow, greater_equal;
  "exists", `Slow, exists;
  "not_exists", `Slow, not_exists;
  "for_all", `Slow, for_all;
  "filter", `Slow, filter;
  "filteri", `Slow, filteri;
  "transpose", `Slow, transpose;
  "flatten", `Slow, flatten;
  "reshape", `Slow, reshape;
  "save_load", `Slow, save_load;
]

(* Run it *)
let () =
  Alcotest.run "Test M." [ "dense ndarray", test_set; ]
