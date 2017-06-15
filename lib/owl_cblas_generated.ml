module CI = Cstubs_internals

external owl_stub_1_cblas_srotg
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> unit
  = "owl_stub_1_cblas_srotg"

external owl_stub_2_cblas_drotg
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> unit
  = "owl_stub_2_cblas_drotg"

external owl_stub_3_cblas_srotmg
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> float -> _ CI.fatptr -> unit
  = "owl_stub_3_cblas_srotmg"

external owl_stub_4_cblas_drotmg
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> float -> _ CI.fatptr -> unit
  = "owl_stub_4_cblas_drotmg"

external owl_stub_5_cblas_srot
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> unit
  = "owl_stub_5_cblas_srot_byte7" "owl_stub_5_cblas_srot"

external owl_stub_6_cblas_drot
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> unit
  = "owl_stub_6_cblas_drot_byte7" "owl_stub_6_cblas_drot"

external owl_stub_7_cblas_sswap
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_7_cblas_sswap"

external owl_stub_8_cblas_dswap
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_8_cblas_dswap"

external owl_stub_9_cblas_cswap
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_9_cblas_cswap"

external owl_stub_10_cblas_zswap
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_10_cblas_zswap"

external owl_stub_11_cblas_sscal : int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_11_cblas_sscal"

external owl_stub_12_cblas_dscal : int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_12_cblas_dscal"

external owl_stub_13_cblas_cscal
  : int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_13_cblas_cscal"

external owl_stub_14_cblas_zscal
  : int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_14_cblas_zscal"

external owl_stub_15_cblas_csscal
  : int -> float -> _ CI.fatptr -> int -> unit = "owl_stub_15_cblas_csscal"

external owl_stub_16_cblas_zdscal
  : int -> float -> _ CI.fatptr -> int -> unit = "owl_stub_16_cblas_zdscal"

external owl_stub_17_cblas_scopy
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_17_cblas_scopy"

external owl_stub_18_cblas_dcopy
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_18_cblas_dcopy"

external owl_stub_19_cblas_ccopy
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_19_cblas_ccopy"

external owl_stub_20_cblas_zcopy
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_20_cblas_zcopy"

external owl_stub_21_cblas_saxpy
  : int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_21_cblas_saxpy_byte6" "owl_stub_21_cblas_saxpy"

external owl_stub_22_cblas_daxpy
  : int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_22_cblas_daxpy_byte6" "owl_stub_22_cblas_daxpy"

external owl_stub_23_cblas_caxpy
  : int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_23_cblas_caxpy_byte6" "owl_stub_23_cblas_caxpy"

external owl_stub_24_cblas_zaxpy
  : int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_24_cblas_zaxpy_byte6" "owl_stub_24_cblas_zaxpy"

external owl_stub_25_cblas_sdot
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float
  = "owl_stub_25_cblas_sdot"

external owl_stub_26_cblas_ddot
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float
  = "owl_stub_26_cblas_ddot"

external owl_stub_27_cblas_sdsdot
  : int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float
  = "owl_stub_27_cblas_sdsdot_byte6" "owl_stub_27_cblas_sdsdot"

external owl_stub_28_cblas_dsdot
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float
  = "owl_stub_28_cblas_dsdot"

external owl_stub_29_cblas_cdotu_sub
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "owl_stub_29_cblas_cdotu_sub_byte6" "owl_stub_29_cblas_cdotu_sub"

external owl_stub_30_cblas_cdotc_sub
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "owl_stub_30_cblas_cdotc_sub_byte6" "owl_stub_30_cblas_cdotc_sub"

external owl_stub_31_cblas_zdotu_sub
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "owl_stub_31_cblas_zdotu_sub_byte6" "owl_stub_31_cblas_zdotu_sub"

external owl_stub_32_cblas_zdotc_sub
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "owl_stub_32_cblas_zdotc_sub_byte6" "owl_stub_32_cblas_zdotc_sub"

external owl_stub_33_cblas_snrm2 : int -> _ CI.fatptr -> int -> float
  = "owl_stub_33_cblas_snrm2"

external owl_stub_34_cblas_dnrm2 : int -> _ CI.fatptr -> int -> float
  = "owl_stub_34_cblas_dnrm2"

external owl_stub_35_cblas_scnrm2 : int -> _ CI.fatptr -> int -> float
  = "owl_stub_35_cblas_scnrm2"

external owl_stub_36_cblas_dznrm2 : int -> _ CI.fatptr -> int -> float
  = "owl_stub_36_cblas_dznrm2"

external owl_stub_37_cblas_sasum : int -> _ CI.fatptr -> int -> float
  = "owl_stub_37_cblas_sasum"

external owl_stub_38_cblas_dasum : int -> _ CI.fatptr -> int -> float
  = "owl_stub_38_cblas_dasum"

external owl_stub_39_cblas_scasum : int -> _ CI.fatptr -> int -> float
  = "owl_stub_39_cblas_scasum"

external owl_stub_40_cblas_dzasum : int -> _ CI.fatptr -> int -> float
  = "owl_stub_40_cblas_dzasum"

external owl_stub_41_cblas_isamax
  : int -> _ CI.fatptr -> int -> Unsigned.size_t = "owl_stub_41_cblas_isamax"

external owl_stub_42_cblas_idamax
  : int -> _ CI.fatptr -> int -> Unsigned.size_t = "owl_stub_42_cblas_idamax"

external owl_stub_43_cblas_icamax
  : int -> _ CI.fatptr -> int -> Unsigned.size_t = "owl_stub_43_cblas_icamax"

external owl_stub_44_cblas_izamax
  : int -> _ CI.fatptr -> int -> Unsigned.size_t = "owl_stub_44_cblas_izamax"

external owl_stub_45_cblas_sgemv
  : int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_45_cblas_sgemv_byte12" "owl_stub_45_cblas_sgemv"

external owl_stub_46_cblas_dgemv
  : int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_46_cblas_dgemv_byte12" "owl_stub_46_cblas_dgemv"

external owl_stub_47_cblas_cgemv
  : int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int ->
    _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_47_cblas_cgemv_byte12" "owl_stub_47_cblas_cgemv"

external owl_stub_48_cblas_zgemv
  : int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int ->
    _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_48_cblas_zgemv_byte12" "owl_stub_48_cblas_zgemv"

external owl_stub_49_cblas_sgbmv
  : int -> int -> int -> int -> int -> int -> float -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_49_cblas_sgbmv_byte14" "owl_stub_49_cblas_sgbmv"

external owl_stub_50_cblas_dgbmv
  : int -> int -> int -> int -> int -> int -> float -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_50_cblas_dgbmv_byte14" "owl_stub_50_cblas_dgbmv"

external owl_stub_51_cblas_cgbmv
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_51_cblas_cgbmv_byte14" "owl_stub_51_cblas_cgbmv"

external owl_stub_52_cblas_zgbmv
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_52_cblas_zgbmv_byte14" "owl_stub_52_cblas_zgbmv"

external owl_stub_53_cblas_strmv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> unit = "owl_stub_53_cblas_strmv_byte9" "owl_stub_53_cblas_strmv"

external owl_stub_54_cblas_dtrmv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> unit = "owl_stub_54_cblas_dtrmv_byte9" "owl_stub_54_cblas_dtrmv"

external owl_stub_55_cblas_ctrmv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> unit = "owl_stub_55_cblas_ctrmv_byte9" "owl_stub_55_cblas_ctrmv"

external owl_stub_56_cblas_ztrmv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> unit = "owl_stub_56_cblas_ztrmv_byte9" "owl_stub_56_cblas_ztrmv"

external owl_stub_57_cblas_stbmv
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> int ->
    _ CI.fatptr -> int -> unit
  = "owl_stub_57_cblas_stbmv_byte10" "owl_stub_57_cblas_stbmv"

external owl_stub_58_cblas_dtbmv
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> int ->
    _ CI.fatptr -> int -> unit
  = "owl_stub_58_cblas_dtbmv_byte10" "owl_stub_58_cblas_dtbmv"

external owl_stub_59_cblas_ctbmv
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> int ->
    _ CI.fatptr -> int -> unit
  = "owl_stub_59_cblas_ctbmv_byte10" "owl_stub_59_cblas_ctbmv"

