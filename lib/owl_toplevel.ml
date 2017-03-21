(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Install Toplevel Printers *)

type t =
  | Lident of string
  | Ldot of t * string
  | Lapply of t * t

let printers = [
  Obj.magic (Ldot (Lident "Owl_dense_ndarray", "pp_dsnda"));
  Obj.magic (Ldot (Lident "Owl_dense_matrix_generic", "pp_dsmat"));
  Obj.magic (Ldot (Lident "Owl_sparse_ndarray", "pp_spnda"));
  Obj.magic (Ldot (Lident "Owl_sparse_matrix", "pp_spmat"));
  Obj.magic (Ldot (Lident "Owl_sparse_real", "pp_spmat"));
  Obj.magic (Ldot (Lident "Owl_sparse_complex", "pp_spmat"));
]

let () =
  List.iter (fun p ->
    Topdirs.dir_install_printer Format.std_formatter p
  ) printers
