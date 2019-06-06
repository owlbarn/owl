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


  let n = 3
  let n_samples = 20
  let threshold = 1E-6
  let eps = 1E-5

  module FD = Owl_algodiff_grad_check.Make (AlgoM)

  let samples, directions = FD.generate_test_samples (n, n) n_samples

  let test_func f = FD.check_grad ~threshold ~eps ~directions ~f samples

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
    let diagm () =
      let f x = Maths.(diagm (get_row x 0)) in
      test_func f
    let trace () = test_func Maths.trace
    let tril  () = test_func Maths.tril
    let triu  () = test_func Maths.triu

    let inv   () =
      let e = Arr (Owl.Mat.eye n) in
      let f x =
        let x = Maths.(transpose x *@ x) in
        Maths.(inv (x + e)) in
      test_func f

    let logdet () =
      let e = Arr (Owl.Mat.eye n) in
      let f x =
        let x = Maths.(transpose x *@ x) in
        Linalg.logdet Maths.(x + e) in
      test_func f

    let qr  () =
      let f x =
        let q, r = Linalg.qr x in
        Maths.(q + r)
      in test_func f

    let lq  () =
      let f x =
        let l, q = Linalg.lq x in
        Maths.(l + q)
      in test_func f

    let svd () =
      let f =
        let y = Mat.gaussian 20 n in
        fun x ->
          let x = Maths.(y *@ x) in
          let u, s, vt = Linalg.svd x in
          Maths.(u + (sum' s) * (l2norm_sqr' vt))
      in test_func f

    let chol  () =
      let f x =
        let identity = Arr (Owl.Mat.eye n) in
        let s = Maths.(transpose x *@ x) in
        let s = Maths.(s + (F 0.001) * identity) in
        Maths.(inv (Linalg.chol ~upper:false s))
      in test_func f

    let split () =
      let f x =
        let a = Maths.split ~axis:0 [| 1; 1; 1|] x in
        Maths.(a.(0) + a.(1) * a.(2)) in
      test_func f

    let concatenate () =
      let f =
        let y1 = Mat.gaussian 10 n in
        let y2 = Mat.gaussian 15 n in
        fun x ->
          let y = Maths.concatenate ~axis:0 [|y1; x; y2|] in
          Maths.(y *@ x) in
      test_func f


    let of_arrays () =
      let f x =
        let y = Array.init n (fun i -> Array.init n (fun j -> if i=0 then (F 3.) else Maths.get_item x i j))
                |> Maths.of_arrays in
        Maths.(x * sin y)  in
      test_func f

    let to_arrays () =
      let f x =
        let a = Maths.to_arrays x in
        Maths.(a.(0).(1) * cos a.(1).(0)) in
      test_func f

    let init_2d () =
      let f x =
        let y = Mat.init_2d n n (fun i j -> if i=0 then (F 3.) else Maths.get_item x i j) in
        Maths.(y *@ x) in
      test_func f

    let lyapunov () =
      let r = Mat.gaussian n n in
      let identity = Arr Owl.Mat.(eye n) in
      let f =
        fun x ->
          let q = Maths.((F 0.5) * (x + (transpose x) + identity)) in
          let s = Maths.(r - (transpose r)) in
          let p = Maths.((r + x) *@ (transpose (r + x)) + identity) in
          let a = Maths.((s - (F 0.5) * q) *@ (inv p)) in
          Linalg.lyapunov a Maths.(neg q) in
      test_func f

    let discrete_lyapunov () =
      let r = Mat.gaussian n n in
      let identity = Arr Owl.Mat.(eye n) in
      let f =
        fun x ->
          let q = Maths.((F 0.5) * (x + (transpose x) + identity)) in
          let s = Maths.(r - (transpose r)) in
          let p = Maths.((r + x) *@ (transpose (r + x)) + identity) in
          let a = Maths.((s - (F 0.5) * q) *@ (inv p)) in
          let a = Maths.(a - identity) in
          Linalg.discrete_lyapunov a q in
      test_func f

    let linsolve () =
      let x = Mat.gaussian n n in
      let f a =
        let b = Maths.(a *@ x) in
        let x = Linalg.(linsolve a b) in
        let at = Linalg.(linsolve ~trans:true x (Maths.transpose b)) in
        Maths.(a + at + x) in
      test_func f

    let linsolve_triangular () =
      let x = Mat.gaussian n n in
      let f a =
        let a_l = Maths.tril a in
        let p_l = Maths.(a_l *@ (transpose a_l)) in
        let a_u = Maths.triu a in
        let p_u = Maths.(transpose a_u *@ a_u) in
        let b_l = Maths.(p_l *@ x) in
        let b_u = Maths.(p_u *@ x) in
        let x_l = Linalg.linsolve ~typ:`l a_l b_l
                |> Linalg.(linsolve ~typ:`l ~trans:true a_l) in
        let x_u = Linalg.(linsolve ~typ:`u ~trans:true a_u b_u)
                |> Linalg.(linsolve ~typ:`u a_u) in
        let atl = Linalg.(linsolve ~trans:true x_l (Maths.transpose b_l)) in
        let atu = Linalg.(linsolve ~trans:true x_u (Maths.transpose b_u)) in
        Maths.(atl *@ atu) in
      test_func f

  end

  let alco_fun s f =
    let check, c = f () in
    Alcotest.(check bool) (sprintf "%s: %i/%i passed" s c n_samples) true check

  let sin () = alco_fun "sin" To_test.sin

  let cos () = alco_fun "cos" To_test.cos

  let tan () = alco_fun "tan" To_test.tan

  let sinh () = alco_fun "sinh" To_test.sinh

  let cosh () = alco_fun "cosh" To_test.cosh

  let tanh () = alco_fun "tanh" To_test.tanh

  let exp () = alco_fun "exp" To_test.exp

  let diag () = alco_fun "diag" To_test.diag

  let diagm () = alco_fun "diagm" To_test.diagm

  let trace () = alco_fun "trace" To_test.trace

  let tril () = alco_fun "tril" To_test.tril

  let triu () = alco_fun "triu" To_test.triu

  let inv () = alco_fun "inv" To_test.inv

  let logdet () = alco_fun "logdet" To_test.logdet

  let chol () = alco_fun "chol" To_test.chol

  let qr () = alco_fun "qr" To_test.qr

  let lq () = alco_fun "lq" To_test.lq

  let svd () = alco_fun "svd" To_test.svd

  let split () = alco_fun "split" To_test.split

  let concatenate () = alco_fun "concatenate" To_test.concatenate

  let of_arrays () = alco_fun "of_arrays" To_test.of_arrays

  let to_arrays () = alco_fun "to_arrays" To_test.to_arrays

  let init_2d () = alco_fun "init_2d" To_test.init_2d

  let lyapunov () = alco_fun "lyapunov" To_test.lyapunov

  let discrete_lyapunov () = alco_fun "discrete_lyapunov" To_test.discrete_lyapunov

  let linsolve () = alco_fun "linsolve" To_test.linsolve

  let linsolve_triangular () = alco_fun "linsolve_triangular" To_test.linsolve_triangular

  let test_set = [
    "sin",                      `Slow,     sin;
    "cos",                      `Slow,     cos;
    "tan",                      `Slow,     tan;
    "sinh",                     `Slow,     sinh;
    "cosh",                     `Slow,     cosh;
    "tanh",                     `Slow,     tanh;
    "exp",                      `Slow,     exp;
    "diag",                     `Slow,     diag;
    "diagm",                    `Slow,     diagm;
    "trace",                    `Slow,     trace;
    "tril",                     `Slow,     tril;
    "triu",                     `Slow,     triu;
    "inv",                      `Slow,     inv;
    "logdet",                   `Slow,     logdet;
    "chol",                     `Slow,     chol;
    "qr",                       `Slow,     qr;
    "lq",                       `Slow,     lq;
    "split",                    `Slow,     split;
    "concatenate",              `Slow,     concatenate;
    "svd",                      `Slow,     svd;
    "of_arrays",                `Slow,     of_arrays;
    "to_arrays",                `Slow,     to_arrays;
    "init_2d",                  `Slow,     init_2d;
    "lyapunov",                 `Slow,     lyapunov;
    "discrete_lyapunov",        `Slow,     discrete_lyapunov;
    "linsolve",                 `Slow,     linsolve;
    "linsolve_triangular",      `Slow,     linsolve_triangular;
  ]

end
