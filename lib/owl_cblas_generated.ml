(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* auto-generated cblas interface file, timestamp:1497541471 *)

open Ctypes

module CI = Cstubs_internals

external cblas_sdsdot
  : int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float
  = "openblas_stub_1_cblas_sdsdot_byte6" "openblas_stub_1_cblas_sdsdot"

external cblas_dsdot
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float
  = "openblas_stub_2_cblas_dsdot"

external cblas_sdot
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float
  = "openblas_stub_3_cblas_sdot"

external cblas_ddot
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float
  = "openblas_stub_4_cblas_ddot"

external cblas_cdotu
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "openblas_stub_5_cblas_cdotu_sub_byte6" "openblas_stub_5_cblas_cdotu_sub"

external cblas_cdotc
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "openblas_stub_6_cblas_cdotc_sub_byte6" "openblas_stub_6_cblas_cdotc_sub"

external cblas_zdotu
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "openblas_stub_7_cblas_zdotu_sub_byte6" "openblas_stub_7_cblas_zdotu_sub"

external cblas_zdotc
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "openblas_stub_8_cblas_zdotc_sub_byte6" "openblas_stub_8_cblas_zdotc_sub"

external cblas_snrm2
  : int -> _ CI.fatptr -> int -> float
  = "openblas_stub_9_cblas_snrm2"

external cblas_sasum
  : int -> _ CI.fatptr -> int -> float
  = "openblas_stub_10_cblas_sasum"

external cblas_dnrm2
  : int -> _ CI.fatptr -> int -> float
  = "openblas_stub_11_cblas_dnrm2"

external cblas_dasum
  : int -> _ CI.fatptr -> int -> float
  = "openblas_stub_12_cblas_dasum"

external cblas_scnrm2
  : int -> _ CI.fatptr -> int -> float
  = "openblas_stub_13_cblas_scnrm2"

external cblas_scasum
  : int -> _ CI.fatptr -> int -> float
  = "openblas_stub_14_cblas_scasum"

external cblas_dznrm2
  : int -> _ CI.fatptr -> int -> float
  = "openblas_stub_15_cblas_dznrm2"

external cblas_dzasum
  : int -> _ CI.fatptr -> int -> float
  = "openblas_stub_16_cblas_dzasum"

external cblas_isamax
  : int -> _ CI.fatptr -> int -> Unsigned.size_t
  = "openblas_stub_17_cblas_isamax"

external cblas_idamax
  : int -> _ CI.fatptr -> int -> Unsigned.size_t
  = "openblas_stub_18_cblas_idamax"

external cblas_icamax
  : int -> _ CI.fatptr -> int -> Unsigned.size_t
  = "openblas_stub_19_cblas_icamax"

external cblas_izamax
  : int -> _ CI.fatptr -> int -> Unsigned.size_t
  = "openblas_stub_20_cblas_izamax"

external cblas_sswap
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_21_cblas_sswap"

external cblas_scopy
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_22_cblas_scopy"

external cblas_saxpy
  : int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_23_cblas_saxpy_byte6" "openblas_stub_23_cblas_saxpy"

external cblas_dswap
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_24_cblas_dswap"

external cblas_dcopy
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_25_cblas_dcopy"

external cblas_daxpy
  : int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_26_cblas_daxpy_byte6" "openblas_stub_26_cblas_daxpy"

external cblas_cswap
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_27_cblas_cswap"

external cblas_ccopy
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_28_cblas_ccopy"

external cblas_caxpy
  : int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_29_cblas_caxpy_byte6" "openblas_stub_29_cblas_caxpy"

external cblas_zswap
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_30_cblas_zswap"

external cblas_zcopy
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_31_cblas_zcopy"

external cblas_zaxpy
  : int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_32_cblas_zaxpy_byte6" "openblas_stub_32_cblas_zaxpy"

external cblas_srotg
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> unit
  = "openblas_stub_33_cblas_srotg"

external cblas_srotmg
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> float -> _ CI.fatptr -> unit
  = "openblas_stub_34_cblas_srotmg"

external cblas_srot
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> unit
  = "openblas_stub_35_cblas_srot_byte7" "openblas_stub_35_cblas_srot"

external cblas_srotm
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "openblas_stub_36_cblas_srotm_byte6" "openblas_stub_36_cblas_srotm"

external cblas_drotg
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> unit
  = "openblas_stub_37_cblas_drotg"

external cblas_drotmg
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> float -> _ CI.fatptr -> unit
  = "openblas_stub_38_cblas_drotmg"

external cblas_drot
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> unit
  = "openblas_stub_39_cblas_drot_byte7" "openblas_stub_39_cblas_drot"

external cblas_drotm
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "openblas_stub_40_cblas_drotm_byte6" "openblas_stub_40_cblas_drotm"

external cblas_sscal
  : int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_41_cblas_sscal"

external cblas_dscal
  : int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_42_cblas_dscal"

external cblas_cscal
  : int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_43_cblas_cscal"

external cblas_zscal
  : int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_44_cblas_zscal"

external cblas_csscal
  : int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_45_cblas_csscal"

external cblas_zdscal
  : int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_46_cblas_zdscal"

external cblas_sgemv
  : int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_47_cblas_sgemv_byte12" "openblas_stub_47_cblas_sgemv"

external cblas_sgbmv
  : int -> int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_48_cblas_sgbmv_byte14" "openblas_stub_48_cblas_sgbmv"

external cblas_strmv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_49_cblas_strmv_byte9" "openblas_stub_49_cblas_strmv"

external cblas_stbmv
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_50_cblas_stbmv_byte10" "openblas_stub_50_cblas_stbmv"

external cblas_stpmv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_51_cblas_stpmv_byte8" "openblas_stub_51_cblas_stpmv"

external cblas_strsv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_52_cblas_strsv_byte9" "openblas_stub_52_cblas_strsv"

