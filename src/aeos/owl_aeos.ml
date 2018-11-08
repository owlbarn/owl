(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** AEOS: Automatic Empirical Optimisation of Software *)

let fname = "OWLROOT/src/owl/core/owl_aeos_paramter.h" (* is this the correct place ? *)

(* tune_all *)
let tune_all fname =
  let tuners = Owl_aeos_tuners.all in
  Owl_aeos_engine.eval tuners;
  Owl_aeos_writer.c_header_file fname tuners

(*
let tune ts =
  Owl_aeos_engine.eval ts;
  Owl_aeos_writer.write_partial fname tuners


let set_default = ()

*)

(* how to only tune part of the paramter:
 start_tuning [|Sin; Cos|]; and cover only THRD_SIN and THRD_COS *)

(* put all existing tunable threasholds in this module *)

(* do we really need omp for fold_plus and fold_mul? (FUN5) *)

(* add support for swap operations *)

(*map : 4, 12, 14, 15, 17, 19, 20, 29 -- not need to cover all. Currently should be fine. *)