external owl_stub_60_cblas_ztbmv
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> int ->
    _ CI.fatptr -> int -> unit
  = "owl_stub_60_cblas_ztbmv_byte10" "owl_stub_60_cblas_ztbmv"

external owl_stub_61_cblas_stpmv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> unit = "owl_stub_61_cblas_stpmv_byte8" "owl_stub_61_cblas_stpmv"

external owl_stub_62_cblas_dtpmv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> unit = "owl_stub_62_cblas_dtpmv_byte8" "owl_stub_62_cblas_dtpmv"

external owl_stub_63_cblas_ctpmv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> unit = "owl_stub_63_cblas_ctpmv_byte8" "owl_stub_63_cblas_ctpmv"

external owl_stub_64_cblas_ztpmv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> unit = "owl_stub_64_cblas_ztpmv_byte8" "owl_stub_64_cblas_ztpmv"

external owl_stub_65_cblas_strsv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> unit = "owl_stub_65_cblas_strsv_byte9" "owl_stub_65_cblas_strsv"

external owl_stub_66_cblas_dtrsv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> unit = "owl_stub_66_cblas_dtrsv_byte9" "owl_stub_66_cblas_dtrsv"

external owl_stub_67_cblas_ctrsv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> unit = "owl_stub_67_cblas_ctrsv_byte9" "owl_stub_67_cblas_ctrsv"

external owl_stub_68_cblas_ztrsv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> unit = "owl_stub_68_cblas_ztrsv_byte9" "owl_stub_68_cblas_ztrsv"

external owl_stub_69_cblas_stbsv
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> int ->
    _ CI.fatptr -> int -> unit
  = "owl_stub_69_cblas_stbsv_byte10" "owl_stub_69_cblas_stbsv"

external owl_stub_70_cblas_dtbsv
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> int ->
    _ CI.fatptr -> int -> unit
  = "owl_stub_70_cblas_dtbsv_byte10" "owl_stub_70_cblas_dtbsv"

external owl_stub_71_cblas_ctbsv
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> int ->
    _ CI.fatptr -> int -> unit
  = "owl_stub_71_cblas_ctbsv_byte10" "owl_stub_71_cblas_ctbsv"

external owl_stub_72_cblas_ztbsv
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> int ->
    _ CI.fatptr -> int -> unit
  = "owl_stub_72_cblas_ztbsv_byte10" "owl_stub_72_cblas_ztbsv"

external owl_stub_73_cblas_stpsv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> unit = "owl_stub_73_cblas_stpsv_byte8" "owl_stub_73_cblas_stpsv"

external owl_stub_74_cblas_dtpsv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> unit = "owl_stub_74_cblas_dtpsv_byte8" "owl_stub_74_cblas_dtpsv"

external owl_stub_75_cblas_ctpsv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> unit = "owl_stub_75_cblas_ctpsv_byte8" "owl_stub_75_cblas_ctpsv"

external owl_stub_76_cblas_ztpsv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> unit = "owl_stub_76_cblas_ztpsv_byte8" "owl_stub_76_cblas_ztpsv"

external owl_stub_77_cblas_ssymv
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_77_cblas_ssymv_byte11" "owl_stub_77_cblas_ssymv"

external owl_stub_78_cblas_dsymv
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_78_cblas_dsymv_byte11" "owl_stub_78_cblas_dsymv"

external owl_stub_79_cblas_ssbmv
  : int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_79_cblas_ssbmv_byte12" "owl_stub_79_cblas_ssbmv"

external owl_stub_80_cblas_dsbmv
  : int -> int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_80_cblas_dsbmv_byte12" "owl_stub_80_cblas_dsbmv"

external owl_stub_81_cblas_sspmv
  : int -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> int ->
    float -> _ CI.fatptr -> int -> unit
  = "owl_stub_81_cblas_sspmv_byte10" "owl_stub_81_cblas_sspmv"

external owl_stub_82_cblas_dspmv
  : int -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> int ->
    float -> _ CI.fatptr -> int -> unit
  = "owl_stub_82_cblas_dspmv_byte10" "owl_stub_82_cblas_dspmv"

external owl_stub_83_cblas_sger
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> unit
  = "owl_stub_83_cblas_sger_byte10" "owl_stub_83_cblas_sger"

external owl_stub_84_cblas_dger
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> unit
  = "owl_stub_84_cblas_dger_byte10" "owl_stub_84_cblas_dger"

external owl_stub_85_cblas_ssyr
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> unit = "owl_stub_85_cblas_ssyr_byte8" "owl_stub_85_cblas_ssyr"

external owl_stub_86_cblas_dsyr
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> unit = "owl_stub_86_cblas_dsyr_byte8" "owl_stub_86_cblas_dsyr"

external owl_stub_87_cblas_sspr
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "owl_stub_87_cblas_sspr_byte7" "owl_stub_87_cblas_sspr"

external owl_stub_88_cblas_dspr
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "owl_stub_88_cblas_dspr_byte7" "owl_stub_88_cblas_dspr"

external owl_stub_89_cblas_ssyr2
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> unit
  = "owl_stub_89_cblas_ssyr2_byte10" "owl_stub_89_cblas_ssyr2"

external owl_stub_90_cblas_dsyr2
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> unit
  = "owl_stub_90_cblas_dsyr2_byte10" "owl_stub_90_cblas_dsyr2"

external owl_stub_91_cblas_sspr2
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> _ CI.fatptr -> unit
  = "owl_stub_91_cblas_sspr2_byte9" "owl_stub_91_cblas_sspr2"

external owl_stub_92_cblas_dspr2
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> _ CI.fatptr -> unit
  = "owl_stub_92_cblas_dspr2_byte9" "owl_stub_92_cblas_dspr2"

external owl_stub_93_cblas_chemv
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_93_cblas_chemv_byte11" "owl_stub_93_cblas_chemv"

external owl_stub_94_cblas_zhemv
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_94_cblas_zhemv_byte11" "owl_stub_94_cblas_zhemv"

external owl_stub_95_cblas_chbmv
  : int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int ->
    _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_95_cblas_chbmv_byte12" "owl_stub_95_cblas_chbmv"

external owl_stub_96_cblas_zhbmv
  : int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int ->
    _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_96_cblas_zhbmv_byte12" "owl_stub_96_cblas_zhbmv"

external owl_stub_97_cblas_chpmv
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr ->
    int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_97_cblas_chpmv_byte10" "owl_stub_97_cblas_chpmv"

external owl_stub_98_cblas_zhpmv
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr ->
    int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_98_cblas_zhpmv_byte10" "owl_stub_98_cblas_zhpmv"

external owl_stub_99_cblas_cgeru
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> unit
  = "owl_stub_99_cblas_cgeru_byte10" "owl_stub_99_cblas_cgeru"

external owl_stub_100_cblas_zgeru
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> unit
  = "owl_stub_100_cblas_zgeru_byte10" "owl_stub_100_cblas_zgeru"

external owl_stub_101_cblas_cgerc
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> unit
  = "owl_stub_101_cblas_cgerc_byte10" "owl_stub_101_cblas_cgerc"

external owl_stub_102_cblas_zgerc
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> unit
  = "owl_stub_102_cblas_zgerc_byte10" "owl_stub_102_cblas_zgerc"

external owl_stub_103_cblas_cher
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> unit = "owl_stub_103_cblas_cher_byte8" "owl_stub_103_cblas_cher"

external owl_stub_104_cblas_zher
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> unit = "owl_stub_104_cblas_zher_byte8" "owl_stub_104_cblas_zher"

external owl_stub_105_cblas_chpr
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "owl_stub_105_cblas_chpr_byte7" "owl_stub_105_cblas_chpr"

external owl_stub_106_cblas_zhpr
  : int -> int -> int -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> unit
  = "owl_stub_106_cblas_zhpr_byte7" "owl_stub_106_cblas_zhpr"

external owl_stub_107_cblas_cher2
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> unit
  = "owl_stub_107_cblas_cher2_byte10" "owl_stub_107_cblas_cher2"

external owl_stub_108_cblas_zher2
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> unit
  = "owl_stub_108_cblas_zher2_byte10" "owl_stub_108_cblas_zher2"

external owl_stub_109_cblas_chpr2
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> _ CI.fatptr -> unit
  = "owl_stub_109_cblas_chpr2_byte9" "owl_stub_109_cblas_chpr2"

