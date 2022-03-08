(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(** Linear algebra: module aliases *)

module Generic = struct
  include Owl_linalg_generic
end

module S = struct
  include Owl_linalg_s
end

module D = struct
  include Owl_linalg_d
end

module C = struct
  include Owl_linalg_c
end

module Z = struct
  include Owl_linalg_z
end

(* ends here *)