external cblas_stbsv
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_53_cblas_stbsv_byte10" "openblas_stub_53_cblas_stbsv"

external cblas_stpsv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_54_cblas_stpsv_byte8" "openblas_stub_54_cblas_stpsv"

external cblas_dgemv
  : int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_55_cblas_dgemv_byte12" "openblas_stub_55_cblas_dgemv"

external cblas_dgbmv
  : int -> int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_56_cblas_dgbmv_byte14" "openblas_stub_56_cblas_dgbmv"

external cblas_dtrmv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_57_cblas_dtrmv_byte9" "openblas_stub_57_cblas_dtrmv"

external cblas_dtbmv
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_58_cblas_dtbmv_byte10" "openblas_stub_58_cblas_dtbmv"

external cblas_dtpmv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_59_cblas_dtpmv_byte8" "openblas_stub_59_cblas_dtpmv"

external cblas_dtrsv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_60_cblas_dtrsv_byte9" "openblas_stub_60_cblas_dtrsv"

external cblas_dtbsv
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_61_cblas_dtbsv_byte10" "openblas_stub_61_cblas_dtbsv"

external cblas_dtpsv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_62_cblas_dtpsv_byte8" "openblas_stub_62_cblas_dtpsv"

external cblas_cgemv
  : int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_63_cblas_cgemv_byte12" "openblas_stub_63_cblas_cgemv"

external cblas_cgbmv
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_64_cblas_cgbmv_byte14" "openblas_stub_64_cblas_cgbmv"

external cblas_ctrmv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_65_cblas_ctrmv_byte9" "openblas_stub_65_cblas_ctrmv"

external cblas_ctbmv
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_66_cblas_ctbmv_byte10" "openblas_stub_66_cblas_ctbmv"

external cblas_ctpmv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_67_cblas_ctpmv_byte8" "openblas_stub_67_cblas_ctpmv"

external cblas_ctrsv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_68_cblas_ctrsv_byte9" "openblas_stub_68_cblas_ctrsv"

external cblas_ctbsv
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_69_cblas_ctbsv_byte10" "openblas_stub_69_cblas_ctbsv"

external cblas_ctpsv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_70_cblas_ctpsv_byte8" "openblas_stub_70_cblas_ctpsv"

external cblas_zgemv
  : int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_71_cblas_zgemv_byte12" "openblas_stub_71_cblas_zgemv"

external cblas_zgbmv
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_72_cblas_zgbmv_byte14" "openblas_stub_72_cblas_zgbmv"

external cblas_ztrmv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_73_cblas_ztrmv_byte9" "openblas_stub_73_cblas_ztrmv"

external cblas_ztbmv
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_74_cblas_ztbmv_byte10" "openblas_stub_74_cblas_ztbmv"

external cblas_ztpmv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_75_cblas_ztpmv_byte8" "openblas_stub_75_cblas_ztpmv"

external cblas_ztrsv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_76_cblas_ztrsv_byte9" "openblas_stub_76_cblas_ztrsv"

external cblas_ztbsv
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_77_cblas_ztbsv_byte10" "openblas_stub_77_cblas_ztbsv"

external cblas_ztpsv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_78_cblas_ztpsv_byte8" "openblas_stub_78_cblas_ztpsv"

external cblas_ssymv
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_79_cblas_ssymv_byte11" "openblas_stub_79_cblas_ssymv"

external cblas_ssbmv
  : int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_80_cblas_ssbmv_byte12" "openblas_stub_80_cblas_ssbmv"

external cblas_sspmv
  : int -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_81_cblas_sspmv_byte10" "openblas_stub_81_cblas_sspmv"

external cblas_sger
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_82_cblas_sger_byte10" "openblas_stub_82_cblas_sger"

external cblas_ssyr
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_83_cblas_ssyr_byte8" "openblas_stub_83_cblas_ssyr"

external cblas_sspr
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "openblas_stub_84_cblas_sspr_byte7" "openblas_stub_84_cblas_sspr"

external cblas_ssyr2
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_85_cblas_ssyr2_byte10" "openblas_stub_85_cblas_ssyr2"

external cblas_sspr2
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "openblas_stub_86_cblas_sspr2_byte9" "openblas_stub_86_cblas_sspr2"

external cblas_dsymv
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_87_cblas_dsymv_byte11" "openblas_stub_87_cblas_dsymv"

external cblas_dsbmv
  : int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_88_cblas_dsbmv_byte12" "openblas_stub_88_cblas_dsbmv"

external cblas_dspmv
  : int -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_89_cblas_dspmv_byte10" "openblas_stub_89_cblas_dspmv"

external cblas_dger
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_90_cblas_dger_byte10" "openblas_stub_90_cblas_dger"

external cblas_dsyr
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_91_cblas_dsyr_byte8" "openblas_stub_91_cblas_dsyr"

external cblas_dspr
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "openblas_stub_92_cblas_dspr_byte7" "openblas_stub_92_cblas_dspr"

external cblas_dsyr2
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_93_cblas_dsyr2_byte10" "openblas_stub_93_cblas_dsyr2"

external cblas_dspr2
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "openblas_stub_94_cblas_dspr2_byte9" "openblas_stub_94_cblas_dspr2"

external cblas_chemv
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_95_cblas_chemv_byte11" "openblas_stub_95_cblas_chemv"

external cblas_chbmv
  : int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_96_cblas_chbmv_byte12" "openblas_stub_96_cblas_chbmv"

external cblas_chpmv
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_97_cblas_chpmv_byte10" "openblas_stub_97_cblas_chpmv"

external cblas_cgeru
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_98_cblas_cgeru_byte10" "openblas_stub_98_cblas_cgeru"

external cblas_cgerc
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_99_cblas_cgerc_byte10" "openblas_stub_99_cblas_cgerc"

external cblas_cher
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_100_cblas_cher_byte8" "openblas_stub_100_cblas_cher"

