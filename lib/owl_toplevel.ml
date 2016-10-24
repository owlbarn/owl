(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Install Toplevel Printers *)

type t =
  | Lident of string
  | Ldot of t * string
  | Lapply of t * t

let printers = [
  Obj.magic (Ldot (Lident "Owl_dense_real", "pp_dsmat"));
  Obj.magic (Ldot (Lident "Owl_dense_complex", "pp_dsmat"));
  Obj.magic (Ldot (Lident "Owl_sparse", "pp_spmat"));
]

let () =
  List.iter (fun p ->
    Topdirs.dir_install_printer Format.std_formatter p
  ) printers
