(** Unit test for Owl_dense_ndarray_generic module *)

open Bigarray
open Owl_types

module M = Owl_dense_ndarray_generic

(* define the test error *)
let eps = 5e-10

let approx_equal a b = Pervasives.(abs_float (a -. b) < eps)


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

let vec = M.zeros Complex32 [|2;1|]
let _ =
   M.set vec [|0;0|] {Complex.re=0.0;im=3.0};
   M.set vec [|1;0|] {Complex.re=0.0;im=(-4.0)}

let x3 = M.sequential Float64 ~a:1. [|6|]


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

  let get_slice () =
    let y = M.get_slice [[];[0];[0]] x0 |> M.flatten in
    let z = M.zeros Float64 [|2|] in
    M.set z [|1|] 3.;
    M.equal y z

  let copy () = (M.copy x0) = x0

  let fill () =
    let y = M.empty Float64 [|2;2;3|] in
    M.fill y 2.;
    M.sum' y = 24.

  let map () = M.map (fun a -> a +. 1.) x0 |> M.sum' = 18.

  let fold () =
    let a = M.fold (fun c a -> c +. a) 0. x0 in
    M.get a [|0|] = 6.

  let add () = M.equal (M.add x0 x1) x2

  let mul () = M.mul x0 x1 |> M.sum' = 13.

  let add_scalar () = M.add_scalar x0 2. |> M.sum' = 30.

  let mul_scalar () = M.mul_scalar x0 2. |> M.sum' = 12.

  let abs () = M.equal (M.abs x0) x0

  let neg () = M.equal (M.map (fun a -> (-1.) *. a) x0) (M.neg x0)

  let sum' () = M.sum' x0 = 6.

  let min' () = M.min' x0 = 0.

  let max' () = M.max' x0 = 3.

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

  let transpose () =
    let y = M.copy x0 in
    let y = M.transpose y in
    M.get y [|1;0;0|] = 1. &&
    M.get y [|0;1;0|] = 2. &&
    M.get y [|0;0;1|] = 3.

  let flatten () = M.get (M.flatten x0) [|3|] = 2.

  let reshape () = M.get (M.reshape x0 [|2;3;2|]) [|0;1;1|] = 2.

  let l2norm' () = M.l2norm' vec = {Complex.re=5.0;im=0.}

  let save_load () =
    M.save x0 "ds_nda.tmp";
    let y = M.load Float64 "ds_nda.tmp" in
    M.equal x0 y

  let broadcast_add () =
    let x = M.sequential Float64 [|2;1;3|] in
    let y = M.ones Float64 [|2;1|] in
    let z = M.of_array Float64 [|1.;2.;3.;1.;2.;3.;4.;5.;6.;4.;5.;6.|] [|2;2;3|] in
    M.(equal z (add x y))

  let reverse () =
    let x = M.sequential Float64 [|3|] in
    let y = M.reverse x in
    M.get y [|0|] = 2. &&
    M.get y [|1|] = 1. &&
    M.get y [|2|] = 0.

  let rotate () =
    let x = M.sequential Float64 [|3;1|] in
    let y = M.rotate x 90 in
    M.get y [|0;0|] = 2. &&
    M.get y [|0;1|] = 1. &&
    M.get y [|0;2|] = 0.

  let same_shape_1 () =
    let x = M.empty Float64 [|1;2;3|] in
    let y = M.empty Float64 [|1;2;3|] in
    M.same_shape x y = true

  let same_shape_2 () =
    let x = M.empty Float64 [|1;2;3|] in
    let y = M.empty Float64 [|1;2;4|] in
    M.same_shape x y = false

  let same_shape_3 () =
    let x = M.empty Float64 [|1;2;3|] in
    let y = M.empty Float64 [|1;2;3;4|] in
    M.same_shape x y = false

  let same_shape_4 () =
    let x = M.empty Float64 [|1;2;3|] in
    let y = M.empty Float64 [|3;2;1|] in
    M.same_shape x y = false

  let same_shape_5 () =
    let x = M.empty Float64 [|1|] in
    let y = M.empty Float64 [|1|] in
    M.same_shape x y = true

  let linspace () =
    let x = M.linspace Float64 0. 9. 10 in
    let a = M.get x [|0|] in
    let b = M.get x [|5|] in
    let c = M.get x [|9|] in
    a = 0. && b = 5. && c = 9.

  let logspace_2 () =
    let x = M.logspace Float64 ~base:2. 0. 5. 6 in
    let a = M.get x [|0|] in
    let b = M.get x [|2|] in
    let c = M.get x [|5|] in
    a = 1. && b = 4. && c = 32.

  let logspace_10 () =
    let x = M.logspace Float64 ~base:10. 0. 5. 6 in
    let a = M.get x [|0|] in
    let b = M.get x [|2|] in
    let c = M.get x [|5|] in
    (a -. 1. < eps) && (b -. 100. < eps) && (c -. 100000. < eps)

  let logspace_e () =
    let _e = Owl.Const.e in
    let x = M.logspace Float64 0. 5. 6 in
    let a = M.get x [|0|] in
    let b = M.get x [|2|] in
    let c = M.get x [|5|] in
    (a -. _e < eps) && (b -. Owl.Maths.(pow _e 2.) < eps) && (c -. Owl.Maths.(pow _e 5.) < eps)

  let vecnorm_01 () =
    let a = M.vecnorm' ~p:1. x3 in
    approx_equal a 21.

  let vecnorm_02 () =
    let a = M.vecnorm' ~p:2. x3 in
    approx_equal a 9.539392014169456

  let vecnorm_03 () =
    let a = M.vecnorm' ~p:3. x3 in
    approx_equal a 7.6116626110202441

  let vecnorm_04 () =
    let a = M.vecnorm' ~p:4. x3 in
    approx_equal a 6.9062985796189906

  let vecnorm_05 () =
    let a = M.vecnorm' ~p:infinity x3 in
    approx_equal a 6.

  let vecnorm_06 () =
    let a = M.vecnorm' ~p:(-1.) x3 in
    approx_equal a 0.40816326530612251

  let vecnorm_07 () =
    let a = M.vecnorm' ~p:(-2.) x3 in
    approx_equal a 0.81885036774322384

  let vecnorm_08 () =
    let a = M.vecnorm' ~p:(-3.) x3 in
    approx_equal a 0.94358755060582611

  let vecnorm_09 () =
    let a = M.vecnorm' ~p:(-4.) x3 in
    approx_equal a 0.98068869669651115

  let vecnorm_10 () =
    let a = M.vecnorm' ~p:neg_infinity x3 in
    approx_equal a 1.

  let expand_01 () =
    let y = M.expand ~hi:true x0 5 in
    M.shape y = [|2;2;3;1;1|]

  let expand_02 () =
    let y = M.expand ~hi:false x0 5 in
    M.shape y = [|1;1;2;2;3|]

  let concatenate_01 () =
    let x = M.sequential Float64 ~a:1. [|2;3;4|] in
    let y = M.sequential Float64 ~a:25. [|1;3;4|] in
    let z = M.sequential Float64 ~a:1. [|3;3;4|] in
    let a = M.concatenate ~axis:0 [|x; y|] in
    M.(a = z)

  let concatenate_02 () =
    let x = M.of_array Float64 [|0.;2.|] [|2; 1|] in
    let y = M.of_array Float64 [|1.;3.|] [|2; 1|] in
    let z = M.sequential Float64 ~a:0. [|2;2|] in
    let a = M.concatenate ~axis:1 [|x; y|] in
    M.(a = z)

  let diff_1 () =
    let x = M.sequential Float64 [|3;3|] in
    let y = M.create Float64 [|2;3|] 3. in
    let z = M.diff ~axis:0 x in
    M.(y = z)

  let diff_2 () =
    let x = M.sequential Float64 [|3;3|] in
    let y = M.ones Float64 [|3;2|] in
    let z = M.diff ~axis:1 x in
    M.(y = z)

  let one_hot_1 () =
    let idx = M.of_array Float64 [|3.;2.;1.|] [|3|] in
    let x = M.one_hot 4 idx in
    let y = M.zeros Float64 [|3;4|] in
    M.set y [|0;3|] 1.;
    M.set y [|1;2|] 1.;
    M.set y [|2;1|] 1.;
    M.(x = y)

  let one_hot_2 () =
    let idx = M.of_array Float64 [|3.;2.;0.;1.|] [|2;2|] in
    let x = M.one_hot 4 idx in
    let y = M.zeros Float64 [|2;2;4|] in
    M.set y [|0;0;3|] 1.;
    M.set y [|0;1;2|] 1.;
    M.set y [|1;0;0|] 1.;
    M.set y [|1;1;1|] 1.;
    M.(x = y)


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