external owl_stub_110_cblas_zhpr2
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr ->
    int -> _ CI.fatptr -> unit
  = "owl_stub_110_cblas_zhpr2_byte9" "owl_stub_110_cblas_zhpr2"

external owl_stub_111_cblas_sgemm
  : int -> int -> int -> int -> int -> int -> float -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_111_cblas_sgemm_byte14" "owl_stub_111_cblas_sgemm"

external owl_stub_112_cblas_dgemm
  : int -> int -> int -> int -> int -> int -> float -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_112_cblas_dgemm_byte14" "owl_stub_112_cblas_dgemm"

external owl_stub_113_cblas_cgemm
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_113_cblas_cgemm_byte14" "owl_stub_113_cblas_cgemm"

external owl_stub_114_cblas_zgemm
  : int -> int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_114_cblas_zgemm_byte14" "owl_stub_114_cblas_zgemm"

external owl_stub_115_cblas_ssymm
  : int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int ->
    _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_115_cblas_ssymm_byte13" "owl_stub_115_cblas_ssymm"

external owl_stub_116_cblas_dsymm
  : int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int ->
    _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_116_cblas_dsymm_byte13" "owl_stub_116_cblas_dsymm"

external owl_stub_117_cblas_csymm
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_117_cblas_csymm_byte13" "owl_stub_117_cblas_csymm"

external owl_stub_118_cblas_zsymm
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_118_cblas_zsymm_byte13" "owl_stub_118_cblas_zsymm"

external owl_stub_119_cblas_ssyrk
  : int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int ->
    float -> _ CI.fatptr -> int -> unit
  = "owl_stub_119_cblas_ssyrk_byte11" "owl_stub_119_cblas_ssyrk"

external owl_stub_120_cblas_dsyrk
  : int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int ->
    float -> _ CI.fatptr -> int -> unit
  = "owl_stub_120_cblas_dsyrk_byte11" "owl_stub_120_cblas_dsyrk"

external owl_stub_121_cblas_csyrk
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_121_cblas_csyrk_byte11" "owl_stub_121_cblas_csyrk"

external owl_stub_122_cblas_zsyrk
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_122_cblas_zsyrk_byte11" "owl_stub_122_cblas_zsyrk"

external owl_stub_123_cblas_ssyr2k
  : int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int ->
    _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_123_cblas_ssyr2k_byte13" "owl_stub_123_cblas_ssyr2k"

external owl_stub_124_cblas_dsyr2k
  : int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int ->
    _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_124_cblas_dsyr2k_byte13" "owl_stub_124_cblas_dsyr2k"

external owl_stub_125_cblas_csyr2k
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_125_cblas_csyr2k_byte13" "owl_stub_125_cblas_csyr2k"

external owl_stub_126_cblas_zsyr2k
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_126_cblas_zsyr2k_byte13" "owl_stub_126_cblas_zsyr2k"

external owl_stub_127_cblas_strmm
  : int -> int -> int -> int -> int -> int -> int -> float -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> unit
  = "owl_stub_127_cblas_strmm_byte12" "owl_stub_127_cblas_strmm"

external owl_stub_128_cblas_dtrmm
  : int -> int -> int -> int -> int -> int -> int -> float -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> unit
  = "owl_stub_128_cblas_dtrmm_byte12" "owl_stub_128_cblas_dtrmm"

external owl_stub_129_cblas_ctrmm
  : int -> int -> int -> int -> int -> int -> int -> _ CI.fatptr ->
    _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_129_cblas_ctrmm_byte12" "owl_stub_129_cblas_ctrmm"

external owl_stub_130_cblas_ztrmm
  : int -> int -> int -> int -> int -> int -> int -> _ CI.fatptr ->
    _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_130_cblas_ztrmm_byte12" "owl_stub_130_cblas_ztrmm"

external owl_stub_131_cblas_strsm
  : int -> int -> int -> int -> int -> int -> int -> float -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> unit
  = "owl_stub_131_cblas_strsm_byte12" "owl_stub_131_cblas_strsm"

external owl_stub_132_cblas_dtrsm
  : int -> int -> int -> int -> int -> int -> int -> float -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> unit
  = "owl_stub_132_cblas_dtrsm_byte12" "owl_stub_132_cblas_dtrsm"

external owl_stub_133_cblas_ctrsm
  : int -> int -> int -> int -> int -> int -> int -> _ CI.fatptr ->
    _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_133_cblas_ctrsm_byte12" "owl_stub_133_cblas_ctrsm"

external owl_stub_134_cblas_ztrsm
  : int -> int -> int -> int -> int -> int -> int -> _ CI.fatptr ->
    _ CI.fatptr -> int -> _ CI.fatptr -> int -> unit
  = "owl_stub_134_cblas_ztrsm_byte12" "owl_stub_134_cblas_ztrsm"

external owl_stub_135_cblas_chemm
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_135_cblas_chemm_byte13" "owl_stub_135_cblas_chemm"

external owl_stub_136_cblas_zhemm
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> unit
  = "owl_stub_136_cblas_zhemm_byte13" "owl_stub_136_cblas_zhemm"

external owl_stub_137_cblas_cherk
  : int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int ->
    float -> _ CI.fatptr -> int -> unit
  = "owl_stub_137_cblas_cherk_byte11" "owl_stub_137_cblas_cherk"

external owl_stub_138_cblas_zherk
  : int -> int -> int -> int -> int -> float -> _ CI.fatptr -> int ->
    float -> _ CI.fatptr -> int -> unit
  = "owl_stub_138_cblas_zherk_byte11" "owl_stub_138_cblas_zherk"

external owl_stub_139_cblas_cher2k
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_139_cblas_cher2k_byte13" "owl_stub_139_cblas_cher2k"

external owl_stub_140_cblas_zher2k
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr ->
    int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int -> unit
  = "owl_stub_140_cblas_zher2k_byte13" "owl_stub_140_cblas_zher2k"

type 'a result = 'a
type 'a return = 'a
type 'a fn =
 | Returns  : 'a CI.typ   -> 'a return fn
 | Function : 'a CI.typ * 'b fn  -> ('a -> 'b) fn
