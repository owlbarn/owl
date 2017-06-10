(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Ctypes

module Bindings (F : Cstubs.FOREIGN) = struct

  open F

  (* Level 1 *)

  let cblas_srotg = foreign "cblas_srotg" (ptr float @-> ptr float @-> ptr float @-> ptr float @-> returning void)

  let cblas_drotg = foreign "cblas_drotg" (ptr double @-> ptr double @-> ptr double @-> ptr double @-> returning void)


  let cblas_srotmg = foreign "cblas_srotmg" (ptr float @-> ptr float @-> ptr float @-> float @-> ptr float @-> returning void)

  let cblas_drotmg = foreign "cblas_drotmg" (ptr double @-> ptr double @-> ptr double @-> double @-> ptr double @-> returning void)


  let cblas_srot = foreign "cblas_srot" (int @-> ptr float @-> int @-> ptr float @-> int @-> float @-> float @-> returning void)

  let cblas_drot = foreign "cblas_drot" (int @-> ptr double @-> int @-> ptr double @-> int @-> double @-> double @-> returning void)


  let cblas_sswap = foreign "cblas_sswap" (int @-> ptr float @-> int @-> ptr float @-> int @-> returning void)

  let cblas_dswap = foreign "cblas_dswap" (int @-> ptr double @-> int @-> ptr double @-> int @-> returning void)

  let cblas_cswap = foreign "cblas_cswap" (int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning void)

  let cblas_zswap = foreign "cblas_zswap" (int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning void)


  let cblas_sscal = foreign "cblas_sscal" (int @-> float @-> ptr float @-> int @-> returning void)

  let cblas_dscal = foreign "cblas_dscal" (int @-> double @-> ptr double @-> int @-> returning void)

  let cblas_cscal = foreign "cblas_cscal" (int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning void)

  let cblas_zscal = foreign "cblas_zscal" (int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning void)

  let cblas_csscal = foreign "cblas_csscal" (int @-> float @-> ptr complex32 @-> int @-> returning void)

  let cblas_zdscal = foreign "cblas_zdscal" (int @-> double @-> ptr complex64 @-> int @-> returning void)


  let cblas_scopy = foreign "cblas_scopy" (int @-> ptr float @-> int @-> ptr float @-> int @-> returning void)

  let cblas_dcopy = foreign "cblas_dcopy" (int @-> ptr double @-> int @-> ptr double @-> int @-> returning void)

  let cblas_ccopy = foreign "cblas_ccopy" (int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning void)

  let cblas_zcopy = foreign "cblas_zcopy" (int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning void)


  let cblas_saxpy = foreign "cblas_saxpy" (int @-> float @-> ptr float @-> int @-> ptr float @-> int @-> returning void)

  let cblas_daxpy = foreign "cblas_daxpy" (int @-> double @-> ptr double @-> int @-> ptr double @-> int @-> returning void)

  let cblas_caxpy = foreign "cblas_caxpy" (int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning void)

  let cblas_zaxpy = foreign "cblas_zaxpy" (int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning void)


  let cblas_sdot = foreign "cblas_sdot" (int @-> ptr float @-> int @-> ptr float @-> int @-> returning float)

  let cblas_ddot = foreign "cblas_ddot" (int @-> ptr double @-> int @-> ptr double @-> int @-> returning double)

  let cblas_sdsdot = foreign "cblas_sdsdot" (int @-> float @-> ptr float @-> int @-> ptr float @-> int @-> returning float)

  let cblas_dsdot = foreign "cblas_dsdot" (int @-> ptr float @-> int @-> ptr float @-> int @-> returning double)

  let cblas_cdotu = foreign "cblas_cdotu_sub" (int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning void)

  let cblas_cdotc = foreign "cblas_cdotc_sub" (int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning void)

  let cblas_zdotu = foreign "cblas_zdotu_sub" (int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning void)

  let cblas_zdotc = foreign "cblas_zdotc_sub" (int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning void)


  let cblas_snrm2 = foreign "cblas_snrm2" (int @-> ptr float @-> int @-> returning float)

  let cblas_dnrm2 = foreign "cblas_dnrm2" (int @-> ptr double @-> int @-> returning double)

  let cblas_scnrm2 = foreign "cblas_scnrm2" (int @-> ptr complex32 @-> int @-> returning float)

  let cblas_dznrm2 = foreign "cblas_dznrm2" (int @-> ptr complex64 @-> int @-> returning double)


  let cblas_sasum = foreign "cblas_sasum" (int @-> ptr float @-> int @-> returning float)

  let cblas_dasum = foreign "cblas_dasum" (int @-> ptr double @-> int @-> returning double)

  let cblas_scasum = foreign "cblas_scasum" (int @-> ptr complex32 @-> int @-> returning float)

  let cblas_dzasum = foreign "cblas_dzasum" (int @-> ptr complex64 @-> int @-> returning double)


  let cblas_isamax = foreign "cblas_isamax" (int @-> ptr float @-> int @-> returning size_t)

  let cblas_idamax = foreign "cblas_idamax" (int @-> ptr double @-> int @-> returning size_t)

  let cblas_icamax = foreign "cblas_icamax" (int @-> ptr complex32 @-> int @-> returning size_t)

  let cblas_izamax = foreign "cblas_izamax" (int @-> ptr complex64 @-> int @-> returning size_t)


  (* Level 2 *)

  let cblas_sgemv = foreign "cblas_sgemv" (int @-> int @-> int @-> int @-> float @-> ptr float @-> int @-> ptr float @-> int @-> float @-> ptr float @-> int @-> returning void)

  let cblas_dgemv = foreign "cblas_dgemv" (int @-> int @-> int @-> int @-> double @-> ptr double @-> int @-> ptr double @-> int @-> double @-> ptr double @-> int @-> returning void)

  let cblas_cgemv = foreign "cblas_cgemv" (int @-> int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning void)

  let cblas_zgemv = foreign "cblas_zgemv" (int @-> int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning void)


end
