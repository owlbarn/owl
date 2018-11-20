(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


let () =
  let fname = "owl_aeos_params_generated.h" in
  let enable_openmp = Sys.getenv "ENABLE_OPENMP" in
  if enable_openmp = "0" then Owl_aeos.tune_default fname
  else Owl_aeos.tune_all fname
