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
                   (CI.Pointer x7,
                    Function
                      (CI.Pointer x9,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x12,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer x15,
                                   Function
                                     (CI.Pointer x17,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_zsymm" ->
  (fun x1 x2 x3 x4 x5 x6 x8 x10 x11 x13 x14 x16 x18 ->
    owl_stub_118_cblas_zsymm x1 x2 x3 x4 x5 (CI.cptr x6) (CI.cptr x8) x10
    (CI.cptr x11) x13 (CI.cptr x14) (CI.cptr x16) x18)
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
                   (CI.Pointer x25,
                    Function
                      (CI.Pointer x27,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x30,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer x33,
                                   Function
                                     (CI.Pointer x35,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_csymm" ->
  (fun x19 x20 x21 x22 x23 x24 x26 x28 x29 x31 x32 x34 x36 ->
    owl_stub_117_cblas_csymm x19 x20 x21 x22 x23 (CI.cptr x24) (CI.cptr x26)
    x28 (CI.cptr x29) x31 (CI.cptr x32) (CI.cptr x34) x36)
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
                      (CI.Pointer x44,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x47,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Primitive CI.Double,
                                   Function
                                     (CI.Pointer x51,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_dsymm" ->
  (fun x37 x38 x39 x40 x41 x42 x43 x45 x46 x48 x49 x50 x52 ->
    owl_stub_116_cblas_dsymm x37 x38 x39 x40 x41 x42 (CI.cptr x43) x45
    (CI.cptr x46) x48 x49 (CI.cptr x50) x52)
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
                      (CI.Pointer x60,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x63,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Primitive CI.Float,
                                   Function
                                     (CI.Pointer x67,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_ssymm" ->
  (fun x53 x54 x55 x56 x57 x58 x59 x61 x62 x64 x65 x66 x68 ->
    owl_stub_115_cblas_ssymm x53 x54 x55 x56 x57 x58 (CI.cptr x59) x61
    (CI.cptr x62) x64 x65 (CI.cptr x66) x68)
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
                      (CI.Pointer x76,
                       Function
                         (CI.Pointer x78,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x81,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Pointer x84,
                                      Function
                                        (CI.Pointer x86,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_zgemm" ->
  (fun x69 x70 x71 x72 x73 x74 x75 x77 x79 x80 x82 x83 x85 x87 ->
    owl_stub_114_cblas_zgemm x69 x70 x71 x72 x73 x74 (CI.cptr x75)
    (CI.cptr x77) x79 (CI.cptr x80) x82 (CI.cptr x83) (CI.cptr x85) x87)
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
                      (CI.Pointer x95,
                       Function
                         (CI.Pointer x97,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x100,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Pointer x103,
                                      Function
                                        (CI.Pointer x105,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_cgemm" ->
  (fun x88 x89 x90 x91 x92 x93 x94 x96 x98 x99 x101 x102 x104 x106 ->
    owl_stub_113_cblas_cgemm x88 x89 x90 x91 x92 x93 (CI.cptr x94)
    (CI.cptr x96) x98 (CI.cptr x99) x101 (CI.cptr x102) (CI.cptr x104) x106)
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
                         (CI.Pointer x115,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x118,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Primitive CI.Double,
                                      Function
                                        (CI.Pointer x122,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_dgemm" ->
  (fun x107 x108 x109 x110 x111 x112 x113 x114 x116 x117 x119 x120 x121 x123
    ->
    owl_stub_112_cblas_dgemm x107 x108 x109 x110 x111 x112 x113
    (CI.cptr x114) x116 (CI.cptr x117) x119 x120 (CI.cptr x121) x123)
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
                         (CI.Pointer x132,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x135,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Primitive CI.Float,
                                      Function
                                        (CI.Pointer x139,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_sgemm" ->
  (fun x124 x125 x126 x127 x128 x129 x130 x131 x133 x134 x136 x137 x138 x140
    ->
    owl_stub_111_cblas_sgemm x124 x125 x126 x127 x128 x129 x130
    (CI.cptr x131) x133 (CI.cptr x134) x136 x137 (CI.cptr x138) x140)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x145,
              Function
                (CI.Pointer x147,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x150,
                       Function
                         (CI.Primitive CI.Int,
                          Function (CI.Pointer x153, Returns CI.Void))))))))),
  "cblas_zhpr2" ->
  (fun x141 x142 x143 x144 x146 x148 x149 x151 x152 ->
    owl_stub_110_cblas_zhpr2 x141 x142 x143 (CI.cptr x144) (CI.cptr x146)
    x148 (CI.cptr x149) x151 (CI.cptr x152))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x158,
              Function
                (CI.Pointer x160,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x163,
                       Function
                         (CI.Primitive CI.Int,
                          Function (CI.Pointer x166, Returns CI.Void))))))))),
  "cblas_chpr2" ->
  (fun x154 x155 x156 x157 x159 x161 x162 x164 x165 ->
    owl_stub_109_cblas_chpr2 x154 x155 x156 (CI.cptr x157) (CI.cptr x159)
    x161 (CI.cptr x162) x164 (CI.cptr x165))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x171,
              Function
                (CI.Pointer x173,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x176,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x179,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_zher2" ->
  (fun x167 x168 x169 x170 x172 x174 x175 x177 x178 x180 ->
    owl_stub_108_cblas_zher2 x167 x168 x169 (CI.cptr x170) (CI.cptr x172)
    x174 (CI.cptr x175) x177 (CI.cptr x178) x180)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x185,
              Function
                (CI.Pointer x187,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x190,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x193,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_cher2" ->
  (fun x181 x182 x183 x184 x186 x188 x189 x191 x192 x194 ->
    owl_stub_107_cblas_cher2 x181 x182 x183 (CI.cptr x184) (CI.cptr x186)
    x188 (CI.cptr x189) x191 (CI.cptr x192) x194)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x200,
                 Function
                   (CI.Primitive CI.Int,
                    Function (CI.Pointer x203, Returns CI.Void))))))),
  "cblas_zhpr" ->
  (fun x195 x196 x197 x198 x199 x201 x202 ->
    owl_stub_106_cblas_zhpr x195 x196 x197 x198 (CI.cptr x199) x201
    (CI.cptr x202))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x209,
                 Function
                   (CI.Primitive CI.Int,
                    Function (CI.Pointer x212, Returns CI.Void))))))),
  "cblas_chpr" ->
  (fun x204 x205 x206 x207 x208 x210 x211 ->
    owl_stub_105_cblas_chpr x204 x205 x206 x207 (CI.cptr x208) x210
    (CI.cptr x211))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x218,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x221,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_zher" ->
  (fun x213 x214 x215 x216 x217 x219 x220 x222 ->
    owl_stub_104_cblas_zher x213 x214 x215 x216 (CI.cptr x217) x219
    (CI.cptr x220) x222)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x228,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x231,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_cher" ->
  (fun x223 x224 x225 x226 x227 x229 x230 x232 ->
    owl_stub_103_cblas_cher x223 x224 x225 x226 (CI.cptr x227) x229
    (CI.cptr x230) x232)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x237,
              Function
                (CI.Pointer x239,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x242,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x245,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_zgerc" ->
  (fun x233 x234 x235 x236 x238 x240 x241 x243 x244 x246 ->
    owl_stub_102_cblas_zgerc x233 x234 x235 (CI.cptr x236) (CI.cptr x238)
    x240 (CI.cptr x241) x243 (CI.cptr x244) x246)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x251,
              Function
                (CI.Pointer x253,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x256,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x259,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_cgerc" ->
  (fun x247 x248 x249 x250 x252 x254 x255 x257 x258 x260 ->
    owl_stub_101_cblas_cgerc x247 x248 x249 (CI.cptr x250) (CI.cptr x252)
    x254 (CI.cptr x255) x257 (CI.cptr x258) x260)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x265,
              Function
                (CI.Pointer x267,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x270,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x273,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_zgeru" ->
  (fun x261 x262 x263 x264 x266 x268 x269 x271 x272 x274 ->
    owl_stub_100_cblas_zgeru x261 x262 x263 (CI.cptr x264) (CI.cptr x266)
    x268 (CI.cptr x269) x271 (CI.cptr x272) x274)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x279,
              Function
                (CI.Pointer x281,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x284,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x287,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_cgeru" ->
  (fun x275 x276 x277 x278 x280 x282 x283 x285 x286 x288 ->
    owl_stub_99_cblas_cgeru x275 x276 x277 (CI.cptr x278) (CI.cptr x280) x282
    (CI.cptr x283) x285 (CI.cptr x286) x288)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x293,
              Function
                (CI.Pointer x295,
                 Function
                   (CI.Pointer x297,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x300,
                          Function
                            (CI.Pointer x302,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_zhpmv" ->
  (fun x289 x290 x291 x292 x294 x296 x298 x299 x301 x303 ->
    owl_stub_98_cblas_zhpmv x289 x290 x291 (CI.cptr x292) (CI.cptr x294)
    (CI.cptr x296) x298 (CI.cptr x299) (CI.cptr x301) x303)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x308,
              Function
                (CI.Pointer x310,
                 Function
                   (CI.Pointer x312,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x315,
                          Function
                            (CI.Pointer x317,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_chpmv" ->
  (fun x304 x305 x306 x307 x309 x311 x313 x314 x316 x318 ->
    owl_stub_97_cblas_chpmv x304 x305 x306 (CI.cptr x307) (CI.cptr x309)
    (CI.cptr x311) x313 (CI.cptr x314) (CI.cptr x316) x318)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x324,
                 Function
                   (CI.Pointer x326,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x329,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x332,
                                Function
                                  (CI.Pointer x334,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_zhbmv" ->
  (fun x319 x320 x321 x322 x323 x325 x327 x328 x330 x331 x333 x335 ->
    owl_stub_96_cblas_zhbmv x319 x320 x321 x322 (CI.cptr x323) (CI.cptr x325)
    x327 (CI.cptr x328) x330 (CI.cptr x331) (CI.cptr x333) x335)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x341,
                 Function
                   (CI.Pointer x343,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x346,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x349,
                                Function
                                  (CI.Pointer x351,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_chbmv" ->
  (fun x336 x337 x338 x339 x340 x342 x344 x345 x347 x348 x350 x352 ->
    owl_stub_95_cblas_chbmv x336 x337 x338 x339 (CI.cptr x340) (CI.cptr x342)
    x344 (CI.cptr x345) x347 (CI.cptr x348) (CI.cptr x350) x352)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x357,
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
                             Function
                               (CI.Pointer x367,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_zhemv" ->
  (fun x353 x354 x355 x356 x358 x360 x361 x363 x364 x366 x368 ->
    owl_stub_94_cblas_zhemv x353 x354 x355 (CI.cptr x356) (CI.cptr x358) x360
    (CI.cptr x361) x363 (CI.cptr x364) (CI.cptr x366) x368)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x373,
              Function
                (CI.Pointer x375,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x378,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x381,
                             Function
                               (CI.Pointer x383,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_chemv" ->
  (fun x369 x370 x371 x372 x374 x376 x377 x379 x380 x382 x384 ->
    owl_stub_93_cblas_chemv x369 x370 x371 (CI.cptr x372) (CI.cptr x374) x376
    (CI.cptr x377) x379 (CI.cptr x380) (CI.cptr x382) x384)
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
                       Function
                         (CI.Primitive CI.Int,
                          Function (CI.Pointer x396, Returns CI.Void))))))))),
  "cblas_dspr2" ->
  (fun x385 x386 x387 x388 x389 x391 x392 x394 x395 ->
    owl_stub_92_cblas_dspr2 x385 x386 x387 x388 (CI.cptr x389) x391
    (CI.cptr x392) x394 (CI.cptr x395))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x402,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x405,
                       Function
                         (CI.Primitive CI.Int,
                          Function (CI.Pointer x408, Returns CI.Void))))))))),
  "cblas_sspr2" ->
  (fun x397 x398 x399 x400 x401 x403 x404 x406 x407 ->
    owl_stub_91_cblas_sspr2 x397 x398 x399 x400 (CI.cptr x401) x403
    (CI.cptr x404) x406 (CI.cptr x407))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer x414,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x417,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x420,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_dsyr2" ->
  (fun x409 x410 x411 x412 x413 x415 x416 x418 x419 x421 ->
    owl_stub_90_cblas_dsyr2 x409 x410 x411 x412 (CI.cptr x413) x415
    (CI.cptr x416) x418 (CI.cptr x419) x421)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x427,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x430,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x433,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_ssyr2" ->
  (fun x422 x423 x424 x425 x426 x428 x429 x431 x432 x434 ->
    owl_stub_89_cblas_ssyr2 x422 x423 x424 x425 (CI.cptr x426) x428
    (CI.cptr x429) x431 (CI.cptr x432) x434)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer x440,
                 Function
                   (CI.Primitive CI.Int,
                    Function (CI.Pointer x443, Returns CI.Void))))))),
  "cblas_dspr" ->
  (fun x435 x436 x437 x438 x439 x441 x442 ->
    owl_stub_88_cblas_dspr x435 x436 x437 x438 (CI.cptr x439) x441
    (CI.cptr x442))
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
                   (CI.Primitive CI.Int,
                    Function (CI.Pointer x452, Returns CI.Void))))))),
  "cblas_sspr" ->
  (fun x444 x445 x446 x447 x448 x450 x451 ->
    owl_stub_87_cblas_sspr x444 x445 x446 x447 (CI.cptr x448) x450
    (CI.cptr x451))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer x458,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x461,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_dsyr" ->
  (fun x453 x454 x455 x456 x457 x459 x460 x462 ->
    owl_stub_86_cblas_dsyr x453 x454 x455 x456 (CI.cptr x457) x459
    (CI.cptr x460) x462)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x468,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x471,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_ssyr" ->
  (fun x463 x464 x465 x466 x467 x469 x470 x472 ->
    owl_stub_85_cblas_ssyr x463 x464 x465 x466 (CI.cptr x467) x469
    (CI.cptr x470) x472)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer x478,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x481,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x484,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_dger" ->
  (fun x473 x474 x475 x476 x477 x479 x480 x482 x483 x485 ->
    owl_stub_84_cblas_dger x473 x474 x475 x476 (CI.cptr x477) x479
    (CI.cptr x480) x482 (CI.cptr x483) x485)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x491,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x494,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x497,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_sger" ->
  (fun x486 x487 x488 x489 x490 x492 x493 x495 x496 x498 ->
    owl_stub_83_cblas_sger x486 x487 x488 x489 (CI.cptr x490) x492
    (CI.cptr x493) x495 (CI.cptr x496) x498)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer x504,
                 Function
                   (CI.Pointer x506,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Primitive CI.Double,
                          Function
                            (CI.Pointer x510,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_dspmv" ->
  (fun x499 x500 x501 x502 x503 x505 x507 x508 x509 x511 ->
    owl_stub_82_cblas_dspmv x499 x500 x501 x502 (CI.cptr x503) (CI.cptr x505)
    x507 x508 (CI.cptr x509) x511)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x517,
                 Function
                   (CI.Pointer x519,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Primitive CI.Float,
                          Function
                            (CI.Pointer x523,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_sspmv" ->
  (fun x512 x513 x514 x515 x516 x518 x520 x521 x522 x524 ->
    owl_stub_81_cblas_sspmv x512 x513 x514 x515 (CI.cptr x516) (CI.cptr x518)
    x520 x521 (CI.cptr x522) x524)
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
                   (CI.Pointer x531,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x534,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Primitive CI.Double,
                                Function
                                  (CI.Pointer x538,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_dsbmv" ->
  (fun x525 x526 x527 x528 x529 x530 x532 x533 x535 x536 x537 x539 ->
    owl_stub_80_cblas_dsbmv x525 x526 x527 x528 x529 (CI.cptr x530) x532
    (CI.cptr x533) x535 x536 (CI.cptr x537) x539)
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
                   (CI.Pointer x546,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x549,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Primitive CI.Float,
                                Function
                                  (CI.Pointer x553,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_ssbmv" ->
  (fun x540 x541 x542 x543 x544 x545 x547 x548 x550 x551 x552 x554 ->
    owl_stub_79_cblas_ssbmv x540 x541 x542 x543 x544 (CI.cptr x545) x547
    (CI.cptr x548) x550 x551 (CI.cptr x552) x554)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer x560,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x563,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Primitive CI.Double,
                             Function
                               (CI.Pointer x567,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_dsymv" ->
  (fun x555 x556 x557 x558 x559 x561 x562 x564 x565 x566 x568 ->
    owl_stub_78_cblas_dsymv x555 x556 x557 x558 (CI.cptr x559) x561
    (CI.cptr x562) x564 x565 (CI.cptr x566) x568)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x574,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x577,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Primitive CI.Float,
                             Function
                               (CI.Pointer x581,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_ssymv" ->
  (fun x569 x570 x571 x572 x573 x575 x576 x578 x579 x580 x582 ->
    owl_stub_77_cblas_ssymv x569 x570 x571 x572 (CI.cptr x573) x575
    (CI.cptr x576) x578 x579 (CI.cptr x580) x582)
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
                   (CI.Pointer x589,
                    Function
                      (CI.Pointer x591,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_ztpsv" ->
  (fun x583 x584 x585 x586 x587 x588 x590 x592 ->
    owl_stub_76_cblas_ztpsv x583 x584 x585 x586 x587 (CI.cptr x588)
    (CI.cptr x590) x592)
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
                   (CI.Pointer x599,
                    Function
                      (CI.Pointer x601,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_ctpsv" ->
  (fun x593 x594 x595 x596 x597 x598 x600 x602 ->
    owl_stub_75_cblas_ctpsv x593 x594 x595 x596 x597 (CI.cptr x598)
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
                      (CI.Pointer x611,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_dtpsv" ->
  (fun x603 x604 x605 x606 x607 x608 x610 x612 ->
    owl_stub_74_cblas_dtpsv x603 x604 x605 x606 x607 (CI.cptr x608)
    (CI.cptr x610) x612)
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
                   (CI.Pointer x619,
                    Function
                      (CI.Pointer x621,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_stpsv" ->
  (fun x613 x614 x615 x616 x617 x618 x620 x622 ->
    owl_stub_73_cblas_stpsv x613 x614 x615 x616 x617 (CI.cptr x618)
    (CI.cptr x620) x622)
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
                      (CI.Pointer x630,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x633,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_ztbsv" ->
  (fun x623 x624 x625 x626 x627 x628 x629 x631 x632 x634 ->
    owl_stub_72_cblas_ztbsv x623 x624 x625 x626 x627 x628 (CI.cptr x629) x631
    (CI.cptr x632) x634)
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
                      (CI.Pointer x642,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x645,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_ctbsv" ->
  (fun x635 x636 x637 x638 x639 x640 x641 x643 x644 x646 ->
    owl_stub_71_cblas_ctbsv x635 x636 x637 x638 x639 x640 (CI.cptr x641) x643
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
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x654,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x657,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_dtbsv" ->
  (fun x647 x648 x649 x650 x651 x652 x653 x655 x656 x658 ->
    owl_stub_70_cblas_dtbsv x647 x648 x649 x650 x651 x652 (CI.cptr x653) x655
    (CI.cptr x656) x658)
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
                      (CI.Pointer x666,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x669,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_stbsv" ->
  (fun x659 x660 x661 x662 x663 x664 x665 x667 x668 x670 ->
    owl_stub_69_cblas_stbsv x659 x660 x661 x662 x663 x664 (CI.cptr x665) x667
    (CI.cptr x668) x670)
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
                   (CI.Pointer x677,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x680,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_ztrsv" ->
  (fun x671 x672 x673 x674 x675 x676 x678 x679 x681 ->
    owl_stub_68_cblas_ztrsv x671 x672 x673 x674 x675 (CI.cptr x676) x678
    (CI.cptr x679) x681)
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
                   (CI.Pointer x688,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x691,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_ctrsv" ->
  (fun x682 x683 x684 x685 x686 x687 x689 x690 x692 ->
    owl_stub_67_cblas_ctrsv x682 x683 x684 x685 x686 (CI.cptr x687) x689
    (CI.cptr x690) x692)
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
                   (CI.Pointer x699,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x702,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_dtrsv" ->
  (fun x693 x694 x695 x696 x697 x698 x700 x701 x703 ->
    owl_stub_66_cblas_dtrsv x693 x694 x695 x696 x697 (CI.cptr x698) x700
    (CI.cptr x701) x703)
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
                   (CI.Pointer x710,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x713,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_strsv" ->
  (fun x704 x705 x706 x707 x708 x709 x711 x712 x714 ->
    owl_stub_65_cblas_strsv x704 x705 x706 x707 x708 (CI.cptr x709) x711
    (CI.cptr x712) x714)
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
                   (CI.Pointer x721,
                    Function
                      (CI.Pointer x723,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_ztpmv" ->
  (fun x715 x716 x717 x718 x719 x720 x722 x724 ->
    owl_stub_64_cblas_ztpmv x715 x716 x717 x718 x719 (CI.cptr x720)
    (CI.cptr x722) x724)
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
                   (CI.Pointer x731,
                    Function
                      (CI.Pointer x733,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_ctpmv" ->
  (fun x725 x726 x727 x728 x729 x730 x732 x734 ->
    owl_stub_63_cblas_ctpmv x725 x726 x727 x728 x729 (CI.cptr x730)
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
                      (CI.Pointer x743,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_dtpmv" ->
  (fun x735 x736 x737 x738 x739 x740 x742 x744 ->
    owl_stub_62_cblas_dtpmv x735 x736 x737 x738 x739 (CI.cptr x740)
    (CI.cptr x742) x744)
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
                   (CI.Pointer x751,
                    Function
                      (CI.Pointer x753,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_stpmv" ->
  (fun x745 x746 x747 x748 x749 x750 x752 x754 ->
    owl_stub_61_cblas_stpmv x745 x746 x747 x748 x749 (CI.cptr x750)
    (CI.cptr x752) x754)
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
                      (CI.Pointer x762,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x765,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_ztbmv" ->
  (fun x755 x756 x757 x758 x759 x760 x761 x763 x764 x766 ->
    owl_stub_60_cblas_ztbmv x755 x756 x757 x758 x759 x760 (CI.cptr x761) x763
    (CI.cptr x764) x766)
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
                      (CI.Pointer x774,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x777,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_ctbmv" ->
  (fun x767 x768 x769 x770 x771 x772 x773 x775 x776 x778 ->
    owl_stub_59_cblas_ctbmv x767 x768 x769 x770 x771 x772 (CI.cptr x773) x775
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
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x789,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_dtbmv" ->
  (fun x779 x780 x781 x782 x783 x784 x785 x787 x788 x790 ->
    owl_stub_58_cblas_dtbmv x779 x780 x781 x782 x783 x784 (CI.cptr x785) x787
    (CI.cptr x788) x790)
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
                      (CI.Pointer x798,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x801,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_stbmv" ->
  (fun x791 x792 x793 x794 x795 x796 x797 x799 x800 x802 ->
    owl_stub_57_cblas_stbmv x791 x792 x793 x794 x795 x796 (CI.cptr x797) x799
    (CI.cptr x800) x802)
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
                   (CI.Pointer x809,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x812,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_ztrmv" ->
  (fun x803 x804 x805 x806 x807 x808 x810 x811 x813 ->
    owl_stub_56_cblas_ztrmv x803 x804 x805 x806 x807 (CI.cptr x808) x810
    (CI.cptr x811) x813)
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
                   (CI.Pointer x820,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x823,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_ctrmv" ->
  (fun x814 x815 x816 x817 x818 x819 x821 x822 x824 ->
    owl_stub_55_cblas_ctrmv x814 x815 x816 x817 x818 (CI.cptr x819) x821
    (CI.cptr x822) x824)
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
                   (CI.Pointer x831,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x834,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_dtrmv" ->
  (fun x825 x826 x827 x828 x829 x830 x832 x833 x835 ->
    owl_stub_54_cblas_dtrmv x825 x826 x827 x828 x829 (CI.cptr x830) x832
    (CI.cptr x833) x835)
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
                   (CI.Pointer x842,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x845,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_strmv" ->
  (fun x836 x837 x838 x839 x840 x841 x843 x844 x846 ->
    owl_stub_53_cblas_strmv x836 x837 x838 x839 x840 (CI.cptr x841) x843
    (CI.cptr x844) x846)
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
                      (CI.Pointer x854,
                       Function
                         (CI.Pointer x856,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x859,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Pointer x862,
                                      Function
                                        (CI.Pointer x864,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_zgbmv" ->
  (fun x847 x848 x849 x850 x851 x852 x853 x855 x857 x858 x860 x861 x863 x865
    ->
    owl_stub_52_cblas_zgbmv x847 x848 x849 x850 x851 x852 (CI.cptr x853)
    (CI.cptr x855) x857 (CI.cptr x858) x860 (CI.cptr x861) (CI.cptr x863)
    x865)
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
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_cgbmv" ->
  (fun x866 x867 x868 x869 x870 x871 x872 x874 x876 x877 x879 x880 x882 x884
    ->
    owl_stub_51_cblas_cgbmv x866 x867 x868 x869 x870 x871 (CI.cptr x872)
    (CI.cptr x874) x876 (CI.cptr x877) x879 (CI.cptr x880) (CI.cptr x882)
    x884)
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
                         (CI.Pointer x893,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x896,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Primitive CI.Double,
                                      Function
                                        (CI.Pointer x900,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_dgbmv" ->
  (fun x885 x886 x887 x888 x889 x890 x891 x892 x894 x895 x897 x898 x899 x901
    ->
    owl_stub_50_cblas_dgbmv x885 x886 x887 x888 x889 x890 x891 (CI.cptr x892)
    x894 (CI.cptr x895) x897 x898 (CI.cptr x899) x901)
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
                         (CI.Pointer x910,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x913,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Primitive CI.Float,
                                      Function
                                        (CI.Pointer x917,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_sgbmv" ->
  (fun x902 x903 x904 x905 x906 x907 x908 x909 x911 x912 x914 x915 x916 x918
    ->
    owl_stub_49_cblas_sgbmv x902 x903 x904 x905 x906 x907 x908 (CI.cptr x909)
    x911 (CI.cptr x912) x914 x915 (CI.cptr x916) x918)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x924,
                 Function
                   (CI.Pointer x926,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x929,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x932,
                                Function
                                  (CI.Pointer x934,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_zgemv" ->
  (fun x919 x920 x921 x922 x923 x925 x927 x928 x930 x931 x933 x935 ->
    owl_stub_48_cblas_zgemv x919 x920 x921 x922 (CI.cptr x923) (CI.cptr x925)
    x927 (CI.cptr x928) x930 (CI.cptr x931) (CI.cptr x933) x935)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x941,
                 Function
                   (CI.Pointer x943,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x946,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x949,
                                Function
                                  (CI.Pointer x951,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_cgemv" ->
  (fun x936 x937 x938 x939 x940 x942 x944 x945 x947 x948 x950 x952 ->
    owl_stub_47_cblas_cgemv x936 x937 x938 x939 (CI.cptr x940) (CI.cptr x942)
    x944 (CI.cptr x945) x947 (CI.cptr x948) (CI.cptr x950) x952)
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
                   (CI.Pointer x959,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x962,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Primitive CI.Double,
                                Function
                                  (CI.Pointer x966,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_dgemv" ->
  (fun x953 x954 x955 x956 x957 x958 x960 x961 x963 x964 x965 x967 ->
    owl_stub_46_cblas_dgemv x953 x954 x955 x956 x957 (CI.cptr x958) x960
    (CI.cptr x961) x963 x964 (CI.cptr x965) x967)
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
                   (CI.Pointer x974,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x977,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Primitive CI.Float,
                                Function
                                  (CI.Pointer x981,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_sgemv" ->
  (fun x968 x969 x970 x971 x972 x973 x975 x976 x978 x979 x980 x982 ->
    owl_stub_45_cblas_sgemv x968 x969 x970 x971 x972 (CI.cptr x973) x975
    (CI.cptr x976) x978 x979 (CI.cptr x980) x982)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x985,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Size_t)))),
  "cblas_izamax" ->
  (fun x983 x984 x986 -> owl_stub_44_cblas_izamax x983 (CI.cptr x984) x986)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x989,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Size_t)))),
  "cblas_icamax" ->
  (fun x987 x988 x990 -> owl_stub_43_cblas_icamax x987 (CI.cptr x988) x990)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x993,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Size_t)))),
  "cblas_idamax" ->
  (fun x991 x992 x994 -> owl_stub_42_cblas_idamax x991 (CI.cptr x992) x994)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x997,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Size_t)))),
  "cblas_isamax" ->
  (fun x995 x996 x998 -> owl_stub_41_cblas_isamax x995 (CI.cptr x996) x998)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1001,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "cblas_dzasum" ->
  (fun x999 x1000 x1002 ->
    owl_stub_40_cblas_dzasum x999 (CI.cptr x1000) x1002)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1005,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))),
  "cblas_scasum" ->
  (fun x1003 x1004 x1006 ->
    owl_stub_39_cblas_scasum x1003 (CI.cptr x1004) x1006)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1009,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "cblas_dasum" ->
  (fun x1007 x1008 x1010 ->
    owl_stub_38_cblas_dasum x1007 (CI.cptr x1008) x1010)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1013,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))),
  "cblas_sasum" ->
  (fun x1011 x1012 x1014 ->
    owl_stub_37_cblas_sasum x1011 (CI.cptr x1012) x1014)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1017,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "cblas_dznrm2" ->
  (fun x1015 x1016 x1018 ->
    owl_stub_36_cblas_dznrm2 x1015 (CI.cptr x1016) x1018)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1021,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))),
  "cblas_scnrm2" ->
  (fun x1019 x1020 x1022 ->
    owl_stub_35_cblas_scnrm2 x1019 (CI.cptr x1020) x1022)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1025,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "cblas_dnrm2" ->
  (fun x1023 x1024 x1026 ->
    owl_stub_34_cblas_dnrm2 x1023 (CI.cptr x1024) x1026)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1029,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))),
  "cblas_snrm2" ->
  (fun x1027 x1028 x1030 ->
    owl_stub_33_cblas_snrm2 x1027 (CI.cptr x1028) x1030)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1033,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1036,
              Function
                (CI.Primitive CI.Int,
                 Function (CI.Pointer x1039, Returns CI.Void)))))),
  "cblas_zdotc_sub" ->
  (fun x1031 x1032 x1034 x1035 x1037 x1038 ->
    owl_stub_32_cblas_zdotc_sub x1031 (CI.cptr x1032) x1034 (CI.cptr x1035)
    x1037 (CI.cptr x1038))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1042,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1045,
              Function
                (CI.Primitive CI.Int,
                 Function (CI.Pointer x1048, Returns CI.Void)))))),
  "cblas_zdotu_sub" ->
  (fun x1040 x1041 x1043 x1044 x1046 x1047 ->
    owl_stub_31_cblas_zdotu_sub x1040 (CI.cptr x1041) x1043 (CI.cptr x1044)
    x1046 (CI.cptr x1047))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1051,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1054,
              Function
                (CI.Primitive CI.Int,
                 Function (CI.Pointer x1057, Returns CI.Void)))))),
  "cblas_cdotc_sub" ->
  (fun x1049 x1050 x1052 x1053 x1055 x1056 ->
    owl_stub_30_cblas_cdotc_sub x1049 (CI.cptr x1050) x1052 (CI.cptr x1053)
    x1055 (CI.cptr x1056))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1060,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1063,
              Function
                (CI.Primitive CI.Int,
                 Function (CI.Pointer x1066, Returns CI.Void)))))),
  "cblas_cdotu_sub" ->
  (fun x1058 x1059 x1061 x1062 x1064 x1065 ->
    owl_stub_29_cblas_cdotu_sub x1058 (CI.cptr x1059) x1061 (CI.cptr x1062)
    x1064 (CI.cptr x1065))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1069,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1072,
              Function
                (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))))),
  "cblas_dsdot" ->
  (fun x1067 x1068 x1070 x1071 x1073 ->
    owl_stub_28_cblas_dsdot x1067 (CI.cptr x1068) x1070 (CI.cptr x1071) x1073)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Float,
        Function
          (CI.Pointer x1077,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x1080,
                 Function
                   (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float))))))),
  "cblas_sdsdot" ->
  (fun x1074 x1075 x1076 x1078 x1079 x1081 ->
    owl_stub_27_cblas_sdsdot x1074 x1075 (CI.cptr x1076) x1078
    (CI.cptr x1079) x1081)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1084,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1087,
              Function
                (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))))),
  "cblas_ddot" ->
  (fun x1082 x1083 x1085 x1086 x1088 ->
    owl_stub_26_cblas_ddot x1082 (CI.cptr x1083) x1085 (CI.cptr x1086) x1088)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1091,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1094,
              Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))))),
  "cblas_sdot" ->
  (fun x1089 x1090 x1092 x1093 x1095 ->
    owl_stub_25_cblas_sdot x1089 (CI.cptr x1090) x1092 (CI.cptr x1093) x1095)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1098,
        Function
          (CI.Pointer x1100,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x1103,
                 Function (CI.Primitive CI.Int, Returns CI.Void)))))),
  "cblas_zaxpy" ->
  (fun x1096 x1097 x1099 x1101 x1102 x1104 ->
    owl_stub_24_cblas_zaxpy x1096 (CI.cptr x1097) (CI.cptr x1099) x1101
    (CI.cptr x1102) x1104)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1107,
        Function
          (CI.Pointer x1109,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x1112,
                 Function (CI.Primitive CI.Int, Returns CI.Void)))))),
  "cblas_caxpy" ->
  (fun x1105 x1106 x1108 x1110 x1111 x1113 ->
    owl_stub_23_cblas_caxpy x1105 (CI.cptr x1106) (CI.cptr x1108) x1110
    (CI.cptr x1111) x1113)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Double,
        Function
          (CI.Pointer x1117,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x1120,
                 Function (CI.Primitive CI.Int, Returns CI.Void)))))),
  "cblas_daxpy" ->
  (fun x1114 x1115 x1116 x1118 x1119 x1121 ->
    owl_stub_22_cblas_daxpy x1114 x1115 (CI.cptr x1116) x1118 (CI.cptr x1119)
    x1121)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Float,
        Function
          (CI.Pointer x1125,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x1128,
                 Function (CI.Primitive CI.Int, Returns CI.Void)))))),
  "cblas_saxpy" ->
  (fun x1122 x1123 x1124 x1126 x1127 x1129 ->
    owl_stub_21_cblas_saxpy x1122 x1123 (CI.cptr x1124) x1126 (CI.cptr x1127)
    x1129)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1132,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1135,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_zcopy" ->
  (fun x1130 x1131 x1133 x1134 x1136 ->
    owl_stub_20_cblas_zcopy x1130 (CI.cptr x1131) x1133 (CI.cptr x1134) x1136)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1139,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1142,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_ccopy" ->
  (fun x1137 x1138 x1140 x1141 x1143 ->
    owl_stub_19_cblas_ccopy x1137 (CI.cptr x1138) x1140 (CI.cptr x1141) x1143)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1146,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1149,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_dcopy" ->
  (fun x1144 x1145 x1147 x1148 x1150 ->
    owl_stub_18_cblas_dcopy x1144 (CI.cptr x1145) x1147 (CI.cptr x1148) x1150)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1153,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1156,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_scopy" ->
  (fun x1151 x1152 x1154 x1155 x1157 ->
    owl_stub_17_cblas_scopy x1151 (CI.cptr x1152) x1154 (CI.cptr x1155) x1157)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Double,
        Function
          (CI.Pointer x1161, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_zdscal" ->
  (fun x1158 x1159 x1160 x1162 ->
    owl_stub_16_cblas_zdscal x1158 x1159 (CI.cptr x1160) x1162)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Float,
        Function
          (CI.Pointer x1166, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_csscal" ->
  (fun x1163 x1164 x1165 x1167 ->
    owl_stub_15_cblas_csscal x1163 x1164 (CI.cptr x1165) x1167)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1170,
        Function
          (CI.Pointer x1172, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_zscal" ->
  (fun x1168 x1169 x1171 x1173 ->
    owl_stub_14_cblas_zscal x1168 (CI.cptr x1169) (CI.cptr x1171) x1173)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1176,
        Function
          (CI.Pointer x1178, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_cscal" ->
  (fun x1174 x1175 x1177 x1179 ->
    owl_stub_13_cblas_cscal x1174 (CI.cptr x1175) (CI.cptr x1177) x1179)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Double,
        Function
          (CI.Pointer x1183, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_dscal" ->
  (fun x1180 x1181 x1182 x1184 ->
    owl_stub_12_cblas_dscal x1180 x1181 (CI.cptr x1182) x1184)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Float,
        Function
          (CI.Pointer x1188, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_sscal" ->
  (fun x1185 x1186 x1187 x1189 ->
    owl_stub_11_cblas_sscal x1185 x1186 (CI.cptr x1187) x1189)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1192,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1195,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_zswap" ->
  (fun x1190 x1191 x1193 x1194 x1196 ->
    owl_stub_10_cblas_zswap x1190 (CI.cptr x1191) x1193 (CI.cptr x1194) x1196)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1199,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1202,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_cswap" ->
  (fun x1197 x1198 x1200 x1201 x1203 ->
    owl_stub_9_cblas_cswap x1197 (CI.cptr x1198) x1200 (CI.cptr x1201) x1203)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1206,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1209,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_dswap" ->
  (fun x1204 x1205 x1207 x1208 x1210 ->
    owl_stub_8_cblas_dswap x1204 (CI.cptr x1205) x1207 (CI.cptr x1208) x1210)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1213,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1216,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_sswap" ->
  (fun x1211 x1212 x1214 x1215 x1217 ->
    owl_stub_7_cblas_sswap x1211 (CI.cptr x1212) x1214 (CI.cptr x1215) x1217)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1220,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1223,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Double,
                    Function (CI.Primitive CI.Double, Returns CI.Void))))))),
  "cblas_drot" ->
  (fun x1218 x1219 x1221 x1222 x1224 x1225 x1226 ->
    owl_stub_6_cblas_drot x1218 (CI.cptr x1219) x1221 (CI.cptr x1222) x1224
    x1225 x1226)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1229,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1232,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Float,
                    Function (CI.Primitive CI.Float, Returns CI.Void))))))),
  "cblas_srot" ->
  (fun x1227 x1228 x1230 x1231 x1233 x1234 x1235 ->
    owl_stub_5_cblas_srot x1227 (CI.cptr x1228) x1230 (CI.cptr x1231) x1233
    x1234 x1235)
