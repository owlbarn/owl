(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

include Owl_fft_generic

let rfft = rfft ~otyp:Complex64

let irfft = irfft ~otyp:Float64
