(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

module S = Pervasives
module M = Owl_dense_real

type mat = Owl_dense_real.mat

type t =
  | Float of float
  | Matrix of mat
  | DF of dual
  | DR of adjoint
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


let make_dual p t = DF { p; t }

let dual = function
  | Float a -> Float 0.
  | Matrix a -> Float 0.
  | DF a -> a.t

let rec zero = function
  | Float _ -> Float 0.
  | Matrix _ -> Float 0.
  | DF a -> make_dual (zero a.p) (zero a.t)

let rec one = function
  | Float _ -> Float 1.
  | Matrix _ -> failwith "Error: one does not take matrix."
  | DF a -> make_dual (one a.p) (zero a.t)


module Maths = struct

  let rec noop _ = ()

  and op_d_d a ff fd df =
    match a with
    | DF a -> let cp = fd a.p in make_dual cp (df cp a.p a.t)
    | DR a -> failwith "error: not implemented."
    | ap   -> ff ap

  and op_d_d_d a b ff fd df_da df_db df_dab =
    match a, b with
    | Float ap, DF b  -> let cp = fd a b.p in make_dual cp (df_db cp b.p b.t)
    | DF a, Float bp  -> let cp = fd a.p b in make_dual cp (df_da cp a.p a.t)
    | Matrix ap, DF b -> let cp = fd a b.p in make_dual cp (df_db cp b.p b.t)
    | DF a, Matrix bp -> let cp = fd a.p b in make_dual cp (df_da cp a.p a.t)
    | DF a, DF b      -> let cp = fd a.p b.p in make_dual cp (df_dab cp a.p a.t b.p b.t)
    | a, b            -> ff a b

  and ( +. ) a b = add a b
  and add a b =
    let ff a b =
      match a, b with
      | Float a, Float b   -> Float S.(a +. b)
      | Float a, Matrix b  -> Matrix M.(a $+ b)
      | Matrix a, Float b  -> Matrix M.(a +$ b)
      | Matrix a, Matrix b -> Matrix M.(a +@ b)
    in
    let fd a b = a +. b
    in
    let df_da cp ap at = at
    in
    let df_db cp bp bt = bt
    in
    let df_dab cp ap at bp bt = at +. bt
    in
    op_d_d_d a b ff fd df_da df_db df_dab

  and ( -. ) a b = sub a b
  and sub a b =
    let ff a b =
      match a, b with
      | Float a, Float b   -> Float S.(a -. b)
      | Float a, Matrix b  -> Matrix M.(a $- b)
      | Matrix a, Float b  -> Matrix M.(a -$ b)
      | Matrix a, Matrix b -> Matrix M.(a -@ b)
    in
    let fd a b = a -. b
    in
    let df_da cp ap at = at
    in
    let df_db cp bp bt = Float 0. -. bt
    in
    let df_dab cp ap at bp bt = at -. bt
    in
    op_d_d_d a b ff fd df_da df_db df_dab

  and ( *. ) a b = mul a b
  and mul a b =
    let ff a b =
      match a, b with
      | Float a, Float b   -> Float S.(a *. b)
      | Float a, Matrix b  -> Matrix M.(a $* b)
      | Matrix a, Float b  -> Matrix M.(a *$ b)
      | Matrix a, Matrix b -> Matrix M.(a *@ b)
    in
    let fd a b = a *. b
    in
    let df_da cp ap at = at *. b
    in
    let df_db cp bp bt = a *. bt
    in
    let df_dab cp ap at bp bt = (ap *. bt) +. (at *. bp)
    in
    op_d_d_d a b ff fd df_da df_db df_dab

  and ( /. ) a b = div a b
  and div a b =
    let ff a b =
      match a, b with
      | Float a, Float b   -> Float S.(a /. b)
      | Float a, Matrix b  -> Matrix M.(a $/ b)
      | Matrix a, Float b  -> Matrix M.(a /$ b)
      | Matrix a, Matrix b -> Matrix M.(a /@ b)
    in
    let fd a b = a /. b
    in
    let df_da cp ap at = at /. b
    in
    let df_db cp bp bt = (Float 0.) -. (bt *. cp /. bp)
    in
    let df_dab cp ap at bp bt = (at -. bt *. cp) /. bp
    in
    op_d_d_d a b ff fd df_da df_db df_dab

(*
  and add a b = match a, b with
    | Float a, Float b -> Float Pervasives.(a +. b)
    | Float a, DF b -> make_dual (add (Float a) b.p) b.t
    | DF a, Float b -> make_dual (add a.p (Float b)) a.t
    | DF a, DF b -> make_dual (add a.p b.p) (add a.t b.t)
    | Matrix a, Matrix b -> Matrix M.(a +@ b)
    | Matrix a, Float b -> Matrix M.(a +$ b)
    | Float a, Matrix b -> Matrix M.(a $+ b)
    | Matrix a, DF b -> make_dual (add (Matrix a) b.p) b.t
    | DF a, Matrix b -> make_dual (add a.p (Matrix b)) a.t

  and ( +. ) a b = add a b

  and add' cp ap at bp bt = at +. bt

  and add'_da cp ap at = at

  and add'_db cp bp bt = bt

  and sub a b = match a, b with
    | Float a, Float b -> Float Pervasives.(a -. b)
    | Float a, DF b -> make_dual (sub (Float a) b.p) (sub (Float 0.) b.t)
    | DF a, Float b -> make_dual (sub a.p (Float b)) a.t
    | DF a, DF b -> make_dual (sub a.p b.p) (sub a.t b.t)
    | Matrix a, Matrix b -> Matrix M.(a -@ b)
    | Matrix a, Float b -> Matrix M.(a -$ b)
    | Float a, Matrix b -> Matrix M.(a $- b)
    | Matrix a, DF b -> make_dual (sub (Matrix a) b.p) b.t
    | DF a, Matrix b -> make_dual (sub a.p (Matrix b)) a.t

  and ( -. ) a b = sub a b

  and sub' cp ap at bp bt = at -. bt

  and sub'_da cp ap at = at

  and sub'_db cp bp bt = Float 0. -. bt

  and mul a b = match a, b with
    | Float a, Float b -> Float Pervasives.(a *. b)
    | Float a, DF b -> make_dual (mul (Float a) b.p) (mul (Float a) b.t)
    | DF a, Float b -> make_dual (mul a.p (Float b)) (mul a.t (Float b))
    | DF a, DF b -> make_dual (mul a.p b.p) (add (mul a.p b.t) (mul a.t b.p))
    | Matrix a, Matrix b -> Matrix M.(a *@ b)
    | Matrix a, Float b -> Matrix M.(a *$ b)
    | Float a, Matrix b -> Matrix M.(a $* b)
    | Matrix a, DF b -> make_dual (mul (Matrix a) b.p) (mul (Matrix a) b.t)
    | DF a, Matrix b -> make_dual (mul a.p (Matrix b)) (mul a.t (Matrix b))

  and ( *. ) a b = mul a b

  and mul' cp ap at bp bt = (ap *. bt) +. (at *. bp)

  and mul'_da cp ap at b = at *. b

  and mul'_db cp bp bt a = a *. bt

  and div a b = match a, b with
    | Float a, Float b -> Float Pervasives.(a /. b)
    | Float a, DF b -> let y = div (Float a) b.p in make_dual y (mul (Float (-1.)) (mul (div y b.p) b.t))
    | DF a, Float b -> make_dual (div a.p (Float b)) (div a.t (Float b))
    | DF a, DF b -> make_dual (div a.p b.p) (sub (div a.t b.p) (div (mul a.p b.t) (mul b.p b.p)))
    | Matrix a, Matrix b -> Matrix M.(a /@ b)
    | Matrix a, Float b -> Matrix M.(a /$ b)
    | Float a, Matrix b -> Matrix M.(a $/ b)
    | Matrix a, DF b -> let y = div (Matrix a) b.p in make_dual y (mul (Float (-1.)) (mul (div y b.p) b.t))
    | DF a, Matrix b -> make_dual (div a.p (Matrix b)) (div a.t (Matrix b))

  and ( /. ) a b = div a b

  and div' cp ap at bp bt = (at -. bt *. cp) /. bp

  and div'_da cp ap at b = at /. b

  and div'_db cp bp bt a = Float 0. -. (bt *. cp /. bp)
*)

  and signum a =
    let ff = function
      | Float a -> Float Owl_maths.(signum a)
      | Matrix a -> Matrix M.(signum a)
    in
    let fd a = signum a
    in
    let df cp ap at = zero ap
    in
    op_d_d a ff fd df

  and sin a =
    let ff = function
      | Float a -> Float S.(sin a)
      | Matrix a -> Matrix M.(sin a)
    in
    let fd a = sin a
    in
    let df cp ap at = at *. cos ap
    in
    op_d_d a ff fd df

  and cos a =
    let ff = function
      | Float a -> Float S.(cos a)
      | Matrix a -> Matrix M.(cos a)
    in
    let fd a = cos a
    in
    let df cp ap at = Float 0. -. (at *. sin ap)
    in
    op_d_d a ff fd df

(*
  and sin = function
    | Float a -> Float Pervasives.(sin a)
    | Matrix a -> Matrix M.(sin a)
    | DF a -> make_dual (sin a.p) ((sin' a.p a.p) *. a.t)

  and sin' cp ap at = at *. cos ap

  and cos = function
    | Float a -> Float Pervasives.(cos a)
    | Matrix a -> Matrix M.(cos a)
    | DF a -> make_dual (cos a.p) ((cos' a.p) *. a.t)

  and cos' cp ap at = Float 0. -. (at *. sin ap)
*)

end

let diff f = fun x ->
  let x = make_dual x (one x) in
  f x |> dual