external cblas_chpr
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "openblas_stub_101_cblas_chpr_byte7" "openblas_stub_101_cblas_chpr"

external cblas_cher2
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_102_cblas_cher2_byte10" "openblas_stub_102_cblas_cher2"

external cblas_chpr2
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "openblas_stub_103_cblas_chpr2_byte9" "openblas_stub_103_cblas_chpr2"

external cblas_zhemv
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_104_cblas_zhemv_byte11" "openblas_stub_104_cblas_zhemv"

external cblas_zhbmv
  : int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_105_cblas_zhbmv_byte12" "openblas_stub_105_cblas_zhbmv"

external cblas_zhpmv
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_106_cblas_zhpmv_byte10" "openblas_stub_106_cblas_zhpmv"

external cblas_zgeru
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_107_cblas_zgeru_byte10" "openblas_stub_107_cblas_zgeru"

external cblas_zgerc
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_108_cblas_zgerc_byte10" "openblas_stub_108_cblas_zgerc"

external cblas_zher
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_109_cblas_zher_byte8" "openblas_stub_109_cblas_zher"

external cblas_zhpr
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "openblas_stub_110_cblas_zhpr_byte7" "openblas_stub_110_cblas_zhpr"

external cblas_zher2
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_111_cblas_zher2_byte10" "openblas_stub_111_cblas_zher2"

external cblas_zhpr2
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "openblas_stub_112_cblas_zhpr2_byte9" "openblas_stub_112_cblas_zhpr2"

external cblas_sgemm
  : int -> int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_113_cblas_sgemm_byte14" "openblas_stub_113_cblas_sgemm"

external cblas_ssymm
  : int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_114_cblas_ssymm_byte13" "openblas_stub_114_cblas_ssymm"

external cblas_ssyrk
  : int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_115_cblas_ssyrk_byte11" "openblas_stub_115_cblas_ssyrk"

external cblas_ssyr2k
  : int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_116_cblas_ssyr2k_byte13" "openblas_stub_116_cblas_ssyr2k"

external cblas_strmm
  : int -> int -> int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_117_cblas_strmm_byte12" "openblas_stub_117_cblas_strmm"

external cblas_strsm
  : int -> int -> int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_118_cblas_strsm_byte12" "openblas_stub_118_cblas_strsm"

external cblas_dgemm
  : int -> int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_119_cblas_dgemm_byte14" "openblas_stub_119_cblas_dgemm"

external cblas_dsymm
  : int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_120_cblas_dsymm_byte13" "openblas_stub_120_cblas_dsymm"

external cblas_dsyrk
  : int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_121_cblas_dsyrk_byte11" "openblas_stub_121_cblas_dsyrk"

external cblas_dsyr2k
  : int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_122_cblas_dsyr2k_byte13" "openblas_stub_122_cblas_dsyr2k"

external cblas_dtrmm
  : int -> int -> int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_123_cblas_dtrmm_byte12" "openblas_stub_123_cblas_dtrmm"

external cblas_dtrsm
  : int -> int -> int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_124_cblas_dtrsm_byte12" "openblas_stub_124_cblas_dtrsm"

external cblas_cgemm
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_125_cblas_cgemm_byte14" "openblas_stub_125_cblas_cgemm"

external cblas_csymm
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_126_cblas_csymm_byte13" "openblas_stub_126_cblas_csymm"

external cblas_csyrk
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_127_cblas_csyrk_byte11" "openblas_stub_127_cblas_csyrk"

external cblas_csyr2k
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_128_cblas_csyr2k_byte13" "openblas_stub_128_cblas_csyr2k"

external cblas_ctrmm
  : int -> int -> int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_129_cblas_ctrmm_byte12" "openblas_stub_129_cblas_ctrmm"

external cblas_ctrsm
  : int -> int -> int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_130_cblas_ctrsm_byte12" "openblas_stub_130_cblas_ctrsm"

external cblas_zgemm
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_131_cblas_zgemm_byte14" "openblas_stub_131_cblas_zgemm"

external cblas_zsymm
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_132_cblas_zsymm_byte13" "openblas_stub_132_cblas_zsymm"

external cblas_zsyrk
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_133_cblas_zsyrk_byte11" "openblas_stub_133_cblas_zsyrk"

external cblas_zsyr2k
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_134_cblas_zsyr2k_byte13" "openblas_stub_134_cblas_zsyr2k"

external cblas_ztrmm
  : int -> int -> int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_135_cblas_ztrmm_byte12" "openblas_stub_135_cblas_ztrmm"

external cblas_ztrsm
  : int -> int -> int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "openblas_stub_136_cblas_ztrsm_byte12" "openblas_stub_136_cblas_ztrsm"

external cblas_chemm
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_137_cblas_chemm_byte13" "openblas_stub_137_cblas_chemm"

external cblas_cherk
  : int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_138_cblas_cherk_byte11" "openblas_stub_138_cblas_cherk"

external cblas_cher2k
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_139_cblas_cher2k_byte13" "openblas_stub_139_cblas_cher2k"

external cblas_zhemm
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "openblas_stub_140_cblas_zhemm_byte13" "openblas_stub_140_cblas_zhemm"

external cblas_zherk
  : int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_141_cblas_zherk_byte11" "openblas_stub_141_cblas_zherk"

external cblas_zher2k
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "openblas_stub_142_cblas_zher2k_byte13" "openblas_stub_142_cblas_zher2k"

let sdsdot ~n ~alpha ~x ~incx ~y ~incy =
  cblas_sdsdot n alpha (CI.cptr x) incx (CI.cptr y) incy

let dsdot ~n ~x ~incx ~y ~incy =
  cblas_dsdot n (CI.cptr x) incx (CI.cptr y) incy

let sdot ~n ~x ~incx ~y ~incy =
  cblas_sdot n (CI.cptr x) incx (CI.cptr y) incy

