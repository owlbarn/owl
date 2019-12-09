(** Unit test for Algodiff module *)

open Owl_types

(* functor to generate test unit. *)

module Make (M : Ndarray_Algodiff with type elt = float) = struct
  module M = Owl.Mat
  module AlgoM = Owl.Algodiff.D
  open AlgoM

  let n = 3

  let n_samples = 20

  let threshold = 1E-6

  let eps = 1E-5

  module FD = Owl_algodiff_check.Make (AlgoM)

  module Make_tests (P : sig
    val label : string

    val test_func : (t -> t) -> bool * int
  end) =
  struct
    open P

    let neg () = test_func Maths.neg

    let abs () = test_func Maths.abs

    let signum () = test_func Maths.signum

    let floor () = test_func Maths.floor

    let ceil () = test_func Maths.ceil

    let round () = test_func Maths.round

    let sqr () = test_func Maths.sqr

    let sqrt () = test_func (fun x -> Maths.(sqrt (x * x)))

    let log () = test_func (fun x -> Maths.(log (F 1. + (x * x))))

    let pow () = test_func (fun x -> Maths.(log (F 1. + pow (sqr x) (F 2.9 + x))))

    let sin () = test_func Maths.sin

    let cos () = test_func Maths.cos

    let tan () =
      let f x = Maths.(tan x * cos x * cos x) in
      test_func f


    let sinh () = test_func Maths.sinh

    let cosh () = test_func Maths.cosh

    let exp () = test_func Maths.exp

    let tanh () = test_func Maths.tanh

    let sigmoid () = test_func Maths.sigmoid

    let relu () = test_func Maths.relu

    let transpose () = test_func Maths.transpose

    let diag () = test_func Maths.diag

    let diagm () =
      let f x = Maths.(diagm (get_row x 0)) in
      test_func f


    let trace () = test_func Maths.trace

    let l1norm' () = test_func Maths.l1norm'

    let l2norm' () = test_func Maths.l2norm'

    let l2norm_sqr' () = test_func Maths.l2norm_sqr'

    let tril () = test_func Maths.tril

    let triu () = test_func Maths.triu

    let inv () =
      let e = Arr (Owl.Mat.eye n) in
      let f x =
        let x = Maths.(transpose x *@ x) in
        Maths.(inv (x + e))
      in
      test_func f


    let logdet () =
      let e = Arr (Owl.Mat.eye n) in
      let f x =
        let x = Maths.(transpose x *@ x) in
        Linalg.logdet Maths.(x + e)
      in
      test_func f


    let qr () =
      let f x =
        let q, r = Linalg.qr x in
        Maths.(q + r)
      in
      test_func f


    let lq () =
      let f x =
        let l, q = Linalg.lq x in
        Maths.(l + q)
      in
      test_func f


    let svd () =
      let f =
        let y = Mat.gaussian 20 n in
        fun x ->
          let x = Maths.(y *@ x) in
          let u, s, vt = Linalg.svd x in
          Maths.(u + (sum' s * l2norm_sqr' vt))
      in
      test_func f


    let chol () =
      let f x =
        let identity = Arr (Owl.Mat.eye n) in
        let s = Maths.(transpose x *@ x) in
        let s = Maths.(s + (F 0.001 * identity)) in
        Maths.(inv (Linalg.chol ~upper:false s))
      in
      test_func f


    let split () =
      let f x =
        let a = Maths.split ~axis:0 [| 1; 1; 1 |] x in
        Maths.(a.(0) + (a.(1) * a.(2)))
      in
      test_func f


    let concat () =
      let y = Mat.gaussian n (2 * n) in
      let z = Mat.gaussian n n in
      let f x =
        let z = Maths.concat ~axis:0 Maths.(x + z) x in
        Maths.(y *@ z)
      in
      test_func f


    let concatenate () =
      let f =
        let y1 = Mat.gaussian 10 n in
        let y2 = Mat.gaussian 15 n in
        let h x = Maths.(y1 *@ x) in
        let h' = grad h in
        fun x ->
          let y = Maths.concatenate ~axis:0 [| y1; x; y2; h' x |] in
          Maths.(y *@ x)
      in
      test_func f


    let of_arrays () =
      let f x =
        let y =
          Array.init n (fun i ->
              Array.init n (fun j ->
                  if i = 0 then Maths.get_item x j i else Maths.get_item x i j))
          |> Maths.of_arrays
        in
        Maths.(x * sin (y + x))
      in
      test_func f


    let to_arrays () =
      let f x =
        let a = Maths.to_arrays x in
        Maths.(a.(0).(1) * cos a.(1).(0))
      in
      test_func f


    let init_2d () =
      let f x =
        let y =
          Mat.init_2d n n (fun i j -> if i = 0 then F 3. else Maths.get_item x i j)
        in
        Maths.(y *@ x)
      in
      test_func f


    let sylvester () =
      let r1 = Mat.gaussian n n in
      let r2 = Mat.gaussian n n in
      let f x =
        let a = Maths.(x + r1) in
        let b = Maths.(x + r2) in
        let c = Maths.((a *@ x) + (x *@ b)) in
        Linalg.sylvester a b c
      in
      test_func f


    let lyapunov () =
      let r = Mat.gaussian n n in
      let identity = Arr Owl.Mat.(eye n) in
      let f x =
        let q = Maths.(F 0.5 * (x + transpose x + identity)) in
        let s = Maths.(r - transpose r) in
        let p = Maths.(((r + x) *@ transpose (r + x)) + identity) in
        let a = Maths.((s - (F 0.5 * q)) *@ inv p) in
        Linalg.lyapunov a Maths.(neg q)
      in
      test_func f


    let discrete_lyapunov () =
      let r = Mat.gaussian n n in
      let identity = Arr Owl.Mat.(eye n) in
      let f x =
        let q = Maths.(F 0.5 * ((x *@ transpose x) + identity)) in
        let s = Maths.(x - transpose x) in
        let p = Maths.(((r + x) *@ transpose (r + x)) + identity) in
        let a = Maths.(((s - (F 0.5 * q)) *@ inv p) - identity) in
        Linalg.discrete_lyapunov a q
      in
      test_func f


    let linsolve () =
      let x = Mat.gaussian n n in
      let f a =
        let b = Maths.(a *@ x) in
        let x = Linalg.(linsolve a b) in
        let at = Linalg.(linsolve ~trans:true x (Maths.transpose b)) in
        Maths.(a + at + x)
      in
      test_func f


    let linsolve_triangular () =
      let x = Mat.gaussian n n in
      let f a =
        let a_l = Maths.tril a in
        let p_l = Maths.(a_l *@ transpose a_l) in
        let a_u = Maths.triu a in
        let p_u = Maths.(transpose a_u *@ a_u) in
        let b_l = Maths.(p_l *@ x) in
        let b_u = Maths.(p_u *@ x) in
        let x_l =
          Linalg.linsolve ~typ:`l a_l b_l |> Linalg.(linsolve ~typ:`l ~trans:true a_l)
        in
        let x_u =
          Linalg.(linsolve ~typ:`u ~trans:true a_u b_u) |> Linalg.(linsolve ~typ:`u a_u)
        in
        let atl = Linalg.(linsolve ~trans:true x_l (Maths.transpose b_l)) in
        let atu = Linalg.(linsolve ~trans:true x_u (Maths.transpose b_u)) in
        Maths.(atl *@ atu)
      in
      test_func f


    let care () =
      let b = Mat.gaussian n n in
      let q = Mat.gaussian n n in
      let f x =
        let a = x in
        let b = Maths.(tril x + b) in
        let r =
          let e = Mat.eye n in
          let r = Maths.(e + (a *@ transpose a)) in
          Maths.(r *@ transpose r)
        in
        let q =
          let q = Maths.(q + a) in
          Maths.((q *@ transpose q) + Mat.(eye n))
        in
        let c1 = Linalg.care a b q r in
        let c2 = Linalg.care ~diag_r:true a b q Maths.(diagm (diag r)) in
        Maths.(c1 + c2)
      in
      test_func f


    let test =
      [ "neg", neg; "abs", abs; "signum", signum; "floor", floor; "ceil", ceil
      ; "round", round; "sqr", sqr; "sqrt", sqrt; "log", log; "pow", pow; "sin", sin
      ; "cos", cos; "tan", tan; "sinh", sinh; "cosh", cosh; "tanh", tanh
      ; "sigmoid", sigmoid; "relu", relu; "exp", exp; "transpose", transpose; "diag", diag
      ; "diagm", diagm; "trace", trace; "l1norm'", l1norm'; "l2norm'", l2norm'
      ; "l2norm_sqr'", l2norm_sqr'; "tril", tril; "triu", triu; "inv", inv
      ; "logdet", logdet; "chol", chol; "qr", qr; "lq", lq; "split", split
      ; "concat", concat; "concatenate", concatenate; "svd", svd; "of_arrays", of_arrays
      ; "to_arrays", to_arrays; "init_2d", init_2d; "sylvester", sylvester
      ; "lyapunov", lyapunov; "discrete_lyapunov", discrete_lyapunov; "linsolve", linsolve
      ; "linsolve_triangular", linsolve_triangular; "care", care ]
      |> List.fold_left
           (fun (b, error_msg) (s, f) ->
             let b', c =
               match f () with
               | x -> x
               | exception Owl_exception.NOT_IMPLEMENTED _ -> true, n
             in
             if b'
             then b && b', error_msg
             else (
               let msg =
                 Printf.sprintf
                   "%s\n       %s (%i/%i)"
                   error_msg
                   s
                   (n_samples - c)
                   n_samples
               in
               false, msg))
           (true, Printf.sprintf "\nfailed %s operations" label)
      |> fun (b, error_msg) ->
      label, `Slow, fun () -> if b then () else failwith error_msg
  end

  let samples, directions = FD.generate_test_samples (n, n) n_samples

  module Reverse = Make_tests (struct
    let label = "reverse mode"

    let test_func f =
      FD.Reverse.check ~threshold ~order:`fourth ~eps ~directions ~f samples
  end)

  module Forward = Make_tests (struct
    let label = "forward mode"

    let test_func f = FD.Forward.check ~threshold ~directions ~f samples
  end)
end
