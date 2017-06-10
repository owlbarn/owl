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
                                  (CI.Primitive CI.Float,
                                   Function
                                     (CI.Pointer x16,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_zher2k" ->
  (fun x1 x2 x3 x4 x5 x6 x8 x10 x11 x13 x14 x15 x17 ->
    owl_stub_140_cblas_zher2k x1 x2 x3 x4 x5 (CI.cptr x6) (CI.cptr x8) x10
    (CI.cptr x11) x13 x14 (CI.cptr x15) x17)
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
                   (CI.Pointer x24,
                    Function
                      (CI.Pointer x26,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x29,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Primitive CI.Float,
                                   Function
                                     (CI.Pointer x33,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_cher2k" ->
  (fun x18 x19 x20 x21 x22 x23 x25 x27 x28 x30 x31 x32 x34 ->
    owl_stub_139_cblas_cher2k x18 x19 x20 x21 x22 (CI.cptr x23) (CI.cptr x25)
    x27 (CI.cptr x28) x30 x31 (CI.cptr x32) x34)
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
                      (CI.Pointer x42,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Primitive CI.Double,
                             Function
                               (CI.Pointer x46,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_zherk" ->
  (fun x35 x36 x37 x38 x39 x40 x41 x43 x44 x45 x47 ->
    owl_stub_138_cblas_zherk x35 x36 x37 x38 x39 x40 (CI.cptr x41) x43 x44
    (CI.cptr x45) x47)
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
                      (CI.Pointer x55,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Primitive CI.Float,
                             Function
                               (CI.Pointer x59,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_cherk" ->
  (fun x48 x49 x50 x51 x52 x53 x54 x56 x57 x58 x60 ->
    owl_stub_137_cblas_cherk x48 x49 x50 x51 x52 x53 (CI.cptr x54) x56 x57
    (CI.cptr x58) x60)
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
                   (CI.Pointer x67,
                    Function
                      (CI.Pointer x69,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x72,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer x75,
                                   Function
                                     (CI.Pointer x77,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_zhemm" ->
  (fun x61 x62 x63 x64 x65 x66 x68 x70 x71 x73 x74 x76 x78 ->
    owl_stub_136_cblas_zhemm x61 x62 x63 x64 x65 (CI.cptr x66) (CI.cptr x68)
    x70 (CI.cptr x71) x73 (CI.cptr x74) (CI.cptr x76) x78)
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
                   (CI.Pointer x85,
                    Function
                      (CI.Pointer x87,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x90,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer x93,
                                   Function
                                     (CI.Pointer x95,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_chemm" ->
  (fun x79 x80 x81 x82 x83 x84 x86 x88 x89 x91 x92 x94 x96 ->
    owl_stub_135_cblas_chemm x79 x80 x81 x82 x83 (CI.cptr x84) (CI.cptr x86)
    x88 (CI.cptr x89) x91 (CI.cptr x92) (CI.cptr x94) x96)
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
                         (CI.Pointer x105,
                          Function
                            (CI.Pointer x107,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer x110,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_ztrsm" ->
  (fun x97 x98 x99 x100 x101 x102 x103 x104 x106 x108 x109 x111 ->
    owl_stub_134_cblas_ztrsm x97 x98 x99 x100 x101 x102 x103 (CI.cptr x104)
    (CI.cptr x106) x108 (CI.cptr x109) x111)
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
                         (CI.Pointer x120,
                          Function
                            (CI.Pointer x122,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer x125,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_ctrsm" ->
  (fun x112 x113 x114 x115 x116 x117 x118 x119 x121 x123 x124 x126 ->
    owl_stub_133_cblas_ctrsm x112 x113 x114 x115 x116 x117 x118
    (CI.cptr x119) (CI.cptr x121) x123 (CI.cptr x124) x126)
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
                            (CI.Pointer x136,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer x139,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_dtrsm" ->
  (fun x127 x128 x129 x130 x131 x132 x133 x134 x135 x137 x138 x140 ->
    owl_stub_132_cblas_dtrsm x127 x128 x129 x130 x131 x132 x133 x134
    (CI.cptr x135) x137 (CI.cptr x138) x140)
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
                            (CI.Pointer x150,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer x153,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_strsm" ->
  (fun x141 x142 x143 x144 x145 x146 x147 x148 x149 x151 x152 x154 ->
    owl_stub_131_cblas_strsm x141 x142 x143 x144 x145 x146 x147 x148
    (CI.cptr x149) x151 (CI.cptr x152) x154)
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
                         (CI.Pointer x163,
                          Function
                            (CI.Pointer x165,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer x168,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_ztrmm" ->
  (fun x155 x156 x157 x158 x159 x160 x161 x162 x164 x166 x167 x169 ->
    owl_stub_130_cblas_ztrmm x155 x156 x157 x158 x159 x160 x161
    (CI.cptr x162) (CI.cptr x164) x166 (CI.cptr x167) x169)
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
                         (CI.Pointer x178,
                          Function
                            (CI.Pointer x180,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer x183,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_ctrmm" ->
  (fun x170 x171 x172 x173 x174 x175 x176 x177 x179 x181 x182 x184 ->
    owl_stub_129_cblas_ctrmm x170 x171 x172 x173 x174 x175 x176
    (CI.cptr x177) (CI.cptr x179) x181 (CI.cptr x182) x184)
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
                            (CI.Pointer x194,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer x197,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_dtrmm" ->
  (fun x185 x186 x187 x188 x189 x190 x191 x192 x193 x195 x196 x198 ->
    owl_stub_128_cblas_dtrmm x185 x186 x187 x188 x189 x190 x191 x192
    (CI.cptr x193) x195 (CI.cptr x196) x198)
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
                            (CI.Pointer x208,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer x211,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_strmm" ->
  (fun x199 x200 x201 x202 x203 x204 x205 x206 x207 x209 x210 x212 ->
    owl_stub_127_cblas_strmm x199 x200 x201 x202 x203 x204 x205 x206
    (CI.cptr x207) x209 (CI.cptr x210) x212)
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
                   (CI.Pointer x219,
                    Function
                      (CI.Pointer x221,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x224,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer x227,
                                   Function
                                     (CI.Pointer x229,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_zsyr2k" ->
  (fun x213 x214 x215 x216 x217 x218 x220 x222 x223 x225 x226 x228 x230 ->
    owl_stub_126_cblas_zsyr2k x213 x214 x215 x216 x217 (CI.cptr x218)
    (CI.cptr x220) x222 (CI.cptr x223) x225 (CI.cptr x226) (CI.cptr x228)
    x230)
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
                                   Function
                                     (CI.Pointer x247,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_csyr2k" ->
  (fun x231 x232 x233 x234 x235 x236 x238 x240 x241 x243 x244 x246 x248 ->
    owl_stub_125_cblas_csyr2k x231 x232 x233 x234 x235 (CI.cptr x236)
    (CI.cptr x238) x240 (CI.cptr x241) x243 (CI.cptr x244) (CI.cptr x246)
    x248)
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
                      (CI.Pointer x256,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x259,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Primitive CI.Double,
                                   Function
                                     (CI.Pointer x263,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_dsyr2k" ->
  (fun x249 x250 x251 x252 x253 x254 x255 x257 x258 x260 x261 x262 x264 ->
    owl_stub_124_cblas_dsyr2k x249 x250 x251 x252 x253 x254 (CI.cptr x255)
    x257 (CI.cptr x258) x260 x261 (CI.cptr x262) x264)
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
                      (CI.Pointer x272,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x275,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Primitive CI.Float,
                                   Function
                                     (CI.Pointer x279,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_ssyr2k" ->
  (fun x265 x266 x267 x268 x269 x270 x271 x273 x274 x276 x277 x278 x280 ->
    owl_stub_123_cblas_ssyr2k x265 x266 x267 x268 x269 x270 (CI.cptr x271)
    x273 (CI.cptr x274) x276 x277 (CI.cptr x278) x280)
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
                   (CI.Pointer x287,
                    Function
                      (CI.Pointer x289,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x292,
                             Function
                               (CI.Pointer x294,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_zsyrk" ->
  (fun x281 x282 x283 x284 x285 x286 x288 x290 x291 x293 x295 ->
    owl_stub_122_cblas_zsyrk x281 x282 x283 x284 x285 (CI.cptr x286)
    (CI.cptr x288) x290 (CI.cptr x291) (CI.cptr x293) x295)
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
                   (CI.Pointer x302,
                    Function
                      (CI.Pointer x304,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x307,
                             Function
                               (CI.Pointer x309,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_csyrk" ->
  (fun x296 x297 x298 x299 x300 x301 x303 x305 x306 x308 x310 ->
    owl_stub_121_cblas_csyrk x296 x297 x298 x299 x300 (CI.cptr x301)
    (CI.cptr x303) x305 (CI.cptr x306) (CI.cptr x308) x310)
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
                      (CI.Pointer x318,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Primitive CI.Double,
                             Function
                               (CI.Pointer x322,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_dsyrk" ->
  (fun x311 x312 x313 x314 x315 x316 x317 x319 x320 x321 x323 ->
    owl_stub_120_cblas_dsyrk x311 x312 x313 x314 x315 x316 (CI.cptr x317)
    x319 x320 (CI.cptr x321) x323)
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
                      (CI.Pointer x331,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Primitive CI.Float,
                             Function
                               (CI.Pointer x335,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_ssyrk" ->
  (fun x324 x325 x326 x327 x328 x329 x330 x332 x333 x334 x336 ->
    owl_stub_119_cblas_ssyrk x324 x325 x326 x327 x328 x329 (CI.cptr x330)
    x332 x333 (CI.cptr x334) x336)
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
                   (CI.Pointer x343,
                    Function
                      (CI.Pointer x345,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x348,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer x351,
                                   Function
                                     (CI.Pointer x353,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_zsymm" ->
  (fun x337 x338 x339 x340 x341 x342 x344 x346 x347 x349 x350 x352 x354 ->
    owl_stub_118_cblas_zsymm x337 x338 x339 x340 x341 (CI.cptr x342)
    (CI.cptr x344) x346 (CI.cptr x347) x349 (CI.cptr x350) (CI.cptr x352)
    x354)
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
                   (CI.Pointer x361,
                    Function
                      (CI.Pointer x363,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x366,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Pointer x369,
                                   Function
                                     (CI.Pointer x371,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_csymm" ->
  (fun x355 x356 x357 x358 x359 x360 x362 x364 x365 x367 x368 x370 x372 ->
    owl_stub_117_cblas_csymm x355 x356 x357 x358 x359 (CI.cptr x360)
    (CI.cptr x362) x364 (CI.cptr x365) x367 (CI.cptr x368) (CI.cptr x370)
    x372)
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
                      (CI.Pointer x380,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x383,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Primitive CI.Double,
                                   Function
                                     (CI.Pointer x387,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_dsymm" ->
  (fun x373 x374 x375 x376 x377 x378 x379 x381 x382 x384 x385 x386 x388 ->
    owl_stub_116_cblas_dsymm x373 x374 x375 x376 x377 x378 (CI.cptr x379)
    x381 (CI.cptr x382) x384 x385 (CI.cptr x386) x388)
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
                      (CI.Pointer x396,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x399,
                             Function
                               (CI.Primitive CI.Int,
                                Function
                                  (CI.Primitive CI.Float,
                                   Function
                                     (CI.Pointer x403,
                                      Function
                                        (CI.Primitive CI.Int,
                                         Returns CI.Void))))))))))))),
  "cblas_ssymm" ->
  (fun x389 x390 x391 x392 x393 x394 x395 x397 x398 x400 x401 x402 x404 ->
    owl_stub_115_cblas_ssymm x389 x390 x391 x392 x393 x394 (CI.cptr x395)
    x397 (CI.cptr x398) x400 x401 (CI.cptr x402) x404)
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
                      (CI.Pointer x412,
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
                                      Function
                                        (CI.Pointer x422,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_zgemm" ->
  (fun x405 x406 x407 x408 x409 x410 x411 x413 x415 x416 x418 x419 x421 x423
    ->
    owl_stub_114_cblas_zgemm x405 x406 x407 x408 x409 x410 (CI.cptr x411)
    (CI.cptr x413) x415 (CI.cptr x416) x418 (CI.cptr x419) (CI.cptr x421)
    x423)
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
                      (CI.Pointer x431,
                       Function
                         (CI.Pointer x433,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x436,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Pointer x439,
                                      Function
                                        (CI.Pointer x441,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_cgemm" ->
  (fun x424 x425 x426 x427 x428 x429 x430 x432 x434 x435 x437 x438 x440 x442
    ->
    owl_stub_113_cblas_cgemm x424 x425 x426 x427 x428 x429 (CI.cptr x430)
    (CI.cptr x432) x434 (CI.cptr x435) x437 (CI.cptr x438) (CI.cptr x440)
    x442)
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
                         (CI.Pointer x451,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x454,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Primitive CI.Double,
                                      Function
                                        (CI.Pointer x458,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_dgemm" ->
  (fun x443 x444 x445 x446 x447 x448 x449 x450 x452 x453 x455 x456 x457 x459
    ->
    owl_stub_112_cblas_dgemm x443 x444 x445 x446 x447 x448 x449
    (CI.cptr x450) x452 (CI.cptr x453) x455 x456 (CI.cptr x457) x459)
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
                         (CI.Pointer x468,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x471,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Primitive CI.Float,
                                      Function
                                        (CI.Pointer x475,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_sgemm" ->
  (fun x460 x461 x462 x463 x464 x465 x466 x467 x469 x470 x472 x473 x474 x476
    ->
    owl_stub_111_cblas_sgemm x460 x461 x462 x463 x464 x465 x466
    (CI.cptr x467) x469 (CI.cptr x470) x472 x473 (CI.cptr x474) x476)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x481,
              Function
                (CI.Pointer x483,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x486,
                       Function
                         (CI.Primitive CI.Int,
                          Function (CI.Pointer x489, Returns CI.Void))))))))),
  "cblas_zhpr2" ->
  (fun x477 x478 x479 x480 x482 x484 x485 x487 x488 ->
    owl_stub_110_cblas_zhpr2 x477 x478 x479 (CI.cptr x480) (CI.cptr x482)
    x484 (CI.cptr x485) x487 (CI.cptr x488))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x494,
              Function
                (CI.Pointer x496,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x499,
                       Function
                         (CI.Primitive CI.Int,
                          Function (CI.Pointer x502, Returns CI.Void))))))))),
  "cblas_chpr2" ->
  (fun x490 x491 x492 x493 x495 x497 x498 x500 x501 ->
    owl_stub_109_cblas_chpr2 x490 x491 x492 (CI.cptr x493) (CI.cptr x495)
    x497 (CI.cptr x498) x500 (CI.cptr x501))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x507,
              Function
                (CI.Pointer x509,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x512,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x515,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_zher2" ->
  (fun x503 x504 x505 x506 x508 x510 x511 x513 x514 x516 ->
    owl_stub_108_cblas_zher2 x503 x504 x505 (CI.cptr x506) (CI.cptr x508)
    x510 (CI.cptr x511) x513 (CI.cptr x514) x516)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x521,
              Function
                (CI.Pointer x523,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x526,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x529,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_cher2" ->
  (fun x517 x518 x519 x520 x522 x524 x525 x527 x528 x530 ->
    owl_stub_107_cblas_cher2 x517 x518 x519 (CI.cptr x520) (CI.cptr x522)
    x524 (CI.cptr x525) x527 (CI.cptr x528) x530)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x536,
                 Function
                   (CI.Primitive CI.Int,
                    Function (CI.Pointer x539, Returns CI.Void))))))),
  "cblas_zhpr" ->
  (fun x531 x532 x533 x534 x535 x537 x538 ->
    owl_stub_106_cblas_zhpr x531 x532 x533 x534 (CI.cptr x535) x537
    (CI.cptr x538))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x545,
                 Function
                   (CI.Primitive CI.Int,
                    Function (CI.Pointer x548, Returns CI.Void))))))),
  "cblas_chpr" ->
  (fun x540 x541 x542 x543 x544 x546 x547 ->
    owl_stub_105_cblas_chpr x540 x541 x542 x543 (CI.cptr x544) x546
    (CI.cptr x547))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x554,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x557,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_zher" ->
  (fun x549 x550 x551 x552 x553 x555 x556 x558 ->
    owl_stub_104_cblas_zher x549 x550 x551 x552 (CI.cptr x553) x555
    (CI.cptr x556) x558)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x564,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x567,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_cher" ->
  (fun x559 x560 x561 x562 x563 x565 x566 x568 ->
    owl_stub_103_cblas_cher x559 x560 x561 x562 (CI.cptr x563) x565
    (CI.cptr x566) x568)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x573,
              Function
                (CI.Pointer x575,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x578,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x581,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_zgerc" ->
  (fun x569 x570 x571 x572 x574 x576 x577 x579 x580 x582 ->
    owl_stub_102_cblas_zgerc x569 x570 x571 (CI.cptr x572) (CI.cptr x574)
    x576 (CI.cptr x577) x579 (CI.cptr x580) x582)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x587,
              Function
                (CI.Pointer x589,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x592,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x595,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_cgerc" ->
  (fun x583 x584 x585 x586 x588 x590 x591 x593 x594 x596 ->
    owl_stub_101_cblas_cgerc x583 x584 x585 (CI.cptr x586) (CI.cptr x588)
    x590 (CI.cptr x591) x593 (CI.cptr x594) x596)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x601,
              Function
                (CI.Pointer x603,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x606,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x609,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_zgeru" ->
  (fun x597 x598 x599 x600 x602 x604 x605 x607 x608 x610 ->
    owl_stub_100_cblas_zgeru x597 x598 x599 (CI.cptr x600) (CI.cptr x602)
    x604 (CI.cptr x605) x607 (CI.cptr x608) x610)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x615,
              Function
                (CI.Pointer x617,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x620,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x623,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_cgeru" ->
  (fun x611 x612 x613 x614 x616 x618 x619 x621 x622 x624 ->
    owl_stub_99_cblas_cgeru x611 x612 x613 (CI.cptr x614) (CI.cptr x616) x618
    (CI.cptr x619) x621 (CI.cptr x622) x624)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x629,
              Function
                (CI.Pointer x631,
                 Function
                   (CI.Pointer x633,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x636,
                          Function
                            (CI.Pointer x638,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_zhpmv" ->
  (fun x625 x626 x627 x628 x630 x632 x634 x635 x637 x639 ->
    owl_stub_98_cblas_zhpmv x625 x626 x627 (CI.cptr x628) (CI.cptr x630)
    (CI.cptr x632) x634 (CI.cptr x635) (CI.cptr x637) x639)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x644,
              Function
                (CI.Pointer x646,
                 Function
                   (CI.Pointer x648,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x651,
                          Function
                            (CI.Pointer x653,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_chpmv" ->
  (fun x640 x641 x642 x643 x645 x647 x649 x650 x652 x654 ->
    owl_stub_97_cblas_chpmv x640 x641 x642 (CI.cptr x643) (CI.cptr x645)
    (CI.cptr x647) x649 (CI.cptr x650) (CI.cptr x652) x654)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x660,
                 Function
                   (CI.Pointer x662,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x665,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x668,
                                Function
                                  (CI.Pointer x670,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_zhbmv" ->
  (fun x655 x656 x657 x658 x659 x661 x663 x664 x666 x667 x669 x671 ->
    owl_stub_96_cblas_zhbmv x655 x656 x657 x658 (CI.cptr x659) (CI.cptr x661)
    x663 (CI.cptr x664) x666 (CI.cptr x667) (CI.cptr x669) x671)
| Function
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
                   (CI.Pointer x679,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x682,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x685,
                                Function
                                  (CI.Pointer x687,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_chbmv" ->
  (fun x672 x673 x674 x675 x676 x678 x680 x681 x683 x684 x686 x688 ->
    owl_stub_95_cblas_chbmv x672 x673 x674 x675 (CI.cptr x676) (CI.cptr x678)
    x680 (CI.cptr x681) x683 (CI.cptr x684) (CI.cptr x686) x688)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x693,
              Function
                (CI.Pointer x695,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x698,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x701,
                             Function
                               (CI.Pointer x703,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_zhemv" ->
  (fun x689 x690 x691 x692 x694 x696 x697 x699 x700 x702 x704 ->
    owl_stub_94_cblas_zhemv x689 x690 x691 (CI.cptr x692) (CI.cptr x694) x696
    (CI.cptr x697) x699 (CI.cptr x700) (CI.cptr x702) x704)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x709,
              Function
                (CI.Pointer x711,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x714,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x717,
                             Function
                               (CI.Pointer x719,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_chemv" ->
  (fun x705 x706 x707 x708 x710 x712 x713 x715 x716 x718 x720 ->
    owl_stub_93_cblas_chemv x705 x706 x707 (CI.cptr x708) (CI.cptr x710) x712
    (CI.cptr x713) x715 (CI.cptr x716) (CI.cptr x718) x720)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer x726,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x729,
                       Function
                         (CI.Primitive CI.Int,
                          Function (CI.Pointer x732, Returns CI.Void))))))))),
  "cblas_dspr2" ->
  (fun x721 x722 x723 x724 x725 x727 x728 x730 x731 ->
    owl_stub_92_cblas_dspr2 x721 x722 x723 x724 (CI.cptr x725) x727
    (CI.cptr x728) x730 (CI.cptr x731))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x738,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x741,
                       Function
                         (CI.Primitive CI.Int,
                          Function (CI.Pointer x744, Returns CI.Void))))))))),
  "cblas_sspr2" ->
  (fun x733 x734 x735 x736 x737 x739 x740 x742 x743 ->
    owl_stub_91_cblas_sspr2 x733 x734 x735 x736 (CI.cptr x737) x739
    (CI.cptr x740) x742 (CI.cptr x743))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer x750,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x753,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x756,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_dsyr2" ->
  (fun x745 x746 x747 x748 x749 x751 x752 x754 x755 x757 ->
    owl_stub_90_cblas_dsyr2 x745 x746 x747 x748 (CI.cptr x749) x751
    (CI.cptr x752) x754 (CI.cptr x755) x757)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x763,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x766,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x769,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_ssyr2" ->
  (fun x758 x759 x760 x761 x762 x764 x765 x767 x768 x770 ->
    owl_stub_89_cblas_ssyr2 x758 x759 x760 x761 (CI.cptr x762) x764
    (CI.cptr x765) x767 (CI.cptr x768) x770)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer x776,
                 Function
                   (CI.Primitive CI.Int,
                    Function (CI.Pointer x779, Returns CI.Void))))))),
  "cblas_dspr" ->
  (fun x771 x772 x773 x774 x775 x777 x778 ->
    owl_stub_88_cblas_dspr x771 x772 x773 x774 (CI.cptr x775) x777
    (CI.cptr x778))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x785,
                 Function
                   (CI.Primitive CI.Int,
                    Function (CI.Pointer x788, Returns CI.Void))))))),
  "cblas_sspr" ->
  (fun x780 x781 x782 x783 x784 x786 x787 ->
    owl_stub_87_cblas_sspr x780 x781 x782 x783 (CI.cptr x784) x786
    (CI.cptr x787))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer x794,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x797,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_dsyr" ->
  (fun x789 x790 x791 x792 x793 x795 x796 x798 ->
    owl_stub_86_cblas_dsyr x789 x790 x791 x792 (CI.cptr x793) x795
    (CI.cptr x796) x798)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x804,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x807,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_ssyr" ->
  (fun x799 x800 x801 x802 x803 x805 x806 x808 ->
    owl_stub_85_cblas_ssyr x799 x800 x801 x802 (CI.cptr x803) x805
    (CI.cptr x806) x808)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer x814,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x817,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x820,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_dger" ->
  (fun x809 x810 x811 x812 x813 x815 x816 x818 x819 x821 ->
    owl_stub_84_cblas_dger x809 x810 x811 x812 (CI.cptr x813) x815
    (CI.cptr x816) x818 (CI.cptr x819) x821)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x827,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x830,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x833,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_sger" ->
  (fun x822 x823 x824 x825 x826 x828 x829 x831 x832 x834 ->
    owl_stub_83_cblas_sger x822 x823 x824 x825 (CI.cptr x826) x828
    (CI.cptr x829) x831 (CI.cptr x832) x834)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer x840,
                 Function
                   (CI.Pointer x842,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Primitive CI.Double,
                          Function
                            (CI.Pointer x846,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_dspmv" ->
  (fun x835 x836 x837 x838 x839 x841 x843 x844 x845 x847 ->
    owl_stub_82_cblas_dspmv x835 x836 x837 x838 (CI.cptr x839) (CI.cptr x841)
    x843 x844 (CI.cptr x845) x847)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Float,
              Function
                (CI.Pointer x853,
                 Function
                   (CI.Pointer x855,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Primitive CI.Float,
                          Function
                            (CI.Pointer x859,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_sspmv" ->
  (fun x848 x849 x850 x851 x852 x854 x856 x857 x858 x860 ->
    owl_stub_81_cblas_sspmv x848 x849 x850 x851 (CI.cptr x852) (CI.cptr x854)
    x856 x857 (CI.cptr x858) x860)
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
                   (CI.Pointer x867,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x870,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Primitive CI.Double,
                                Function
                                  (CI.Pointer x874,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_dsbmv" ->
  (fun x861 x862 x863 x864 x865 x866 x868 x869 x871 x872 x873 x875 ->
    owl_stub_80_cblas_dsbmv x861 x862 x863 x864 x865 (CI.cptr x866) x868
    (CI.cptr x869) x871 x872 (CI.cptr x873) x875)
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
                   (CI.Pointer x882,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x885,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Primitive CI.Float,
                                Function
                                  (CI.Pointer x889,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_ssbmv" ->
  (fun x876 x877 x878 x879 x880 x881 x883 x884 x886 x887 x888 x890 ->
    owl_stub_79_cblas_ssbmv x876 x877 x878 x879 x880 (CI.cptr x881) x883
    (CI.cptr x884) x886 x887 (CI.cptr x888) x890)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Double,
              Function
                (CI.Pointer x896,
                 Function
                   (CI.Primitive CI.Int,
                    Function
                      (CI.Pointer x899,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Primitive CI.Double,
                             Function
                               (CI.Pointer x903,
                                Function
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_dsymv" ->
  (fun x891 x892 x893 x894 x895 x897 x898 x900 x901 x902 x904 ->
    owl_stub_78_cblas_dsymv x891 x892 x893 x894 (CI.cptr x895) x897
    (CI.cptr x898) x900 x901 (CI.cptr x902) x904)
| Function
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
                                  (CI.Primitive CI.Int, Returns CI.Void))))))))))),
  "cblas_ssymv" ->
  (fun x905 x906 x907 x908 x909 x911 x912 x914 x915 x916 x918 ->
    owl_stub_77_cblas_ssymv x905 x906 x907 x908 (CI.cptr x909) x911
    (CI.cptr x912) x914 x915 (CI.cptr x916) x918)
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
                   (CI.Pointer x925,
                    Function
                      (CI.Pointer x927,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_ztpsv" ->
  (fun x919 x920 x921 x922 x923 x924 x926 x928 ->
    owl_stub_76_cblas_ztpsv x919 x920 x921 x922 x923 (CI.cptr x924)
    (CI.cptr x926) x928)
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
                   (CI.Pointer x935,
                    Function
                      (CI.Pointer x937,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_ctpsv" ->
  (fun x929 x930 x931 x932 x933 x934 x936 x938 ->
    owl_stub_75_cblas_ctpsv x929 x930 x931 x932 x933 (CI.cptr x934)
    (CI.cptr x936) x938)
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
                   (CI.Pointer x945,
                    Function
                      (CI.Pointer x947,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_dtpsv" ->
  (fun x939 x940 x941 x942 x943 x944 x946 x948 ->
    owl_stub_74_cblas_dtpsv x939 x940 x941 x942 x943 (CI.cptr x944)
    (CI.cptr x946) x948)
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
                   (CI.Pointer x955,
                    Function
                      (CI.Pointer x957,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_stpsv" ->
  (fun x949 x950 x951 x952 x953 x954 x956 x958 ->
    owl_stub_73_cblas_stpsv x949 x950 x951 x952 x953 (CI.cptr x954)
    (CI.cptr x956) x958)
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
                      (CI.Pointer x966,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x969,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_ztbsv" ->
  (fun x959 x960 x961 x962 x963 x964 x965 x967 x968 x970 ->
    owl_stub_72_cblas_ztbsv x959 x960 x961 x962 x963 x964 (CI.cptr x965) x967
    (CI.cptr x968) x970)
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
                      (CI.Pointer x978,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x981,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_ctbsv" ->
  (fun x971 x972 x973 x974 x975 x976 x977 x979 x980 x982 ->
    owl_stub_71_cblas_ctbsv x971 x972 x973 x974 x975 x976 (CI.cptr x977) x979
    (CI.cptr x980) x982)
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
                      (CI.Pointer x990,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x993,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_dtbsv" ->
  (fun x983 x984 x985 x986 x987 x988 x989 x991 x992 x994 ->
    owl_stub_70_cblas_dtbsv x983 x984 x985 x986 x987 x988 (CI.cptr x989) x991
    (CI.cptr x992) x994)
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
                      (CI.Pointer x1002,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x1005,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_stbsv" ->
  (fun x995 x996 x997 x998 x999 x1000 x1001 x1003 x1004 x1006 ->
    owl_stub_69_cblas_stbsv x995 x996 x997 x998 x999 x1000 (CI.cptr x1001)
    x1003 (CI.cptr x1004) x1006)
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
                   (CI.Pointer x1013,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x1016,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_ztrsv" ->
  (fun x1007 x1008 x1009 x1010 x1011 x1012 x1014 x1015 x1017 ->
    owl_stub_68_cblas_ztrsv x1007 x1008 x1009 x1010 x1011 (CI.cptr x1012)
    x1014 (CI.cptr x1015) x1017)
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
                   (CI.Pointer x1024,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x1027,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_ctrsv" ->
  (fun x1018 x1019 x1020 x1021 x1022 x1023 x1025 x1026 x1028 ->
    owl_stub_67_cblas_ctrsv x1018 x1019 x1020 x1021 x1022 (CI.cptr x1023)
    x1025 (CI.cptr x1026) x1028)
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
                   (CI.Pointer x1035,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x1038,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_dtrsv" ->
  (fun x1029 x1030 x1031 x1032 x1033 x1034 x1036 x1037 x1039 ->
    owl_stub_66_cblas_dtrsv x1029 x1030 x1031 x1032 x1033 (CI.cptr x1034)
    x1036 (CI.cptr x1037) x1039)
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
                   (CI.Pointer x1046,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x1049,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_strsv" ->
  (fun x1040 x1041 x1042 x1043 x1044 x1045 x1047 x1048 x1050 ->
    owl_stub_65_cblas_strsv x1040 x1041 x1042 x1043 x1044 (CI.cptr x1045)
    x1047 (CI.cptr x1048) x1050)
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
                   (CI.Pointer x1057,
                    Function
                      (CI.Pointer x1059,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_ztpmv" ->
  (fun x1051 x1052 x1053 x1054 x1055 x1056 x1058 x1060 ->
    owl_stub_64_cblas_ztpmv x1051 x1052 x1053 x1054 x1055 (CI.cptr x1056)
    (CI.cptr x1058) x1060)
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
                   (CI.Pointer x1067,
                    Function
                      (CI.Pointer x1069,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_ctpmv" ->
  (fun x1061 x1062 x1063 x1064 x1065 x1066 x1068 x1070 ->
    owl_stub_63_cblas_ctpmv x1061 x1062 x1063 x1064 x1065 (CI.cptr x1066)
    (CI.cptr x1068) x1070)
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
                   (CI.Pointer x1077,
                    Function
                      (CI.Pointer x1079,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_dtpmv" ->
  (fun x1071 x1072 x1073 x1074 x1075 x1076 x1078 x1080 ->
    owl_stub_62_cblas_dtpmv x1071 x1072 x1073 x1074 x1075 (CI.cptr x1076)
    (CI.cptr x1078) x1080)
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
                   (CI.Pointer x1087,
                    Function
                      (CI.Pointer x1089,
                       Function (CI.Primitive CI.Int, Returns CI.Void)))))))),
  "cblas_stpmv" ->
  (fun x1081 x1082 x1083 x1084 x1085 x1086 x1088 x1090 ->
    owl_stub_61_cblas_stpmv x1081 x1082 x1083 x1084 x1085 (CI.cptr x1086)
    (CI.cptr x1088) x1090)
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
                      (CI.Pointer x1098,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x1101,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_ztbmv" ->
  (fun x1091 x1092 x1093 x1094 x1095 x1096 x1097 x1099 x1100 x1102 ->
    owl_stub_60_cblas_ztbmv x1091 x1092 x1093 x1094 x1095 x1096
    (CI.cptr x1097) x1099 (CI.cptr x1100) x1102)
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
                      (CI.Pointer x1110,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x1113,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_ctbmv" ->
  (fun x1103 x1104 x1105 x1106 x1107 x1108 x1109 x1111 x1112 x1114 ->
    owl_stub_59_cblas_ctbmv x1103 x1104 x1105 x1106 x1107 x1108
    (CI.cptr x1109) x1111 (CI.cptr x1112) x1114)
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
                      (CI.Pointer x1122,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x1125,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_dtbmv" ->
  (fun x1115 x1116 x1117 x1118 x1119 x1120 x1121 x1123 x1124 x1126 ->
    owl_stub_58_cblas_dtbmv x1115 x1116 x1117 x1118 x1119 x1120
    (CI.cptr x1121) x1123 (CI.cptr x1124) x1126)
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
                      (CI.Pointer x1134,
                       Function
                         (CI.Primitive CI.Int,
                          Function
                            (CI.Pointer x1137,
                             Function (CI.Primitive CI.Int, Returns CI.Void)))))))))),
  "cblas_stbmv" ->
  (fun x1127 x1128 x1129 x1130 x1131 x1132 x1133 x1135 x1136 x1138 ->
    owl_stub_57_cblas_stbmv x1127 x1128 x1129 x1130 x1131 x1132
    (CI.cptr x1133) x1135 (CI.cptr x1136) x1138)
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
                   (CI.Pointer x1145,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x1148,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_ztrmv" ->
  (fun x1139 x1140 x1141 x1142 x1143 x1144 x1146 x1147 x1149 ->
    owl_stub_56_cblas_ztrmv x1139 x1140 x1141 x1142 x1143 (CI.cptr x1144)
    x1146 (CI.cptr x1147) x1149)
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
                   (CI.Pointer x1156,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x1159,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_ctrmv" ->
  (fun x1150 x1151 x1152 x1153 x1154 x1155 x1157 x1158 x1160 ->
    owl_stub_55_cblas_ctrmv x1150 x1151 x1152 x1153 x1154 (CI.cptr x1155)
    x1157 (CI.cptr x1158) x1160)
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
                   (CI.Pointer x1167,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x1170,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_dtrmv" ->
  (fun x1161 x1162 x1163 x1164 x1165 x1166 x1168 x1169 x1171 ->
    owl_stub_54_cblas_dtrmv x1161 x1162 x1163 x1164 x1165 (CI.cptr x1166)
    x1168 (CI.cptr x1169) x1171)
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
                   (CI.Pointer x1178,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x1181,
                          Function (CI.Primitive CI.Int, Returns CI.Void))))))))),
  "cblas_strmv" ->
  (fun x1172 x1173 x1174 x1175 x1176 x1177 x1179 x1180 x1182 ->
    owl_stub_53_cblas_strmv x1172 x1173 x1174 x1175 x1176 (CI.cptr x1177)
    x1179 (CI.cptr x1180) x1182)
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
                      (CI.Pointer x1190,
                       Function
                         (CI.Pointer x1192,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x1195,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Pointer x1198,
                                      Function
                                        (CI.Pointer x1200,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_zgbmv" ->
  (fun x1183 x1184 x1185 x1186 x1187 x1188 x1189 x1191 x1193 x1194 x1196
    x1197 x1199 x1201 ->
    owl_stub_52_cblas_zgbmv x1183 x1184 x1185 x1186 x1187 x1188
    (CI.cptr x1189) (CI.cptr x1191) x1193 (CI.cptr x1194) x1196
    (CI.cptr x1197) (CI.cptr x1199) x1201)
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
                      (CI.Pointer x1209,
                       Function
                         (CI.Pointer x1211,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x1214,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Pointer x1217,
                                      Function
                                        (CI.Pointer x1219,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_cgbmv" ->
  (fun x1202 x1203 x1204 x1205 x1206 x1207 x1208 x1210 x1212 x1213 x1215
    x1216 x1218 x1220 ->
    owl_stub_51_cblas_cgbmv x1202 x1203 x1204 x1205 x1206 x1207
    (CI.cptr x1208) (CI.cptr x1210) x1212 (CI.cptr x1213) x1215
    (CI.cptr x1216) (CI.cptr x1218) x1220)
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
                         (CI.Pointer x1229,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x1232,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Primitive CI.Double,
                                      Function
                                        (CI.Pointer x1236,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_dgbmv" ->
  (fun x1221 x1222 x1223 x1224 x1225 x1226 x1227 x1228 x1230 x1231 x1233
    x1234 x1235 x1237 ->
    owl_stub_50_cblas_dgbmv x1221 x1222 x1223 x1224 x1225 x1226 x1227
    (CI.cptr x1228) x1230 (CI.cptr x1231) x1233 x1234 (CI.cptr x1235) x1237)
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
                         (CI.Pointer x1246,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x1249,
                                Function
                                  (CI.Primitive CI.Int,
                                   Function
                                     (CI.Primitive CI.Float,
                                      Function
                                        (CI.Pointer x1253,
                                         Function
                                           (CI.Primitive CI.Int,
                                            Returns CI.Void)))))))))))))),
  "cblas_sgbmv" ->
  (fun x1238 x1239 x1240 x1241 x1242 x1243 x1244 x1245 x1247 x1248 x1250
    x1251 x1252 x1254 ->
    owl_stub_49_cblas_sgbmv x1238 x1239 x1240 x1241 x1242 x1243 x1244
    (CI.cptr x1245) x1247 (CI.cptr x1248) x1250 x1251 (CI.cptr x1252) x1254)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x1260,
                 Function
                   (CI.Pointer x1262,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x1265,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x1268,
                                Function
                                  (CI.Pointer x1270,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_zgemv" ->
  (fun x1255 x1256 x1257 x1258 x1259 x1261 x1263 x1264 x1266 x1267 x1269
    x1271 ->
    owl_stub_48_cblas_zgemv x1255 x1256 x1257 x1258 (CI.cptr x1259)
    (CI.cptr x1261) x1263 (CI.cptr x1264) x1266 (CI.cptr x1267)
    (CI.cptr x1269) x1271)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x1277,
                 Function
                   (CI.Pointer x1279,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x1282,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Pointer x1285,
                                Function
                                  (CI.Pointer x1287,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_cgemv" ->
  (fun x1272 x1273 x1274 x1275 x1276 x1278 x1280 x1281 x1283 x1284 x1286
    x1288 ->
    owl_stub_47_cblas_cgemv x1272 x1273 x1274 x1275 (CI.cptr x1276)
    (CI.cptr x1278) x1280 (CI.cptr x1281) x1283 (CI.cptr x1284)
    (CI.cptr x1286) x1288)
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
                   (CI.Pointer x1295,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x1298,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Primitive CI.Double,
                                Function
                                  (CI.Pointer x1302,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_dgemv" ->
  (fun x1289 x1290 x1291 x1292 x1293 x1294 x1296 x1297 x1299 x1300 x1301
    x1303 ->
    owl_stub_46_cblas_dgemv x1289 x1290 x1291 x1292 x1293 (CI.cptr x1294)
    x1296 (CI.cptr x1297) x1299 x1300 (CI.cptr x1301) x1303)
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
                   (CI.Pointer x1310,
                    Function
                      (CI.Primitive CI.Int,
                       Function
                         (CI.Pointer x1313,
                          Function
                            (CI.Primitive CI.Int,
                             Function
                               (CI.Primitive CI.Float,
                                Function
                                  (CI.Pointer x1317,
                                   Function
                                     (CI.Primitive CI.Int, Returns CI.Void)))))))))))),
  "cblas_sgemv" ->
  (fun x1304 x1305 x1306 x1307 x1308 x1309 x1311 x1312 x1314 x1315 x1316
    x1318 ->
    owl_stub_45_cblas_sgemv x1304 x1305 x1306 x1307 x1308 (CI.cptr x1309)
    x1311 (CI.cptr x1312) x1314 x1315 (CI.cptr x1316) x1318)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1321,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Size_t)))),
  "cblas_izamax" ->
  (fun x1319 x1320 x1322 ->
    owl_stub_44_cblas_izamax x1319 (CI.cptr x1320) x1322)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1325,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Size_t)))),
  "cblas_icamax" ->
  (fun x1323 x1324 x1326 ->
    owl_stub_43_cblas_icamax x1323 (CI.cptr x1324) x1326)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1329,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Size_t)))),
  "cblas_idamax" ->
  (fun x1327 x1328 x1330 ->
    owl_stub_42_cblas_idamax x1327 (CI.cptr x1328) x1330)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1333,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Size_t)))),
  "cblas_isamax" ->
  (fun x1331 x1332 x1334 ->
    owl_stub_41_cblas_isamax x1331 (CI.cptr x1332) x1334)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1337,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "cblas_dzasum" ->
  (fun x1335 x1336 x1338 ->
    owl_stub_40_cblas_dzasum x1335 (CI.cptr x1336) x1338)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1341,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))),
  "cblas_scasum" ->
  (fun x1339 x1340 x1342 ->
    owl_stub_39_cblas_scasum x1339 (CI.cptr x1340) x1342)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1345,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "cblas_dasum" ->
  (fun x1343 x1344 x1346 ->
    owl_stub_38_cblas_dasum x1343 (CI.cptr x1344) x1346)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1349,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))),
  "cblas_sasum" ->
  (fun x1347 x1348 x1350 ->
    owl_stub_37_cblas_sasum x1347 (CI.cptr x1348) x1350)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1353,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "cblas_dznrm2" ->
  (fun x1351 x1352 x1354 ->
    owl_stub_36_cblas_dznrm2 x1351 (CI.cptr x1352) x1354)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1357,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))),
  "cblas_scnrm2" ->
  (fun x1355 x1356 x1358 ->
    owl_stub_35_cblas_scnrm2 x1355 (CI.cptr x1356) x1358)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1361,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "cblas_dnrm2" ->
  (fun x1359 x1360 x1362 ->
    owl_stub_34_cblas_dnrm2 x1359 (CI.cptr x1360) x1362)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1365,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))),
  "cblas_snrm2" ->
  (fun x1363 x1364 x1366 ->
    owl_stub_33_cblas_snrm2 x1363 (CI.cptr x1364) x1366)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1369,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1372,
              Function
                (CI.Primitive CI.Int,
                 Function (CI.Pointer x1375, Returns CI.Void)))))),
  "cblas_zdotc_sub" ->
  (fun x1367 x1368 x1370 x1371 x1373 x1374 ->
    owl_stub_32_cblas_zdotc_sub x1367 (CI.cptr x1368) x1370 (CI.cptr x1371)
    x1373 (CI.cptr x1374))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1378,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1381,
              Function
                (CI.Primitive CI.Int,
                 Function (CI.Pointer x1384, Returns CI.Void)))))),
  "cblas_zdotu_sub" ->
  (fun x1376 x1377 x1379 x1380 x1382 x1383 ->
    owl_stub_31_cblas_zdotu_sub x1376 (CI.cptr x1377) x1379 (CI.cptr x1380)
    x1382 (CI.cptr x1383))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1387,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1390,
              Function
                (CI.Primitive CI.Int,
                 Function (CI.Pointer x1393, Returns CI.Void)))))),
  "cblas_cdotc_sub" ->
  (fun x1385 x1386 x1388 x1389 x1391 x1392 ->
    owl_stub_30_cblas_cdotc_sub x1385 (CI.cptr x1386) x1388 (CI.cptr x1389)
    x1391 (CI.cptr x1392))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1396,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1399,
              Function
                (CI.Primitive CI.Int,
                 Function (CI.Pointer x1402, Returns CI.Void)))))),
  "cblas_cdotu_sub" ->
  (fun x1394 x1395 x1397 x1398 x1400 x1401 ->
    owl_stub_29_cblas_cdotu_sub x1394 (CI.cptr x1395) x1397 (CI.cptr x1398)
    x1400 (CI.cptr x1401))
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1405,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1408,
              Function
                (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))))),
  "cblas_dsdot" ->
  (fun x1403 x1404 x1406 x1407 x1409 ->
    owl_stub_28_cblas_dsdot x1403 (CI.cptr x1404) x1406 (CI.cptr x1407) x1409)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Float,
        Function
          (CI.Pointer x1413,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x1416,
                 Function
                   (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float))))))),
  "cblas_sdsdot" ->
  (fun x1410 x1411 x1412 x1414 x1415 x1417 ->
    owl_stub_27_cblas_sdsdot x1410 x1411 (CI.cptr x1412) x1414
    (CI.cptr x1415) x1417)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1420,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1423,
              Function
                (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))))),
  "cblas_ddot" ->
  (fun x1418 x1419 x1421 x1422 x1424 ->
    owl_stub_26_cblas_ddot x1418 (CI.cptr x1419) x1421 (CI.cptr x1422) x1424)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1427,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1430,
              Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Float)))))),
  "cblas_sdot" ->
  (fun x1425 x1426 x1428 x1429 x1431 ->
    owl_stub_25_cblas_sdot x1425 (CI.cptr x1426) x1428 (CI.cptr x1429) x1431)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1434,
        Function
          (CI.Pointer x1436,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x1439,
                 Function (CI.Primitive CI.Int, Returns CI.Void)))))),
  "cblas_zaxpy" ->
  (fun x1432 x1433 x1435 x1437 x1438 x1440 ->
    owl_stub_24_cblas_zaxpy x1432 (CI.cptr x1433) (CI.cptr x1435) x1437
    (CI.cptr x1438) x1440)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1443,
        Function
          (CI.Pointer x1445,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x1448,
                 Function (CI.Primitive CI.Int, Returns CI.Void)))))),
  "cblas_caxpy" ->
  (fun x1441 x1442 x1444 x1446 x1447 x1449 ->
    owl_stub_23_cblas_caxpy x1441 (CI.cptr x1442) (CI.cptr x1444) x1446
    (CI.cptr x1447) x1449)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Double,
        Function
          (CI.Pointer x1453,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x1456,
                 Function (CI.Primitive CI.Int, Returns CI.Void)))))),
  "cblas_daxpy" ->
  (fun x1450 x1451 x1452 x1454 x1455 x1457 ->
    owl_stub_22_cblas_daxpy x1450 x1451 (CI.cptr x1452) x1454 (CI.cptr x1455)
    x1457)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Float,
        Function
          (CI.Pointer x1461,
           Function
             (CI.Primitive CI.Int,
              Function
                (CI.Pointer x1464,
                 Function (CI.Primitive CI.Int, Returns CI.Void)))))),
  "cblas_saxpy" ->
  (fun x1458 x1459 x1460 x1462 x1463 x1465 ->
    owl_stub_21_cblas_saxpy x1458 x1459 (CI.cptr x1460) x1462 (CI.cptr x1463)
    x1465)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1468,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1471,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_zcopy" ->
  (fun x1466 x1467 x1469 x1470 x1472 ->
    owl_stub_20_cblas_zcopy x1466 (CI.cptr x1467) x1469 (CI.cptr x1470) x1472)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1475,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1478,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_ccopy" ->
  (fun x1473 x1474 x1476 x1477 x1479 ->
    owl_stub_19_cblas_ccopy x1473 (CI.cptr x1474) x1476 (CI.cptr x1477) x1479)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1482,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1485,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_dcopy" ->
  (fun x1480 x1481 x1483 x1484 x1486 ->
    owl_stub_18_cblas_dcopy x1480 (CI.cptr x1481) x1483 (CI.cptr x1484) x1486)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1489,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1492,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_scopy" ->
  (fun x1487 x1488 x1490 x1491 x1493 ->
    owl_stub_17_cblas_scopy x1487 (CI.cptr x1488) x1490 (CI.cptr x1491) x1493)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Double,
        Function
          (CI.Pointer x1497, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_zdscal" ->
  (fun x1494 x1495 x1496 x1498 ->
    owl_stub_16_cblas_zdscal x1494 x1495 (CI.cptr x1496) x1498)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Float,
        Function
          (CI.Pointer x1502, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_csscal" ->
  (fun x1499 x1500 x1501 x1503 ->
    owl_stub_15_cblas_csscal x1499 x1500 (CI.cptr x1501) x1503)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1506,
        Function
          (CI.Pointer x1508, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_zscal" ->
  (fun x1504 x1505 x1507 x1509 ->
    owl_stub_14_cblas_zscal x1504 (CI.cptr x1505) (CI.cptr x1507) x1509)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1512,
        Function
          (CI.Pointer x1514, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_cscal" ->
  (fun x1510 x1511 x1513 x1515 ->
    owl_stub_13_cblas_cscal x1510 (CI.cptr x1511) (CI.cptr x1513) x1515)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Double,
        Function
          (CI.Pointer x1519, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_dscal" ->
  (fun x1516 x1517 x1518 x1520 ->
    owl_stub_12_cblas_dscal x1516 x1517 (CI.cptr x1518) x1520)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Float,
        Function
          (CI.Pointer x1524, Function (CI.Primitive CI.Int, Returns CI.Void)))),
  "cblas_sscal" ->
  (fun x1521 x1522 x1523 x1525 ->
    owl_stub_11_cblas_sscal x1521 x1522 (CI.cptr x1523) x1525)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1528,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1531,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_zswap" ->
  (fun x1526 x1527 x1529 x1530 x1532 ->
    owl_stub_10_cblas_zswap x1526 (CI.cptr x1527) x1529 (CI.cptr x1530) x1532)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1535,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1538,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_cswap" ->
  (fun x1533 x1534 x1536 x1537 x1539 ->
    owl_stub_9_cblas_cswap x1533 (CI.cptr x1534) x1536 (CI.cptr x1537) x1539)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1542,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1545,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_dswap" ->
  (fun x1540 x1541 x1543 x1544 x1546 ->
    owl_stub_8_cblas_dswap x1540 (CI.cptr x1541) x1543 (CI.cptr x1544) x1546)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1549,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1552,
              Function (CI.Primitive CI.Int, Returns CI.Void))))),
  "cblas_sswap" ->
  (fun x1547 x1548 x1550 x1551 x1553 ->
    owl_stub_7_cblas_sswap x1547 (CI.cptr x1548) x1550 (CI.cptr x1551) x1553)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1556,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1559,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Double,
                    Function (CI.Primitive CI.Double, Returns CI.Void))))))),
  "cblas_drot" ->
  (fun x1554 x1555 x1557 x1558 x1560 x1561 x1562 ->
    owl_stub_6_cblas_drot x1554 (CI.cptr x1555) x1557 (CI.cptr x1558) x1560
    x1561 x1562)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Pointer x1565,
        Function
          (CI.Primitive CI.Int,
           Function
             (CI.Pointer x1568,
              Function
                (CI.Primitive CI.Int,
                 Function
                   (CI.Primitive CI.Float,
                    Function (CI.Primitive CI.Float, Returns CI.Void))))))),
  "cblas_srot" ->
  (fun x1563 x1564 x1566 x1567 x1569 x1570 x1571 ->
    owl_stub_5_cblas_srot x1563 (CI.cptr x1564) x1566 (CI.cptr x1567) x1569
    x1570 x1571)
