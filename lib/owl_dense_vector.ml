(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

module M = Owl_dense_matrix

type vec_typ = Row | Col

(* save some efforts, just include it *)
include M


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


(* vector properties and manipulations *)

let is_row_vec x = M.row_num x = 1

let is_col_vec x = M.col_num x = 1

let get x i =
  match is_row_vec x with
  | true  -> x.{0,i}
  | false -> x.{i,0}

let set x i a =
  match is_row_vec x with
  | true  -> x.{0,i} <- a
  | false -> x.{i,0} <- a


(* vector iteration operations *)

let iteri f x =
  match is_row_vec x with
  | true  -> M.iteri (fun _ i a -> f i a) x
  | false -> M.iteri (fun i _ a -> f i a) x

let mapi f x =
  match is_row_vec x with
  | true  -> M.mapi (fun _ i a -> f i a) x
  | false -> M.mapi (fun i _ a -> f i a) x

let filteri f x =
  match is_row_vec x with
  | true  -> M.filteri (fun _ i a -> f i a) x
  | false -> M.filteri (fun i _ a -> f i a) x

let foldi f a x =
  match is_row_vec x with
  | true  -> M.foldi (fun _ i c b -> f i c b) a x
  | false -> M.foldi (fun i _ c b -> f i c b) a x


(* ends here *)
