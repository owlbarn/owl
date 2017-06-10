(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Ctypes

module Bindings (F : Cstubs.FOREIGN) = struct

  open F


  (* Level 1 BLAS *)

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



  (* Level 2 BLAS *)

  let cblas_sgemv = foreign "cblas_sgemv" (int @-> int @-> int @-> int @-> float @-> ptr float @-> int @-> ptr float @-> int @-> float @-> ptr float @-> int @-> returning void)

  let cblas_dgemv = foreign "cblas_dgemv" (int @-> int @-> int @-> int @-> double @-> ptr double @-> int @-> ptr double @-> int @-> double @-> ptr double @-> int @-> returning void)

  let cblas_cgemv = foreign "cblas_cgemv" (int @-> int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning void)

  let cblas_zgemv = foreign "cblas_zgemv" (int @-> int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning void)


  let cblas_sgbmv = foreign "cblas_sgbmv" (int @-> int @-> int @-> int @-> int @-> int @-> float @-> ptr float @-> int @-> ptr float @-> int @-> float @-> ptr float @-> int @-> returning void)

  let cblas_dgbmv = foreign "cblas_dgbmv" (int @-> int @-> int @-> int @-> int @-> int @-> double @-> ptr double @-> int @-> ptr double @-> int @-> double @-> ptr double @-> int @-> returning void)

  let cblas_cgbmv = foreign "cblas_cgbmv" (int @-> int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning void)

  let cblas_zgbmv = foreign "cblas_zgbmv" (int @-> int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning void)


  let cblas_strmv = foreign "cblas_strmv" (int @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning void)

  let cblas_dtrmv = foreign "cblas_dtrmv" (int @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning void)

  let cblas_ctrmv = foreign "cblas_ctrmv" (int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning void)

  let cblas_ztrmv = foreign "cblas_ztrmv" (int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning void)


  let cblas_stbmv = foreign "cblas_stbmv" (int @-> int @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning void)

  let cblas_dtbmv = foreign "cblas_dtbmv" (int @-> int @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning void)

  let cblas_ctbmv = foreign "cblas_ctbmv" (int @-> int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning void)

  let cblas_ztbmv = foreign "cblas_ztbmv" (int @-> int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning void)


  let cblas_stpmv = foreign "cblas_stpmv" (int @-> int @-> int @-> int @-> int @-> ptr float @-> ptr float @-> int @-> returning void)

  let cblas_dtpmv = foreign "cblas_dtpmv" (int @-> int @-> int @-> int @-> int @-> ptr double @-> ptr double @-> int @-> returning void)

  let cblas_ctpmv = foreign "cblas_ctpmv" (int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning void)

  let cblas_ztpmv = foreign "cblas_ztpmv" (int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning void)


  let cblas_strsv = foreign "cblas_strsv" (int @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning void)

  let cblas_dtrsv = foreign "cblas_dtrsv" (int @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning void)

  let cblas_ctrsv = foreign "cblas_ctrsv" (int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning void)

  let cblas_ztrsv = foreign "cblas_ztrsv" (int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning void)


  let cblas_stbsv = foreign "cblas_stbsv" (int @-> int @-> int @-> int @-> int @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning void)

  let cblas_dtbsv = foreign "cblas_dtbsv" (int @-> int @-> int @-> int @-> int @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning void)

  let cblas_ctbsv = foreign "cblas_ctbsv" (int @-> int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning void)

  let cblas_ztbsv = foreign "cblas_ztbsv" (int @-> int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning void)


  let cblas_stpsv = foreign "cblas_stpsv" (int @-> int @-> int @-> int @-> int @-> ptr float @-> ptr float @-> int @-> returning void)

  let cblas_dtpsv = foreign "cblas_dtpsv" (int @-> int @-> int @-> int @-> int @-> ptr double @-> ptr double @-> int @-> returning void)

  let cblas_ctpsv = foreign "cblas_ctpsv" (int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning void)

  let cblas_ztpsv = foreign "cblas_ztpsv" (int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning void)


  let cblas_ssymv = foreign "cblas_ssymv" (int @-> int @-> int @-> float @-> ptr float @-> int @-> ptr float @-> int @-> float @-> ptr float @-> int @-> returning void)

  let cblas_dsymv = foreign "cblas_dsymv" (int @-> int @-> int @-> double @-> ptr double @-> int @-> ptr double @-> int @-> double @-> ptr double @-> int @-> returning void)


  let cblas_ssbmv = foreign "cblas_ssbmv" (int @-> int @-> int @-> int @-> float @-> ptr float @-> int @-> ptr float @-> int @-> float @-> ptr float @-> int @-> returning void)

  let cblas_dsbmv = foreign "cblas_dsbmv" (int @-> int @-> int @-> int @-> double @-> ptr double @-> int @-> ptr double @-> int @-> double @-> ptr double @-> int @-> returning void)


  let cblas_sspmv = foreign "cblas_sspmv" (int @-> int @-> int @-> float @-> ptr float @-> ptr float @-> int @-> float @-> ptr float @-> int @-> returning void)

  let cblas_dspmv = foreign "cblas_dspmv" (int @-> int @-> int @-> double @-> ptr double @-> ptr double @-> int @-> double @-> ptr double @-> int @-> returning void)


  let cblas_sger = foreign "cblas_sger" (int @-> int @-> int @-> float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning void)

  let cblas_dger = foreign "cblas_dger" (int @-> int @-> int @-> double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning void)


  let cblas_ssyr = foreign "cblas_ssyr" (int @-> int @-> int @-> float @-> ptr float @-> int @-> ptr float @-> int @-> returning void)

  let cblas_dsyr = foreign "cblas_dsyr" (int @-> int @-> int @-> double @-> ptr double @-> int @-> ptr double @-> int @-> returning void)


  let cblas_sspr = foreign "cblas_sspr" (int @-> int @-> int @-> float @-> ptr float @-> int @-> ptr float @-> returning void)

  let cblas_dspr = foreign "cblas_dspr" (int @-> int @-> int @-> double @-> ptr double @-> int @-> ptr double @-> returning void)


  let cblas_ssyr2 = foreign "cblas_ssyr2" (int @-> int @-> int @-> float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> int @-> returning void)

  let cblas_dsyr2 = foreign "cblas_dsyr2" (int @-> int @-> int @-> double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> int @-> returning void)


  let cblas_sspr2 = foreign "cblas_sspr2" (int @-> int @-> int @-> float @-> ptr float @-> int @-> ptr float @-> int @-> ptr float @-> returning void)

  let cblas_dspr2 = foreign "cblas_dspr2" (int @-> int @-> int @-> double @-> ptr double @-> int @-> ptr double @-> int @-> ptr double @-> returning void)


  let cblas_chemv = foreign "cblas_chemv" (int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning void)

  let cblas_zhemv = foreign "cblas_zhemv" (int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning void)


  let cblas_chbmv = foreign "cblas_chbmv" (int @-> int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning void)

  let cblas_zhbmv = foreign "cblas_zhbmv" (int @-> int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning void)


  let cblas_chpmv = foreign "cblas_chpmv" (int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning void)

  let cblas_zhpmv = foreign "cblas_zhpmv" (int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning void)


  let cblas_cgeru = foreign "cblas_cgeru" (int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning void)

  let cblas_zgeru = foreign "cblas_zgeru" (int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning void)


  let cblas_cgerc = foreign "cblas_cgerc" (int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning void)

  let cblas_zgerc = foreign "cblas_zgerc" (int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning void)


  let cblas_cher = foreign "cblas_cher" (int @-> int @-> int @-> float @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning void)

  let cblas_zher = foreign "cblas_zher" (int @-> int @-> int @-> float @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning void)


  let cblas_chpr = foreign "cblas_chpr" (int @-> int @-> int @-> float @-> ptr complex32 @-> int @-> ptr complex32 @-> returning void)

  let cblas_zhpr = foreign "cblas_zhpr" (int @-> int @-> int @-> float @-> ptr complex64 @-> int @-> ptr complex64 @-> returning void)


  let cblas_cher2 = foreign "cblas_cher2" (int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning void)

  let cblas_zher2 = foreign "cblas_zher2" (int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning void)


  let cblas_chpr2 = foreign "cblas_chpr2" (int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> returning void)

  let cblas_zhpr2 = foreign "cblas_zhpr2" (int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> returning void)



  (* Level 3 BLAS *)

  let cblas_sgemm = foreign "cblas_sgemm" (int @-> int @-> int @-> int @-> int @-> int @-> float @-> ptr float @-> int @-> ptr float @-> int @-> float @-> ptr float @-> int @-> returning void)

  let cblas_dgemm = foreign "cblas_dgemm" (int @-> int @-> int @-> int @-> int @-> int @-> double @-> ptr double @-> int @-> ptr double @-> int @-> double @-> ptr double @-> int @-> returning void)

  let cblas_cgemm = foreign "cblas_cgemm" (int @-> int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning void)

  let cblas_zgemm = foreign "cblas_zgemm" (int @-> int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning void)


  let cblas_ssymm = foreign "cblas_ssymm" (int @-> int @-> int @-> int @-> int @-> float @-> ptr float @-> int @-> ptr float @-> int @-> float @-> ptr float @-> int @-> returning void)

  let cblas_dsymm = foreign "cblas_dsymm" (int @-> int @-> int @-> int @-> int @-> double @-> ptr double @-> int @-> ptr double @-> int @-> double @-> ptr double @-> int @-> returning void)

  let cblas_csymm = foreign "cblas_csymm" (int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning void)

  let cblas_zsymm = foreign "cblas_zsymm" (int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning void)


  let cblas_ssyrk = foreign "cblas_ssyrk" (int @-> int @-> int @-> int @-> int @-> float @-> ptr float @-> int @-> float @-> ptr float @-> int @-> returning void)

  let cblas_dsyrk = foreign "cblas_dsyrk" (int @-> int @-> int @-> int @-> int @-> double @-> ptr double @-> int @-> double @-> ptr double @-> int @-> returning void)

  let cblas_csyrk = foreign "cblas_csyrk" (int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning void)

  let cblas_zsyrk = foreign "cblas_zsyrk" (int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning void)


  let cblas_ssyr2k = foreign "cblas_ssyr2k" (int @-> int @-> int @-> int @-> int @-> float @-> ptr float @-> int @-> ptr float @-> int @-> float @-> ptr float @-> int @-> returning void)

  let cblas_dsyr2k = foreign "cblas_dsyr2k" (int @-> int @-> int @-> int @-> int @-> double @-> ptr double @-> int @-> ptr double @-> int @-> double @-> ptr double @-> int @-> returning void)

  let cblas_csyr2k = foreign "cblas_csyr2k" (int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning void)

  let cblas_zsyr2k = foreign "cblas_zsyr2k" (int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning void)


  let cblas_strmm = foreign "cblas_strmm" (int @-> int @-> int @-> int @-> int @-> int @-> int @-> float @-> ptr float @-> int @-> ptr float @-> int @-> returning void)

  let cblas_dtrmm = foreign "cblas_dtrmm" (int @-> int @-> int @-> int @-> int @-> int @-> int @-> double @-> ptr double @-> int @-> ptr double @-> int @-> returning void)

  let cblas_ctrmm = foreign "cblas_ctrmm" (int @-> int @-> int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning void)

  let cblas_ztrmm = foreign "cblas_ztrmm" (int @-> int @-> int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning void)


  let cblas_strsm = foreign "cblas_strsm" (int @-> int @-> int @-> int @-> int @-> int @-> int @-> float @-> ptr float @-> int @-> ptr float @-> int @-> returning void)

  let cblas_dtrsm = foreign "cblas_dtrsm" (int @-> int @-> int @-> int @-> int @-> int @-> int @-> double @-> ptr double @-> int @-> ptr double @-> int @-> returning void)

  let cblas_ctrsm = foreign "cblas_ctrsm" (int @-> int @-> int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> returning void)

  let cblas_ztrsm = foreign "cblas_ztrsm" (int @-> int @-> int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> returning void)


  let cblas_chemm = foreign "cblas_chemm" (int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> returning void)

  let cblas_zhemm = foreign "cblas_zhemm" (int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> returning void)


  let cblas_cherk = foreign "cblas_cherk" (int @-> int @-> int @-> int @-> int @-> float @-> ptr complex32 @-> int @-> float @-> ptr complex32 @-> int @-> returning void)

  let cblas_zherk = foreign "cblas_zherk" (int @-> int @-> int @-> int @-> int @-> double @-> ptr complex64 @-> int @-> double @-> ptr complex64 @-> int @-> returning void)


  let cblas_cher2k = foreign "cblas_cher2k" (int @-> int @-> int @-> int @-> int @-> ptr complex32 @-> ptr complex32 @-> int @-> ptr complex32 @-> int @-> float @-> ptr complex32 @-> int @-> returning void)

  let cblas_zher2k = foreign "cblas_zher2k" (int @-> int @-> int @-> int @-> int @-> ptr complex64 @-> ptr complex64 @-> int @-> ptr complex64 @-> int @-> float @-> ptr complex64 @-> int @-> returning void)



end