| Function
    (CI.Pointer x1573,
     Function
       (CI.Pointer x1575,
        Function
          (CI.Pointer x1577,
           Function
             (CI.Primitive CI.Double,
              Function (CI.Pointer x1580, Returns CI.Void))))),
  "cblas_drotmg" ->
  (fun x1572 x1574 x1576 x1578 x1579 ->
    owl_stub_4_cblas_drotmg (CI.cptr x1572) (CI.cptr x1574) (CI.cptr x1576)
    x1578 (CI.cptr x1579))
| Function
    (CI.Pointer x1582,
     Function
       (CI.Pointer x1584,
        Function
          (CI.Pointer x1586,
           Function
             (CI.Primitive CI.Float,
              Function (CI.Pointer x1589, Returns CI.Void))))),
  "cblas_srotmg" ->
  (fun x1581 x1583 x1585 x1587 x1588 ->
    owl_stub_3_cblas_srotmg (CI.cptr x1581) (CI.cptr x1583) (CI.cptr x1585)
    x1587 (CI.cptr x1588))
| Function
    (CI.Pointer x1591,
     Function
       (CI.Pointer x1593,
        Function
          (CI.Pointer x1595, Function (CI.Pointer x1597, Returns CI.Void)))),
  "cblas_drotg" ->
  (fun x1590 x1592 x1594 x1596 ->
    owl_stub_2_cblas_drotg (CI.cptr x1590) (CI.cptr x1592) (CI.cptr x1594)
    (CI.cptr x1596))
| Function
    (CI.Pointer x1599,
     Function
       (CI.Pointer x1601,
        Function
          (CI.Pointer x1603, Function (CI.Pointer x1605, Returns CI.Void)))),
  "cblas_srotg" ->
  (fun x1598 x1600 x1602 x1604 ->
    owl_stub_1_cblas_srotg (CI.cptr x1598) (CI.cptr x1600) (CI.cptr x1602)
    (CI.cptr x1604))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

