(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(** AEOS: Automatic Empirical Optimisation of Software *)


let tune_default fname =
  Owl_aeos_log.info "Using default parameters...\n";
  let tuners = Owl_aeos_tuners.all in
  Owl_aeos_writer.write_full fname tuners


let tune_all fname =
  Owl_aeos_log.info "Start tuning parameters...\n";
  let tuners = Owl_aeos_tuners.all in
  Owl_aeos_engine.eval tuners;
  Owl_aeos_writer.write_full fname tuners


let tune fname tuners =
  Owl_aeos_engine.eval tuners;
  Owl_aeos_writer.write_partial fname tuners

(* put all existing tunable threasholds in this module *)

(* add support for swap operations *)

(*map : 4, 12, 14, 15, 17, 19, 20, 29 -- not need to cover all. Currently should be fine. *)
