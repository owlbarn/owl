(** [ Install Toplevel Printers ]  *)

type t =
	| Lident of string
	| Ldot of t * string
	| Lapply of t * t

let printers = [
  Obj.magic (Ldot (Lident "Dense",  "pp_dsmat"));
  Obj.magic (Ldot (Lident "Sparse", "pp_spmat"));
]

let () =
  List.iter (fun p ->
    Topdirs.dir_install_printer Format.std_formatter p
  ) printers
