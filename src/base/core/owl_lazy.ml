(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

open Owl_types

(* Functor of making a Lazy engine, just an alias of CPU engine. *)

module Make (A : Ndarray_Mutable) = struct
  include Owl_computation_cpu_engine.Make (A)
end

(* Make functor ends *)
