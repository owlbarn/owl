(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

let () =
  let fname = "owl_aeos_params_generated.h" in
  let bgetenv v =
    let v' =
      try Sys.getenv v |> int_of_string with
      | Not_found -> 0
    in
    if v' < 0 || v' > 1
    then
      raise
      @@ Invalid_argument
           (Printf.sprintf "Invalid value for env variable %s: got %d" v v');
    v' = 1
  in
  let enable_openmp = bgetenv "OWL_ENABLE_OPENMP" in
  if not (Sys.file_exists fname && (Unix.stat fname).st_size > 0)
  then
    if enable_openmp then Owl_aeos.tune_all fname else Owl_aeos_utils.write_file fname ""