let map_result f x = f x
let returning t = Returns t
let (@->) f p = Function (f, p)
let foreign : type a b. string -> (a -> b) fn -> (a -> b) =
  fun name t -> match t, name with
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Primitive CI.Float,
                                   Function
                                     (CI.Pointer _,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_zher2k" ->
  (fun x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 ->
    owl_stub_140_cblas_zher2k x1 x2 x3 x4 x5 (CI.cptr x6) (CI.cptr x7) x8
    (CI.cptr x9) x10 x11 (CI.cptr x12) x13)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Primitive CI.Float,
                                   Function
                                     (CI.Pointer _,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_cher2k" ->
  (fun x14 x15 x16 x17 x18 x19 x20 x21 x22 x23 x24 x25 x26 ->
    owl_stub_139_cblas_cher2k x14 x15 x16 x17 x18 (CI.cptr x19) (CI.cptr x20)
    x21 (CI.cptr x22) x23 x24 (CI.cptr x25) x26)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Double,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Primitive CI.Double,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_zherk" ->
  (fun x27 x28 x29 x30 x31 x32 x33 x34 x35 x36 x37 ->
    owl_stub_138_cblas_zherk x27 x28 x29 x30 x31 x32 (CI.cptr x33) x34 x35
    (CI.cptr x36) x37)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Float,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Primitive CI.Float,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_cherk" ->
  (fun x38 x39 x40 x41 x42 x43 x44 x45 x46 x47 x48 ->
    owl_stub_137_cblas_cherk x38 x39 x40 x41 x42 x43 (CI.cptr x44) x45 x46
    (CI.cptr x47) x48)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Pointer _,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_zhemm" ->
  (fun x49 x50 x51 x52 x53 x54 x55 x56 x57 x58 x59 x60 x61 ->
    owl_stub_136_cblas_zhemm x49 x50 x51 x52 x53 (CI.cptr x54) (CI.cptr x55)
    x56 (CI.cptr x57) x58 (CI.cptr x59) (CI.cptr x60) x61)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Pointer _,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_chemm" ->
  (fun x62 x63 x64 x65 x66 x67 x68 x69 x70 x71 x72 x73 x74 ->
    owl_stub_135_cblas_chemm x62 x63 x64 x65 x66 (CI.cptr x67) (CI.cptr x68)
    x69 (CI.cptr x70) x71 (CI.cptr x72) (CI.cptr x73) x74)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_ztrsm" ->
  (fun x75 x76 x77 x78 x79 x80 x81 x82 x83 x84 x85 x86 ->
    owl_stub_134_cblas_ztrsm x75 x76 x77 x78 x79 x80 x81 (CI.cptr x82)
    (CI.cptr x83) x84 (CI.cptr x85) x86)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_ctrsm" ->
  (fun x87 x88 x89 x90 x91 x92 x93 x94 x95 x96 x97 x98 ->
    owl_stub_133_cblas_ctrsm x87 x88 x89 x90 x91 x92 x93 (CI.cptr x94)
    (CI.cptr x95) x96 (CI.cptr x97) x98)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Primitive CI.Double,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_dtrsm" ->
  (fun x99 x100 x101 x102 x103 x104 x105 x106 x107 x108 x109 x110 ->
    owl_stub_132_cblas_dtrsm x99 x100 x101 x102 x103 x104 x105 x106
    (CI.cptr x107) x108 (CI.cptr x109) x110)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Primitive CI.Float,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_strsm" ->
  (fun x111 x112 x113 x114 x115 x116 x117 x118 x119 x120 x121 x122 ->
    owl_stub_131_cblas_strsm x111 x112 x113 x114 x115 x116 x117 x118
    (CI.cptr x119) x120 (CI.cptr x121) x122)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_ztrmm" ->
  (fun x123 x124 x125 x126 x127 x128 x129 x130 x131 x132 x133 x134 ->
    owl_stub_130_cblas_ztrmm x123 x124 x125 x126 x127 x128 x129
    (CI.cptr x130) (CI.cptr x131) x132 (CI.cptr x133) x134)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_ctrmm" ->
  (fun x135 x136 x137 x138 x139 x140 x141 x142 x143 x144 x145 x146 ->
    owl_stub_129_cblas_ctrmm x135 x136 x137 x138 x139 x140 x141
    (CI.cptr x142) (CI.cptr x143) x144 (CI.cptr x145) x146)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Primitive CI.Double,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_dtrmm" ->
  (fun x147 x148 x149 x150 x151 x152 x153 x154 x155 x156 x157 x158 ->
    owl_stub_128_cblas_dtrmm x147 x148 x149 x150 x151 x152 x153 x154
    (CI.cptr x155) x156 (CI.cptr x157) x158)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Primitive CI.Float,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_strmm" ->
  (fun x159 x160 x161 x162 x163 x164 x165 x166 x167 x168 x169 x170 ->
    owl_stub_127_cblas_strmm x159 x160 x161 x162 x163 x164 x165 x166
    (CI.cptr x167) x168 (CI.cptr x169) x170)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Pointer _,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_zsyr2k" ->
  (fun x171 x172 x173 x174 x175 x176 x177 x178 x179 x180 x181 x182 x183 ->
    owl_stub_126_cblas_zsyr2k x171 x172 x173 x174 x175 (CI.cptr x176)
    (CI.cptr x177) x178 (CI.cptr x179) x180 (CI.cptr x181) (CI.cptr x182)
    x183)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Pointer _,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_csyr2k" ->
  (fun x184 x185 x186 x187 x188 x189 x190 x191 x192 x193 x194 x195 x196 ->
    owl_stub_125_cblas_csyr2k x184 x185 x186 x187 x188 (CI.cptr x189)
    (CI.cptr x190) x191 (CI.cptr x192) x193 (CI.cptr x194) (CI.cptr x195)
    x196)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Double,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Primitive CI.Double,
                                   Function
                                     (CI.Pointer _,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_dsyr2k" ->
  (fun x197 x198 x199 x200 x201 x202 x203 x204 x205 x206 x207 x208 x209 ->
    owl_stub_124_cblas_dsyr2k x197 x198 x199 x200 x201 x202 (CI.cptr x203)
    x204 (CI.cptr x205) x206 x207 (CI.cptr x208) x209)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Float,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Primitive CI.Float,
                                   Function
                                     (CI.Pointer _,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_ssyr2k" ->
  (fun x210 x211 x212 x213 x214 x215 x216 x217 x218 x219 x220 x221 x222 ->
    owl_stub_123_cblas_ssyr2k x210 x211 x212 x213 x214 x215 (CI.cptr x216)
    x217 (CI.cptr x218) x219 x220 (CI.cptr x221) x222)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_zsyrk" ->
  (fun x223 x224 x225 x226 x227 x228 x229 x230 x231 x232 x233 ->
    owl_stub_122_cblas_zsyrk x223 x224 x225 x226 x227 (CI.cptr x228)
    (CI.cptr x229) x230 (CI.cptr x231) (CI.cptr x232) x233)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_csyrk" ->
  (fun x234 x235 x236 x237 x238 x239 x240 x241 x242 x243 x244 ->
    owl_stub_121_cblas_csyrk x234 x235 x236 x237 x238 (CI.cptr x239)
    (CI.cptr x240) x241 (CI.cptr x242) (CI.cptr x243) x244)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Double,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Primitive CI.Double,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_dsyrk" ->
  (fun x245 x246 x247 x248 x249 x250 x251 x252 x253 x254 x255 ->
    owl_stub_120_cblas_dsyrk x245 x246 x247 x248 x249 x250 (CI.cptr x251)
    x252 x253 (CI.cptr x254) x255)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Float,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Primitive CI.Float,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_ssyrk" ->
  (fun x256 x257 x258 x259 x260 x261 x262 x263 x264 x265 x266 ->
    owl_stub_119_cblas_ssyrk x256 x257 x258 x259 x260 x261 (CI.cptr x262)
    x263 x264 (CI.cptr x265) x266)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Pointer _,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_zsymm" ->
  (fun x267 x268 x269 x270 x271 x272 x273 x274 x275 x276 x277 x278 x279 ->
    owl_stub_118_cblas_zsymm x267 x268 x269 x270 x271 (CI.cptr x272)
    (CI.cptr x273) x274 (CI.cptr x275) x276 (CI.cptr x277) (CI.cptr x278)
    x279)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Pointer _,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_csymm" ->
  (fun x280 x281 x282 x283 x284 x285 x286 x287 x288 x289 x290 x291 x292 ->
    owl_stub_117_cblas_csymm x280 x281 x282 x283 x284 (CI.cptr x285)
    (CI.cptr x286) x287 (CI.cptr x288) x289 (CI.cptr x290) (CI.cptr x291)
    x292)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Double,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Primitive CI.Double,
                                   Function
                                     (CI.Pointer _,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_dsymm" ->
  (fun x293 x294 x295 x296 x297 x298 x299 x300 x301 x302 x303 x304 x305 ->
    owl_stub_116_cblas_dsymm x293 x294 x295 x296 x297 x298 (CI.cptr x299)
    x300 (CI.cptr x301) x302 x303 (CI.cptr x304) x305)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Float,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Primitive CI.Float,
                                   Function
                                     (CI.Pointer _,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_ssymm" ->
  (fun x306 x307 x308 x309 x310 x311 x312 x313 x314 x315 x316 x317 x318 ->
    owl_stub_115_cblas_ssymm x306 x307 x308 x309 x310 x311 (CI.cptr x312)
    x313 (CI.cptr x314) x315 x316 (CI.cptr x317) x318)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Pointer _,
                                      Function
                                        (CI.Pointer _,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_zgemm" ->
  (fun x319 x320 x321 x322 x323 x324 x325 x326 x327 x328 x329 x330 x331 x332
    ->
    owl_stub_114_cblas_zgemm x319 x320 x321 x322 x323 x324 (CI.cptr x325)
    (CI.cptr x326) x327 (CI.cptr x328) x329 (CI.cptr x330) (CI.cptr x331)
    x332)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Pointer _,
                                      Function
                                        (CI.Pointer _,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_cgemm" ->
  (fun x333 x334 x335 x336 x337 x338 x339 x340 x341 x342 x343 x344 x345 x346
    ->
    owl_stub_113_cblas_cgemm x333 x334 x335 x336 x337 x338 (CI.cptr x339)
    (CI.cptr x340) x341 (CI.cptr x342) x343 (CI.cptr x344) (CI.cptr x345)
    x346)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Primitive CI.Double,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Primitive CI.Double,
                                      Function
                                        (CI.Pointer _,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_dgemm" ->
  (fun x347 x348 x349 x350 x351 x352 x353 x354 x355 x356 x357 x358 x359 x360
    ->
    owl_stub_112_cblas_dgemm x347 x348 x349 x350 x351 x352 x353
    (CI.cptr x354) x355 (CI.cptr x356) x357 x358 (CI.cptr x359) x360)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Primitive CI.Float,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Primitive CI.Float,
                                      Function
                                        (CI.Pointer _,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_sgemm" ->
  (fun x361 x362 x363 x364 x365 x366 x367 x368 x369 x370 x371 x372 x373 x374
    ->
    owl_stub_111_cblas_sgemm x361 x362 x363 x364 x365 x366 x367
    (CI.cptr x368) x369 (CI.cptr x370) x371 x372 (CI.cptr x373) x374)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function (CI.Pointer _, Returns CI.Void))))))))),
  "cblas_zhpr2" ->
  (fun x375 x376 x377 x378 x379 x380 x381 x382 x383 ->
    owl_stub_110_cblas_zhpr2 x375 x376 x377 (CI.cptr x378) (CI.cptr x379)
    x380 (CI.cptr x381) x382 (CI.cptr x383))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function (CI.Pointer _, Returns CI.Void))))))))),
  "cblas_chpr2" ->
  (fun x384 x385 x386 x387 x388 x389 x390 x391 x392 ->
    owl_stub_109_cblas_chpr2 x384 x385 x386 (CI.cptr x387) (CI.cptr x388)
    x389 (CI.cptr x390) x391 (CI.cptr x392))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_zher2" ->
  (fun x393 x394 x395 x396 x397 x398 x399 x400 x401 x402 ->
    owl_stub_108_cblas_zher2 x393 x394 x395 (CI.cptr x396) (CI.cptr x397)
    x398 (CI.cptr x399) x400 (CI.cptr x401) x402)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_cher2" ->
  (fun x403 x404 x405 x406 x407 x408 x409 x410 x411 x412 ->
    owl_stub_107_cblas_cher2 x403 x404 x405 (CI.cptr x406) (CI.cptr x407)
    x408 (CI.cptr x409) x410 (CI.cptr x411) x412)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function (CI.Pointer _, Returns CI.Void))))))),
  "cblas_zhpr" ->
  (fun x413 x414 x415 x416 x417 x418 x419 ->
    owl_stub_106_cblas_zhpr x413 x414 x415 x416 (CI.cptr x417) x418
    (CI.cptr x419))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function (CI.Pointer _, Returns CI.Void))))))),
  "cblas_chpr" ->
  (fun x420 x421 x422 x423 x424 x425 x426 ->
    owl_stub_105_cblas_chpr x420 x421 x422 x423 (CI.cptr x424) x425
    (CI.cptr x426))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_zher" ->
  (fun x427 x428 x429 x430 x431 x432 x433 x434 ->
    owl_stub_104_cblas_zher x427 x428 x429 x430 (CI.cptr x431) x432
    (CI.cptr x433) x434)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_cher" ->
  (fun x435 x436 x437 x438 x439 x440 x441 x442 ->
    owl_stub_103_cblas_cher x435 x436 x437 x438 (CI.cptr x439) x440
    (CI.cptr x441) x442)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_zgerc" ->
  (fun x443 x444 x445 x446 x447 x448 x449 x450 x451 x452 ->
    owl_stub_102_cblas_zgerc x443 x444 x445 (CI.cptr x446) (CI.cptr x447)
    x448 (CI.cptr x449) x450 (CI.cptr x451) x452)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_cgerc" ->
  (fun x453 x454 x455 x456 x457 x458 x459 x460 x461 x462 ->
    owl_stub_101_cblas_cgerc x453 x454 x455 (CI.cptr x456) (CI.cptr x457)
    x458 (CI.cptr x459) x460 (CI.cptr x461) x462)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_zgeru" ->
  (fun x463 x464 x465 x466 x467 x468 x469 x470 x471 x472 ->
    owl_stub_100_cblas_zgeru x463 x464 x465 (CI.cptr x466) (CI.cptr x467)
    x468 (CI.cptr x469) x470 (CI.cptr x471) x472)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_cgeru" ->
  (fun x473 x474 x475 x476 x477 x478 x479 x480 x481 x482 ->
    owl_stub_99_cblas_cgeru x473 x474 x475 (CI.cptr x476) (CI.cptr x477) x478
    (CI.cptr x479) x480 (CI.cptr x481) x482)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_zhpmv" ->
  (fun x483 x484 x485 x486 x487 x488 x489 x490 x491 x492 ->
    owl_stub_98_cblas_zhpmv x483 x484 x485 (CI.cptr x486) (CI.cptr x487)
    (CI.cptr x488) x489 (CI.cptr x490) (CI.cptr x491) x492)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_chpmv" ->
  (fun x493 x494 x495 x496 x497 x498 x499 x500 x501 x502 ->
    owl_stub_97_cblas_chpmv x493 x494 x495 (CI.cptr x496) (CI.cptr x497)
    (CI.cptr x498) x499 (CI.cptr x500) (CI.cptr x501) x502)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_zhbmv" ->
  (fun x503 x504 x505 x506 x507 x508 x509 x510 x511 x512 x513 x514 ->
    owl_stub_96_cblas_zhbmv x503 x504 x505 x506 (CI.cptr x507) (CI.cptr x508)
    x509 (CI.cptr x510) x511 (CI.cptr x512) (CI.cptr x513) x514)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_chbmv" ->
  (fun x515 x516 x517 x518 x519 x520 x521 x522 x523 x524 x525 x526 ->
    owl_stub_95_cblas_chbmv x515 x516 x517 x518 (CI.cptr x519) (CI.cptr x520)
    x521 (CI.cptr x522) x523 (CI.cptr x524) (CI.cptr x525) x526)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_zhemv" ->
  (fun x527 x528 x529 x530 x531 x532 x533 x534 x535 x536 x537 ->
    owl_stub_94_cblas_zhemv x527 x528 x529 (CI.cptr x530) (CI.cptr x531) x532
    (CI.cptr x533) x534 (CI.cptr x535) (CI.cptr x536) x537)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_chemv" ->
  (fun x538 x539 x540 x541 x542 x543 x544 x545 x546 x547 x548 ->
    owl_stub_93_cblas_chemv x538 x539 x540 (CI.cptr x541) (CI.cptr x542) x543
    (CI.cptr x544) x545 (CI.cptr x546) (CI.cptr x547) x548)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function (CI.Pointer _, Returns CI.Void))))))))),
  "cblas_dspr2" ->
  (fun x549 x550 x551 x552 x553 x554 x555 x556 x557 ->
    owl_stub_92_cblas_dspr2 x549 x550 x551 x552 (CI.cptr x553) x554
    (CI.cptr x555) x556 (CI.cptr x557))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function (CI.Pointer _, Returns CI.Void))))))))),
  "cblas_sspr2" ->
  (fun x558 x559 x560 x561 x562 x563 x564 x565 x566 ->
    owl_stub_91_cblas_sspr2 x558 x559 x560 x561 (CI.cptr x562) x563
    (CI.cptr x564) x565 (CI.cptr x566))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_dsyr2" ->
  (fun x567 x568 x569 x570 x571 x572 x573 x574 x575 x576 ->
    owl_stub_90_cblas_dsyr2 x567 x568 x569 x570 (CI.cptr x571) x572
    (CI.cptr x573) x574 (CI.cptr x575) x576)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_ssyr2" ->
  (fun x577 x578 x579 x580 x581 x582 x583 x584 x585 x586 ->
    owl_stub_89_cblas_ssyr2 x577 x578 x579 x580 (CI.cptr x581) x582
    (CI.cptr x583) x584 (CI.cptr x585) x586)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function (CI.Pointer _, Returns CI.Void))))))),
  "cblas_dspr" ->
  (fun x587 x588 x589 x590 x591 x592 x593 ->
    owl_stub_88_cblas_dspr x587 x588 x589 x590 (CI.cptr x591) x592
    (CI.cptr x593))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function (CI.Pointer _, Returns CI.Void))))))),
  "cblas_sspr" ->
  (fun x594 x595 x596 x597 x598 x599 x600 ->
    owl_stub_87_cblas_sspr x594 x595 x596 x597 (CI.cptr x598) x599
    (CI.cptr x600))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_dsyr" ->
  (fun x601 x602 x603 x604 x605 x606 x607 x608 ->
    owl_stub_86_cblas_dsyr x601 x602 x603 x604 (CI.cptr x605) x606
    (CI.cptr x607) x608)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_ssyr" ->
  (fun x609 x610 x611 x612 x613 x614 x615 x616 ->
    owl_stub_85_cblas_ssyr x609 x610 x611 x612 (CI.cptr x613) x614
    (CI.cptr x615) x616)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_dger" ->
  (fun x617 x618 x619 x620 x621 x622 x623 x624 x625 x626 ->
    owl_stub_84_cblas_dger x617 x618 x619 x620 (CI.cptr x621) x622
    (CI.cptr x623) x624 (CI.cptr x625) x626)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_sger" ->
  (fun x627 x628 x629 x630 x631 x632 x633 x634 x635 x636 ->
    owl_stub_83_cblas_sger x627 x628 x629 x630 (CI.cptr x631) x632
    (CI.cptr x633) x634 (CI.cptr x635) x636)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Primitive CI.Double,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_dspmv" ->
  (fun x637 x638 x639 x640 x641 x642 x643 x644 x645 x646 ->
    owl_stub_82_cblas_dspmv x637 x638 x639 x640 (CI.cptr x641) (CI.cptr x642)
    x643 x644 (CI.cptr x645) x646)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Primitive CI.Float,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_sspmv" ->
  (fun x647 x648 x649 x650 x651 x652 x653 x654 x655 x656 ->
    owl_stub_81_cblas_sspmv x647 x648 x649 x650 (CI.cptr x651) (CI.cptr x652)
    x653 x654 (CI.cptr x655) x656)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Double,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Primitive CI.Double,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_dsbmv" ->
  (fun x657 x658 x659 x660 x661 x662 x663 x664 x665 x666 x667 x668 ->
    owl_stub_80_cblas_dsbmv x657 x658 x659 x660 x661 (CI.cptr x662) x663
    (CI.cptr x664) x665 x666 (CI.cptr x667) x668)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Float,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Primitive CI.Float,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_ssbmv" ->
  (fun x669 x670 x671 x672 x673 x674 x675 x676 x677 x678 x679 x680 ->
    owl_stub_79_cblas_ssbmv x669 x670 x671 x672 x673 (CI.cptr x674) x675
    (CI.cptr x676) x677 x678 (CI.cptr x679) x680)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Primitive CI.Double,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_dsymv" ->
  (fun x681 x682 x683 x684 x685 x686 x687 x688 x689 x690 x691 ->
    owl_stub_78_cblas_dsymv x681 x682 x683 x684 (CI.cptr x685) x686
    (CI.cptr x687) x688 x689 (CI.cptr x690) x691)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Primitive CI.Float,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_ssymv" ->
  (fun x692 x693 x694 x695 x696 x697 x698 x699 x700 x701 x702 ->
    owl_stub_77_cblas_ssymv x692 x693 x694 x695 (CI.cptr x696) x697
    (CI.cptr x698) x699 x700 (CI.cptr x701) x702)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Pointer _,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_ztpsv" ->
  (fun x703 x704 x705 x706 x707 x708 x709 x710 ->
    owl_stub_76_cblas_ztpsv x703 x704 x705 x706 x707 (CI.cptr x708)
    (CI.cptr x709) x710)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Pointer _,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_ctpsv" ->
  (fun x711 x712 x713 x714 x715 x716 x717 x718 ->
    owl_stub_75_cblas_ctpsv x711 x712 x713 x714 x715 (CI.cptr x716)
    (CI.cptr x717) x718)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Pointer _,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_dtpsv" ->
  (fun x719 x720 x721 x722 x723 x724 x725 x726 ->
    owl_stub_74_cblas_dtpsv x719 x720 x721 x722 x723 (CI.cptr x724)
    (CI.cptr x725) x726)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Pointer _,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_stpsv" ->
  (fun x727 x728 x729 x730 x731 x732 x733 x734 ->
    owl_stub_73_cblas_stpsv x727 x728 x729 x730 x731 (CI.cptr x732)
    (CI.cptr x733) x734)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_ztbsv" ->
  (fun x735 x736 x737 x738 x739 x740 x741 x742 x743 x744 ->
    owl_stub_72_cblas_ztbsv x735 x736 x737 x738 x739 x740 (CI.cptr x741) x742
    (CI.cptr x743) x744)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_ctbsv" ->
  (fun x745 x746 x747 x748 x749 x750 x751 x752 x753 x754 ->
    owl_stub_71_cblas_ctbsv x745 x746 x747 x748 x749 x750 (CI.cptr x751) x752
    (CI.cptr x753) x754)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_dtbsv" ->
  (fun x755 x756 x757 x758 x759 x760 x761 x762 x763 x764 ->
    owl_stub_70_cblas_dtbsv x755 x756 x757 x758 x759 x760 (CI.cptr x761) x762
    (CI.cptr x763) x764)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_stbsv" ->
  (fun x765 x766 x767 x768 x769 x770 x771 x772 x773 x774 ->
    owl_stub_69_cblas_stbsv x765 x766 x767 x768 x769 x770 (CI.cptr x771) x772
    (CI.cptr x773) x774)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_ztrsv" ->
  (fun x775 x776 x777 x778 x779 x780 x781 x782 x783 ->
    owl_stub_68_cblas_ztrsv x775 x776 x777 x778 x779 (CI.cptr x780) x781
    (CI.cptr x782) x783)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_ctrsv" ->
  (fun x784 x785 x786 x787 x788 x789 x790 x791 x792 ->
    owl_stub_67_cblas_ctrsv x784 x785 x786 x787 x788 (CI.cptr x789) x790
    (CI.cptr x791) x792)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_dtrsv" ->
  (fun x793 x794 x795 x796 x797 x798 x799 x800 x801 ->
    owl_stub_66_cblas_dtrsv x793 x794 x795 x796 x797 (CI.cptr x798) x799
    (CI.cptr x800) x801)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_strsv" ->
  (fun x802 x803 x804 x805 x806 x807 x808 x809 x810 ->
    owl_stub_65_cblas_strsv x802 x803 x804 x805 x806 (CI.cptr x807) x808
    (CI.cptr x809) x810)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Pointer _,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_ztpmv" ->
  (fun x811 x812 x813 x814 x815 x816 x817 x818 ->
    owl_stub_64_cblas_ztpmv x811 x812 x813 x814 x815 (CI.cptr x816)
    (CI.cptr x817) x818)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Pointer _,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_ctpmv" ->
  (fun x819 x820 x821 x822 x823 x824 x825 x826 ->
    owl_stub_63_cblas_ctpmv x819 x820 x821 x822 x823 (CI.cptr x824)
    (CI.cptr x825) x826)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Pointer _,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_dtpmv" ->
  (fun x827 x828 x829 x830 x831 x832 x833 x834 ->
    owl_stub_62_cblas_dtpmv x827 x828 x829 x830 x831 (CI.cptr x832)
    (CI.cptr x833) x834)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Pointer _,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_stpmv" ->
  (fun x835 x836 x837 x838 x839 x840 x841 x842 ->
    owl_stub_61_cblas_stpmv x835 x836 x837 x838 x839 (CI.cptr x840)
    (CI.cptr x841) x842)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_ztbmv" ->
  (fun x843 x844 x845 x846 x847 x848 x849 x850 x851 x852 ->
    owl_stub_60_cblas_ztbmv x843 x844 x845 x846 x847 x848 (CI.cptr x849) x850
    (CI.cptr x851) x852)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_ctbmv" ->
  (fun x853 x854 x855 x856 x857 x858 x859 x860 x861 x862 ->
    owl_stub_59_cblas_ctbmv x853 x854 x855 x856 x857 x858 (CI.cptr x859) x860
    (CI.cptr x861) x862)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_dtbmv" ->
  (fun x863 x864 x865 x866 x867 x868 x869 x870 x871 x872 ->
    owl_stub_58_cblas_dtbmv x863 x864 x865 x866 x867 x868 (CI.cptr x869) x870
    (CI.cptr x871) x872)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer _,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_stbmv" ->
  (fun x873 x874 x875 x876 x877 x878 x879 x880 x881 x882 ->
    owl_stub_57_cblas_stbmv x873 x874 x875 x876 x877 x878 (CI.cptr x879) x880
    (CI.cptr x881) x882)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_ztrmv" ->
  (fun x883 x884 x885 x886 x887 x888 x889 x890 x891 ->
    owl_stub_56_cblas_ztrmv x883 x884 x885 x886 x887 (CI.cptr x888) x889
    (CI.cptr x890) x891)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_ctrmv" ->
  (fun x892 x893 x894 x895 x896 x897 x898 x899 x900 ->
    owl_stub_55_cblas_ctrmv x892 x893 x894 x895 x896 (CI.cptr x897) x898
    (CI.cptr x899) x900)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_dtrmv" ->
  (fun x901 x902 x903 x904 x905 x906 x907 x908 x909 ->
    owl_stub_54_cblas_dtrmv x901 x902 x903 x904 x905 (CI.cptr x906) x907
    (CI.cptr x908) x909)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_strmv" ->
  (fun x910 x911 x912 x913 x914 x915 x916 x917 x918 ->
    owl_stub_53_cblas_strmv x910 x911 x912 x913 x914 (CI.cptr x915) x916
    (CI.cptr x917) x918)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Pointer _,
                                      Function
                                        (CI.Pointer _,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_zgbmv" ->
  (fun x919 x920 x921 x922 x923 x924 x925 x926 x927 x928 x929 x930 x931 x932
    ->
    owl_stub_52_cblas_zgbmv x919 x920 x921 x922 x923 x924 (CI.cptr x925)
    (CI.cptr x926) x927 (CI.cptr x928) x929 (CI.cptr x930) (CI.cptr x931)
    x932)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer _,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Pointer _,
                                      Function
                                        (CI.Pointer _,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_cgbmv" ->
  (fun x933 x934 x935 x936 x937 x938 x939 x940 x941 x942 x943 x944 x945 x946
    ->
    owl_stub_51_cblas_cgbmv x933 x934 x935 x936 x937 x938 (CI.cptr x939)
    (CI.cptr x940) x941 (CI.cptr x942) x943 (CI.cptr x944) (CI.cptr x945)
    x946)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Primitive CI.Double,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Primitive CI.Double,
                                      Function
                                        (CI.Pointer _,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_dgbmv" ->
  (fun x947 x948 x949 x950 x951 x952 x953 x954 x955 x956 x957 x958 x959 x960
    ->
    owl_stub_50_cblas_dgbmv x947 x948 x949 x950 x951 x952 x953 (CI.cptr x954)
    x955 (CI.cptr x956) x957 x958 (CI.cptr x959) x960)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Primitive CI.Float,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Primitive CI.Float,
                                      Function
                                        (CI.Pointer _,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_sgbmv" ->
  (fun x961 x962 x963 x964 x965 x966 x967 x968 x969 x970 x971 x972 x973 x974
    ->
    owl_stub_49_cblas_sgbmv x961 x962 x963 x964 x965 x966 x967 (CI.cptr x968)
    x969 (CI.cptr x970) x971 x972 (CI.cptr x973) x974)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_zgemv" ->
  (fun x975 x976 x977 x978 x979 x980 x981 x982 x983 x984 x985 x986 ->
    owl_stub_48_cblas_zgemv x975 x976 x977 x978 (CI.cptr x979) (CI.cptr x980)
    x981 (CI.cptr x982) x983 (CI.cptr x984) (CI.cptr x985) x986)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer _,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_cgemv" ->
  (fun x987 x988 x989 x990 x991 x992 x993 x994 x995 x996 x997 x998 ->
    owl_stub_47_cblas_cgemv x987 x988 x989 x990 (CI.cptr x991) (CI.cptr x992)
    x993 (CI.cptr x994) x995 (CI.cptr x996) (CI.cptr x997) x998)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Double,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Primitive CI.Double,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_dgemv" ->
  (fun x999 x1000 x1001 x1002 x1003 x1004 x1005 x1006 x1007 x1008 x1009 x1010
    ->
    owl_stub_46_cblas_dgemv x999 x1000 x1001 x1002 x1003 (CI.cptr x1004)
    x1005 (CI.cptr x1006) x1007 x1008 (CI.cptr x1009) x1010)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Primitive CI.Float,
                 Function
                   (CI.Pointer _,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer _,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Primitive CI.Float,
                                Function
                                  (CI.Pointer _,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_sgemv" ->
  (fun x1011 x1012 x1013 x1014 x1015 x1016 x1017 x1018 x1019 x1020 x1021
    x1022 ->
    owl_stub_45_cblas_sgemv x1011 x1012 x1013 x1014 x1015 (CI.cptr x1016)
    x1017 (CI.cptr x1018) x1019 x1020 (CI.cptr x1021) x1022)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Size_t)))),
  "cblas_izamax" ->
  (fun x1023 x1024 x1025 ->
    owl_stub_44_cblas_izamax x1023 (CI.cptr x1024) x1025)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Size_t)))),
  "cblas_icamax" ->
  (fun x1026 x1027 x1028 ->
    owl_stub_43_cblas_icamax x1026 (CI.cptr x1027) x1028)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Size_t)))),
  "cblas_idamax" ->
  (fun x1029 x1030 x1031 ->
    owl_stub_42_cblas_idamax x1029 (CI.cptr x1030) x1031)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Size_t)))),
  "cblas_isamax" ->
  (fun x1032 x1033 x1034 ->
    owl_stub_41_cblas_isamax x1032 (CI.cptr x1033) x1034)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "cblas_dzasum" ->
  (fun x1035 x1036 x1037 ->
    owl_stub_40_cblas_dzasum x1035 (CI.cptr x1036) x1037)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))),
  "cblas_scasum" ->
  (fun x1038 x1039 x1040 ->
    owl_stub_39_cblas_scasum x1038 (CI.cptr x1039) x1040)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "cblas_dasum" ->
  (fun x1041 x1042 x1043 ->
    owl_stub_38_cblas_dasum x1041 (CI.cptr x1042) x1043)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))),
  "cblas_sasum" ->
  (fun x1044 x1045 x1046 ->
    owl_stub_37_cblas_sasum x1044 (CI.cptr x1045) x1046)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "cblas_dznrm2" ->
  (fun x1047 x1048 x1049 ->
    owl_stub_36_cblas_dznrm2 x1047 (CI.cptr x1048) x1049)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))),
  "cblas_scnrm2" ->
  (fun x1050 x1051 x1052 ->
    owl_stub_35_cblas_scnrm2 x1050 (CI.cptr x1051) x1052)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "cblas_dnrm2" ->
  (fun x1053 x1054 x1055 ->
    owl_stub_34_cblas_dnrm2 x1053 (CI.cptr x1054) x1055)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))),
  "cblas_snrm2" ->
  (fun x1056 x1057 x1058 ->
    owl_stub_33_cblas_snrm2 x1056 (CI.cptr x1057) x1058)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function
                (CI.Primitive CI.Int,
                 Function (CI.Pointer _, Returns CI.Void)))))),
  "cblas_zdotc_sub" ->
  (fun x1059 x1060 x1061 x1062 x1063 x1064 ->
    owl_stub_32_cblas_zdotc_sub x1059 (CI.cptr x1060) x1061 (CI.cptr x1062)
    x1063 (CI.cptr x1064))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function
                (CI.Primitive CI.Int,
                 Function (CI.Pointer _, Returns CI.Void)))))),
  "cblas_zdotu_sub" ->
  (fun x1065 x1066 x1067 x1068 x1069 x1070 ->
    owl_stub_31_cblas_zdotu_sub x1065 (CI.cptr x1066) x1067 (CI.cptr x1068)
    x1069 (CI.cptr x1070))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function
                (CI.Primitive CI.Int,
                 Function (CI.Pointer _, Returns CI.Void)))))),
  "cblas_cdotc_sub" ->
  (fun x1071 x1072 x1073 x1074 x1075 x1076 ->
    owl_stub_30_cblas_cdotc_sub x1071 (CI.cptr x1072) x1073 (CI.cptr x1074)
    x1075 (CI.cptr x1076))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function
                (CI.Primitive CI.Int,
                 Function (CI.Pointer _, Returns CI.Void)))))),
  "cblas_cdotu_sub" ->
  (fun x1077 x1078 x1079 x1080 x1081 x1082 ->
    owl_stub_29_cblas_cdotu_sub x1077 (CI.cptr x1078) x1079 (CI.cptr x1080)
    x1081 (CI.cptr x1082))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function
                (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))))),
  "cblas_dsdot" ->
  (fun x1083 x1084 x1085 x1086 x1087 ->
    owl_stub_28_cblas_dsdot x1083 (CI.cptr x1084) x1085 (CI.cptr x1086) x1087)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Float,
        Function
          (CI.Pointer _,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer _,
                 Function
                   (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float))))))),
  "cblas_sdsdot" ->
  (fun x1088 x1089 x1090 x1091 x1092 x1093 ->
    owl_stub_27_cblas_sdsdot x1088 x1089 (CI.cptr x1090) x1091
    (CI.cptr x1092) x1093)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function
                (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))))),
  "cblas_ddot" ->
  (fun x1094 x1095 x1096 x1097 x1098 ->
    owl_stub_26_cblas_ddot x1094 (CI.cptr x1095) x1096 (CI.cptr x1097) x1098)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))))),
  "cblas_sdot" ->
  (fun x1099 x1100 x1101 x1102 x1103 ->
    owl_stub_25_cblas_sdot x1099 (CI.cptr x1100) x1101 (CI.cptr x1102) x1103)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Pointer _,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer _,
                 Function (CI.Primitive CI.Int, Returns CI.Void)))))),
  "cblas_zaxpy" ->
  (fun x1104 x1105 x1106 x1107 x1108 x1109 ->
    owl_stub_24_cblas_zaxpy x1104 (CI.cptr x1105) (CI.cptr x1106) x1107
    (CI.cptr x1108) x1109)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Pointer _,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer _,
                 Function (CI.Primitive CI.Int, Returns CI.Void)))))),
  "cblas_caxpy" ->
  (fun x1110 x1111 x1112 x1113 x1114 x1115 ->
    owl_stub_23_cblas_caxpy x1110 (CI.cptr x1111) (CI.cptr x1112) x1113
    (CI.cptr x1114) x1115)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Double,
        Function
          (CI.Pointer _,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer _,
                 Function (CI.Primitive CI.Int, Returns CI.Void)))))),
  "cblas_daxpy" ->
  (fun x1116 x1117 x1118 x1119 x1120 x1121 ->
    owl_stub_22_cblas_daxpy x1116 x1117 (CI.cptr x1118) x1119 (CI.cptr x1120)
    x1121)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Float,
        Function
          (CI.Pointer _,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer _,
                 Function (CI.Primitive CI.Int, Returns CI.Void)))))),
  "cblas_saxpy" ->
  (fun x1122 x1123 x1124 x1125 x1126 x1127 ->
    owl_stub_21_cblas_saxpy x1122 x1123 (CI.cptr x1124) x1125 (CI.cptr x1126)
    x1127)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _, Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_zcopy" ->
  (fun x1128 x1129 x1130 x1131 x1132 ->
    owl_stub_20_cblas_zcopy x1128 (CI.cptr x1129) x1130 (CI.cptr x1131) x1132)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _, Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_ccopy" ->
  (fun x1133 x1134 x1135 x1136 x1137 ->
    owl_stub_19_cblas_ccopy x1133 (CI.cptr x1134) x1135 (CI.cptr x1136) x1137)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _, Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_dcopy" ->
  (fun x1138 x1139 x1140 x1141 x1142 ->
    owl_stub_18_cblas_dcopy x1138 (CI.cptr x1139) x1140 (CI.cptr x1141) x1142)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _, Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_scopy" ->
  (fun x1143 x1144 x1145 x1146 x1147 ->
    owl_stub_17_cblas_scopy x1143 (CI.cptr x1144) x1145 (CI.cptr x1146) x1147)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Double,
        Function
          (CI.Pointer _, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_zdscal" ->
  (fun x1148 x1149 x1150 x1151 ->
    owl_stub_16_cblas_zdscal x1148 x1149 (CI.cptr x1150) x1151)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Float,
        Function
          (CI.Pointer _, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_csscal" ->
  (fun x1152 x1153 x1154 x1155 ->
    owl_stub_15_cblas_csscal x1152 x1153 (CI.cptr x1154) x1155)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Pointer _, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_zscal" ->
  (fun x1156 x1157 x1158 x1159 ->
    owl_stub_14_cblas_zscal x1156 (CI.cptr x1157) (CI.cptr x1158) x1159)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Pointer _, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_cscal" ->
  (fun x1160 x1161 x1162 x1163 ->
    owl_stub_13_cblas_cscal x1160 (CI.cptr x1161) (CI.cptr x1162) x1163)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Double,
        Function
          (CI.Pointer _, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_dscal" ->
  (fun x1164 x1165 x1166 x1167 ->
    owl_stub_12_cblas_dscal x1164 x1165 (CI.cptr x1166) x1167)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Float,
        Function
          (CI.Pointer _, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_sscal" ->
  (fun x1168 x1169 x1170 x1171 ->
    owl_stub_11_cblas_sscal x1168 x1169 (CI.cptr x1170) x1171)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _, Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_zswap" ->
  (fun x1172 x1173 x1174 x1175 x1176 ->
    owl_stub_10_cblas_zswap x1172 (CI.cptr x1173) x1174 (CI.cptr x1175) x1176)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _, Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_cswap" ->
  (fun x1177 x1178 x1179 x1180 x1181 ->
    owl_stub_9_cblas_cswap x1177 (CI.cptr x1178) x1179 (CI.cptr x1180) x1181)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _, Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_dswap" ->
  (fun x1182 x1183 x1184 x1185 x1186 ->
    owl_stub_8_cblas_dswap x1182 (CI.cptr x1183) x1184 (CI.cptr x1185) x1186)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _, Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_sswap" ->
  (fun x1187 x1188 x1189 x1190 x1191 ->
    owl_stub_7_cblas_sswap x1187 (CI.cptr x1188) x1189 (CI.cptr x1190) x1191)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Double,
                    Function (CI.Primitive CI.Double, Returns CI.Void))))))),
  "cblas_drot" ->
  (fun x1192 x1193 x1194 x1195 x1196 x1197 x1198 ->
    owl_stub_6_cblas_drot x1192 (CI.cptr x1193) x1194 (CI.cptr x1195) x1196
    x1197 x1198)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer _,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer _,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Float,
                    Function (CI.Primitive CI.Float, Returns CI.Void))))))),
  "cblas_srot" ->
  (fun x1199 x1200 x1201 x1202 x1203 x1204 x1205 ->
    owl_stub_5_cblas_srot x1199 (CI.cptr x1200) x1201 (CI.cptr x1202) x1203
    x1204 x1205)
