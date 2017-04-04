(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

(* save some efforts, just include it *)
module M = Owl_dense_matrix_generic
include M

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

let sequential ?(typ=Row) k m = match typ with
  | Row -> M.sequential k 1 m
  | Col -> M.sequential k m 1

let unit_basis ?(typ=Row) k m i =
  let a1 = Owl_types._one k in
  match typ with
  | Row -> let v = M.zeros k 1 m in v.{0,i} <- a1; v
  | Col -> let v = M.zeros k m 1 in v.{i,0} <- a1; v

let linspace ?(typ=Row) k a b n = match typ with
  | Row -> M.linspace k a b n
  | Col -> M.linspace k a b n |> M.reshape n 1

let logspace ?(typ=Row) ?base k a b n = match typ with
  | Row -> M.logspace k ?base a b n
  | Col -> M.logspace k ?base a b n |> M.reshape n 1

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


(* to/from other types *)

let of_array ?(typ=Row) k l = match typ with
  | Row -> M.of_array k l 1 (Array.length l)
  | Col -> M.of_array k l (Array.length l) 1


(* ends here *)