let ddot ~n ~x ~incx ~y ~incy =
  cblas_ddot n (CI.cptr x) incx (CI.cptr y) incy

let cdotu ~n ~x ~incx ~y ~incy ~dotu =
  cblas_cdotu n (CI.cptr x) incx (CI.cptr y) incy (CI.cptr dotu)

let cdotc ~n ~x ~incx ~y ~incy ~dotc =
  cblas_cdotc n (CI.cptr x) incx (CI.cptr y) incy (CI.cptr dotc)

let zdotu ~n ~x ~incx ~y ~incy ~dotu =
  cblas_zdotu n (CI.cptr x) incx (CI.cptr y) incy (CI.cptr dotu)

let zdotc ~n ~x ~incx ~y ~incy ~dotc =
  cblas_zdotc n (CI.cptr x) incx (CI.cptr y) incy (CI.cptr dotc)

let snrm2 ~n ~x ~incx =
  cblas_snrm2 n (CI.cptr x) incx

let sasum ~n ~x ~incx =
  cblas_sasum n (CI.cptr x) incx

let dnrm2 ~n ~x ~incx =
  cblas_dnrm2 n (CI.cptr x) incx

let dasum ~n ~x ~incx =
  cblas_dasum n (CI.cptr x) incx

let scnrm2 ~n ~x ~incx =
  cblas_scnrm2 n (CI.cptr x) incx

let scasum ~n ~x ~incx =
  cblas_scasum n (CI.cptr x) incx

let dznrm2 ~n ~x ~incx =
  cblas_dznrm2 n (CI.cptr x) incx

let dzasum ~n ~x ~incx =
  cblas_dzasum n (CI.cptr x) incx

let isamax ~n ~x ~incx =
  cblas_isamax n (CI.cptr x) incx

let idamax ~n ~x ~incx =
  cblas_idamax n (CI.cptr x) incx

let icamax ~n ~x ~incx =
  cblas_icamax n (CI.cptr x) incx

let izamax ~n ~x ~incx =
  cblas_izamax n (CI.cptr x) incx

let sswap ~n ~x ~incx ~y ~incy =
  cblas_sswap n (CI.cptr x) incx (CI.cptr y) incy

let scopy ~n ~x ~incx ~y ~incy =
  cblas_scopy n (CI.cptr x) incx (CI.cptr y) incy

let saxpy ~n ~alpha ~x ~incx ~y ~incy =
  cblas_saxpy n alpha (CI.cptr x) incx (CI.cptr y) incy

let dswap ~n ~x ~incx ~y ~incy =
  cblas_dswap n (CI.cptr x) incx (CI.cptr y) incy

let dcopy ~n ~x ~incx ~y ~incy =
  cblas_dcopy n (CI.cptr x) incx (CI.cptr y) incy

let daxpy ~n ~alpha ~x ~incx ~y ~incy =
  cblas_daxpy n alpha (CI.cptr x) incx (CI.cptr y) incy

let cswap ~n ~x ~incx ~y ~incy =
  cblas_cswap n (CI.cptr x) incx (CI.cptr y) incy

let ccopy ~n ~x ~incx ~y ~incy =
  cblas_ccopy n (CI.cptr x) incx (CI.cptr y) incy

let caxpy ~n ~alpha ~x ~incx ~y ~incy =
  cblas_caxpy n (CI.cptr alpha) (CI.cptr x) incx (CI.cptr y) incy

let zswap ~n ~x ~incx ~y ~incy =
  cblas_zswap n (CI.cptr x) incx (CI.cptr y) incy

let zcopy ~n ~x ~incx ~y ~incy =
  cblas_zcopy n (CI.cptr x) incx (CI.cptr y) incy

let zaxpy ~n ~alpha ~x ~incx ~y ~incy =
  cblas_zaxpy n (CI.cptr alpha) (CI.cptr x) incx (CI.cptr y) incy

let srotg ~a ~b ~c ~s =
  cblas_srotg (CI.cptr a) (CI.cptr b) (CI.cptr c) (CI.cptr s)

let srotmg ~d1 ~d2 ~b1 ~b2 ~p =
  cblas_srotmg (CI.cptr d1) (CI.cptr d2) (CI.cptr b1) b2 (CI.cptr p)

let srot ~n ~x ~incx ~y ~incy ~c ~s =
  cblas_srot n (CI.cptr x) incx (CI.cptr y) incy c s

let srotm ~n ~x ~incx ~y ~incy ~p =
  cblas_srotm n (CI.cptr x) incx (CI.cptr y) incy (CI.cptr p)

let drotg ~a ~b ~c ~s =
  cblas_drotg (CI.cptr a) (CI.cptr b) (CI.cptr c) (CI.cptr s)

let drotmg ~d1 ~d2 ~b1 ~b2 ~p =
  cblas_drotmg (CI.cptr d1) (CI.cptr d2) (CI.cptr b1) b2 (CI.cptr p)

let drot ~n ~x ~incx ~y ~incy ~c ~s =
  cblas_drot n (CI.cptr x) incx (CI.cptr y) incy c s

let drotm ~n ~x ~incx ~y ~incy ~p =
  cblas_drotm n (CI.cptr x) incx (CI.cptr y) incy (CI.cptr p)

let sscal ~n ~alpha ~x ~incx =
  cblas_sscal n alpha (CI.cptr x) incx

let dscal ~n ~alpha ~x ~incx =
  cblas_dscal n alpha (CI.cptr x) incx

let cscal ~n ~alpha ~x ~incx =
  cblas_cscal n (CI.cptr alpha) (CI.cptr x) incx

let zscal ~n ~alpha ~x ~incx =
  cblas_zscal n (CI.cptr alpha) (CI.cptr x) incx

let csscal ~n ~alpha ~x ~incx =
  cblas_csscal n alpha (CI.cptr x) incx

let zdscal ~n ~alpha ~x ~incx =
  cblas_zdscal n alpha (CI.cptr x) incx

