(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(*
type tunner =
  | Sin of Owl_aeos_tuner_sin.t
  | Cos of Owl_aeos_tuner_cos.t
*)

(* module Sin : sig

  type t = {
    mutable c_macro : string;
    mutable params  : int;
    mutable x       : int array;
  }

  val make : unit -> t

  val tune : t -> unit

  val to_string : t -> string

end *)

(*
type tuner =
  | Sin of Sin.t
*)

(* open Owl_aeos_types *)
open Owl_aeos_tuner_map
open Owl_aeos_tuner_fold

type tuner =
  | Sin of Sin.t
  | Cos of Cos.t
  | Add of Add.t
  | Sum of Sum.t
