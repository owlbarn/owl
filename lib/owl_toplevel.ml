(** [ Install Toplevel Printers ]  *)

module Longident = struct
	type t =
		| Lident of string
		| Ldot of t * string
		| Lapply of t * t
end

let printers = [
  Obj.magic Longident.(Ldot (Lident "Dense", "pp_dsmat"));
  Obj.magic Longident.(Ldot (Lident "Sparse", "pp_spmat"));
]

let () =
  List.iter (fun p ->
    Topdirs.dir_install_printer Format.std_formatter p
  ) printers