let sgemv ~order ~transa ~m ~n ~alpha ~a ~lda ~x ~incx ~beta ~y ~incy =
  cblas_sgemv order transa m n alpha (CI.cptr a) lda (CI.cptr x) incx beta (CI.cptr y) incy

let sgbmv ~order ~transa ~m ~n ~kl ~ku ~alpha ~a ~lda ~x ~incx ~beta ~y ~incy =
  cblas_sgbmv order transa m n kl ku alpha (CI.cptr a) lda (CI.cptr x) incx beta (CI.cptr y) incy

let strmv ~order ~uplo ~transa ~diag ~n ~a ~lda ~x ~incx =
  cblas_strmv order uplo transa diag n (CI.cptr a) lda (CI.cptr x) incx

let stbmv ~order ~uplo ~transa ~diag ~n ~k ~a ~lda ~x ~incx =
  cblas_stbmv order uplo transa diag n k (CI.cptr a) lda (CI.cptr x) incx

let stpmv ~order ~uplo ~transa ~diag ~n ~ap ~x ~incx =
  cblas_stpmv order uplo transa diag n (CI.cptr ap) (CI.cptr x) incx

let strsv ~order ~uplo ~transa ~diag ~n ~a ~lda ~x ~incx =
  cblas_strsv order uplo transa diag n (CI.cptr a) lda (CI.cptr x) incx

let stbsv ~order ~uplo ~transa ~diag ~n ~k ~a ~lda ~x ~incx =
  cblas_stbsv order uplo transa diag n k (CI.cptr a) lda (CI.cptr x) incx

let stpsv ~order ~uplo ~transa ~diag ~n ~ap ~x ~incx =
  cblas_stpsv order uplo transa diag n (CI.cptr ap) (CI.cptr x) incx

let dgemv ~order ~transa ~m ~n ~alpha ~a ~lda ~x ~incx ~beta ~y ~incy =
  cblas_dgemv order transa m n alpha (CI.cptr a) lda (CI.cptr x) incx beta (CI.cptr y) incy

let dgbmv ~order ~transa ~m ~n ~kl ~ku ~alpha ~a ~lda ~x ~incx ~beta ~y ~incy =
  cblas_dgbmv order transa m n kl ku alpha (CI.cptr a) lda (CI.cptr x) incx beta (CI.cptr y) incy

let dtrmv ~order ~uplo ~transa ~diag ~n ~a ~lda ~x ~incx =
  cblas_dtrmv order uplo transa diag n (CI.cptr a) lda (CI.cptr x) incx

let dtbmv ~order ~uplo ~transa ~diag ~n ~k ~a ~lda ~x ~incx =
  cblas_dtbmv order uplo transa diag n k (CI.cptr a) lda (CI.cptr x) incx

let dtpmv ~order ~uplo ~transa ~diag ~n ~ap ~x ~incx =
  cblas_dtpmv order uplo transa diag n (CI.cptr ap) (CI.cptr x) incx

let dtrsv ~order ~uplo ~transa ~diag ~n ~a ~lda ~x ~incx =
  cblas_dtrsv order uplo transa diag n (CI.cptr a) lda (CI.cptr x) incx

let dtbsv ~order ~uplo ~transa ~diag ~n ~k ~a ~lda ~x ~incx =
  cblas_dtbsv order uplo transa diag n k (CI.cptr a) lda (CI.cptr x) incx

let dtpsv ~order ~uplo ~transa ~diag ~n ~ap ~x ~incx =
  cblas_dtpsv order uplo transa diag n (CI.cptr ap) (CI.cptr x) incx

let cgemv ~order ~transa ~m ~n ~alpha ~a ~lda ~x ~incx ~beta ~y ~incy =
  cblas_cgemv order transa m n (CI.cptr alpha) (CI.cptr a) lda (CI.cptr x) incx (CI.cptr beta) (CI.cptr y) incy

let cgbmv ~order ~transa ~m ~n ~kl ~ku ~alpha ~a ~lda ~x ~incx ~beta ~y ~incy =
  cblas_cgbmv order transa m n kl ku (CI.cptr alpha) (CI.cptr a) lda (CI.cptr x) incx (CI.cptr beta) (CI.cptr y) incy

let ctrmv ~order ~uplo ~transa ~diag ~n ~a ~lda ~x ~incx =
  cblas_ctrmv order uplo transa diag n (CI.cptr a) lda (CI.cptr x) incx

let ctbmv ~order ~uplo ~transa ~diag ~n ~k ~a ~lda ~x ~incx =
  cblas_ctbmv order uplo transa diag n k (CI.cptr a) lda (CI.cptr x) incx

let ctpmv ~order ~uplo ~transa ~diag ~n ~ap ~x ~incx =
  cblas_ctpmv order uplo transa diag n (CI.cptr ap) (CI.cptr x) incx

let ctrsv ~order ~uplo ~transa ~diag ~n ~a ~lda ~x ~incx =
  cblas_ctrsv order uplo transa diag n (CI.cptr a) lda (CI.cptr x) incx

let ctbsv ~order ~uplo ~transa ~diag ~n ~k ~a ~lda ~x ~incx =
  cblas_ctbsv order uplo transa diag n k (CI.cptr a) lda (CI.cptr x) incx

let ctpsv ~order ~uplo ~transa ~diag ~n ~ap ~x ~incx =
  cblas_ctpsv order uplo transa diag n (CI.cptr ap) (CI.cptr x) incx

let zgemv ~order ~transa ~m ~n ~alpha ~a ~lda ~x ~incx ~beta ~y ~incy =
  cblas_zgemv order transa m n (CI.cptr alpha) (CI.cptr a) lda (CI.cptr x) incx (CI.cptr beta) (CI.cptr y) incy

