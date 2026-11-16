(** Unit test for [keep_dims] in reductions over all elements (#621).

    Without [axis], a reduction keeps every dimension as 1 only when
    [~keep_dims:true] is passed explicitly; by default, and with
    [~keep_dims:false], it returns shape [[|1|]] as it always has. With an
    [axis], [keep_dims] still defaults to [true]. *)

module N = Owl.Dense.Ndarray.D
module B = Owl_base_dense_ndarray.D

let x = N.of_array [| 1.; -2.; 3.; 4.; 5.; -6. |] [| 2; 3 |]

let x3 = N.sequential ~a:1. [| 2; 3; 4 |]

type reduction = ?axis:int -> ?keep_dims:bool -> N.arr -> N.arr

let reductions : (string * reduction) list =
  [ "sum", N.sum; "prod", N.prod; "min", N.min; "max", N.max; "mean", N.mean
  ; "median", N.median; "var", N.var; "std", N.std; "sem", N.sem
  ; "l1norm", N.l1norm; "l2norm", N.l2norm; "l2norm_sqr", N.l2norm_sqr
  ; ("minmax (min)", fun ?axis ?keep_dims x -> fst (N.minmax ?axis ?keep_dims x))
  ; ("minmax (max)", fun ?axis ?keep_dims x -> snd (N.minmax ?axis ?keep_dims x))
  ; ("vecnorm p=1", fun ?axis ?keep_dims x -> N.vecnorm ?axis ~p:1. ?keep_dims x)
  ; ("vecnorm p=3", fun ?axis ?keep_dims x -> N.vecnorm ?axis ~p:3. ?keep_dims x)
  ; ("vecnorm p=inf", fun ?axis ?keep_dims x -> N.vecnorm ?axis ~p:infinity ?keep_dims x)
  ]


let value a = N.get a (Array.make (N.num_dims a) 0)

(* for every reduction and input: the shape for each [keep_dims] setting,
   and the same value in all three *)
let check_all f x =
  let d = f ?axis:None ?keep_dims:None x
  and t = f ?axis:None ?keep_dims:(Some true) x
  and n = f ?axis:None ?keep_dims:(Some false) x in
  N.shape d = [| 1 |]
  && N.shape n = [| 1 |]
  && N.shape t = Array.make (N.num_dims x) 1
  && value d = value t
  && value d = value n


(* with an axis nothing changes: kept by default, squeezed on request *)
let check_axis f x =
  let s = N.shape x in
  let kept = Array.copy s in
  kept.(1) <- 1;
  let squeezed = Array.of_list (List.filteri (fun i _ -> i <> 1) (Array.to_list s)) in
  N.shape (f ?axis:(Some 1) ?keep_dims:None x) = kept
  && N.shape (f ?axis:(Some 1) ?keep_dims:(Some true) x) = kept
  && N.shape (f ?axis:(Some 1) ?keep_dims:(Some false) x) = squeezed


let check name f () = Alcotest.(check bool) name true (f ())

let dense_tests =
  List.concat_map
    (fun (name, (f : reduction)) ->
      [ ( name ^ " all"
        , `Quick
        , check (name ^ " all") (fun () -> check_all f x && check_all f x3) )
      ; ( name ^ " axis"
        , `Quick
        , check (name ^ " axis") (fun () -> check_axis f x && check_axis f x3) ) ])
    reductions


(* the issue's example *)
let issue_621 () =
  let a = N.of_arrays [| [| 1.; 2.; 3. |]; [| 4.; 5.; 6. |] |] in
  let s = N.sum ~keep_dims:true a in
  N.shape s = [| 1; 1 |] && N.get s [| 0; 0 |] = 21.


(* the pure-OCaml implementation behaves the same way *)
let base () =
  let x = B.of_array [| 1.; -2.; 3.; 4.; 5.; -6. |] [| 2; 3 |] in
  List.for_all
    (fun (f : ?axis:int -> ?keep_dims:bool -> B.arr -> B.arr) ->
      B.shape (f x) = [| 1 |]
      && B.shape (f ~keep_dims:false x) = [| 1 |]
      && B.shape (f ~keep_dims:true x) = [| 1; 1 |]
      && B.get (f ~keep_dims:true x) [| 0; 0 |] = B.get (f x) [| 0 |]
      && B.shape (f ~axis:1 x) = [| 2; 1 |]
      && B.shape (f ~axis:1 ~keep_dims:false x) = [| 2 |])
    [ B.sum; B.min; B.max ]


(* [Maths.sum] passes [keep_dims] on unchanged, and its gradient is still a
   matrix of ones *)
let algodiff () =
  let open Owl.Algodiff.D in
  let a = Arr x in
  let shape v = Owl.Dense.Ndarray.D.shape (unpack_arr v) in
  let ones = Owl.Dense.Ndarray.D.ones [| 2; 3 |] in
  let grad_is_ones f = Owl.Dense.Ndarray.D.equal (unpack_arr (grad f a)) ones in
  shape (Maths.sum a) = [| 1 |]
  && shape (Maths.sum ~keep_dims:true a) = [| 1; 1 |]
  && shape (Maths.sum ~keep_dims:false a) = [| 1 |]
  && shape (Maths.sum ~axis:1 a) = [| 2; 1 |]
  && grad_is_ones (fun v -> Maths.(sum' (sum ~keep_dims:true v)))
  && grad_is_ones (fun v -> Maths.(sum' (sum v)))


let test_set =
  dense_tests
  @ [ "issue 621", `Quick, check "issue 621" issue_621
    ; "base", `Quick, check "base" base
    ; "algodiff", `Quick, check "algodiff" algodiff ]
