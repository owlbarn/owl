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
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x8,
                       Function
                         (CI.Pointer x10,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x13,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Pointer x16,
                                      Function
                                        (CI.Pointer x18,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_zgemm" ->
  (fun x1 x2 x3 x4 x5 x6 x7 x9 x11 x12 x14 x15 x17 x19 ->
    owl_stub_114_cblas_zgemm x1 x2 x3 x4 x5 x6 (CI.cptr x7) (CI.cptr x9) x11
    (CI.cptr x12) x14 (CI.cptr x15) (CI.cptr x17) x19)
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
                      (CI.Pointer x27,
                       Function
                         (CI.Pointer x29,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x32,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Pointer x35,
                                      Function
                                        (CI.Pointer x37,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_cgemm" ->
  (fun x20 x21 x22 x23 x24 x25 x26 x28 x30 x31 x33 x34 x36 x38 ->
    owl_stub_113_cblas_cgemm x20 x21 x22 x23 x24 x25 (CI.cptr x26)
    (CI.cptr x28) x30 (CI.cptr x31) x33 (CI.cptr x34) (CI.cptr x36) x38)
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
                         (CI.Pointer x47,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x50,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Primitive CI.Double,
                                      Function
                                        (CI.Pointer x54,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_dgemm" ->
  (fun x39 x40 x41 x42 x43 x44 x45 x46 x48 x49 x51 x52 x53 x55 ->
    owl_stub_112_cblas_dgemm x39 x40 x41 x42 x43 x44 x45 (CI.cptr x46) x48
    (CI.cptr x49) x51 x52 (CI.cptr x53) x55)
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
                         (CI.Pointer x64,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x67,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Primitive CI.Float,
                                      Function
                                        (CI.Pointer x71,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_sgemm" ->
  (fun x56 x57 x58 x59 x60 x61 x62 x63 x65 x66 x68 x69 x70 x72 ->
    owl_stub_111_cblas_sgemm x56 x57 x58 x59 x60 x61 x62 (CI.cptr x63) x65
    (CI.cptr x66) x68 x69 (CI.cptr x70) x72)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x77,
              Function
                (CI.Pointer x79,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x82,
                       Function
                         (CI.Primitive CI.Int,
                          Function (CI.Pointer x85, Returns CI.Void))))))))),
  "cblas_zhpr2" ->
  (fun x73 x74 x75 x76 x78 x80 x81 x83 x84 ->
    owl_stub_110_cblas_zhpr2 x73 x74 x75 (CI.cptr x76) (CI.cptr x78) x80
    (CI.cptr x81) x83 (CI.cptr x84))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x90,
              Function
                (CI.Pointer x92,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x95,
                       Function
                         (CI.Primitive CI.Int,
                          Function (CI.Pointer x98, Returns CI.Void))))))))),
  "cblas_chpr2" ->
  (fun x86 x87 x88 x89 x91 x93 x94 x96 x97 ->
    owl_stub_109_cblas_chpr2 x86 x87 x88 (CI.cptr x89) (CI.cptr x91) x93
    (CI.cptr x94) x96 (CI.cptr x97))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x103,
              Function
                (CI.Pointer x105,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x108,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x111,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_zher2" ->
  (fun x99 x100 x101 x102 x104 x106 x107 x109 x110 x112 ->
    owl_stub_108_cblas_zher2 x99 x100 x101 (CI.cptr x102) (CI.cptr x104) x106
    (CI.cptr x107) x109 (CI.cptr x110) x112)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x117,
              Function
                (CI.Pointer x119,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x122,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x125,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_cher2" ->
  (fun x113 x114 x115 x116 x118 x120 x121 x123 x124 x126 ->
    owl_stub_107_cblas_cher2 x113 x114 x115 (CI.cptr x116) (CI.cptr x118)
    x120 (CI.cptr x121) x123 (CI.cptr x124) x126)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x132,
                 Function
                   (CI.Primitive CI.Int,
                    Function (CI.Pointer x135, Returns CI.Void))))))),
  "cblas_zhpr" ->
  (fun x127 x128 x129 x130 x131 x133 x134 ->
    owl_stub_106_cblas_zhpr x127 x128 x129 x130 (CI.cptr x131) x133
    (CI.cptr x134))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x141,
                 Function
                   (CI.Primitive CI.Int,
                    Function (CI.Pointer x144, Returns CI.Void))))))),
  "cblas_chpr" ->
  (fun x136 x137 x138 x139 x140 x142 x143 ->
    owl_stub_105_cblas_chpr x136 x137 x138 x139 (CI.cptr x140) x142
    (CI.cptr x143))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x150,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x153,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_zher" ->
  (fun x145 x146 x147 x148 x149 x151 x152 x154 ->
    owl_stub_104_cblas_zher x145 x146 x147 x148 (CI.cptr x149) x151
    (CI.cptr x152) x154)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x160,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x163,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_cher" ->
  (fun x155 x156 x157 x158 x159 x161 x162 x164 ->
    owl_stub_103_cblas_cher x155 x156 x157 x158 (CI.cptr x159) x161
    (CI.cptr x162) x164)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x169,
              Function
                (CI.Pointer x171,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x174,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x177,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_zgerc" ->
  (fun x165 x166 x167 x168 x170 x172 x173 x175 x176 x178 ->
    owl_stub_102_cblas_zgerc x165 x166 x167 (CI.cptr x168) (CI.cptr x170)
    x172 (CI.cptr x173) x175 (CI.cptr x176) x178)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x183,
              Function
                (CI.Pointer x185,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x188,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x191,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_cgerc" ->
  (fun x179 x180 x181 x182 x184 x186 x187 x189 x190 x192 ->
    owl_stub_101_cblas_cgerc x179 x180 x181 (CI.cptr x182) (CI.cptr x184)
    x186 (CI.cptr x187) x189 (CI.cptr x190) x192)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x197,
              Function
                (CI.Pointer x199,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x202,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x205,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_zgeru" ->
  (fun x193 x194 x195 x196 x198 x200 x201 x203 x204 x206 ->
    owl_stub_100_cblas_zgeru x193 x194 x195 (CI.cptr x196) (CI.cptr x198)
    x200 (CI.cptr x201) x203 (CI.cptr x204) x206)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x211,
              Function
                (CI.Pointer x213,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x216,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x219,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_cgeru" ->
  (fun x207 x208 x209 x210 x212 x214 x215 x217 x218 x220 ->
    owl_stub_99_cblas_cgeru x207 x208 x209 (CI.cptr x210) (CI.cptr x212) x214
    (CI.cptr x215) x217 (CI.cptr x218) x220)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x225,
              Function
                (CI.Pointer x227,
                 Function
                   (CI.Pointer x229,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x232,
                          Function
                            (CI.Pointer x234,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_zhpmv" ->
  (fun x221 x222 x223 x224 x226 x228 x230 x231 x233 x235 ->
    owl_stub_98_cblas_zhpmv x221 x222 x223 (CI.cptr x224) (CI.cptr x226)
    (CI.cptr x228) x230 (CI.cptr x231) (CI.cptr x233) x235)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x240,
              Function
                (CI.Pointer x242,
                 Function
                   (CI.Pointer x244,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x247,
                          Function
                            (CI.Pointer x249,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_chpmv" ->
  (fun x236 x237 x238 x239 x241 x243 x245 x246 x248 x250 ->
    owl_stub_97_cblas_chpmv x236 x237 x238 (CI.cptr x239) (CI.cptr x241)
    (CI.cptr x243) x245 (CI.cptr x246) (CI.cptr x248) x250)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x256,
                 Function
                   (CI.Pointer x258,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x261,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x264,
                                Function
                                  (CI.Pointer x266,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_zhbmv" ->
  (fun x251 x252 x253 x254 x255 x257 x259 x260 x262 x263 x265 x267 ->
    owl_stub_96_cblas_zhbmv x251 x252 x253 x254 (CI.cptr x255) (CI.cptr x257)
    x259 (CI.cptr x260) x262 (CI.cptr x263) (CI.cptr x265) x267)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x273,
                 Function
                   (CI.Pointer x275,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x278,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x281,
                                Function
                                  (CI.Pointer x283,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_chbmv" ->
  (fun x268 x269 x270 x271 x272 x274 x276 x277 x279 x280 x282 x284 ->
    owl_stub_95_cblas_chbmv x268 x269 x270 x271 (CI.cptr x272) (CI.cptr x274)
    x276 (CI.cptr x277) x279 (CI.cptr x280) (CI.cptr x282) x284)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x289,
              Function
                (CI.Pointer x291,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x294,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x297,
                             Function
                               (CI.Pointer x299,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_zhemv" ->
  (fun x285 x286 x287 x288 x290 x292 x293 x295 x296 x298 x300 ->
    owl_stub_94_cblas_zhemv x285 x286 x287 (CI.cptr x288) (CI.cptr x290) x292
    (CI.cptr x293) x295 (CI.cptr x296) (CI.cptr x298) x300)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x305,
              Function
                (CI.Pointer x307,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x310,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x313,
                             Function
                               (CI.Pointer x315,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_chemv" ->
  (fun x301 x302 x303 x304 x306 x308 x309 x311 x312 x314 x316 ->
    owl_stub_93_cblas_chemv x301 x302 x303 (CI.cptr x304) (CI.cptr x306) x308
    (CI.cptr x309) x311 (CI.cptr x312) (CI.cptr x314) x316)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer x322,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x325,
                       Function
                         (CI.Primitive CI.Int,
                          Function (CI.Pointer x328, Returns CI.Void))))))))),
  "cblas_dspr2" ->
  (fun x317 x318 x319 x320 x321 x323 x324 x326 x327 ->
    owl_stub_92_cblas_dspr2 x317 x318 x319 x320 (CI.cptr x321) x323
    (CI.cptr x324) x326 (CI.cptr x327))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x334,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x337,
                       Function
                         (CI.Primitive CI.Int,
                          Function (CI.Pointer x340, Returns CI.Void))))))))),
  "cblas_sspr2" ->
  (fun x329 x330 x331 x332 x333 x335 x336 x338 x339 ->
    owl_stub_91_cblas_sspr2 x329 x330 x331 x332 (CI.cptr x333) x335
    (CI.cptr x336) x338 (CI.cptr x339))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer x346,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x349,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x352,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_dsyr2" ->
  (fun x341 x342 x343 x344 x345 x347 x348 x350 x351 x353 ->
    owl_stub_90_cblas_dsyr2 x341 x342 x343 x344 (CI.cptr x345) x347
    (CI.cptr x348) x350 (CI.cptr x351) x353)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x359,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x362,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x365,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_ssyr2" ->
  (fun x354 x355 x356 x357 x358 x360 x361 x363 x364 x366 ->
    owl_stub_89_cblas_ssyr2 x354 x355 x356 x357 (CI.cptr x358) x360
    (CI.cptr x361) x363 (CI.cptr x364) x366)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer x372,
                 Function
                   (CI.Primitive CI.Int,
                    Function (CI.Pointer x375, Returns CI.Void))))))),
  "cblas_dspr" ->
  (fun x367 x368 x369 x370 x371 x373 x374 ->
    owl_stub_88_cblas_dspr x367 x368 x369 x370 (CI.cptr x371) x373
    (CI.cptr x374))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x381,
                 Function
                   (CI.Primitive CI.Int,
                    Function (CI.Pointer x384, Returns CI.Void))))))),
  "cblas_sspr" ->
  (fun x376 x377 x378 x379 x380 x382 x383 ->
    owl_stub_87_cblas_sspr x376 x377 x378 x379 (CI.cptr x380) x382
    (CI.cptr x383))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer x390,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x393,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_dsyr" ->
  (fun x385 x386 x387 x388 x389 x391 x392 x394 ->
    owl_stub_86_cblas_dsyr x385 x386 x387 x388 (CI.cptr x389) x391
    (CI.cptr x392) x394)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x400,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x403,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_ssyr" ->
  (fun x395 x396 x397 x398 x399 x401 x402 x404 ->
    owl_stub_85_cblas_ssyr x395 x396 x397 x398 (CI.cptr x399) x401
    (CI.cptr x402) x404)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer x410,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x413,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x416,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_dger" ->
  (fun x405 x406 x407 x408 x409 x411 x412 x414 x415 x417 ->
    owl_stub_84_cblas_dger x405 x406 x407 x408 (CI.cptr x409) x411
    (CI.cptr x412) x414 (CI.cptr x415) x417)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x423,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x426,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x429,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_sger" ->
  (fun x418 x419 x420 x421 x422 x424 x425 x427 x428 x430 ->
    owl_stub_83_cblas_sger x418 x419 x420 x421 (CI.cptr x422) x424
    (CI.cptr x425) x427 (CI.cptr x428) x430)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer x436,
                 Function
                   (CI.Pointer x438,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Primitive CI.Double,
                          Function
                            (CI.Pointer x442,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_dspmv" ->
  (fun x431 x432 x433 x434 x435 x437 x439 x440 x441 x443 ->
    owl_stub_82_cblas_dspmv x431 x432 x433 x434 (CI.cptr x435) (CI.cptr x437)
    x439 x440 (CI.cptr x441) x443)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x449,
                 Function
                   (CI.Pointer x451,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Primitive CI.Float,
                          Function
                            (CI.Pointer x455,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_sspmv" ->
  (fun x444 x445 x446 x447 x448 x450 x452 x453 x454 x456 ->
    owl_stub_81_cblas_sspmv x444 x445 x446 x447 (CI.cptr x448) (CI.cptr x450)
    x452 x453 (CI.cptr x454) x456)
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
                   (CI.Pointer x463,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x466,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Primitive CI.Double,
                                Function
                                  (CI.Pointer x470,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_dsbmv" ->
  (fun x457 x458 x459 x460 x461 x462 x464 x465 x467 x468 x469 x471 ->
    owl_stub_80_cblas_dsbmv x457 x458 x459 x460 x461 (CI.cptr x462) x464
    (CI.cptr x465) x467 x468 (CI.cptr x469) x471)
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
                   (CI.Pointer x478,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x481,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Primitive CI.Float,
                                Function
                                  (CI.Pointer x485,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_ssbmv" ->
  (fun x472 x473 x474 x475 x476 x477 x479 x480 x482 x483 x484 x486 ->
    owl_stub_79_cblas_ssbmv x472 x473 x474 x475 x476 (CI.cptr x477) x479
    (CI.cptr x480) x482 x483 (CI.cptr x484) x486)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer x492,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x495,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Primitive CI.Double,
                             Function
                               (CI.Pointer x499,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_dsymv" ->
  (fun x487 x488 x489 x490 x491 x493 x494 x496 x497 x498 x500 ->
    owl_stub_78_cblas_dsymv x487 x488 x489 x490 (CI.cptr x491) x493
    (CI.cptr x494) x496 x497 (CI.cptr x498) x500)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x506,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x509,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Primitive CI.Float,
                             Function
                               (CI.Pointer x513,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_ssymv" ->
  (fun x501 x502 x503 x504 x505 x507 x508 x510 x511 x512 x514 ->
    owl_stub_77_cblas_ssymv x501 x502 x503 x504 (CI.cptr x505) x507
    (CI.cptr x508) x510 x511 (CI.cptr x512) x514)
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
                   (CI.Pointer x521,
                    Function
                      (CI.Pointer x523,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_ztpsv" ->
  (fun x515 x516 x517 x518 x519 x520 x522 x524 ->
    owl_stub_76_cblas_ztpsv x515 x516 x517 x518 x519 (CI.cptr x520)
    (CI.cptr x522) x524)
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
                   (CI.Pointer x531,
                    Function
                      (CI.Pointer x533,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_ctpsv" ->
  (fun x525 x526 x527 x528 x529 x530 x532 x534 ->
    owl_stub_75_cblas_ctpsv x525 x526 x527 x528 x529 (CI.cptr x530)
    (CI.cptr x532) x534)
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
                   (CI.Pointer x541,
                    Function
                      (CI.Pointer x543,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_dtpsv" ->
  (fun x535 x536 x537 x538 x539 x540 x542 x544 ->
    owl_stub_74_cblas_dtpsv x535 x536 x537 x538 x539 (CI.cptr x540)
    (CI.cptr x542) x544)
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
                   (CI.Pointer x551,
                    Function
                      (CI.Pointer x553,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_stpsv" ->
  (fun x545 x546 x547 x548 x549 x550 x552 x554 ->
    owl_stub_73_cblas_stpsv x545 x546 x547 x548 x549 (CI.cptr x550)
    (CI.cptr x552) x554)
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
                      (CI.Pointer x562,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x565,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_ztbsv" ->
  (fun x555 x556 x557 x558 x559 x560 x561 x563 x564 x566 ->
    owl_stub_72_cblas_ztbsv x555 x556 x557 x558 x559 x560 (CI.cptr x561) x563
    (CI.cptr x564) x566)
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
                      (CI.Pointer x574,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x577,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_ctbsv" ->
  (fun x567 x568 x569 x570 x571 x572 x573 x575 x576 x578 ->
    owl_stub_71_cblas_ctbsv x567 x568 x569 x570 x571 x572 (CI.cptr x573) x575
    (CI.cptr x576) x578)
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
                      (CI.Pointer x586,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x589,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_dtbsv" ->
  (fun x579 x580 x581 x582 x583 x584 x585 x587 x588 x590 ->
    owl_stub_70_cblas_dtbsv x579 x580 x581 x582 x583 x584 (CI.cptr x585) x587
    (CI.cptr x588) x590)
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
                      (CI.Pointer x598,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x601,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_stbsv" ->
  (fun x591 x592 x593 x594 x595 x596 x597 x599 x600 x602 ->
    owl_stub_69_cblas_stbsv x591 x592 x593 x594 x595 x596 (CI.cptr x597) x599
    (CI.cptr x600) x602)
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
                   (CI.Pointer x609,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x612,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_ztrsv" ->
  (fun x603 x604 x605 x606 x607 x608 x610 x611 x613 ->
    owl_stub_68_cblas_ztrsv x603 x604 x605 x606 x607 (CI.cptr x608) x610
    (CI.cptr x611) x613)
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
                   (CI.Pointer x620,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x623,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_ctrsv" ->
  (fun x614 x615 x616 x617 x618 x619 x621 x622 x624 ->
    owl_stub_67_cblas_ctrsv x614 x615 x616 x617 x618 (CI.cptr x619) x621
    (CI.cptr x622) x624)
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
                   (CI.Pointer x631,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x634,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_dtrsv" ->
  (fun x625 x626 x627 x628 x629 x630 x632 x633 x635 ->
    owl_stub_66_cblas_dtrsv x625 x626 x627 x628 x629 (CI.cptr x630) x632
    (CI.cptr x633) x635)
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
                   (CI.Pointer x642,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x645,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_strsv" ->
  (fun x636 x637 x638 x639 x640 x641 x643 x644 x646 ->
    owl_stub_65_cblas_strsv x636 x637 x638 x639 x640 (CI.cptr x641) x643
    (CI.cptr x644) x646)
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
                   (CI.Pointer x653,
                    Function
                      (CI.Pointer x655,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_ztpmv" ->
  (fun x647 x648 x649 x650 x651 x652 x654 x656 ->
    owl_stub_64_cblas_ztpmv x647 x648 x649 x650 x651 (CI.cptr x652)
    (CI.cptr x654) x656)
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
                   (CI.Pointer x663,
                    Function
                      (CI.Pointer x665,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_ctpmv" ->
  (fun x657 x658 x659 x660 x661 x662 x664 x666 ->
    owl_stub_63_cblas_ctpmv x657 x658 x659 x660 x661 (CI.cptr x662)
    (CI.cptr x664) x666)
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
                   (CI.Pointer x673,
                    Function
                      (CI.Pointer x675,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_dtpmv" ->
  (fun x667 x668 x669 x670 x671 x672 x674 x676 ->
    owl_stub_62_cblas_dtpmv x667 x668 x669 x670 x671 (CI.cptr x672)
    (CI.cptr x674) x676)
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
                   (CI.Pointer x683,
                    Function
                      (CI.Pointer x685,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_stpmv" ->
  (fun x677 x678 x679 x680 x681 x682 x684 x686 ->
    owl_stub_61_cblas_stpmv x677 x678 x679 x680 x681 (CI.cptr x682)
    (CI.cptr x684) x686)
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
                      (CI.Pointer x694,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x697,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_ztbmv" ->
  (fun x687 x688 x689 x690 x691 x692 x693 x695 x696 x698 ->
    owl_stub_60_cblas_ztbmv x687 x688 x689 x690 x691 x692 (CI.cptr x693) x695
    (CI.cptr x696) x698)
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
                      (CI.Pointer x706,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x709,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_ctbmv" ->
  (fun x699 x700 x701 x702 x703 x704 x705 x707 x708 x710 ->
    owl_stub_59_cblas_ctbmv x699 x700 x701 x702 x703 x704 (CI.cptr x705) x707
    (CI.cptr x708) x710)
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
                      (CI.Pointer x718,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x721,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_dtbmv" ->
  (fun x711 x712 x713 x714 x715 x716 x717 x719 x720 x722 ->
    owl_stub_58_cblas_dtbmv x711 x712 x713 x714 x715 x716 (CI.cptr x717) x719
    (CI.cptr x720) x722)
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
                      (CI.Pointer x730,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x733,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_stbmv" ->
  (fun x723 x724 x725 x726 x727 x728 x729 x731 x732 x734 ->
    owl_stub_57_cblas_stbmv x723 x724 x725 x726 x727 x728 (CI.cptr x729) x731
    (CI.cptr x732) x734)
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
                   (CI.Pointer x741,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x744,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_ztrmv" ->
  (fun x735 x736 x737 x738 x739 x740 x742 x743 x745 ->
    owl_stub_56_cblas_ztrmv x735 x736 x737 x738 x739 (CI.cptr x740) x742
    (CI.cptr x743) x745)
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
                   (CI.Pointer x752,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x755,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_ctrmv" ->
  (fun x746 x747 x748 x749 x750 x751 x753 x754 x756 ->
    owl_stub_55_cblas_ctrmv x746 x747 x748 x749 x750 (CI.cptr x751) x753
    (CI.cptr x754) x756)
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
                   (CI.Pointer x763,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x766,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_dtrmv" ->
  (fun x757 x758 x759 x760 x761 x762 x764 x765 x767 ->
    owl_stub_54_cblas_dtrmv x757 x758 x759 x760 x761 (CI.cptr x762) x764
    (CI.cptr x765) x767)
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
                   (CI.Pointer x774,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x777,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_strmv" ->
  (fun x768 x769 x770 x771 x772 x773 x775 x776 x778 ->
    owl_stub_53_cblas_strmv x768 x769 x770 x771 x772 (CI.cptr x773) x775
    (CI.cptr x776) x778)
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
                      (CI.Pointer x786,
                       Function
                         (CI.Pointer x788,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x791,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Pointer x794,
                                      Function
                                        (CI.Pointer x796,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_zgbmv" ->
  (fun x779 x780 x781 x782 x783 x784 x785 x787 x789 x790 x792 x793 x795 x797
    ->
    owl_stub_52_cblas_zgbmv x779 x780 x781 x782 x783 x784 (CI.cptr x785)
    (CI.cptr x787) x789 (CI.cptr x790) x792 (CI.cptr x793) (CI.cptr x795)
    x797)
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
                      (CI.Pointer x805,
                       Function
                         (CI.Pointer x807,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x810,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Pointer x813,
                                      Function
                                        (CI.Pointer x815,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_cgbmv" ->
  (fun x798 x799 x800 x801 x802 x803 x804 x806 x808 x809 x811 x812 x814 x816
    ->
    owl_stub_51_cblas_cgbmv x798 x799 x800 x801 x802 x803 (CI.cptr x804)
    (CI.cptr x806) x808 (CI.cptr x809) x811 (CI.cptr x812) (CI.cptr x814)
    x816)
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
                         (CI.Pointer x825,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x828,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Primitive CI.Double,
                                      Function
                                        (CI.Pointer x832,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_dgbmv" ->
  (fun x817 x818 x819 x820 x821 x822 x823 x824 x826 x827 x829 x830 x831 x833
    ->
    owl_stub_50_cblas_dgbmv x817 x818 x819 x820 x821 x822 x823 (CI.cptr x824)
    x826 (CI.cptr x827) x829 x830 (CI.cptr x831) x833)
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
                         (CI.Pointer x842,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x845,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Primitive CI.Float,
                                      Function
                                        (CI.Pointer x849,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_sgbmv" ->
  (fun x834 x835 x836 x837 x838 x839 x840 x841 x843 x844 x846 x847 x848 x850
    ->
    owl_stub_49_cblas_sgbmv x834 x835 x836 x837 x838 x839 x840 (CI.cptr x841)
    x843 (CI.cptr x844) x846 x847 (CI.cptr x848) x850)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x856,
                 Function
                   (CI.Pointer x858,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x861,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x864,
                                Function
                                  (CI.Pointer x866,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_zgemv" ->
  (fun x851 x852 x853 x854 x855 x857 x859 x860 x862 x863 x865 x867 ->
    owl_stub_48_cblas_zgemv x851 x852 x853 x854 (CI.cptr x855) (CI.cptr x857)
    x859 (CI.cptr x860) x862 (CI.cptr x863) (CI.cptr x865) x867)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x873,
                 Function
                   (CI.Pointer x875,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x878,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x881,
                                Function
                                  (CI.Pointer x883,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_cgemv" ->
  (fun x868 x869 x870 x871 x872 x874 x876 x877 x879 x880 x882 x884 ->
    owl_stub_47_cblas_cgemv x868 x869 x870 x871 (CI.cptr x872) (CI.cptr x874)
    x876 (CI.cptr x877) x879 (CI.cptr x880) (CI.cptr x882) x884)
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
                   (CI.Pointer x891,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x894,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Primitive CI.Double,
                                Function
                                  (CI.Pointer x898,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_dgemv" ->
  (fun x885 x886 x887 x888 x889 x890 x892 x893 x895 x896 x897 x899 ->
    owl_stub_46_cblas_dgemv x885 x886 x887 x888 x889 (CI.cptr x890) x892
    (CI.cptr x893) x895 x896 (CI.cptr x897) x899)
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
                   (CI.Pointer x906,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x909,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Primitive CI.Float,
                                Function
                                  (CI.Pointer x913,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_sgemv" ->
  (fun x900 x901 x902 x903 x904 x905 x907 x908 x910 x911 x912 x914 ->
    owl_stub_45_cblas_sgemv x900 x901 x902 x903 x904 (CI.cptr x905) x907
    (CI.cptr x908) x910 x911 (CI.cptr x912) x914)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x917,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Size_t)))),
  "cblas_izamax" ->
  (fun x915 x916 x918 -> owl_stub_44_cblas_izamax x915 (CI.cptr x916) x918)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x921,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Size_t)))),
  "cblas_icamax" ->
  (fun x919 x920 x922 -> owl_stub_43_cblas_icamax x919 (CI.cptr x920) x922)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x925,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Size_t)))),
  "cblas_idamax" ->
  (fun x923 x924 x926 -> owl_stub_42_cblas_idamax x923 (CI.cptr x924) x926)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x929,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Size_t)))),
  "cblas_isamax" ->
  (fun x927 x928 x930 -> owl_stub_41_cblas_isamax x927 (CI.cptr x928) x930)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x933,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "cblas_dzasum" ->
  (fun x931 x932 x934 -> owl_stub_40_cblas_dzasum x931 (CI.cptr x932) x934)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x937,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))),
  "cblas_scasum" ->
  (fun x935 x936 x938 -> owl_stub_39_cblas_scasum x935 (CI.cptr x936) x938)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x941,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "cblas_dasum" ->
  (fun x939 x940 x942 -> owl_stub_38_cblas_dasum x939 (CI.cptr x940) x942)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x945,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))),
  "cblas_sasum" ->
  (fun x943 x944 x946 -> owl_stub_37_cblas_sasum x943 (CI.cptr x944) x946)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x949,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "cblas_dznrm2" ->
  (fun x947 x948 x950 -> owl_stub_36_cblas_dznrm2 x947 (CI.cptr x948) x950)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x953,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))),
  "cblas_scnrm2" ->
  (fun x951 x952 x954 -> owl_stub_35_cblas_scnrm2 x951 (CI.cptr x952) x954)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x957,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "cblas_dnrm2" ->
  (fun x955 x956 x958 -> owl_stub_34_cblas_dnrm2 x955 (CI.cptr x956) x958)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x961,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))),
  "cblas_snrm2" ->
  (fun x959 x960 x962 -> owl_stub_33_cblas_snrm2 x959 (CI.cptr x960) x962)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x965,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x968,
              Function
                (CI.Primitive CI.Int,
                 Function (CI.Pointer x971, Returns CI.Void)))))),
  "cblas_zdotc_sub" ->
  (fun x963 x964 x966 x967 x969 x970 ->
    owl_stub_32_cblas_zdotc_sub x963 (CI.cptr x964) x966 (CI.cptr x967) x969
    (CI.cptr x970))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x974,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x977,
              Function
                (CI.Primitive CI.Int,
                 Function (CI.Pointer x980, Returns CI.Void)))))),
  "cblas_zdotu_sub" ->
  (fun x972 x973 x975 x976 x978 x979 ->
    owl_stub_31_cblas_zdotu_sub x972 (CI.cptr x973) x975 (CI.cptr x976) x978
    (CI.cptr x979))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x983,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x986,
              Function
                (CI.Primitive CI.Int,
                 Function (CI.Pointer x989, Returns CI.Void)))))),
  "cblas_cdotc_sub" ->
  (fun x981 x982 x984 x985 x987 x988 ->
    owl_stub_30_cblas_cdotc_sub x981 (CI.cptr x982) x984 (CI.cptr x985) x987
    (CI.cptr x988))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x992,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x995,
              Function
                (CI.Primitive CI.Int,
                 Function (CI.Pointer x998, Returns CI.Void)))))),
  "cblas_cdotu_sub" ->
  (fun x990 x991 x993 x994 x996 x997 ->
    owl_stub_29_cblas_cdotu_sub x990 (CI.cptr x991) x993 (CI.cptr x994) x996
    (CI.cptr x997))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1001,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1004,
              Function
                (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))))),
  "cblas_dsdot" ->
  (fun x999 x1000 x1002 x1003 x1005 ->
    owl_stub_28_cblas_dsdot x999 (CI.cptr x1000) x1002 (CI.cptr x1003) x1005)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Float,
        Function
          (CI.Pointer x1009,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x1012,
                 Function
                   (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float))))))),
  "cblas_sdsdot" ->
  (fun x1006 x1007 x1008 x1010 x1011 x1013 ->
    owl_stub_27_cblas_sdsdot x1006 x1007 (CI.cptr x1008) x1010
    (CI.cptr x1011) x1013)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1016,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1019,
              Function
                (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))))),
  "cblas_ddot" ->
  (fun x1014 x1015 x1017 x1018 x1020 ->
    owl_stub_26_cblas_ddot x1014 (CI.cptr x1015) x1017 (CI.cptr x1018) x1020)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1023,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1026,
              Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))))),
  "cblas_sdot" ->
  (fun x1021 x1022 x1024 x1025 x1027 ->
    owl_stub_25_cblas_sdot x1021 (CI.cptr x1022) x1024 (CI.cptr x1025) x1027)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1030,
        Function
          (CI.Pointer x1032,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x1035,
                 Function (CI.Primitive CI.Int, Returns CI.Void)))))),
  "cblas_zaxpy" ->
  (fun x1028 x1029 x1031 x1033 x1034 x1036 ->
    owl_stub_24_cblas_zaxpy x1028 (CI.cptr x1029) (CI.cptr x1031) x1033
    (CI.cptr x1034) x1036)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1039,
        Function
          (CI.Pointer x1041,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x1044,
                 Function (CI.Primitive CI.Int, Returns CI.Void)))))),
  "cblas_caxpy" ->
  (fun x1037 x1038 x1040 x1042 x1043 x1045 ->
    owl_stub_23_cblas_caxpy x1037 (CI.cptr x1038) (CI.cptr x1040) x1042
    (CI.cptr x1043) x1045)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Double,
        Function
          (CI.Pointer x1049,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x1052,
                 Function (CI.Primitive CI.Int, Returns CI.Void)))))),
  "cblas_daxpy" ->
  (fun x1046 x1047 x1048 x1050 x1051 x1053 ->
    owl_stub_22_cblas_daxpy x1046 x1047 (CI.cptr x1048) x1050 (CI.cptr x1051)
    x1053)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Float,
        Function
          (CI.Pointer x1057,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x1060,
                 Function (CI.Primitive CI.Int, Returns CI.Void)))))),
  "cblas_saxpy" ->
  (fun x1054 x1055 x1056 x1058 x1059 x1061 ->
    owl_stub_21_cblas_saxpy x1054 x1055 (CI.cptr x1056) x1058 (CI.cptr x1059)
    x1061)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1064,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1067,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_zcopy" ->
  (fun x1062 x1063 x1065 x1066 x1068 ->
    owl_stub_20_cblas_zcopy x1062 (CI.cptr x1063) x1065 (CI.cptr x1066) x1068)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1071,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1074,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_ccopy" ->
  (fun x1069 x1070 x1072 x1073 x1075 ->
    owl_stub_19_cblas_ccopy x1069 (CI.cptr x1070) x1072 (CI.cptr x1073) x1075)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1078,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1081,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_dcopy" ->
  (fun x1076 x1077 x1079 x1080 x1082 ->
    owl_stub_18_cblas_dcopy x1076 (CI.cptr x1077) x1079 (CI.cptr x1080) x1082)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1085,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1088,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_scopy" ->
  (fun x1083 x1084 x1086 x1087 x1089 ->
    owl_stub_17_cblas_scopy x1083 (CI.cptr x1084) x1086 (CI.cptr x1087) x1089)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Double,
        Function
          (CI.Pointer x1093, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_zdscal" ->
  (fun x1090 x1091 x1092 x1094 ->
    owl_stub_16_cblas_zdscal x1090 x1091 (CI.cptr x1092) x1094)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Float,
        Function
          (CI.Pointer x1098, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_csscal" ->
  (fun x1095 x1096 x1097 x1099 ->
    owl_stub_15_cblas_csscal x1095 x1096 (CI.cptr x1097) x1099)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1102,
        Function
          (CI.Pointer x1104, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_zscal" ->
  (fun x1100 x1101 x1103 x1105 ->
    owl_stub_14_cblas_zscal x1100 (CI.cptr x1101) (CI.cptr x1103) x1105)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1108,
        Function
          (CI.Pointer x1110, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_cscal" ->
  (fun x1106 x1107 x1109 x1111 ->
    owl_stub_13_cblas_cscal x1106 (CI.cptr x1107) (CI.cptr x1109) x1111)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Double,
        Function
          (CI.Pointer x1115, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_dscal" ->
  (fun x1112 x1113 x1114 x1116 ->
    owl_stub_12_cblas_dscal x1112 x1113 (CI.cptr x1114) x1116)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Float,
        Function
          (CI.Pointer x1120, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_sscal" ->
  (fun x1117 x1118 x1119 x1121 ->
    owl_stub_11_cblas_sscal x1117 x1118 (CI.cptr x1119) x1121)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1124,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1127,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_zswap" ->
  (fun x1122 x1123 x1125 x1126 x1128 ->
    owl_stub_10_cblas_zswap x1122 (CI.cptr x1123) x1125 (CI.cptr x1126) x1128)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1131,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1134,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_cswap" ->
  (fun x1129 x1130 x1132 x1133 x1135 ->
    owl_stub_9_cblas_cswap x1129 (CI.cptr x1130) x1132 (CI.cptr x1133) x1135)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1138,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1141,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_dswap" ->
  (fun x1136 x1137 x1139 x1140 x1142 ->
    owl_stub_8_cblas_dswap x1136 (CI.cptr x1137) x1139 (CI.cptr x1140) x1142)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1145,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1148,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_sswap" ->
  (fun x1143 x1144 x1146 x1147 x1149 ->
    owl_stub_7_cblas_sswap x1143 (CI.cptr x1144) x1146 (CI.cptr x1147) x1149)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1152,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1155,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Double,
                    Function (CI.Primitive CI.Double, Returns CI.Void))))))),
  "cblas_drot" ->
  (fun x1150 x1151 x1153 x1154 x1156 x1157 x1158 ->
    owl_stub_6_cblas_drot x1150 (CI.cptr x1151) x1153 (CI.cptr x1154) x1156
    x1157 x1158)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1161,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1164,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Float,
                    Function (CI.Primitive CI.Float, Returns CI.Void))))))),
  "cblas_srot" ->
  (fun x1159 x1160 x1162 x1163 x1165 x1166 x1167 ->
    owl_stub_5_cblas_srot x1159 (CI.cptr x1160) x1162 (CI.cptr x1163) x1165
    x1166 x1167)