let zgbmv ~order ~transa ~m ~n ~kl ~ku ~alpha ~a ~lda ~x ~incx ~beta ~y ~incy =
  cblas_zgbmv order transa m n kl ku (CI.cptr alpha) (CI.cptr a) lda (CI.cptr x) incx (CI.cptr beta) (CI.cptr y) incy

let ztrmv ~order ~uplo ~transa ~diag ~n ~a ~lda ~x ~incx =
  cblas_ztrmv order uplo transa diag n (CI.cptr a) lda (CI.cptr x) incx

let ztbmv ~order ~uplo ~transa ~diag ~n ~k ~a ~lda ~x ~incx =
  cblas_ztbmv order uplo transa diag n k (CI.cptr a) lda (CI.cptr x) incx

let ztpmv ~order ~uplo ~transa ~diag ~n ~ap ~x ~incx =
  cblas_ztpmv order uplo transa diag n (CI.cptr ap) (CI.cptr x) incx

let ztrsv ~order ~uplo ~transa ~diag ~n ~a ~lda ~x ~incx =
  cblas_ztrsv order uplo transa diag n (CI.cptr a) lda (CI.cptr x) incx

let ztbsv ~order ~uplo ~transa ~diag ~n ~k ~a ~lda ~x ~incx =
  cblas_ztbsv order uplo transa diag n k (CI.cptr a) lda (CI.cptr x) incx

let ztpsv ~order ~uplo ~transa ~diag ~n ~ap ~x ~incx =
  cblas_ztpsv order uplo transa diag n (CI.cptr ap) (CI.cptr x) incx

let ssymv ~order ~uplo ~n ~alpha ~a ~lda ~x ~incx ~beta ~y ~incy =
  cblas_ssymv order uplo n alpha (CI.cptr a) lda (CI.cptr x) incx beta (CI.cptr y) incy

let ssbmv ~order ~uplo ~n ~k ~alpha ~a ~lda ~x ~incx ~beta ~y ~incy =
  cblas_ssbmv order uplo n k alpha (CI.cptr a) lda (CI.cptr x) incx beta (CI.cptr y) incy

let sspmv ~order ~uplo ~n ~alpha ~ap ~x ~incx ~beta ~y ~incy =
  cblas_sspmv order uplo n alpha (CI.cptr ap) (CI.cptr x) incx beta (CI.cptr y) incy

let sger ~order ~m ~n ~alpha ~x ~incx ~y ~incy ~a ~lda =
  cblas_sger order m n alpha (CI.cptr x) incx (CI.cptr y) incy (CI.cptr a) lda

let ssyr ~order ~uplo ~n ~alpha ~x ~incx ~a ~lda =
  cblas_ssyr order uplo n alpha (CI.cptr x) incx (CI.cptr a) lda

let sspr ~order ~uplo ~n ~alpha ~x ~incx ~ap =
  cblas_sspr order uplo n alpha (CI.cptr x) incx (CI.cptr ap)

let ssyr2 ~order ~uplo ~n ~alpha ~x ~incx ~y ~incy ~a ~lda =
  cblas_ssyr2 order uplo n alpha (CI.cptr x) incx (CI.cptr y) incy (CI.cptr a) lda

let sspr2 ~order ~uplo ~n ~alpha ~x ~incx ~y ~incy ~a =
  cblas_sspr2 order uplo n alpha (CI.cptr x) incx (CI.cptr y) incy (CI.cptr a)

let dsymv ~order ~uplo ~n ~alpha ~a ~lda ~x ~incx ~beta ~y ~incy =
  cblas_dsymv order uplo n alpha (CI.cptr a) lda (CI.cptr x) incx beta (CI.cptr y) incy

let dsbmv ~order ~uplo ~n ~k ~alpha ~a ~lda ~x ~incx ~beta ~y ~incy =
  cblas_dsbmv order uplo n k alpha (CI.cptr a) lda (CI.cptr x) incx beta (CI.cptr y) incy

let dspmv ~order ~uplo ~n ~alpha ~ap ~x ~incx ~beta ~y ~incy =
  cblas_dspmv order uplo n alpha (CI.cptr ap) (CI.cptr x) incx beta (CI.cptr y) incy

let dger ~order ~m ~n ~alpha ~x ~incx ~y ~incy ~a ~lda =
  cblas_dger order m n alpha (CI.cptr x) incx (CI.cptr y) incy (CI.cptr a) lda

let dsyr ~order ~uplo ~n ~alpha ~x ~incx ~a ~lda =
  cblas_dsyr order uplo n alpha (CI.cptr x) incx (CI.cptr a) lda

let dspr ~order ~uplo ~n ~alpha ~x ~incx ~ap =
  cblas_dspr order uplo n alpha (CI.cptr x) incx (CI.cptr ap)

let dsyr2 ~order ~uplo ~n ~alpha ~x ~incx ~y ~incy ~a ~lda =
  cblas_dsyr2 order uplo n alpha (CI.cptr x) incx (CI.cptr y) incy (CI.cptr a) lda

let dspr2 ~order ~uplo ~n ~alpha ~x ~incx ~y ~incy ~a =
  cblas_dspr2 order uplo n alpha (CI.cptr x) incx (CI.cptr y) incy (CI.cptr a)

let chemv ~order ~uplo ~n ~alpha ~a ~lda ~x ~incx ~beta ~y ~incy =
  cblas_chemv order uplo n (CI.cptr alpha) (CI.cptr a) lda (CI.cptr x) incx (CI.cptr beta) (CI.cptr y) incy

let chbmv ~order ~uplo ~n ~k ~alpha ~a ~lda ~x ~incx ~beta ~y ~incy =
  cblas_chbmv order uplo n k (CI.cptr alpha) (CI.cptr a) lda (CI.cptr x) incx (CI.cptr beta) (CI.cptr y) incy

let chpmv ~order ~uplo ~n ~alpha ~ap ~x ~incx ~beta ~y ~incy =
  cblas_chpmv order uplo n (CI.cptr alpha) (CI.cptr ap) (CI.cptr x) incx (CI.cptr beta) (CI.cptr y) incy

