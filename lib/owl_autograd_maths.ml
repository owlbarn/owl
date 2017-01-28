(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

let sin x = sin x.(0)

let sin' g x = g *. cos x.(0)


let log x = log x.(0)

let log' g x = g /. x.(0)


let add x = x.(0) +. x.(1)

let add' ?(argnum=0) g x = g

let sub x = x.(0) -. x.(1)

let add' ?(argnum=0) g x = -.g

let mul x = x.(0) *. x.(1)

let mul' ?(argnum=0) g x =
  match argnum with
  | 0 -> g *. x.(1)
  | _ -> g *. x.(0)

let div x = x.(0) /. x.(1)

let div' ?(argnum=0) g x =
  match argnum with
  | 0 -> g /. x.(1)
  | _ -> (-.g *. x.(0)) /. (x.(1) *. x.(1))
