(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type scalar = Float of float | Node of node
and node = {
  v : scalar;
  d : scalar;
}

let rec print_node_helper x =
  match x with
  | Float a -> Printf.printf "%g" a
  | Node x -> (
    let _ = match x.v with
    | Float a -> Printf.printf "(%g," a
    | _ -> failwith "error in print_node 1"
    in
    let _ = match x.d with
    | Float a -> Printf.printf "%g" a
    | y -> print_node_helper y; Printf.printf ")"
    in ()
    )

let print_node n = print_node_helper (Node n); print_endline ""

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

  let sin' g x = g.(0) *. cos x.(0)

  let cos' g x =
    let a = match g.(0) with
    | Node y -> (
      match y.v with
      | Float a -> Node (new_node (Float Pervasives.(-1. *. a)) y.d)
      | _ -> failwith "error in cos'"
      )
    | Float a -> Float Pervasives.(-1. *. a)
    in
    a *. sin x.(0)

end
