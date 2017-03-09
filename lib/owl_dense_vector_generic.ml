(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

(* save some efforts, just include it *)
module M = Owl_dense_matrix
include M

type vec = (float, float64_elt) Owl_dense_matrix.t
type vec_typ = Row | Col


(* vector creation operations *)

let empty ?(typ=Row) k m = match typ with
  | Row -> M.empty k 1 m
  | Col -> M.empty k m 1

let zeros ?(typ=Row) k m = match typ with
  | Row -> M.zeros k 1 m
  | Col -> M.zeros k m 1

let ones ?(typ=Row) k m = match typ with
  | Row -> M.ones k 1 m
  | Col -> M.ones k m 1

let create ?(typ=Row) k m a = match typ with
  | Row -> M.create k 1 m a
  | Col -> M.create k m 1 a

let uniform ?(typ=Row) ?scale k m = match typ with
  | Row -> M.uniform ?scale k 1 m
  | Col -> M.uniform ?scale k m 1

let unit_basis ?(typ=Row) k m i = match typ with
  | Row -> let v = M.zeros k 1 m in v.{0,i} <- 1.; v
  | Col -> let v = M.zeros k m 1 in v.{i,0} <- 1.; v


(* vector properties and manipulations *)

let vec_typ x =
  if M.row_num x = 1 then Row
  else if M.col_num x = 1 then Col
  else failwith "vec_typ: not a vector"

let get x i =
  match vec_typ x with
  | Row -> x.{0,i}
  | Col -> x.{i,0}

let set x i a =
  match vec_typ x with
  | Row -> x.{0,i} <- a
  | Col -> x.{i,0} <- a


(* vector iteration operations *)

let iteri f x =
  match vec_typ x with
  | Row -> M.iteri (fun _ i a -> f i a) x
  | Col -> M.iteri (fun i _ a -> f i a) x

let mapi f x =
  match vec_typ x with
  | Row -> M.mapi (fun _ i a -> f i a) x
  | Col -> M.mapi (fun i _ a -> f i a) x

let filteri f x =
  match vec_typ x with
  | Row -> M.filteri (fun _ i a -> f i a) x
  | Col -> M.filteri (fun i _ a -> f i a) x

let foldi f a x =
  match vec_typ x with
  | Row -> M.foldi (fun _ i c b -> f i c b) a x
  | Col -> M.foldi (fun i _ c b -> f i c b) a x


(* ends here *)
