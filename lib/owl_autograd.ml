(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type scalar = Float of float | Node of node
and node = {
  mutable v : scalar;
  mutable d : scalar;
}

let new_node v d = { v; d; }

let unpack x =
  Array.map (fun y ->
    match y with
    | Float v -> v
    | Node x -> (
      match x.v with
      | Float v -> v
      | _ -> failwith "error"
      )
  ) x

module type MathsSig = sig
  val sin : scalar -> scalar
  val cos : scalar -> scalar
end

module type DerivativeSig = sig
  val sin' : int -> scalar -> scalar array -> scalar
  val cos' : int -> scalar -> scalar array -> scalar
end

module rec Maths : MathsSig = struct

  let wrap_fun f f' args =
    let dr_mode = ref false in
    let argslen = Array.length args in
    let argsval = Array.make argslen (Float 0.) in
    let dualval = Array.make argslen (Float 0.) in
    Array.iteri (fun i arg ->
      match arg with
      | Node x -> (
        dr_mode := true;
        argsval.(i) <- x.v;
        dualval.(i) <- x.d;
        )
      | x -> argsval.(i) <- x
    ) args;
    let v = f (argsval |> unpack) in
    match !dr_mode with
    | true -> (
      let argsval = Array.map (fun x ->
        match x with
        | Node x -> (
          match x.d with
          | Node y -> Node (new_node x.v y.d)
          | _ -> Node x
          )
        | a -> a
      ) args
      in
      let r = ref 0. in
      Array.iteri (fun i d ->
        match (f' i d argsval) with
        | Float a -> (
          r := !r +. a;
          )
        | _ -> failwith "error: wrong output"
      ) dualval;
      Node (new_node (Float v) (Float !r))
      )
    | false -> Float v

  let sin x = wrap_fun Owl_autograd_maths.sin Derivative.sin' [|x|]

  let cos x = wrap_fun Owl_autograd_maths.cos Derivative.cos' [|x|]

end and
Derivative : DerivativeSig = struct

  let sin' i g x = Maths.cos x.(0)

  let cos' i g x = Maths.sin x.(0)

end
