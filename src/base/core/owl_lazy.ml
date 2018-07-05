(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types


(* Functor of making a Lazy engine, just an alias of CPU engine. *)

module Make (A : Ndarray_Mutable) = struct

  include Owl_computation_cpu_engine.Make (A)

end

(* Make functor ends *)
