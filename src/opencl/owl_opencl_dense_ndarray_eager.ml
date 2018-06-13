(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

module G = Owl_opencl_dense_ndarray

include Owl.Dense.Ndarray.S


(* unary operator definitions *)

let erf x = G.(of_ndarray x |> erf |> to_ndarray float32)

let erfc x = G.(of_ndarray x |> erfc |> to_ndarray float32)

let abs x = G.(of_ndarray x |> abs |> to_ndarray float32)

let neg x = G.(of_ndarray x |> neg |> to_ndarray float32)

let sqr x = G.(of_ndarray x |> sqr |> to_ndarray float32)

let sqrt x = G.(of_ndarray x |> sqrt |> to_ndarray float32)

let cbrt x = G.(of_ndarray x |> cbrt |> to_ndarray float32)

let reci x = G.(of_ndarray x |> reci |> to_ndarray float32)

let sin x = G.(of_ndarray x |> sin |> to_ndarray float32)

let cos x = G.(of_ndarray x |> cos |> to_ndarray float32)

let tan x = G.(of_ndarray x |> tan |> to_ndarray float32)

let asin x = G.(of_ndarray x |> asin |> to_ndarray float32)

let acos x = G.(of_ndarray x |> acos |> to_ndarray float32)

let atan x = G.(of_ndarray x |> atan |> to_ndarray float32)

let sinh x = G.(of_ndarray x |> sinh |> to_ndarray float32)

let cosh x = G.(of_ndarray x |> cosh |> to_ndarray float32)

let tanh x = G.(of_ndarray x |> tanh |> to_ndarray float32)

let asinh x = G.(of_ndarray x |> asinh |> to_ndarray float32)

let acosh x = G.(of_ndarray x |> acosh |> to_ndarray float32)

let atanh x = G.(of_ndarray x |> atanh |> to_ndarray float32)

let sinpi x = G.(of_ndarray x |> sinpi |> to_ndarray float32)

let cospi x = G.(of_ndarray x |> cospi |> to_ndarray float32)

let tanpi x = G.(of_ndarray x |> tanpi |> to_ndarray float32)

let floor x = G.(of_ndarray x |> floor |> to_ndarray float32)

let ceil x = G.(of_ndarray x |> ceil |> to_ndarray float32)

let round x = G.(of_ndarray x |> round |> to_ndarray float32)

let exp x = G.(of_ndarray x |> exp |> to_ndarray float32)

let exp2 x = G.(of_ndarray x |> exp2 |> to_ndarray float32)

let exp10 x = G.(of_ndarray x |> exp10 |> to_ndarray float32)

let expm1 x = G.(of_ndarray x |> expm1 |> to_ndarray float32)

let log x = G.(of_ndarray x |> log |> to_ndarray float32)

let log2 x = G.(of_ndarray x |> log2 |> to_ndarray float32)

let log10 x = G.(of_ndarray x |> log10 |> to_ndarray float32)

let log1p x = G.(of_ndarray x |> log1p |> to_ndarray float32)

let logb x = G.(of_ndarray x |> logb |> to_ndarray float32)

let relu x = G.(of_ndarray x |> relu |> to_ndarray float32)

let signum x = G.(of_ndarray x |> signum |> to_ndarray float32)

let sigmoid x = G.(of_ndarray x |> sigmoid |> to_ndarray float32)

let softplus x = G.(of_ndarray x |> softplus |> to_ndarray float32)

let softsign x = G.(of_ndarray x |> softsign |> to_ndarray float32)


(* binary operator definitions *)

let add_scalar x a =
  let x = G.of_ndarray x in
  let a = Owl_opencl_primitive.pack_flt a in
  let y = G.add_scalar x a in
  G.to_ndarray float32 y


let sub_scalar x a =
  let x = G.of_ndarray x in
  let a = Owl_opencl_primitive.pack_flt a in
  let y = G.sub_scalar x a in
  G.to_ndarray float32 y


let mul_scalar x a =
  let x = G.of_ndarray x in
  let a = Owl_opencl_primitive.pack_flt a in
  let y = G.mul_scalar x a in
  G.to_ndarray float32 y


let div_scalar x a =
  let x = G.of_ndarray x in
  let a = Owl_opencl_primitive.pack_flt a in
  let y = G.div_scalar x a in
  G.to_ndarray float32 y


let scalar_add a x =
  let x = G.of_ndarray x in
  let a = Owl_opencl_primitive.pack_flt a in
  let y = G.scalar_add a x in
  G.to_ndarray float32 y


let scalar_sub a x =
  let x = G.of_ndarray x in
  let a = Owl_opencl_primitive.pack_flt a in
  let y = G.scalar_sub a x in
  G.to_ndarray float32 y


let scalar_mul a x =
  let x = G.of_ndarray x in
  let a = Owl_opencl_primitive.pack_flt a in
  let y = G.scalar_mul a x in
  G.to_ndarray float32 y


let scalar_div a x =
  let x = G.of_ndarray x in
  let a = Owl_opencl_primitive.pack_flt a in
  let y = G.scalar_div a x in
  G.to_ndarray float32 y


(*
let add x y =
  let x = G.of_ndarray x in
  let y = G.of_ndarray y in
  let z = G.add x y in
  G.to_ndarray float32 z


let sub x y =
  let x = G.of_ndarray x in
  let y = G.of_ndarray y in
  let z = G.sub x y in
  G.to_ndarray float32 z


let mul x y =
  let x = G.of_ndarray x in
  let y = G.of_ndarray y in
  let z = G.mul x y in
  G.to_ndarray float32 z


let div x y =
  let x = G.of_ndarray x in
  let y = G.of_ndarray y in
  let z = G.div x y in
  G.to_ndarray float32 z
*)
