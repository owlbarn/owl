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


  let n = 3 (* size of matrix n x n*)
  let n_xs = 1

  let eps = 1E-5
  let xs = Array.init n_xs (fun _ -> Mat.gaussian n n)
           |> Array.map (fun a -> Maths.(transpose a *@ a))

  let ds = 
    Array.init (n * n) (fun j -> 
        Arr (M.init n n (fun i -> if i=j then 1. else 0.)))

  let g ~f x = (grad f) x
  let fd_g ~f x d = 
    let dx = Maths.( (F eps) * d) in
    Maths.( ((f (x + dx)) - (f (x - dx))) / (F (2. *. eps)) )

  let check_grads ?threshold:(th=1E-5) rs = 
    let n_d = Array.length rs in
    let r_fds = Array.map snd rs in
    let rms = (Array.fold_left (fun acc r_fd -> acc +. (r_fd *. r_fd ) ) 0. r_fds) /. (float n_d) |> sqrt in
    let max_err = rs |> Array.map (fun (r_ad, r_fd) -> abs_float (r_ad -. r_fd) /. (rms +. 1E-9) ) |> (Array.fold_left max (-1.)) in
    max_err, max_err < th

  let test_func f  = 
    let f x = Maths.(sum' (f x)) in
    Array.map (fun x ->
        let max_err, check = 
          Array.map (fun d -> 
              let r_ad = Maths.(sum' ( (g ~f x) * d )) |> unpack_flt in
              let r_fd = (fd_g ~f x d)  |> unpack_flt in
              r_ad, r_fd
            ) ds 
          |> check_grads in
        check
      ) xs 
    |> (Array.fold_left (fun (a, c) b -> a && b, (if b then (succ c) else c) ) (true, 0) )


  module To_test = struct

    let sin   () = test_func Maths.sin
    let cos   () = test_func Maths.cos
    let tan   () = test_func Maths.tan
    let sinh  () = test_func Maths.sinh
    let cosh  () = test_func Maths.cosh
    let exp   () = test_func Maths.exp
    let tanh  () = test_func Maths.tanh
    let diag  () = test_func Maths.diag
    let trace () = test_func Maths.trace
    let tril  () = test_func Maths.tril
    let triu  () = test_func Maths.triu
    let inv   () = test_func Maths.inv
    let qr  () = 
      let f x =
        match (Maths.qr x) with
          | Pair (q, r) -> Maths.(q + r)
          | _ -> assert false  in
        test_func f

    let lyapunov () = 
      let q = Arr Owl.Mat.(neg (eye n)) in
      let f x = Maths.lyapunov x q in
      test_func f 

  end

  let alco_fun s f = 
    let check, c = f () in
    Alcotest.(check bool) (sprintf "%s: %i/%i passed" s c n_xs) true check

  let sin  () = alco_fun "sin" To_test.sin

  let cos  () = alco_fun "cos" To_test.cos

  let tan  () = alco_fun "tan" To_test.tan

  let sinh  () = alco_fun "sinh" To_test.sinh

  let cosh  () = alco_fun "cosh" To_test.cosh

  let tanh  () = alco_fun "tanh" To_test.tanh

  let exp () = alco_fun "exp" To_test.exp

  let diag () = alco_fun "diag" To_test.diag

  let trace () = alco_fun "trace" To_test.trace

  let tril () = alco_fun "tril" To_test.tril

  let triu () = alco_fun "triu" To_test.triu

  let inv () = alco_fun "inv" To_test.inv

  let qr () = alco_fun "qr" To_test.qr


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
    "qr",  `Slow,   qr;
  ]

end
