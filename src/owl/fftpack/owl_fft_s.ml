(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

include Owl_fft_generic

let rfft = rfft ~otyp:Complex32

let irfft = irfft ~otyp:Float32
