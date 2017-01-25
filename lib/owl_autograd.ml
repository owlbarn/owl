(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type node = {
  value : float;
  func : float -> float;
  vjp : float -> float;
  parent : node list;
}

type scalar = Float of float | Node of node

module Owl_math_wrapper = struct

  let wrap_fun f g arg =
    let v, p = match arg with
    | Float v -> v, []
    | Node p -> p.value, [p]
    in
    let x = {
      value = f v;
      func = f;
      vjp = g;
      parent = p;
    }
    in
    Node x

  let sin x = wrap_fun sin cos x

  let log x = wrap_fun log (fun x -> 1. /. x) x

end
