(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Ctypes

module Bindings (F : Cstubs.FOREIGN) = struct

  open F

  let cblas_scopy = foreign "cblas_scopy" (int @-> ptr float @-> int @-> ptr float @-> int @-> returning void)

  let cblas_dcopy = foreign "cblas_dcopy" (int @-> ptr double @-> int @-> ptr double @-> int @-> returning void)

  let cblas_ccopy = foreign "cblas_ccopy" (int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning void)

  let cblas_zcopy = foreign "cblas_zcopy" (int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning void)

end