let cgeru ~order ~m ~n ~alpha ~x ~incx ~y ~incy ~a ~lda =
  cblas_cgeru order m n (CI.cptr alpha) (CI.cptr x) incx (CI.cptr y) incy (CI.cptr a) lda

let cgerc ~order ~m ~n ~alpha ~x ~incx ~y ~incy ~a ~lda =
  cblas_cgerc order m n (CI.cptr alpha) (CI.cptr x) incx (CI.cptr y) incy (CI.cptr a) lda

let cher ~order ~uplo ~n ~alpha ~x ~incx ~a ~lda =
  cblas_cher order uplo n alpha (CI.cptr x) incx (CI.cptr a) lda

let chpr ~order ~uplo ~n ~alpha ~x ~incx ~a =
  cblas_chpr order uplo n alpha (CI.cptr x) incx (CI.cptr a)

let cher2 ~order ~uplo ~n ~alpha ~x ~incx ~y ~incy ~a ~lda =
  cblas_cher2 order uplo n (CI.cptr alpha) (CI.cptr x) incx (CI.cptr y) incy (CI.cptr a) lda

let chpr2 ~order ~uplo ~n ~alpha ~x ~incx ~y ~incy ~ap =
  cblas_chpr2 order uplo n (CI.cptr alpha) (CI.cptr x) incx (CI.cptr y) incy (CI.cptr ap)

let zhemv ~order ~uplo ~n ~alpha ~a ~lda ~x ~incx ~beta ~y ~incy =
  cblas_zhemv order uplo n (CI.cptr alpha) (CI.cptr a) lda (CI.cptr x) incx (CI.cptr beta) (CI.cptr y) incy

let zhbmv ~order ~uplo ~n ~k ~alpha ~a ~lda ~x ~incx ~beta ~y ~incy =
  cblas_zhbmv order uplo n k (CI.cptr alpha) (CI.cptr a) lda (CI.cptr x) incx (CI.cptr beta) (CI.cptr y) incy

let zhpmv ~order ~uplo ~n ~alpha ~ap ~x ~incx ~beta ~y ~incy =
  cblas_zhpmv order uplo n (CI.cptr alpha) (CI.cptr ap) (CI.cptr x) incx (CI.cptr beta) (CI.cptr y) incy

let zgeru ~order ~m ~n ~alpha ~x ~incx ~y ~incy ~a ~lda =
  cblas_zgeru order m n (CI.cptr alpha) (CI.cptr x) incx (CI.cptr y) incy (CI.cptr a) lda

let zgerc ~order ~m ~n ~alpha ~x ~incx ~y ~incy ~a ~lda =
  cblas_zgerc order m n (CI.cptr alpha) (CI.cptr x) incx (CI.cptr y) incy (CI.cptr a) lda

let zher ~order ~uplo ~n ~alpha ~x ~incx ~a ~lda =
  cblas_zher order uplo n alpha (CI.cptr x) incx (CI.cptr a) lda

let zhpr ~order ~uplo ~n ~alpha ~x ~incx ~a =
  cblas_zhpr order uplo n alpha (CI.cptr x) incx (CI.cptr a)

let zher2 ~order ~uplo ~n ~alpha ~x ~incx ~y ~incy ~a ~lda =
  cblas_zher2 order uplo n (CI.cptr alpha) (CI.cptr x) incx (CI.cptr y) incy (CI.cptr a) lda

let zhpr2 ~order ~uplo ~n ~alpha ~x ~incx ~y ~incy ~ap =
  cblas_zhpr2 order uplo n (CI.cptr alpha) (CI.cptr x) incx (CI.cptr y) incy (CI.cptr ap)

let sgemm ~order ~transa ~transb ~m ~n ~k ~alpha ~a ~lda ~b ~ldb ~beta ~c ~ldc =
  cblas_sgemm order transa transb m n k alpha (CI.cptr a) lda (CI.cptr b) ldb beta (CI.cptr c) ldc

let ssymm ~order ~side ~uplo ~m ~n ~alpha ~a ~lda ~b ~ldb ~beta ~c ~ldc =
  cblas_ssymm order side uplo m n alpha (CI.cptr a) lda (CI.cptr b) ldb beta (CI.cptr c) ldc

let ssyrk ~order ~uplo ~trans ~n ~k ~alpha ~a ~lda ~beta ~c ~ldc =
  cblas_ssyrk order uplo trans n k alpha (CI.cptr a) lda beta (CI.cptr c) ldc

let ssyr2k ~order ~uplo ~trans ~n ~k ~alpha ~a ~lda ~b ~ldb ~beta ~c ~ldc =
  cblas_ssyr2k order uplo trans n k alpha (CI.cptr a) lda (CI.cptr b) ldb beta (CI.cptr c) ldc

let strmm ~order ~side ~uplo ~transa ~diag ~m ~n ~alpha ~a ~lda ~b ~ldb =
  cblas_strmm order side uplo transa diag m n alpha (CI.cptr a) lda (CI.cptr b) ldb

let strsm ~order ~side ~uplo ~transa ~diag ~m ~n ~alpha ~a ~lda ~b ~ldb =
  cblas_strsm order side uplo transa diag m n alpha (CI.cptr a) lda (CI.cptr b) ldb

let dgemm ~order ~transa ~transb ~m ~n ~k ~alpha ~a ~lda ~b ~ldb ~beta ~c ~ldc =
  cblas_dgemm order transa transb m n k alpha (CI.cptr a) lda (CI.cptr b) ldb beta (CI.cptr c) ldc

let dsymm ~order ~side ~uplo ~m ~n ~alpha ~a ~lda ~b ~ldb ~beta ~c ~ldc =
  cblas_dsymm order side uplo m n alpha (CI.cptr a) lda (CI.cptr b) ldb beta (CI.cptr c) ldc