| Function
    (CI.Pointer _,
     Function
       (CI.Pointer _,
        Function
          (CI.Pointer _,
           Function
             (CI.Primitive CI.Double,
              Function (CI.Pointer _, Returns CI.Void))))),
  "cblas_drotmg" ->
  (fun x1206 x1207 x1208 x1209 x1210 ->
    owl_stub_4_cblas_drotmg (CI.cptr x1206) (CI.cptr x1207) (CI.cptr x1208)
    x1209 (CI.cptr x1210))
| Function
    (CI.Pointer _,
     Function
       (CI.Pointer _,
        Function
          (CI.Pointer _,
           Function
             (CI.Primitive CI.Float,
              Function (CI.Pointer _, Returns CI.Void))))),
  "cblas_srotmg" ->
  (fun x1211 x1212 x1213 x1214 x1215 ->
    owl_stub_3_cblas_srotmg (CI.cptr x1211) (CI.cptr x1212) (CI.cptr x1213)
    x1214 (CI.cptr x1215))
| Function
    (CI.Pointer _,
     Function
       (CI.Pointer _,
        Function (CI.Pointer _, Function (CI.Pointer _, Returns CI.Void)))),
  "cblas_drotg" ->
  (fun x1216 x1217 x1218 x1219 ->
    owl_stub_2_cblas_drotg (CI.cptr x1216) (CI.cptr x1217) (CI.cptr x1218)
    (CI.cptr x1219))
| Function
    (CI.Pointer _,
     Function
       (CI.Pointer _,
        Function (CI.Pointer _, Function (CI.Pointer _, Returns CI.Void)))),
  "cblas_srotg" ->
  (fun x1220 x1221 x1222 x1223 ->
    owl_stub_1_cblas_srotg (CI.cptr x1220) (CI.cptr x1221) (CI.cptr x1222)
    (CI.cptr x1223))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s