let get_slice () =
  Alcotest.(check bool) "get_slice" true (To_test.get_slice ())

let copy () =
  Alcotest.(check bool) "copy" true (To_test.copy ())

let fill () =
  Alcotest.(check bool) "fill" true (To_test.fill ())

let map () =
  Alcotest.(check bool) "map" true (To_test.map ())

let fold () =
  Alcotest.(check bool) "fold" true (To_test.fold ())

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

let sum' () =
  Alcotest.(check bool) "sum'" true (To_test.sum' ())

let min' () =
  Alcotest.(check bool) "min'" true (To_test.min' ())

let max' () =
  Alcotest.(check bool) "max'" true (To_test.max' ())

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

let transpose () =
  Alcotest.(check bool) "transpose" true (To_test.transpose ())

let flatten () =
  Alcotest.(check bool) "flatten" true (To_test.flatten ())

let reshape () =
  Alcotest.(check bool) "reshape" true (To_test.reshape ())

let l2norm' () =
  Alcotest.(check bool) "l2norm'" true (To_test.l2norm' ())

let save_load () =
  Alcotest.(check bool) "save_load" true (To_test.save_load ())

let broadcast_add () =
  Alcotest.(check bool) "broadcast_add" true (To_test.broadcast_add ())

let reverse () =
  Alcotest.(check bool) "reverse" true (To_test.reverse ())

let rotate () =
  Alcotest.(check bool) "rotate" true (To_test.rotate ())

let same_shape_1 () =
  Alcotest.(check bool) "same_shape_1" true (To_test.same_shape_1 ())

let same_shape_2 () =
  Alcotest.(check bool) "same_shape_2" true (To_test.same_shape_2 ())

let same_shape_3 () =
  Alcotest.(check bool) "same_shape_3" true (To_test.same_shape_3 ())

let same_shape_4 () =
  Alcotest.(check bool) "same_shape_4" true (To_test.same_shape_4 ())

let same_shape_5 () =
  Alcotest.(check bool) "same_shape_5" true (To_test.same_shape_5 ())

let linspace () =
  Alcotest.(check bool) "linspace" true (To_test.linspace ())

let logspace_2 () =
  Alcotest.(check bool) "logspace_2" true (To_test.logspace_2 ())

let logspace_10 () =
  Alcotest.(check bool) "logspace_10" true (To_test.logspace_10 ())

let logspace_e () =
  Alcotest.(check bool) "logspace_e" true (To_test.logspace_e ())

let vecnorm_01 () =
  Alcotest.(check bool) "vecnorm_01" true (To_test.vecnorm_01 ())

let vecnorm_02 () =
  Alcotest.(check bool) "vecnorm_02" true (To_test.vecnorm_02 ())

let vecnorm_03 () =
  Alcotest.(check bool) "vecnorm_03" true (To_test.vecnorm_03 ())

let vecnorm_04 () =
  Alcotest.(check bool) "vecnorm_04" true (To_test.vecnorm_04 ())

let vecnorm_05 () =
  Alcotest.(check bool) "vecnorm_05" true (To_test.vecnorm_05 ())

let vecnorm_06 () =
  Alcotest.(check bool) "vecnorm_06" true (To_test.vecnorm_06 ())

let vecnorm_07 () =
  Alcotest.(check bool) "vecnorm_07" true (To_test.vecnorm_07 ())

let vecnorm_08 () =
  Alcotest.(check bool) "vecnorm_08" true (To_test.vecnorm_08 ())

let vecnorm_09 () =
  Alcotest.(check bool) "vecnorm_09" true (To_test.vecnorm_09 ())

let vecnorm_10 () =
  Alcotest.(check bool) "vecnorm_10" true (To_test.vecnorm_10 ())

let expand_01 () =
  Alcotest.(check bool) "expand_01" true (To_test.expand_01 ())

let expand_02 () =
  Alcotest.(check bool) "expand_02" true (To_test.expand_02 ())

let concatenate_01 () =
  Alcotest.(check bool) "concatenate_01" true (To_test.concatenate_01 ())

let concatenate_02 () =
  Alcotest.(check bool) "concatenate_02" true (To_test.concatenate_02 ())

let diff_1 () =
  Alcotest.(check bool) "diff_1" true (To_test.diff_1 ())

let diff_2 () =
  Alcotest.(check bool) "diff_2" true (To_test.diff_2 ())

let one_hot_1 () =
  Alcotest.(check bool) "one_hot_1" true (To_test.one_hot_1 ())

let one_hot_2 () =
  Alcotest.(check bool) "one_hot_2" true (To_test.one_hot_2 ())

let test_set = [
  "shape", `Slow, shape;
  "num_dims", `Slow, num_dims;
  "nth_dim", `Slow, nth_dim;
  "numel", `Slow, numel;
  "nnz", `Slow, nnz;
  "density", `Slow, density;
  "get", `Slow, get;
  "set", `Slow, set;
  "get_slice", `Slow, get_slice;
  "copy", `Slow, copy;
  "fill", `Slow, fill;
  "map", `Slow, map;
  "fold", `Slow, fold;
  "add", `Slow, add;
  "mul", `Slow, mul;
  "add_scalar", `Slow, add_scalar;
  "mul_scalar", `Slow, mul_scalar;
  "abs", `Slow, abs;
  "neg", `Slow, neg;
  "sum'", `Slow, sum';
  "min'", `Slow, min';
  "max'", `Slow, max';
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
  "transpose", `Slow, transpose;
  "flatten", `Slow, flatten;
  "reshape", `Slow, reshape;
  "l2norm'", `Slow, l2norm';
  "save_load", `Slow, save_load;
  "broadcast_add", `Slow, broadcast_add;
  "reverse", `Slow, reverse;
  "rotate", `Slow, rotate;
  "same_shape_1", `Slow, same_shape_1;
  "same_shape_2", `Slow, same_shape_2;
  "same_shape_3", `Slow, same_shape_3;
  "same_shape_4", `Slow, same_shape_4;
  "same_shape_5", `Slow, same_shape_5;
  "linspace", `Slow, linspace;
  "logspace_2", `Slow, logspace_2;
  "logspace_10", `Slow, logspace_10;
  "logspace_e", `Slow, logspace_e;
  "vecnorm_01", `Slow, vecnorm_01;
  "vecnorm_02", `Slow, vecnorm_02;
  "vecnorm_03", `Slow, vecnorm_03;
  "vecnorm_04", `Slow, vecnorm_04;
  "vecnorm_05", `Slow, vecnorm_05;
  "vecnorm_06", `Slow, vecnorm_06;
  "vecnorm_07", `Slow, vecnorm_07;
  "vecnorm_08", `Slow, vecnorm_08;
  "vecnorm_09", `Slow, vecnorm_09;
  "vecnorm_10", `Slow, vecnorm_10;
  "expand_01", `Slow, expand_01;
  "expand_02", `Slow, expand_02;
  "concatenate_01", `Slow, concatenate_01;
  "concatenate_02", `Slow, concatenate_02;
  "diff_1", `Slow, diff_1;
  "diff_2", `Slow, diff_2;
  "one_hot_1", `Slow, one_hot_1;
  "one_hot_2", `Slow, one_hot_2;
]