let dsyrk ~order ~uplo ~trans ~n ~k ~alpha ~a ~lda ~beta ~c ~ldc =
  cblas_dsyrk order uplo trans n k alpha (CI.cptr a) lda beta (CI.cptr c) ldc

let dsyr2k ~order ~uplo ~trans ~n ~k ~alpha ~a ~lda ~b ~ldb ~beta ~c ~ldc =
  cblas_dsyr2k order uplo trans n k alpha (CI.cptr a) lda (CI.cptr b) ldb beta (CI.cptr c) ldc

let dtrmm ~order ~side ~uplo ~transa ~diag ~m ~n ~alpha ~a ~lda ~b ~ldb =
  cblas_dtrmm order side uplo transa diag m n alpha (CI.cptr a) lda (CI.cptr b) ldb

let dtrsm ~order ~side ~uplo ~transa ~diag ~m ~n ~alpha ~a ~lda ~b ~ldb =
  cblas_dtrsm order side uplo transa diag m n alpha (CI.cptr a) lda (CI.cptr b) ldb

let cgemm ~order ~transa ~transb ~m ~n ~k ~alpha ~a ~lda ~b ~ldb ~beta ~c ~ldc =
  cblas_cgemm order transa transb m n k (CI.cptr alpha) (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr beta) (CI.cptr c) ldc

let csymm ~order ~side ~uplo ~m ~n ~alpha ~a ~lda ~b ~ldb ~beta ~c ~ldc =
  cblas_csymm order side uplo m n (CI.cptr alpha) (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr beta) (CI.cptr c) ldc

let csyrk ~order ~uplo ~trans ~n ~k ~alpha ~a ~lda ~beta ~c ~ldc =
  cblas_csyrk order uplo trans n k (CI.cptr alpha) (CI.cptr a) lda (CI.cptr beta) (CI.cptr c) ldc

let csyr2k ~order ~uplo ~trans ~n ~k ~alpha ~a ~lda ~b ~ldb ~beta ~c ~ldc =
  cblas_csyr2k order uplo trans n k (CI.cptr alpha) (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr beta) (CI.cptr c) ldc

let ctrmm ~order ~side ~uplo ~transa ~diag ~m ~n ~alpha ~a ~lda ~b ~ldb =
  cblas_ctrmm order side uplo transa diag m n (CI.cptr alpha) (CI.cptr a) lda (CI.cptr b) ldb

let ctrsm ~order ~side ~uplo ~transa ~diag ~m ~n ~alpha ~a ~lda ~b ~ldb =
  cblas_ctrsm order side uplo transa diag m n (CI.cptr alpha) (CI.cptr a) lda (CI.cptr b) ldb

let zgemm ~order ~transa ~transb ~m ~n ~k ~alpha ~a ~lda ~b ~ldb ~beta ~c ~ldc =
  cblas_zgemm order transa transb m n k (CI.cptr alpha) (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr beta) (CI.cptr c) ldc

let zsymm ~order ~side ~uplo ~m ~n ~alpha ~a ~lda ~b ~ldb ~beta ~c ~ldc =
  cblas_zsymm order side uplo m n (CI.cptr alpha) (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr beta) (CI.cptr c) ldc

let zsyrk ~order ~uplo ~trans ~n ~k ~alpha ~a ~lda ~beta ~c ~ldc =
  cblas_zsyrk order uplo trans n k (CI.cptr alpha) (CI.cptr a) lda (CI.cptr beta) (CI.cptr c) ldc

let zsyr2k ~order ~uplo ~trans ~n ~k ~alpha ~a ~lda ~b ~ldb ~beta ~c ~ldc =
  cblas_zsyr2k order uplo trans n k (CI.cptr alpha) (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr beta) (CI.cptr c) ldc

let ztrmm ~order ~side ~uplo ~transa ~diag ~m ~n ~alpha ~a ~lda ~b ~ldb =
  cblas_ztrmm order side uplo transa diag m n (CI.cptr alpha) (CI.cptr a) lda (CI.cptr b) ldb

let ztrsm ~order ~side ~uplo ~transa ~diag ~m ~n ~alpha ~a ~lda ~b ~ldb =
  cblas_ztrsm order side uplo transa diag m n (CI.cptr alpha) (CI.cptr a) lda (CI.cptr b) ldb

let chemm ~order ~side ~uplo ~m ~n ~alpha ~a ~lda ~b ~ldb ~beta ~c ~ldc =
  cblas_chemm order side uplo m n (CI.cptr alpha) (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr beta) (CI.cptr c) ldc

let cherk ~order ~uplo ~trans ~n ~k ~alpha ~a ~lda ~beta ~c ~ldc =
  cblas_cherk order uplo trans n k alpha (CI.cptr a) lda beta (CI.cptr c) ldc

let cher2k ~order ~uplo ~trans ~n ~k ~alpha ~a ~lda ~b ~ldb ~beta ~c ~ldc =
  cblas_cher2k order uplo trans n k (CI.cptr alpha) (CI.cptr a) lda (CI.cptr b) ldb beta (CI.cptr c) ldc

let zhemm ~order ~side ~uplo ~m ~n ~alpha ~a ~lda ~b ~ldb ~beta ~c ~ldc =
  cblas_zhemm order side uplo m n (CI.cptr alpha) (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr beta) (CI.cptr c) ldc

let zherk ~order ~uplo ~trans ~n ~k ~alpha ~a ~lda ~beta ~c ~ldc =
  cblas_zherk order uplo trans n k alpha (CI.cptr a) lda beta (CI.cptr c) ldc

let zher2k ~order ~uplo ~trans ~n ~k ~alpha ~a ~lda ~b ~ldb ~beta ~c ~ldc =
  cblas_zher2k order uplo trans n k (CI.cptr alpha) (CI.cptr a) lda (CI.cptr b) ldb beta (CI.cptr c) ldc

