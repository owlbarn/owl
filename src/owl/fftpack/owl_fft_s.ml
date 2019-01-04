(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

include Owl_fft_generic

let rfft = rfft ~otyp:Complex32

let irfft = irfft ~otyp:Float32
