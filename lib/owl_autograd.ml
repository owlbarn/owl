(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type scalar = Float of float | Node of node
and node = {
  mutable v : float;
  mutable d : scalar;
}

let new_node v d = { v; d; }


module type MathsSig = sig
  val sin : scalar -> scalar
  val cos : scalar -> scalar
end

module type DerivativeSig = sig
  val sin' : int -> scalar -> float array -> scalar
  val cos' : int -> scalar -> float array -> scalar
end

module rec Maths : MathsSig = struct

  let wrap_fun f f' args =
    let dr_mode = ref false in
    let argsval = ref [||] in
    let dualval = ref [||] in
    Array.iter (fun arg ->
      match arg with
      | Node x -> (
        dr_mode := true;
        argsval := Array.append !argsval [|x.v|];
        dualval := Array.append !dualval [|x.d|];
        )
      | Float x -> argsval := Array.append !argsval [|x|]
    ) args;
    let v = f !argsval in
    match !dr_mode with
    | true -> (
      let r = ref 0. in
      Array.iteri (fun i d ->
        match (f' i d !argsval) with
        | Float a -> r := !r +. a
        | _ -> failwith "error: wrong output"
      ) !dualval;
      Node (new_node v (Float !r))
      )
    | false -> Float v

  let sin x = wrap_fun Owl_autograd_maths.sin Derivative.sin' [|x|]

  let cos x = wrap_fun Owl_autograd_maths.cos Derivative.cos' [|x|]

end and
Derivative : DerivativeSig = struct

  let sin' i g x = Maths.cos (Node(new_node x.(0) g))

  let cos' i g x = Maths.sin (Node(new_node x.(0) g))

end
