(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

module S = Pervasives


(* Functor of making Lazy module of different number types *)

module Make
  (A : InpureSig)
  = struct

  (* type definitions *)

  type state = Valid | Invalid

  type value =
    | Var
    | Elt of A.elt
    | Arr of A.arr

  type node = {
    mutable op    : op;
    mutable prev  : node array;
    mutable next  : node array;
    mutable state : state;
    mutable value : value array;
  }
  and op =
    | Noop
    | Fun00 of (A.arr -> A.arr)
    | Fun01 of (A.arr -> unit)
    | Fun02 of (A.arr -> A.arr -> unit) * (A.arr -> A.arr -> A.arr)
    | Fun03 of (A.arr -> A.elt -> unit)
    | Fun04 of (A.elt -> A.arr -> unit)
    | Fun05 of (A.arr array -> A.arr)
    | Fun06 of (A.arr -> A.arr array)
    | ItemI of int (* select the ith item in an array *)


  let node ?(prev=[||]) ?(next=[||]) ?(state=Invalid) ?(value=[||]) op = {
    op;
    prev;
    next;
    state;
    value;
  }


  let connect x y = ()

end
