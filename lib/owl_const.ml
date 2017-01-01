(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

include Gsl.Const

module SI = struct
  include MKSA
end

module Prefix = struct
  let fine_structure = 7.297352533e-3
  let avogadro = 6.02214199e23
  let yotta = 1e24
  let zetta = 1e21
  let exa = 1e18
  let peta = 1e15
  let tera = 1e12
  let giga = 1e9
  let mega = 1e6
  let kilo = 1e3
  let hecto = 1e2
  let deca = 1e1
  let deci = 1e-1
  let centi = 1e-2
  let milli = 1e-3
  let micro = 1e-6
  let nano = 1e-9
  let pico = 1e-12
  let femto = 1e-15
  let atto = 1e-18
  let zepto = 1e-21
  let yocto = 1e-24
end