| Function
    (CI.Pointer x1237,
     Function
       (CI.Pointer x1239,
        Function
          (CI.Pointer x1241,
           Function
             (CI.Primitive CI.Double,
              Function (CI.Pointer x1244, Returns CI.Void))))),
  "cblas_drotmg" ->
  (fun x1236 x1238 x1240 x1242 x1243 ->
    owl_stub_4_cblas_drotmg (CI.cptr x1236) (CI.cptr x1238) (CI.cptr x1240)
    x1242 (CI.cptr x1243))
| Function
    (CI.Pointer x1246,
     Function
       (CI.Pointer x1248,
        Function
          (CI.Pointer x1250,
           Function
             (CI.Primitive CI.Float,
              Function (CI.Pointer x1253, Returns CI.Void))))),
  "cblas_srotmg" ->
  (fun x1245 x1247 x1249 x1251 x1252 ->
    owl_stub_3_cblas_srotmg (CI.cptr x1245) (CI.cptr x1247) (CI.cptr x1249)
    x1251 (CI.cptr x1252))
| Function
    (CI.Pointer x1255,
     Function
       (CI.Pointer x1257,
        Function
          (CI.Pointer x1259, Function (CI.Pointer x1261, Returns CI.Void)))),
  "cblas_drotg" ->
  (fun x1254 x1256 x1258 x1260 ->
    owl_stub_2_cblas_drotg (CI.cptr x1254) (CI.cptr x1256) (CI.cptr x1258)
    (CI.cptr x1260))
| Function
    (CI.Pointer x1263,
     Function
       (CI.Pointer x1265,
        Function
          (CI.Pointer x1267, Function (CI.Pointer x1269, Returns CI.Void)))),
  "cblas_srotg" ->
  (fun x1262 x1264 x1266 x1268 ->
    owl_stub_1_cblas_srotg (CI.cptr x1262) (CI.cptr x1264) (CI.cptr x1266)
    (CI.cptr x1268))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

