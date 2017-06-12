(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Ctypes

module Bindings (F : Cstubs.FOREIGN) = struct

  open F

  let lapacke_sbdsdc = foreign "LAPACKE_sbdsdc" (int @-> char @-> char @-> int @-> ptr float @-> ptr float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> ptr int @-> returning int)

end
