(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

type node = {
  mutable v : float;
  mutable d : float;
}

type scalar = Float of float | Node of node

type df =
  | FUNVEC of (scalar array -> scalar array)
  | FUN01X of (scalar -> scalar array)
  | FUN02X of (scalar -> scalar -> scalar array)
  | FUN03X of (scalar -> scalar -> scalar -> scalar array)
  | FUN04X of (scalar -> scalar -> scalar -> scalar -> scalar array)

let prepare_fun f =
  match f with
  | FUNVEC f -> f
  | FUN01X f -> fun x -> f x.(0)
  | FUN02X f -> fun x -> f x.(0) x.(1)
  | FUN03X f -> fun x -> f x.(0) x.(1) x.(2)
  | FUN04X f -> fun x -> f x.(0) x.(1) x.(2) x.(3)

let new_node v d = { v; d; }

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
    let d = f' !dualval !argsval in
    let n = new_node v d in
    Node n
    )
  | false -> Float v

let forward ?(argnum=0) f =
  let f' = fun args -> (
    let args = Array.map (fun a ->
      match a with
      | Node n -> n.v
      | Float v -> v
    ) args in
    let l = Array.mapi (fun i a ->
      let n = match argnum = i with
      | true  -> new_node a 1.
      | false -> new_node a 0.
      in
      Node n
    ) args
    in
    (f l)
  )
  in
  f'

let grad ?(argnum=0) f =
  let f = prepare_fun f in
  let g = fun args -> (
    let r = (forward ~argnum f) args in
    match r.(0) with
    | Node n -> n.d
    | Float v -> v
  )
  in
  g

let unpack x =
  Array.map (fun a -> match a with
    | Node n -> n.d
    | Float v -> v
  ) x


module type MathsSig = sig
  val sin : scalar -> scalar
  val cos : scalar -> scalar
end

module type DerivativeSig = sig
  val sin' : float array -> float array -> float
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
      let d = f' !dualval !argsval in
      let n = new_node v d in
      Node n
      )
    | false -> Float v

  let sin x = wrap_fun Owl_autograd_maths.sin Derivative.sin' [|x|]

  let cos x = wrap_fun Owl_autograd_maths.cos Derivative.sin' [|x|]

end and
Derivative : DerivativeSig = struct

  let sin' g x = match Maths.cos (Float x.(0)) with Float v -> Pervasives.((g.(0) *. v))

end
