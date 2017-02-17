(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module M = Owl_dense_real

type mat = Owl_dense_real.mat

type t =
  | Float of float
  | Matrix of mat
  | D of dual
  | A of adjoint
and dual = {
  p : t;       (* primal value *)
  t : t;       (* tangent value *)
}
and adjoint = {
  p : t;       (* primal value *)
  a : t;       (* adjoint value *)
}
and trace_op =
  | Add of t * t
  | Sub of t * t
  | Mul of t * t
  | Div of t * t
  | Sin of t
  | Cos of t


let make_dual p t = D { p; t }


module Maths = struct

  let rec _add a b = match a, b with
    | Float a, Float b -> Float Pervasives.(a +. b)
    | Float a, D b -> make_dual (_add (Float a) b.p) b.t
    | D a, Float b -> make_dual (_add a.p (Float b)) a.t
    | D a, D b -> make_dual (_add a.p b.p) (_add a.t b.t)
    | Matrix a, Matrix b -> Matrix M.(a +@ b)
    | Matrix a, Float b -> Matrix M.(a +$ b)
    | Float a, Matrix b -> Matrix M.(a $+ b)
    | Matrix a, D b -> make_dual (_add (Matrix a) b.p) b.t
    | D a, Matrix b -> make_dual (_add a.p (Matrix b)) a.t

  and _sub a b = match a, b with
    | Float a, Float b -> Float Pervasives.(a -. b)
    | Float a, D b -> make_dual (_sub (Float a) b.p) (_sub (Float 0.) b.t)
    | D a, Float b -> make_dual (_sub a.p (Float b)) a.t
    | D a, D b -> make_dual (_sub a.p b.p) (_sub a.t b.t)
    | Matrix a, Matrix b -> Matrix M.(a -@ b)
    | Matrix a, Float b -> Matrix M.(a -$ b)
    | Float a, Matrix b -> Matrix M.(a $- b)
    | Matrix a, D b -> make_dual (_sub (Matrix a) b.p) b.t
    | D a, Matrix b -> make_dual (_sub a.p (Matrix b)) a.t


end

module Add_ = struct
  let f a b = a +. b
  let df_da cp ap at = at
  let df_db cp bp bt = bt
  let df_dab cp ap at bp bt = at +. bt
end
