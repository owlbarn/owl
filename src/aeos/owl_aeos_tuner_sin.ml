(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


type t = {
  mutable c_macro : string;
  mutable measure : float array;
  mutable params  : int;
}


let make () = {
  c_macro = "OWL_OMP_THRESHOLD_SIN"; (* [| OWL_OMP_THRESHOLD_SIN |] *)
  measure = [||];
  params  = max_int;
}


let tune t =
  Owl_log.info "AEOS: tune sin ...";
  (* Call C stub function to do measurement, then regression *)

  (*
   * 1. choose two different functions: current impl; non-omp version (impl the latter in stub.c file?)
   * 2. eval them at specified sizes: val1 = [|...|]; val2 = [|.....|]
   * 3. Lialg.intersect (val1, val2)
  *)


let to_string t = string_of_int t.params
