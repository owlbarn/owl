(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


type t = {
  mutable c_macro : string;
  mutable measure : float array;
  mutable params  : int;
}


let make () = {
  c_macro = "OWL_OMP_THRESHOLD_COS";
  measure = [||];
  params  = max_int;
}


let tune t =
  Owl_log.info "AEOS: tuning cos ..."
  (* Call C stub function to do measurement, then regression *)


let to_string t = string_of_int t.params
