(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

let sin x = sin x.(0)

let sin' g x = Pervasives.(g.(0) *. cos x.(0))


let cos x = cos x.(0)

let cos' g x = Pervasives.(-.g.(0) *. sin x.(0))


let log x = log x.(0)

let log' g x = g.(0) /. x.(0)


let add x = x.(0) +. x.(1)

let add' g x = g.(0) +. g.(1)


let sub x = x.(0) -. x.(1)

let sub' g x = g.(0) -.g.(1)


let mul x = x.(0) *. x.(1)

let mul' g x = (g.(0) *. x.(1)) +. (g.(1) *. x.(0))


let div x = x.(0) /. x.(1)

let div' g x = (g.(0) /. x.(1)) -. ((g.(1) *. x.(0)) /. (x.(1) *. x.(1)))
