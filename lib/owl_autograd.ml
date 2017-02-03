(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type scalar = Float of float | Node of node
and node = {
  v : scalar;
  d : scalar;
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
  val ( +. ) : scalar -> scalar -> scalar
  val ( *. ) : scalar -> scalar -> scalar
  val sin : scalar -> scalar
  val cos : scalar -> scalar
end

module type DerivativeSig = sig
  val add' : scalar array -> scalar array -> scalar
  val mul' : scalar array -> scalar array -> scalar
  val sin' : scalar array -> scalar array -> scalar
  val cos' : scalar array -> scalar array -> scalar
end

module rec Maths : MathsSig = struct

  let wrap_fun f f' args =
    let dr_mode = ref false in
    let argslen = Array.length args in
    let dualval = Array.make argslen (Float 0.) in
    Array.iteri (fun i arg ->
      match arg with
      | Node x -> (
        dr_mode := true;
        dualval.(i) <- x.d;
        )
      | _ -> ()
    ) args;
    let v = f (args |> unpack) in
    match !dr_mode with
    | true -> (
      let argsval = Array.map (fun x ->
        match x with
        | Node x -> (
          match x.d with
          | Node y -> Node (new_node x.v y.d)
          | a -> a
          )
        | a -> a
      ) args
      in
      let d = f' dualval argsval in
      Node (new_node (Float v) d)
      )
    | false -> Float v

  let ( +. ) x0 x1 = wrap_fun Owl_autograd_maths.mul Derivative.mul' [|x0; x1|]

  let ( *. ) x0 x1 = wrap_fun Owl_autograd_maths.mul Derivative.mul' [|x0; x1|]

  let sin x = wrap_fun Owl_autograd_maths.sin Derivative.sin' [|x|]

  let cos x = wrap_fun Owl_autograd_maths.cos Derivative.cos' [|x|]

end and
Derivative : DerivativeSig = struct

  open Maths

  let add' g x = g.(0) +. g.(1)

  let mul' g x = (g.(0) *. x.(1)) +. (g.(1) *. x.(0))

  let sin' g x = cos x.(0)

  let cos' g x =
    let a = match g.(0) with
    | Node y -> Node (new_node (Float (-1.)) y.d) (* FIXME *)
    | Float a -> Float Pervasives.(-1. *. a) 
    in
    a *. sin x.(0)

end