| Function
    (CI.Pointer x1169,
     Function
       (CI.Pointer x1171,
        Function
          (CI.Pointer x1173,
           Function
             (CI.Primitive CI.Double,
              Function (CI.Pointer x1176, Returns CI.Void))))),
  "cblas_drotmg" ->
  (fun x1168 x1170 x1172 x1174 x1175 ->
    owl_stub_4_cblas_drotmg (CI.cptr x1168) (CI.cptr x1170) (CI.cptr x1172)
    x1174 (CI.cptr x1175))
| Function
    (CI.Pointer x1178,
     Function
       (CI.Pointer x1180,
        Function
          (CI.Pointer x1182,
           Function
             (CI.Primitive CI.Float,
              Function (CI.Pointer x1185, Returns CI.Void))))),
  "cblas_srotmg" ->
  (fun x1177 x1179 x1181 x1183 x1184 ->
    owl_stub_3_cblas_srotmg (CI.cptr x1177) (CI.cptr x1179) (CI.cptr x1181)
    x1183 (CI.cptr x1184))
| Function
    (CI.Pointer x1187,
     Function
       (CI.Pointer x1189,
        Function
          (CI.Pointer x1191, Function (CI.Pointer x1193, Returns CI.Void)))),
  "cblas_drotg" ->
  (fun x1186 x1188 x1190 x1192 ->
    owl_stub_2_cblas_drotg (CI.cptr x1186) (CI.cptr x1188) (CI.cptr x1190)
    (CI.cptr x1192))
| Function
    (CI.Pointer x1195,
     Function
       (CI.Pointer x1197,
        Function
          (CI.Pointer x1199, Function (CI.Pointer x1201, Returns CI.Void)))),
  "cblas_srotg" ->
  (fun x1194 x1196 x1198 x1200 ->
    owl_stub_1_cblas_srotg (CI.cptr x1194) (CI.cptr x1196) (CI.cptr x1198)
    (CI.cptr x1200))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

