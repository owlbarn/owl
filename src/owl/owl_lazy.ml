(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

module S = Pervasives


(* Functor of making Lazy module of different number types *)

module Make
  (M : MatrixSig)
  (A : NdarraySig with type elt = M.elt and type arr = M.mat)
  = struct

  (* type definitions *)

  type arr = A.arr
  type elt = M.elt

  type t = {
    mutable op     : op;
    mutable refnum : int;
    mutable outval : arr;
  }
  and op =
    | Add of t * t
    | Sin of t
    | Cos of t



  let eval t = ()


end
