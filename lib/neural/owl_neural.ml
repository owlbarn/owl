(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_algodiff_ad
type t = Owl_algodiff_ad.t

type init_typ =
  | Init_Uniform of float * float
  | Init_Gaussian of float * float
  | Init_Custom of (int -> int -> float)

let initialise t m n = match t with
  | Init_Uniform (a, b) -> Mat.uniform m n
  | Init_Gaussian (a, b) -> Mat.uniform m n
  | Init_Custom f -> Mat.uniform m n

type activation =
  | Sigmoid
  | Tanh
  | Custom_Act of (t -> t)

type layer =
  | Linear of linear
  | Recurrent of recurrent
  | LTSM of ltsm
  | Activate of activation
and linear = {
  mutable w : t;
  mutable b : t;
  mutable init : init_typ;
  mutable reset : linear -> unit;
  mutable run : t -> linear -> t;
}
and recurrent = {
  mutable whh : t;
  mutable run : t -> recurrent -> t;
}
and ltsm = {
  mutable wxi : t;
}

type network = {
  mutable layers : layer list;
  mutable init : unit -> unit;
  mutable reset : unit -> unit;
  mutable run : unit -> unit;
}

let linear ~input ~output ~init =
  let reset l = Mat.(reset l.w; reset l.b) in
  let run x l = Maths.(x * l.w + l.b) in
  let l = {
    w = initialise init input output;
    b = Mat.zeros 1 output;
    init = init;
    reset = reset;
    run = run;
  }
  in Linear l
