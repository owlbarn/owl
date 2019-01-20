(** Unit test for Algodiff module *)

open Owl_types


(* functor to generate test unit. *)

module Make
    (M : Ndarray_Algodiff with type elt = float)
= struct

  open Printf
  module M = Owl.Mat

  module AlgoM = Owl.Algodiff.D
  open AlgoM

  module GT = FDGrad_test (struct let n = 3 let n_xs = 20 let threshold = 1E-5 let eps = 1E-5 end) 

  open GT

  module To_test = struct
    let sin   () = test_func Maths.sin
    let cos   () = test_func Maths.cos
    let tan   () = 
      let f x = Maths.((tan x) * (cos x) * (cos x))  
      in test_func f
    let sinh  () = test_func Maths.sinh
    let cosh  () = test_func Maths.cosh
    let exp   () = test_func Maths.exp
    let tanh  () = test_func Maths.tanh
    let diag  () = test_func Maths.diag
    let trace () = test_func Maths.trace
    let tril  () = test_func Maths.tril
    let triu  () = test_func Maths.triu

    let inv   () = 
      let e = Arr (Owl.Mat.eye n) in
      let f x = 
        Maths.(inv (x + e)) in
      test_func f

    let qr  () =
      let f x = 
        let q, r = Maths.qr x in
        Maths.(q + r)
      in test_func f

    let svd () = 
      let f x =                   
        let x = Maths.((transpose x) *@ x) in
        let u, s, vt = Maths.svd x in
        Maths.(u + (sum' s) * (l2norm_sqr' vt))
      in test_func f

    let chol  () = 
      let f x = 
        let s = Maths.(transpose x *@ x) in
        Maths.( (chol ~upper:true s) + (chol ~upper:false s))
      in test_func f 

    let split () =
      let f x = 
        let a = Maths.split 0 [| 1; 1; 1|] x in
        Maths.(a.(0) + a.(1) * a.(2)) in
      test_func f

    let lyapunov () =
      let f x = 
        let q = Arr Owl.Mat.((gaussian n n)) in
        let q = Maths.(q + x) in
        let q = Maths.(neg (transpose q *@ q)) in
        Maths.lyapunov x q in
      test_func f

  end

  let alco_fun s f =
    let check, c = f () in
    Alcotest.(check bool) (sprintf "%s: %i/%i passed" s c n_xs) true check

  let sin () = alco_fun "sin" To_test.sin

  let cos () = alco_fun "cos" To_test.cos

  let tan () = alco_fun "tan" To_test.tan

  let sinh () = alco_fun "sinh" To_test.sinh

  let cosh () = alco_fun "cosh" To_test.cosh

  let tanh () = alco_fun "tanh" To_test.tanh

  let exp () = alco_fun "exp" To_test.exp

  let diag () = alco_fun "diag" To_test.diag

  let trace () = alco_fun "trace" To_test.trace

  let tril () = alco_fun "tril" To_test.tril

  let triu () = alco_fun "triu" To_test.triu

  let inv () = alco_fun "inv" To_test.inv
      
  let chol () = alco_fun "chol" To_test.chol

  let qr () = alco_fun "qr" To_test.qr

  let svd () = alco_fun "svd" To_test.svd

  let split () = alco_fun "split" To_test.split


  let test_set = [
    "sin",   `Slow,   sin;
    "cos",   `Slow,   cos;
    "tan",   `Slow,   tan;
    "sinh",  `Slow,   sinh;
    "cosh",  `Slow,   cosh;
    "tanh",  `Slow,   tanh;
    "exp",   `Slow,   exp;
    "diag",  `Slow,   diag;
    "trace", `Slow,   trace;
    "tril",  `Slow,   tril;
    "triu",  `Slow,   triu;
    "inv",   `Slow,   inv;
    "chol",  `Slow,   chol;
    "qr",    `Slow,   qr;
    "split", `Slow,   split;
    "svd",   `Slow,   svd;
  ]

end
