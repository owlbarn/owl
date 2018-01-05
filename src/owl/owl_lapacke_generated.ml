(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** auto-generated lapacke interface file, timestamp:1498396311 *)

module CI = Cstubs_internals

external lapacke_sbdsdc
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_1_LAPACKE_sbdsdc_byte12" "owl_stub_1_LAPACKE_sbdsdc"

external lapacke_dbdsdc
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_2_LAPACKE_dbdsdc_byte12" "owl_stub_2_LAPACKE_dbdsdc"

external lapacke_sbdsqr
  : int -> char -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_3_LAPACKE_sbdsqr_byte14" "owl_stub_3_LAPACKE_sbdsqr"

external lapacke_dbdsqr
  : int -> char -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_4_LAPACKE_dbdsqr_byte14" "owl_stub_4_LAPACKE_dbdsqr"

external lapacke_cbdsqr
  : int -> char -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_5_LAPACKE_cbdsqr_byte14" "owl_stub_5_LAPACKE_cbdsqr"

external lapacke_zbdsqr
  : int -> char -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_6_LAPACKE_zbdsqr_byte14" "owl_stub_6_LAPACKE_zbdsqr"

external lapacke_sbdsvdx
  : int -> char -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> float -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_7_LAPACKE_sbdsvdx_byte16" "owl_stub_7_LAPACKE_sbdsvdx"

external lapacke_dbdsvdx
  : int -> char -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> float -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_8_LAPACKE_dbdsvdx_byte16" "owl_stub_8_LAPACKE_dbdsvdx"

external lapacke_sdisna
  : char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_9_LAPACKE_sdisna"

external lapacke_ddisna
  : char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_10_LAPACKE_ddisna"

external lapacke_sgbbrd
  : int -> char -> int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_11_LAPACKE_sgbbrd_byte17" "owl_stub_11_LAPACKE_sgbbrd"

external lapacke_dgbbrd
  : int -> char -> int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_12_LAPACKE_dgbbrd_byte17" "owl_stub_12_LAPACKE_dgbbrd"

external lapacke_cgbbrd
  : int -> char -> int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_13_LAPACKE_cgbbrd_byte17" "owl_stub_13_LAPACKE_cgbbrd"

external lapacke_zgbbrd
  : int -> char -> int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_14_LAPACKE_zgbbrd_byte17" "owl_stub_14_LAPACKE_zgbbrd"

external lapacke_sgbcon
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_15_LAPACKE_sgbcon_byte10" "owl_stub_15_LAPACKE_sgbcon"

external lapacke_dgbcon
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_16_LAPACKE_dgbcon_byte10" "owl_stub_16_LAPACKE_dgbcon"

external lapacke_cgbcon
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_17_LAPACKE_cgbcon_byte10" "owl_stub_17_LAPACKE_cgbcon"

external lapacke_zgbcon
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_18_LAPACKE_zgbcon_byte10" "owl_stub_18_LAPACKE_zgbcon"

external lapacke_sgbequ
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_19_LAPACKE_sgbequ_byte12" "owl_stub_19_LAPACKE_sgbequ"

external lapacke_dgbequ
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_20_LAPACKE_dgbequ_byte12" "owl_stub_20_LAPACKE_dgbequ"

external lapacke_cgbequ
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_21_LAPACKE_cgbequ_byte12" "owl_stub_21_LAPACKE_cgbequ"

external lapacke_zgbequ
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_22_LAPACKE_zgbequ_byte12" "owl_stub_22_LAPACKE_zgbequ"

external lapacke_sgbequb
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_23_LAPACKE_sgbequb_byte12" "owl_stub_23_LAPACKE_sgbequb"

external lapacke_dgbequb
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_24_LAPACKE_dgbequb_byte12" "owl_stub_24_LAPACKE_dgbequb"

external lapacke_cgbequb
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_25_LAPACKE_cgbequb_byte12" "owl_stub_25_LAPACKE_cgbequb"

external lapacke_zgbequb
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_26_LAPACKE_zgbequb_byte12" "owl_stub_26_LAPACKE_zgbequb"

external lapacke_sgbrfs
  : int -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_27_LAPACKE_sgbrfs_byte17" "owl_stub_27_LAPACKE_sgbrfs"

external lapacke_dgbrfs
  : int -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_28_LAPACKE_dgbrfs_byte17" "owl_stub_28_LAPACKE_dgbrfs"

external lapacke_cgbrfs
  : int -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_29_LAPACKE_cgbrfs_byte17" "owl_stub_29_LAPACKE_cgbrfs"

external lapacke_zgbrfs
  : int -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_30_LAPACKE_zgbrfs_byte17" "owl_stub_30_LAPACKE_zgbrfs"

external lapacke_sgbsv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_31_LAPACKE_sgbsv_byte10" "owl_stub_31_LAPACKE_sgbsv"

external lapacke_dgbsv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_32_LAPACKE_dgbsv_byte10" "owl_stub_32_LAPACKE_dgbsv"

external lapacke_cgbsv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_33_LAPACKE_cgbsv_byte10" "owl_stub_33_LAPACKE_cgbsv"

external lapacke_zgbsv
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_34_LAPACKE_zgbsv_byte10" "owl_stub_34_LAPACKE_zgbsv"

external lapacke_sgbsvx
  : int -> char -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_35_LAPACKE_sgbsvx_byte23" "owl_stub_35_LAPACKE_sgbsvx"

external lapacke_dgbsvx
  : int -> char -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_36_LAPACKE_dgbsvx_byte23" "owl_stub_36_LAPACKE_dgbsvx"

external lapacke_cgbsvx
  : int -> char -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_37_LAPACKE_cgbsvx_byte23" "owl_stub_37_LAPACKE_cgbsvx"

external lapacke_zgbsvx
  : int -> char -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_38_LAPACKE_zgbsvx_byte23" "owl_stub_38_LAPACKE_zgbsvx"

external lapacke_sgbtrf
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_39_LAPACKE_sgbtrf_byte8" "owl_stub_39_LAPACKE_sgbtrf"

external lapacke_dgbtrf
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_40_LAPACKE_dgbtrf_byte8" "owl_stub_40_LAPACKE_dgbtrf"

external lapacke_cgbtrf
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_41_LAPACKE_cgbtrf_byte8" "owl_stub_41_LAPACKE_cgbtrf"

external lapacke_zgbtrf
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_42_LAPACKE_zgbtrf_byte8" "owl_stub_42_LAPACKE_zgbtrf"

external lapacke_sgbtrs
  : int -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_43_LAPACKE_sgbtrs_byte11" "owl_stub_43_LAPACKE_sgbtrs"

external lapacke_dgbtrs
  : int -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_44_LAPACKE_dgbtrs_byte11" "owl_stub_44_LAPACKE_dgbtrs"

external lapacke_cgbtrs
  : int -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_45_LAPACKE_cgbtrs_byte11" "owl_stub_45_LAPACKE_cgbtrs"

external lapacke_zgbtrs
  : int -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_46_LAPACKE_zgbtrs_byte11" "owl_stub_46_LAPACKE_zgbtrs"

external lapacke_sgebak
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_47_LAPACKE_sgebak_byte10" "owl_stub_47_LAPACKE_sgebak"

external lapacke_dgebak
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_48_LAPACKE_dgebak_byte10" "owl_stub_48_LAPACKE_dgebak"

external lapacke_cgebak
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_49_LAPACKE_cgebak_byte10" "owl_stub_49_LAPACKE_cgebak"

external lapacke_zgebak
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_50_LAPACKE_zgebak_byte10" "owl_stub_50_LAPACKE_zgebak"

external lapacke_sgebal
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_51_LAPACKE_sgebal_byte8" "owl_stub_51_LAPACKE_sgebal"

external lapacke_dgebal
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_52_LAPACKE_dgebal_byte8" "owl_stub_52_LAPACKE_dgebal"

external lapacke_cgebal
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_53_LAPACKE_cgebal_byte8" "owl_stub_53_LAPACKE_cgebal"

external lapacke_zgebal
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_54_LAPACKE_zgebal_byte8" "owl_stub_54_LAPACKE_zgebal"

external lapacke_sgebrd
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_55_LAPACKE_sgebrd_byte9" "owl_stub_55_LAPACKE_sgebrd"

external lapacke_dgebrd
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_56_LAPACKE_dgebrd_byte9" "owl_stub_56_LAPACKE_dgebrd"

external lapacke_cgebrd
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_57_LAPACKE_cgebrd_byte9" "owl_stub_57_LAPACKE_cgebrd"

external lapacke_zgebrd
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_58_LAPACKE_zgebrd_byte9" "owl_stub_58_LAPACKE_zgebrd"

external lapacke_sgecon
  : int -> char -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int
  = "owl_stub_59_LAPACKE_sgecon_byte7" "owl_stub_59_LAPACKE_sgecon"

external lapacke_dgecon
  : int -> char -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int
  = "owl_stub_60_LAPACKE_dgecon_byte7" "owl_stub_60_LAPACKE_dgecon"

external lapacke_cgecon
  : int -> char -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int
  = "owl_stub_61_LAPACKE_cgecon_byte7" "owl_stub_61_LAPACKE_cgecon"

external lapacke_zgecon
  : int -> char -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int
  = "owl_stub_62_LAPACKE_zgecon_byte7" "owl_stub_62_LAPACKE_zgecon"

external lapacke_sgeequ
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_63_LAPACKE_sgeequ_byte10" "owl_stub_63_LAPACKE_sgeequ"

external lapacke_dgeequ
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_64_LAPACKE_dgeequ_byte10" "owl_stub_64_LAPACKE_dgeequ"

external lapacke_cgeequ
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_65_LAPACKE_cgeequ_byte10" "owl_stub_65_LAPACKE_cgeequ"

external lapacke_zgeequ
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_66_LAPACKE_zgeequ_byte10" "owl_stub_66_LAPACKE_zgeequ"

external lapacke_sgeequb
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_67_LAPACKE_sgeequb_byte10" "owl_stub_67_LAPACKE_sgeequb"

external lapacke_dgeequb
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_68_LAPACKE_dgeequb_byte10" "owl_stub_68_LAPACKE_dgeequb"

external lapacke_cgeequb
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_69_LAPACKE_cgeequb_byte10" "owl_stub_69_LAPACKE_cgeequb"

external lapacke_zgeequb
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_70_LAPACKE_zgeequb_byte10" "owl_stub_70_LAPACKE_zgeequb"

external lapacke_sgees
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_71_LAPACKE_sgees_byte12" "owl_stub_71_LAPACKE_sgees"

external lapacke_dgees
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_72_LAPACKE_dgees_byte12" "owl_stub_72_LAPACKE_dgees"

external lapacke_cgees
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_73_LAPACKE_cgees_byte11" "owl_stub_73_LAPACKE_cgees"

external lapacke_zgees
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_74_LAPACKE_zgees_byte11" "owl_stub_74_LAPACKE_zgees"

external lapacke_sgeesx
  : int -> char -> char -> _ CI.fatptr -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_75_LAPACKE_sgeesx_byte15" "owl_stub_75_LAPACKE_sgeesx"

external lapacke_dgeesx
  : int -> char -> char -> _ CI.fatptr -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_76_LAPACKE_dgeesx_byte15" "owl_stub_76_LAPACKE_dgeesx"

external lapacke_cgeesx
  : int -> char -> char -> _ CI.fatptr -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_77_LAPACKE_cgeesx_byte14" "owl_stub_77_LAPACKE_cgeesx"

external lapacke_zgeesx
  : int -> char -> char -> _ CI.fatptr -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_78_LAPACKE_zgeesx_byte14" "owl_stub_78_LAPACKE_zgeesx"

external lapacke_sgeev
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_79_LAPACKE_sgeev_byte12" "owl_stub_79_LAPACKE_sgeev"

external lapacke_dgeev
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_80_LAPACKE_dgeev_byte12" "owl_stub_80_LAPACKE_dgeev"

external lapacke_cgeev
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_81_LAPACKE_cgeev_byte11" "owl_stub_81_LAPACKE_cgeev"

external lapacke_zgeev
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_82_LAPACKE_zgeev_byte11" "owl_stub_82_LAPACKE_zgeev"

external lapacke_sgeevx
  : int -> char -> char -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_83_LAPACKE_sgeevx_byte20" "owl_stub_83_LAPACKE_sgeevx"

external lapacke_dgeevx
  : int -> char -> char -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_84_LAPACKE_dgeevx_byte20" "owl_stub_84_LAPACKE_dgeevx"

external lapacke_cgeevx
  : int -> char -> char -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_85_LAPACKE_cgeevx_byte19" "owl_stub_85_LAPACKE_cgeevx"

external lapacke_zgeevx
  : int -> char -> char -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_86_LAPACKE_zgeevx_byte19" "owl_stub_86_LAPACKE_zgeevx"

external lapacke_sgehrd
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_87_LAPACKE_sgehrd_byte7" "owl_stub_87_LAPACKE_sgehrd"

external lapacke_dgehrd
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_88_LAPACKE_dgehrd_byte7" "owl_stub_88_LAPACKE_dgehrd"

external lapacke_cgehrd
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_89_LAPACKE_cgehrd_byte7" "owl_stub_89_LAPACKE_cgehrd"

external lapacke_zgehrd
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_90_LAPACKE_zgehrd_byte7" "owl_stub_90_LAPACKE_zgehrd"

external lapacke_sgejsv
  : int -> char -> char -> char -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_91_LAPACKE_sgejsv_byte18" "owl_stub_91_LAPACKE_sgejsv"

external lapacke_dgejsv
  : int -> char -> char -> char -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_92_LAPACKE_dgejsv_byte18" "owl_stub_92_LAPACKE_dgejsv"

external lapacke_cgejsv
  : int -> char -> char -> char -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_93_LAPACKE_cgejsv_byte18" "owl_stub_93_LAPACKE_cgejsv"

external lapacke_zgejsv
  : int -> char -> char -> char -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_94_LAPACKE_zgejsv_byte18" "owl_stub_94_LAPACKE_zgejsv"

external lapacke_sgelq2
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_95_LAPACKE_sgelq2_byte6" "owl_stub_95_LAPACKE_sgelq2"

external lapacke_dgelq2
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_96_LAPACKE_dgelq2_byte6" "owl_stub_96_LAPACKE_dgelq2"

external lapacke_cgelq2
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_97_LAPACKE_cgelq2_byte6" "owl_stub_97_LAPACKE_cgelq2"

external lapacke_zgelq2
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_98_LAPACKE_zgelq2_byte6" "owl_stub_98_LAPACKE_zgelq2"

external lapacke_sgelqf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_99_LAPACKE_sgelqf_byte6" "owl_stub_99_LAPACKE_sgelqf"

external lapacke_dgelqf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_100_LAPACKE_dgelqf_byte6" "owl_stub_100_LAPACKE_dgelqf"

external lapacke_cgelqf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_101_LAPACKE_cgelqf_byte6" "owl_stub_101_LAPACKE_cgelqf"

external lapacke_zgelqf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_102_LAPACKE_zgelqf_byte6" "owl_stub_102_LAPACKE_zgelqf"

external lapacke_sgels
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_103_LAPACKE_sgels_byte9" "owl_stub_103_LAPACKE_sgels"

external lapacke_dgels
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_104_LAPACKE_dgels_byte9" "owl_stub_104_LAPACKE_dgels"

external lapacke_cgels
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_105_LAPACKE_cgels_byte9" "owl_stub_105_LAPACKE_cgels"

external lapacke_zgels
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_106_LAPACKE_zgels_byte9" "owl_stub_106_LAPACKE_zgels"

external lapacke_sgelsd
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_107_LAPACKE_sgelsd_byte11" "owl_stub_107_LAPACKE_sgelsd"

external lapacke_dgelsd
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_108_LAPACKE_dgelsd_byte11" "owl_stub_108_LAPACKE_dgelsd"

external lapacke_cgelsd
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_109_LAPACKE_cgelsd_byte11" "owl_stub_109_LAPACKE_cgelsd"

external lapacke_zgelsd
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_110_LAPACKE_zgelsd_byte11" "owl_stub_110_LAPACKE_zgelsd"

external lapacke_sgelss
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_111_LAPACKE_sgelss_byte11" "owl_stub_111_LAPACKE_sgelss"

external lapacke_dgelss
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_112_LAPACKE_dgelss_byte11" "owl_stub_112_LAPACKE_dgelss"

external lapacke_cgelss
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_113_LAPACKE_cgelss_byte11" "owl_stub_113_LAPACKE_cgelss"

external lapacke_zgelss
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_114_LAPACKE_zgelss_byte11" "owl_stub_114_LAPACKE_zgelss"

external lapacke_sgelsy
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_115_LAPACKE_sgelsy_byte11" "owl_stub_115_LAPACKE_sgelsy"

external lapacke_dgelsy
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_116_LAPACKE_dgelsy_byte11" "owl_stub_116_LAPACKE_dgelsy"

external lapacke_cgelsy
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_117_LAPACKE_cgelsy_byte11" "owl_stub_117_LAPACKE_cgelsy"

external lapacke_zgelsy
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_118_LAPACKE_zgelsy_byte11" "owl_stub_118_LAPACKE_zgelsy"

external lapacke_sgeqlf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_119_LAPACKE_sgeqlf_byte6" "owl_stub_119_LAPACKE_sgeqlf"

external lapacke_dgeqlf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_120_LAPACKE_dgeqlf_byte6" "owl_stub_120_LAPACKE_dgeqlf"

external lapacke_cgeqlf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_121_LAPACKE_cgeqlf_byte6" "owl_stub_121_LAPACKE_cgeqlf"

external lapacke_zgeqlf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_122_LAPACKE_zgeqlf_byte6" "owl_stub_122_LAPACKE_zgeqlf"

external lapacke_sgeqp3
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_123_LAPACKE_sgeqp3_byte7" "owl_stub_123_LAPACKE_sgeqp3"

external lapacke_dgeqp3
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_124_LAPACKE_dgeqp3_byte7" "owl_stub_124_LAPACKE_dgeqp3"

external lapacke_cgeqp3
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_125_LAPACKE_cgeqp3_byte7" "owl_stub_125_LAPACKE_cgeqp3"

external lapacke_zgeqp3
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_126_LAPACKE_zgeqp3_byte7" "owl_stub_126_LAPACKE_zgeqp3"

external lapacke_sgeqr2
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_127_LAPACKE_sgeqr2_byte6" "owl_stub_127_LAPACKE_sgeqr2"

external lapacke_dgeqr2
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_128_LAPACKE_dgeqr2_byte6" "owl_stub_128_LAPACKE_dgeqr2"

external lapacke_cgeqr2
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_129_LAPACKE_cgeqr2_byte6" "owl_stub_129_LAPACKE_cgeqr2"

external lapacke_zgeqr2
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_130_LAPACKE_zgeqr2_byte6" "owl_stub_130_LAPACKE_zgeqr2"

external lapacke_sgeqrf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_131_LAPACKE_sgeqrf_byte6" "owl_stub_131_LAPACKE_sgeqrf"

external lapacke_dgeqrf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_132_LAPACKE_dgeqrf_byte6" "owl_stub_132_LAPACKE_dgeqrf"

external lapacke_cgeqrf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_133_LAPACKE_cgeqrf_byte6" "owl_stub_133_LAPACKE_cgeqrf"

external lapacke_zgeqrf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_134_LAPACKE_zgeqrf_byte6" "owl_stub_134_LAPACKE_zgeqrf"

external lapacke_sgeqrfp
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_135_LAPACKE_sgeqrfp_byte6" "owl_stub_135_LAPACKE_sgeqrfp"

external lapacke_dgeqrfp
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_136_LAPACKE_dgeqrfp_byte6" "owl_stub_136_LAPACKE_dgeqrfp"

external lapacke_cgeqrfp
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_137_LAPACKE_cgeqrfp_byte6" "owl_stub_137_LAPACKE_cgeqrfp"

external lapacke_zgeqrfp
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_138_LAPACKE_zgeqrfp_byte6" "owl_stub_138_LAPACKE_zgeqrfp"

external lapacke_sgerfs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_139_LAPACKE_sgerfs_byte15" "owl_stub_139_LAPACKE_sgerfs"

external lapacke_dgerfs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_140_LAPACKE_dgerfs_byte15" "owl_stub_140_LAPACKE_dgerfs"

external lapacke_cgerfs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_141_LAPACKE_cgerfs_byte15" "owl_stub_141_LAPACKE_cgerfs"

external lapacke_zgerfs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_142_LAPACKE_zgerfs_byte15" "owl_stub_142_LAPACKE_zgerfs"

external lapacke_sgerqf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_143_LAPACKE_sgerqf_byte6" "owl_stub_143_LAPACKE_sgerqf"

external lapacke_dgerqf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_144_LAPACKE_dgerqf_byte6" "owl_stub_144_LAPACKE_dgerqf"

external lapacke_cgerqf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_145_LAPACKE_cgerqf_byte6" "owl_stub_145_LAPACKE_cgerqf"

external lapacke_zgerqf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_146_LAPACKE_zgerqf_byte6" "owl_stub_146_LAPACKE_zgerqf"

external lapacke_sgesdd
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_147_LAPACKE_sgesdd_byte11" "owl_stub_147_LAPACKE_sgesdd"

external lapacke_dgesdd
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_148_LAPACKE_dgesdd_byte11" "owl_stub_148_LAPACKE_dgesdd"

external lapacke_cgesdd
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_149_LAPACKE_cgesdd_byte11" "owl_stub_149_LAPACKE_cgesdd"

external lapacke_zgesdd
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_150_LAPACKE_zgesdd_byte11" "owl_stub_150_LAPACKE_zgesdd"

external lapacke_sgesv
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_151_LAPACKE_sgesv_byte8" "owl_stub_151_LAPACKE_sgesv"

external lapacke_dgesv
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_152_LAPACKE_dgesv_byte8" "owl_stub_152_LAPACKE_dgesv"

external lapacke_cgesv
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_153_LAPACKE_cgesv_byte8" "owl_stub_153_LAPACKE_cgesv"

external lapacke_zgesv
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_154_LAPACKE_zgesv_byte8" "owl_stub_154_LAPACKE_zgesv"

external lapacke_dsgesv
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_155_LAPACKE_dsgesv_byte11" "owl_stub_155_LAPACKE_dsgesv"

external lapacke_zcgesv
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_156_LAPACKE_zcgesv_byte11" "owl_stub_156_LAPACKE_zcgesv"

external lapacke_sgesvd
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_157_LAPACKE_sgesvd_byte13" "owl_stub_157_LAPACKE_sgesvd"

external lapacke_dgesvd
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_158_LAPACKE_dgesvd_byte13" "owl_stub_158_LAPACKE_dgesvd"

external lapacke_cgesvd
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_159_LAPACKE_cgesvd_byte13" "owl_stub_159_LAPACKE_cgesvd"

external lapacke_zgesvd
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_160_LAPACKE_zgesvd_byte13" "owl_stub_160_LAPACKE_zgesvd"

external lapacke_sgesvdx
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_161_LAPACKE_sgesvdx_byte19" "owl_stub_161_LAPACKE_sgesvdx"

external lapacke_dgesvdx
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_162_LAPACKE_dgesvdx_byte19" "owl_stub_162_LAPACKE_dgesvdx"

external lapacke_cgesvdx
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_163_LAPACKE_cgesvdx_byte19" "owl_stub_163_LAPACKE_cgesvdx"

external lapacke_zgesvdx
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_164_LAPACKE_zgesvdx_byte19" "owl_stub_164_LAPACKE_zgesvdx"

external lapacke_sgesvj
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_165_LAPACKE_sgesvj_byte13" "owl_stub_165_LAPACKE_sgesvj"

external lapacke_dgesvj
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_166_LAPACKE_dgesvj_byte13" "owl_stub_166_LAPACKE_dgesvj"

external lapacke_cgesvj
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_167_LAPACKE_cgesvj_byte13" "owl_stub_167_LAPACKE_cgesvj"

external lapacke_zgesvj
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_168_LAPACKE_zgesvj_byte13" "owl_stub_168_LAPACKE_zgesvj"

external lapacke_sgesvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_169_LAPACKE_sgesvx_byte21" "owl_stub_169_LAPACKE_sgesvx"

external lapacke_dgesvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_170_LAPACKE_dgesvx_byte21" "owl_stub_170_LAPACKE_dgesvx"

external lapacke_cgesvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_171_LAPACKE_cgesvx_byte21" "owl_stub_171_LAPACKE_cgesvx"

external lapacke_zgesvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_172_LAPACKE_zgesvx_byte21" "owl_stub_172_LAPACKE_zgesvx"

external lapacke_sgetf2
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_173_LAPACKE_sgetf2_byte6" "owl_stub_173_LAPACKE_sgetf2"

external lapacke_dgetf2
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_174_LAPACKE_dgetf2_byte6" "owl_stub_174_LAPACKE_dgetf2"

external lapacke_cgetf2
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_175_LAPACKE_cgetf2_byte6" "owl_stub_175_LAPACKE_cgetf2"

external lapacke_zgetf2
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_176_LAPACKE_zgetf2_byte6" "owl_stub_176_LAPACKE_zgetf2"

external lapacke_sgetrf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_177_LAPACKE_sgetrf_byte6" "owl_stub_177_LAPACKE_sgetrf"

external lapacke_dgetrf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_178_LAPACKE_dgetrf_byte6" "owl_stub_178_LAPACKE_dgetrf"

external lapacke_cgetrf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_179_LAPACKE_cgetrf_byte6" "owl_stub_179_LAPACKE_cgetrf"

external lapacke_zgetrf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_180_LAPACKE_zgetrf_byte6" "owl_stub_180_LAPACKE_zgetrf"

external lapacke_sgetrf2
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_181_LAPACKE_sgetrf2_byte6" "owl_stub_181_LAPACKE_sgetrf2"

external lapacke_dgetrf2
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_182_LAPACKE_dgetrf2_byte6" "owl_stub_182_LAPACKE_dgetrf2"

external lapacke_cgetrf2
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_183_LAPACKE_cgetrf2_byte6" "owl_stub_183_LAPACKE_cgetrf2"

external lapacke_zgetrf2
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_184_LAPACKE_zgetrf2_byte6" "owl_stub_184_LAPACKE_zgetrf2"

external lapacke_sgetri
  : int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_185_LAPACKE_sgetri"

external lapacke_dgetri
  : int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_186_LAPACKE_dgetri"

external lapacke_cgetri
  : int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_187_LAPACKE_cgetri"

external lapacke_zgetri
  : int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_188_LAPACKE_zgetri"

external lapacke_sgetrs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_189_LAPACKE_sgetrs_byte9" "owl_stub_189_LAPACKE_sgetrs"

external lapacke_dgetrs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_190_LAPACKE_dgetrs_byte9" "owl_stub_190_LAPACKE_dgetrs"

external lapacke_cgetrs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_191_LAPACKE_cgetrs_byte9" "owl_stub_191_LAPACKE_cgetrs"

external lapacke_zgetrs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_192_LAPACKE_zgetrs_byte9" "owl_stub_192_LAPACKE_zgetrs"

external lapacke_sggbak
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_193_LAPACKE_sggbak_byte11" "owl_stub_193_LAPACKE_sggbak"

external lapacke_dggbak
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_194_LAPACKE_dggbak_byte11" "owl_stub_194_LAPACKE_dggbak"

external lapacke_cggbak
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_195_LAPACKE_cggbak_byte11" "owl_stub_195_LAPACKE_cggbak"

external lapacke_zggbak
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_196_LAPACKE_zggbak_byte11" "owl_stub_196_LAPACKE_zggbak"

external lapacke_sggbal
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_197_LAPACKE_sggbal_byte11" "owl_stub_197_LAPACKE_sggbal"

external lapacke_dggbal
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_198_LAPACKE_dggbal_byte11" "owl_stub_198_LAPACKE_dggbal"

external lapacke_cggbal
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_199_LAPACKE_cggbal_byte11" "owl_stub_199_LAPACKE_cggbal"

external lapacke_zggbal
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_200_LAPACKE_zggbal_byte11" "owl_stub_200_LAPACKE_zggbal"

external lapacke_sgges
  : int -> char -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_201_LAPACKE_sgges_byte18" "owl_stub_201_LAPACKE_sgges"

external lapacke_dgges
  : int -> char -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_202_LAPACKE_dgges_byte18" "owl_stub_202_LAPACKE_dgges"

external lapacke_cgges
  : int -> char -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_203_LAPACKE_cgges_byte17" "owl_stub_203_LAPACKE_cgges"

external lapacke_zgges
  : int -> char -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_204_LAPACKE_zgges_byte17" "owl_stub_204_LAPACKE_zgges"

external lapacke_sgges3
  : int -> char -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_205_LAPACKE_sgges3_byte18" "owl_stub_205_LAPACKE_sgges3"

external lapacke_dgges3
  : int -> char -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_206_LAPACKE_dgges3_byte18" "owl_stub_206_LAPACKE_dgges3"

external lapacke_cgges3
  : int -> char -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_207_LAPACKE_cgges3_byte17" "owl_stub_207_LAPACKE_cgges3"

external lapacke_zgges3
  : int -> char -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_208_LAPACKE_zgges3_byte17" "owl_stub_208_LAPACKE_zgges3"

external lapacke_sggesx
  : int -> char -> char -> char -> _ CI.fatptr -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_209_LAPACKE_sggesx_byte21" "owl_stub_209_LAPACKE_sggesx"

external lapacke_dggesx
  : int -> char -> char -> char -> _ CI.fatptr -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_210_LAPACKE_dggesx_byte21" "owl_stub_210_LAPACKE_dggesx"

external lapacke_cggesx
  : int -> char -> char -> char -> _ CI.fatptr -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_211_LAPACKE_cggesx_byte20" "owl_stub_211_LAPACKE_cggesx"

external lapacke_zggesx
  : int -> char -> char -> char -> _ CI.fatptr -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_212_LAPACKE_zggesx_byte20" "owl_stub_212_LAPACKE_zggesx"

external lapacke_sggev
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_213_LAPACKE_sggev_byte15" "owl_stub_213_LAPACKE_sggev"

external lapacke_dggev
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_214_LAPACKE_dggev_byte15" "owl_stub_214_LAPACKE_dggev"

external lapacke_cggev
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_215_LAPACKE_cggev_byte14" "owl_stub_215_LAPACKE_cggev"

external lapacke_zggev
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_216_LAPACKE_zggev_byte14" "owl_stub_216_LAPACKE_zggev"

external lapacke_sggev3
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_217_LAPACKE_sggev3_byte15" "owl_stub_217_LAPACKE_sggev3"

external lapacke_dggev3
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_218_LAPACKE_dggev3_byte15" "owl_stub_218_LAPACKE_dggev3"

external lapacke_cggev3
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_219_LAPACKE_cggev3_byte14" "owl_stub_219_LAPACKE_cggev3"

external lapacke_zggev3
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_220_LAPACKE_zggev3_byte14" "owl_stub_220_LAPACKE_zggev3"

external lapacke_sggevx
  : int -> char -> char -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_221_LAPACKE_sggevx_byte25" "owl_stub_221_LAPACKE_sggevx"

external lapacke_dggevx
  : int -> char -> char -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_222_LAPACKE_dggevx_byte25" "owl_stub_222_LAPACKE_dggevx"

external lapacke_cggevx
  : int -> char -> char -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_223_LAPACKE_cggevx_byte24" "owl_stub_223_LAPACKE_cggevx"

external lapacke_zggevx
  : int -> char -> char -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_224_LAPACKE_zggevx_byte24" "owl_stub_224_LAPACKE_zggevx"

external lapacke_sggglm
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_225_LAPACKE_sggglm_byte11" "owl_stub_225_LAPACKE_sggglm"

external lapacke_dggglm
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_226_LAPACKE_dggglm_byte11" "owl_stub_226_LAPACKE_dggglm"

external lapacke_cggglm
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_227_LAPACKE_cggglm_byte11" "owl_stub_227_LAPACKE_cggglm"

external lapacke_zggglm
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_228_LAPACKE_zggglm_byte11" "owl_stub_228_LAPACKE_zggglm"

external lapacke_sgghrd
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_229_LAPACKE_sgghrd_byte14" "owl_stub_229_LAPACKE_sgghrd"

external lapacke_dgghrd
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_230_LAPACKE_dgghrd_byte14" "owl_stub_230_LAPACKE_dgghrd"

external lapacke_cgghrd
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_231_LAPACKE_cgghrd_byte14" "owl_stub_231_LAPACKE_cgghrd"

external lapacke_zgghrd
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_232_LAPACKE_zgghrd_byte14" "owl_stub_232_LAPACKE_zgghrd"

external lapacke_sgghd3
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_233_LAPACKE_sgghd3_byte14" "owl_stub_233_LAPACKE_sgghd3"

external lapacke_dgghd3
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_234_LAPACKE_dgghd3_byte14" "owl_stub_234_LAPACKE_dgghd3"

external lapacke_cgghd3
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_235_LAPACKE_cgghd3_byte14" "owl_stub_235_LAPACKE_cgghd3"

external lapacke_zgghd3
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_236_LAPACKE_zgghd3_byte14" "owl_stub_236_LAPACKE_zgghd3"

external lapacke_sgglse
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_237_LAPACKE_sgglse_byte11" "owl_stub_237_LAPACKE_sgglse"

external lapacke_dgglse
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_238_LAPACKE_dgglse_byte11" "owl_stub_238_LAPACKE_dgglse"

external lapacke_cgglse
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_239_LAPACKE_cgglse_byte11" "owl_stub_239_LAPACKE_cgglse"

external lapacke_zgglse
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_240_LAPACKE_zgglse_byte11" "owl_stub_240_LAPACKE_zgglse"

external lapacke_sggqrf
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_241_LAPACKE_sggqrf_byte10" "owl_stub_241_LAPACKE_sggqrf"

external lapacke_dggqrf
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_242_LAPACKE_dggqrf_byte10" "owl_stub_242_LAPACKE_dggqrf"

external lapacke_cggqrf
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_243_LAPACKE_cggqrf_byte10" "owl_stub_243_LAPACKE_cggqrf"

external lapacke_zggqrf
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_244_LAPACKE_zggqrf_byte10" "owl_stub_244_LAPACKE_zggqrf"

external lapacke_sggrqf
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_245_LAPACKE_sggrqf_byte10" "owl_stub_245_LAPACKE_sggrqf"

external lapacke_dggrqf
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_246_LAPACKE_dggrqf_byte10" "owl_stub_246_LAPACKE_dggrqf"

external lapacke_cggrqf
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_247_LAPACKE_cggrqf_byte10" "owl_stub_247_LAPACKE_cggrqf"

external lapacke_zggrqf
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_248_LAPACKE_zggrqf_byte10" "owl_stub_248_LAPACKE_zggrqf"

external lapacke_sggsvd3
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_249_LAPACKE_sggsvd3_byte22" "owl_stub_249_LAPACKE_sggsvd3"

external lapacke_dggsvd3
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_250_LAPACKE_dggsvd3_byte22" "owl_stub_250_LAPACKE_dggsvd3"

external lapacke_cggsvd3
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_251_LAPACKE_cggsvd3_byte22" "owl_stub_251_LAPACKE_cggsvd3"

external lapacke_zggsvd3
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_252_LAPACKE_zggsvd3_byte22" "owl_stub_252_LAPACKE_zggsvd3"

external lapacke_sggsvp3
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_253_LAPACKE_sggsvp3_byte21" "owl_stub_253_LAPACKE_sggsvp3"

external lapacke_dggsvp3
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_254_LAPACKE_dggsvp3_byte21" "owl_stub_254_LAPACKE_dggsvp3"

external lapacke_cggsvp3
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_255_LAPACKE_cggsvp3_byte21" "owl_stub_255_LAPACKE_cggsvp3"

external lapacke_zggsvp3
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_256_LAPACKE_zggsvp3_byte21" "owl_stub_256_LAPACKE_zggsvp3"

external lapacke_sgtcon
  : char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_257_LAPACKE_sgtcon_byte9" "owl_stub_257_LAPACKE_sgtcon"

external lapacke_dgtcon
  : char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_258_LAPACKE_dgtcon_byte9" "owl_stub_258_LAPACKE_dgtcon"

external lapacke_cgtcon
  : char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_259_LAPACKE_cgtcon_byte9" "owl_stub_259_LAPACKE_cgtcon"

external lapacke_zgtcon
  : char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_260_LAPACKE_zgtcon_byte9" "owl_stub_260_LAPACKE_zgtcon"

external lapacke_sgtrfs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_261_LAPACKE_sgtrfs_byte18" "owl_stub_261_LAPACKE_sgtrfs"

external lapacke_dgtrfs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_262_LAPACKE_dgtrfs_byte18" "owl_stub_262_LAPACKE_dgtrfs"

external lapacke_cgtrfs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_263_LAPACKE_cgtrfs_byte18" "owl_stub_263_LAPACKE_cgtrfs"

external lapacke_zgtrfs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_264_LAPACKE_zgtrfs_byte18" "owl_stub_264_LAPACKE_zgtrfs"

external lapacke_sgtsv
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_265_LAPACKE_sgtsv_byte8" "owl_stub_265_LAPACKE_sgtsv"

external lapacke_dgtsv
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_266_LAPACKE_dgtsv_byte8" "owl_stub_266_LAPACKE_dgtsv"

external lapacke_cgtsv
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_267_LAPACKE_cgtsv_byte8" "owl_stub_267_LAPACKE_cgtsv"

external lapacke_zgtsv
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_268_LAPACKE_zgtsv_byte8" "owl_stub_268_LAPACKE_zgtsv"

external lapacke_sgtsvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_269_LAPACKE_sgtsvx_byte20" "owl_stub_269_LAPACKE_sgtsvx"

external lapacke_dgtsvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_270_LAPACKE_dgtsvx_byte20" "owl_stub_270_LAPACKE_dgtsvx"

external lapacke_cgtsvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_271_LAPACKE_cgtsvx_byte20" "owl_stub_271_LAPACKE_cgtsvx"

external lapacke_zgtsvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_272_LAPACKE_zgtsvx_byte20" "owl_stub_272_LAPACKE_zgtsvx"

external lapacke_sgttrf
  : int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_273_LAPACKE_sgttrf_byte6" "owl_stub_273_LAPACKE_sgttrf"

external lapacke_dgttrf
  : int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_274_LAPACKE_dgttrf_byte6" "owl_stub_274_LAPACKE_dgttrf"

external lapacke_cgttrf
  : int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_275_LAPACKE_cgttrf_byte6" "owl_stub_275_LAPACKE_cgttrf"

external lapacke_zgttrf
  : int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_276_LAPACKE_zgttrf_byte6" "owl_stub_276_LAPACKE_zgttrf"

external lapacke_sgttrs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_277_LAPACKE_sgttrs_byte11" "owl_stub_277_LAPACKE_sgttrs"

external lapacke_dgttrs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_278_LAPACKE_dgttrs_byte11" "owl_stub_278_LAPACKE_dgttrs"

external lapacke_cgttrs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_279_LAPACKE_cgttrs_byte11" "owl_stub_279_LAPACKE_cgttrs"

external lapacke_zgttrs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_280_LAPACKE_zgttrs_byte11" "owl_stub_280_LAPACKE_zgttrs"

external lapacke_chbev
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_281_LAPACKE_chbev_byte10" "owl_stub_281_LAPACKE_chbev"

external lapacke_zhbev
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_282_LAPACKE_zhbev_byte10" "owl_stub_282_LAPACKE_zhbev"

external lapacke_chbevd
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_283_LAPACKE_chbevd_byte10" "owl_stub_283_LAPACKE_chbevd"

external lapacke_zhbevd
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_284_LAPACKE_zhbevd_byte10" "owl_stub_284_LAPACKE_zhbevd"

external lapacke_chbevx
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_285_LAPACKE_chbevx_byte20" "owl_stub_285_LAPACKE_chbevx"

external lapacke_zhbevx
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_286_LAPACKE_zhbevx_byte20" "owl_stub_286_LAPACKE_zhbevx"

external lapacke_chbgst
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_287_LAPACKE_chbgst_byte12" "owl_stub_287_LAPACKE_chbgst"

external lapacke_zhbgst
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_288_LAPACKE_zhbgst_byte12" "owl_stub_288_LAPACKE_zhbgst"

external lapacke_chbgv
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_289_LAPACKE_chbgv_byte13" "owl_stub_289_LAPACKE_chbgv"

external lapacke_zhbgv
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_290_LAPACKE_zhbgv_byte13" "owl_stub_290_LAPACKE_zhbgv"

external lapacke_chbgvd
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_291_LAPACKE_chbgvd_byte13" "owl_stub_291_LAPACKE_chbgvd"

external lapacke_zhbgvd
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_292_LAPACKE_zhbgvd_byte13" "owl_stub_292_LAPACKE_zhbgvd"

external lapacke_chbgvx
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_293_LAPACKE_chbgvx_byte23" "owl_stub_293_LAPACKE_chbgvx"

external lapacke_zhbgvx
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_294_LAPACKE_zhbgvx_byte23" "owl_stub_294_LAPACKE_zhbgvx"

external lapacke_chbtrd
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_295_LAPACKE_chbtrd_byte11" "owl_stub_295_LAPACKE_chbtrd"

external lapacke_zhbtrd
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_296_LAPACKE_zhbtrd_byte11" "owl_stub_296_LAPACKE_zhbtrd"

external lapacke_checon
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_297_LAPACKE_checon_byte8" "owl_stub_297_LAPACKE_checon"

external lapacke_zhecon
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_298_LAPACKE_zhecon_byte8" "owl_stub_298_LAPACKE_zhecon"

external lapacke_cheequb
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_299_LAPACKE_cheequb_byte8" "owl_stub_299_LAPACKE_cheequb"

external lapacke_zheequb
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_300_LAPACKE_zheequb_byte8" "owl_stub_300_LAPACKE_zheequb"

external lapacke_cheev
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_301_LAPACKE_cheev_byte7" "owl_stub_301_LAPACKE_cheev"

external lapacke_zheev
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_302_LAPACKE_zheev_byte7" "owl_stub_302_LAPACKE_zheev"

external lapacke_cheevd
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_303_LAPACKE_cheevd_byte7" "owl_stub_303_LAPACKE_cheevd"

external lapacke_zheevd
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_304_LAPACKE_zheevd_byte7" "owl_stub_304_LAPACKE_zheevd"

external lapacke_cheevr
  : int -> char -> char -> char -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_305_LAPACKE_cheevr_byte17" "owl_stub_305_LAPACKE_cheevr"

external lapacke_zheevr
  : int -> char -> char -> char -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_306_LAPACKE_zheevr_byte17" "owl_stub_306_LAPACKE_zheevr"

external lapacke_cheevx
  : int -> char -> char -> char -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_307_LAPACKE_cheevx_byte17" "owl_stub_307_LAPACKE_cheevx"

external lapacke_zheevx
  : int -> char -> char -> char -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_308_LAPACKE_zheevx_byte17" "owl_stub_308_LAPACKE_zheevx"

external lapacke_chegst
  : int -> int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_309_LAPACKE_chegst_byte8" "owl_stub_309_LAPACKE_chegst"

external lapacke_zhegst
  : int -> int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_310_LAPACKE_zhegst_byte8" "owl_stub_310_LAPACKE_zhegst"

external lapacke_chegv
  : int -> int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_311_LAPACKE_chegv_byte10" "owl_stub_311_LAPACKE_chegv"

external lapacke_zhegv
  : int -> int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_312_LAPACKE_zhegv_byte10" "owl_stub_312_LAPACKE_zhegv"

external lapacke_chegvd
  : int -> int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_313_LAPACKE_chegvd_byte10" "owl_stub_313_LAPACKE_chegvd"

external lapacke_zhegvd
  : int -> int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_314_LAPACKE_zhegvd_byte10" "owl_stub_314_LAPACKE_zhegvd"

external lapacke_chegvx
  : int -> int -> char -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_315_LAPACKE_chegvx_byte20" "owl_stub_315_LAPACKE_chegvx"

external lapacke_zhegvx
  : int -> int -> char -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_316_LAPACKE_zhegvx_byte20" "owl_stub_316_LAPACKE_zhegvx"

external lapacke_cherfs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_317_LAPACKE_cherfs_byte15" "owl_stub_317_LAPACKE_cherfs"

external lapacke_zherfs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_318_LAPACKE_zherfs_byte15" "owl_stub_318_LAPACKE_zherfs"

external lapacke_chesv
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_319_LAPACKE_chesv_byte9" "owl_stub_319_LAPACKE_chesv"

external lapacke_zhesv
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_320_LAPACKE_zhesv_byte9" "owl_stub_320_LAPACKE_zhesv"

external lapacke_chesvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_321_LAPACKE_chesvx_byte17" "owl_stub_321_LAPACKE_chesvx"

external lapacke_zhesvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_322_LAPACKE_zhesvx_byte17" "owl_stub_322_LAPACKE_zhesvx"

external lapacke_chetrd
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_323_LAPACKE_chetrd_byte8" "owl_stub_323_LAPACKE_chetrd"

external lapacke_zhetrd
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_324_LAPACKE_zhetrd_byte8" "owl_stub_324_LAPACKE_zhetrd"

external lapacke_chetrf
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_325_LAPACKE_chetrf_byte6" "owl_stub_325_LAPACKE_chetrf"

external lapacke_zhetrf
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_326_LAPACKE_zhetrf_byte6" "owl_stub_326_LAPACKE_zhetrf"

external lapacke_chetri
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_327_LAPACKE_chetri_byte6" "owl_stub_327_LAPACKE_chetri"

external lapacke_zhetri
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_328_LAPACKE_zhetri_byte6" "owl_stub_328_LAPACKE_zhetri"

external lapacke_chetrs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_329_LAPACKE_chetrs_byte9" "owl_stub_329_LAPACKE_chetrs"

external lapacke_zhetrs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_330_LAPACKE_zhetrs_byte9" "owl_stub_330_LAPACKE_zhetrs"

external lapacke_chfrk
  : int -> char -> char -> char -> int -> int -> float -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int
  = "owl_stub_331_LAPACKE_chfrk_byte11" "owl_stub_331_LAPACKE_chfrk"

external lapacke_zhfrk
  : int -> char -> char -> char -> int -> int -> float -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int
  = "owl_stub_332_LAPACKE_zhfrk_byte11" "owl_stub_332_LAPACKE_zhfrk"

external lapacke_shgeqz
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_333_LAPACKE_shgeqz_byte18" "owl_stub_333_LAPACKE_shgeqz"

external lapacke_dhgeqz
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_334_LAPACKE_dhgeqz_byte18" "owl_stub_334_LAPACKE_dhgeqz"

external lapacke_chgeqz
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_335_LAPACKE_chgeqz_byte17" "owl_stub_335_LAPACKE_chgeqz"

external lapacke_zhgeqz
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_336_LAPACKE_zhgeqz_byte17" "owl_stub_336_LAPACKE_zhgeqz"

external lapacke_chpcon
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_337_LAPACKE_chpcon_byte7" "owl_stub_337_LAPACKE_chpcon"

external lapacke_zhpcon
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_338_LAPACKE_zhpcon_byte7" "owl_stub_338_LAPACKE_zhpcon"

external lapacke_chpev
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_339_LAPACKE_chpev_byte8" "owl_stub_339_LAPACKE_chpev"

external lapacke_zhpev
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_340_LAPACKE_zhpev_byte8" "owl_stub_340_LAPACKE_zhpev"

external lapacke_chpevd
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_341_LAPACKE_chpevd_byte8" "owl_stub_341_LAPACKE_chpevd"

external lapacke_zhpevd
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_342_LAPACKE_zhpevd_byte8" "owl_stub_342_LAPACKE_zhpevd"

external lapacke_chpevx
  : int -> char -> char -> char -> int -> _ CI.fatptr -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_343_LAPACKE_chpevx_byte16" "owl_stub_343_LAPACKE_chpevx"

external lapacke_zhpevx
  : int -> char -> char -> char -> int -> _ CI.fatptr -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_344_LAPACKE_zhpevx_byte16" "owl_stub_344_LAPACKE_zhpevx"

external lapacke_chpgst
  : int -> int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_345_LAPACKE_chpgst_byte6" "owl_stub_345_LAPACKE_chpgst"

external lapacke_zhpgst
  : int -> int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_346_LAPACKE_zhpgst_byte6" "owl_stub_346_LAPACKE_zhpgst"

external lapacke_chpgv
  : int -> int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_347_LAPACKE_chpgv_byte10" "owl_stub_347_LAPACKE_chpgv"

external lapacke_zhpgv
  : int -> int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_348_LAPACKE_zhpgv_byte10" "owl_stub_348_LAPACKE_zhpgv"

external lapacke_chpgvd
  : int -> int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_349_LAPACKE_chpgvd_byte10" "owl_stub_349_LAPACKE_chpgvd"

external lapacke_zhpgvd
  : int -> int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_350_LAPACKE_zhpgvd_byte10" "owl_stub_350_LAPACKE_zhpgvd"

external lapacke_chpgvx
  : int -> int -> char -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_351_LAPACKE_chpgvx_byte18" "owl_stub_351_LAPACKE_chpgvx"

external lapacke_zhpgvx
  : int -> int -> char -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_352_LAPACKE_zhpgvx_byte18" "owl_stub_352_LAPACKE_zhpgvx"

external lapacke_chprfs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_353_LAPACKE_chprfs_byte13" "owl_stub_353_LAPACKE_chprfs"

external lapacke_zhprfs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_354_LAPACKE_zhprfs_byte13" "owl_stub_354_LAPACKE_zhprfs"

external lapacke_chpsv
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_355_LAPACKE_chpsv_byte8" "owl_stub_355_LAPACKE_chpsv"

external lapacke_zhpsv
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_356_LAPACKE_zhpsv_byte8" "owl_stub_356_LAPACKE_zhpsv"

external lapacke_chpsvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_357_LAPACKE_chpsvx_byte15" "owl_stub_357_LAPACKE_chpsvx"

external lapacke_zhpsvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_358_LAPACKE_zhpsvx_byte15" "owl_stub_358_LAPACKE_zhpsvx"

external lapacke_chptrd
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_359_LAPACKE_chptrd_byte7" "owl_stub_359_LAPACKE_chptrd"

external lapacke_zhptrd
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_360_LAPACKE_zhptrd_byte7" "owl_stub_360_LAPACKE_zhptrd"

external lapacke_chptrf
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_361_LAPACKE_chptrf"

external lapacke_zhptrf
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_362_LAPACKE_zhptrf"

external lapacke_chptri
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_363_LAPACKE_chptri"

external lapacke_zhptri
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_364_LAPACKE_zhptri"

external lapacke_chptrs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_365_LAPACKE_chptrs_byte8" "owl_stub_365_LAPACKE_chptrs"

external lapacke_zhptrs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_366_LAPACKE_zhptrs_byte8" "owl_stub_366_LAPACKE_zhptrs"

external lapacke_shsein
  : int -> char -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_367_LAPACKE_shsein_byte18" "owl_stub_367_LAPACKE_shsein"

external lapacke_dhsein
  : int -> char -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_368_LAPACKE_dhsein_byte18" "owl_stub_368_LAPACKE_dhsein"

external lapacke_chsein
  : int -> char -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_369_LAPACKE_chsein_byte17" "owl_stub_369_LAPACKE_chsein"

external lapacke_zhsein
  : int -> char -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_370_LAPACKE_zhsein_byte17" "owl_stub_370_LAPACKE_zhsein"

external lapacke_shseqr
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_371_LAPACKE_shseqr_byte12" "owl_stub_371_LAPACKE_shseqr"

external lapacke_dhseqr
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_372_LAPACKE_dhseqr_byte12" "owl_stub_372_LAPACKE_dhseqr"

external lapacke_chseqr
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_373_LAPACKE_chseqr_byte11" "owl_stub_373_LAPACKE_chseqr"

external lapacke_zhseqr
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_374_LAPACKE_zhseqr_byte11" "owl_stub_374_LAPACKE_zhseqr"

external lapacke_clacgv
  : int -> _ CI.fatptr -> int -> int
  = "owl_stub_375_LAPACKE_clacgv"

external lapacke_zlacgv
  : int -> _ CI.fatptr -> int -> int
  = "owl_stub_376_LAPACKE_zlacgv"

external lapacke_slacn2
  : int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_377_LAPACKE_slacn2_byte7" "owl_stub_377_LAPACKE_slacn2"

external lapacke_dlacn2
  : int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_378_LAPACKE_dlacn2_byte7" "owl_stub_378_LAPACKE_dlacn2"

external lapacke_clacn2
  : int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_379_LAPACKE_clacn2_byte6" "owl_stub_379_LAPACKE_clacn2"

external lapacke_zlacn2
  : int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_380_LAPACKE_zlacn2_byte6" "owl_stub_380_LAPACKE_zlacn2"

external lapacke_slacpy
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_381_LAPACKE_slacpy_byte8" "owl_stub_381_LAPACKE_slacpy"

external lapacke_dlacpy
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_382_LAPACKE_dlacpy_byte8" "owl_stub_382_LAPACKE_dlacpy"

external lapacke_clacpy
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_383_LAPACKE_clacpy_byte8" "owl_stub_383_LAPACKE_clacpy"

external lapacke_zlacpy
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_384_LAPACKE_zlacpy_byte8" "owl_stub_384_LAPACKE_zlacpy"

external lapacke_clacp2
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_385_LAPACKE_clacp2_byte8" "owl_stub_385_LAPACKE_clacp2"

external lapacke_zlacp2
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_386_LAPACKE_zlacp2_byte8" "owl_stub_386_LAPACKE_zlacp2"

external lapacke_zlag2c
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_387_LAPACKE_zlag2c_byte7" "owl_stub_387_LAPACKE_zlag2c"

external lapacke_slag2d
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_388_LAPACKE_slag2d_byte7" "owl_stub_388_LAPACKE_slag2d"

external lapacke_dlag2s
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_389_LAPACKE_dlag2s_byte7" "owl_stub_389_LAPACKE_dlag2s"

external lapacke_clag2z
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_390_LAPACKE_clag2z_byte7" "owl_stub_390_LAPACKE_clag2z"

external lapacke_slagge
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_391_LAPACKE_slagge_byte9" "owl_stub_391_LAPACKE_slagge"

external lapacke_dlagge
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_392_LAPACKE_dlagge_byte9" "owl_stub_392_LAPACKE_dlagge"

external lapacke_clagge
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_393_LAPACKE_clagge_byte9" "owl_stub_393_LAPACKE_clagge"

external lapacke_zlagge
  : int -> int -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_394_LAPACKE_zlagge_byte9" "owl_stub_394_LAPACKE_zlagge"

external lapacke_slarfb
  : int -> char -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_395_LAPACKE_slarfb_byte14" "owl_stub_395_LAPACKE_slarfb"

external lapacke_dlarfb
  : int -> char -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_396_LAPACKE_dlarfb_byte14" "owl_stub_396_LAPACKE_dlarfb"

external lapacke_clarfb
  : int -> char -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_397_LAPACKE_clarfb_byte14" "owl_stub_397_LAPACKE_clarfb"

external lapacke_zlarfb
  : int -> char -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_398_LAPACKE_zlarfb_byte14" "owl_stub_398_LAPACKE_zlarfb"

external lapacke_slarfg
  : int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_399_LAPACKE_slarfg"

external lapacke_dlarfg
  : int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_400_LAPACKE_dlarfg"

external lapacke_clarfg
  : int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_401_LAPACKE_clarfg"

external lapacke_zlarfg
  : int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_402_LAPACKE_zlarfg"

external lapacke_slarft
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_403_LAPACKE_slarft_byte10" "owl_stub_403_LAPACKE_slarft"

external lapacke_dlarft
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_404_LAPACKE_dlarft_byte10" "owl_stub_404_LAPACKE_dlarft"

external lapacke_clarft
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_405_LAPACKE_clarft_byte10" "owl_stub_405_LAPACKE_clarft"

external lapacke_zlarft
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_406_LAPACKE_zlarft_byte10" "owl_stub_406_LAPACKE_zlarft"

external lapacke_slarfx
  : int -> char -> int -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_407_LAPACKE_slarfx_byte9" "owl_stub_407_LAPACKE_slarfx"

external lapacke_dlarfx
  : int -> char -> int -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_408_LAPACKE_dlarfx_byte9" "owl_stub_408_LAPACKE_dlarfx"

external lapacke_clarfx
  : int -> char -> int -> int -> _ CI.fatptr -> Complex.t -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_409_LAPACKE_clarfx_byte9" "owl_stub_409_LAPACKE_clarfx"

external lapacke_zlarfx
  : int -> char -> int -> int -> _ CI.fatptr -> Complex.t -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_410_LAPACKE_zlarfx_byte9" "owl_stub_410_LAPACKE_zlarfx"

external lapacke_slarnv
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_411_LAPACKE_slarnv"

external lapacke_dlarnv
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_412_LAPACKE_dlarnv"

external lapacke_clarnv
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_413_LAPACKE_clarnv"

external lapacke_zlarnv
  : int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_414_LAPACKE_zlarnv"

external lapacke_slascl
  : int -> char -> int -> int -> float -> float -> int -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_415_LAPACKE_slascl_byte10" "owl_stub_415_LAPACKE_slascl"

external lapacke_dlascl
  : int -> char -> int -> int -> float -> float -> int -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_416_LAPACKE_dlascl_byte10" "owl_stub_416_LAPACKE_dlascl"

external lapacke_clascl
  : int -> char -> int -> int -> float -> float -> int -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_417_LAPACKE_clascl_byte10" "owl_stub_417_LAPACKE_clascl"

external lapacke_zlascl
  : int -> char -> int -> int -> float -> float -> int -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_418_LAPACKE_zlascl_byte10" "owl_stub_418_LAPACKE_zlascl"

external lapacke_slaset
  : int -> char -> int -> int -> float -> float -> _ CI.fatptr -> int -> int
  = "owl_stub_419_LAPACKE_slaset_byte8" "owl_stub_419_LAPACKE_slaset"

external lapacke_dlaset
  : int -> char -> int -> int -> float -> float -> _ CI.fatptr -> int -> int
  = "owl_stub_420_LAPACKE_dlaset_byte8" "owl_stub_420_LAPACKE_dlaset"

external lapacke_claset
  : int -> char -> int -> int -> Complex.t -> Complex.t -> _ CI.fatptr -> int -> int
  = "owl_stub_421_LAPACKE_claset_byte8" "owl_stub_421_LAPACKE_claset"

external lapacke_zlaset
  : int -> char -> int -> int -> Complex.t -> Complex.t -> _ CI.fatptr -> int -> int
  = "owl_stub_422_LAPACKE_zlaset_byte8" "owl_stub_422_LAPACKE_zlaset"

external lapacke_slasrt
  : char -> int -> _ CI.fatptr -> int
  = "owl_stub_423_LAPACKE_slasrt"

external lapacke_dlasrt
  : char -> int -> _ CI.fatptr -> int
  = "owl_stub_424_LAPACKE_dlasrt"

external lapacke_slaswp
  : int -> int -> _ CI.fatptr -> int -> int -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_425_LAPACKE_slaswp_byte8" "owl_stub_425_LAPACKE_slaswp"

external lapacke_dlaswp
  : int -> int -> _ CI.fatptr -> int -> int -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_426_LAPACKE_dlaswp_byte8" "owl_stub_426_LAPACKE_dlaswp"

external lapacke_claswp
  : int -> int -> _ CI.fatptr -> int -> int -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_427_LAPACKE_claswp_byte8" "owl_stub_427_LAPACKE_claswp"

external lapacke_zlaswp
  : int -> int -> _ CI.fatptr -> int -> int -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_428_LAPACKE_zlaswp_byte8" "owl_stub_428_LAPACKE_zlaswp"

external lapacke_slatms
  : int -> int -> int -> char -> _ CI.fatptr -> char -> _ CI.fatptr -> int -> float -> float -> int -> int -> char -> _ CI.fatptr -> int -> int
  = "owl_stub_429_LAPACKE_slatms_byte15" "owl_stub_429_LAPACKE_slatms"

external lapacke_dlatms
  : int -> int -> int -> char -> _ CI.fatptr -> char -> _ CI.fatptr -> int -> float -> float -> int -> int -> char -> _ CI.fatptr -> int -> int
  = "owl_stub_430_LAPACKE_dlatms_byte15" "owl_stub_430_LAPACKE_dlatms"

external lapacke_clatms
  : int -> int -> int -> char -> _ CI.fatptr -> char -> _ CI.fatptr -> int -> float -> float -> int -> int -> char -> _ CI.fatptr -> int -> int
  = "owl_stub_431_LAPACKE_clatms_byte15" "owl_stub_431_LAPACKE_clatms"

external lapacke_zlatms
  : int -> int -> int -> char -> _ CI.fatptr -> char -> _ CI.fatptr -> int -> float -> float -> int -> int -> char -> _ CI.fatptr -> int -> int
  = "owl_stub_432_LAPACKE_zlatms_byte15" "owl_stub_432_LAPACKE_zlatms"

external lapacke_slauum
  : int -> char -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_433_LAPACKE_slauum"

external lapacke_dlauum
  : int -> char -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_434_LAPACKE_dlauum"

external lapacke_clauum
  : int -> char -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_435_LAPACKE_clauum"

external lapacke_zlauum
  : int -> char -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_436_LAPACKE_zlauum"

external lapacke_sopgtr
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_437_LAPACKE_sopgtr_byte7" "owl_stub_437_LAPACKE_sopgtr"

external lapacke_dopgtr
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_438_LAPACKE_dopgtr_byte7" "owl_stub_438_LAPACKE_dopgtr"

external lapacke_sopmtr
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_439_LAPACKE_sopmtr_byte10" "owl_stub_439_LAPACKE_sopmtr"

external lapacke_dopmtr
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_440_LAPACKE_dopmtr_byte10" "owl_stub_440_LAPACKE_dopmtr"

external lapacke_sorgbr
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_441_LAPACKE_sorgbr_byte8" "owl_stub_441_LAPACKE_sorgbr"

external lapacke_dorgbr
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_442_LAPACKE_dorgbr_byte8" "owl_stub_442_LAPACKE_dorgbr"

external lapacke_sorghr
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_443_LAPACKE_sorghr_byte7" "owl_stub_443_LAPACKE_sorghr"

external lapacke_dorghr
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_444_LAPACKE_dorghr_byte7" "owl_stub_444_LAPACKE_dorghr"

external lapacke_sorglq
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_445_LAPACKE_sorglq_byte7" "owl_stub_445_LAPACKE_sorglq"

external lapacke_dorglq
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_446_LAPACKE_dorglq_byte7" "owl_stub_446_LAPACKE_dorglq"

external lapacke_sorgql
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_447_LAPACKE_sorgql_byte7" "owl_stub_447_LAPACKE_sorgql"

external lapacke_dorgql
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_448_LAPACKE_dorgql_byte7" "owl_stub_448_LAPACKE_dorgql"

external lapacke_sorgqr
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_449_LAPACKE_sorgqr_byte7" "owl_stub_449_LAPACKE_sorgqr"

external lapacke_dorgqr
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_450_LAPACKE_dorgqr_byte7" "owl_stub_450_LAPACKE_dorgqr"

external lapacke_sorgrq
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_451_LAPACKE_sorgrq_byte7" "owl_stub_451_LAPACKE_sorgrq"

external lapacke_dorgrq
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_452_LAPACKE_dorgrq_byte7" "owl_stub_452_LAPACKE_dorgrq"

external lapacke_sorgtr
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_453_LAPACKE_sorgtr_byte6" "owl_stub_453_LAPACKE_sorgtr"

external lapacke_dorgtr
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_454_LAPACKE_dorgtr_byte6" "owl_stub_454_LAPACKE_dorgtr"

external lapacke_sormbr
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_455_LAPACKE_sormbr_byte12" "owl_stub_455_LAPACKE_sormbr"

external lapacke_dormbr
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_456_LAPACKE_dormbr_byte12" "owl_stub_456_LAPACKE_dormbr"

external lapacke_sormhr
  : int -> char -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_457_LAPACKE_sormhr_byte12" "owl_stub_457_LAPACKE_sormhr"

external lapacke_dormhr
  : int -> char -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_458_LAPACKE_dormhr_byte12" "owl_stub_458_LAPACKE_dormhr"

external lapacke_sormlq
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_459_LAPACKE_sormlq_byte11" "owl_stub_459_LAPACKE_sormlq"

external lapacke_dormlq
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_460_LAPACKE_dormlq_byte11" "owl_stub_460_LAPACKE_dormlq"

external lapacke_sormql
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_461_LAPACKE_sormql_byte11" "owl_stub_461_LAPACKE_sormql"

external lapacke_dormql
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_462_LAPACKE_dormql_byte11" "owl_stub_462_LAPACKE_dormql"

external lapacke_sormqr
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_463_LAPACKE_sormqr_byte11" "owl_stub_463_LAPACKE_sormqr"

external lapacke_dormqr
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_464_LAPACKE_dormqr_byte11" "owl_stub_464_LAPACKE_dormqr"

external lapacke_sormrq
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_465_LAPACKE_sormrq_byte11" "owl_stub_465_LAPACKE_sormrq"

external lapacke_dormrq
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_466_LAPACKE_dormrq_byte11" "owl_stub_466_LAPACKE_dormrq"

external lapacke_sormrz
  : int -> char -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_467_LAPACKE_sormrz_byte12" "owl_stub_467_LAPACKE_sormrz"

external lapacke_dormrz
  : int -> char -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_468_LAPACKE_dormrz_byte12" "owl_stub_468_LAPACKE_dormrz"

external lapacke_sormtr
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_469_LAPACKE_sormtr_byte11" "owl_stub_469_LAPACKE_sormtr"

external lapacke_dormtr
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_470_LAPACKE_dormtr_byte11" "owl_stub_470_LAPACKE_dormtr"

external lapacke_spbcon
  : int -> char -> int -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int
  = "owl_stub_471_LAPACKE_spbcon_byte8" "owl_stub_471_LAPACKE_spbcon"

external lapacke_dpbcon
  : int -> char -> int -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int
  = "owl_stub_472_LAPACKE_dpbcon_byte8" "owl_stub_472_LAPACKE_dpbcon"

external lapacke_cpbcon
  : int -> char -> int -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int
  = "owl_stub_473_LAPACKE_cpbcon_byte8" "owl_stub_473_LAPACKE_cpbcon"

external lapacke_zpbcon
  : int -> char -> int -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int
  = "owl_stub_474_LAPACKE_zpbcon_byte8" "owl_stub_474_LAPACKE_zpbcon"

external lapacke_spbequ
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_475_LAPACKE_spbequ_byte9" "owl_stub_475_LAPACKE_spbequ"

external lapacke_dpbequ
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_476_LAPACKE_dpbequ_byte9" "owl_stub_476_LAPACKE_dpbequ"

external lapacke_cpbequ
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_477_LAPACKE_cpbequ_byte9" "owl_stub_477_LAPACKE_cpbequ"

external lapacke_zpbequ
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_478_LAPACKE_zpbequ_byte9" "owl_stub_478_LAPACKE_zpbequ"

external lapacke_spbrfs
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_479_LAPACKE_spbrfs_byte15" "owl_stub_479_LAPACKE_spbrfs"

external lapacke_dpbrfs
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_480_LAPACKE_dpbrfs_byte15" "owl_stub_480_LAPACKE_dpbrfs"

external lapacke_cpbrfs
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_481_LAPACKE_cpbrfs_byte15" "owl_stub_481_LAPACKE_cpbrfs"

external lapacke_zpbrfs
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_482_LAPACKE_zpbrfs_byte15" "owl_stub_482_LAPACKE_zpbrfs"

external lapacke_spbstf
  : int -> char -> int -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_483_LAPACKE_spbstf_byte6" "owl_stub_483_LAPACKE_spbstf"

external lapacke_dpbstf
  : int -> char -> int -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_484_LAPACKE_dpbstf_byte6" "owl_stub_484_LAPACKE_dpbstf"

external lapacke_cpbstf
  : int -> char -> int -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_485_LAPACKE_cpbstf_byte6" "owl_stub_485_LAPACKE_cpbstf"

external lapacke_zpbstf
  : int -> char -> int -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_486_LAPACKE_zpbstf_byte6" "owl_stub_486_LAPACKE_zpbstf"

external lapacke_spbsv
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_487_LAPACKE_spbsv_byte9" "owl_stub_487_LAPACKE_spbsv"

external lapacke_dpbsv
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_488_LAPACKE_dpbsv_byte9" "owl_stub_488_LAPACKE_dpbsv"

external lapacke_cpbsv
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_489_LAPACKE_cpbsv_byte9" "owl_stub_489_LAPACKE_cpbsv"

external lapacke_zpbsv
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_490_LAPACKE_zpbsv_byte9" "owl_stub_490_LAPACKE_zpbsv"

external lapacke_spbsvx
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_491_LAPACKE_spbsvx_byte19" "owl_stub_491_LAPACKE_spbsvx"

external lapacke_dpbsvx
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_492_LAPACKE_dpbsvx_byte19" "owl_stub_492_LAPACKE_dpbsvx"

external lapacke_cpbsvx
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_493_LAPACKE_cpbsvx_byte19" "owl_stub_493_LAPACKE_cpbsvx"

external lapacke_zpbsvx
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_494_LAPACKE_zpbsvx_byte19" "owl_stub_494_LAPACKE_zpbsvx"

external lapacke_spbtrf
  : int -> char -> int -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_495_LAPACKE_spbtrf_byte6" "owl_stub_495_LAPACKE_spbtrf"

external lapacke_dpbtrf
  : int -> char -> int -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_496_LAPACKE_dpbtrf_byte6" "owl_stub_496_LAPACKE_dpbtrf"

external lapacke_cpbtrf
  : int -> char -> int -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_497_LAPACKE_cpbtrf_byte6" "owl_stub_497_LAPACKE_cpbtrf"

external lapacke_zpbtrf
  : int -> char -> int -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_498_LAPACKE_zpbtrf_byte6" "owl_stub_498_LAPACKE_zpbtrf"

external lapacke_spbtrs
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_499_LAPACKE_spbtrs_byte9" "owl_stub_499_LAPACKE_spbtrs"

external lapacke_dpbtrs
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_500_LAPACKE_dpbtrs_byte9" "owl_stub_500_LAPACKE_dpbtrs"

external lapacke_cpbtrs
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_501_LAPACKE_cpbtrs_byte9" "owl_stub_501_LAPACKE_cpbtrs"

external lapacke_zpbtrs
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_502_LAPACKE_zpbtrs_byte9" "owl_stub_502_LAPACKE_zpbtrs"

external lapacke_spftrf
  : int -> char -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_503_LAPACKE_spftrf"

external lapacke_dpftrf
  : int -> char -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_504_LAPACKE_dpftrf"

external lapacke_cpftrf
  : int -> char -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_505_LAPACKE_cpftrf"

external lapacke_zpftrf
  : int -> char -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_506_LAPACKE_zpftrf"

external lapacke_spftri
  : int -> char -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_507_LAPACKE_spftri"

external lapacke_dpftri
  : int -> char -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_508_LAPACKE_dpftri"

external lapacke_cpftri
  : int -> char -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_509_LAPACKE_cpftri"

external lapacke_zpftri
  : int -> char -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_510_LAPACKE_zpftri"

external lapacke_spftrs
  : int -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_511_LAPACKE_spftrs_byte8" "owl_stub_511_LAPACKE_spftrs"

external lapacke_dpftrs
  : int -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_512_LAPACKE_dpftrs_byte8" "owl_stub_512_LAPACKE_dpftrs"

external lapacke_cpftrs
  : int -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_513_LAPACKE_cpftrs_byte8" "owl_stub_513_LAPACKE_cpftrs"

external lapacke_zpftrs
  : int -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_514_LAPACKE_zpftrs_byte8" "owl_stub_514_LAPACKE_zpftrs"

external lapacke_spocon
  : int -> char -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int
  = "owl_stub_515_LAPACKE_spocon_byte7" "owl_stub_515_LAPACKE_spocon"

external lapacke_dpocon
  : int -> char -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int
  = "owl_stub_516_LAPACKE_dpocon_byte7" "owl_stub_516_LAPACKE_dpocon"

external lapacke_cpocon
  : int -> char -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int
  = "owl_stub_517_LAPACKE_cpocon_byte7" "owl_stub_517_LAPACKE_cpocon"

external lapacke_zpocon
  : int -> char -> int -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int
  = "owl_stub_518_LAPACKE_zpocon_byte7" "owl_stub_518_LAPACKE_zpocon"

external lapacke_spoequ
  : int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_519_LAPACKE_spoequ_byte7" "owl_stub_519_LAPACKE_spoequ"

external lapacke_dpoequ
  : int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_520_LAPACKE_dpoequ_byte7" "owl_stub_520_LAPACKE_dpoequ"

external lapacke_cpoequ
  : int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_521_LAPACKE_cpoequ_byte7" "owl_stub_521_LAPACKE_cpoequ"

external lapacke_zpoequ
  : int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_522_LAPACKE_zpoequ_byte7" "owl_stub_522_LAPACKE_zpoequ"

external lapacke_spoequb
  : int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_523_LAPACKE_spoequb_byte7" "owl_stub_523_LAPACKE_spoequb"

external lapacke_dpoequb
  : int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_524_LAPACKE_dpoequb_byte7" "owl_stub_524_LAPACKE_dpoequb"

external lapacke_cpoequb
  : int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_525_LAPACKE_cpoequb_byte7" "owl_stub_525_LAPACKE_cpoequb"

external lapacke_zpoequb
  : int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_526_LAPACKE_zpoequb_byte7" "owl_stub_526_LAPACKE_zpoequb"

external lapacke_sporfs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_527_LAPACKE_sporfs_byte14" "owl_stub_527_LAPACKE_sporfs"

external lapacke_dporfs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_528_LAPACKE_dporfs_byte14" "owl_stub_528_LAPACKE_dporfs"

external lapacke_cporfs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_529_LAPACKE_cporfs_byte14" "owl_stub_529_LAPACKE_cporfs"

external lapacke_zporfs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_530_LAPACKE_zporfs_byte14" "owl_stub_530_LAPACKE_zporfs"

external lapacke_sposv
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_531_LAPACKE_sposv_byte8" "owl_stub_531_LAPACKE_sposv"

external lapacke_dposv
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_532_LAPACKE_dposv_byte8" "owl_stub_532_LAPACKE_dposv"

external lapacke_cposv
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_533_LAPACKE_cposv_byte8" "owl_stub_533_LAPACKE_cposv"

external lapacke_zposv
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_534_LAPACKE_zposv_byte8" "owl_stub_534_LAPACKE_zposv"

external lapacke_dsposv
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_535_LAPACKE_dsposv_byte11" "owl_stub_535_LAPACKE_dsposv"

external lapacke_zcposv
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_536_LAPACKE_zcposv_byte11" "owl_stub_536_LAPACKE_zcposv"

external lapacke_sposvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_537_LAPACKE_sposvx_byte18" "owl_stub_537_LAPACKE_sposvx"

external lapacke_dposvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_538_LAPACKE_dposvx_byte18" "owl_stub_538_LAPACKE_dposvx"

external lapacke_cposvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_539_LAPACKE_cposvx_byte18" "owl_stub_539_LAPACKE_cposvx"

external lapacke_zposvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_540_LAPACKE_zposvx_byte18" "owl_stub_540_LAPACKE_zposvx"

external lapacke_spotrf2
  : int -> char -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_541_LAPACKE_spotrf2"

external lapacke_dpotrf2
  : int -> char -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_542_LAPACKE_dpotrf2"

external lapacke_cpotrf2
  : int -> char -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_543_LAPACKE_cpotrf2"

external lapacke_zpotrf2
  : int -> char -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_544_LAPACKE_zpotrf2"

external lapacke_spotrf
  : int -> char -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_545_LAPACKE_spotrf"

external lapacke_dpotrf
  : int -> char -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_546_LAPACKE_dpotrf"

external lapacke_cpotrf
  : int -> char -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_547_LAPACKE_cpotrf"

external lapacke_zpotrf
  : int -> char -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_548_LAPACKE_zpotrf"

external lapacke_spotri
  : int -> char -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_549_LAPACKE_spotri"

external lapacke_dpotri
  : int -> char -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_550_LAPACKE_dpotri"

external lapacke_cpotri
  : int -> char -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_551_LAPACKE_cpotri"

external lapacke_zpotri
  : int -> char -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_552_LAPACKE_zpotri"

external lapacke_spotrs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_553_LAPACKE_spotrs_byte8" "owl_stub_553_LAPACKE_spotrs"

external lapacke_dpotrs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_554_LAPACKE_dpotrs_byte8" "owl_stub_554_LAPACKE_dpotrs"

external lapacke_cpotrs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_555_LAPACKE_cpotrs_byte8" "owl_stub_555_LAPACKE_cpotrs"

external lapacke_zpotrs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_556_LAPACKE_zpotrs_byte8" "owl_stub_556_LAPACKE_zpotrs"

external lapacke_sppcon
  : int -> char -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_557_LAPACKE_sppcon_byte6" "owl_stub_557_LAPACKE_sppcon"

external lapacke_dppcon
  : int -> char -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_558_LAPACKE_dppcon_byte6" "owl_stub_558_LAPACKE_dppcon"

external lapacke_cppcon
  : int -> char -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_559_LAPACKE_cppcon_byte6" "owl_stub_559_LAPACKE_cppcon"

external lapacke_zppcon
  : int -> char -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_560_LAPACKE_zppcon_byte6" "owl_stub_560_LAPACKE_zppcon"

external lapacke_sppequ
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_561_LAPACKE_sppequ_byte7" "owl_stub_561_LAPACKE_sppequ"

external lapacke_dppequ
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_562_LAPACKE_dppequ_byte7" "owl_stub_562_LAPACKE_dppequ"

external lapacke_cppequ
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_563_LAPACKE_cppequ_byte7" "owl_stub_563_LAPACKE_cppequ"

external lapacke_zppequ
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_564_LAPACKE_zppequ_byte7" "owl_stub_564_LAPACKE_zppequ"

external lapacke_spprfs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_565_LAPACKE_spprfs_byte12" "owl_stub_565_LAPACKE_spprfs"

external lapacke_dpprfs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_566_LAPACKE_dpprfs_byte12" "owl_stub_566_LAPACKE_dpprfs"

external lapacke_cpprfs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_567_LAPACKE_cpprfs_byte12" "owl_stub_567_LAPACKE_cpprfs"

external lapacke_zpprfs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_568_LAPACKE_zpprfs_byte12" "owl_stub_568_LAPACKE_zpprfs"

external lapacke_sppsv
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_569_LAPACKE_sppsv_byte7" "owl_stub_569_LAPACKE_sppsv"

external lapacke_dppsv
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_570_LAPACKE_dppsv_byte7" "owl_stub_570_LAPACKE_dppsv"

external lapacke_cppsv
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_571_LAPACKE_cppsv_byte7" "owl_stub_571_LAPACKE_cppsv"

external lapacke_zppsv
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_572_LAPACKE_zppsv_byte7" "owl_stub_572_LAPACKE_zppsv"

external lapacke_sppsvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_573_LAPACKE_sppsvx_byte16" "owl_stub_573_LAPACKE_sppsvx"

external lapacke_dppsvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_574_LAPACKE_dppsvx_byte16" "owl_stub_574_LAPACKE_dppsvx"

external lapacke_cppsvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_575_LAPACKE_cppsvx_byte16" "owl_stub_575_LAPACKE_cppsvx"

external lapacke_zppsvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_576_LAPACKE_zppsvx_byte16" "owl_stub_576_LAPACKE_zppsvx"

external lapacke_spptrf
  : int -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_577_LAPACKE_spptrf"

external lapacke_dpptrf
  : int -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_578_LAPACKE_dpptrf"

external lapacke_cpptrf
  : int -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_579_LAPACKE_cpptrf"

external lapacke_zpptrf
  : int -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_580_LAPACKE_zpptrf"

external lapacke_spptri
  : int -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_581_LAPACKE_spptri"

external lapacke_dpptri
  : int -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_582_LAPACKE_dpptri"

external lapacke_cpptri
  : int -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_583_LAPACKE_cpptri"

external lapacke_zpptri
  : int -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_584_LAPACKE_zpptri"

external lapacke_spptrs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_585_LAPACKE_spptrs_byte7" "owl_stub_585_LAPACKE_spptrs"

external lapacke_dpptrs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_586_LAPACKE_dpptrs_byte7" "owl_stub_586_LAPACKE_dpptrs"

external lapacke_cpptrs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_587_LAPACKE_cpptrs_byte7" "owl_stub_587_LAPACKE_cpptrs"

external lapacke_zpptrs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_588_LAPACKE_zpptrs_byte7" "owl_stub_588_LAPACKE_zpptrs"

external lapacke_spstrf
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> int
  = "owl_stub_589_LAPACKE_spstrf_byte8" "owl_stub_589_LAPACKE_spstrf"

external lapacke_dpstrf
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> int
  = "owl_stub_590_LAPACKE_dpstrf_byte8" "owl_stub_590_LAPACKE_dpstrf"

external lapacke_cpstrf
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> int
  = "owl_stub_591_LAPACKE_cpstrf_byte8" "owl_stub_591_LAPACKE_cpstrf"

external lapacke_zpstrf
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> int
  = "owl_stub_592_LAPACKE_zpstrf_byte8" "owl_stub_592_LAPACKE_zpstrf"

external lapacke_sptcon
  : int -> _ CI.fatptr -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_593_LAPACKE_sptcon"

external lapacke_dptcon
  : int -> _ CI.fatptr -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_594_LAPACKE_dptcon"

external lapacke_cptcon
  : int -> _ CI.fatptr -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_595_LAPACKE_cptcon"

external lapacke_zptcon
  : int -> _ CI.fatptr -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_596_LAPACKE_zptcon"

external lapacke_spteqr
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_597_LAPACKE_spteqr_byte7" "owl_stub_597_LAPACKE_spteqr"

external lapacke_dpteqr
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_598_LAPACKE_dpteqr_byte7" "owl_stub_598_LAPACKE_dpteqr"

external lapacke_cpteqr
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_599_LAPACKE_cpteqr_byte7" "owl_stub_599_LAPACKE_cpteqr"

external lapacke_zpteqr
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_600_LAPACKE_zpteqr_byte7" "owl_stub_600_LAPACKE_zpteqr"

external lapacke_sptrfs
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_601_LAPACKE_sptrfs_byte13" "owl_stub_601_LAPACKE_sptrfs"

external lapacke_dptrfs
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_602_LAPACKE_dptrfs_byte13" "owl_stub_602_LAPACKE_dptrfs"

external lapacke_cptrfs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_603_LAPACKE_cptrfs_byte14" "owl_stub_603_LAPACKE_cptrfs"

external lapacke_zptrfs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_604_LAPACKE_zptrfs_byte14" "owl_stub_604_LAPACKE_zptrfs"

external lapacke_sptsv
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_605_LAPACKE_sptsv_byte7" "owl_stub_605_LAPACKE_sptsv"

external lapacke_dptsv
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_606_LAPACKE_dptsv_byte7" "owl_stub_606_LAPACKE_dptsv"

external lapacke_cptsv
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_607_LAPACKE_cptsv_byte7" "owl_stub_607_LAPACKE_cptsv"

external lapacke_zptsv
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_608_LAPACKE_zptsv_byte7" "owl_stub_608_LAPACKE_zptsv"

external lapacke_sptsvx
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_609_LAPACKE_sptsvx_byte15" "owl_stub_609_LAPACKE_sptsvx"

external lapacke_dptsvx
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_610_LAPACKE_dptsvx_byte15" "owl_stub_610_LAPACKE_dptsvx"

external lapacke_cptsvx
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_611_LAPACKE_cptsvx_byte15" "owl_stub_611_LAPACKE_cptsvx"

external lapacke_zptsvx
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_612_LAPACKE_zptsvx_byte15" "owl_stub_612_LAPACKE_zptsvx"

external lapacke_spttrf
  : int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_613_LAPACKE_spttrf"

external lapacke_dpttrf
  : int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_614_LAPACKE_dpttrf"

external lapacke_cpttrf
  : int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_615_LAPACKE_cpttrf"

external lapacke_zpttrf
  : int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_616_LAPACKE_zpttrf"

external lapacke_spttrs
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_617_LAPACKE_spttrs_byte7" "owl_stub_617_LAPACKE_spttrs"

external lapacke_dpttrs
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_618_LAPACKE_dpttrs_byte7" "owl_stub_618_LAPACKE_dpttrs"

external lapacke_cpttrs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_619_LAPACKE_cpttrs_byte8" "owl_stub_619_LAPACKE_cpttrs"

external lapacke_zpttrs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_620_LAPACKE_zpttrs_byte8" "owl_stub_620_LAPACKE_zpttrs"

external lapacke_ssbev
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_621_LAPACKE_ssbev_byte10" "owl_stub_621_LAPACKE_ssbev"

external lapacke_dsbev
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_622_LAPACKE_dsbev_byte10" "owl_stub_622_LAPACKE_dsbev"

external lapacke_ssbevd
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_623_LAPACKE_ssbevd_byte10" "owl_stub_623_LAPACKE_ssbevd"

external lapacke_dsbevd
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_624_LAPACKE_dsbevd_byte10" "owl_stub_624_LAPACKE_dsbevd"

external lapacke_ssbevx
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_625_LAPACKE_ssbevx_byte20" "owl_stub_625_LAPACKE_ssbevx"

external lapacke_dsbevx
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_626_LAPACKE_dsbevx_byte20" "owl_stub_626_LAPACKE_dsbevx"

external lapacke_ssbgst
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_627_LAPACKE_ssbgst_byte12" "owl_stub_627_LAPACKE_ssbgst"

external lapacke_dsbgst
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_628_LAPACKE_dsbgst_byte12" "owl_stub_628_LAPACKE_dsbgst"

external lapacke_ssbgv
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_629_LAPACKE_ssbgv_byte13" "owl_stub_629_LAPACKE_ssbgv"

external lapacke_dsbgv
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_630_LAPACKE_dsbgv_byte13" "owl_stub_630_LAPACKE_dsbgv"

external lapacke_ssbgvd
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_631_LAPACKE_ssbgvd_byte13" "owl_stub_631_LAPACKE_ssbgvd"

external lapacke_dsbgvd
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_632_LAPACKE_dsbgvd_byte13" "owl_stub_632_LAPACKE_dsbgvd"

external lapacke_ssbgvx
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_633_LAPACKE_ssbgvx_byte23" "owl_stub_633_LAPACKE_ssbgvx"

external lapacke_dsbgvx
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_634_LAPACKE_dsbgvx_byte23" "owl_stub_634_LAPACKE_dsbgvx"

external lapacke_ssbtrd
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_635_LAPACKE_ssbtrd_byte11" "owl_stub_635_LAPACKE_ssbtrd"

external lapacke_dsbtrd
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_636_LAPACKE_dsbtrd_byte11" "owl_stub_636_LAPACKE_dsbtrd"

external lapacke_ssfrk
  : int -> char -> char -> char -> int -> int -> float -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int
  = "owl_stub_637_LAPACKE_ssfrk_byte11" "owl_stub_637_LAPACKE_ssfrk"

external lapacke_dsfrk
  : int -> char -> char -> char -> int -> int -> float -> _ CI.fatptr -> int -> float -> _ CI.fatptr -> int
  = "owl_stub_638_LAPACKE_dsfrk_byte11" "owl_stub_638_LAPACKE_dsfrk"

external lapacke_sspcon
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_639_LAPACKE_sspcon_byte7" "owl_stub_639_LAPACKE_sspcon"

external lapacke_dspcon
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_640_LAPACKE_dspcon_byte7" "owl_stub_640_LAPACKE_dspcon"

external lapacke_cspcon
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_641_LAPACKE_cspcon_byte7" "owl_stub_641_LAPACKE_cspcon"

external lapacke_zspcon
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_642_LAPACKE_zspcon_byte7" "owl_stub_642_LAPACKE_zspcon"

external lapacke_sspev
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_643_LAPACKE_sspev_byte8" "owl_stub_643_LAPACKE_sspev"

external lapacke_dspev
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_644_LAPACKE_dspev_byte8" "owl_stub_644_LAPACKE_dspev"

external lapacke_sspevd
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_645_LAPACKE_sspevd_byte8" "owl_stub_645_LAPACKE_sspevd"

external lapacke_dspevd
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_646_LAPACKE_dspevd_byte8" "owl_stub_646_LAPACKE_dspevd"

external lapacke_sspevx
  : int -> char -> char -> char -> int -> _ CI.fatptr -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_647_LAPACKE_sspevx_byte16" "owl_stub_647_LAPACKE_sspevx"

external lapacke_dspevx
  : int -> char -> char -> char -> int -> _ CI.fatptr -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_648_LAPACKE_dspevx_byte16" "owl_stub_648_LAPACKE_dspevx"

external lapacke_sspgst
  : int -> int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_649_LAPACKE_sspgst_byte6" "owl_stub_649_LAPACKE_sspgst"

external lapacke_dspgst
  : int -> int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_650_LAPACKE_dspgst_byte6" "owl_stub_650_LAPACKE_dspgst"

external lapacke_sspgv
  : int -> int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_651_LAPACKE_sspgv_byte10" "owl_stub_651_LAPACKE_sspgv"

external lapacke_dspgv
  : int -> int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_652_LAPACKE_dspgv_byte10" "owl_stub_652_LAPACKE_dspgv"

external lapacke_sspgvd
  : int -> int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_653_LAPACKE_sspgvd_byte10" "owl_stub_653_LAPACKE_sspgvd"

external lapacke_dspgvd
  : int -> int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_654_LAPACKE_dspgvd_byte10" "owl_stub_654_LAPACKE_dspgvd"

external lapacke_sspgvx
  : int -> int -> char -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_655_LAPACKE_sspgvx_byte18" "owl_stub_655_LAPACKE_sspgvx"

external lapacke_dspgvx
  : int -> int -> char -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_656_LAPACKE_dspgvx_byte18" "owl_stub_656_LAPACKE_dspgvx"

external lapacke_ssprfs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_657_LAPACKE_ssprfs_byte13" "owl_stub_657_LAPACKE_ssprfs"

external lapacke_dsprfs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_658_LAPACKE_dsprfs_byte13" "owl_stub_658_LAPACKE_dsprfs"

external lapacke_csprfs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_659_LAPACKE_csprfs_byte13" "owl_stub_659_LAPACKE_csprfs"

external lapacke_zsprfs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_660_LAPACKE_zsprfs_byte13" "owl_stub_660_LAPACKE_zsprfs"

external lapacke_sspsv
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_661_LAPACKE_sspsv_byte8" "owl_stub_661_LAPACKE_sspsv"

external lapacke_dspsv
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_662_LAPACKE_dspsv_byte8" "owl_stub_662_LAPACKE_dspsv"

external lapacke_cspsv
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_663_LAPACKE_cspsv_byte8" "owl_stub_663_LAPACKE_cspsv"

external lapacke_zspsv
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_664_LAPACKE_zspsv_byte8" "owl_stub_664_LAPACKE_zspsv"

external lapacke_sspsvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_665_LAPACKE_sspsvx_byte15" "owl_stub_665_LAPACKE_sspsvx"

external lapacke_dspsvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_666_LAPACKE_dspsvx_byte15" "owl_stub_666_LAPACKE_dspsvx"

external lapacke_cspsvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_667_LAPACKE_cspsvx_byte15" "owl_stub_667_LAPACKE_cspsvx"

external lapacke_zspsvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_668_LAPACKE_zspsvx_byte15" "owl_stub_668_LAPACKE_zspsvx"

external lapacke_ssptrd
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_669_LAPACKE_ssptrd_byte7" "owl_stub_669_LAPACKE_ssptrd"

external lapacke_dsptrd
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_670_LAPACKE_dsptrd_byte7" "owl_stub_670_LAPACKE_dsptrd"

external lapacke_ssptrf
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_671_LAPACKE_ssptrf"

external lapacke_dsptrf
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_672_LAPACKE_dsptrf"

external lapacke_csptrf
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_673_LAPACKE_csptrf"

external lapacke_zsptrf
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_674_LAPACKE_zsptrf"

external lapacke_ssptri
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_675_LAPACKE_ssptri"

external lapacke_dsptri
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_676_LAPACKE_dsptri"

external lapacke_csptri
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_677_LAPACKE_csptri"

external lapacke_zsptri
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_678_LAPACKE_zsptri"

external lapacke_ssptrs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_679_LAPACKE_ssptrs_byte8" "owl_stub_679_LAPACKE_ssptrs"

external lapacke_dsptrs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_680_LAPACKE_dsptrs_byte8" "owl_stub_680_LAPACKE_dsptrs"

external lapacke_csptrs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_681_LAPACKE_csptrs_byte8" "owl_stub_681_LAPACKE_csptrs"

external lapacke_zsptrs
  : int -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_682_LAPACKE_zsptrs_byte8" "owl_stub_682_LAPACKE_zsptrs"

external lapacke_sstebz
  : char -> char -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_683_LAPACKE_sstebz_byte15" "owl_stub_683_LAPACKE_sstebz"

external lapacke_dstebz
  : char -> char -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_684_LAPACKE_dstebz_byte15" "owl_stub_684_LAPACKE_dstebz"

external lapacke_sstedc
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_685_LAPACKE_sstedc_byte7" "owl_stub_685_LAPACKE_sstedc"

external lapacke_dstedc
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_686_LAPACKE_dstedc_byte7" "owl_stub_686_LAPACKE_dstedc"

external lapacke_cstedc
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_687_LAPACKE_cstedc_byte7" "owl_stub_687_LAPACKE_cstedc"

external lapacke_zstedc
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_688_LAPACKE_zstedc_byte7" "owl_stub_688_LAPACKE_zstedc"

external lapacke_sstegr
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_689_LAPACKE_sstegr_byte16" "owl_stub_689_LAPACKE_sstegr"

external lapacke_dstegr
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_690_LAPACKE_dstegr_byte16" "owl_stub_690_LAPACKE_dstegr"

external lapacke_cstegr
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_691_LAPACKE_cstegr_byte16" "owl_stub_691_LAPACKE_cstegr"

external lapacke_zstegr
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_692_LAPACKE_zstegr_byte16" "owl_stub_692_LAPACKE_zstegr"

external lapacke_sstein
  : int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_693_LAPACKE_sstein_byte11" "owl_stub_693_LAPACKE_sstein"

external lapacke_dstein
  : int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_694_LAPACKE_dstein_byte11" "owl_stub_694_LAPACKE_dstein"

external lapacke_cstein
  : int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_695_LAPACKE_cstein_byte11" "owl_stub_695_LAPACKE_cstein"

external lapacke_zstein
  : int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_696_LAPACKE_zstein_byte11" "owl_stub_696_LAPACKE_zstein"

external lapacke_sstemr
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> float -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_697_LAPACKE_sstemr_byte17" "owl_stub_697_LAPACKE_sstemr"

external lapacke_dstemr
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> float -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_698_LAPACKE_dstemr_byte17" "owl_stub_698_LAPACKE_dstemr"

external lapacke_cstemr
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> float -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_699_LAPACKE_cstemr_byte17" "owl_stub_699_LAPACKE_cstemr"

external lapacke_zstemr
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> float -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_700_LAPACKE_zstemr_byte17" "owl_stub_700_LAPACKE_zstemr"

external lapacke_ssteqr
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_701_LAPACKE_ssteqr_byte7" "owl_stub_701_LAPACKE_ssteqr"

external lapacke_dsteqr
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_702_LAPACKE_dsteqr_byte7" "owl_stub_702_LAPACKE_dsteqr"

external lapacke_csteqr
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_703_LAPACKE_csteqr_byte7" "owl_stub_703_LAPACKE_csteqr"

external lapacke_zsteqr
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_704_LAPACKE_zsteqr_byte7" "owl_stub_704_LAPACKE_zsteqr"

external lapacke_ssterf
  : int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_705_LAPACKE_ssterf"

external lapacke_dsterf
  : int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_706_LAPACKE_dsterf"

external lapacke_sstev
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_707_LAPACKE_sstev_byte7" "owl_stub_707_LAPACKE_sstev"

external lapacke_dstev
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_708_LAPACKE_dstev_byte7" "owl_stub_708_LAPACKE_dstev"

external lapacke_sstevd
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_709_LAPACKE_sstevd_byte7" "owl_stub_709_LAPACKE_sstevd"

external lapacke_dstevd
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_710_LAPACKE_dstevd_byte7" "owl_stub_710_LAPACKE_dstevd"

external lapacke_sstevr
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_711_LAPACKE_sstevr_byte16" "owl_stub_711_LAPACKE_sstevr"

external lapacke_dstevr
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_712_LAPACKE_dstevr_byte16" "owl_stub_712_LAPACKE_dstevr"

external lapacke_sstevx
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_713_LAPACKE_sstevx_byte16" "owl_stub_713_LAPACKE_sstevx"

external lapacke_dstevx
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_714_LAPACKE_dstevx_byte16" "owl_stub_714_LAPACKE_dstevx"

external lapacke_ssycon
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_715_LAPACKE_ssycon_byte8" "owl_stub_715_LAPACKE_ssycon"

external lapacke_dsycon
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_716_LAPACKE_dsycon_byte8" "owl_stub_716_LAPACKE_dsycon"

external lapacke_csycon
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_717_LAPACKE_csycon_byte8" "owl_stub_717_LAPACKE_csycon"

external lapacke_zsycon
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> float -> _ CI.fatptr -> int
  = "owl_stub_718_LAPACKE_zsycon_byte8" "owl_stub_718_LAPACKE_zsycon"

external lapacke_ssyequb
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_719_LAPACKE_ssyequb_byte8" "owl_stub_719_LAPACKE_ssyequb"

external lapacke_dsyequb
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_720_LAPACKE_dsyequb_byte8" "owl_stub_720_LAPACKE_dsyequb"

external lapacke_csyequb
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_721_LAPACKE_csyequb_byte8" "owl_stub_721_LAPACKE_csyequb"

external lapacke_zsyequb
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_722_LAPACKE_zsyequb_byte8" "owl_stub_722_LAPACKE_zsyequb"

external lapacke_ssyev
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_723_LAPACKE_ssyev_byte7" "owl_stub_723_LAPACKE_ssyev"

external lapacke_dsyev
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_724_LAPACKE_dsyev_byte7" "owl_stub_724_LAPACKE_dsyev"

external lapacke_ssyevd
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_725_LAPACKE_ssyevd_byte7" "owl_stub_725_LAPACKE_ssyevd"

external lapacke_dsyevd
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_726_LAPACKE_dsyevd_byte7" "owl_stub_726_LAPACKE_dsyevd"

external lapacke_ssyevr
  : int -> char -> char -> char -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_727_LAPACKE_ssyevr_byte17" "owl_stub_727_LAPACKE_ssyevr"

external lapacke_dsyevr
  : int -> char -> char -> char -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_728_LAPACKE_dsyevr_byte17" "owl_stub_728_LAPACKE_dsyevr"

external lapacke_ssyevx
  : int -> char -> char -> char -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_729_LAPACKE_ssyevx_byte17" "owl_stub_729_LAPACKE_ssyevx"

external lapacke_dsyevx
  : int -> char -> char -> char -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_730_LAPACKE_dsyevx_byte17" "owl_stub_730_LAPACKE_dsyevx"

external lapacke_ssygst
  : int -> int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_731_LAPACKE_ssygst_byte8" "owl_stub_731_LAPACKE_ssygst"

external lapacke_dsygst
  : int -> int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_732_LAPACKE_dsygst_byte8" "owl_stub_732_LAPACKE_dsygst"

external lapacke_ssygv
  : int -> int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_733_LAPACKE_ssygv_byte10" "owl_stub_733_LAPACKE_ssygv"

external lapacke_dsygv
  : int -> int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_734_LAPACKE_dsygv_byte10" "owl_stub_734_LAPACKE_dsygv"

external lapacke_ssygvd
  : int -> int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_735_LAPACKE_ssygvd_byte10" "owl_stub_735_LAPACKE_ssygvd"

external lapacke_dsygvd
  : int -> int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_736_LAPACKE_dsygvd_byte10" "owl_stub_736_LAPACKE_dsygvd"

external lapacke_ssygvx
  : int -> int -> char -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_737_LAPACKE_ssygvx_byte20" "owl_stub_737_LAPACKE_ssygvx"

external lapacke_dsygvx
  : int -> int -> char -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_738_LAPACKE_dsygvx_byte20" "owl_stub_738_LAPACKE_dsygvx"

external lapacke_ssyrfs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_739_LAPACKE_ssyrfs_byte15" "owl_stub_739_LAPACKE_ssyrfs"

external lapacke_dsyrfs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_740_LAPACKE_dsyrfs_byte15" "owl_stub_740_LAPACKE_dsyrfs"

external lapacke_csyrfs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_741_LAPACKE_csyrfs_byte15" "owl_stub_741_LAPACKE_csyrfs"

external lapacke_zsyrfs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_742_LAPACKE_zsyrfs_byte15" "owl_stub_742_LAPACKE_zsyrfs"

external lapacke_ssysv
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_743_LAPACKE_ssysv_byte9" "owl_stub_743_LAPACKE_ssysv"

external lapacke_dsysv
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_744_LAPACKE_dsysv_byte9" "owl_stub_744_LAPACKE_dsysv"

external lapacke_csysv
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_745_LAPACKE_csysv_byte9" "owl_stub_745_LAPACKE_csysv"

external lapacke_zsysv
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_746_LAPACKE_zsysv_byte9" "owl_stub_746_LAPACKE_zsysv"

external lapacke_ssysvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_747_LAPACKE_ssysvx_byte17" "owl_stub_747_LAPACKE_ssysvx"

external lapacke_dsysvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_748_LAPACKE_dsysvx_byte17" "owl_stub_748_LAPACKE_dsysvx"

external lapacke_csysvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_749_LAPACKE_csysvx_byte17" "owl_stub_749_LAPACKE_csysvx"

external lapacke_zsysvx
  : int -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_750_LAPACKE_zsysvx_byte17" "owl_stub_750_LAPACKE_zsysvx"

external lapacke_ssytrd
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_751_LAPACKE_ssytrd_byte8" "owl_stub_751_LAPACKE_ssytrd"

external lapacke_dsytrd
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_752_LAPACKE_dsytrd_byte8" "owl_stub_752_LAPACKE_dsytrd"

external lapacke_ssytrf
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_753_LAPACKE_ssytrf_byte6" "owl_stub_753_LAPACKE_ssytrf"

external lapacke_dsytrf
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_754_LAPACKE_dsytrf_byte6" "owl_stub_754_LAPACKE_dsytrf"

external lapacke_csytrf
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_755_LAPACKE_csytrf_byte6" "owl_stub_755_LAPACKE_csytrf"

external lapacke_zsytrf
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_756_LAPACKE_zsytrf_byte6" "owl_stub_756_LAPACKE_zsytrf"

external lapacke_ssytri
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_757_LAPACKE_ssytri_byte6" "owl_stub_757_LAPACKE_ssytri"

external lapacke_dsytri
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_758_LAPACKE_dsytri_byte6" "owl_stub_758_LAPACKE_dsytri"

external lapacke_csytri
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_759_LAPACKE_csytri_byte6" "owl_stub_759_LAPACKE_csytri"

external lapacke_zsytri
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_760_LAPACKE_zsytri_byte6" "owl_stub_760_LAPACKE_zsytri"

external lapacke_ssytrs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_761_LAPACKE_ssytrs_byte9" "owl_stub_761_LAPACKE_ssytrs"

external lapacke_dsytrs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_762_LAPACKE_dsytrs_byte9" "owl_stub_762_LAPACKE_dsytrs"

external lapacke_csytrs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_763_LAPACKE_csytrs_byte9" "owl_stub_763_LAPACKE_csytrs"

external lapacke_zsytrs
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_764_LAPACKE_zsytrs_byte9" "owl_stub_764_LAPACKE_zsytrs"

external lapacke_stbcon
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_765_LAPACKE_stbcon_byte9" "owl_stub_765_LAPACKE_stbcon"

external lapacke_dtbcon
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_766_LAPACKE_dtbcon_byte9" "owl_stub_766_LAPACKE_dtbcon"

external lapacke_ctbcon
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_767_LAPACKE_ctbcon_byte9" "owl_stub_767_LAPACKE_ctbcon"

external lapacke_ztbcon
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_768_LAPACKE_ztbcon_byte9" "owl_stub_768_LAPACKE_ztbcon"

external lapacke_stbrfs
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_769_LAPACKE_stbrfs_byte15" "owl_stub_769_LAPACKE_stbrfs"

external lapacke_dtbrfs
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_770_LAPACKE_dtbrfs_byte15" "owl_stub_770_LAPACKE_dtbrfs"

external lapacke_ctbrfs
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_771_LAPACKE_ctbrfs_byte15" "owl_stub_771_LAPACKE_ctbrfs"

external lapacke_ztbrfs
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_772_LAPACKE_ztbrfs_byte15" "owl_stub_772_LAPACKE_ztbrfs"

external lapacke_stbtrs
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_773_LAPACKE_stbtrs_byte11" "owl_stub_773_LAPACKE_stbtrs"

external lapacke_dtbtrs
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_774_LAPACKE_dtbtrs_byte11" "owl_stub_774_LAPACKE_dtbtrs"

external lapacke_ctbtrs
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_775_LAPACKE_ctbtrs_byte11" "owl_stub_775_LAPACKE_ctbtrs"

external lapacke_ztbtrs
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_776_LAPACKE_ztbtrs_byte11" "owl_stub_776_LAPACKE_ztbtrs"

external lapacke_stfsm
  : int -> char -> char -> char -> char -> char -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_777_LAPACKE_stfsm_byte12" "owl_stub_777_LAPACKE_stfsm"

external lapacke_dtfsm
  : int -> char -> char -> char -> char -> char -> int -> int -> float -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_778_LAPACKE_dtfsm_byte12" "owl_stub_778_LAPACKE_dtfsm"

external lapacke_ctfsm
  : int -> char -> char -> char -> char -> char -> int -> int -> Complex.t -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_779_LAPACKE_ctfsm_byte12" "owl_stub_779_LAPACKE_ctfsm"

external lapacke_ztfsm
  : int -> char -> char -> char -> char -> char -> int -> int -> Complex.t -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_780_LAPACKE_ztfsm_byte12" "owl_stub_780_LAPACKE_ztfsm"

external lapacke_stftri
  : int -> char -> char -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_781_LAPACKE_stftri_byte6" "owl_stub_781_LAPACKE_stftri"

external lapacke_dtftri
  : int -> char -> char -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_782_LAPACKE_dtftri_byte6" "owl_stub_782_LAPACKE_dtftri"

external lapacke_ctftri
  : int -> char -> char -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_783_LAPACKE_ctftri_byte6" "owl_stub_783_LAPACKE_ctftri"

external lapacke_ztftri
  : int -> char -> char -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_784_LAPACKE_ztftri_byte6" "owl_stub_784_LAPACKE_ztftri"

external lapacke_stfttp
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_785_LAPACKE_stfttp_byte6" "owl_stub_785_LAPACKE_stfttp"

external lapacke_dtfttp
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_786_LAPACKE_dtfttp_byte6" "owl_stub_786_LAPACKE_dtfttp"

external lapacke_ctfttp
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_787_LAPACKE_ctfttp_byte6" "owl_stub_787_LAPACKE_ctfttp"

external lapacke_ztfttp
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_788_LAPACKE_ztfttp_byte6" "owl_stub_788_LAPACKE_ztfttp"

external lapacke_stfttr
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_789_LAPACKE_stfttr_byte7" "owl_stub_789_LAPACKE_stfttr"

external lapacke_dtfttr
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_790_LAPACKE_dtfttr_byte7" "owl_stub_790_LAPACKE_dtfttr"

external lapacke_ctfttr
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_791_LAPACKE_ctfttr_byte7" "owl_stub_791_LAPACKE_ctfttr"

external lapacke_ztfttr
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_792_LAPACKE_ztfttr_byte7" "owl_stub_792_LAPACKE_ztfttr"

external lapacke_stgevc
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int -> _ CI.fatptr -> int
  = "owl_stub_793_LAPACKE_stgevc_byte15" "owl_stub_793_LAPACKE_stgevc"

external lapacke_dtgevc
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int -> _ CI.fatptr -> int
  = "owl_stub_794_LAPACKE_dtgevc_byte15" "owl_stub_794_LAPACKE_dtgevc"

external lapacke_ctgevc
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int -> _ CI.fatptr -> int
  = "owl_stub_795_LAPACKE_ctgevc_byte15" "owl_stub_795_LAPACKE_ctgevc"

external lapacke_ztgevc
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int -> _ CI.fatptr -> int
  = "owl_stub_796_LAPACKE_ztgevc_byte15" "owl_stub_796_LAPACKE_ztgevc"

external lapacke_stgexc
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_797_LAPACKE_stgexc_byte14" "owl_stub_797_LAPACKE_stgexc"

external lapacke_dtgexc
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_798_LAPACKE_dtgexc_byte14" "owl_stub_798_LAPACKE_dtgexc"

external lapacke_ctgexc
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int -> int -> int
  = "owl_stub_799_LAPACKE_ctgexc_byte14" "owl_stub_799_LAPACKE_ctgexc"

external lapacke_ztgexc
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int -> int -> int
  = "owl_stub_800_LAPACKE_ztgexc_byte14" "owl_stub_800_LAPACKE_ztgexc"

external lapacke_stgsen
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_801_LAPACKE_stgsen_byte21" "owl_stub_801_LAPACKE_stgsen"

external lapacke_dtgsen
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_802_LAPACKE_dtgsen_byte21" "owl_stub_802_LAPACKE_dtgsen"

external lapacke_ctgsen
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_803_LAPACKE_ctgsen_byte20" "owl_stub_803_LAPACKE_ctgsen"

external lapacke_ztgsen
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_804_LAPACKE_ztgsen_byte20" "owl_stub_804_LAPACKE_ztgsen"

external lapacke_stgsja
  : int -> char -> char -> char -> int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_805_LAPACKE_stgsja_byte24" "owl_stub_805_LAPACKE_stgsja"

external lapacke_dtgsja
  : int -> char -> char -> char -> int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_806_LAPACKE_dtgsja_byte24" "owl_stub_806_LAPACKE_dtgsja"

external lapacke_ctgsja
  : int -> char -> char -> char -> int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_807_LAPACKE_ctgsja_byte24" "owl_stub_807_LAPACKE_ctgsja"

external lapacke_ztgsja
  : int -> char -> char -> char -> int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> float -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_808_LAPACKE_ztgsja_byte24" "owl_stub_808_LAPACKE_ztgsja"

external lapacke_stgsna
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_809_LAPACKE_stgsna_byte17" "owl_stub_809_LAPACKE_stgsna"

external lapacke_dtgsna
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_810_LAPACKE_dtgsna_byte17" "owl_stub_810_LAPACKE_dtgsna"

external lapacke_ctgsna
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_811_LAPACKE_ctgsna_byte17" "owl_stub_811_LAPACKE_ctgsna"

external lapacke_ztgsna
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_812_LAPACKE_ztgsna_byte17" "owl_stub_812_LAPACKE_ztgsna"

external lapacke_stgsyl
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_813_LAPACKE_stgsyl_byte19" "owl_stub_813_LAPACKE_stgsyl"

external lapacke_dtgsyl
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_814_LAPACKE_dtgsyl_byte19" "owl_stub_814_LAPACKE_dtgsyl"

external lapacke_ctgsyl
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_815_LAPACKE_ctgsyl_byte19" "owl_stub_815_LAPACKE_ctgsyl"

external lapacke_ztgsyl
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_816_LAPACKE_ztgsyl_byte19" "owl_stub_816_LAPACKE_ztgsyl"

external lapacke_stpcon
  : int -> char -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_817_LAPACKE_stpcon_byte7" "owl_stub_817_LAPACKE_stpcon"

external lapacke_dtpcon
  : int -> char -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_818_LAPACKE_dtpcon_byte7" "owl_stub_818_LAPACKE_dtpcon"

external lapacke_ctpcon
  : int -> char -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_819_LAPACKE_ctpcon_byte7" "owl_stub_819_LAPACKE_ctpcon"

external lapacke_ztpcon
  : int -> char -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_820_LAPACKE_ztpcon_byte7" "owl_stub_820_LAPACKE_ztpcon"

external lapacke_stprfs
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_821_LAPACKE_stprfs_byte13" "owl_stub_821_LAPACKE_stprfs"

external lapacke_dtprfs
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_822_LAPACKE_dtprfs_byte13" "owl_stub_822_LAPACKE_dtprfs"

external lapacke_ctprfs
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_823_LAPACKE_ctprfs_byte13" "owl_stub_823_LAPACKE_ctprfs"

external lapacke_ztprfs
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_824_LAPACKE_ztprfs_byte13" "owl_stub_824_LAPACKE_ztprfs"

external lapacke_stptri
  : int -> char -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_825_LAPACKE_stptri"

external lapacke_dtptri
  : int -> char -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_826_LAPACKE_dtptri"

external lapacke_ctptri
  : int -> char -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_827_LAPACKE_ctptri"

external lapacke_ztptri
  : int -> char -> char -> int -> _ CI.fatptr -> int
  = "owl_stub_828_LAPACKE_ztptri"

external lapacke_stptrs
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_829_LAPACKE_stptrs_byte9" "owl_stub_829_LAPACKE_stptrs"

external lapacke_dtptrs
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_830_LAPACKE_dtptrs_byte9" "owl_stub_830_LAPACKE_dtptrs"

external lapacke_ctptrs
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_831_LAPACKE_ctptrs_byte9" "owl_stub_831_LAPACKE_ctptrs"

external lapacke_ztptrs
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_832_LAPACKE_ztptrs_byte9" "owl_stub_832_LAPACKE_ztptrs"

external lapacke_stpttf
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_833_LAPACKE_stpttf_byte6" "owl_stub_833_LAPACKE_stpttf"

external lapacke_dtpttf
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_834_LAPACKE_dtpttf_byte6" "owl_stub_834_LAPACKE_dtpttf"

external lapacke_ctpttf
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_835_LAPACKE_ctpttf_byte6" "owl_stub_835_LAPACKE_ctpttf"

external lapacke_ztpttf
  : int -> char -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_836_LAPACKE_ztpttf_byte6" "owl_stub_836_LAPACKE_ztpttf"

external lapacke_stpttr
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_837_LAPACKE_stpttr_byte6" "owl_stub_837_LAPACKE_stpttr"

external lapacke_dtpttr
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_838_LAPACKE_dtpttr_byte6" "owl_stub_838_LAPACKE_dtpttr"

external lapacke_ctpttr
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_839_LAPACKE_ctpttr_byte6" "owl_stub_839_LAPACKE_ctpttr"

external lapacke_ztpttr
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_840_LAPACKE_ztpttr_byte6" "owl_stub_840_LAPACKE_ztpttr"

external lapacke_strcon
  : int -> char -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_841_LAPACKE_strcon_byte8" "owl_stub_841_LAPACKE_strcon"

external lapacke_dtrcon
  : int -> char -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_842_LAPACKE_dtrcon_byte8" "owl_stub_842_LAPACKE_dtrcon"

external lapacke_ctrcon
  : int -> char -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_843_LAPACKE_ctrcon_byte8" "owl_stub_843_LAPACKE_ctrcon"

external lapacke_ztrcon
  : int -> char -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_844_LAPACKE_ztrcon_byte8" "owl_stub_844_LAPACKE_ztrcon"

external lapacke_strevc
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int -> _ CI.fatptr -> int
  = "owl_stub_845_LAPACKE_strevc_byte13" "owl_stub_845_LAPACKE_strevc"

external lapacke_dtrevc
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int -> _ CI.fatptr -> int
  = "owl_stub_846_LAPACKE_dtrevc_byte13" "owl_stub_846_LAPACKE_dtrevc"

external lapacke_ctrevc
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int -> _ CI.fatptr -> int
  = "owl_stub_847_LAPACKE_ctrevc_byte13" "owl_stub_847_LAPACKE_ctrevc"

external lapacke_ztrevc
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int -> _ CI.fatptr -> int
  = "owl_stub_848_LAPACKE_ztrevc_byte13" "owl_stub_848_LAPACKE_ztrevc"

external lapacke_strexc
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_849_LAPACKE_strexc_byte9" "owl_stub_849_LAPACKE_strexc"

external lapacke_dtrexc
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_850_LAPACKE_dtrexc_byte9" "owl_stub_850_LAPACKE_dtrexc"

external lapacke_ctrexc
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int -> int -> int
  = "owl_stub_851_LAPACKE_ctrexc_byte9" "owl_stub_851_LAPACKE_ctrexc"

external lapacke_ztrexc
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int -> int -> int
  = "owl_stub_852_LAPACKE_ztrexc_byte9" "owl_stub_852_LAPACKE_ztrexc"

external lapacke_strrfs
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_853_LAPACKE_strrfs_byte14" "owl_stub_853_LAPACKE_strrfs"

external lapacke_dtrrfs
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_854_LAPACKE_dtrrfs_byte14" "owl_stub_854_LAPACKE_dtrrfs"

external lapacke_ctrrfs
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_855_LAPACKE_ctrrfs_byte14" "owl_stub_855_LAPACKE_ctrrfs"

external lapacke_ztrrfs
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_856_LAPACKE_ztrrfs_byte14" "owl_stub_856_LAPACKE_ztrrfs"

external lapacke_strsen
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_857_LAPACKE_strsen_byte14" "owl_stub_857_LAPACKE_strsen"

external lapacke_dtrsen
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_858_LAPACKE_dtrsen_byte14" "owl_stub_858_LAPACKE_dtrsen"

external lapacke_ctrsen
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_859_LAPACKE_ctrsen_byte13" "owl_stub_859_LAPACKE_ctrsen"

external lapacke_ztrsen
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_860_LAPACKE_ztrsen_byte13" "owl_stub_860_LAPACKE_ztrsen"

external lapacke_strsna
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_861_LAPACKE_strsna_byte15" "owl_stub_861_LAPACKE_strsna"

external lapacke_dtrsna
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_862_LAPACKE_dtrsna_byte15" "owl_stub_862_LAPACKE_dtrsna"

external lapacke_ctrsna
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_863_LAPACKE_ctrsna_byte15" "owl_stub_863_LAPACKE_ctrsna"

external lapacke_ztrsna
  : int -> char -> char -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_864_LAPACKE_ztrsna_byte15" "owl_stub_864_LAPACKE_ztrsna"

external lapacke_strsyl
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_865_LAPACKE_strsyl_byte13" "owl_stub_865_LAPACKE_strsyl"

external lapacke_dtrsyl
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_866_LAPACKE_dtrsyl_byte13" "owl_stub_866_LAPACKE_dtrsyl"

external lapacke_ctrsyl
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_867_LAPACKE_ctrsyl_byte13" "owl_stub_867_LAPACKE_ctrsyl"

external lapacke_ztrsyl
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_868_LAPACKE_ztrsyl_byte13" "owl_stub_868_LAPACKE_ztrsyl"

external lapacke_strtri
  : int -> char -> char -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_869_LAPACKE_strtri_byte6" "owl_stub_869_LAPACKE_strtri"

external lapacke_dtrtri
  : int -> char -> char -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_870_LAPACKE_dtrtri_byte6" "owl_stub_870_LAPACKE_dtrtri"

external lapacke_ctrtri
  : int -> char -> char -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_871_LAPACKE_ctrtri_byte6" "owl_stub_871_LAPACKE_ctrtri"

external lapacke_ztrtri
  : int -> char -> char -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_872_LAPACKE_ztrtri_byte6" "owl_stub_872_LAPACKE_ztrtri"

external lapacke_strtrs
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_873_LAPACKE_strtrs_byte10" "owl_stub_873_LAPACKE_strtrs"

external lapacke_dtrtrs
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_874_LAPACKE_dtrtrs_byte10" "owl_stub_874_LAPACKE_dtrtrs"

external lapacke_ctrtrs
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_875_LAPACKE_ctrtrs_byte10" "owl_stub_875_LAPACKE_ctrtrs"

external lapacke_ztrtrs
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_876_LAPACKE_ztrtrs_byte10" "owl_stub_876_LAPACKE_ztrtrs"

external lapacke_strttf
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_877_LAPACKE_strttf_byte7" "owl_stub_877_LAPACKE_strttf"

external lapacke_dtrttf
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_878_LAPACKE_dtrttf_byte7" "owl_stub_878_LAPACKE_dtrttf"

external lapacke_ctrttf
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_879_LAPACKE_ctrttf_byte7" "owl_stub_879_LAPACKE_ctrttf"

external lapacke_ztrttf
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_880_LAPACKE_ztrttf_byte7" "owl_stub_880_LAPACKE_ztrttf"

external lapacke_strttp
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_881_LAPACKE_strttp_byte6" "owl_stub_881_LAPACKE_strttp"

external lapacke_dtrttp
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_882_LAPACKE_dtrttp_byte6" "owl_stub_882_LAPACKE_dtrttp"

external lapacke_ctrttp
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_883_LAPACKE_ctrttp_byte6" "owl_stub_883_LAPACKE_ctrttp"

external lapacke_ztrttp
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_884_LAPACKE_ztrttp_byte6" "owl_stub_884_LAPACKE_ztrttp"

external lapacke_stzrzf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_885_LAPACKE_stzrzf_byte6" "owl_stub_885_LAPACKE_stzrzf"

external lapacke_dtzrzf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_886_LAPACKE_dtzrzf_byte6" "owl_stub_886_LAPACKE_dtzrzf"

external lapacke_ctzrzf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_887_LAPACKE_ctzrzf_byte6" "owl_stub_887_LAPACKE_ctzrzf"

external lapacke_ztzrzf
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_888_LAPACKE_ztzrzf_byte6" "owl_stub_888_LAPACKE_ztzrzf"

external lapacke_cungbr
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_889_LAPACKE_cungbr_byte8" "owl_stub_889_LAPACKE_cungbr"

external lapacke_zungbr
  : int -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_890_LAPACKE_zungbr_byte8" "owl_stub_890_LAPACKE_zungbr"

external lapacke_cunghr
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_891_LAPACKE_cunghr_byte7" "owl_stub_891_LAPACKE_cunghr"

external lapacke_zunghr
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_892_LAPACKE_zunghr_byte7" "owl_stub_892_LAPACKE_zunghr"

external lapacke_cunglq
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_893_LAPACKE_cunglq_byte7" "owl_stub_893_LAPACKE_cunglq"

external lapacke_zunglq
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_894_LAPACKE_zunglq_byte7" "owl_stub_894_LAPACKE_zunglq"

external lapacke_cungql
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_895_LAPACKE_cungql_byte7" "owl_stub_895_LAPACKE_cungql"

external lapacke_zungql
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_896_LAPACKE_zungql_byte7" "owl_stub_896_LAPACKE_zungql"

external lapacke_cungqr
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_897_LAPACKE_cungqr_byte7" "owl_stub_897_LAPACKE_cungqr"

external lapacke_zungqr
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_898_LAPACKE_zungqr_byte7" "owl_stub_898_LAPACKE_zungqr"

external lapacke_cungrq
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_899_LAPACKE_cungrq_byte7" "owl_stub_899_LAPACKE_cungrq"

external lapacke_zungrq
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_900_LAPACKE_zungrq_byte7" "owl_stub_900_LAPACKE_zungrq"

external lapacke_cungtr
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_901_LAPACKE_cungtr_byte6" "owl_stub_901_LAPACKE_cungtr"

external lapacke_zungtr
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_902_LAPACKE_zungtr_byte6" "owl_stub_902_LAPACKE_zungtr"

external lapacke_cunmbr
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_903_LAPACKE_cunmbr_byte12" "owl_stub_903_LAPACKE_cunmbr"

external lapacke_zunmbr
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_904_LAPACKE_zunmbr_byte12" "owl_stub_904_LAPACKE_zunmbr"

external lapacke_cunmhr
  : int -> char -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_905_LAPACKE_cunmhr_byte12" "owl_stub_905_LAPACKE_cunmhr"

external lapacke_zunmhr
  : int -> char -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_906_LAPACKE_zunmhr_byte12" "owl_stub_906_LAPACKE_zunmhr"

external lapacke_cunmlq
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_907_LAPACKE_cunmlq_byte11" "owl_stub_907_LAPACKE_cunmlq"

external lapacke_zunmlq
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_908_LAPACKE_zunmlq_byte11" "owl_stub_908_LAPACKE_zunmlq"

external lapacke_cunmql
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_909_LAPACKE_cunmql_byte11" "owl_stub_909_LAPACKE_cunmql"

external lapacke_zunmql
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_910_LAPACKE_zunmql_byte11" "owl_stub_910_LAPACKE_zunmql"

external lapacke_cunmqr
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_911_LAPACKE_cunmqr_byte11" "owl_stub_911_LAPACKE_cunmqr"

external lapacke_zunmqr
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_912_LAPACKE_zunmqr_byte11" "owl_stub_912_LAPACKE_zunmqr"

external lapacke_cunmrq
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_913_LAPACKE_cunmrq_byte11" "owl_stub_913_LAPACKE_cunmrq"

external lapacke_zunmrq
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_914_LAPACKE_zunmrq_byte11" "owl_stub_914_LAPACKE_zunmrq"

external lapacke_cunmrz
  : int -> char -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_915_LAPACKE_cunmrz_byte12" "owl_stub_915_LAPACKE_cunmrz"

external lapacke_zunmrz
  : int -> char -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_916_LAPACKE_zunmrz_byte12" "owl_stub_916_LAPACKE_zunmrz"

external lapacke_cunmtr
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_917_LAPACKE_cunmtr_byte11" "owl_stub_917_LAPACKE_cunmtr"

external lapacke_zunmtr
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_918_LAPACKE_zunmtr_byte11" "owl_stub_918_LAPACKE_zunmtr"

external lapacke_cupgtr
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_919_LAPACKE_cupgtr_byte7" "owl_stub_919_LAPACKE_cupgtr"

external lapacke_zupgtr
  : int -> char -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_920_LAPACKE_zupgtr_byte7" "owl_stub_920_LAPACKE_zupgtr"

external lapacke_cupmtr
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_921_LAPACKE_cupmtr_byte10" "owl_stub_921_LAPACKE_cupmtr"

external lapacke_zupmtr
  : int -> char -> char -> char -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_922_LAPACKE_zupmtr_byte10" "owl_stub_922_LAPACKE_zupmtr"

external lapacke_claghe
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_923_LAPACKE_claghe_byte7" "owl_stub_923_LAPACKE_claghe"

external lapacke_zlaghe
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_924_LAPACKE_zlaghe_byte7" "owl_stub_924_LAPACKE_zlaghe"

external lapacke_slagsy
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_925_LAPACKE_slagsy_byte7" "owl_stub_925_LAPACKE_slagsy"

external lapacke_dlagsy
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_926_LAPACKE_dlagsy_byte7" "owl_stub_926_LAPACKE_dlagsy"

external lapacke_clagsy
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_927_LAPACKE_clagsy_byte7" "owl_stub_927_LAPACKE_clagsy"

external lapacke_zlagsy
  : int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_928_LAPACKE_zlagsy_byte7" "owl_stub_928_LAPACKE_zlagsy"

external lapacke_slapmr
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_929_LAPACKE_slapmr_byte7" "owl_stub_929_LAPACKE_slapmr"

external lapacke_dlapmr
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_930_LAPACKE_dlapmr_byte7" "owl_stub_930_LAPACKE_dlapmr"

external lapacke_clapmr
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_931_LAPACKE_clapmr_byte7" "owl_stub_931_LAPACKE_clapmr"

external lapacke_zlapmr
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_932_LAPACKE_zlapmr_byte7" "owl_stub_932_LAPACKE_zlapmr"

external lapacke_slapmt
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_933_LAPACKE_slapmt_byte7" "owl_stub_933_LAPACKE_slapmt"

external lapacke_dlapmt
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_934_LAPACKE_dlapmt_byte7" "owl_stub_934_LAPACKE_dlapmt"

external lapacke_clapmt
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_935_LAPACKE_clapmt_byte7" "owl_stub_935_LAPACKE_clapmt"

external lapacke_zlapmt
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_936_LAPACKE_zlapmt_byte7" "owl_stub_936_LAPACKE_zlapmt"

external lapacke_slartgp
  : float -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_937_LAPACKE_slartgp"

external lapacke_dlartgp
  : float -> float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_938_LAPACKE_dlartgp"

external lapacke_slartgs
  : float -> float -> float -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_939_LAPACKE_slartgs"

external lapacke_dlartgs
  : float -> float -> float -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_940_LAPACKE_dlartgs"

external lapacke_cbbcsd
  : int -> char -> char -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_941_LAPACKE_cbbcsd_byte27" "owl_stub_941_LAPACKE_cbbcsd"

external lapacke_cheswapr
  : int -> char -> int -> _ CI.fatptr -> int -> int -> int -> int
  = "owl_stub_942_LAPACKE_cheswapr_byte7" "owl_stub_942_LAPACKE_cheswapr"

external lapacke_chetri2
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_943_LAPACKE_chetri2_byte6" "owl_stub_943_LAPACKE_chetri2"

external lapacke_chetri2x
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_944_LAPACKE_chetri2x_byte7" "owl_stub_944_LAPACKE_chetri2x"

external lapacke_chetrs2
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_945_LAPACKE_chetrs2_byte9" "owl_stub_945_LAPACKE_chetrs2"

external lapacke_csyconv
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_946_LAPACKE_csyconv_byte8" "owl_stub_946_LAPACKE_csyconv"

external lapacke_csyswapr
  : int -> char -> int -> _ CI.fatptr -> int -> int -> int -> int
  = "owl_stub_947_LAPACKE_csyswapr_byte7" "owl_stub_947_LAPACKE_csyswapr"

external lapacke_csytri2
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_948_LAPACKE_csytri2_byte6" "owl_stub_948_LAPACKE_csytri2"

external lapacke_csytri2x
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_949_LAPACKE_csytri2x_byte7" "owl_stub_949_LAPACKE_csytri2x"

external lapacke_csytrs2
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_950_LAPACKE_csytrs2_byte9" "owl_stub_950_LAPACKE_csytrs2"

external lapacke_cunbdb
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_951_LAPACKE_cunbdb_byte20" "owl_stub_951_LAPACKE_cunbdb"

external lapacke_cuncsd
  : int -> char -> char -> char -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_952_LAPACKE_cuncsd_byte27" "owl_stub_952_LAPACKE_cuncsd"

external lapacke_cuncsd2by1
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_953_LAPACKE_cuncsd2by1_byte18" "owl_stub_953_LAPACKE_cuncsd2by1"

external lapacke_dbbcsd
  : int -> char -> char -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_954_LAPACKE_dbbcsd_byte27" "owl_stub_954_LAPACKE_dbbcsd"

external lapacke_dorbdb
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_955_LAPACKE_dorbdb_byte20" "owl_stub_955_LAPACKE_dorbdb"

external lapacke_dorcsd
  : int -> char -> char -> char -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_956_LAPACKE_dorcsd_byte27" "owl_stub_956_LAPACKE_dorcsd"

external lapacke_dorcsd2by1
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_957_LAPACKE_dorcsd2by1_byte18" "owl_stub_957_LAPACKE_dorcsd2by1"

external lapacke_dsyconv
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_958_LAPACKE_dsyconv_byte8" "owl_stub_958_LAPACKE_dsyconv"

external lapacke_dsyswapr
  : int -> char -> int -> _ CI.fatptr -> int -> int -> int -> int
  = "owl_stub_959_LAPACKE_dsyswapr_byte7" "owl_stub_959_LAPACKE_dsyswapr"

external lapacke_dsytri2
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_960_LAPACKE_dsytri2_byte6" "owl_stub_960_LAPACKE_dsytri2"

external lapacke_dsytri2x
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_961_LAPACKE_dsytri2x_byte7" "owl_stub_961_LAPACKE_dsytri2x"

external lapacke_dsytrs2
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_962_LAPACKE_dsytrs2_byte9" "owl_stub_962_LAPACKE_dsytrs2"

external lapacke_sbbcsd
  : int -> char -> char -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_963_LAPACKE_sbbcsd_byte27" "owl_stub_963_LAPACKE_sbbcsd"

external lapacke_sorbdb
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_964_LAPACKE_sorbdb_byte20" "owl_stub_964_LAPACKE_sorbdb"

external lapacke_sorcsd
  : int -> char -> char -> char -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_965_LAPACKE_sorcsd_byte27" "owl_stub_965_LAPACKE_sorcsd"

external lapacke_sorcsd2by1
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_966_LAPACKE_sorcsd2by1_byte18" "owl_stub_966_LAPACKE_sorcsd2by1"

external lapacke_ssyconv
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_967_LAPACKE_ssyconv_byte8" "owl_stub_967_LAPACKE_ssyconv"

external lapacke_ssyswapr
  : int -> char -> int -> _ CI.fatptr -> int -> int -> int -> int
  = "owl_stub_968_LAPACKE_ssyswapr_byte7" "owl_stub_968_LAPACKE_ssyswapr"

external lapacke_ssytri2
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_969_LAPACKE_ssytri2_byte6" "owl_stub_969_LAPACKE_ssytri2"

external lapacke_ssytri2x
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_970_LAPACKE_ssytri2x_byte7" "owl_stub_970_LAPACKE_ssytri2x"

external lapacke_ssytrs2
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_971_LAPACKE_ssytrs2_byte9" "owl_stub_971_LAPACKE_ssytrs2"

external lapacke_zbbcsd
  : int -> char -> char -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_972_LAPACKE_zbbcsd_byte27" "owl_stub_972_LAPACKE_zbbcsd"

external lapacke_zheswapr
  : int -> char -> int -> _ CI.fatptr -> int -> int -> int -> int
  = "owl_stub_973_LAPACKE_zheswapr_byte7" "owl_stub_973_LAPACKE_zheswapr"

external lapacke_zhetri2
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_974_LAPACKE_zhetri2_byte6" "owl_stub_974_LAPACKE_zhetri2"

external lapacke_zhetri2x
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_975_LAPACKE_zhetri2x_byte7" "owl_stub_975_LAPACKE_zhetri2x"

external lapacke_zhetrs2
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_976_LAPACKE_zhetrs2_byte9" "owl_stub_976_LAPACKE_zhetrs2"

external lapacke_zsyconv
  : int -> char -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_977_LAPACKE_zsyconv_byte8" "owl_stub_977_LAPACKE_zsyconv"

external lapacke_zsyswapr
  : int -> char -> int -> _ CI.fatptr -> int -> int -> int -> int
  = "owl_stub_978_LAPACKE_zsyswapr_byte7" "owl_stub_978_LAPACKE_zsyswapr"

external lapacke_zsytri2
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_979_LAPACKE_zsytri2_byte6" "owl_stub_979_LAPACKE_zsytri2"

external lapacke_zsytri2x
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_980_LAPACKE_zsytri2x_byte7" "owl_stub_980_LAPACKE_zsytri2x"

external lapacke_zsytrs2
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_981_LAPACKE_zsytrs2_byte9" "owl_stub_981_LAPACKE_zsytrs2"

external lapacke_zunbdb
  : int -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_982_LAPACKE_zunbdb_byte20" "owl_stub_982_LAPACKE_zunbdb"

external lapacke_zuncsd
  : int -> char -> char -> char -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_983_LAPACKE_zuncsd_byte27" "owl_stub_983_LAPACKE_zuncsd"

external lapacke_zuncsd2by1
  : int -> char -> char -> char -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_984_LAPACKE_zuncsd2by1_byte18" "owl_stub_984_LAPACKE_zuncsd2by1"

external lapacke_sgemqrt
  : int -> char -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_985_LAPACKE_sgemqrt_byte13" "owl_stub_985_LAPACKE_sgemqrt"

external lapacke_dgemqrt
  : int -> char -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_986_LAPACKE_dgemqrt_byte13" "owl_stub_986_LAPACKE_dgemqrt"

external lapacke_cgemqrt
  : int -> char -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_987_LAPACKE_cgemqrt_byte13" "owl_stub_987_LAPACKE_cgemqrt"

external lapacke_zgemqrt
  : int -> char -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_988_LAPACKE_zgemqrt_byte13" "owl_stub_988_LAPACKE_zgemqrt"

external lapacke_sgeqrt
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_989_LAPACKE_sgeqrt_byte8" "owl_stub_989_LAPACKE_sgeqrt"

external lapacke_dgeqrt
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_990_LAPACKE_dgeqrt_byte8" "owl_stub_990_LAPACKE_dgeqrt"

external lapacke_cgeqrt
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_991_LAPACKE_cgeqrt_byte8" "owl_stub_991_LAPACKE_cgeqrt"

external lapacke_zgeqrt
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_992_LAPACKE_zgeqrt_byte8" "owl_stub_992_LAPACKE_zgeqrt"

external lapacke_sgeqrt2
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_993_LAPACKE_sgeqrt2_byte7" "owl_stub_993_LAPACKE_sgeqrt2"

external lapacke_dgeqrt2
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_994_LAPACKE_dgeqrt2_byte7" "owl_stub_994_LAPACKE_dgeqrt2"

external lapacke_cgeqrt2
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_995_LAPACKE_cgeqrt2_byte7" "owl_stub_995_LAPACKE_cgeqrt2"

external lapacke_zgeqrt2
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_996_LAPACKE_zgeqrt2_byte7" "owl_stub_996_LAPACKE_zgeqrt2"

external lapacke_sgeqrt3
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_997_LAPACKE_sgeqrt3_byte7" "owl_stub_997_LAPACKE_sgeqrt3"

external lapacke_dgeqrt3
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_998_LAPACKE_dgeqrt3_byte7" "owl_stub_998_LAPACKE_dgeqrt3"

external lapacke_cgeqrt3
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_999_LAPACKE_cgeqrt3_byte7" "owl_stub_999_LAPACKE_cgeqrt3"

external lapacke_zgeqrt3
  : int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_1000_LAPACKE_zgeqrt3_byte7" "owl_stub_1000_LAPACKE_zgeqrt3"

external lapacke_stpmqrt
  : int -> char -> char -> int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_1001_LAPACKE_stpmqrt_byte16" "owl_stub_1001_LAPACKE_stpmqrt"

external lapacke_dtpmqrt
  : int -> char -> char -> int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_1002_LAPACKE_dtpmqrt_byte16" "owl_stub_1002_LAPACKE_dtpmqrt"

external lapacke_ctpmqrt
  : int -> char -> char -> int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_1003_LAPACKE_ctpmqrt_byte16" "owl_stub_1003_LAPACKE_ctpmqrt"

external lapacke_ztpmqrt
  : int -> char -> char -> int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_1004_LAPACKE_ztpmqrt_byte16" "owl_stub_1004_LAPACKE_ztpmqrt"

external lapacke_stpqrt
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_1005_LAPACKE_stpqrt_byte11" "owl_stub_1005_LAPACKE_stpqrt"

external lapacke_dtpqrt
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_1006_LAPACKE_dtpqrt_byte11" "owl_stub_1006_LAPACKE_dtpqrt"

external lapacke_ctpqrt
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_1007_LAPACKE_ctpqrt_byte11" "owl_stub_1007_LAPACKE_ctpqrt"

external lapacke_ztpqrt
  : int -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_1008_LAPACKE_ztpqrt_byte11" "owl_stub_1008_LAPACKE_ztpqrt"

external lapacke_stpqrt2
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_1009_LAPACKE_stpqrt2_byte10" "owl_stub_1009_LAPACKE_stpqrt2"

external lapacke_dtpqrt2
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_1010_LAPACKE_dtpqrt2_byte10" "owl_stub_1010_LAPACKE_dtpqrt2"

external lapacke_ctpqrt2
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_1011_LAPACKE_ctpqrt2_byte10" "owl_stub_1011_LAPACKE_ctpqrt2"

external lapacke_ztpqrt2
  : int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_1012_LAPACKE_ztpqrt2_byte10" "owl_stub_1012_LAPACKE_ztpqrt2"

external lapacke_stprfb
  : int -> char -> char -> char -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_1013_LAPACKE_stprfb_byte17" "owl_stub_1013_LAPACKE_stprfb"

external lapacke_dtprfb
  : int -> char -> char -> char -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_1014_LAPACKE_dtprfb_byte17" "owl_stub_1014_LAPACKE_dtprfb"

external lapacke_ctprfb
  : int -> char -> char -> char -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_1015_LAPACKE_ctprfb_byte17" "owl_stub_1015_LAPACKE_ctprfb"

external lapacke_ztprfb
  : int -> char -> char -> char -> char -> int -> int -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_1016_LAPACKE_ztprfb_byte17" "owl_stub_1016_LAPACKE_ztprfb"

external lapacke_ssysv_rook
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_1017_LAPACKE_ssysv_rook_byte9" "owl_stub_1017_LAPACKE_ssysv_rook"

external lapacke_dsysv_rook
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_1018_LAPACKE_dsysv_rook_byte9" "owl_stub_1018_LAPACKE_dsysv_rook"

external lapacke_csysv_rook
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_1019_LAPACKE_csysv_rook_byte9" "owl_stub_1019_LAPACKE_csysv_rook"

external lapacke_zsysv_rook
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_1020_LAPACKE_zsysv_rook_byte9" "owl_stub_1020_LAPACKE_zsysv_rook"

external lapacke_ssytrf_rook
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_1021_LAPACKE_ssytrf_rook_byte6" "owl_stub_1021_LAPACKE_ssytrf_rook"

external lapacke_dsytrf_rook
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_1022_LAPACKE_dsytrf_rook_byte6" "owl_stub_1022_LAPACKE_dsytrf_rook"

external lapacke_csytrf_rook
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_1023_LAPACKE_csytrf_rook_byte6" "owl_stub_1023_LAPACKE_csytrf_rook"

external lapacke_zsytrf_rook
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_1024_LAPACKE_zsytrf_rook_byte6" "owl_stub_1024_LAPACKE_zsytrf_rook"

external lapacke_ssytrs_rook
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_1025_LAPACKE_ssytrs_rook_byte9" "owl_stub_1025_LAPACKE_ssytrs_rook"

external lapacke_dsytrs_rook
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_1026_LAPACKE_dsytrs_rook_byte9" "owl_stub_1026_LAPACKE_dsytrs_rook"

external lapacke_csytrs_rook
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_1027_LAPACKE_csytrs_rook_byte9" "owl_stub_1027_LAPACKE_csytrs_rook"

external lapacke_zsytrs_rook
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_1028_LAPACKE_zsytrs_rook_byte9" "owl_stub_1028_LAPACKE_zsytrs_rook"

external lapacke_chetrf_rook
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_1029_LAPACKE_chetrf_rook_byte6" "owl_stub_1029_LAPACKE_chetrf_rook"

external lapacke_zhetrf_rook
  : int -> char -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> int
  = "owl_stub_1030_LAPACKE_zhetrf_rook_byte6" "owl_stub_1030_LAPACKE_zhetrf_rook"

external lapacke_chetrs_rook
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_1031_LAPACKE_chetrs_rook_byte9" "owl_stub_1031_LAPACKE_chetrs_rook"

external lapacke_zhetrs_rook
  : int -> char -> int -> int -> _ CI.fatptr -> int -> _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_1032_LAPACKE_zhetrs_rook_byte9" "owl_stub_1032_LAPACKE_zhetrs_rook"

external lapacke_csyr
  : int -> char -> int -> Complex.t -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_1033_LAPACKE_csyr_byte8" "owl_stub_1033_LAPACKE_csyr"

external lapacke_zsyr
  : int -> char -> int -> Complex.t -> _ CI.fatptr -> int -> _ CI.fatptr -> int -> int
  = "owl_stub_1034_LAPACKE_zsyr_byte8" "owl_stub_1034_LAPACKE_zsyr"

let sbdsdc ~layout ~uplo ~compq ~n ~d ~e ~u ~ldu ~vt ~ldvt ~q ~iq =
  lapacke_sbdsdc layout uplo compq n (CI.cptr d) (CI.cptr e) (CI.cptr u) ldu (CI.cptr vt) ldvt (CI.cptr q) (CI.cptr iq)

let dbdsdc ~layout ~uplo ~compq ~n ~d ~e ~u ~ldu ~vt ~ldvt ~q ~iq =
  lapacke_dbdsdc layout uplo compq n (CI.cptr d) (CI.cptr e) (CI.cptr u) ldu (CI.cptr vt) ldvt (CI.cptr q) (CI.cptr iq)

let sbdsqr ~layout ~uplo ~n ~ncvt ~nru ~ncc ~d ~e ~vt ~ldvt ~u ~ldu ~c ~ldc =
  lapacke_sbdsqr layout uplo n ncvt nru ncc (CI.cptr d) (CI.cptr e) (CI.cptr vt) ldvt (CI.cptr u) ldu (CI.cptr c) ldc

let dbdsqr ~layout ~uplo ~n ~ncvt ~nru ~ncc ~d ~e ~vt ~ldvt ~u ~ldu ~c ~ldc =
  lapacke_dbdsqr layout uplo n ncvt nru ncc (CI.cptr d) (CI.cptr e) (CI.cptr vt) ldvt (CI.cptr u) ldu (CI.cptr c) ldc

let cbdsqr ~layout ~uplo ~n ~ncvt ~nru ~ncc ~d ~e ~vt ~ldvt ~u ~ldu ~c ~ldc =
  lapacke_cbdsqr layout uplo n ncvt nru ncc (CI.cptr d) (CI.cptr e) (CI.cptr vt) ldvt (CI.cptr u) ldu (CI.cptr c) ldc

let zbdsqr ~layout ~uplo ~n ~ncvt ~nru ~ncc ~d ~e ~vt ~ldvt ~u ~ldu ~c ~ldc =
  lapacke_zbdsqr layout uplo n ncvt nru ncc (CI.cptr d) (CI.cptr e) (CI.cptr vt) ldvt (CI.cptr u) ldu (CI.cptr c) ldc

let sbdsvdx ~layout ~uplo ~jobz ~range ~n ~d ~e ~vl ~vu ~il ~iu ~ns ~s ~z ~ldz ~superb =
  lapacke_sbdsvdx layout uplo jobz range n (CI.cptr d) (CI.cptr e) vl vu il iu (CI.cptr ns) (CI.cptr s) (CI.cptr z) ldz (CI.cptr superb)

let dbdsvdx ~layout ~uplo ~jobz ~range ~n ~d ~e ~vl ~vu ~il ~iu ~ns ~s ~z ~ldz ~superb =
  lapacke_dbdsvdx layout uplo jobz range n (CI.cptr d) (CI.cptr e) vl vu il iu (CI.cptr ns) (CI.cptr s) (CI.cptr z) ldz (CI.cptr superb)

let sdisna ~job ~m ~n ~d ~sep =
  lapacke_sdisna job m n (CI.cptr d) (CI.cptr sep)

let ddisna ~job ~m ~n ~d ~sep =
  lapacke_ddisna job m n (CI.cptr d) (CI.cptr sep)

let sgbbrd ~layout ~vect ~m ~n ~ncc ~kl ~ku ~ab ~ldab ~d ~e ~q ~ldq ~pt ~ldpt ~c ~ldc =
  lapacke_sgbbrd layout vect m n ncc kl ku (CI.cptr ab) ldab (CI.cptr d) (CI.cptr e) (CI.cptr q) ldq (CI.cptr pt) ldpt (CI.cptr c) ldc

let dgbbrd ~layout ~vect ~m ~n ~ncc ~kl ~ku ~ab ~ldab ~d ~e ~q ~ldq ~pt ~ldpt ~c ~ldc =
  lapacke_dgbbrd layout vect m n ncc kl ku (CI.cptr ab) ldab (CI.cptr d) (CI.cptr e) (CI.cptr q) ldq (CI.cptr pt) ldpt (CI.cptr c) ldc

let cgbbrd ~layout ~vect ~m ~n ~ncc ~kl ~ku ~ab ~ldab ~d ~e ~q ~ldq ~pt ~ldpt ~c ~ldc =
  lapacke_cgbbrd layout vect m n ncc kl ku (CI.cptr ab) ldab (CI.cptr d) (CI.cptr e) (CI.cptr q) ldq (CI.cptr pt) ldpt (CI.cptr c) ldc

let zgbbrd ~layout ~vect ~m ~n ~ncc ~kl ~ku ~ab ~ldab ~d ~e ~q ~ldq ~pt ~ldpt ~c ~ldc =
  lapacke_zgbbrd layout vect m n ncc kl ku (CI.cptr ab) ldab (CI.cptr d) (CI.cptr e) (CI.cptr q) ldq (CI.cptr pt) ldpt (CI.cptr c) ldc

let sgbcon ~layout ~norm ~n ~kl ~ku ~ab ~ldab ~ipiv ~anorm ~rcond =
  lapacke_sgbcon layout norm n kl ku (CI.cptr ab) ldab (CI.cptr ipiv) anorm (CI.cptr rcond)

let dgbcon ~layout ~norm ~n ~kl ~ku ~ab ~ldab ~ipiv ~anorm ~rcond =
  lapacke_dgbcon layout norm n kl ku (CI.cptr ab) ldab (CI.cptr ipiv) anorm (CI.cptr rcond)

let cgbcon ~layout ~norm ~n ~kl ~ku ~ab ~ldab ~ipiv ~anorm ~rcond =
  lapacke_cgbcon layout norm n kl ku (CI.cptr ab) ldab (CI.cptr ipiv) anorm (CI.cptr rcond)

let zgbcon ~layout ~norm ~n ~kl ~ku ~ab ~ldab ~ipiv ~anorm ~rcond =
  lapacke_zgbcon layout norm n kl ku (CI.cptr ab) ldab (CI.cptr ipiv) anorm (CI.cptr rcond)

let sgbequ ~layout ~m ~n ~kl ~ku ~ab ~ldab ~r ~c ~rowcnd ~colcnd ~amax =
  lapacke_sgbequ layout m n kl ku (CI.cptr ab) ldab (CI.cptr r) (CI.cptr c) (CI.cptr rowcnd) (CI.cptr colcnd) (CI.cptr amax)

let dgbequ ~layout ~m ~n ~kl ~ku ~ab ~ldab ~r ~c ~rowcnd ~colcnd ~amax =
  lapacke_dgbequ layout m n kl ku (CI.cptr ab) ldab (CI.cptr r) (CI.cptr c) (CI.cptr rowcnd) (CI.cptr colcnd) (CI.cptr amax)

let cgbequ ~layout ~m ~n ~kl ~ku ~ab ~ldab ~r ~c ~rowcnd ~colcnd ~amax =
  lapacke_cgbequ layout m n kl ku (CI.cptr ab) ldab (CI.cptr r) (CI.cptr c) (CI.cptr rowcnd) (CI.cptr colcnd) (CI.cptr amax)

let zgbequ ~layout ~m ~n ~kl ~ku ~ab ~ldab ~r ~c ~rowcnd ~colcnd ~amax =
  lapacke_zgbequ layout m n kl ku (CI.cptr ab) ldab (CI.cptr r) (CI.cptr c) (CI.cptr rowcnd) (CI.cptr colcnd) (CI.cptr amax)

let sgbequb ~layout ~m ~n ~kl ~ku ~ab ~ldab ~r ~c ~rowcnd ~colcnd ~amax =
  lapacke_sgbequb layout m n kl ku (CI.cptr ab) ldab (CI.cptr r) (CI.cptr c) (CI.cptr rowcnd) (CI.cptr colcnd) (CI.cptr amax)

let dgbequb ~layout ~m ~n ~kl ~ku ~ab ~ldab ~r ~c ~rowcnd ~colcnd ~amax =
  lapacke_dgbequb layout m n kl ku (CI.cptr ab) ldab (CI.cptr r) (CI.cptr c) (CI.cptr rowcnd) (CI.cptr colcnd) (CI.cptr amax)

let cgbequb ~layout ~m ~n ~kl ~ku ~ab ~ldab ~r ~c ~rowcnd ~colcnd ~amax =
  lapacke_cgbequb layout m n kl ku (CI.cptr ab) ldab (CI.cptr r) (CI.cptr c) (CI.cptr rowcnd) (CI.cptr colcnd) (CI.cptr amax)

let zgbequb ~layout ~m ~n ~kl ~ku ~ab ~ldab ~r ~c ~rowcnd ~colcnd ~amax =
  lapacke_zgbequb layout m n kl ku (CI.cptr ab) ldab (CI.cptr r) (CI.cptr c) (CI.cptr rowcnd) (CI.cptr colcnd) (CI.cptr amax)

let sgbrfs ~layout ~trans ~n ~kl ~ku ~nrhs ~ab ~ldab ~afb ~ldafb ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_sgbrfs layout trans n kl ku nrhs (CI.cptr ab) ldab (CI.cptr afb) ldafb (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let dgbrfs ~layout ~trans ~n ~kl ~ku ~nrhs ~ab ~ldab ~afb ~ldafb ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_dgbrfs layout trans n kl ku nrhs (CI.cptr ab) ldab (CI.cptr afb) ldafb (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let cgbrfs ~layout ~trans ~n ~kl ~ku ~nrhs ~ab ~ldab ~afb ~ldafb ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_cgbrfs layout trans n kl ku nrhs (CI.cptr ab) ldab (CI.cptr afb) ldafb (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let zgbrfs ~layout ~trans ~n ~kl ~ku ~nrhs ~ab ~ldab ~afb ~ldafb ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_zgbrfs layout trans n kl ku nrhs (CI.cptr ab) ldab (CI.cptr afb) ldafb (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let sgbsv ~layout ~n ~kl ~ku ~nrhs ~ab ~ldab ~ipiv ~b ~ldb =
  lapacke_sgbsv layout n kl ku nrhs (CI.cptr ab) ldab (CI.cptr ipiv) (CI.cptr b) ldb

let dgbsv ~layout ~n ~kl ~ku ~nrhs ~ab ~ldab ~ipiv ~b ~ldb =
  lapacke_dgbsv layout n kl ku nrhs (CI.cptr ab) ldab (CI.cptr ipiv) (CI.cptr b) ldb

let cgbsv ~layout ~n ~kl ~ku ~nrhs ~ab ~ldab ~ipiv ~b ~ldb =
  lapacke_cgbsv layout n kl ku nrhs (CI.cptr ab) ldab (CI.cptr ipiv) (CI.cptr b) ldb

let zgbsv ~layout ~n ~kl ~ku ~nrhs ~ab ~ldab ~ipiv ~b ~ldb =
  lapacke_zgbsv layout n kl ku nrhs (CI.cptr ab) ldab (CI.cptr ipiv) (CI.cptr b) ldb

let sgbsvx ~layout ~fact ~trans ~n ~kl ~ku ~nrhs ~ab ~ldab ~afb ~ldafb ~ipiv ~equed ~r ~c ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr ~rpivot =
  lapacke_sgbsvx layout fact trans n kl ku nrhs (CI.cptr ab) ldab (CI.cptr afb) ldafb (CI.cptr ipiv) (CI.cptr equed) (CI.cptr r) (CI.cptr c) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr) (CI.cptr rpivot)

let dgbsvx ~layout ~fact ~trans ~n ~kl ~ku ~nrhs ~ab ~ldab ~afb ~ldafb ~ipiv ~equed ~r ~c ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr ~rpivot =
  lapacke_dgbsvx layout fact trans n kl ku nrhs (CI.cptr ab) ldab (CI.cptr afb) ldafb (CI.cptr ipiv) (CI.cptr equed) (CI.cptr r) (CI.cptr c) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr) (CI.cptr rpivot)

let cgbsvx ~layout ~fact ~trans ~n ~kl ~ku ~nrhs ~ab ~ldab ~afb ~ldafb ~ipiv ~equed ~r ~c ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr ~rpivot =
  lapacke_cgbsvx layout fact trans n kl ku nrhs (CI.cptr ab) ldab (CI.cptr afb) ldafb (CI.cptr ipiv) (CI.cptr equed) (CI.cptr r) (CI.cptr c) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr) (CI.cptr rpivot)

let zgbsvx ~layout ~fact ~trans ~n ~kl ~ku ~nrhs ~ab ~ldab ~afb ~ldafb ~ipiv ~equed ~r ~c ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr ~rpivot =
  lapacke_zgbsvx layout fact trans n kl ku nrhs (CI.cptr ab) ldab (CI.cptr afb) ldafb (CI.cptr ipiv) (CI.cptr equed) (CI.cptr r) (CI.cptr c) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr) (CI.cptr rpivot)

let sgbtrf ~layout ~m ~n ~kl ~ku ~ab ~ldab ~ipiv =
  lapacke_sgbtrf layout m n kl ku (CI.cptr ab) ldab (CI.cptr ipiv)

let dgbtrf ~layout ~m ~n ~kl ~ku ~ab ~ldab ~ipiv =
  lapacke_dgbtrf layout m n kl ku (CI.cptr ab) ldab (CI.cptr ipiv)

let cgbtrf ~layout ~m ~n ~kl ~ku ~ab ~ldab ~ipiv =
  lapacke_cgbtrf layout m n kl ku (CI.cptr ab) ldab (CI.cptr ipiv)

let zgbtrf ~layout ~m ~n ~kl ~ku ~ab ~ldab ~ipiv =
  lapacke_zgbtrf layout m n kl ku (CI.cptr ab) ldab (CI.cptr ipiv)

let sgbtrs ~layout ~trans ~n ~kl ~ku ~nrhs ~ab ~ldab ~ipiv ~b ~ldb =
  lapacke_sgbtrs layout trans n kl ku nrhs (CI.cptr ab) ldab (CI.cptr ipiv) (CI.cptr b) ldb

let dgbtrs ~layout ~trans ~n ~kl ~ku ~nrhs ~ab ~ldab ~ipiv ~b ~ldb =
  lapacke_dgbtrs layout trans n kl ku nrhs (CI.cptr ab) ldab (CI.cptr ipiv) (CI.cptr b) ldb

let cgbtrs ~layout ~trans ~n ~kl ~ku ~nrhs ~ab ~ldab ~ipiv ~b ~ldb =
  lapacke_cgbtrs layout trans n kl ku nrhs (CI.cptr ab) ldab (CI.cptr ipiv) (CI.cptr b) ldb

let zgbtrs ~layout ~trans ~n ~kl ~ku ~nrhs ~ab ~ldab ~ipiv ~b ~ldb =
  lapacke_zgbtrs layout trans n kl ku nrhs (CI.cptr ab) ldab (CI.cptr ipiv) (CI.cptr b) ldb

let sgebak ~layout ~job ~side ~n ~ilo ~ihi ~scale ~m ~v ~ldv =
  lapacke_sgebak layout job side n ilo ihi (CI.cptr scale) m (CI.cptr v) ldv

let dgebak ~layout ~job ~side ~n ~ilo ~ihi ~scale ~m ~v ~ldv =
  lapacke_dgebak layout job side n ilo ihi (CI.cptr scale) m (CI.cptr v) ldv

let cgebak ~layout ~job ~side ~n ~ilo ~ihi ~scale ~m ~v ~ldv =
  lapacke_cgebak layout job side n ilo ihi (CI.cptr scale) m (CI.cptr v) ldv

let zgebak ~layout ~job ~side ~n ~ilo ~ihi ~scale ~m ~v ~ldv =
  lapacke_zgebak layout job side n ilo ihi (CI.cptr scale) m (CI.cptr v) ldv

let sgebal ~layout ~job ~n ~a ~lda ~ilo ~ihi ~scale =
  lapacke_sgebal layout job n (CI.cptr a) lda (CI.cptr ilo) (CI.cptr ihi) (CI.cptr scale)

let dgebal ~layout ~job ~n ~a ~lda ~ilo ~ihi ~scale =
  lapacke_dgebal layout job n (CI.cptr a) lda (CI.cptr ilo) (CI.cptr ihi) (CI.cptr scale)

let cgebal ~layout ~job ~n ~a ~lda ~ilo ~ihi ~scale =
  lapacke_cgebal layout job n (CI.cptr a) lda (CI.cptr ilo) (CI.cptr ihi) (CI.cptr scale)

let zgebal ~layout ~job ~n ~a ~lda ~ilo ~ihi ~scale =
  lapacke_zgebal layout job n (CI.cptr a) lda (CI.cptr ilo) (CI.cptr ihi) (CI.cptr scale)

let sgebrd ~layout ~m ~n ~a ~lda ~d ~e ~tauq ~taup =
  lapacke_sgebrd layout m n (CI.cptr a) lda (CI.cptr d) (CI.cptr e) (CI.cptr tauq) (CI.cptr taup)

let dgebrd ~layout ~m ~n ~a ~lda ~d ~e ~tauq ~taup =
  lapacke_dgebrd layout m n (CI.cptr a) lda (CI.cptr d) (CI.cptr e) (CI.cptr tauq) (CI.cptr taup)

let cgebrd ~layout ~m ~n ~a ~lda ~d ~e ~tauq ~taup =
  lapacke_cgebrd layout m n (CI.cptr a) lda (CI.cptr d) (CI.cptr e) (CI.cptr tauq) (CI.cptr taup)

let zgebrd ~layout ~m ~n ~a ~lda ~d ~e ~tauq ~taup =
  lapacke_zgebrd layout m n (CI.cptr a) lda (CI.cptr d) (CI.cptr e) (CI.cptr tauq) (CI.cptr taup)

let sgecon ~layout ~norm ~n ~a ~lda ~anorm ~rcond =
  lapacke_sgecon layout norm n (CI.cptr a) lda anorm (CI.cptr rcond)

let dgecon ~layout ~norm ~n ~a ~lda ~anorm ~rcond =
  lapacke_dgecon layout norm n (CI.cptr a) lda anorm (CI.cptr rcond)

let cgecon ~layout ~norm ~n ~a ~lda ~anorm ~rcond =
  lapacke_cgecon layout norm n (CI.cptr a) lda anorm (CI.cptr rcond)

let zgecon ~layout ~norm ~n ~a ~lda ~anorm ~rcond =
  lapacke_zgecon layout norm n (CI.cptr a) lda anorm (CI.cptr rcond)

let sgeequ ~layout ~m ~n ~a ~lda ~r ~c ~rowcnd ~colcnd ~amax =
  lapacke_sgeequ layout m n (CI.cptr a) lda (CI.cptr r) (CI.cptr c) (CI.cptr rowcnd) (CI.cptr colcnd) (CI.cptr amax)

let dgeequ ~layout ~m ~n ~a ~lda ~r ~c ~rowcnd ~colcnd ~amax =
  lapacke_dgeequ layout m n (CI.cptr a) lda (CI.cptr r) (CI.cptr c) (CI.cptr rowcnd) (CI.cptr colcnd) (CI.cptr amax)

let cgeequ ~layout ~m ~n ~a ~lda ~r ~c ~rowcnd ~colcnd ~amax =
  lapacke_cgeequ layout m n (CI.cptr a) lda (CI.cptr r) (CI.cptr c) (CI.cptr rowcnd) (CI.cptr colcnd) (CI.cptr amax)

let zgeequ ~layout ~m ~n ~a ~lda ~r ~c ~rowcnd ~colcnd ~amax =
  lapacke_zgeequ layout m n (CI.cptr a) lda (CI.cptr r) (CI.cptr c) (CI.cptr rowcnd) (CI.cptr colcnd) (CI.cptr amax)

let sgeequb ~layout ~m ~n ~a ~lda ~r ~c ~rowcnd ~colcnd ~amax =
  lapacke_sgeequb layout m n (CI.cptr a) lda (CI.cptr r) (CI.cptr c) (CI.cptr rowcnd) (CI.cptr colcnd) (CI.cptr amax)

let dgeequb ~layout ~m ~n ~a ~lda ~r ~c ~rowcnd ~colcnd ~amax =
  lapacke_dgeequb layout m n (CI.cptr a) lda (CI.cptr r) (CI.cptr c) (CI.cptr rowcnd) (CI.cptr colcnd) (CI.cptr amax)

let cgeequb ~layout ~m ~n ~a ~lda ~r ~c ~rowcnd ~colcnd ~amax =
  lapacke_cgeequb layout m n (CI.cptr a) lda (CI.cptr r) (CI.cptr c) (CI.cptr rowcnd) (CI.cptr colcnd) (CI.cptr amax)

let zgeequb ~layout ~m ~n ~a ~lda ~r ~c ~rowcnd ~colcnd ~amax =
  lapacke_zgeequb layout m n (CI.cptr a) lda (CI.cptr r) (CI.cptr c) (CI.cptr rowcnd) (CI.cptr colcnd) (CI.cptr amax)

let sgees ~layout ~jobvs ~sort ~select ~n ~a ~lda ~sdim ~wr ~wi ~vs ~ldvs =
  lapacke_sgees layout jobvs sort (CI.cptr select) n (CI.cptr a) lda (CI.cptr sdim) (CI.cptr wr) (CI.cptr wi) (CI.cptr vs) ldvs

let dgees ~layout ~jobvs ~sort ~select ~n ~a ~lda ~sdim ~wr ~wi ~vs ~ldvs =
  lapacke_dgees layout jobvs sort (CI.cptr select) n (CI.cptr a) lda (CI.cptr sdim) (CI.cptr wr) (CI.cptr wi) (CI.cptr vs) ldvs

let cgees ~layout ~jobvs ~sort ~select ~n ~a ~lda ~sdim ~w ~vs ~ldvs =
  lapacke_cgees layout jobvs sort (CI.cptr select) n (CI.cptr a) lda (CI.cptr sdim) (CI.cptr w) (CI.cptr vs) ldvs

let zgees ~layout ~jobvs ~sort ~select ~n ~a ~lda ~sdim ~w ~vs ~ldvs =
  lapacke_zgees layout jobvs sort (CI.cptr select) n (CI.cptr a) lda (CI.cptr sdim) (CI.cptr w) (CI.cptr vs) ldvs

let sgeesx ~layout ~jobvs ~sort ~select ~sense ~n ~a ~lda ~sdim ~wr ~wi ~vs ~ldvs ~rconde ~rcondv =
  lapacke_sgeesx layout jobvs sort (CI.cptr select) sense n (CI.cptr a) lda (CI.cptr sdim) (CI.cptr wr) (CI.cptr wi) (CI.cptr vs) ldvs (CI.cptr rconde) (CI.cptr rcondv)

let dgeesx ~layout ~jobvs ~sort ~select ~sense ~n ~a ~lda ~sdim ~wr ~wi ~vs ~ldvs ~rconde ~rcondv =
  lapacke_dgeesx layout jobvs sort (CI.cptr select) sense n (CI.cptr a) lda (CI.cptr sdim) (CI.cptr wr) (CI.cptr wi) (CI.cptr vs) ldvs (CI.cptr rconde) (CI.cptr rcondv)

let cgeesx ~layout ~jobvs ~sort ~select ~sense ~n ~a ~lda ~sdim ~w ~vs ~ldvs ~rconde ~rcondv =
  lapacke_cgeesx layout jobvs sort (CI.cptr select) sense n (CI.cptr a) lda (CI.cptr sdim) (CI.cptr w) (CI.cptr vs) ldvs (CI.cptr rconde) (CI.cptr rcondv)

let zgeesx ~layout ~jobvs ~sort ~select ~sense ~n ~a ~lda ~sdim ~w ~vs ~ldvs ~rconde ~rcondv =
  lapacke_zgeesx layout jobvs sort (CI.cptr select) sense n (CI.cptr a) lda (CI.cptr sdim) (CI.cptr w) (CI.cptr vs) ldvs (CI.cptr rconde) (CI.cptr rcondv)

let sgeev ~layout ~jobvl ~jobvr ~n ~a ~lda ~wr ~wi ~vl ~ldvl ~vr ~ldvr =
  lapacke_sgeev layout jobvl jobvr n (CI.cptr a) lda (CI.cptr wr) (CI.cptr wi) (CI.cptr vl) ldvl (CI.cptr vr) ldvr

let dgeev ~layout ~jobvl ~jobvr ~n ~a ~lda ~wr ~wi ~vl ~ldvl ~vr ~ldvr =
  lapacke_dgeev layout jobvl jobvr n (CI.cptr a) lda (CI.cptr wr) (CI.cptr wi) (CI.cptr vl) ldvl (CI.cptr vr) ldvr

let cgeev ~layout ~jobvl ~jobvr ~n ~a ~lda ~w ~vl ~ldvl ~vr ~ldvr =
  lapacke_cgeev layout jobvl jobvr n (CI.cptr a) lda (CI.cptr w) (CI.cptr vl) ldvl (CI.cptr vr) ldvr

let zgeev ~layout ~jobvl ~jobvr ~n ~a ~lda ~w ~vl ~ldvl ~vr ~ldvr =
  lapacke_zgeev layout jobvl jobvr n (CI.cptr a) lda (CI.cptr w) (CI.cptr vl) ldvl (CI.cptr vr) ldvr

let sgeevx ~layout ~balanc ~jobvl ~jobvr ~sense ~n ~a ~lda ~wr ~wi ~vl ~ldvl ~vr ~ldvr ~ilo ~ihi ~scale ~abnrm ~rconde ~rcondv =
  lapacke_sgeevx layout balanc jobvl jobvr sense n (CI.cptr a) lda (CI.cptr wr) (CI.cptr wi) (CI.cptr vl) ldvl (CI.cptr vr) ldvr (CI.cptr ilo) (CI.cptr ihi) (CI.cptr scale) (CI.cptr abnrm) (CI.cptr rconde) (CI.cptr rcondv)

let dgeevx ~layout ~balanc ~jobvl ~jobvr ~sense ~n ~a ~lda ~wr ~wi ~vl ~ldvl ~vr ~ldvr ~ilo ~ihi ~scale ~abnrm ~rconde ~rcondv =
  lapacke_dgeevx layout balanc jobvl jobvr sense n (CI.cptr a) lda (CI.cptr wr) (CI.cptr wi) (CI.cptr vl) ldvl (CI.cptr vr) ldvr (CI.cptr ilo) (CI.cptr ihi) (CI.cptr scale) (CI.cptr abnrm) (CI.cptr rconde) (CI.cptr rcondv)

let cgeevx ~layout ~balanc ~jobvl ~jobvr ~sense ~n ~a ~lda ~w ~vl ~ldvl ~vr ~ldvr ~ilo ~ihi ~scale ~abnrm ~rconde ~rcondv =
  lapacke_cgeevx layout balanc jobvl jobvr sense n (CI.cptr a) lda (CI.cptr w) (CI.cptr vl) ldvl (CI.cptr vr) ldvr (CI.cptr ilo) (CI.cptr ihi) (CI.cptr scale) (CI.cptr abnrm) (CI.cptr rconde) (CI.cptr rcondv)

let zgeevx ~layout ~balanc ~jobvl ~jobvr ~sense ~n ~a ~lda ~w ~vl ~ldvl ~vr ~ldvr ~ilo ~ihi ~scale ~abnrm ~rconde ~rcondv =
  lapacke_zgeevx layout balanc jobvl jobvr sense n (CI.cptr a) lda (CI.cptr w) (CI.cptr vl) ldvl (CI.cptr vr) ldvr (CI.cptr ilo) (CI.cptr ihi) (CI.cptr scale) (CI.cptr abnrm) (CI.cptr rconde) (CI.cptr rcondv)

let sgehrd ~layout ~n ~ilo ~ihi ~a ~lda ~tau =
  lapacke_sgehrd layout n ilo ihi (CI.cptr a) lda (CI.cptr tau)

let dgehrd ~layout ~n ~ilo ~ihi ~a ~lda ~tau =
  lapacke_dgehrd layout n ilo ihi (CI.cptr a) lda (CI.cptr tau)

let cgehrd ~layout ~n ~ilo ~ihi ~a ~lda ~tau =
  lapacke_cgehrd layout n ilo ihi (CI.cptr a) lda (CI.cptr tau)

let zgehrd ~layout ~n ~ilo ~ihi ~a ~lda ~tau =
  lapacke_zgehrd layout n ilo ihi (CI.cptr a) lda (CI.cptr tau)

let sgejsv ~layout ~joba ~jobu ~jobv ~jobr ~jobt ~jobp ~m ~n ~a ~lda ~sva ~u ~ldu ~v ~ldv ~stat ~istat =
  lapacke_sgejsv layout joba jobu jobv jobr jobt jobp m n (CI.cptr a) lda (CI.cptr sva) (CI.cptr u) ldu (CI.cptr v) ldv (CI.cptr stat) (CI.cptr istat)

let dgejsv ~layout ~joba ~jobu ~jobv ~jobr ~jobt ~jobp ~m ~n ~a ~lda ~sva ~u ~ldu ~v ~ldv ~stat ~istat =
  lapacke_dgejsv layout joba jobu jobv jobr jobt jobp m n (CI.cptr a) lda (CI.cptr sva) (CI.cptr u) ldu (CI.cptr v) ldv (CI.cptr stat) (CI.cptr istat)

let cgejsv ~layout ~joba ~jobu ~jobv ~jobr ~jobt ~jobp ~m ~n ~a ~lda ~sva ~u ~ldu ~v ~ldv ~stat ~istat =
  lapacke_cgejsv layout joba jobu jobv jobr jobt jobp m n (CI.cptr a) lda (CI.cptr sva) (CI.cptr u) ldu (CI.cptr v) ldv (CI.cptr stat) (CI.cptr istat)

let zgejsv ~layout ~joba ~jobu ~jobv ~jobr ~jobt ~jobp ~m ~n ~a ~lda ~sva ~u ~ldu ~v ~ldv ~stat ~istat =
  lapacke_zgejsv layout joba jobu jobv jobr jobt jobp m n (CI.cptr a) lda (CI.cptr sva) (CI.cptr u) ldu (CI.cptr v) ldv (CI.cptr stat) (CI.cptr istat)

let sgelq2 ~layout ~m ~n ~a ~lda ~tau =
  lapacke_sgelq2 layout m n (CI.cptr a) lda (CI.cptr tau)

let dgelq2 ~layout ~m ~n ~a ~lda ~tau =
  lapacke_dgelq2 layout m n (CI.cptr a) lda (CI.cptr tau)

let cgelq2 ~layout ~m ~n ~a ~lda ~tau =
  lapacke_cgelq2 layout m n (CI.cptr a) lda (CI.cptr tau)

let zgelq2 ~layout ~m ~n ~a ~lda ~tau =
  lapacke_zgelq2 layout m n (CI.cptr a) lda (CI.cptr tau)

let sgelqf ~layout ~m ~n ~a ~lda ~tau =
  lapacke_sgelqf layout m n (CI.cptr a) lda (CI.cptr tau)

let dgelqf ~layout ~m ~n ~a ~lda ~tau =
  lapacke_dgelqf layout m n (CI.cptr a) lda (CI.cptr tau)

let cgelqf ~layout ~m ~n ~a ~lda ~tau =
  lapacke_cgelqf layout m n (CI.cptr a) lda (CI.cptr tau)

let zgelqf ~layout ~m ~n ~a ~lda ~tau =
  lapacke_zgelqf layout m n (CI.cptr a) lda (CI.cptr tau)

let sgels ~layout ~trans ~m ~n ~nrhs ~a ~lda ~b ~ldb =
  lapacke_sgels layout trans m n nrhs (CI.cptr a) lda (CI.cptr b) ldb

let dgels ~layout ~trans ~m ~n ~nrhs ~a ~lda ~b ~ldb =
  lapacke_dgels layout trans m n nrhs (CI.cptr a) lda (CI.cptr b) ldb

let cgels ~layout ~trans ~m ~n ~nrhs ~a ~lda ~b ~ldb =
  lapacke_cgels layout trans m n nrhs (CI.cptr a) lda (CI.cptr b) ldb

let zgels ~layout ~trans ~m ~n ~nrhs ~a ~lda ~b ~ldb =
  lapacke_zgels layout trans m n nrhs (CI.cptr a) lda (CI.cptr b) ldb

let sgelsd ~layout ~m ~n ~nrhs ~a ~lda ~b ~ldb ~s ~rcond ~rank =
  lapacke_sgelsd layout m n nrhs (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr s) rcond (CI.cptr rank)

let dgelsd ~layout ~m ~n ~nrhs ~a ~lda ~b ~ldb ~s ~rcond ~rank =
  lapacke_dgelsd layout m n nrhs (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr s) rcond (CI.cptr rank)

let cgelsd ~layout ~m ~n ~nrhs ~a ~lda ~b ~ldb ~s ~rcond ~rank =
  lapacke_cgelsd layout m n nrhs (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr s) rcond (CI.cptr rank)

let zgelsd ~layout ~m ~n ~nrhs ~a ~lda ~b ~ldb ~s ~rcond ~rank =
  lapacke_zgelsd layout m n nrhs (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr s) rcond (CI.cptr rank)

let sgelss ~layout ~m ~n ~nrhs ~a ~lda ~b ~ldb ~s ~rcond ~rank =
  lapacke_sgelss layout m n nrhs (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr s) rcond (CI.cptr rank)

let dgelss ~layout ~m ~n ~nrhs ~a ~lda ~b ~ldb ~s ~rcond ~rank =
  lapacke_dgelss layout m n nrhs (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr s) rcond (CI.cptr rank)

let cgelss ~layout ~m ~n ~nrhs ~a ~lda ~b ~ldb ~s ~rcond ~rank =
  lapacke_cgelss layout m n nrhs (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr s) rcond (CI.cptr rank)

let zgelss ~layout ~m ~n ~nrhs ~a ~lda ~b ~ldb ~s ~rcond ~rank =
  lapacke_zgelss layout m n nrhs (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr s) rcond (CI.cptr rank)

let sgelsy ~layout ~m ~n ~nrhs ~a ~lda ~b ~ldb ~jpvt ~rcond ~rank =
  lapacke_sgelsy layout m n nrhs (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr jpvt) rcond (CI.cptr rank)

let dgelsy ~layout ~m ~n ~nrhs ~a ~lda ~b ~ldb ~jpvt ~rcond ~rank =
  lapacke_dgelsy layout m n nrhs (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr jpvt) rcond (CI.cptr rank)

let cgelsy ~layout ~m ~n ~nrhs ~a ~lda ~b ~ldb ~jpvt ~rcond ~rank =
  lapacke_cgelsy layout m n nrhs (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr jpvt) rcond (CI.cptr rank)

let zgelsy ~layout ~m ~n ~nrhs ~a ~lda ~b ~ldb ~jpvt ~rcond ~rank =
  lapacke_zgelsy layout m n nrhs (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr jpvt) rcond (CI.cptr rank)

let sgeqlf ~layout ~m ~n ~a ~lda ~tau =
  lapacke_sgeqlf layout m n (CI.cptr a) lda (CI.cptr tau)

let dgeqlf ~layout ~m ~n ~a ~lda ~tau =
  lapacke_dgeqlf layout m n (CI.cptr a) lda (CI.cptr tau)

let cgeqlf ~layout ~m ~n ~a ~lda ~tau =
  lapacke_cgeqlf layout m n (CI.cptr a) lda (CI.cptr tau)

let zgeqlf ~layout ~m ~n ~a ~lda ~tau =
  lapacke_zgeqlf layout m n (CI.cptr a) lda (CI.cptr tau)

let sgeqp3 ~layout ~m ~n ~a ~lda ~jpvt ~tau =
  lapacke_sgeqp3 layout m n (CI.cptr a) lda (CI.cptr jpvt) (CI.cptr tau)

let dgeqp3 ~layout ~m ~n ~a ~lda ~jpvt ~tau =
  lapacke_dgeqp3 layout m n (CI.cptr a) lda (CI.cptr jpvt) (CI.cptr tau)

let cgeqp3 ~layout ~m ~n ~a ~lda ~jpvt ~tau =
  lapacke_cgeqp3 layout m n (CI.cptr a) lda (CI.cptr jpvt) (CI.cptr tau)

let zgeqp3 ~layout ~m ~n ~a ~lda ~jpvt ~tau =
  lapacke_zgeqp3 layout m n (CI.cptr a) lda (CI.cptr jpvt) (CI.cptr tau)

let sgeqr2 ~layout ~m ~n ~a ~lda ~tau =
  lapacke_sgeqr2 layout m n (CI.cptr a) lda (CI.cptr tau)

let dgeqr2 ~layout ~m ~n ~a ~lda ~tau =
  lapacke_dgeqr2 layout m n (CI.cptr a) lda (CI.cptr tau)

let cgeqr2 ~layout ~m ~n ~a ~lda ~tau =
  lapacke_cgeqr2 layout m n (CI.cptr a) lda (CI.cptr tau)

let zgeqr2 ~layout ~m ~n ~a ~lda ~tau =
  lapacke_zgeqr2 layout m n (CI.cptr a) lda (CI.cptr tau)

let sgeqrf ~layout ~m ~n ~a ~lda ~tau =
  lapacke_sgeqrf layout m n (CI.cptr a) lda (CI.cptr tau)

let dgeqrf ~layout ~m ~n ~a ~lda ~tau =
  lapacke_dgeqrf layout m n (CI.cptr a) lda (CI.cptr tau)

let cgeqrf ~layout ~m ~n ~a ~lda ~tau =
  lapacke_cgeqrf layout m n (CI.cptr a) lda (CI.cptr tau)

let zgeqrf ~layout ~m ~n ~a ~lda ~tau =
  lapacke_zgeqrf layout m n (CI.cptr a) lda (CI.cptr tau)

let sgeqrfp ~layout ~m ~n ~a ~lda ~tau =
  lapacke_sgeqrfp layout m n (CI.cptr a) lda (CI.cptr tau)

let dgeqrfp ~layout ~m ~n ~a ~lda ~tau =
  lapacke_dgeqrfp layout m n (CI.cptr a) lda (CI.cptr tau)

let cgeqrfp ~layout ~m ~n ~a ~lda ~tau =
  lapacke_cgeqrfp layout m n (CI.cptr a) lda (CI.cptr tau)

let zgeqrfp ~layout ~m ~n ~a ~lda ~tau =
  lapacke_zgeqrfp layout m n (CI.cptr a) lda (CI.cptr tau)

let sgerfs ~layout ~trans ~n ~nrhs ~a ~lda ~af ~ldaf ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_sgerfs layout trans n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let dgerfs ~layout ~trans ~n ~nrhs ~a ~lda ~af ~ldaf ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_dgerfs layout trans n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let cgerfs ~layout ~trans ~n ~nrhs ~a ~lda ~af ~ldaf ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_cgerfs layout trans n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let zgerfs ~layout ~trans ~n ~nrhs ~a ~lda ~af ~ldaf ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_zgerfs layout trans n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let sgerqf ~layout ~m ~n ~a ~lda ~tau =
  lapacke_sgerqf layout m n (CI.cptr a) lda (CI.cptr tau)

let dgerqf ~layout ~m ~n ~a ~lda ~tau =
  lapacke_dgerqf layout m n (CI.cptr a) lda (CI.cptr tau)

let cgerqf ~layout ~m ~n ~a ~lda ~tau =
  lapacke_cgerqf layout m n (CI.cptr a) lda (CI.cptr tau)

let zgerqf ~layout ~m ~n ~a ~lda ~tau =
  lapacke_zgerqf layout m n (CI.cptr a) lda (CI.cptr tau)

let sgesdd ~layout ~jobz ~m ~n ~a ~lda ~s ~u ~ldu ~vt ~ldvt =
  lapacke_sgesdd layout jobz m n (CI.cptr a) lda (CI.cptr s) (CI.cptr u) ldu (CI.cptr vt) ldvt

let dgesdd ~layout ~jobz ~m ~n ~a ~lda ~s ~u ~ldu ~vt ~ldvt =
  lapacke_dgesdd layout jobz m n (CI.cptr a) lda (CI.cptr s) (CI.cptr u) ldu (CI.cptr vt) ldvt

let cgesdd ~layout ~jobz ~m ~n ~a ~lda ~s ~u ~ldu ~vt ~ldvt =
  lapacke_cgesdd layout jobz m n (CI.cptr a) lda (CI.cptr s) (CI.cptr u) ldu (CI.cptr vt) ldvt

let zgesdd ~layout ~jobz ~m ~n ~a ~lda ~s ~u ~ldu ~vt ~ldvt =
  lapacke_zgesdd layout jobz m n (CI.cptr a) lda (CI.cptr s) (CI.cptr u) ldu (CI.cptr vt) ldvt

let sgesv ~layout ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_sgesv layout n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let dgesv ~layout ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_dgesv layout n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let cgesv ~layout ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_cgesv layout n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let zgesv ~layout ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_zgesv layout n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let dsgesv ~layout ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb ~x ~ldx ~iter =
  lapacke_dsgesv layout n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr iter)

let zcgesv ~layout ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb ~x ~ldx ~iter =
  lapacke_zcgesv layout n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr iter)

let sgesvd ~layout ~jobu ~jobvt ~m ~n ~a ~lda ~s ~u ~ldu ~vt ~ldvt ~superb =
  lapacke_sgesvd layout jobu jobvt m n (CI.cptr a) lda (CI.cptr s) (CI.cptr u) ldu (CI.cptr vt) ldvt (CI.cptr superb)

let dgesvd ~layout ~jobu ~jobvt ~m ~n ~a ~lda ~s ~u ~ldu ~vt ~ldvt ~superb =
  lapacke_dgesvd layout jobu jobvt m n (CI.cptr a) lda (CI.cptr s) (CI.cptr u) ldu (CI.cptr vt) ldvt (CI.cptr superb)

let cgesvd ~layout ~jobu ~jobvt ~m ~n ~a ~lda ~s ~u ~ldu ~vt ~ldvt ~superb =
  lapacke_cgesvd layout jobu jobvt m n (CI.cptr a) lda (CI.cptr s) (CI.cptr u) ldu (CI.cptr vt) ldvt (CI.cptr superb)

let zgesvd ~layout ~jobu ~jobvt ~m ~n ~a ~lda ~s ~u ~ldu ~vt ~ldvt ~superb =
  lapacke_zgesvd layout jobu jobvt m n (CI.cptr a) lda (CI.cptr s) (CI.cptr u) ldu (CI.cptr vt) ldvt (CI.cptr superb)

let sgesvdx ~layout ~jobu ~jobvt ~range ~m ~n ~a ~lda ~vl ~vu ~il ~iu ~ns ~s ~u ~ldu ~vt ~ldvt ~superb =
  lapacke_sgesvdx layout jobu jobvt range m n (CI.cptr a) lda vl vu il iu (CI.cptr ns) (CI.cptr s) (CI.cptr u) ldu (CI.cptr vt) ldvt (CI.cptr superb)

let dgesvdx ~layout ~jobu ~jobvt ~range ~m ~n ~a ~lda ~vl ~vu ~il ~iu ~ns ~s ~u ~ldu ~vt ~ldvt ~superb =
  lapacke_dgesvdx layout jobu jobvt range m n (CI.cptr a) lda vl vu il iu (CI.cptr ns) (CI.cptr s) (CI.cptr u) ldu (CI.cptr vt) ldvt (CI.cptr superb)

let cgesvdx ~layout ~jobu ~jobvt ~range ~m ~n ~a ~lda ~vl ~vu ~il ~iu ~ns ~s ~u ~ldu ~vt ~ldvt ~superb =
  lapacke_cgesvdx layout jobu jobvt range m n (CI.cptr a) lda vl vu il iu (CI.cptr ns) (CI.cptr s) (CI.cptr u) ldu (CI.cptr vt) ldvt (CI.cptr superb)

let zgesvdx ~layout ~jobu ~jobvt ~range ~m ~n ~a ~lda ~vl ~vu ~il ~iu ~ns ~s ~u ~ldu ~vt ~ldvt ~superb =
  lapacke_zgesvdx layout jobu jobvt range m n (CI.cptr a) lda vl vu il iu (CI.cptr ns) (CI.cptr s) (CI.cptr u) ldu (CI.cptr vt) ldvt (CI.cptr superb)

let sgesvj ~layout ~joba ~jobu ~jobv ~m ~n ~a ~lda ~sva ~mv ~v ~ldv ~stat =
  lapacke_sgesvj layout joba jobu jobv m n (CI.cptr a) lda (CI.cptr sva) mv (CI.cptr v) ldv (CI.cptr stat)

let dgesvj ~layout ~joba ~jobu ~jobv ~m ~n ~a ~lda ~sva ~mv ~v ~ldv ~stat =
  lapacke_dgesvj layout joba jobu jobv m n (CI.cptr a) lda (CI.cptr sva) mv (CI.cptr v) ldv (CI.cptr stat)

let cgesvj ~layout ~joba ~jobu ~jobv ~m ~n ~a ~lda ~sva ~mv ~v ~ldv ~stat =
  lapacke_cgesvj layout joba jobu jobv m n (CI.cptr a) lda (CI.cptr sva) mv (CI.cptr v) ldv (CI.cptr stat)

let zgesvj ~layout ~joba ~jobu ~jobv ~m ~n ~a ~lda ~sva ~mv ~v ~ldv ~stat =
  lapacke_zgesvj layout joba jobu jobv m n (CI.cptr a) lda (CI.cptr sva) mv (CI.cptr v) ldv (CI.cptr stat)

let sgesvx ~layout ~fact ~trans ~n ~nrhs ~a ~lda ~af ~ldaf ~ipiv ~equed ~r ~c ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr ~rpivot =
  lapacke_sgesvx layout fact trans n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr ipiv) (CI.cptr equed) (CI.cptr r) (CI.cptr c) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr) (CI.cptr rpivot)

let dgesvx ~layout ~fact ~trans ~n ~nrhs ~a ~lda ~af ~ldaf ~ipiv ~equed ~r ~c ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr ~rpivot =
  lapacke_dgesvx layout fact trans n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr ipiv) (CI.cptr equed) (CI.cptr r) (CI.cptr c) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr) (CI.cptr rpivot)

let cgesvx ~layout ~fact ~trans ~n ~nrhs ~a ~lda ~af ~ldaf ~ipiv ~equed ~r ~c ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr ~rpivot =
  lapacke_cgesvx layout fact trans n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr ipiv) (CI.cptr equed) (CI.cptr r) (CI.cptr c) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr) (CI.cptr rpivot)

let zgesvx ~layout ~fact ~trans ~n ~nrhs ~a ~lda ~af ~ldaf ~ipiv ~equed ~r ~c ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr ~rpivot =
  lapacke_zgesvx layout fact trans n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr ipiv) (CI.cptr equed) (CI.cptr r) (CI.cptr c) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr) (CI.cptr rpivot)

let sgetf2 ~layout ~m ~n ~a ~lda ~ipiv =
  lapacke_sgetf2 layout m n (CI.cptr a) lda (CI.cptr ipiv)

let dgetf2 ~layout ~m ~n ~a ~lda ~ipiv =
  lapacke_dgetf2 layout m n (CI.cptr a) lda (CI.cptr ipiv)

let cgetf2 ~layout ~m ~n ~a ~lda ~ipiv =
  lapacke_cgetf2 layout m n (CI.cptr a) lda (CI.cptr ipiv)

let zgetf2 ~layout ~m ~n ~a ~lda ~ipiv =
  lapacke_zgetf2 layout m n (CI.cptr a) lda (CI.cptr ipiv)

let sgetrf ~layout ~m ~n ~a ~lda ~ipiv =
  lapacke_sgetrf layout m n (CI.cptr a) lda (CI.cptr ipiv)

let dgetrf ~layout ~m ~n ~a ~lda ~ipiv =
  lapacke_dgetrf layout m n (CI.cptr a) lda (CI.cptr ipiv)

let cgetrf ~layout ~m ~n ~a ~lda ~ipiv =
  lapacke_cgetrf layout m n (CI.cptr a) lda (CI.cptr ipiv)

let zgetrf ~layout ~m ~n ~a ~lda ~ipiv =
  lapacke_zgetrf layout m n (CI.cptr a) lda (CI.cptr ipiv)

let sgetrf2 ~layout ~m ~n ~a ~lda ~ipiv =
  lapacke_sgetrf2 layout m n (CI.cptr a) lda (CI.cptr ipiv)

let dgetrf2 ~layout ~m ~n ~a ~lda ~ipiv =
  lapacke_dgetrf2 layout m n (CI.cptr a) lda (CI.cptr ipiv)

let cgetrf2 ~layout ~m ~n ~a ~lda ~ipiv =
  lapacke_cgetrf2 layout m n (CI.cptr a) lda (CI.cptr ipiv)

let zgetrf2 ~layout ~m ~n ~a ~lda ~ipiv =
  lapacke_zgetrf2 layout m n (CI.cptr a) lda (CI.cptr ipiv)

let sgetri ~layout ~n ~a ~lda ~ipiv =
  lapacke_sgetri layout n (CI.cptr a) lda (CI.cptr ipiv)

let dgetri ~layout ~n ~a ~lda ~ipiv =
  lapacke_dgetri layout n (CI.cptr a) lda (CI.cptr ipiv)

let cgetri ~layout ~n ~a ~lda ~ipiv =
  lapacke_cgetri layout n (CI.cptr a) lda (CI.cptr ipiv)

let zgetri ~layout ~n ~a ~lda ~ipiv =
  lapacke_zgetri layout n (CI.cptr a) lda (CI.cptr ipiv)

let sgetrs ~layout ~trans ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_sgetrs layout trans n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let dgetrs ~layout ~trans ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_dgetrs layout trans n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let cgetrs ~layout ~trans ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_cgetrs layout trans n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let zgetrs ~layout ~trans ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_zgetrs layout trans n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let sggbak ~layout ~job ~side ~n ~ilo ~ihi ~lscale ~rscale ~m ~v ~ldv =
  lapacke_sggbak layout job side n ilo ihi (CI.cptr lscale) (CI.cptr rscale) m (CI.cptr v) ldv

let dggbak ~layout ~job ~side ~n ~ilo ~ihi ~lscale ~rscale ~m ~v ~ldv =
  lapacke_dggbak layout job side n ilo ihi (CI.cptr lscale) (CI.cptr rscale) m (CI.cptr v) ldv

let cggbak ~layout ~job ~side ~n ~ilo ~ihi ~lscale ~rscale ~m ~v ~ldv =
  lapacke_cggbak layout job side n ilo ihi (CI.cptr lscale) (CI.cptr rscale) m (CI.cptr v) ldv

let zggbak ~layout ~job ~side ~n ~ilo ~ihi ~lscale ~rscale ~m ~v ~ldv =
  lapacke_zggbak layout job side n ilo ihi (CI.cptr lscale) (CI.cptr rscale) m (CI.cptr v) ldv

let sggbal ~layout ~job ~n ~a ~lda ~b ~ldb ~ilo ~ihi ~lscale ~rscale =
  lapacke_sggbal layout job n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr ilo) (CI.cptr ihi) (CI.cptr lscale) (CI.cptr rscale)

let dggbal ~layout ~job ~n ~a ~lda ~b ~ldb ~ilo ~ihi ~lscale ~rscale =
  lapacke_dggbal layout job n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr ilo) (CI.cptr ihi) (CI.cptr lscale) (CI.cptr rscale)

let cggbal ~layout ~job ~n ~a ~lda ~b ~ldb ~ilo ~ihi ~lscale ~rscale =
  lapacke_cggbal layout job n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr ilo) (CI.cptr ihi) (CI.cptr lscale) (CI.cptr rscale)

let zggbal ~layout ~job ~n ~a ~lda ~b ~ldb ~ilo ~ihi ~lscale ~rscale =
  lapacke_zggbal layout job n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr ilo) (CI.cptr ihi) (CI.cptr lscale) (CI.cptr rscale)

let sgges ~layout ~jobvsl ~jobvsr ~sort ~selctg ~n ~a ~lda ~b ~ldb ~sdim ~alphar ~alphai ~beta ~vsl ~ldvsl ~vsr ~ldvsr =
  lapacke_sgges layout jobvsl jobvsr sort (CI.cptr selctg) n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr sdim) (CI.cptr alphar) (CI.cptr alphai) (CI.cptr beta) (CI.cptr vsl) ldvsl (CI.cptr vsr) ldvsr

let dgges ~layout ~jobvsl ~jobvsr ~sort ~selctg ~n ~a ~lda ~b ~ldb ~sdim ~alphar ~alphai ~beta ~vsl ~ldvsl ~vsr ~ldvsr =
  lapacke_dgges layout jobvsl jobvsr sort (CI.cptr selctg) n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr sdim) (CI.cptr alphar) (CI.cptr alphai) (CI.cptr beta) (CI.cptr vsl) ldvsl (CI.cptr vsr) ldvsr

let cgges ~layout ~jobvsl ~jobvsr ~sort ~selctg ~n ~a ~lda ~b ~ldb ~sdim ~alpha ~beta ~vsl ~ldvsl ~vsr ~ldvsr =
  lapacke_cgges layout jobvsl jobvsr sort (CI.cptr selctg) n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr sdim) (CI.cptr alpha) (CI.cptr beta) (CI.cptr vsl) ldvsl (CI.cptr vsr) ldvsr

let zgges ~layout ~jobvsl ~jobvsr ~sort ~selctg ~n ~a ~lda ~b ~ldb ~sdim ~alpha ~beta ~vsl ~ldvsl ~vsr ~ldvsr =
  lapacke_zgges layout jobvsl jobvsr sort (CI.cptr selctg) n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr sdim) (CI.cptr alpha) (CI.cptr beta) (CI.cptr vsl) ldvsl (CI.cptr vsr) ldvsr

let sgges3 ~layout ~jobvsl ~jobvsr ~sort ~selctg ~n ~a ~lda ~b ~ldb ~sdim ~alphar ~alphai ~beta ~vsl ~ldvsl ~vsr ~ldvsr =
  lapacke_sgges3 layout jobvsl jobvsr sort (CI.cptr selctg) n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr sdim) (CI.cptr alphar) (CI.cptr alphai) (CI.cptr beta) (CI.cptr vsl) ldvsl (CI.cptr vsr) ldvsr

let dgges3 ~layout ~jobvsl ~jobvsr ~sort ~selctg ~n ~a ~lda ~b ~ldb ~sdim ~alphar ~alphai ~beta ~vsl ~ldvsl ~vsr ~ldvsr =
  lapacke_dgges3 layout jobvsl jobvsr sort (CI.cptr selctg) n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr sdim) (CI.cptr alphar) (CI.cptr alphai) (CI.cptr beta) (CI.cptr vsl) ldvsl (CI.cptr vsr) ldvsr

let cgges3 ~layout ~jobvsl ~jobvsr ~sort ~selctg ~n ~a ~lda ~b ~ldb ~sdim ~alpha ~beta ~vsl ~ldvsl ~vsr ~ldvsr =
  lapacke_cgges3 layout jobvsl jobvsr sort (CI.cptr selctg) n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr sdim) (CI.cptr alpha) (CI.cptr beta) (CI.cptr vsl) ldvsl (CI.cptr vsr) ldvsr

let zgges3 ~layout ~jobvsl ~jobvsr ~sort ~selctg ~n ~a ~lda ~b ~ldb ~sdim ~alpha ~beta ~vsl ~ldvsl ~vsr ~ldvsr =
  lapacke_zgges3 layout jobvsl jobvsr sort (CI.cptr selctg) n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr sdim) (CI.cptr alpha) (CI.cptr beta) (CI.cptr vsl) ldvsl (CI.cptr vsr) ldvsr

let sggesx ~layout ~jobvsl ~jobvsr ~sort ~selctg ~sense ~n ~a ~lda ~b ~ldb ~sdim ~alphar ~alphai ~beta ~vsl ~ldvsl ~vsr ~ldvsr ~rconde ~rcondv =
  lapacke_sggesx layout jobvsl jobvsr sort (CI.cptr selctg) sense n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr sdim) (CI.cptr alphar) (CI.cptr alphai) (CI.cptr beta) (CI.cptr vsl) ldvsl (CI.cptr vsr) ldvsr (CI.cptr rconde) (CI.cptr rcondv)

let dggesx ~layout ~jobvsl ~jobvsr ~sort ~selctg ~sense ~n ~a ~lda ~b ~ldb ~sdim ~alphar ~alphai ~beta ~vsl ~ldvsl ~vsr ~ldvsr ~rconde ~rcondv =
  lapacke_dggesx layout jobvsl jobvsr sort (CI.cptr selctg) sense n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr sdim) (CI.cptr alphar) (CI.cptr alphai) (CI.cptr beta) (CI.cptr vsl) ldvsl (CI.cptr vsr) ldvsr (CI.cptr rconde) (CI.cptr rcondv)

let cggesx ~layout ~jobvsl ~jobvsr ~sort ~selctg ~sense ~n ~a ~lda ~b ~ldb ~sdim ~alpha ~beta ~vsl ~ldvsl ~vsr ~ldvsr ~rconde ~rcondv =
  lapacke_cggesx layout jobvsl jobvsr sort (CI.cptr selctg) sense n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr sdim) (CI.cptr alpha) (CI.cptr beta) (CI.cptr vsl) ldvsl (CI.cptr vsr) ldvsr (CI.cptr rconde) (CI.cptr rcondv)

let zggesx ~layout ~jobvsl ~jobvsr ~sort ~selctg ~sense ~n ~a ~lda ~b ~ldb ~sdim ~alpha ~beta ~vsl ~ldvsl ~vsr ~ldvsr ~rconde ~rcondv =
  lapacke_zggesx layout jobvsl jobvsr sort (CI.cptr selctg) sense n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr sdim) (CI.cptr alpha) (CI.cptr beta) (CI.cptr vsl) ldvsl (CI.cptr vsr) ldvsr (CI.cptr rconde) (CI.cptr rcondv)

let sggev ~layout ~jobvl ~jobvr ~n ~a ~lda ~b ~ldb ~alphar ~alphai ~beta ~vl ~ldvl ~vr ~ldvr =
  lapacke_sggev layout jobvl jobvr n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr alphar) (CI.cptr alphai) (CI.cptr beta) (CI.cptr vl) ldvl (CI.cptr vr) ldvr

let dggev ~layout ~jobvl ~jobvr ~n ~a ~lda ~b ~ldb ~alphar ~alphai ~beta ~vl ~ldvl ~vr ~ldvr =
  lapacke_dggev layout jobvl jobvr n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr alphar) (CI.cptr alphai) (CI.cptr beta) (CI.cptr vl) ldvl (CI.cptr vr) ldvr

let cggev ~layout ~jobvl ~jobvr ~n ~a ~lda ~b ~ldb ~alpha ~beta ~vl ~ldvl ~vr ~ldvr =
  lapacke_cggev layout jobvl jobvr n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr alpha) (CI.cptr beta) (CI.cptr vl) ldvl (CI.cptr vr) ldvr

let zggev ~layout ~jobvl ~jobvr ~n ~a ~lda ~b ~ldb ~alpha ~beta ~vl ~ldvl ~vr ~ldvr =
  lapacke_zggev layout jobvl jobvr n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr alpha) (CI.cptr beta) (CI.cptr vl) ldvl (CI.cptr vr) ldvr

let sggev3 ~layout ~jobvl ~jobvr ~n ~a ~lda ~b ~ldb ~alphar ~alphai ~beta ~vl ~ldvl ~vr ~ldvr =
  lapacke_sggev3 layout jobvl jobvr n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr alphar) (CI.cptr alphai) (CI.cptr beta) (CI.cptr vl) ldvl (CI.cptr vr) ldvr

let dggev3 ~layout ~jobvl ~jobvr ~n ~a ~lda ~b ~ldb ~alphar ~alphai ~beta ~vl ~ldvl ~vr ~ldvr =
  lapacke_dggev3 layout jobvl jobvr n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr alphar) (CI.cptr alphai) (CI.cptr beta) (CI.cptr vl) ldvl (CI.cptr vr) ldvr

let cggev3 ~layout ~jobvl ~jobvr ~n ~a ~lda ~b ~ldb ~alpha ~beta ~vl ~ldvl ~vr ~ldvr =
  lapacke_cggev3 layout jobvl jobvr n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr alpha) (CI.cptr beta) (CI.cptr vl) ldvl (CI.cptr vr) ldvr

let zggev3 ~layout ~jobvl ~jobvr ~n ~a ~lda ~b ~ldb ~alpha ~beta ~vl ~ldvl ~vr ~ldvr =
  lapacke_zggev3 layout jobvl jobvr n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr alpha) (CI.cptr beta) (CI.cptr vl) ldvl (CI.cptr vr) ldvr

let sggevx ~layout ~balanc ~jobvl ~jobvr ~sense ~n ~a ~lda ~b ~ldb ~alphar ~alphai ~beta ~vl ~ldvl ~vr ~ldvr ~ilo ~ihi ~lscale ~rscale ~abnrm ~bbnrm ~rconde ~rcondv =
  lapacke_sggevx layout balanc jobvl jobvr sense n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr alphar) (CI.cptr alphai) (CI.cptr beta) (CI.cptr vl) ldvl (CI.cptr vr) ldvr (CI.cptr ilo) (CI.cptr ihi) (CI.cptr lscale) (CI.cptr rscale) (CI.cptr abnrm) (CI.cptr bbnrm) (CI.cptr rconde) (CI.cptr rcondv)

let dggevx ~layout ~balanc ~jobvl ~jobvr ~sense ~n ~a ~lda ~b ~ldb ~alphar ~alphai ~beta ~vl ~ldvl ~vr ~ldvr ~ilo ~ihi ~lscale ~rscale ~abnrm ~bbnrm ~rconde ~rcondv =
  lapacke_dggevx layout balanc jobvl jobvr sense n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr alphar) (CI.cptr alphai) (CI.cptr beta) (CI.cptr vl) ldvl (CI.cptr vr) ldvr (CI.cptr ilo) (CI.cptr ihi) (CI.cptr lscale) (CI.cptr rscale) (CI.cptr abnrm) (CI.cptr bbnrm) (CI.cptr rconde) (CI.cptr rcondv)

let cggevx ~layout ~balanc ~jobvl ~jobvr ~sense ~n ~a ~lda ~b ~ldb ~alpha ~beta ~vl ~ldvl ~vr ~ldvr ~ilo ~ihi ~lscale ~rscale ~abnrm ~bbnrm ~rconde ~rcondv =
  lapacke_cggevx layout balanc jobvl jobvr sense n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr alpha) (CI.cptr beta) (CI.cptr vl) ldvl (CI.cptr vr) ldvr (CI.cptr ilo) (CI.cptr ihi) (CI.cptr lscale) (CI.cptr rscale) (CI.cptr abnrm) (CI.cptr bbnrm) (CI.cptr rconde) (CI.cptr rcondv)

let zggevx ~layout ~balanc ~jobvl ~jobvr ~sense ~n ~a ~lda ~b ~ldb ~alpha ~beta ~vl ~ldvl ~vr ~ldvr ~ilo ~ihi ~lscale ~rscale ~abnrm ~bbnrm ~rconde ~rcondv =
  lapacke_zggevx layout balanc jobvl jobvr sense n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr alpha) (CI.cptr beta) (CI.cptr vl) ldvl (CI.cptr vr) ldvr (CI.cptr ilo) (CI.cptr ihi) (CI.cptr lscale) (CI.cptr rscale) (CI.cptr abnrm) (CI.cptr bbnrm) (CI.cptr rconde) (CI.cptr rcondv)

let sggglm ~layout ~n ~m ~p ~a ~lda ~b ~ldb ~d ~x ~y =
  lapacke_sggglm layout n m p (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr d) (CI.cptr x) (CI.cptr y)

let dggglm ~layout ~n ~m ~p ~a ~lda ~b ~ldb ~d ~x ~y =
  lapacke_dggglm layout n m p (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr d) (CI.cptr x) (CI.cptr y)

let cggglm ~layout ~n ~m ~p ~a ~lda ~b ~ldb ~d ~x ~y =
  lapacke_cggglm layout n m p (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr d) (CI.cptr x) (CI.cptr y)

let zggglm ~layout ~n ~m ~p ~a ~lda ~b ~ldb ~d ~x ~y =
  lapacke_zggglm layout n m p (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr d) (CI.cptr x) (CI.cptr y)

let sgghrd ~layout ~compq ~compz ~n ~ilo ~ihi ~a ~lda ~b ~ldb ~q ~ldq ~z ~ldz =
  lapacke_sgghrd layout compq compz n ilo ihi (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr q) ldq (CI.cptr z) ldz

let dgghrd ~layout ~compq ~compz ~n ~ilo ~ihi ~a ~lda ~b ~ldb ~q ~ldq ~z ~ldz =
  lapacke_dgghrd layout compq compz n ilo ihi (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr q) ldq (CI.cptr z) ldz

let cgghrd ~layout ~compq ~compz ~n ~ilo ~ihi ~a ~lda ~b ~ldb ~q ~ldq ~z ~ldz =
  lapacke_cgghrd layout compq compz n ilo ihi (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr q) ldq (CI.cptr z) ldz

let zgghrd ~layout ~compq ~compz ~n ~ilo ~ihi ~a ~lda ~b ~ldb ~q ~ldq ~z ~ldz =
  lapacke_zgghrd layout compq compz n ilo ihi (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr q) ldq (CI.cptr z) ldz

let sgghd3 ~layout ~compq ~compz ~n ~ilo ~ihi ~a ~lda ~b ~ldb ~q ~ldq ~z ~ldz =
  lapacke_sgghd3 layout compq compz n ilo ihi (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr q) ldq (CI.cptr z) ldz

let dgghd3 ~layout ~compq ~compz ~n ~ilo ~ihi ~a ~lda ~b ~ldb ~q ~ldq ~z ~ldz =
  lapacke_dgghd3 layout compq compz n ilo ihi (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr q) ldq (CI.cptr z) ldz

let cgghd3 ~layout ~compq ~compz ~n ~ilo ~ihi ~a ~lda ~b ~ldb ~q ~ldq ~z ~ldz =
  lapacke_cgghd3 layout compq compz n ilo ihi (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr q) ldq (CI.cptr z) ldz

let zgghd3 ~layout ~compq ~compz ~n ~ilo ~ihi ~a ~lda ~b ~ldb ~q ~ldq ~z ~ldz =
  lapacke_zgghd3 layout compq compz n ilo ihi (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr q) ldq (CI.cptr z) ldz

let sgglse ~layout ~m ~n ~p ~a ~lda ~b ~ldb ~c ~d ~x =
  lapacke_sgglse layout m n p (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr c) (CI.cptr d) (CI.cptr x)

let dgglse ~layout ~m ~n ~p ~a ~lda ~b ~ldb ~c ~d ~x =
  lapacke_dgglse layout m n p (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr c) (CI.cptr d) (CI.cptr x)

let cgglse ~layout ~m ~n ~p ~a ~lda ~b ~ldb ~c ~d ~x =
  lapacke_cgglse layout m n p (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr c) (CI.cptr d) (CI.cptr x)

let zgglse ~layout ~m ~n ~p ~a ~lda ~b ~ldb ~c ~d ~x =
  lapacke_zgglse layout m n p (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr c) (CI.cptr d) (CI.cptr x)

let sggqrf ~layout ~n ~m ~p ~a ~lda ~taua ~b ~ldb ~taub =
  lapacke_sggqrf layout n m p (CI.cptr a) lda (CI.cptr taua) (CI.cptr b) ldb (CI.cptr taub)

let dggqrf ~layout ~n ~m ~p ~a ~lda ~taua ~b ~ldb ~taub =
  lapacke_dggqrf layout n m p (CI.cptr a) lda (CI.cptr taua) (CI.cptr b) ldb (CI.cptr taub)

let cggqrf ~layout ~n ~m ~p ~a ~lda ~taua ~b ~ldb ~taub =
  lapacke_cggqrf layout n m p (CI.cptr a) lda (CI.cptr taua) (CI.cptr b) ldb (CI.cptr taub)

let zggqrf ~layout ~n ~m ~p ~a ~lda ~taua ~b ~ldb ~taub =
  lapacke_zggqrf layout n m p (CI.cptr a) lda (CI.cptr taua) (CI.cptr b) ldb (CI.cptr taub)

let sggrqf ~layout ~m ~p ~n ~a ~lda ~taua ~b ~ldb ~taub =
  lapacke_sggrqf layout m p n (CI.cptr a) lda (CI.cptr taua) (CI.cptr b) ldb (CI.cptr taub)

let dggrqf ~layout ~m ~p ~n ~a ~lda ~taua ~b ~ldb ~taub =
  lapacke_dggrqf layout m p n (CI.cptr a) lda (CI.cptr taua) (CI.cptr b) ldb (CI.cptr taub)

let cggrqf ~layout ~m ~p ~n ~a ~lda ~taua ~b ~ldb ~taub =
  lapacke_cggrqf layout m p n (CI.cptr a) lda (CI.cptr taua) (CI.cptr b) ldb (CI.cptr taub)

let zggrqf ~layout ~m ~p ~n ~a ~lda ~taua ~b ~ldb ~taub =
  lapacke_zggrqf layout m p n (CI.cptr a) lda (CI.cptr taua) (CI.cptr b) ldb (CI.cptr taub)

let sggsvd3 ~layout ~jobu ~jobv ~jobq ~m ~n ~p ~k ~l ~a ~lda ~b ~ldb ~alpha ~beta ~u ~ldu ~v ~ldv ~q ~ldq ~iwork =
  lapacke_sggsvd3 layout jobu jobv jobq m n p (CI.cptr k) (CI.cptr l) (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr alpha) (CI.cptr beta) (CI.cptr u) ldu (CI.cptr v) ldv (CI.cptr q) ldq (CI.cptr iwork)

let dggsvd3 ~layout ~jobu ~jobv ~jobq ~m ~n ~p ~k ~l ~a ~lda ~b ~ldb ~alpha ~beta ~u ~ldu ~v ~ldv ~q ~ldq ~iwork =
  lapacke_dggsvd3 layout jobu jobv jobq m n p (CI.cptr k) (CI.cptr l) (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr alpha) (CI.cptr beta) (CI.cptr u) ldu (CI.cptr v) ldv (CI.cptr q) ldq (CI.cptr iwork)

let cggsvd3 ~layout ~jobu ~jobv ~jobq ~m ~n ~p ~k ~l ~a ~lda ~b ~ldb ~alpha ~beta ~u ~ldu ~v ~ldv ~q ~ldq ~iwork =
  lapacke_cggsvd3 layout jobu jobv jobq m n p (CI.cptr k) (CI.cptr l) (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr alpha) (CI.cptr beta) (CI.cptr u) ldu (CI.cptr v) ldv (CI.cptr q) ldq (CI.cptr iwork)

let zggsvd3 ~layout ~jobu ~jobv ~jobq ~m ~n ~p ~k ~l ~a ~lda ~b ~ldb ~alpha ~beta ~u ~ldu ~v ~ldv ~q ~ldq ~iwork =
  lapacke_zggsvd3 layout jobu jobv jobq m n p (CI.cptr k) (CI.cptr l) (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr alpha) (CI.cptr beta) (CI.cptr u) ldu (CI.cptr v) ldv (CI.cptr q) ldq (CI.cptr iwork)

let sggsvp3 ~layout ~jobu ~jobv ~jobq ~m ~p ~n ~a ~lda ~b ~ldb ~tola ~tolb ~k ~l ~u ~ldu ~v ~ldv ~q ~ldq =
  lapacke_sggsvp3 layout jobu jobv jobq m p n (CI.cptr a) lda (CI.cptr b) ldb tola tolb (CI.cptr k) (CI.cptr l) (CI.cptr u) ldu (CI.cptr v) ldv (CI.cptr q) ldq

let dggsvp3 ~layout ~jobu ~jobv ~jobq ~m ~p ~n ~a ~lda ~b ~ldb ~tola ~tolb ~k ~l ~u ~ldu ~v ~ldv ~q ~ldq =
  lapacke_dggsvp3 layout jobu jobv jobq m p n (CI.cptr a) lda (CI.cptr b) ldb tola tolb (CI.cptr k) (CI.cptr l) (CI.cptr u) ldu (CI.cptr v) ldv (CI.cptr q) ldq

let cggsvp3 ~layout ~jobu ~jobv ~jobq ~m ~p ~n ~a ~lda ~b ~ldb ~tola ~tolb ~k ~l ~u ~ldu ~v ~ldv ~q ~ldq =
  lapacke_cggsvp3 layout jobu jobv jobq m p n (CI.cptr a) lda (CI.cptr b) ldb tola tolb (CI.cptr k) (CI.cptr l) (CI.cptr u) ldu (CI.cptr v) ldv (CI.cptr q) ldq

let zggsvp3 ~layout ~jobu ~jobv ~jobq ~m ~p ~n ~a ~lda ~b ~ldb ~tola ~tolb ~k ~l ~u ~ldu ~v ~ldv ~q ~ldq =
  lapacke_zggsvp3 layout jobu jobv jobq m p n (CI.cptr a) lda (CI.cptr b) ldb tola tolb (CI.cptr k) (CI.cptr l) (CI.cptr u) ldu (CI.cptr v) ldv (CI.cptr q) ldq

let sgtcon ~norm ~n ~dl ~d ~du ~du2 ~ipiv ~anorm ~rcond =
  lapacke_sgtcon norm n (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr du2) (CI.cptr ipiv) anorm (CI.cptr rcond)

let dgtcon ~norm ~n ~dl ~d ~du ~du2 ~ipiv ~anorm ~rcond =
  lapacke_dgtcon norm n (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr du2) (CI.cptr ipiv) anorm (CI.cptr rcond)

let cgtcon ~norm ~n ~dl ~d ~du ~du2 ~ipiv ~anorm ~rcond =
  lapacke_cgtcon norm n (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr du2) (CI.cptr ipiv) anorm (CI.cptr rcond)

let zgtcon ~norm ~n ~dl ~d ~du ~du2 ~ipiv ~anorm ~rcond =
  lapacke_zgtcon norm n (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr du2) (CI.cptr ipiv) anorm (CI.cptr rcond)

let sgtrfs ~layout ~trans ~n ~nrhs ~dl ~d ~du ~dlf ~df ~duf ~du2 ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_sgtrfs layout trans n nrhs (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr dlf) (CI.cptr df) (CI.cptr duf) (CI.cptr du2) (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let dgtrfs ~layout ~trans ~n ~nrhs ~dl ~d ~du ~dlf ~df ~duf ~du2 ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_dgtrfs layout trans n nrhs (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr dlf) (CI.cptr df) (CI.cptr duf) (CI.cptr du2) (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let cgtrfs ~layout ~trans ~n ~nrhs ~dl ~d ~du ~dlf ~df ~duf ~du2 ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_cgtrfs layout trans n nrhs (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr dlf) (CI.cptr df) (CI.cptr duf) (CI.cptr du2) (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let zgtrfs ~layout ~trans ~n ~nrhs ~dl ~d ~du ~dlf ~df ~duf ~du2 ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_zgtrfs layout trans n nrhs (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr dlf) (CI.cptr df) (CI.cptr duf) (CI.cptr du2) (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let sgtsv ~layout ~n ~nrhs ~dl ~d ~du ~b ~ldb =
  lapacke_sgtsv layout n nrhs (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr b) ldb

let dgtsv ~layout ~n ~nrhs ~dl ~d ~du ~b ~ldb =
  lapacke_dgtsv layout n nrhs (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr b) ldb

let cgtsv ~layout ~n ~nrhs ~dl ~d ~du ~b ~ldb =
  lapacke_cgtsv layout n nrhs (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr b) ldb

let zgtsv ~layout ~n ~nrhs ~dl ~d ~du ~b ~ldb =
  lapacke_zgtsv layout n nrhs (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr b) ldb

let sgtsvx ~layout ~fact ~trans ~n ~nrhs ~dl ~d ~du ~dlf ~df ~duf ~du2 ~ipiv ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_sgtsvx layout fact trans n nrhs (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr dlf) (CI.cptr df) (CI.cptr duf) (CI.cptr du2) (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let dgtsvx ~layout ~fact ~trans ~n ~nrhs ~dl ~d ~du ~dlf ~df ~duf ~du2 ~ipiv ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_dgtsvx layout fact trans n nrhs (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr dlf) (CI.cptr df) (CI.cptr duf) (CI.cptr du2) (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let cgtsvx ~layout ~fact ~trans ~n ~nrhs ~dl ~d ~du ~dlf ~df ~duf ~du2 ~ipiv ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_cgtsvx layout fact trans n nrhs (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr dlf) (CI.cptr df) (CI.cptr duf) (CI.cptr du2) (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let zgtsvx ~layout ~fact ~trans ~n ~nrhs ~dl ~d ~du ~dlf ~df ~duf ~du2 ~ipiv ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_zgtsvx layout fact trans n nrhs (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr dlf) (CI.cptr df) (CI.cptr duf) (CI.cptr du2) (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let sgttrf ~n ~dl ~d ~du ~du2 ~ipiv =
  lapacke_sgttrf n (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr du2) (CI.cptr ipiv)

let dgttrf ~n ~dl ~d ~du ~du2 ~ipiv =
  lapacke_dgttrf n (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr du2) (CI.cptr ipiv)

let cgttrf ~n ~dl ~d ~du ~du2 ~ipiv =
  lapacke_cgttrf n (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr du2) (CI.cptr ipiv)

let zgttrf ~n ~dl ~d ~du ~du2 ~ipiv =
  lapacke_zgttrf n (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr du2) (CI.cptr ipiv)

let sgttrs ~layout ~trans ~n ~nrhs ~dl ~d ~du ~du2 ~ipiv ~b ~ldb =
  lapacke_sgttrs layout trans n nrhs (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr du2) (CI.cptr ipiv) (CI.cptr b) ldb

let dgttrs ~layout ~trans ~n ~nrhs ~dl ~d ~du ~du2 ~ipiv ~b ~ldb =
  lapacke_dgttrs layout trans n nrhs (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr du2) (CI.cptr ipiv) (CI.cptr b) ldb

let cgttrs ~layout ~trans ~n ~nrhs ~dl ~d ~du ~du2 ~ipiv ~b ~ldb =
  lapacke_cgttrs layout trans n nrhs (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr du2) (CI.cptr ipiv) (CI.cptr b) ldb

let zgttrs ~layout ~trans ~n ~nrhs ~dl ~d ~du ~du2 ~ipiv ~b ~ldb =
  lapacke_zgttrs layout trans n nrhs (CI.cptr dl) (CI.cptr d) (CI.cptr du) (CI.cptr du2) (CI.cptr ipiv) (CI.cptr b) ldb

let chbev ~layout ~jobz ~uplo ~n ~kd ~ab ~ldab ~w ~z ~ldz =
  lapacke_chbev layout jobz uplo n kd (CI.cptr ab) ldab (CI.cptr w) (CI.cptr z) ldz

let zhbev ~layout ~jobz ~uplo ~n ~kd ~ab ~ldab ~w ~z ~ldz =
  lapacke_zhbev layout jobz uplo n kd (CI.cptr ab) ldab (CI.cptr w) (CI.cptr z) ldz

let chbevd ~layout ~jobz ~uplo ~n ~kd ~ab ~ldab ~w ~z ~ldz =
  lapacke_chbevd layout jobz uplo n kd (CI.cptr ab) ldab (CI.cptr w) (CI.cptr z) ldz

let zhbevd ~layout ~jobz ~uplo ~n ~kd ~ab ~ldab ~w ~z ~ldz =
  lapacke_zhbevd layout jobz uplo n kd (CI.cptr ab) ldab (CI.cptr w) (CI.cptr z) ldz

let chbevx ~layout ~jobz ~range ~uplo ~n ~kd ~ab ~ldab ~q ~ldq ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_chbevx layout jobz range uplo n kd (CI.cptr ab) ldab (CI.cptr q) ldq vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let zhbevx ~layout ~jobz ~range ~uplo ~n ~kd ~ab ~ldab ~q ~ldq ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_zhbevx layout jobz range uplo n kd (CI.cptr ab) ldab (CI.cptr q) ldq vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let chbgst ~layout ~vect ~uplo ~n ~ka ~kb ~ab ~ldab ~bb ~ldbb ~x ~ldx =
  lapacke_chbgst layout vect uplo n ka kb (CI.cptr ab) ldab (CI.cptr bb) ldbb (CI.cptr x) ldx

let zhbgst ~layout ~vect ~uplo ~n ~ka ~kb ~ab ~ldab ~bb ~ldbb ~x ~ldx =
  lapacke_zhbgst layout vect uplo n ka kb (CI.cptr ab) ldab (CI.cptr bb) ldbb (CI.cptr x) ldx

let chbgv ~layout ~jobz ~uplo ~n ~ka ~kb ~ab ~ldab ~bb ~ldbb ~w ~z ~ldz =
  lapacke_chbgv layout jobz uplo n ka kb (CI.cptr ab) ldab (CI.cptr bb) ldbb (CI.cptr w) (CI.cptr z) ldz

let zhbgv ~layout ~jobz ~uplo ~n ~ka ~kb ~ab ~ldab ~bb ~ldbb ~w ~z ~ldz =
  lapacke_zhbgv layout jobz uplo n ka kb (CI.cptr ab) ldab (CI.cptr bb) ldbb (CI.cptr w) (CI.cptr z) ldz

let chbgvd ~layout ~jobz ~uplo ~n ~ka ~kb ~ab ~ldab ~bb ~ldbb ~w ~z ~ldz =
  lapacke_chbgvd layout jobz uplo n ka kb (CI.cptr ab) ldab (CI.cptr bb) ldbb (CI.cptr w) (CI.cptr z) ldz

let zhbgvd ~layout ~jobz ~uplo ~n ~ka ~kb ~ab ~ldab ~bb ~ldbb ~w ~z ~ldz =
  lapacke_zhbgvd layout jobz uplo n ka kb (CI.cptr ab) ldab (CI.cptr bb) ldbb (CI.cptr w) (CI.cptr z) ldz

let chbgvx ~layout ~jobz ~range ~uplo ~n ~ka ~kb ~ab ~ldab ~bb ~ldbb ~q ~ldq ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_chbgvx layout jobz range uplo n ka kb (CI.cptr ab) ldab (CI.cptr bb) ldbb (CI.cptr q) ldq vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let zhbgvx ~layout ~jobz ~range ~uplo ~n ~ka ~kb ~ab ~ldab ~bb ~ldbb ~q ~ldq ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_zhbgvx layout jobz range uplo n ka kb (CI.cptr ab) ldab (CI.cptr bb) ldbb (CI.cptr q) ldq vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let chbtrd ~layout ~vect ~uplo ~n ~kd ~ab ~ldab ~d ~e ~q ~ldq =
  lapacke_chbtrd layout vect uplo n kd (CI.cptr ab) ldab (CI.cptr d) (CI.cptr e) (CI.cptr q) ldq

let zhbtrd ~layout ~vect ~uplo ~n ~kd ~ab ~ldab ~d ~e ~q ~ldq =
  lapacke_zhbtrd layout vect uplo n kd (CI.cptr ab) ldab (CI.cptr d) (CI.cptr e) (CI.cptr q) ldq

let checon ~layout ~uplo ~n ~a ~lda ~ipiv ~anorm ~rcond =
  lapacke_checon layout uplo n (CI.cptr a) lda (CI.cptr ipiv) anorm (CI.cptr rcond)

let zhecon ~layout ~uplo ~n ~a ~lda ~ipiv ~anorm ~rcond =
  lapacke_zhecon layout uplo n (CI.cptr a) lda (CI.cptr ipiv) anorm (CI.cptr rcond)

let cheequb ~layout ~uplo ~n ~a ~lda ~s ~scond ~amax =
  lapacke_cheequb layout uplo n (CI.cptr a) lda (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let zheequb ~layout ~uplo ~n ~a ~lda ~s ~scond ~amax =
  lapacke_zheequb layout uplo n (CI.cptr a) lda (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let cheev ~layout ~jobz ~uplo ~n ~a ~lda ~w =
  lapacke_cheev layout jobz uplo n (CI.cptr a) lda (CI.cptr w)

let zheev ~layout ~jobz ~uplo ~n ~a ~lda ~w =
  lapacke_zheev layout jobz uplo n (CI.cptr a) lda (CI.cptr w)

let cheevd ~layout ~jobz ~uplo ~n ~a ~lda ~w =
  lapacke_cheevd layout jobz uplo n (CI.cptr a) lda (CI.cptr w)

let zheevd ~layout ~jobz ~uplo ~n ~a ~lda ~w =
  lapacke_zheevd layout jobz uplo n (CI.cptr a) lda (CI.cptr w)

let cheevr ~layout ~jobz ~range ~uplo ~n ~a ~lda ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~isuppz =
  lapacke_cheevr layout jobz range uplo n (CI.cptr a) lda vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr isuppz)

let zheevr ~layout ~jobz ~range ~uplo ~n ~a ~lda ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~isuppz =
  lapacke_zheevr layout jobz range uplo n (CI.cptr a) lda vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr isuppz)

let cheevx ~layout ~jobz ~range ~uplo ~n ~a ~lda ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_cheevx layout jobz range uplo n (CI.cptr a) lda vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let zheevx ~layout ~jobz ~range ~uplo ~n ~a ~lda ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_zheevx layout jobz range uplo n (CI.cptr a) lda vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let chegst ~layout ~ityp ~uplo ~n ~a ~lda ~b ~ldb =
  lapacke_chegst layout ityp uplo n (CI.cptr a) lda (CI.cptr b) ldb

let zhegst ~layout ~ityp ~uplo ~n ~a ~lda ~b ~ldb =
  lapacke_zhegst layout ityp uplo n (CI.cptr a) lda (CI.cptr b) ldb

let chegv ~layout ~ityp ~jobz ~uplo ~n ~a ~lda ~b ~ldb ~w =
  lapacke_chegv layout ityp jobz uplo n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr w)

let zhegv ~layout ~ityp ~jobz ~uplo ~n ~a ~lda ~b ~ldb ~w =
  lapacke_zhegv layout ityp jobz uplo n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr w)

let chegvd ~layout ~ityp ~jobz ~uplo ~n ~a ~lda ~b ~ldb ~w =
  lapacke_chegvd layout ityp jobz uplo n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr w)

let zhegvd ~layout ~ityp ~jobz ~uplo ~n ~a ~lda ~b ~ldb ~w =
  lapacke_zhegvd layout ityp jobz uplo n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr w)

let chegvx ~layout ~ityp ~jobz ~range ~uplo ~n ~a ~lda ~b ~ldb ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_chegvx layout ityp jobz range uplo n (CI.cptr a) lda (CI.cptr b) ldb vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let zhegvx ~layout ~ityp ~jobz ~range ~uplo ~n ~a ~lda ~b ~ldb ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_zhegvx layout ityp jobz range uplo n (CI.cptr a) lda (CI.cptr b) ldb vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let cherfs ~layout ~uplo ~n ~nrhs ~a ~lda ~af ~ldaf ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_cherfs layout uplo n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let zherfs ~layout ~uplo ~n ~nrhs ~a ~lda ~af ~ldaf ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_zherfs layout uplo n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let chesv ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_chesv layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let zhesv ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_zhesv layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let chesvx ~layout ~fact ~uplo ~n ~nrhs ~a ~lda ~af ~ldaf ~ipiv ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_chesvx layout fact uplo n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let zhesvx ~layout ~fact ~uplo ~n ~nrhs ~a ~lda ~af ~ldaf ~ipiv ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_zhesvx layout fact uplo n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let chetrd ~layout ~uplo ~n ~a ~lda ~d ~e ~tau =
  lapacke_chetrd layout uplo n (CI.cptr a) lda (CI.cptr d) (CI.cptr e) (CI.cptr tau)

let zhetrd ~layout ~uplo ~n ~a ~lda ~d ~e ~tau =
  lapacke_zhetrd layout uplo n (CI.cptr a) lda (CI.cptr d) (CI.cptr e) (CI.cptr tau)

let chetrf ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_chetrf layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let zhetrf ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_zhetrf layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let chetri ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_chetri layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let zhetri ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_zhetri layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let chetrs ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_chetrs layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let zhetrs ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_zhetrs layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let chfrk ~layout ~transr ~uplo ~trans ~n ~k ~alpha ~a ~lda ~beta ~c =
  lapacke_chfrk layout transr uplo trans n k alpha (CI.cptr a) lda beta (CI.cptr c)

let zhfrk ~layout ~transr ~uplo ~trans ~n ~k ~alpha ~a ~lda ~beta ~c =
  lapacke_zhfrk layout transr uplo trans n k alpha (CI.cptr a) lda beta (CI.cptr c)

let shgeqz ~layout ~job ~compq ~compz ~n ~ilo ~ihi ~h ~ldh ~t ~ldt ~alphar ~alphai ~beta ~q ~ldq ~z ~ldz =
  lapacke_shgeqz layout job compq compz n ilo ihi (CI.cptr h) ldh (CI.cptr t) ldt (CI.cptr alphar) (CI.cptr alphai) (CI.cptr beta) (CI.cptr q) ldq (CI.cptr z) ldz

let dhgeqz ~layout ~job ~compq ~compz ~n ~ilo ~ihi ~h ~ldh ~t ~ldt ~alphar ~alphai ~beta ~q ~ldq ~z ~ldz =
  lapacke_dhgeqz layout job compq compz n ilo ihi (CI.cptr h) ldh (CI.cptr t) ldt (CI.cptr alphar) (CI.cptr alphai) (CI.cptr beta) (CI.cptr q) ldq (CI.cptr z) ldz

let chgeqz ~layout ~job ~compq ~compz ~n ~ilo ~ihi ~h ~ldh ~t ~ldt ~alpha ~beta ~q ~ldq ~z ~ldz =
  lapacke_chgeqz layout job compq compz n ilo ihi (CI.cptr h) ldh (CI.cptr t) ldt (CI.cptr alpha) (CI.cptr beta) (CI.cptr q) ldq (CI.cptr z) ldz

let zhgeqz ~layout ~job ~compq ~compz ~n ~ilo ~ihi ~h ~ldh ~t ~ldt ~alpha ~beta ~q ~ldq ~z ~ldz =
  lapacke_zhgeqz layout job compq compz n ilo ihi (CI.cptr h) ldh (CI.cptr t) ldt (CI.cptr alpha) (CI.cptr beta) (CI.cptr q) ldq (CI.cptr z) ldz

let chpcon ~layout ~uplo ~n ~ap ~ipiv ~anorm ~rcond =
  lapacke_chpcon layout uplo n (CI.cptr ap) (CI.cptr ipiv) anorm (CI.cptr rcond)

let zhpcon ~layout ~uplo ~n ~ap ~ipiv ~anorm ~rcond =
  lapacke_zhpcon layout uplo n (CI.cptr ap) (CI.cptr ipiv) anorm (CI.cptr rcond)

let chpev ~layout ~jobz ~uplo ~n ~ap ~w ~z ~ldz =
  lapacke_chpev layout jobz uplo n (CI.cptr ap) (CI.cptr w) (CI.cptr z) ldz

let zhpev ~layout ~jobz ~uplo ~n ~ap ~w ~z ~ldz =
  lapacke_zhpev layout jobz uplo n (CI.cptr ap) (CI.cptr w) (CI.cptr z) ldz

let chpevd ~layout ~jobz ~uplo ~n ~ap ~w ~z ~ldz =
  lapacke_chpevd layout jobz uplo n (CI.cptr ap) (CI.cptr w) (CI.cptr z) ldz

let zhpevd ~layout ~jobz ~uplo ~n ~ap ~w ~z ~ldz =
  lapacke_zhpevd layout jobz uplo n (CI.cptr ap) (CI.cptr w) (CI.cptr z) ldz

let chpevx ~layout ~jobz ~range ~uplo ~n ~ap ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_chpevx layout jobz range uplo n (CI.cptr ap) vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let zhpevx ~layout ~jobz ~range ~uplo ~n ~ap ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_zhpevx layout jobz range uplo n (CI.cptr ap) vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let chpgst ~layout ~ityp ~uplo ~n ~ap ~bp =
  lapacke_chpgst layout ityp uplo n (CI.cptr ap) (CI.cptr bp)

let zhpgst ~layout ~ityp ~uplo ~n ~ap ~bp =
  lapacke_zhpgst layout ityp uplo n (CI.cptr ap) (CI.cptr bp)

let chpgv ~layout ~ityp ~jobz ~uplo ~n ~ap ~bp ~w ~z ~ldz =
  lapacke_chpgv layout ityp jobz uplo n (CI.cptr ap) (CI.cptr bp) (CI.cptr w) (CI.cptr z) ldz

let zhpgv ~layout ~ityp ~jobz ~uplo ~n ~ap ~bp ~w ~z ~ldz =
  lapacke_zhpgv layout ityp jobz uplo n (CI.cptr ap) (CI.cptr bp) (CI.cptr w) (CI.cptr z) ldz

let chpgvd ~layout ~ityp ~jobz ~uplo ~n ~ap ~bp ~w ~z ~ldz =
  lapacke_chpgvd layout ityp jobz uplo n (CI.cptr ap) (CI.cptr bp) (CI.cptr w) (CI.cptr z) ldz

let zhpgvd ~layout ~ityp ~jobz ~uplo ~n ~ap ~bp ~w ~z ~ldz =
  lapacke_zhpgvd layout ityp jobz uplo n (CI.cptr ap) (CI.cptr bp) (CI.cptr w) (CI.cptr z) ldz

let chpgvx ~layout ~ityp ~jobz ~range ~uplo ~n ~ap ~bp ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_chpgvx layout ityp jobz range uplo n (CI.cptr ap) (CI.cptr bp) vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let zhpgvx ~layout ~ityp ~jobz ~range ~uplo ~n ~ap ~bp ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_zhpgvx layout ityp jobz range uplo n (CI.cptr ap) (CI.cptr bp) vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let chprfs ~layout ~uplo ~n ~nrhs ~ap ~afp ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_chprfs layout uplo n nrhs (CI.cptr ap) (CI.cptr afp) (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let zhprfs ~layout ~uplo ~n ~nrhs ~ap ~afp ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_zhprfs layout uplo n nrhs (CI.cptr ap) (CI.cptr afp) (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let chpsv ~layout ~uplo ~n ~nrhs ~ap ~ipiv ~b ~ldb =
  lapacke_chpsv layout uplo n nrhs (CI.cptr ap) (CI.cptr ipiv) (CI.cptr b) ldb

let zhpsv ~layout ~uplo ~n ~nrhs ~ap ~ipiv ~b ~ldb =
  lapacke_zhpsv layout uplo n nrhs (CI.cptr ap) (CI.cptr ipiv) (CI.cptr b) ldb

let chpsvx ~layout ~fact ~uplo ~n ~nrhs ~ap ~afp ~ipiv ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_chpsvx layout fact uplo n nrhs (CI.cptr ap) (CI.cptr afp) (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let zhpsvx ~layout ~fact ~uplo ~n ~nrhs ~ap ~afp ~ipiv ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_zhpsvx layout fact uplo n nrhs (CI.cptr ap) (CI.cptr afp) (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let chptrd ~layout ~uplo ~n ~ap ~d ~e ~tau =
  lapacke_chptrd layout uplo n (CI.cptr ap) (CI.cptr d) (CI.cptr e) (CI.cptr tau)

let zhptrd ~layout ~uplo ~n ~ap ~d ~e ~tau =
  lapacke_zhptrd layout uplo n (CI.cptr ap) (CI.cptr d) (CI.cptr e) (CI.cptr tau)

let chptrf ~layout ~uplo ~n ~ap ~ipiv =
  lapacke_chptrf layout uplo n (CI.cptr ap) (CI.cptr ipiv)

let zhptrf ~layout ~uplo ~n ~ap ~ipiv =
  lapacke_zhptrf layout uplo n (CI.cptr ap) (CI.cptr ipiv)

let chptri ~layout ~uplo ~n ~ap ~ipiv =
  lapacke_chptri layout uplo n (CI.cptr ap) (CI.cptr ipiv)

let zhptri ~layout ~uplo ~n ~ap ~ipiv =
  lapacke_zhptri layout uplo n (CI.cptr ap) (CI.cptr ipiv)

let chptrs ~layout ~uplo ~n ~nrhs ~ap ~ipiv ~b ~ldb =
  lapacke_chptrs layout uplo n nrhs (CI.cptr ap) (CI.cptr ipiv) (CI.cptr b) ldb

let zhptrs ~layout ~uplo ~n ~nrhs ~ap ~ipiv ~b ~ldb =
  lapacke_zhptrs layout uplo n nrhs (CI.cptr ap) (CI.cptr ipiv) (CI.cptr b) ldb

let shsein ~layout ~job ~eigsrc ~initv ~select ~n ~h ~ldh ~wr ~wi ~vl ~ldvl ~vr ~ldvr ~mm ~m ~ifaill ~ifailr =
  lapacke_shsein layout job eigsrc initv (CI.cptr select) n (CI.cptr h) ldh (CI.cptr wr) (CI.cptr wi) (CI.cptr vl) ldvl (CI.cptr vr) ldvr mm (CI.cptr m) (CI.cptr ifaill) (CI.cptr ifailr)

let dhsein ~layout ~job ~eigsrc ~initv ~select ~n ~h ~ldh ~wr ~wi ~vl ~ldvl ~vr ~ldvr ~mm ~m ~ifaill ~ifailr =
  lapacke_dhsein layout job eigsrc initv (CI.cptr select) n (CI.cptr h) ldh (CI.cptr wr) (CI.cptr wi) (CI.cptr vl) ldvl (CI.cptr vr) ldvr mm (CI.cptr m) (CI.cptr ifaill) (CI.cptr ifailr)

let chsein ~layout ~job ~eigsrc ~initv ~select ~n ~h ~ldh ~w ~vl ~ldvl ~vr ~ldvr ~mm ~m ~ifaill ~ifailr =
  lapacke_chsein layout job eigsrc initv (CI.cptr select) n (CI.cptr h) ldh (CI.cptr w) (CI.cptr vl) ldvl (CI.cptr vr) ldvr mm (CI.cptr m) (CI.cptr ifaill) (CI.cptr ifailr)

let zhsein ~layout ~job ~eigsrc ~initv ~select ~n ~h ~ldh ~w ~vl ~ldvl ~vr ~ldvr ~mm ~m ~ifaill ~ifailr =
  lapacke_zhsein layout job eigsrc initv (CI.cptr select) n (CI.cptr h) ldh (CI.cptr w) (CI.cptr vl) ldvl (CI.cptr vr) ldvr mm (CI.cptr m) (CI.cptr ifaill) (CI.cptr ifailr)

let shseqr ~layout ~job ~compz ~n ~ilo ~ihi ~h ~ldh ~wr ~wi ~z ~ldz =
  lapacke_shseqr layout job compz n ilo ihi (CI.cptr h) ldh (CI.cptr wr) (CI.cptr wi) (CI.cptr z) ldz

let dhseqr ~layout ~job ~compz ~n ~ilo ~ihi ~h ~ldh ~wr ~wi ~z ~ldz =
  lapacke_dhseqr layout job compz n ilo ihi (CI.cptr h) ldh (CI.cptr wr) (CI.cptr wi) (CI.cptr z) ldz

let chseqr ~layout ~job ~compz ~n ~ilo ~ihi ~h ~ldh ~w ~z ~ldz =
  lapacke_chseqr layout job compz n ilo ihi (CI.cptr h) ldh (CI.cptr w) (CI.cptr z) ldz

let zhseqr ~layout ~job ~compz ~n ~ilo ~ihi ~h ~ldh ~w ~z ~ldz =
  lapacke_zhseqr layout job compz n ilo ihi (CI.cptr h) ldh (CI.cptr w) (CI.cptr z) ldz

let clacgv ~n ~x ~incx =
  lapacke_clacgv n (CI.cptr x) incx

let zlacgv ~n ~x ~incx =
  lapacke_zlacgv n (CI.cptr x) incx

let slacn2 ~n ~v ~x ~isgn ~est ~kase ~isave =
  lapacke_slacn2 n (CI.cptr v) (CI.cptr x) (CI.cptr isgn) (CI.cptr est) (CI.cptr kase) (CI.cptr isave)

let dlacn2 ~n ~v ~x ~isgn ~est ~kase ~isave =
  lapacke_dlacn2 n (CI.cptr v) (CI.cptr x) (CI.cptr isgn) (CI.cptr est) (CI.cptr kase) (CI.cptr isave)

let clacn2 ~n ~v ~x ~est ~kase ~isave =
  lapacke_clacn2 n (CI.cptr v) (CI.cptr x) (CI.cptr est) (CI.cptr kase) (CI.cptr isave)

let zlacn2 ~n ~v ~x ~est ~kase ~isave =
  lapacke_zlacn2 n (CI.cptr v) (CI.cptr x) (CI.cptr est) (CI.cptr kase) (CI.cptr isave)

let slacpy ~layout ~uplo ~m ~n ~a ~lda ~b ~ldb =
  lapacke_slacpy layout uplo m n (CI.cptr a) lda (CI.cptr b) ldb

let dlacpy ~layout ~uplo ~m ~n ~a ~lda ~b ~ldb =
  lapacke_dlacpy layout uplo m n (CI.cptr a) lda (CI.cptr b) ldb

let clacpy ~layout ~uplo ~m ~n ~a ~lda ~b ~ldb =
  lapacke_clacpy layout uplo m n (CI.cptr a) lda (CI.cptr b) ldb

let zlacpy ~layout ~uplo ~m ~n ~a ~lda ~b ~ldb =
  lapacke_zlacpy layout uplo m n (CI.cptr a) lda (CI.cptr b) ldb

let clacp2 ~layout ~uplo ~m ~n ~a ~lda ~b ~ldb =
  lapacke_clacp2 layout uplo m n (CI.cptr a) lda (CI.cptr b) ldb

let zlacp2 ~layout ~uplo ~m ~n ~a ~lda ~b ~ldb =
  lapacke_zlacp2 layout uplo m n (CI.cptr a) lda (CI.cptr b) ldb

let zlag2c ~layout ~m ~n ~a ~lda ~sa ~ldsa =
  lapacke_zlag2c layout m n (CI.cptr a) lda (CI.cptr sa) ldsa

let slag2d ~layout ~m ~n ~sa ~ldsa ~a ~lda =
  lapacke_slag2d layout m n (CI.cptr sa) ldsa (CI.cptr a) lda

let dlag2s ~layout ~m ~n ~a ~lda ~sa ~ldsa =
  lapacke_dlag2s layout m n (CI.cptr a) lda (CI.cptr sa) ldsa

let clag2z ~layout ~m ~n ~sa ~ldsa ~a ~lda =
  lapacke_clag2z layout m n (CI.cptr sa) ldsa (CI.cptr a) lda

let slagge ~layout ~m ~n ~kl ~ku ~d ~a ~lda ~iseed =
  lapacke_slagge layout m n kl ku (CI.cptr d) (CI.cptr a) lda (CI.cptr iseed)

let dlagge ~layout ~m ~n ~kl ~ku ~d ~a ~lda ~iseed =
  lapacke_dlagge layout m n kl ku (CI.cptr d) (CI.cptr a) lda (CI.cptr iseed)

let clagge ~layout ~m ~n ~kl ~ku ~d ~a ~lda ~iseed =
  lapacke_clagge layout m n kl ku (CI.cptr d) (CI.cptr a) lda (CI.cptr iseed)

let zlagge ~layout ~m ~n ~kl ~ku ~d ~a ~lda ~iseed =
  lapacke_zlagge layout m n kl ku (CI.cptr d) (CI.cptr a) lda (CI.cptr iseed)

let slarfb ~layout ~side ~trans ~direct ~storev ~m ~n ~k ~v ~ldv ~t ~ldt ~c ~ldc =
  lapacke_slarfb layout side trans direct storev m n k (CI.cptr v) ldv (CI.cptr t) ldt (CI.cptr c) ldc

let dlarfb ~layout ~side ~trans ~direct ~storev ~m ~n ~k ~v ~ldv ~t ~ldt ~c ~ldc =
  lapacke_dlarfb layout side trans direct storev m n k (CI.cptr v) ldv (CI.cptr t) ldt (CI.cptr c) ldc

let clarfb ~layout ~side ~trans ~direct ~storev ~m ~n ~k ~v ~ldv ~t ~ldt ~c ~ldc =
  lapacke_clarfb layout side trans direct storev m n k (CI.cptr v) ldv (CI.cptr t) ldt (CI.cptr c) ldc

let zlarfb ~layout ~side ~trans ~direct ~storev ~m ~n ~k ~v ~ldv ~t ~ldt ~c ~ldc =
  lapacke_zlarfb layout side trans direct storev m n k (CI.cptr v) ldv (CI.cptr t) ldt (CI.cptr c) ldc

let slarfg ~n ~alpha ~x ~incx ~tau =
  lapacke_slarfg n (CI.cptr alpha) (CI.cptr x) incx (CI.cptr tau)

let dlarfg ~n ~alpha ~x ~incx ~tau =
  lapacke_dlarfg n (CI.cptr alpha) (CI.cptr x) incx (CI.cptr tau)

let clarfg ~n ~alpha ~x ~incx ~tau =
  lapacke_clarfg n (CI.cptr alpha) (CI.cptr x) incx (CI.cptr tau)

let zlarfg ~n ~alpha ~x ~incx ~tau =
  lapacke_zlarfg n (CI.cptr alpha) (CI.cptr x) incx (CI.cptr tau)

let slarft ~layout ~direct ~storev ~n ~k ~v ~ldv ~tau ~t ~ldt =
  lapacke_slarft layout direct storev n k (CI.cptr v) ldv (CI.cptr tau) (CI.cptr t) ldt

let dlarft ~layout ~direct ~storev ~n ~k ~v ~ldv ~tau ~t ~ldt =
  lapacke_dlarft layout direct storev n k (CI.cptr v) ldv (CI.cptr tau) (CI.cptr t) ldt

let clarft ~layout ~direct ~storev ~n ~k ~v ~ldv ~tau ~t ~ldt =
  lapacke_clarft layout direct storev n k (CI.cptr v) ldv (CI.cptr tau) (CI.cptr t) ldt

let zlarft ~layout ~direct ~storev ~n ~k ~v ~ldv ~tau ~t ~ldt =
  lapacke_zlarft layout direct storev n k (CI.cptr v) ldv (CI.cptr tau) (CI.cptr t) ldt

let slarfx ~layout ~side ~m ~n ~v ~tau ~c ~ldc ~work =
  lapacke_slarfx layout side m n (CI.cptr v) tau (CI.cptr c) ldc (CI.cptr work)

let dlarfx ~layout ~side ~m ~n ~v ~tau ~c ~ldc ~work =
  lapacke_dlarfx layout side m n (CI.cptr v) tau (CI.cptr c) ldc (CI.cptr work)

let clarfx ~layout ~side ~m ~n ~v ~tau ~c ~ldc ~work =
  lapacke_clarfx layout side m n (CI.cptr v) tau (CI.cptr c) ldc (CI.cptr work)

let zlarfx ~layout ~side ~m ~n ~v ~tau ~c ~ldc ~work =
  lapacke_zlarfx layout side m n (CI.cptr v) tau (CI.cptr c) ldc (CI.cptr work)

let slarnv ~idist ~iseed ~n ~x =
  lapacke_slarnv idist (CI.cptr iseed) n (CI.cptr x)

let dlarnv ~idist ~iseed ~n ~x =
  lapacke_dlarnv idist (CI.cptr iseed) n (CI.cptr x)

let clarnv ~idist ~iseed ~n ~x =
  lapacke_clarnv idist (CI.cptr iseed) n (CI.cptr x)

let zlarnv ~idist ~iseed ~n ~x =
  lapacke_zlarnv idist (CI.cptr iseed) n (CI.cptr x)

let slascl ~layout ~typ ~kl ~ku ~cfrom ~cto ~m ~n ~a ~lda =
  lapacke_slascl layout typ kl ku cfrom cto m n (CI.cptr a) lda

let dlascl ~layout ~typ ~kl ~ku ~cfrom ~cto ~m ~n ~a ~lda =
  lapacke_dlascl layout typ kl ku cfrom cto m n (CI.cptr a) lda

let clascl ~layout ~typ ~kl ~ku ~cfrom ~cto ~m ~n ~a ~lda =
  lapacke_clascl layout typ kl ku cfrom cto m n (CI.cptr a) lda

let zlascl ~layout ~typ ~kl ~ku ~cfrom ~cto ~m ~n ~a ~lda =
  lapacke_zlascl layout typ kl ku cfrom cto m n (CI.cptr a) lda

let slaset ~layout ~uplo ~m ~n ~alpha ~beta ~a ~lda =
  lapacke_slaset layout uplo m n alpha beta (CI.cptr a) lda

let dlaset ~layout ~uplo ~m ~n ~alpha ~beta ~a ~lda =
  lapacke_dlaset layout uplo m n alpha beta (CI.cptr a) lda

let claset ~layout ~uplo ~m ~n ~alpha ~beta ~a ~lda =
  lapacke_claset layout uplo m n alpha beta (CI.cptr a) lda

let zlaset ~layout ~uplo ~m ~n ~alpha ~beta ~a ~lda =
  lapacke_zlaset layout uplo m n alpha beta (CI.cptr a) lda

let slasrt ~id ~n ~d =
  lapacke_slasrt id n (CI.cptr d)

let dlasrt ~id ~n ~d =
  lapacke_dlasrt id n (CI.cptr d)

let slaswp ~layout ~n ~a ~lda ~k1 ~k2 ~ipiv ~incx =
  lapacke_slaswp layout n (CI.cptr a) lda k1 k2 (CI.cptr ipiv) incx

let dlaswp ~layout ~n ~a ~lda ~k1 ~k2 ~ipiv ~incx =
  lapacke_dlaswp layout n (CI.cptr a) lda k1 k2 (CI.cptr ipiv) incx

let claswp ~layout ~n ~a ~lda ~k1 ~k2 ~ipiv ~incx =
  lapacke_claswp layout n (CI.cptr a) lda k1 k2 (CI.cptr ipiv) incx

let zlaswp ~layout ~n ~a ~lda ~k1 ~k2 ~ipiv ~incx =
  lapacke_zlaswp layout n (CI.cptr a) lda k1 k2 (CI.cptr ipiv) incx

let slatms ~layout ~m ~n ~dist ~iseed ~sym ~d ~mode ~cond ~dmax ~kl ~ku ~pack ~a ~lda =
  lapacke_slatms layout m n dist (CI.cptr iseed) sym (CI.cptr d) mode cond dmax kl ku pack (CI.cptr a) lda

let dlatms ~layout ~m ~n ~dist ~iseed ~sym ~d ~mode ~cond ~dmax ~kl ~ku ~pack ~a ~lda =
  lapacke_dlatms layout m n dist (CI.cptr iseed) sym (CI.cptr d) mode cond dmax kl ku pack (CI.cptr a) lda

let clatms ~layout ~m ~n ~dist ~iseed ~sym ~d ~mode ~cond ~dmax ~kl ~ku ~pack ~a ~lda =
  lapacke_clatms layout m n dist (CI.cptr iseed) sym (CI.cptr d) mode cond dmax kl ku pack (CI.cptr a) lda

let zlatms ~layout ~m ~n ~dist ~iseed ~sym ~d ~mode ~cond ~dmax ~kl ~ku ~pack ~a ~lda =
  lapacke_zlatms layout m n dist (CI.cptr iseed) sym (CI.cptr d) mode cond dmax kl ku pack (CI.cptr a) lda

let slauum ~layout ~uplo ~n ~a ~lda =
  lapacke_slauum layout uplo n (CI.cptr a) lda

let dlauum ~layout ~uplo ~n ~a ~lda =
  lapacke_dlauum layout uplo n (CI.cptr a) lda

let clauum ~layout ~uplo ~n ~a ~lda =
  lapacke_clauum layout uplo n (CI.cptr a) lda

let zlauum ~layout ~uplo ~n ~a ~lda =
  lapacke_zlauum layout uplo n (CI.cptr a) lda

let sopgtr ~layout ~uplo ~n ~ap ~tau ~q ~ldq =
  lapacke_sopgtr layout uplo n (CI.cptr ap) (CI.cptr tau) (CI.cptr q) ldq

let dopgtr ~layout ~uplo ~n ~ap ~tau ~q ~ldq =
  lapacke_dopgtr layout uplo n (CI.cptr ap) (CI.cptr tau) (CI.cptr q) ldq

let sopmtr ~layout ~side ~uplo ~trans ~m ~n ~ap ~tau ~c ~ldc =
  lapacke_sopmtr layout side uplo trans m n (CI.cptr ap) (CI.cptr tau) (CI.cptr c) ldc

let dopmtr ~layout ~side ~uplo ~trans ~m ~n ~ap ~tau ~c ~ldc =
  lapacke_dopmtr layout side uplo trans m n (CI.cptr ap) (CI.cptr tau) (CI.cptr c) ldc

let sorgbr ~layout ~vect ~m ~n ~k ~a ~lda ~tau =
  lapacke_sorgbr layout vect m n k (CI.cptr a) lda (CI.cptr tau)

let dorgbr ~layout ~vect ~m ~n ~k ~a ~lda ~tau =
  lapacke_dorgbr layout vect m n k (CI.cptr a) lda (CI.cptr tau)

let sorghr ~layout ~n ~ilo ~ihi ~a ~lda ~tau =
  lapacke_sorghr layout n ilo ihi (CI.cptr a) lda (CI.cptr tau)

let dorghr ~layout ~n ~ilo ~ihi ~a ~lda ~tau =
  lapacke_dorghr layout n ilo ihi (CI.cptr a) lda (CI.cptr tau)

let sorglq ~layout ~m ~n ~k ~a ~lda ~tau =
  lapacke_sorglq layout m n k (CI.cptr a) lda (CI.cptr tau)

let dorglq ~layout ~m ~n ~k ~a ~lda ~tau =
  lapacke_dorglq layout m n k (CI.cptr a) lda (CI.cptr tau)

let sorgql ~layout ~m ~n ~k ~a ~lda ~tau =
  lapacke_sorgql layout m n k (CI.cptr a) lda (CI.cptr tau)

let dorgql ~layout ~m ~n ~k ~a ~lda ~tau =
  lapacke_dorgql layout m n k (CI.cptr a) lda (CI.cptr tau)

let sorgqr ~layout ~m ~n ~k ~a ~lda ~tau =
  lapacke_sorgqr layout m n k (CI.cptr a) lda (CI.cptr tau)

let dorgqr ~layout ~m ~n ~k ~a ~lda ~tau =
  lapacke_dorgqr layout m n k (CI.cptr a) lda (CI.cptr tau)

let sorgrq ~layout ~m ~n ~k ~a ~lda ~tau =
  lapacke_sorgrq layout m n k (CI.cptr a) lda (CI.cptr tau)

let dorgrq ~layout ~m ~n ~k ~a ~lda ~tau =
  lapacke_dorgrq layout m n k (CI.cptr a) lda (CI.cptr tau)

let sorgtr ~layout ~uplo ~n ~a ~lda ~tau =
  lapacke_sorgtr layout uplo n (CI.cptr a) lda (CI.cptr tau)

let dorgtr ~layout ~uplo ~n ~a ~lda ~tau =
  lapacke_dorgtr layout uplo n (CI.cptr a) lda (CI.cptr tau)

let sormbr ~layout ~vect ~side ~trans ~m ~n ~k ~a ~lda ~tau ~c ~ldc =
  lapacke_sormbr layout vect side trans m n k (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let dormbr ~layout ~vect ~side ~trans ~m ~n ~k ~a ~lda ~tau ~c ~ldc =
  lapacke_dormbr layout vect side trans m n k (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let sormhr ~layout ~side ~trans ~m ~n ~ilo ~ihi ~a ~lda ~tau ~c ~ldc =
  lapacke_sormhr layout side trans m n ilo ihi (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let dormhr ~layout ~side ~trans ~m ~n ~ilo ~ihi ~a ~lda ~tau ~c ~ldc =
  lapacke_dormhr layout side trans m n ilo ihi (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let sormlq ~layout ~side ~trans ~m ~n ~k ~a ~lda ~tau ~c ~ldc =
  lapacke_sormlq layout side trans m n k (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let dormlq ~layout ~side ~trans ~m ~n ~k ~a ~lda ~tau ~c ~ldc =
  lapacke_dormlq layout side trans m n k (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let sormql ~layout ~side ~trans ~m ~n ~k ~a ~lda ~tau ~c ~ldc =
  lapacke_sormql layout side trans m n k (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let dormql ~layout ~side ~trans ~m ~n ~k ~a ~lda ~tau ~c ~ldc =
  lapacke_dormql layout side trans m n k (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let sormqr ~layout ~side ~trans ~m ~n ~k ~a ~lda ~tau ~c ~ldc =
  lapacke_sormqr layout side trans m n k (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let dormqr ~layout ~side ~trans ~m ~n ~k ~a ~lda ~tau ~c ~ldc =
  lapacke_dormqr layout side trans m n k (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let sormrq ~layout ~side ~trans ~m ~n ~k ~a ~lda ~tau ~c ~ldc =
  lapacke_sormrq layout side trans m n k (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let dormrq ~layout ~side ~trans ~m ~n ~k ~a ~lda ~tau ~c ~ldc =
  lapacke_dormrq layout side trans m n k (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let sormrz ~layout ~side ~trans ~m ~n ~k ~l ~a ~lda ~tau ~c ~ldc =
  lapacke_sormrz layout side trans m n k l (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let dormrz ~layout ~side ~trans ~m ~n ~k ~l ~a ~lda ~tau ~c ~ldc =
  lapacke_dormrz layout side trans m n k l (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let sormtr ~layout ~side ~uplo ~trans ~m ~n ~a ~lda ~tau ~c ~ldc =
  lapacke_sormtr layout side uplo trans m n (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let dormtr ~layout ~side ~uplo ~trans ~m ~n ~a ~lda ~tau ~c ~ldc =
  lapacke_dormtr layout side uplo trans m n (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let spbcon ~layout ~uplo ~n ~kd ~ab ~ldab ~anorm ~rcond =
  lapacke_spbcon layout uplo n kd (CI.cptr ab) ldab anorm (CI.cptr rcond)

let dpbcon ~layout ~uplo ~n ~kd ~ab ~ldab ~anorm ~rcond =
  lapacke_dpbcon layout uplo n kd (CI.cptr ab) ldab anorm (CI.cptr rcond)

let cpbcon ~layout ~uplo ~n ~kd ~ab ~ldab ~anorm ~rcond =
  lapacke_cpbcon layout uplo n kd (CI.cptr ab) ldab anorm (CI.cptr rcond)

let zpbcon ~layout ~uplo ~n ~kd ~ab ~ldab ~anorm ~rcond =
  lapacke_zpbcon layout uplo n kd (CI.cptr ab) ldab anorm (CI.cptr rcond)

let spbequ ~layout ~uplo ~n ~kd ~ab ~ldab ~s ~scond ~amax =
  lapacke_spbequ layout uplo n kd (CI.cptr ab) ldab (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let dpbequ ~layout ~uplo ~n ~kd ~ab ~ldab ~s ~scond ~amax =
  lapacke_dpbequ layout uplo n kd (CI.cptr ab) ldab (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let cpbequ ~layout ~uplo ~n ~kd ~ab ~ldab ~s ~scond ~amax =
  lapacke_cpbequ layout uplo n kd (CI.cptr ab) ldab (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let zpbequ ~layout ~uplo ~n ~kd ~ab ~ldab ~s ~scond ~amax =
  lapacke_zpbequ layout uplo n kd (CI.cptr ab) ldab (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let spbrfs ~layout ~uplo ~n ~kd ~nrhs ~ab ~ldab ~afb ~ldafb ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_spbrfs layout uplo n kd nrhs (CI.cptr ab) ldab (CI.cptr afb) ldafb (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let dpbrfs ~layout ~uplo ~n ~kd ~nrhs ~ab ~ldab ~afb ~ldafb ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_dpbrfs layout uplo n kd nrhs (CI.cptr ab) ldab (CI.cptr afb) ldafb (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let cpbrfs ~layout ~uplo ~n ~kd ~nrhs ~ab ~ldab ~afb ~ldafb ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_cpbrfs layout uplo n kd nrhs (CI.cptr ab) ldab (CI.cptr afb) ldafb (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let zpbrfs ~layout ~uplo ~n ~kd ~nrhs ~ab ~ldab ~afb ~ldafb ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_zpbrfs layout uplo n kd nrhs (CI.cptr ab) ldab (CI.cptr afb) ldafb (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let spbstf ~layout ~uplo ~n ~kb ~bb ~ldbb =
  lapacke_spbstf layout uplo n kb (CI.cptr bb) ldbb

let dpbstf ~layout ~uplo ~n ~kb ~bb ~ldbb =
  lapacke_dpbstf layout uplo n kb (CI.cptr bb) ldbb

let cpbstf ~layout ~uplo ~n ~kb ~bb ~ldbb =
  lapacke_cpbstf layout uplo n kb (CI.cptr bb) ldbb

let zpbstf ~layout ~uplo ~n ~kb ~bb ~ldbb =
  lapacke_zpbstf layout uplo n kb (CI.cptr bb) ldbb

let spbsv ~layout ~uplo ~n ~kd ~nrhs ~ab ~ldab ~b ~ldb =
  lapacke_spbsv layout uplo n kd nrhs (CI.cptr ab) ldab (CI.cptr b) ldb

let dpbsv ~layout ~uplo ~n ~kd ~nrhs ~ab ~ldab ~b ~ldb =
  lapacke_dpbsv layout uplo n kd nrhs (CI.cptr ab) ldab (CI.cptr b) ldb

let cpbsv ~layout ~uplo ~n ~kd ~nrhs ~ab ~ldab ~b ~ldb =
  lapacke_cpbsv layout uplo n kd nrhs (CI.cptr ab) ldab (CI.cptr b) ldb

let zpbsv ~layout ~uplo ~n ~kd ~nrhs ~ab ~ldab ~b ~ldb =
  lapacke_zpbsv layout uplo n kd nrhs (CI.cptr ab) ldab (CI.cptr b) ldb

let spbsvx ~layout ~fact ~uplo ~n ~kd ~nrhs ~ab ~ldab ~afb ~ldafb ~equed ~s ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_spbsvx layout fact uplo n kd nrhs (CI.cptr ab) ldab (CI.cptr afb) ldafb (CI.cptr equed) (CI.cptr s) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let dpbsvx ~layout ~fact ~uplo ~n ~kd ~nrhs ~ab ~ldab ~afb ~ldafb ~equed ~s ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_dpbsvx layout fact uplo n kd nrhs (CI.cptr ab) ldab (CI.cptr afb) ldafb (CI.cptr equed) (CI.cptr s) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let cpbsvx ~layout ~fact ~uplo ~n ~kd ~nrhs ~ab ~ldab ~afb ~ldafb ~equed ~s ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_cpbsvx layout fact uplo n kd nrhs (CI.cptr ab) ldab (CI.cptr afb) ldafb (CI.cptr equed) (CI.cptr s) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let zpbsvx ~layout ~fact ~uplo ~n ~kd ~nrhs ~ab ~ldab ~afb ~ldafb ~equed ~s ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_zpbsvx layout fact uplo n kd nrhs (CI.cptr ab) ldab (CI.cptr afb) ldafb (CI.cptr equed) (CI.cptr s) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let spbtrf ~layout ~uplo ~n ~kd ~ab ~ldab =
  lapacke_spbtrf layout uplo n kd (CI.cptr ab) ldab

let dpbtrf ~layout ~uplo ~n ~kd ~ab ~ldab =
  lapacke_dpbtrf layout uplo n kd (CI.cptr ab) ldab

let cpbtrf ~layout ~uplo ~n ~kd ~ab ~ldab =
  lapacke_cpbtrf layout uplo n kd (CI.cptr ab) ldab

let zpbtrf ~layout ~uplo ~n ~kd ~ab ~ldab =
  lapacke_zpbtrf layout uplo n kd (CI.cptr ab) ldab

let spbtrs ~layout ~uplo ~n ~kd ~nrhs ~ab ~ldab ~b ~ldb =
  lapacke_spbtrs layout uplo n kd nrhs (CI.cptr ab) ldab (CI.cptr b) ldb

let dpbtrs ~layout ~uplo ~n ~kd ~nrhs ~ab ~ldab ~b ~ldb =
  lapacke_dpbtrs layout uplo n kd nrhs (CI.cptr ab) ldab (CI.cptr b) ldb

let cpbtrs ~layout ~uplo ~n ~kd ~nrhs ~ab ~ldab ~b ~ldb =
  lapacke_cpbtrs layout uplo n kd nrhs (CI.cptr ab) ldab (CI.cptr b) ldb

let zpbtrs ~layout ~uplo ~n ~kd ~nrhs ~ab ~ldab ~b ~ldb =
  lapacke_zpbtrs layout uplo n kd nrhs (CI.cptr ab) ldab (CI.cptr b) ldb

let spftrf ~layout ~transr ~uplo ~n ~a =
  lapacke_spftrf layout transr uplo n (CI.cptr a)

let dpftrf ~layout ~transr ~uplo ~n ~a =
  lapacke_dpftrf layout transr uplo n (CI.cptr a)

let cpftrf ~layout ~transr ~uplo ~n ~a =
  lapacke_cpftrf layout transr uplo n (CI.cptr a)

let zpftrf ~layout ~transr ~uplo ~n ~a =
  lapacke_zpftrf layout transr uplo n (CI.cptr a)

let spftri ~layout ~transr ~uplo ~n ~a =
  lapacke_spftri layout transr uplo n (CI.cptr a)

let dpftri ~layout ~transr ~uplo ~n ~a =
  lapacke_dpftri layout transr uplo n (CI.cptr a)

let cpftri ~layout ~transr ~uplo ~n ~a =
  lapacke_cpftri layout transr uplo n (CI.cptr a)

let zpftri ~layout ~transr ~uplo ~n ~a =
  lapacke_zpftri layout transr uplo n (CI.cptr a)

let spftrs ~layout ~transr ~uplo ~n ~nrhs ~a ~b ~ldb =
  lapacke_spftrs layout transr uplo n nrhs (CI.cptr a) (CI.cptr b) ldb

let dpftrs ~layout ~transr ~uplo ~n ~nrhs ~a ~b ~ldb =
  lapacke_dpftrs layout transr uplo n nrhs (CI.cptr a) (CI.cptr b) ldb

let cpftrs ~layout ~transr ~uplo ~n ~nrhs ~a ~b ~ldb =
  lapacke_cpftrs layout transr uplo n nrhs (CI.cptr a) (CI.cptr b) ldb

let zpftrs ~layout ~transr ~uplo ~n ~nrhs ~a ~b ~ldb =
  lapacke_zpftrs layout transr uplo n nrhs (CI.cptr a) (CI.cptr b) ldb

let spocon ~layout ~uplo ~n ~a ~lda ~anorm ~rcond =
  lapacke_spocon layout uplo n (CI.cptr a) lda anorm (CI.cptr rcond)

let dpocon ~layout ~uplo ~n ~a ~lda ~anorm ~rcond =
  lapacke_dpocon layout uplo n (CI.cptr a) lda anorm (CI.cptr rcond)

let cpocon ~layout ~uplo ~n ~a ~lda ~anorm ~rcond =
  lapacke_cpocon layout uplo n (CI.cptr a) lda anorm (CI.cptr rcond)

let zpocon ~layout ~uplo ~n ~a ~lda ~anorm ~rcond =
  lapacke_zpocon layout uplo n (CI.cptr a) lda anorm (CI.cptr rcond)

let spoequ ~layout ~n ~a ~lda ~s ~scond ~amax =
  lapacke_spoequ layout n (CI.cptr a) lda (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let dpoequ ~layout ~n ~a ~lda ~s ~scond ~amax =
  lapacke_dpoequ layout n (CI.cptr a) lda (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let cpoequ ~layout ~n ~a ~lda ~s ~scond ~amax =
  lapacke_cpoequ layout n (CI.cptr a) lda (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let zpoequ ~layout ~n ~a ~lda ~s ~scond ~amax =
  lapacke_zpoequ layout n (CI.cptr a) lda (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let spoequb ~layout ~n ~a ~lda ~s ~scond ~amax =
  lapacke_spoequb layout n (CI.cptr a) lda (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let dpoequb ~layout ~n ~a ~lda ~s ~scond ~amax =
  lapacke_dpoequb layout n (CI.cptr a) lda (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let cpoequb ~layout ~n ~a ~lda ~s ~scond ~amax =
  lapacke_cpoequb layout n (CI.cptr a) lda (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let zpoequb ~layout ~n ~a ~lda ~s ~scond ~amax =
  lapacke_zpoequb layout n (CI.cptr a) lda (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let sporfs ~layout ~uplo ~n ~nrhs ~a ~lda ~af ~ldaf ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_sporfs layout uplo n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let dporfs ~layout ~uplo ~n ~nrhs ~a ~lda ~af ~ldaf ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_dporfs layout uplo n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let cporfs ~layout ~uplo ~n ~nrhs ~a ~lda ~af ~ldaf ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_cporfs layout uplo n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let zporfs ~layout ~uplo ~n ~nrhs ~a ~lda ~af ~ldaf ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_zporfs layout uplo n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let sposv ~layout ~uplo ~n ~nrhs ~a ~lda ~b ~ldb =
  lapacke_sposv layout uplo n nrhs (CI.cptr a) lda (CI.cptr b) ldb

let dposv ~layout ~uplo ~n ~nrhs ~a ~lda ~b ~ldb =
  lapacke_dposv layout uplo n nrhs (CI.cptr a) lda (CI.cptr b) ldb

let cposv ~layout ~uplo ~n ~nrhs ~a ~lda ~b ~ldb =
  lapacke_cposv layout uplo n nrhs (CI.cptr a) lda (CI.cptr b) ldb

let zposv ~layout ~uplo ~n ~nrhs ~a ~lda ~b ~ldb =
  lapacke_zposv layout uplo n nrhs (CI.cptr a) lda (CI.cptr b) ldb

let dsposv ~layout ~uplo ~n ~nrhs ~a ~lda ~b ~ldb ~x ~ldx ~iter =
  lapacke_dsposv layout uplo n nrhs (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr iter)

let zcposv ~layout ~uplo ~n ~nrhs ~a ~lda ~b ~ldb ~x ~ldx ~iter =
  lapacke_zcposv layout uplo n nrhs (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr iter)

let sposvx ~layout ~fact ~uplo ~n ~nrhs ~a ~lda ~af ~ldaf ~equed ~s ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_sposvx layout fact uplo n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr equed) (CI.cptr s) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let dposvx ~layout ~fact ~uplo ~n ~nrhs ~a ~lda ~af ~ldaf ~equed ~s ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_dposvx layout fact uplo n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr equed) (CI.cptr s) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let cposvx ~layout ~fact ~uplo ~n ~nrhs ~a ~lda ~af ~ldaf ~equed ~s ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_cposvx layout fact uplo n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr equed) (CI.cptr s) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let zposvx ~layout ~fact ~uplo ~n ~nrhs ~a ~lda ~af ~ldaf ~equed ~s ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_zposvx layout fact uplo n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr equed) (CI.cptr s) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let spotrf2 ~layout ~uplo ~n ~a ~lda =
  lapacke_spotrf2 layout uplo n (CI.cptr a) lda

let dpotrf2 ~layout ~uplo ~n ~a ~lda =
  lapacke_dpotrf2 layout uplo n (CI.cptr a) lda

let cpotrf2 ~layout ~uplo ~n ~a ~lda =
  lapacke_cpotrf2 layout uplo n (CI.cptr a) lda

let zpotrf2 ~layout ~uplo ~n ~a ~lda =
  lapacke_zpotrf2 layout uplo n (CI.cptr a) lda

let spotrf ~layout ~uplo ~n ~a ~lda =
  lapacke_spotrf layout uplo n (CI.cptr a) lda

let dpotrf ~layout ~uplo ~n ~a ~lda =
  lapacke_dpotrf layout uplo n (CI.cptr a) lda

let cpotrf ~layout ~uplo ~n ~a ~lda =
  lapacke_cpotrf layout uplo n (CI.cptr a) lda

let zpotrf ~layout ~uplo ~n ~a ~lda =
  lapacke_zpotrf layout uplo n (CI.cptr a) lda

let spotri ~layout ~uplo ~n ~a ~lda =
  lapacke_spotri layout uplo n (CI.cptr a) lda

let dpotri ~layout ~uplo ~n ~a ~lda =
  lapacke_dpotri layout uplo n (CI.cptr a) lda

let cpotri ~layout ~uplo ~n ~a ~lda =
  lapacke_cpotri layout uplo n (CI.cptr a) lda

let zpotri ~layout ~uplo ~n ~a ~lda =
  lapacke_zpotri layout uplo n (CI.cptr a) lda

let spotrs ~layout ~uplo ~n ~nrhs ~a ~lda ~b ~ldb =
  lapacke_spotrs layout uplo n nrhs (CI.cptr a) lda (CI.cptr b) ldb

let dpotrs ~layout ~uplo ~n ~nrhs ~a ~lda ~b ~ldb =
  lapacke_dpotrs layout uplo n nrhs (CI.cptr a) lda (CI.cptr b) ldb

let cpotrs ~layout ~uplo ~n ~nrhs ~a ~lda ~b ~ldb =
  lapacke_cpotrs layout uplo n nrhs (CI.cptr a) lda (CI.cptr b) ldb

let zpotrs ~layout ~uplo ~n ~nrhs ~a ~lda ~b ~ldb =
  lapacke_zpotrs layout uplo n nrhs (CI.cptr a) lda (CI.cptr b) ldb

let sppcon ~layout ~uplo ~n ~ap ~anorm ~rcond =
  lapacke_sppcon layout uplo n (CI.cptr ap) anorm (CI.cptr rcond)

let dppcon ~layout ~uplo ~n ~ap ~anorm ~rcond =
  lapacke_dppcon layout uplo n (CI.cptr ap) anorm (CI.cptr rcond)

let cppcon ~layout ~uplo ~n ~ap ~anorm ~rcond =
  lapacke_cppcon layout uplo n (CI.cptr ap) anorm (CI.cptr rcond)

let zppcon ~layout ~uplo ~n ~ap ~anorm ~rcond =
  lapacke_zppcon layout uplo n (CI.cptr ap) anorm (CI.cptr rcond)

let sppequ ~layout ~uplo ~n ~ap ~s ~scond ~amax =
  lapacke_sppequ layout uplo n (CI.cptr ap) (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let dppequ ~layout ~uplo ~n ~ap ~s ~scond ~amax =
  lapacke_dppequ layout uplo n (CI.cptr ap) (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let cppequ ~layout ~uplo ~n ~ap ~s ~scond ~amax =
  lapacke_cppequ layout uplo n (CI.cptr ap) (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let zppequ ~layout ~uplo ~n ~ap ~s ~scond ~amax =
  lapacke_zppequ layout uplo n (CI.cptr ap) (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let spprfs ~layout ~uplo ~n ~nrhs ~ap ~afp ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_spprfs layout uplo n nrhs (CI.cptr ap) (CI.cptr afp) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let dpprfs ~layout ~uplo ~n ~nrhs ~ap ~afp ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_dpprfs layout uplo n nrhs (CI.cptr ap) (CI.cptr afp) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let cpprfs ~layout ~uplo ~n ~nrhs ~ap ~afp ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_cpprfs layout uplo n nrhs (CI.cptr ap) (CI.cptr afp) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let zpprfs ~layout ~uplo ~n ~nrhs ~ap ~afp ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_zpprfs layout uplo n nrhs (CI.cptr ap) (CI.cptr afp) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let sppsv ~layout ~uplo ~n ~nrhs ~ap ~b ~ldb =
  lapacke_sppsv layout uplo n nrhs (CI.cptr ap) (CI.cptr b) ldb

let dppsv ~layout ~uplo ~n ~nrhs ~ap ~b ~ldb =
  lapacke_dppsv layout uplo n nrhs (CI.cptr ap) (CI.cptr b) ldb

let cppsv ~layout ~uplo ~n ~nrhs ~ap ~b ~ldb =
  lapacke_cppsv layout uplo n nrhs (CI.cptr ap) (CI.cptr b) ldb

let zppsv ~layout ~uplo ~n ~nrhs ~ap ~b ~ldb =
  lapacke_zppsv layout uplo n nrhs (CI.cptr ap) (CI.cptr b) ldb

let sppsvx ~layout ~fact ~uplo ~n ~nrhs ~ap ~afp ~equed ~s ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_sppsvx layout fact uplo n nrhs (CI.cptr ap) (CI.cptr afp) (CI.cptr equed) (CI.cptr s) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let dppsvx ~layout ~fact ~uplo ~n ~nrhs ~ap ~afp ~equed ~s ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_dppsvx layout fact uplo n nrhs (CI.cptr ap) (CI.cptr afp) (CI.cptr equed) (CI.cptr s) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let cppsvx ~layout ~fact ~uplo ~n ~nrhs ~ap ~afp ~equed ~s ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_cppsvx layout fact uplo n nrhs (CI.cptr ap) (CI.cptr afp) (CI.cptr equed) (CI.cptr s) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let zppsvx ~layout ~fact ~uplo ~n ~nrhs ~ap ~afp ~equed ~s ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_zppsvx layout fact uplo n nrhs (CI.cptr ap) (CI.cptr afp) (CI.cptr equed) (CI.cptr s) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let spptrf ~layout ~uplo ~n ~ap =
  lapacke_spptrf layout uplo n (CI.cptr ap)

let dpptrf ~layout ~uplo ~n ~ap =
  lapacke_dpptrf layout uplo n (CI.cptr ap)

let cpptrf ~layout ~uplo ~n ~ap =
  lapacke_cpptrf layout uplo n (CI.cptr ap)

let zpptrf ~layout ~uplo ~n ~ap =
  lapacke_zpptrf layout uplo n (CI.cptr ap)

let spptri ~layout ~uplo ~n ~ap =
  lapacke_spptri layout uplo n (CI.cptr ap)

let dpptri ~layout ~uplo ~n ~ap =
  lapacke_dpptri layout uplo n (CI.cptr ap)

let cpptri ~layout ~uplo ~n ~ap =
  lapacke_cpptri layout uplo n (CI.cptr ap)

let zpptri ~layout ~uplo ~n ~ap =
  lapacke_zpptri layout uplo n (CI.cptr ap)

let spptrs ~layout ~uplo ~n ~nrhs ~ap ~b ~ldb =
  lapacke_spptrs layout uplo n nrhs (CI.cptr ap) (CI.cptr b) ldb

let dpptrs ~layout ~uplo ~n ~nrhs ~ap ~b ~ldb =
  lapacke_dpptrs layout uplo n nrhs (CI.cptr ap) (CI.cptr b) ldb

let cpptrs ~layout ~uplo ~n ~nrhs ~ap ~b ~ldb =
  lapacke_cpptrs layout uplo n nrhs (CI.cptr ap) (CI.cptr b) ldb

let zpptrs ~layout ~uplo ~n ~nrhs ~ap ~b ~ldb =
  lapacke_zpptrs layout uplo n nrhs (CI.cptr ap) (CI.cptr b) ldb

let spstrf ~layout ~uplo ~n ~a ~lda ~piv ~rank ~tol =
  lapacke_spstrf layout uplo n (CI.cptr a) lda (CI.cptr piv) (CI.cptr rank) tol

let dpstrf ~layout ~uplo ~n ~a ~lda ~piv ~rank ~tol =
  lapacke_dpstrf layout uplo n (CI.cptr a) lda (CI.cptr piv) (CI.cptr rank) tol

let cpstrf ~layout ~uplo ~n ~a ~lda ~piv ~rank ~tol =
  lapacke_cpstrf layout uplo n (CI.cptr a) lda (CI.cptr piv) (CI.cptr rank) tol

let zpstrf ~layout ~uplo ~n ~a ~lda ~piv ~rank ~tol =
  lapacke_zpstrf layout uplo n (CI.cptr a) lda (CI.cptr piv) (CI.cptr rank) tol

let sptcon ~n ~d ~e ~anorm ~rcond =
  lapacke_sptcon n (CI.cptr d) (CI.cptr e) anorm (CI.cptr rcond)

let dptcon ~n ~d ~e ~anorm ~rcond =
  lapacke_dptcon n (CI.cptr d) (CI.cptr e) anorm (CI.cptr rcond)

let cptcon ~n ~d ~e ~anorm ~rcond =
  lapacke_cptcon n (CI.cptr d) (CI.cptr e) anorm (CI.cptr rcond)

let zptcon ~n ~d ~e ~anorm ~rcond =
  lapacke_zptcon n (CI.cptr d) (CI.cptr e) anorm (CI.cptr rcond)

let spteqr ~layout ~compz ~n ~d ~e ~z ~ldz =
  lapacke_spteqr layout compz n (CI.cptr d) (CI.cptr e) (CI.cptr z) ldz

let dpteqr ~layout ~compz ~n ~d ~e ~z ~ldz =
  lapacke_dpteqr layout compz n (CI.cptr d) (CI.cptr e) (CI.cptr z) ldz

let cpteqr ~layout ~compz ~n ~d ~e ~z ~ldz =
  lapacke_cpteqr layout compz n (CI.cptr d) (CI.cptr e) (CI.cptr z) ldz

let zpteqr ~layout ~compz ~n ~d ~e ~z ~ldz =
  lapacke_zpteqr layout compz n (CI.cptr d) (CI.cptr e) (CI.cptr z) ldz

let sptrfs ~layout ~n ~nrhs ~d ~e ~df ~ef ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_sptrfs layout n nrhs (CI.cptr d) (CI.cptr e) (CI.cptr df) (CI.cptr ef) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let dptrfs ~layout ~n ~nrhs ~d ~e ~df ~ef ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_dptrfs layout n nrhs (CI.cptr d) (CI.cptr e) (CI.cptr df) (CI.cptr ef) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let cptrfs ~layout ~uplo ~n ~nrhs ~d ~e ~df ~ef ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_cptrfs layout uplo n nrhs (CI.cptr d) (CI.cptr e) (CI.cptr df) (CI.cptr ef) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let zptrfs ~layout ~uplo ~n ~nrhs ~d ~e ~df ~ef ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_zptrfs layout uplo n nrhs (CI.cptr d) (CI.cptr e) (CI.cptr df) (CI.cptr ef) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let sptsv ~layout ~n ~nrhs ~d ~e ~b ~ldb =
  lapacke_sptsv layout n nrhs (CI.cptr d) (CI.cptr e) (CI.cptr b) ldb

let dptsv ~layout ~n ~nrhs ~d ~e ~b ~ldb =
  lapacke_dptsv layout n nrhs (CI.cptr d) (CI.cptr e) (CI.cptr b) ldb

let cptsv ~layout ~n ~nrhs ~d ~e ~b ~ldb =
  lapacke_cptsv layout n nrhs (CI.cptr d) (CI.cptr e) (CI.cptr b) ldb

let zptsv ~layout ~n ~nrhs ~d ~e ~b ~ldb =
  lapacke_zptsv layout n nrhs (CI.cptr d) (CI.cptr e) (CI.cptr b) ldb

let sptsvx ~layout ~fact ~n ~nrhs ~d ~e ~df ~ef ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_sptsvx layout fact n nrhs (CI.cptr d) (CI.cptr e) (CI.cptr df) (CI.cptr ef) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let dptsvx ~layout ~fact ~n ~nrhs ~d ~e ~df ~ef ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_dptsvx layout fact n nrhs (CI.cptr d) (CI.cptr e) (CI.cptr df) (CI.cptr ef) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let cptsvx ~layout ~fact ~n ~nrhs ~d ~e ~df ~ef ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_cptsvx layout fact n nrhs (CI.cptr d) (CI.cptr e) (CI.cptr df) (CI.cptr ef) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let zptsvx ~layout ~fact ~n ~nrhs ~d ~e ~df ~ef ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_zptsvx layout fact n nrhs (CI.cptr d) (CI.cptr e) (CI.cptr df) (CI.cptr ef) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let spttrf ~n ~d ~e =
  lapacke_spttrf n (CI.cptr d) (CI.cptr e)

let dpttrf ~n ~d ~e =
  lapacke_dpttrf n (CI.cptr d) (CI.cptr e)

let cpttrf ~n ~d ~e =
  lapacke_cpttrf n (CI.cptr d) (CI.cptr e)

let zpttrf ~n ~d ~e =
  lapacke_zpttrf n (CI.cptr d) (CI.cptr e)

let spttrs ~layout ~n ~nrhs ~d ~e ~b ~ldb =
  lapacke_spttrs layout n nrhs (CI.cptr d) (CI.cptr e) (CI.cptr b) ldb

let dpttrs ~layout ~n ~nrhs ~d ~e ~b ~ldb =
  lapacke_dpttrs layout n nrhs (CI.cptr d) (CI.cptr e) (CI.cptr b) ldb

let cpttrs ~layout ~uplo ~n ~nrhs ~d ~e ~b ~ldb =
  lapacke_cpttrs layout uplo n nrhs (CI.cptr d) (CI.cptr e) (CI.cptr b) ldb

let zpttrs ~layout ~uplo ~n ~nrhs ~d ~e ~b ~ldb =
  lapacke_zpttrs layout uplo n nrhs (CI.cptr d) (CI.cptr e) (CI.cptr b) ldb

let ssbev ~layout ~jobz ~uplo ~n ~kd ~ab ~ldab ~w ~z ~ldz =
  lapacke_ssbev layout jobz uplo n kd (CI.cptr ab) ldab (CI.cptr w) (CI.cptr z) ldz

let dsbev ~layout ~jobz ~uplo ~n ~kd ~ab ~ldab ~w ~z ~ldz =
  lapacke_dsbev layout jobz uplo n kd (CI.cptr ab) ldab (CI.cptr w) (CI.cptr z) ldz

let ssbevd ~layout ~jobz ~uplo ~n ~kd ~ab ~ldab ~w ~z ~ldz =
  lapacke_ssbevd layout jobz uplo n kd (CI.cptr ab) ldab (CI.cptr w) (CI.cptr z) ldz

let dsbevd ~layout ~jobz ~uplo ~n ~kd ~ab ~ldab ~w ~z ~ldz =
  lapacke_dsbevd layout jobz uplo n kd (CI.cptr ab) ldab (CI.cptr w) (CI.cptr z) ldz

let ssbevx ~layout ~jobz ~range ~uplo ~n ~kd ~ab ~ldab ~q ~ldq ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_ssbevx layout jobz range uplo n kd (CI.cptr ab) ldab (CI.cptr q) ldq vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let dsbevx ~layout ~jobz ~range ~uplo ~n ~kd ~ab ~ldab ~q ~ldq ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_dsbevx layout jobz range uplo n kd (CI.cptr ab) ldab (CI.cptr q) ldq vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let ssbgst ~layout ~vect ~uplo ~n ~ka ~kb ~ab ~ldab ~bb ~ldbb ~x ~ldx =
  lapacke_ssbgst layout vect uplo n ka kb (CI.cptr ab) ldab (CI.cptr bb) ldbb (CI.cptr x) ldx

let dsbgst ~layout ~vect ~uplo ~n ~ka ~kb ~ab ~ldab ~bb ~ldbb ~x ~ldx =
  lapacke_dsbgst layout vect uplo n ka kb (CI.cptr ab) ldab (CI.cptr bb) ldbb (CI.cptr x) ldx

let ssbgv ~layout ~jobz ~uplo ~n ~ka ~kb ~ab ~ldab ~bb ~ldbb ~w ~z ~ldz =
  lapacke_ssbgv layout jobz uplo n ka kb (CI.cptr ab) ldab (CI.cptr bb) ldbb (CI.cptr w) (CI.cptr z) ldz

let dsbgv ~layout ~jobz ~uplo ~n ~ka ~kb ~ab ~ldab ~bb ~ldbb ~w ~z ~ldz =
  lapacke_dsbgv layout jobz uplo n ka kb (CI.cptr ab) ldab (CI.cptr bb) ldbb (CI.cptr w) (CI.cptr z) ldz

let ssbgvd ~layout ~jobz ~uplo ~n ~ka ~kb ~ab ~ldab ~bb ~ldbb ~w ~z ~ldz =
  lapacke_ssbgvd layout jobz uplo n ka kb (CI.cptr ab) ldab (CI.cptr bb) ldbb (CI.cptr w) (CI.cptr z) ldz

let dsbgvd ~layout ~jobz ~uplo ~n ~ka ~kb ~ab ~ldab ~bb ~ldbb ~w ~z ~ldz =
  lapacke_dsbgvd layout jobz uplo n ka kb (CI.cptr ab) ldab (CI.cptr bb) ldbb (CI.cptr w) (CI.cptr z) ldz

let ssbgvx ~layout ~jobz ~range ~uplo ~n ~ka ~kb ~ab ~ldab ~bb ~ldbb ~q ~ldq ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_ssbgvx layout jobz range uplo n ka kb (CI.cptr ab) ldab (CI.cptr bb) ldbb (CI.cptr q) ldq vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let dsbgvx ~layout ~jobz ~range ~uplo ~n ~ka ~kb ~ab ~ldab ~bb ~ldbb ~q ~ldq ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_dsbgvx layout jobz range uplo n ka kb (CI.cptr ab) ldab (CI.cptr bb) ldbb (CI.cptr q) ldq vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let ssbtrd ~layout ~vect ~uplo ~n ~kd ~ab ~ldab ~d ~e ~q ~ldq =
  lapacke_ssbtrd layout vect uplo n kd (CI.cptr ab) ldab (CI.cptr d) (CI.cptr e) (CI.cptr q) ldq

let dsbtrd ~layout ~vect ~uplo ~n ~kd ~ab ~ldab ~d ~e ~q ~ldq =
  lapacke_dsbtrd layout vect uplo n kd (CI.cptr ab) ldab (CI.cptr d) (CI.cptr e) (CI.cptr q) ldq

let ssfrk ~layout ~transr ~uplo ~trans ~n ~k ~alpha ~a ~lda ~beta ~c =
  lapacke_ssfrk layout transr uplo trans n k alpha (CI.cptr a) lda beta (CI.cptr c)

let dsfrk ~layout ~transr ~uplo ~trans ~n ~k ~alpha ~a ~lda ~beta ~c =
  lapacke_dsfrk layout transr uplo trans n k alpha (CI.cptr a) lda beta (CI.cptr c)

let sspcon ~layout ~uplo ~n ~ap ~ipiv ~anorm ~rcond =
  lapacke_sspcon layout uplo n (CI.cptr ap) (CI.cptr ipiv) anorm (CI.cptr rcond)

let dspcon ~layout ~uplo ~n ~ap ~ipiv ~anorm ~rcond =
  lapacke_dspcon layout uplo n (CI.cptr ap) (CI.cptr ipiv) anorm (CI.cptr rcond)

let cspcon ~layout ~uplo ~n ~ap ~ipiv ~anorm ~rcond =
  lapacke_cspcon layout uplo n (CI.cptr ap) (CI.cptr ipiv) anorm (CI.cptr rcond)

let zspcon ~layout ~uplo ~n ~ap ~ipiv ~anorm ~rcond =
  lapacke_zspcon layout uplo n (CI.cptr ap) (CI.cptr ipiv) anorm (CI.cptr rcond)

let sspev ~layout ~jobz ~uplo ~n ~ap ~w ~z ~ldz =
  lapacke_sspev layout jobz uplo n (CI.cptr ap) (CI.cptr w) (CI.cptr z) ldz

let dspev ~layout ~jobz ~uplo ~n ~ap ~w ~z ~ldz =
  lapacke_dspev layout jobz uplo n (CI.cptr ap) (CI.cptr w) (CI.cptr z) ldz

let sspevd ~layout ~jobz ~uplo ~n ~ap ~w ~z ~ldz =
  lapacke_sspevd layout jobz uplo n (CI.cptr ap) (CI.cptr w) (CI.cptr z) ldz

let dspevd ~layout ~jobz ~uplo ~n ~ap ~w ~z ~ldz =
  lapacke_dspevd layout jobz uplo n (CI.cptr ap) (CI.cptr w) (CI.cptr z) ldz

let sspevx ~layout ~jobz ~range ~uplo ~n ~ap ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_sspevx layout jobz range uplo n (CI.cptr ap) vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let dspevx ~layout ~jobz ~range ~uplo ~n ~ap ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_dspevx layout jobz range uplo n (CI.cptr ap) vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let sspgst ~layout ~ityp ~uplo ~n ~ap ~bp =
  lapacke_sspgst layout ityp uplo n (CI.cptr ap) (CI.cptr bp)

let dspgst ~layout ~ityp ~uplo ~n ~ap ~bp =
  lapacke_dspgst layout ityp uplo n (CI.cptr ap) (CI.cptr bp)

let sspgv ~layout ~ityp ~jobz ~uplo ~n ~ap ~bp ~w ~z ~ldz =
  lapacke_sspgv layout ityp jobz uplo n (CI.cptr ap) (CI.cptr bp) (CI.cptr w) (CI.cptr z) ldz

let dspgv ~layout ~ityp ~jobz ~uplo ~n ~ap ~bp ~w ~z ~ldz =
  lapacke_dspgv layout ityp jobz uplo n (CI.cptr ap) (CI.cptr bp) (CI.cptr w) (CI.cptr z) ldz

let sspgvd ~layout ~ityp ~jobz ~uplo ~n ~ap ~bp ~w ~z ~ldz =
  lapacke_sspgvd layout ityp jobz uplo n (CI.cptr ap) (CI.cptr bp) (CI.cptr w) (CI.cptr z) ldz

let dspgvd ~layout ~ityp ~jobz ~uplo ~n ~ap ~bp ~w ~z ~ldz =
  lapacke_dspgvd layout ityp jobz uplo n (CI.cptr ap) (CI.cptr bp) (CI.cptr w) (CI.cptr z) ldz

let sspgvx ~layout ~ityp ~jobz ~range ~uplo ~n ~ap ~bp ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_sspgvx layout ityp jobz range uplo n (CI.cptr ap) (CI.cptr bp) vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let dspgvx ~layout ~ityp ~jobz ~range ~uplo ~n ~ap ~bp ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_dspgvx layout ityp jobz range uplo n (CI.cptr ap) (CI.cptr bp) vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let ssprfs ~layout ~uplo ~n ~nrhs ~ap ~afp ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_ssprfs layout uplo n nrhs (CI.cptr ap) (CI.cptr afp) (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let dsprfs ~layout ~uplo ~n ~nrhs ~ap ~afp ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_dsprfs layout uplo n nrhs (CI.cptr ap) (CI.cptr afp) (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let csprfs ~layout ~uplo ~n ~nrhs ~ap ~afp ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_csprfs layout uplo n nrhs (CI.cptr ap) (CI.cptr afp) (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let zsprfs ~layout ~uplo ~n ~nrhs ~ap ~afp ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_zsprfs layout uplo n nrhs (CI.cptr ap) (CI.cptr afp) (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let sspsv ~layout ~uplo ~n ~nrhs ~ap ~ipiv ~b ~ldb =
  lapacke_sspsv layout uplo n nrhs (CI.cptr ap) (CI.cptr ipiv) (CI.cptr b) ldb

let dspsv ~layout ~uplo ~n ~nrhs ~ap ~ipiv ~b ~ldb =
  lapacke_dspsv layout uplo n nrhs (CI.cptr ap) (CI.cptr ipiv) (CI.cptr b) ldb

let cspsv ~layout ~uplo ~n ~nrhs ~ap ~ipiv ~b ~ldb =
  lapacke_cspsv layout uplo n nrhs (CI.cptr ap) (CI.cptr ipiv) (CI.cptr b) ldb

let zspsv ~layout ~uplo ~n ~nrhs ~ap ~ipiv ~b ~ldb =
  lapacke_zspsv layout uplo n nrhs (CI.cptr ap) (CI.cptr ipiv) (CI.cptr b) ldb

let sspsvx ~layout ~fact ~uplo ~n ~nrhs ~ap ~afp ~ipiv ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_sspsvx layout fact uplo n nrhs (CI.cptr ap) (CI.cptr afp) (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let dspsvx ~layout ~fact ~uplo ~n ~nrhs ~ap ~afp ~ipiv ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_dspsvx layout fact uplo n nrhs (CI.cptr ap) (CI.cptr afp) (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let cspsvx ~layout ~fact ~uplo ~n ~nrhs ~ap ~afp ~ipiv ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_cspsvx layout fact uplo n nrhs (CI.cptr ap) (CI.cptr afp) (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let zspsvx ~layout ~fact ~uplo ~n ~nrhs ~ap ~afp ~ipiv ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_zspsvx layout fact uplo n nrhs (CI.cptr ap) (CI.cptr afp) (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let ssptrd ~layout ~uplo ~n ~ap ~d ~e ~tau =
  lapacke_ssptrd layout uplo n (CI.cptr ap) (CI.cptr d) (CI.cptr e) (CI.cptr tau)

let dsptrd ~layout ~uplo ~n ~ap ~d ~e ~tau =
  lapacke_dsptrd layout uplo n (CI.cptr ap) (CI.cptr d) (CI.cptr e) (CI.cptr tau)

let ssptrf ~layout ~uplo ~n ~ap ~ipiv =
  lapacke_ssptrf layout uplo n (CI.cptr ap) (CI.cptr ipiv)

let dsptrf ~layout ~uplo ~n ~ap ~ipiv =
  lapacke_dsptrf layout uplo n (CI.cptr ap) (CI.cptr ipiv)

let csptrf ~layout ~uplo ~n ~ap ~ipiv =
  lapacke_csptrf layout uplo n (CI.cptr ap) (CI.cptr ipiv)

let zsptrf ~layout ~uplo ~n ~ap ~ipiv =
  lapacke_zsptrf layout uplo n (CI.cptr ap) (CI.cptr ipiv)

let ssptri ~layout ~uplo ~n ~ap ~ipiv =
  lapacke_ssptri layout uplo n (CI.cptr ap) (CI.cptr ipiv)

let dsptri ~layout ~uplo ~n ~ap ~ipiv =
  lapacke_dsptri layout uplo n (CI.cptr ap) (CI.cptr ipiv)

let csptri ~layout ~uplo ~n ~ap ~ipiv =
  lapacke_csptri layout uplo n (CI.cptr ap) (CI.cptr ipiv)

let zsptri ~layout ~uplo ~n ~ap ~ipiv =
  lapacke_zsptri layout uplo n (CI.cptr ap) (CI.cptr ipiv)

let ssptrs ~layout ~uplo ~n ~nrhs ~ap ~ipiv ~b ~ldb =
  lapacke_ssptrs layout uplo n nrhs (CI.cptr ap) (CI.cptr ipiv) (CI.cptr b) ldb

let dsptrs ~layout ~uplo ~n ~nrhs ~ap ~ipiv ~b ~ldb =
  lapacke_dsptrs layout uplo n nrhs (CI.cptr ap) (CI.cptr ipiv) (CI.cptr b) ldb

let csptrs ~layout ~uplo ~n ~nrhs ~ap ~ipiv ~b ~ldb =
  lapacke_csptrs layout uplo n nrhs (CI.cptr ap) (CI.cptr ipiv) (CI.cptr b) ldb

let zsptrs ~layout ~uplo ~n ~nrhs ~ap ~ipiv ~b ~ldb =
  lapacke_zsptrs layout uplo n nrhs (CI.cptr ap) (CI.cptr ipiv) (CI.cptr b) ldb

let sstebz ~range ~order ~n ~vl ~vu ~il ~iu ~abstol ~d ~e ~m ~nsplit ~w ~iblock ~isplit =
  lapacke_sstebz range order n vl vu il iu abstol (CI.cptr d) (CI.cptr e) (CI.cptr m) (CI.cptr nsplit) (CI.cptr w) (CI.cptr iblock) (CI.cptr isplit)

let dstebz ~range ~order ~n ~vl ~vu ~il ~iu ~abstol ~d ~e ~m ~nsplit ~w ~iblock ~isplit =
  lapacke_dstebz range order n vl vu il iu abstol (CI.cptr d) (CI.cptr e) (CI.cptr m) (CI.cptr nsplit) (CI.cptr w) (CI.cptr iblock) (CI.cptr isplit)

let sstedc ~layout ~compz ~n ~d ~e ~z ~ldz =
  lapacke_sstedc layout compz n (CI.cptr d) (CI.cptr e) (CI.cptr z) ldz

let dstedc ~layout ~compz ~n ~d ~e ~z ~ldz =
  lapacke_dstedc layout compz n (CI.cptr d) (CI.cptr e) (CI.cptr z) ldz

let cstedc ~layout ~compz ~n ~d ~e ~z ~ldz =
  lapacke_cstedc layout compz n (CI.cptr d) (CI.cptr e) (CI.cptr z) ldz

let zstedc ~layout ~compz ~n ~d ~e ~z ~ldz =
  lapacke_zstedc layout compz n (CI.cptr d) (CI.cptr e) (CI.cptr z) ldz

let sstegr ~layout ~jobz ~range ~n ~d ~e ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~isuppz =
  lapacke_sstegr layout jobz range n (CI.cptr d) (CI.cptr e) vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr isuppz)

let dstegr ~layout ~jobz ~range ~n ~d ~e ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~isuppz =
  lapacke_dstegr layout jobz range n (CI.cptr d) (CI.cptr e) vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr isuppz)

let cstegr ~layout ~jobz ~range ~n ~d ~e ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~isuppz =
  lapacke_cstegr layout jobz range n (CI.cptr d) (CI.cptr e) vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr isuppz)

let zstegr ~layout ~jobz ~range ~n ~d ~e ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~isuppz =
  lapacke_zstegr layout jobz range n (CI.cptr d) (CI.cptr e) vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr isuppz)

let sstein ~layout ~n ~d ~e ~m ~w ~iblock ~isplit ~z ~ldz ~ifailv =
  lapacke_sstein layout n (CI.cptr d) (CI.cptr e) m (CI.cptr w) (CI.cptr iblock) (CI.cptr isplit) (CI.cptr z) ldz (CI.cptr ifailv)

let dstein ~layout ~n ~d ~e ~m ~w ~iblock ~isplit ~z ~ldz ~ifailv =
  lapacke_dstein layout n (CI.cptr d) (CI.cptr e) m (CI.cptr w) (CI.cptr iblock) (CI.cptr isplit) (CI.cptr z) ldz (CI.cptr ifailv)

let cstein ~layout ~n ~d ~e ~m ~w ~iblock ~isplit ~z ~ldz ~ifailv =
  lapacke_cstein layout n (CI.cptr d) (CI.cptr e) m (CI.cptr w) (CI.cptr iblock) (CI.cptr isplit) (CI.cptr z) ldz (CI.cptr ifailv)

let zstein ~layout ~n ~d ~e ~m ~w ~iblock ~isplit ~z ~ldz ~ifailv =
  lapacke_zstein layout n (CI.cptr d) (CI.cptr e) m (CI.cptr w) (CI.cptr iblock) (CI.cptr isplit) (CI.cptr z) ldz (CI.cptr ifailv)

let sstemr ~layout ~jobz ~range ~n ~d ~e ~vl ~vu ~il ~iu ~m ~w ~z ~ldz ~nzc ~isuppz ~tryrac =
  lapacke_sstemr layout jobz range n (CI.cptr d) (CI.cptr e) vl vu il iu (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz nzc (CI.cptr isuppz) (CI.cptr tryrac)

let dstemr ~layout ~jobz ~range ~n ~d ~e ~vl ~vu ~il ~iu ~m ~w ~z ~ldz ~nzc ~isuppz ~tryrac =
  lapacke_dstemr layout jobz range n (CI.cptr d) (CI.cptr e) vl vu il iu (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz nzc (CI.cptr isuppz) (CI.cptr tryrac)

let cstemr ~layout ~jobz ~range ~n ~d ~e ~vl ~vu ~il ~iu ~m ~w ~z ~ldz ~nzc ~isuppz ~tryrac =
  lapacke_cstemr layout jobz range n (CI.cptr d) (CI.cptr e) vl vu il iu (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz nzc (CI.cptr isuppz) (CI.cptr tryrac)

let zstemr ~layout ~jobz ~range ~n ~d ~e ~vl ~vu ~il ~iu ~m ~w ~z ~ldz ~nzc ~isuppz ~tryrac =
  lapacke_zstemr layout jobz range n (CI.cptr d) (CI.cptr e) vl vu il iu (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz nzc (CI.cptr isuppz) (CI.cptr tryrac)

let ssteqr ~layout ~compz ~n ~d ~e ~z ~ldz =
  lapacke_ssteqr layout compz n (CI.cptr d) (CI.cptr e) (CI.cptr z) ldz

let dsteqr ~layout ~compz ~n ~d ~e ~z ~ldz =
  lapacke_dsteqr layout compz n (CI.cptr d) (CI.cptr e) (CI.cptr z) ldz

let csteqr ~layout ~compz ~n ~d ~e ~z ~ldz =
  lapacke_csteqr layout compz n (CI.cptr d) (CI.cptr e) (CI.cptr z) ldz

let zsteqr ~layout ~compz ~n ~d ~e ~z ~ldz =
  lapacke_zsteqr layout compz n (CI.cptr d) (CI.cptr e) (CI.cptr z) ldz

let ssterf ~n ~d ~e =
  lapacke_ssterf n (CI.cptr d) (CI.cptr e)

let dsterf ~n ~d ~e =
  lapacke_dsterf n (CI.cptr d) (CI.cptr e)

let sstev ~layout ~jobz ~n ~d ~e ~z ~ldz =
  lapacke_sstev layout jobz n (CI.cptr d) (CI.cptr e) (CI.cptr z) ldz

let dstev ~layout ~jobz ~n ~d ~e ~z ~ldz =
  lapacke_dstev layout jobz n (CI.cptr d) (CI.cptr e) (CI.cptr z) ldz

let sstevd ~layout ~jobz ~n ~d ~e ~z ~ldz =
  lapacke_sstevd layout jobz n (CI.cptr d) (CI.cptr e) (CI.cptr z) ldz

let dstevd ~layout ~jobz ~n ~d ~e ~z ~ldz =
  lapacke_dstevd layout jobz n (CI.cptr d) (CI.cptr e) (CI.cptr z) ldz

let sstevr ~layout ~jobz ~range ~n ~d ~e ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~isuppz =
  lapacke_sstevr layout jobz range n (CI.cptr d) (CI.cptr e) vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr isuppz)

let dstevr ~layout ~jobz ~range ~n ~d ~e ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~isuppz =
  lapacke_dstevr layout jobz range n (CI.cptr d) (CI.cptr e) vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr isuppz)

let sstevx ~layout ~jobz ~range ~n ~d ~e ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_sstevx layout jobz range n (CI.cptr d) (CI.cptr e) vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let dstevx ~layout ~jobz ~range ~n ~d ~e ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_dstevx layout jobz range n (CI.cptr d) (CI.cptr e) vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let ssycon ~layout ~uplo ~n ~a ~lda ~ipiv ~anorm ~rcond =
  lapacke_ssycon layout uplo n (CI.cptr a) lda (CI.cptr ipiv) anorm (CI.cptr rcond)

let dsycon ~layout ~uplo ~n ~a ~lda ~ipiv ~anorm ~rcond =
  lapacke_dsycon layout uplo n (CI.cptr a) lda (CI.cptr ipiv) anorm (CI.cptr rcond)

let csycon ~layout ~uplo ~n ~a ~lda ~ipiv ~anorm ~rcond =
  lapacke_csycon layout uplo n (CI.cptr a) lda (CI.cptr ipiv) anorm (CI.cptr rcond)

let zsycon ~layout ~uplo ~n ~a ~lda ~ipiv ~anorm ~rcond =
  lapacke_zsycon layout uplo n (CI.cptr a) lda (CI.cptr ipiv) anorm (CI.cptr rcond)

let ssyequb ~layout ~uplo ~n ~a ~lda ~s ~scond ~amax =
  lapacke_ssyequb layout uplo n (CI.cptr a) lda (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let dsyequb ~layout ~uplo ~n ~a ~lda ~s ~scond ~amax =
  lapacke_dsyequb layout uplo n (CI.cptr a) lda (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let csyequb ~layout ~uplo ~n ~a ~lda ~s ~scond ~amax =
  lapacke_csyequb layout uplo n (CI.cptr a) lda (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let zsyequb ~layout ~uplo ~n ~a ~lda ~s ~scond ~amax =
  lapacke_zsyequb layout uplo n (CI.cptr a) lda (CI.cptr s) (CI.cptr scond) (CI.cptr amax)

let ssyev ~layout ~jobz ~uplo ~n ~a ~lda ~w =
  lapacke_ssyev layout jobz uplo n (CI.cptr a) lda (CI.cptr w)

let dsyev ~layout ~jobz ~uplo ~n ~a ~lda ~w =
  lapacke_dsyev layout jobz uplo n (CI.cptr a) lda (CI.cptr w)

let ssyevd ~layout ~jobz ~uplo ~n ~a ~lda ~w =
  lapacke_ssyevd layout jobz uplo n (CI.cptr a) lda (CI.cptr w)

let dsyevd ~layout ~jobz ~uplo ~n ~a ~lda ~w =
  lapacke_dsyevd layout jobz uplo n (CI.cptr a) lda (CI.cptr w)

let ssyevr ~layout ~jobz ~range ~uplo ~n ~a ~lda ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~isuppz =
  lapacke_ssyevr layout jobz range uplo n (CI.cptr a) lda vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr isuppz)

let dsyevr ~layout ~jobz ~range ~uplo ~n ~a ~lda ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~isuppz =
  lapacke_dsyevr layout jobz range uplo n (CI.cptr a) lda vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr isuppz)

let ssyevx ~layout ~jobz ~range ~uplo ~n ~a ~lda ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_ssyevx layout jobz range uplo n (CI.cptr a) lda vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let dsyevx ~layout ~jobz ~range ~uplo ~n ~a ~lda ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_dsyevx layout jobz range uplo n (CI.cptr a) lda vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let ssygst ~layout ~ityp ~uplo ~n ~a ~lda ~b ~ldb =
  lapacke_ssygst layout ityp uplo n (CI.cptr a) lda (CI.cptr b) ldb

let dsygst ~layout ~ityp ~uplo ~n ~a ~lda ~b ~ldb =
  lapacke_dsygst layout ityp uplo n (CI.cptr a) lda (CI.cptr b) ldb

let ssygv ~layout ~ityp ~jobz ~uplo ~n ~a ~lda ~b ~ldb ~w =
  lapacke_ssygv layout ityp jobz uplo n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr w)

let dsygv ~layout ~ityp ~jobz ~uplo ~n ~a ~lda ~b ~ldb ~w =
  lapacke_dsygv layout ityp jobz uplo n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr w)

let ssygvd ~layout ~ityp ~jobz ~uplo ~n ~a ~lda ~b ~ldb ~w =
  lapacke_ssygvd layout ityp jobz uplo n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr w)

let dsygvd ~layout ~ityp ~jobz ~uplo ~n ~a ~lda ~b ~ldb ~w =
  lapacke_dsygvd layout ityp jobz uplo n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr w)

let ssygvx ~layout ~ityp ~jobz ~range ~uplo ~n ~a ~lda ~b ~ldb ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_ssygvx layout ityp jobz range uplo n (CI.cptr a) lda (CI.cptr b) ldb vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let dsygvx ~layout ~ityp ~jobz ~range ~uplo ~n ~a ~lda ~b ~ldb ~vl ~vu ~il ~iu ~abstol ~m ~w ~z ~ldz ~ifail =
  lapacke_dsygvx layout ityp jobz range uplo n (CI.cptr a) lda (CI.cptr b) ldb vl vu il iu abstol (CI.cptr m) (CI.cptr w) (CI.cptr z) ldz (CI.cptr ifail)

let ssyrfs ~layout ~uplo ~n ~nrhs ~a ~lda ~af ~ldaf ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_ssyrfs layout uplo n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let dsyrfs ~layout ~uplo ~n ~nrhs ~a ~lda ~af ~ldaf ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_dsyrfs layout uplo n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let csyrfs ~layout ~uplo ~n ~nrhs ~a ~lda ~af ~ldaf ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_csyrfs layout uplo n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let zsyrfs ~layout ~uplo ~n ~nrhs ~a ~lda ~af ~ldaf ~ipiv ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_zsyrfs layout uplo n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let ssysv ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_ssysv layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let dsysv ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_dsysv layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let csysv ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_csysv layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let zsysv ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_zsysv layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let ssysvx ~layout ~fact ~uplo ~n ~nrhs ~a ~lda ~af ~ldaf ~ipiv ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_ssysvx layout fact uplo n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let dsysvx ~layout ~fact ~uplo ~n ~nrhs ~a ~lda ~af ~ldaf ~ipiv ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_dsysvx layout fact uplo n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let csysvx ~layout ~fact ~uplo ~n ~nrhs ~a ~lda ~af ~ldaf ~ipiv ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_csysvx layout fact uplo n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let zsysvx ~layout ~fact ~uplo ~n ~nrhs ~a ~lda ~af ~ldaf ~ipiv ~b ~ldb ~x ~ldx ~rcond ~ferr ~berr =
  lapacke_zsysvx layout fact uplo n nrhs (CI.cptr a) lda (CI.cptr af) ldaf (CI.cptr ipiv) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr rcond) (CI.cptr ferr) (CI.cptr berr)

let ssytrd ~layout ~uplo ~n ~a ~lda ~d ~e ~tau =
  lapacke_ssytrd layout uplo n (CI.cptr a) lda (CI.cptr d) (CI.cptr e) (CI.cptr tau)

let dsytrd ~layout ~uplo ~n ~a ~lda ~d ~e ~tau =
  lapacke_dsytrd layout uplo n (CI.cptr a) lda (CI.cptr d) (CI.cptr e) (CI.cptr tau)

let ssytrf ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_ssytrf layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let dsytrf ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_dsytrf layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let csytrf ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_csytrf layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let zsytrf ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_zsytrf layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let ssytri ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_ssytri layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let dsytri ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_dsytri layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let csytri ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_csytri layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let zsytri ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_zsytri layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let ssytrs ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_ssytrs layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let dsytrs ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_dsytrs layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let csytrs ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_csytrs layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let zsytrs ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_zsytrs layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let stbcon ~layout ~norm ~uplo ~diag ~n ~kd ~ab ~ldab ~rcond =
  lapacke_stbcon layout norm uplo diag n kd (CI.cptr ab) ldab (CI.cptr rcond)

let dtbcon ~layout ~norm ~uplo ~diag ~n ~kd ~ab ~ldab ~rcond =
  lapacke_dtbcon layout norm uplo diag n kd (CI.cptr ab) ldab (CI.cptr rcond)

let ctbcon ~layout ~norm ~uplo ~diag ~n ~kd ~ab ~ldab ~rcond =
  lapacke_ctbcon layout norm uplo diag n kd (CI.cptr ab) ldab (CI.cptr rcond)

let ztbcon ~layout ~norm ~uplo ~diag ~n ~kd ~ab ~ldab ~rcond =
  lapacke_ztbcon layout norm uplo diag n kd (CI.cptr ab) ldab (CI.cptr rcond)

let stbrfs ~layout ~uplo ~trans ~diag ~n ~kd ~nrhs ~ab ~ldab ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_stbrfs layout uplo trans diag n kd nrhs (CI.cptr ab) ldab (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let dtbrfs ~layout ~uplo ~trans ~diag ~n ~kd ~nrhs ~ab ~ldab ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_dtbrfs layout uplo trans diag n kd nrhs (CI.cptr ab) ldab (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let ctbrfs ~layout ~uplo ~trans ~diag ~n ~kd ~nrhs ~ab ~ldab ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_ctbrfs layout uplo trans diag n kd nrhs (CI.cptr ab) ldab (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let ztbrfs ~layout ~uplo ~trans ~diag ~n ~kd ~nrhs ~ab ~ldab ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_ztbrfs layout uplo trans diag n kd nrhs (CI.cptr ab) ldab (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let stbtrs ~layout ~uplo ~trans ~diag ~n ~kd ~nrhs ~ab ~ldab ~b ~ldb =
  lapacke_stbtrs layout uplo trans diag n kd nrhs (CI.cptr ab) ldab (CI.cptr b) ldb

let dtbtrs ~layout ~uplo ~trans ~diag ~n ~kd ~nrhs ~ab ~ldab ~b ~ldb =
  lapacke_dtbtrs layout uplo trans diag n kd nrhs (CI.cptr ab) ldab (CI.cptr b) ldb

let ctbtrs ~layout ~uplo ~trans ~diag ~n ~kd ~nrhs ~ab ~ldab ~b ~ldb =
  lapacke_ctbtrs layout uplo trans diag n kd nrhs (CI.cptr ab) ldab (CI.cptr b) ldb

let ztbtrs ~layout ~uplo ~trans ~diag ~n ~kd ~nrhs ~ab ~ldab ~b ~ldb =
  lapacke_ztbtrs layout uplo trans diag n kd nrhs (CI.cptr ab) ldab (CI.cptr b) ldb

let stfsm ~layout ~transr ~side ~uplo ~trans ~diag ~m ~n ~alpha ~a ~b ~ldb =
  lapacke_stfsm layout transr side uplo trans diag m n alpha (CI.cptr a) (CI.cptr b) ldb

let dtfsm ~layout ~transr ~side ~uplo ~trans ~diag ~m ~n ~alpha ~a ~b ~ldb =
  lapacke_dtfsm layout transr side uplo trans diag m n alpha (CI.cptr a) (CI.cptr b) ldb

let ctfsm ~layout ~transr ~side ~uplo ~trans ~diag ~m ~n ~alpha ~a ~b ~ldb =
  lapacke_ctfsm layout transr side uplo trans diag m n alpha (CI.cptr a) (CI.cptr b) ldb

let ztfsm ~layout ~transr ~side ~uplo ~trans ~diag ~m ~n ~alpha ~a ~b ~ldb =
  lapacke_ztfsm layout transr side uplo trans diag m n alpha (CI.cptr a) (CI.cptr b) ldb

let stftri ~layout ~transr ~uplo ~diag ~n ~a =
  lapacke_stftri layout transr uplo diag n (CI.cptr a)

let dtftri ~layout ~transr ~uplo ~diag ~n ~a =
  lapacke_dtftri layout transr uplo diag n (CI.cptr a)

let ctftri ~layout ~transr ~uplo ~diag ~n ~a =
  lapacke_ctftri layout transr uplo diag n (CI.cptr a)

let ztftri ~layout ~transr ~uplo ~diag ~n ~a =
  lapacke_ztftri layout transr uplo diag n (CI.cptr a)

let stfttp ~layout ~transr ~uplo ~n ~arf ~ap =
  lapacke_stfttp layout transr uplo n (CI.cptr arf) (CI.cptr ap)

let dtfttp ~layout ~transr ~uplo ~n ~arf ~ap =
  lapacke_dtfttp layout transr uplo n (CI.cptr arf) (CI.cptr ap)

let ctfttp ~layout ~transr ~uplo ~n ~arf ~ap =
  lapacke_ctfttp layout transr uplo n (CI.cptr arf) (CI.cptr ap)

let ztfttp ~layout ~transr ~uplo ~n ~arf ~ap =
  lapacke_ztfttp layout transr uplo n (CI.cptr arf) (CI.cptr ap)

let stfttr ~layout ~transr ~uplo ~n ~arf ~a ~lda =
  lapacke_stfttr layout transr uplo n (CI.cptr arf) (CI.cptr a) lda

let dtfttr ~layout ~transr ~uplo ~n ~arf ~a ~lda =
  lapacke_dtfttr layout transr uplo n (CI.cptr arf) (CI.cptr a) lda

let ctfttr ~layout ~transr ~uplo ~n ~arf ~a ~lda =
  lapacke_ctfttr layout transr uplo n (CI.cptr arf) (CI.cptr a) lda

let ztfttr ~layout ~transr ~uplo ~n ~arf ~a ~lda =
  lapacke_ztfttr layout transr uplo n (CI.cptr arf) (CI.cptr a) lda

let stgevc ~layout ~side ~howmny ~select ~n ~s ~lds ~p ~ldp ~vl ~ldvl ~vr ~ldvr ~mm ~m =
  lapacke_stgevc layout side howmny (CI.cptr select) n (CI.cptr s) lds (CI.cptr p) ldp (CI.cptr vl) ldvl (CI.cptr vr) ldvr mm (CI.cptr m)

let dtgevc ~layout ~side ~howmny ~select ~n ~s ~lds ~p ~ldp ~vl ~ldvl ~vr ~ldvr ~mm ~m =
  lapacke_dtgevc layout side howmny (CI.cptr select) n (CI.cptr s) lds (CI.cptr p) ldp (CI.cptr vl) ldvl (CI.cptr vr) ldvr mm (CI.cptr m)

let ctgevc ~layout ~side ~howmny ~select ~n ~s ~lds ~p ~ldp ~vl ~ldvl ~vr ~ldvr ~mm ~m =
  lapacke_ctgevc layout side howmny (CI.cptr select) n (CI.cptr s) lds (CI.cptr p) ldp (CI.cptr vl) ldvl (CI.cptr vr) ldvr mm (CI.cptr m)

let ztgevc ~layout ~side ~howmny ~select ~n ~s ~lds ~p ~ldp ~vl ~ldvl ~vr ~ldvr ~mm ~m =
  lapacke_ztgevc layout side howmny (CI.cptr select) n (CI.cptr s) lds (CI.cptr p) ldp (CI.cptr vl) ldvl (CI.cptr vr) ldvr mm (CI.cptr m)

let stgexc ~layout ~wantq ~wantz ~n ~a ~lda ~b ~ldb ~q ~ldq ~z ~ldz ~ifst ~ilst =
  lapacke_stgexc layout wantq wantz n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr q) ldq (CI.cptr z) ldz (CI.cptr ifst) (CI.cptr ilst)

let dtgexc ~layout ~wantq ~wantz ~n ~a ~lda ~b ~ldb ~q ~ldq ~z ~ldz ~ifst ~ilst =
  lapacke_dtgexc layout wantq wantz n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr q) ldq (CI.cptr z) ldz (CI.cptr ifst) (CI.cptr ilst)

let ctgexc ~layout ~wantq ~wantz ~n ~a ~lda ~b ~ldb ~q ~ldq ~z ~ldz ~ifst ~ilst =
  lapacke_ctgexc layout wantq wantz n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr q) ldq (CI.cptr z) ldz ifst ilst

let ztgexc ~layout ~wantq ~wantz ~n ~a ~lda ~b ~ldb ~q ~ldq ~z ~ldz ~ifst ~ilst =
  lapacke_ztgexc layout wantq wantz n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr q) ldq (CI.cptr z) ldz ifst ilst

let stgsen ~layout ~ijob ~wantq ~wantz ~select ~n ~a ~lda ~b ~ldb ~alphar ~alphai ~beta ~q ~ldq ~z ~ldz ~m ~pl ~pr ~dif =
  lapacke_stgsen layout ijob wantq wantz (CI.cptr select) n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr alphar) (CI.cptr alphai) (CI.cptr beta) (CI.cptr q) ldq (CI.cptr z) ldz (CI.cptr m) (CI.cptr pl) (CI.cptr pr) (CI.cptr dif)

let dtgsen ~layout ~ijob ~wantq ~wantz ~select ~n ~a ~lda ~b ~ldb ~alphar ~alphai ~beta ~q ~ldq ~z ~ldz ~m ~pl ~pr ~dif =
  lapacke_dtgsen layout ijob wantq wantz (CI.cptr select) n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr alphar) (CI.cptr alphai) (CI.cptr beta) (CI.cptr q) ldq (CI.cptr z) ldz (CI.cptr m) (CI.cptr pl) (CI.cptr pr) (CI.cptr dif)

let ctgsen ~layout ~ijob ~wantq ~wantz ~select ~n ~a ~lda ~b ~ldb ~alpha ~beta ~q ~ldq ~z ~ldz ~m ~pl ~pr ~dif =
  lapacke_ctgsen layout ijob wantq wantz (CI.cptr select) n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr alpha) (CI.cptr beta) (CI.cptr q) ldq (CI.cptr z) ldz (CI.cptr m) (CI.cptr pl) (CI.cptr pr) (CI.cptr dif)

let ztgsen ~layout ~ijob ~wantq ~wantz ~select ~n ~a ~lda ~b ~ldb ~alpha ~beta ~q ~ldq ~z ~ldz ~m ~pl ~pr ~dif =
  lapacke_ztgsen layout ijob wantq wantz (CI.cptr select) n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr alpha) (CI.cptr beta) (CI.cptr q) ldq (CI.cptr z) ldz (CI.cptr m) (CI.cptr pl) (CI.cptr pr) (CI.cptr dif)

let stgsja ~layout ~jobu ~jobv ~jobq ~m ~p ~n ~k ~l ~a ~lda ~b ~ldb ~tola ~tolb ~alpha ~beta ~u ~ldu ~v ~ldv ~q ~ldq ~ncycle =
  lapacke_stgsja layout jobu jobv jobq m p n k l (CI.cptr a) lda (CI.cptr b) ldb tola tolb (CI.cptr alpha) (CI.cptr beta) (CI.cptr u) ldu (CI.cptr v) ldv (CI.cptr q) ldq (CI.cptr ncycle)

let dtgsja ~layout ~jobu ~jobv ~jobq ~m ~p ~n ~k ~l ~a ~lda ~b ~ldb ~tola ~tolb ~alpha ~beta ~u ~ldu ~v ~ldv ~q ~ldq ~ncycle =
  lapacke_dtgsja layout jobu jobv jobq m p n k l (CI.cptr a) lda (CI.cptr b) ldb tola tolb (CI.cptr alpha) (CI.cptr beta) (CI.cptr u) ldu (CI.cptr v) ldv (CI.cptr q) ldq (CI.cptr ncycle)

let ctgsja ~layout ~jobu ~jobv ~jobq ~m ~p ~n ~k ~l ~a ~lda ~b ~ldb ~tola ~tolb ~alpha ~beta ~u ~ldu ~v ~ldv ~q ~ldq ~ncycle =
  lapacke_ctgsja layout jobu jobv jobq m p n k l (CI.cptr a) lda (CI.cptr b) ldb tola tolb (CI.cptr alpha) (CI.cptr beta) (CI.cptr u) ldu (CI.cptr v) ldv (CI.cptr q) ldq (CI.cptr ncycle)

let ztgsja ~layout ~jobu ~jobv ~jobq ~m ~p ~n ~k ~l ~a ~lda ~b ~ldb ~tola ~tolb ~alpha ~beta ~u ~ldu ~v ~ldv ~q ~ldq ~ncycle =
  lapacke_ztgsja layout jobu jobv jobq m p n k l (CI.cptr a) lda (CI.cptr b) ldb tola tolb (CI.cptr alpha) (CI.cptr beta) (CI.cptr u) ldu (CI.cptr v) ldv (CI.cptr q) ldq (CI.cptr ncycle)

let stgsna ~layout ~job ~howmny ~select ~n ~a ~lda ~b ~ldb ~vl ~ldvl ~vr ~ldvr ~s ~dif ~mm ~m =
  lapacke_stgsna layout job howmny (CI.cptr select) n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr vl) ldvl (CI.cptr vr) ldvr (CI.cptr s) (CI.cptr dif) mm (CI.cptr m)

let dtgsna ~layout ~job ~howmny ~select ~n ~a ~lda ~b ~ldb ~vl ~ldvl ~vr ~ldvr ~s ~dif ~mm ~m =
  lapacke_dtgsna layout job howmny (CI.cptr select) n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr vl) ldvl (CI.cptr vr) ldvr (CI.cptr s) (CI.cptr dif) mm (CI.cptr m)

let ctgsna ~layout ~job ~howmny ~select ~n ~a ~lda ~b ~ldb ~vl ~ldvl ~vr ~ldvr ~s ~dif ~mm ~m =
  lapacke_ctgsna layout job howmny (CI.cptr select) n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr vl) ldvl (CI.cptr vr) ldvr (CI.cptr s) (CI.cptr dif) mm (CI.cptr m)

let ztgsna ~layout ~job ~howmny ~select ~n ~a ~lda ~b ~ldb ~vl ~ldvl ~vr ~ldvr ~s ~dif ~mm ~m =
  lapacke_ztgsna layout job howmny (CI.cptr select) n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr vl) ldvl (CI.cptr vr) ldvr (CI.cptr s) (CI.cptr dif) mm (CI.cptr m)

let stgsyl ~layout ~trans ~ijob ~m ~n ~a ~lda ~b ~ldb ~c ~ldc ~d ~ldd ~e ~lde ~f ~ldf ~scale ~dif =
  lapacke_stgsyl layout trans ijob m n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr c) ldc (CI.cptr d) ldd (CI.cptr e) lde (CI.cptr f) ldf (CI.cptr scale) (CI.cptr dif)

let dtgsyl ~layout ~trans ~ijob ~m ~n ~a ~lda ~b ~ldb ~c ~ldc ~d ~ldd ~e ~lde ~f ~ldf ~scale ~dif =
  lapacke_dtgsyl layout trans ijob m n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr c) ldc (CI.cptr d) ldd (CI.cptr e) lde (CI.cptr f) ldf (CI.cptr scale) (CI.cptr dif)

let ctgsyl ~layout ~trans ~ijob ~m ~n ~a ~lda ~b ~ldb ~c ~ldc ~d ~ldd ~e ~lde ~f ~ldf ~scale ~dif =
  lapacke_ctgsyl layout trans ijob m n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr c) ldc (CI.cptr d) ldd (CI.cptr e) lde (CI.cptr f) ldf (CI.cptr scale) (CI.cptr dif)

let ztgsyl ~layout ~trans ~ijob ~m ~n ~a ~lda ~b ~ldb ~c ~ldc ~d ~ldd ~e ~lde ~f ~ldf ~scale ~dif =
  lapacke_ztgsyl layout trans ijob m n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr c) ldc (CI.cptr d) ldd (CI.cptr e) lde (CI.cptr f) ldf (CI.cptr scale) (CI.cptr dif)

let stpcon ~layout ~norm ~uplo ~diag ~n ~ap ~rcond =
  lapacke_stpcon layout norm uplo diag n (CI.cptr ap) (CI.cptr rcond)

let dtpcon ~layout ~norm ~uplo ~diag ~n ~ap ~rcond =
  lapacke_dtpcon layout norm uplo diag n (CI.cptr ap) (CI.cptr rcond)

let ctpcon ~layout ~norm ~uplo ~diag ~n ~ap ~rcond =
  lapacke_ctpcon layout norm uplo diag n (CI.cptr ap) (CI.cptr rcond)

let ztpcon ~layout ~norm ~uplo ~diag ~n ~ap ~rcond =
  lapacke_ztpcon layout norm uplo diag n (CI.cptr ap) (CI.cptr rcond)

let stprfs ~layout ~uplo ~trans ~diag ~n ~nrhs ~ap ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_stprfs layout uplo trans diag n nrhs (CI.cptr ap) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let dtprfs ~layout ~uplo ~trans ~diag ~n ~nrhs ~ap ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_dtprfs layout uplo trans diag n nrhs (CI.cptr ap) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let ctprfs ~layout ~uplo ~trans ~diag ~n ~nrhs ~ap ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_ctprfs layout uplo trans diag n nrhs (CI.cptr ap) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let ztprfs ~layout ~uplo ~trans ~diag ~n ~nrhs ~ap ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_ztprfs layout uplo trans diag n nrhs (CI.cptr ap) (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let stptri ~layout ~uplo ~diag ~n ~ap =
  lapacke_stptri layout uplo diag n (CI.cptr ap)

let dtptri ~layout ~uplo ~diag ~n ~ap =
  lapacke_dtptri layout uplo diag n (CI.cptr ap)

let ctptri ~layout ~uplo ~diag ~n ~ap =
  lapacke_ctptri layout uplo diag n (CI.cptr ap)

let ztptri ~layout ~uplo ~diag ~n ~ap =
  lapacke_ztptri layout uplo diag n (CI.cptr ap)

let stptrs ~layout ~uplo ~trans ~diag ~n ~nrhs ~ap ~b ~ldb =
  lapacke_stptrs layout uplo trans diag n nrhs (CI.cptr ap) (CI.cptr b) ldb

let dtptrs ~layout ~uplo ~trans ~diag ~n ~nrhs ~ap ~b ~ldb =
  lapacke_dtptrs layout uplo trans diag n nrhs (CI.cptr ap) (CI.cptr b) ldb

let ctptrs ~layout ~uplo ~trans ~diag ~n ~nrhs ~ap ~b ~ldb =
  lapacke_ctptrs layout uplo trans diag n nrhs (CI.cptr ap) (CI.cptr b) ldb

let ztptrs ~layout ~uplo ~trans ~diag ~n ~nrhs ~ap ~b ~ldb =
  lapacke_ztptrs layout uplo trans diag n nrhs (CI.cptr ap) (CI.cptr b) ldb

let stpttf ~layout ~transr ~uplo ~n ~ap ~arf =
  lapacke_stpttf layout transr uplo n (CI.cptr ap) (CI.cptr arf)

let dtpttf ~layout ~transr ~uplo ~n ~ap ~arf =
  lapacke_dtpttf layout transr uplo n (CI.cptr ap) (CI.cptr arf)

let ctpttf ~layout ~transr ~uplo ~n ~ap ~arf =
  lapacke_ctpttf layout transr uplo n (CI.cptr ap) (CI.cptr arf)

let ztpttf ~layout ~transr ~uplo ~n ~ap ~arf =
  lapacke_ztpttf layout transr uplo n (CI.cptr ap) (CI.cptr arf)

let stpttr ~layout ~uplo ~n ~ap ~a ~lda =
  lapacke_stpttr layout uplo n (CI.cptr ap) (CI.cptr a) lda

let dtpttr ~layout ~uplo ~n ~ap ~a ~lda =
  lapacke_dtpttr layout uplo n (CI.cptr ap) (CI.cptr a) lda

let ctpttr ~layout ~uplo ~n ~ap ~a ~lda =
  lapacke_ctpttr layout uplo n (CI.cptr ap) (CI.cptr a) lda

let ztpttr ~layout ~uplo ~n ~ap ~a ~lda =
  lapacke_ztpttr layout uplo n (CI.cptr ap) (CI.cptr a) lda

let strcon ~layout ~norm ~uplo ~diag ~n ~a ~lda ~rcond =
  lapacke_strcon layout norm uplo diag n (CI.cptr a) lda (CI.cptr rcond)

let dtrcon ~layout ~norm ~uplo ~diag ~n ~a ~lda ~rcond =
  lapacke_dtrcon layout norm uplo diag n (CI.cptr a) lda (CI.cptr rcond)

let ctrcon ~layout ~norm ~uplo ~diag ~n ~a ~lda ~rcond =
  lapacke_ctrcon layout norm uplo diag n (CI.cptr a) lda (CI.cptr rcond)

let ztrcon ~layout ~norm ~uplo ~diag ~n ~a ~lda ~rcond =
  lapacke_ztrcon layout norm uplo diag n (CI.cptr a) lda (CI.cptr rcond)

let strevc ~layout ~side ~howmny ~select ~n ~t ~ldt ~vl ~ldvl ~vr ~ldvr ~mm ~m =
  lapacke_strevc layout side howmny (CI.cptr select) n (CI.cptr t) ldt (CI.cptr vl) ldvl (CI.cptr vr) ldvr mm (CI.cptr m)

let dtrevc ~layout ~side ~howmny ~select ~n ~t ~ldt ~vl ~ldvl ~vr ~ldvr ~mm ~m =
  lapacke_dtrevc layout side howmny (CI.cptr select) n (CI.cptr t) ldt (CI.cptr vl) ldvl (CI.cptr vr) ldvr mm (CI.cptr m)

let ctrevc ~layout ~side ~howmny ~select ~n ~t ~ldt ~vl ~ldvl ~vr ~ldvr ~mm ~m =
  lapacke_ctrevc layout side howmny (CI.cptr select) n (CI.cptr t) ldt (CI.cptr vl) ldvl (CI.cptr vr) ldvr mm (CI.cptr m)

let ztrevc ~layout ~side ~howmny ~select ~n ~t ~ldt ~vl ~ldvl ~vr ~ldvr ~mm ~m =
  lapacke_ztrevc layout side howmny (CI.cptr select) n (CI.cptr t) ldt (CI.cptr vl) ldvl (CI.cptr vr) ldvr mm (CI.cptr m)

let strexc ~layout ~compq ~n ~t ~ldt ~q ~ldq ~ifst ~ilst =
  lapacke_strexc layout compq n (CI.cptr t) ldt (CI.cptr q) ldq (CI.cptr ifst) (CI.cptr ilst)

let dtrexc ~layout ~compq ~n ~t ~ldt ~q ~ldq ~ifst ~ilst =
  lapacke_dtrexc layout compq n (CI.cptr t) ldt (CI.cptr q) ldq (CI.cptr ifst) (CI.cptr ilst)

let ctrexc ~layout ~compq ~n ~t ~ldt ~q ~ldq ~ifst ~ilst =
  lapacke_ctrexc layout compq n (CI.cptr t) ldt (CI.cptr q) ldq ifst ilst

let ztrexc ~layout ~compq ~n ~t ~ldt ~q ~ldq ~ifst ~ilst =
  lapacke_ztrexc layout compq n (CI.cptr t) ldt (CI.cptr q) ldq ifst ilst

let strrfs ~layout ~uplo ~trans ~diag ~n ~nrhs ~a ~lda ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_strrfs layout uplo trans diag n nrhs (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let dtrrfs ~layout ~uplo ~trans ~diag ~n ~nrhs ~a ~lda ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_dtrrfs layout uplo trans diag n nrhs (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let ctrrfs ~layout ~uplo ~trans ~diag ~n ~nrhs ~a ~lda ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_ctrrfs layout uplo trans diag n nrhs (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let ztrrfs ~layout ~uplo ~trans ~diag ~n ~nrhs ~a ~lda ~b ~ldb ~x ~ldx ~ferr ~berr =
  lapacke_ztrrfs layout uplo trans diag n nrhs (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr x) ldx (CI.cptr ferr) (CI.cptr berr)

let strsen ~layout ~job ~compq ~select ~n ~t ~ldt ~q ~ldq ~wr ~wi ~m ~s ~sep =
  lapacke_strsen layout job compq (CI.cptr select) n (CI.cptr t) ldt (CI.cptr q) ldq (CI.cptr wr) (CI.cptr wi) (CI.cptr m) (CI.cptr s) (CI.cptr sep)

let dtrsen ~layout ~job ~compq ~select ~n ~t ~ldt ~q ~ldq ~wr ~wi ~m ~s ~sep =
  lapacke_dtrsen layout job compq (CI.cptr select) n (CI.cptr t) ldt (CI.cptr q) ldq (CI.cptr wr) (CI.cptr wi) (CI.cptr m) (CI.cptr s) (CI.cptr sep)

let ctrsen ~layout ~job ~compq ~select ~n ~t ~ldt ~q ~ldq ~w ~m ~s ~sep =
  lapacke_ctrsen layout job compq (CI.cptr select) n (CI.cptr t) ldt (CI.cptr q) ldq (CI.cptr w) (CI.cptr m) (CI.cptr s) (CI.cptr sep)

let ztrsen ~layout ~job ~compq ~select ~n ~t ~ldt ~q ~ldq ~w ~m ~s ~sep =
  lapacke_ztrsen layout job compq (CI.cptr select) n (CI.cptr t) ldt (CI.cptr q) ldq (CI.cptr w) (CI.cptr m) (CI.cptr s) (CI.cptr sep)

let strsna ~layout ~job ~howmny ~select ~n ~t ~ldt ~vl ~ldvl ~vr ~ldvr ~s ~sep ~mm ~m =
  lapacke_strsna layout job howmny (CI.cptr select) n (CI.cptr t) ldt (CI.cptr vl) ldvl (CI.cptr vr) ldvr (CI.cptr s) (CI.cptr sep) mm (CI.cptr m)

let dtrsna ~layout ~job ~howmny ~select ~n ~t ~ldt ~vl ~ldvl ~vr ~ldvr ~s ~sep ~mm ~m =
  lapacke_dtrsna layout job howmny (CI.cptr select) n (CI.cptr t) ldt (CI.cptr vl) ldvl (CI.cptr vr) ldvr (CI.cptr s) (CI.cptr sep) mm (CI.cptr m)

let ctrsna ~layout ~job ~howmny ~select ~n ~t ~ldt ~vl ~ldvl ~vr ~ldvr ~s ~sep ~mm ~m =
  lapacke_ctrsna layout job howmny (CI.cptr select) n (CI.cptr t) ldt (CI.cptr vl) ldvl (CI.cptr vr) ldvr (CI.cptr s) (CI.cptr sep) mm (CI.cptr m)

let ztrsna ~layout ~job ~howmny ~select ~n ~t ~ldt ~vl ~ldvl ~vr ~ldvr ~s ~sep ~mm ~m =
  lapacke_ztrsna layout job howmny (CI.cptr select) n (CI.cptr t) ldt (CI.cptr vl) ldvl (CI.cptr vr) ldvr (CI.cptr s) (CI.cptr sep) mm (CI.cptr m)

let strsyl ~layout ~trana ~tranb ~isgn ~m ~n ~a ~lda ~b ~ldb ~c ~ldc ~scale =
  lapacke_strsyl layout trana tranb isgn m n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr c) ldc (CI.cptr scale)

let dtrsyl ~layout ~trana ~tranb ~isgn ~m ~n ~a ~lda ~b ~ldb ~c ~ldc ~scale =
  lapacke_dtrsyl layout trana tranb isgn m n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr c) ldc (CI.cptr scale)

let ctrsyl ~layout ~trana ~tranb ~isgn ~m ~n ~a ~lda ~b ~ldb ~c ~ldc ~scale =
  lapacke_ctrsyl layout trana tranb isgn m n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr c) ldc (CI.cptr scale)

let ztrsyl ~layout ~trana ~tranb ~isgn ~m ~n ~a ~lda ~b ~ldb ~c ~ldc ~scale =
  lapacke_ztrsyl layout trana tranb isgn m n (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr c) ldc (CI.cptr scale)

let strtri ~layout ~uplo ~diag ~n ~a ~lda =
  lapacke_strtri layout uplo diag n (CI.cptr a) lda

let dtrtri ~layout ~uplo ~diag ~n ~a ~lda =
  lapacke_dtrtri layout uplo diag n (CI.cptr a) lda

let ctrtri ~layout ~uplo ~diag ~n ~a ~lda =
  lapacke_ctrtri layout uplo diag n (CI.cptr a) lda

let ztrtri ~layout ~uplo ~diag ~n ~a ~lda =
  lapacke_ztrtri layout uplo diag n (CI.cptr a) lda

let strtrs ~layout ~uplo ~trans ~diag ~n ~nrhs ~a ~lda ~b ~ldb =
  lapacke_strtrs layout uplo trans diag n nrhs (CI.cptr a) lda (CI.cptr b) ldb

let dtrtrs ~layout ~uplo ~trans ~diag ~n ~nrhs ~a ~lda ~b ~ldb =
  lapacke_dtrtrs layout uplo trans diag n nrhs (CI.cptr a) lda (CI.cptr b) ldb

let ctrtrs ~layout ~uplo ~trans ~diag ~n ~nrhs ~a ~lda ~b ~ldb =
  lapacke_ctrtrs layout uplo trans diag n nrhs (CI.cptr a) lda (CI.cptr b) ldb

let ztrtrs ~layout ~uplo ~trans ~diag ~n ~nrhs ~a ~lda ~b ~ldb =
  lapacke_ztrtrs layout uplo trans diag n nrhs (CI.cptr a) lda (CI.cptr b) ldb

let strttf ~layout ~transr ~uplo ~n ~a ~lda ~arf =
  lapacke_strttf layout transr uplo n (CI.cptr a) lda (CI.cptr arf)

let dtrttf ~layout ~transr ~uplo ~n ~a ~lda ~arf =
  lapacke_dtrttf layout transr uplo n (CI.cptr a) lda (CI.cptr arf)

let ctrttf ~layout ~transr ~uplo ~n ~a ~lda ~arf =
  lapacke_ctrttf layout transr uplo n (CI.cptr a) lda (CI.cptr arf)

let ztrttf ~layout ~transr ~uplo ~n ~a ~lda ~arf =
  lapacke_ztrttf layout transr uplo n (CI.cptr a) lda (CI.cptr arf)

let strttp ~layout ~uplo ~n ~a ~lda ~ap =
  lapacke_strttp layout uplo n (CI.cptr a) lda (CI.cptr ap)

let dtrttp ~layout ~uplo ~n ~a ~lda ~ap =
  lapacke_dtrttp layout uplo n (CI.cptr a) lda (CI.cptr ap)

let ctrttp ~layout ~uplo ~n ~a ~lda ~ap =
  lapacke_ctrttp layout uplo n (CI.cptr a) lda (CI.cptr ap)

let ztrttp ~layout ~uplo ~n ~a ~lda ~ap =
  lapacke_ztrttp layout uplo n (CI.cptr a) lda (CI.cptr ap)

let stzrzf ~layout ~m ~n ~a ~lda ~tau =
  lapacke_stzrzf layout m n (CI.cptr a) lda (CI.cptr tau)

let dtzrzf ~layout ~m ~n ~a ~lda ~tau =
  lapacke_dtzrzf layout m n (CI.cptr a) lda (CI.cptr tau)

let ctzrzf ~layout ~m ~n ~a ~lda ~tau =
  lapacke_ctzrzf layout m n (CI.cptr a) lda (CI.cptr tau)

let ztzrzf ~layout ~m ~n ~a ~lda ~tau =
  lapacke_ztzrzf layout m n (CI.cptr a) lda (CI.cptr tau)

let cungbr ~layout ~vect ~m ~n ~k ~a ~lda ~tau =
  lapacke_cungbr layout vect m n k (CI.cptr a) lda (CI.cptr tau)

let zungbr ~layout ~vect ~m ~n ~k ~a ~lda ~tau =
  lapacke_zungbr layout vect m n k (CI.cptr a) lda (CI.cptr tau)

let cunghr ~layout ~n ~ilo ~ihi ~a ~lda ~tau =
  lapacke_cunghr layout n ilo ihi (CI.cptr a) lda (CI.cptr tau)

let zunghr ~layout ~n ~ilo ~ihi ~a ~lda ~tau =
  lapacke_zunghr layout n ilo ihi (CI.cptr a) lda (CI.cptr tau)

let cunglq ~layout ~m ~n ~k ~a ~lda ~tau =
  lapacke_cunglq layout m n k (CI.cptr a) lda (CI.cptr tau)

let zunglq ~layout ~m ~n ~k ~a ~lda ~tau =
  lapacke_zunglq layout m n k (CI.cptr a) lda (CI.cptr tau)

let cungql ~layout ~m ~n ~k ~a ~lda ~tau =
  lapacke_cungql layout m n k (CI.cptr a) lda (CI.cptr tau)

let zungql ~layout ~m ~n ~k ~a ~lda ~tau =
  lapacke_zungql layout m n k (CI.cptr a) lda (CI.cptr tau)

let cungqr ~layout ~m ~n ~k ~a ~lda ~tau =
  lapacke_cungqr layout m n k (CI.cptr a) lda (CI.cptr tau)

let zungqr ~layout ~m ~n ~k ~a ~lda ~tau =
  lapacke_zungqr layout m n k (CI.cptr a) lda (CI.cptr tau)

let cungrq ~layout ~m ~n ~k ~a ~lda ~tau =
  lapacke_cungrq layout m n k (CI.cptr a) lda (CI.cptr tau)

let zungrq ~layout ~m ~n ~k ~a ~lda ~tau =
  lapacke_zungrq layout m n k (CI.cptr a) lda (CI.cptr tau)

let cungtr ~layout ~uplo ~n ~a ~lda ~tau =
  lapacke_cungtr layout uplo n (CI.cptr a) lda (CI.cptr tau)

let zungtr ~layout ~uplo ~n ~a ~lda ~tau =
  lapacke_zungtr layout uplo n (CI.cptr a) lda (CI.cptr tau)

let cunmbr ~layout ~vect ~side ~trans ~m ~n ~k ~a ~lda ~tau ~c ~ldc =
  lapacke_cunmbr layout vect side trans m n k (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let zunmbr ~layout ~vect ~side ~trans ~m ~n ~k ~a ~lda ~tau ~c ~ldc =
  lapacke_zunmbr layout vect side trans m n k (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let cunmhr ~layout ~side ~trans ~m ~n ~ilo ~ihi ~a ~lda ~tau ~c ~ldc =
  lapacke_cunmhr layout side trans m n ilo ihi (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let zunmhr ~layout ~side ~trans ~m ~n ~ilo ~ihi ~a ~lda ~tau ~c ~ldc =
  lapacke_zunmhr layout side trans m n ilo ihi (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let cunmlq ~layout ~side ~trans ~m ~n ~k ~a ~lda ~tau ~c ~ldc =
  lapacke_cunmlq layout side trans m n k (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let zunmlq ~layout ~side ~trans ~m ~n ~k ~a ~lda ~tau ~c ~ldc =
  lapacke_zunmlq layout side trans m n k (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let cunmql ~layout ~side ~trans ~m ~n ~k ~a ~lda ~tau ~c ~ldc =
  lapacke_cunmql layout side trans m n k (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let zunmql ~layout ~side ~trans ~m ~n ~k ~a ~lda ~tau ~c ~ldc =
  lapacke_zunmql layout side trans m n k (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let cunmqr ~layout ~side ~trans ~m ~n ~k ~a ~lda ~tau ~c ~ldc =
  lapacke_cunmqr layout side trans m n k (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let zunmqr ~layout ~side ~trans ~m ~n ~k ~a ~lda ~tau ~c ~ldc =
  lapacke_zunmqr layout side trans m n k (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let cunmrq ~layout ~side ~trans ~m ~n ~k ~a ~lda ~tau ~c ~ldc =
  lapacke_cunmrq layout side trans m n k (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let zunmrq ~layout ~side ~trans ~m ~n ~k ~a ~lda ~tau ~c ~ldc =
  lapacke_zunmrq layout side trans m n k (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let cunmrz ~layout ~side ~trans ~m ~n ~k ~l ~a ~lda ~tau ~c ~ldc =
  lapacke_cunmrz layout side trans m n k l (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let zunmrz ~layout ~side ~trans ~m ~n ~k ~l ~a ~lda ~tau ~c ~ldc =
  lapacke_zunmrz layout side trans m n k l (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let cunmtr ~layout ~side ~uplo ~trans ~m ~n ~a ~lda ~tau ~c ~ldc =
  lapacke_cunmtr layout side uplo trans m n (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let zunmtr ~layout ~side ~uplo ~trans ~m ~n ~a ~lda ~tau ~c ~ldc =
  lapacke_zunmtr layout side uplo trans m n (CI.cptr a) lda (CI.cptr tau) (CI.cptr c) ldc

let cupgtr ~layout ~uplo ~n ~ap ~tau ~q ~ldq =
  lapacke_cupgtr layout uplo n (CI.cptr ap) (CI.cptr tau) (CI.cptr q) ldq

let zupgtr ~layout ~uplo ~n ~ap ~tau ~q ~ldq =
  lapacke_zupgtr layout uplo n (CI.cptr ap) (CI.cptr tau) (CI.cptr q) ldq

let cupmtr ~layout ~side ~uplo ~trans ~m ~n ~ap ~tau ~c ~ldc =
  lapacke_cupmtr layout side uplo trans m n (CI.cptr ap) (CI.cptr tau) (CI.cptr c) ldc

let zupmtr ~layout ~side ~uplo ~trans ~m ~n ~ap ~tau ~c ~ldc =
  lapacke_zupmtr layout side uplo trans m n (CI.cptr ap) (CI.cptr tau) (CI.cptr c) ldc

let claghe ~layout ~n ~k ~d ~a ~lda ~iseed =
  lapacke_claghe layout n k (CI.cptr d) (CI.cptr a) lda (CI.cptr iseed)

let zlaghe ~layout ~n ~k ~d ~a ~lda ~iseed =
  lapacke_zlaghe layout n k (CI.cptr d) (CI.cptr a) lda (CI.cptr iseed)

let slagsy ~layout ~n ~k ~d ~a ~lda ~iseed =
  lapacke_slagsy layout n k (CI.cptr d) (CI.cptr a) lda (CI.cptr iseed)

let dlagsy ~layout ~n ~k ~d ~a ~lda ~iseed =
  lapacke_dlagsy layout n k (CI.cptr d) (CI.cptr a) lda (CI.cptr iseed)

let clagsy ~layout ~n ~k ~d ~a ~lda ~iseed =
  lapacke_clagsy layout n k (CI.cptr d) (CI.cptr a) lda (CI.cptr iseed)

let zlagsy ~layout ~n ~k ~d ~a ~lda ~iseed =
  lapacke_zlagsy layout n k (CI.cptr d) (CI.cptr a) lda (CI.cptr iseed)

let slapmr ~layout ~forwrd ~m ~n ~x ~ldx ~k =
  lapacke_slapmr layout forwrd m n (CI.cptr x) ldx (CI.cptr k)

let dlapmr ~layout ~forwrd ~m ~n ~x ~ldx ~k =
  lapacke_dlapmr layout forwrd m n (CI.cptr x) ldx (CI.cptr k)

let clapmr ~layout ~forwrd ~m ~n ~x ~ldx ~k =
  lapacke_clapmr layout forwrd m n (CI.cptr x) ldx (CI.cptr k)

let zlapmr ~layout ~forwrd ~m ~n ~x ~ldx ~k =
  lapacke_zlapmr layout forwrd m n (CI.cptr x) ldx (CI.cptr k)

let slapmt ~layout ~forwrd ~m ~n ~x ~ldx ~k =
  lapacke_slapmt layout forwrd m n (CI.cptr x) ldx (CI.cptr k)

let dlapmt ~layout ~forwrd ~m ~n ~x ~ldx ~k =
  lapacke_dlapmt layout forwrd m n (CI.cptr x) ldx (CI.cptr k)

let clapmt ~layout ~forwrd ~m ~n ~x ~ldx ~k =
  lapacke_clapmt layout forwrd m n (CI.cptr x) ldx (CI.cptr k)

let zlapmt ~layout ~forwrd ~m ~n ~x ~ldx ~k =
  lapacke_zlapmt layout forwrd m n (CI.cptr x) ldx (CI.cptr k)

let slartgp ~f ~g ~cs ~sn ~r =
  lapacke_slartgp f g (CI.cptr cs) (CI.cptr sn) (CI.cptr r)

let dlartgp ~f ~g ~cs ~sn ~r =
  lapacke_dlartgp f g (CI.cptr cs) (CI.cptr sn) (CI.cptr r)

let slartgs ~x ~y ~sigma ~cs ~sn =
  lapacke_slartgs x y sigma (CI.cptr cs) (CI.cptr sn)

let dlartgs ~x ~y ~sigma ~cs ~sn =
  lapacke_dlartgs x y sigma (CI.cptr cs) (CI.cptr sn)

let cbbcsd ~layout ~jobu1 ~jobu2 ~jobv1t ~jobv2t ~trans ~m ~p ~q ~theta ~phi ~u1 ~ldu1 ~u2 ~ldu2 ~v1t ~ldv1t ~v2t ~ldv2t ~b11d ~b11e ~b12d ~b12e ~b21d ~b21e ~b22d ~b22e =
  lapacke_cbbcsd layout jobu1 jobu2 jobv1t jobv2t trans m p q (CI.cptr theta) (CI.cptr phi) (CI.cptr u1) ldu1 (CI.cptr u2) ldu2 (CI.cptr v1t) ldv1t (CI.cptr v2t) ldv2t (CI.cptr b11d) (CI.cptr b11e) (CI.cptr b12d) (CI.cptr b12e) (CI.cptr b21d) (CI.cptr b21e) (CI.cptr b22d) (CI.cptr b22e)

let cheswapr ~layout ~uplo ~n ~a ~lda ~i1 ~i2 =
  lapacke_cheswapr layout uplo n (CI.cptr a) lda i1 i2

let chetri2 ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_chetri2 layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let chetri2x ~layout ~uplo ~n ~a ~lda ~ipiv ~nb =
  lapacke_chetri2x layout uplo n (CI.cptr a) lda (CI.cptr ipiv) nb

let chetrs2 ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_chetrs2 layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let csyconv ~layout ~uplo ~way ~n ~a ~lda ~ipiv ~e =
  lapacke_csyconv layout uplo way n (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr e)

let csyswapr ~layout ~uplo ~n ~a ~lda ~i1 ~i2 =
  lapacke_csyswapr layout uplo n (CI.cptr a) lda i1 i2

let csytri2 ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_csytri2 layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let csytri2x ~layout ~uplo ~n ~a ~lda ~ipiv ~nb =
  lapacke_csytri2x layout uplo n (CI.cptr a) lda (CI.cptr ipiv) nb

let csytrs2 ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_csytrs2 layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let cunbdb ~layout ~trans ~signs ~m ~p ~q ~x11 ~ldx11 ~x12 ~ldx12 ~x21 ~ldx21 ~x22 ~ldx22 ~theta ~phi ~taup1 ~taup2 ~tauq1 ~tauq2 =
  lapacke_cunbdb layout trans signs m p q (CI.cptr x11) ldx11 (CI.cptr x12) ldx12 (CI.cptr x21) ldx21 (CI.cptr x22) ldx22 (CI.cptr theta) (CI.cptr phi) (CI.cptr taup1) (CI.cptr taup2) (CI.cptr tauq1) (CI.cptr tauq2)

let cuncsd ~layout ~jobu1 ~jobu2 ~jobv1t ~jobv2t ~trans ~signs ~m ~p ~q ~x11 ~ldx11 ~x12 ~ldx12 ~x21 ~ldx21 ~x22 ~ldx22 ~theta ~u1 ~ldu1 ~u2 ~ldu2 ~v1t ~ldv1t ~v2t ~ldv2t =
  lapacke_cuncsd layout jobu1 jobu2 jobv1t jobv2t trans signs m p q (CI.cptr x11) ldx11 (CI.cptr x12) ldx12 (CI.cptr x21) ldx21 (CI.cptr x22) ldx22 (CI.cptr theta) (CI.cptr u1) ldu1 (CI.cptr u2) ldu2 (CI.cptr v1t) ldv1t (CI.cptr v2t) ldv2t

let cuncsd2by1 ~layout ~jobu1 ~jobu2 ~jobv1t ~m ~p ~q ~x11 ~ldx11 ~x21 ~ldx21 ~theta ~u1 ~ldu1 ~u2 ~ldu2 ~v1t ~ldv1t =
  lapacke_cuncsd2by1 layout jobu1 jobu2 jobv1t m p q (CI.cptr x11) ldx11 (CI.cptr x21) ldx21 (CI.cptr theta) (CI.cptr u1) ldu1 (CI.cptr u2) ldu2 (CI.cptr v1t) ldv1t

let dbbcsd ~layout ~jobu1 ~jobu2 ~jobv1t ~jobv2t ~trans ~m ~p ~q ~theta ~phi ~u1 ~ldu1 ~u2 ~ldu2 ~v1t ~ldv1t ~v2t ~ldv2t ~b11d ~b11e ~b12d ~b12e ~b21d ~b21e ~b22d ~b22e =
  lapacke_dbbcsd layout jobu1 jobu2 jobv1t jobv2t trans m p q (CI.cptr theta) (CI.cptr phi) (CI.cptr u1) ldu1 (CI.cptr u2) ldu2 (CI.cptr v1t) ldv1t (CI.cptr v2t) ldv2t (CI.cptr b11d) (CI.cptr b11e) (CI.cptr b12d) (CI.cptr b12e) (CI.cptr b21d) (CI.cptr b21e) (CI.cptr b22d) (CI.cptr b22e)

let dorbdb ~layout ~trans ~signs ~m ~p ~q ~x11 ~ldx11 ~x12 ~ldx12 ~x21 ~ldx21 ~x22 ~ldx22 ~theta ~phi ~taup1 ~taup2 ~tauq1 ~tauq2 =
  lapacke_dorbdb layout trans signs m p q (CI.cptr x11) ldx11 (CI.cptr x12) ldx12 (CI.cptr x21) ldx21 (CI.cptr x22) ldx22 (CI.cptr theta) (CI.cptr phi) (CI.cptr taup1) (CI.cptr taup2) (CI.cptr tauq1) (CI.cptr tauq2)

let dorcsd ~layout ~jobu1 ~jobu2 ~jobv1t ~jobv2t ~trans ~signs ~m ~p ~q ~x11 ~ldx11 ~x12 ~ldx12 ~x21 ~ldx21 ~x22 ~ldx22 ~theta ~u1 ~ldu1 ~u2 ~ldu2 ~v1t ~ldv1t ~v2t ~ldv2t =
  lapacke_dorcsd layout jobu1 jobu2 jobv1t jobv2t trans signs m p q (CI.cptr x11) ldx11 (CI.cptr x12) ldx12 (CI.cptr x21) ldx21 (CI.cptr x22) ldx22 (CI.cptr theta) (CI.cptr u1) ldu1 (CI.cptr u2) ldu2 (CI.cptr v1t) ldv1t (CI.cptr v2t) ldv2t

let dorcsd2by1 ~layout ~jobu1 ~jobu2 ~jobv1t ~m ~p ~q ~x11 ~ldx11 ~x21 ~ldx21 ~theta ~u1 ~ldu1 ~u2 ~ldu2 ~v1t ~ldv1t =
  lapacke_dorcsd2by1 layout jobu1 jobu2 jobv1t m p q (CI.cptr x11) ldx11 (CI.cptr x21) ldx21 (CI.cptr theta) (CI.cptr u1) ldu1 (CI.cptr u2) ldu2 (CI.cptr v1t) ldv1t

let dsyconv ~layout ~uplo ~way ~n ~a ~lda ~ipiv ~e =
  lapacke_dsyconv layout uplo way n (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr e)

let dsyswapr ~layout ~uplo ~n ~a ~lda ~i1 ~i2 =
  lapacke_dsyswapr layout uplo n (CI.cptr a) lda i1 i2

let dsytri2 ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_dsytri2 layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let dsytri2x ~layout ~uplo ~n ~a ~lda ~ipiv ~nb =
  lapacke_dsytri2x layout uplo n (CI.cptr a) lda (CI.cptr ipiv) nb

let dsytrs2 ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_dsytrs2 layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let sbbcsd ~layout ~jobu1 ~jobu2 ~jobv1t ~jobv2t ~trans ~m ~p ~q ~theta ~phi ~u1 ~ldu1 ~u2 ~ldu2 ~v1t ~ldv1t ~v2t ~ldv2t ~b11d ~b11e ~b12d ~b12e ~b21d ~b21e ~b22d ~b22e =
  lapacke_sbbcsd layout jobu1 jobu2 jobv1t jobv2t trans m p q (CI.cptr theta) (CI.cptr phi) (CI.cptr u1) ldu1 (CI.cptr u2) ldu2 (CI.cptr v1t) ldv1t (CI.cptr v2t) ldv2t (CI.cptr b11d) (CI.cptr b11e) (CI.cptr b12d) (CI.cptr b12e) (CI.cptr b21d) (CI.cptr b21e) (CI.cptr b22d) (CI.cptr b22e)

let sorbdb ~layout ~trans ~signs ~m ~p ~q ~x11 ~ldx11 ~x12 ~ldx12 ~x21 ~ldx21 ~x22 ~ldx22 ~theta ~phi ~taup1 ~taup2 ~tauq1 ~tauq2 =
  lapacke_sorbdb layout trans signs m p q (CI.cptr x11) ldx11 (CI.cptr x12) ldx12 (CI.cptr x21) ldx21 (CI.cptr x22) ldx22 (CI.cptr theta) (CI.cptr phi) (CI.cptr taup1) (CI.cptr taup2) (CI.cptr tauq1) (CI.cptr tauq2)

let sorcsd ~layout ~jobu1 ~jobu2 ~jobv1t ~jobv2t ~trans ~signs ~m ~p ~q ~x11 ~ldx11 ~x12 ~ldx12 ~x21 ~ldx21 ~x22 ~ldx22 ~theta ~u1 ~ldu1 ~u2 ~ldu2 ~v1t ~ldv1t ~v2t ~ldv2t =
  lapacke_sorcsd layout jobu1 jobu2 jobv1t jobv2t trans signs m p q (CI.cptr x11) ldx11 (CI.cptr x12) ldx12 (CI.cptr x21) ldx21 (CI.cptr x22) ldx22 (CI.cptr theta) (CI.cptr u1) ldu1 (CI.cptr u2) ldu2 (CI.cptr v1t) ldv1t (CI.cptr v2t) ldv2t

let sorcsd2by1 ~layout ~jobu1 ~jobu2 ~jobv1t ~m ~p ~q ~x11 ~ldx11 ~x21 ~ldx21 ~theta ~u1 ~ldu1 ~u2 ~ldu2 ~v1t ~ldv1t =
  lapacke_sorcsd2by1 layout jobu1 jobu2 jobv1t m p q (CI.cptr x11) ldx11 (CI.cptr x21) ldx21 (CI.cptr theta) (CI.cptr u1) ldu1 (CI.cptr u2) ldu2 (CI.cptr v1t) ldv1t

let ssyconv ~layout ~uplo ~way ~n ~a ~lda ~ipiv ~e =
  lapacke_ssyconv layout uplo way n (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr e)

let ssyswapr ~layout ~uplo ~n ~a ~lda ~i1 ~i2 =
  lapacke_ssyswapr layout uplo n (CI.cptr a) lda i1 i2

let ssytri2 ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_ssytri2 layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let ssytri2x ~layout ~uplo ~n ~a ~lda ~ipiv ~nb =
  lapacke_ssytri2x layout uplo n (CI.cptr a) lda (CI.cptr ipiv) nb

let ssytrs2 ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_ssytrs2 layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let zbbcsd ~layout ~jobu1 ~jobu2 ~jobv1t ~jobv2t ~trans ~m ~p ~q ~theta ~phi ~u1 ~ldu1 ~u2 ~ldu2 ~v1t ~ldv1t ~v2t ~ldv2t ~b11d ~b11e ~b12d ~b12e ~b21d ~b21e ~b22d ~b22e =
  lapacke_zbbcsd layout jobu1 jobu2 jobv1t jobv2t trans m p q (CI.cptr theta) (CI.cptr phi) (CI.cptr u1) ldu1 (CI.cptr u2) ldu2 (CI.cptr v1t) ldv1t (CI.cptr v2t) ldv2t (CI.cptr b11d) (CI.cptr b11e) (CI.cptr b12d) (CI.cptr b12e) (CI.cptr b21d) (CI.cptr b21e) (CI.cptr b22d) (CI.cptr b22e)

let zheswapr ~layout ~uplo ~n ~a ~lda ~i1 ~i2 =
  lapacke_zheswapr layout uplo n (CI.cptr a) lda i1 i2

let zhetri2 ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_zhetri2 layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let zhetri2x ~layout ~uplo ~n ~a ~lda ~ipiv ~nb =
  lapacke_zhetri2x layout uplo n (CI.cptr a) lda (CI.cptr ipiv) nb

let zhetrs2 ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_zhetrs2 layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let zsyconv ~layout ~uplo ~way ~n ~a ~lda ~ipiv ~e =
  lapacke_zsyconv layout uplo way n (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr e)

let zsyswapr ~layout ~uplo ~n ~a ~lda ~i1 ~i2 =
  lapacke_zsyswapr layout uplo n (CI.cptr a) lda i1 i2

let zsytri2 ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_zsytri2 layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let zsytri2x ~layout ~uplo ~n ~a ~lda ~ipiv ~nb =
  lapacke_zsytri2x layout uplo n (CI.cptr a) lda (CI.cptr ipiv) nb

let zsytrs2 ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_zsytrs2 layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let zunbdb ~layout ~trans ~signs ~m ~p ~q ~x11 ~ldx11 ~x12 ~ldx12 ~x21 ~ldx21 ~x22 ~ldx22 ~theta ~phi ~taup1 ~taup2 ~tauq1 ~tauq2 =
  lapacke_zunbdb layout trans signs m p q (CI.cptr x11) ldx11 (CI.cptr x12) ldx12 (CI.cptr x21) ldx21 (CI.cptr x22) ldx22 (CI.cptr theta) (CI.cptr phi) (CI.cptr taup1) (CI.cptr taup2) (CI.cptr tauq1) (CI.cptr tauq2)

let zuncsd ~layout ~jobu1 ~jobu2 ~jobv1t ~jobv2t ~trans ~signs ~m ~p ~q ~x11 ~ldx11 ~x12 ~ldx12 ~x21 ~ldx21 ~x22 ~ldx22 ~theta ~u1 ~ldu1 ~u2 ~ldu2 ~v1t ~ldv1t ~v2t ~ldv2t =
  lapacke_zuncsd layout jobu1 jobu2 jobv1t jobv2t trans signs m p q (CI.cptr x11) ldx11 (CI.cptr x12) ldx12 (CI.cptr x21) ldx21 (CI.cptr x22) ldx22 (CI.cptr theta) (CI.cptr u1) ldu1 (CI.cptr u2) ldu2 (CI.cptr v1t) ldv1t (CI.cptr v2t) ldv2t

let zuncsd2by1 ~layout ~jobu1 ~jobu2 ~jobv1t ~m ~p ~q ~x11 ~ldx11 ~x21 ~ldx21 ~theta ~u1 ~ldu1 ~u2 ~ldu2 ~v1t ~ldv1t =
  lapacke_zuncsd2by1 layout jobu1 jobu2 jobv1t m p q (CI.cptr x11) ldx11 (CI.cptr x21) ldx21 (CI.cptr theta) (CI.cptr u1) ldu1 (CI.cptr u2) ldu2 (CI.cptr v1t) ldv1t

let sgemqrt ~layout ~side ~trans ~m ~n ~k ~nb ~v ~ldv ~t ~ldt ~c ~ldc =
  lapacke_sgemqrt layout side trans m n k nb (CI.cptr v) ldv (CI.cptr t) ldt (CI.cptr c) ldc

let dgemqrt ~layout ~side ~trans ~m ~n ~k ~nb ~v ~ldv ~t ~ldt ~c ~ldc =
  lapacke_dgemqrt layout side trans m n k nb (CI.cptr v) ldv (CI.cptr t) ldt (CI.cptr c) ldc

let cgemqrt ~layout ~side ~trans ~m ~n ~k ~nb ~v ~ldv ~t ~ldt ~c ~ldc =
  lapacke_cgemqrt layout side trans m n k nb (CI.cptr v) ldv (CI.cptr t) ldt (CI.cptr c) ldc

let zgemqrt ~layout ~side ~trans ~m ~n ~k ~nb ~v ~ldv ~t ~ldt ~c ~ldc =
  lapacke_zgemqrt layout side trans m n k nb (CI.cptr v) ldv (CI.cptr t) ldt (CI.cptr c) ldc

let sgeqrt ~layout ~m ~n ~nb ~a ~lda ~t ~ldt =
  lapacke_sgeqrt layout m n nb (CI.cptr a) lda (CI.cptr t) ldt

let dgeqrt ~layout ~m ~n ~nb ~a ~lda ~t ~ldt =
  lapacke_dgeqrt layout m n nb (CI.cptr a) lda (CI.cptr t) ldt

let cgeqrt ~layout ~m ~n ~nb ~a ~lda ~t ~ldt =
  lapacke_cgeqrt layout m n nb (CI.cptr a) lda (CI.cptr t) ldt

let zgeqrt ~layout ~m ~n ~nb ~a ~lda ~t ~ldt =
  lapacke_zgeqrt layout m n nb (CI.cptr a) lda (CI.cptr t) ldt

let sgeqrt2 ~layout ~m ~n ~a ~lda ~t ~ldt =
  lapacke_sgeqrt2 layout m n (CI.cptr a) lda (CI.cptr t) ldt

let dgeqrt2 ~layout ~m ~n ~a ~lda ~t ~ldt =
  lapacke_dgeqrt2 layout m n (CI.cptr a) lda (CI.cptr t) ldt

let cgeqrt2 ~layout ~m ~n ~a ~lda ~t ~ldt =
  lapacke_cgeqrt2 layout m n (CI.cptr a) lda (CI.cptr t) ldt

let zgeqrt2 ~layout ~m ~n ~a ~lda ~t ~ldt =
  lapacke_zgeqrt2 layout m n (CI.cptr a) lda (CI.cptr t) ldt

let sgeqrt3 ~layout ~m ~n ~a ~lda ~t ~ldt =
  lapacke_sgeqrt3 layout m n (CI.cptr a) lda (CI.cptr t) ldt

let dgeqrt3 ~layout ~m ~n ~a ~lda ~t ~ldt =
  lapacke_dgeqrt3 layout m n (CI.cptr a) lda (CI.cptr t) ldt

let cgeqrt3 ~layout ~m ~n ~a ~lda ~t ~ldt =
  lapacke_cgeqrt3 layout m n (CI.cptr a) lda (CI.cptr t) ldt

let zgeqrt3 ~layout ~m ~n ~a ~lda ~t ~ldt =
  lapacke_zgeqrt3 layout m n (CI.cptr a) lda (CI.cptr t) ldt

let stpmqrt ~layout ~side ~trans ~m ~n ~k ~l ~nb ~v ~ldv ~t ~ldt ~a ~lda ~b ~ldb =
  lapacke_stpmqrt layout side trans m n k l nb (CI.cptr v) ldv (CI.cptr t) ldt (CI.cptr a) lda (CI.cptr b) ldb

let dtpmqrt ~layout ~side ~trans ~m ~n ~k ~l ~nb ~v ~ldv ~t ~ldt ~a ~lda ~b ~ldb =
  lapacke_dtpmqrt layout side trans m n k l nb (CI.cptr v) ldv (CI.cptr t) ldt (CI.cptr a) lda (CI.cptr b) ldb

let ctpmqrt ~layout ~side ~trans ~m ~n ~k ~l ~nb ~v ~ldv ~t ~ldt ~a ~lda ~b ~ldb =
  lapacke_ctpmqrt layout side trans m n k l nb (CI.cptr v) ldv (CI.cptr t) ldt (CI.cptr a) lda (CI.cptr b) ldb

let ztpmqrt ~layout ~side ~trans ~m ~n ~k ~l ~nb ~v ~ldv ~t ~ldt ~a ~lda ~b ~ldb =
  lapacke_ztpmqrt layout side trans m n k l nb (CI.cptr v) ldv (CI.cptr t) ldt (CI.cptr a) lda (CI.cptr b) ldb

let stpqrt ~layout ~m ~n ~l ~nb ~a ~lda ~b ~ldb ~t ~ldt =
  lapacke_stpqrt layout m n l nb (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr t) ldt

let dtpqrt ~layout ~m ~n ~l ~nb ~a ~lda ~b ~ldb ~t ~ldt =
  lapacke_dtpqrt layout m n l nb (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr t) ldt

let ctpqrt ~layout ~m ~n ~l ~nb ~a ~lda ~b ~ldb ~t ~ldt =
  lapacke_ctpqrt layout m n l nb (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr t) ldt

let ztpqrt ~layout ~m ~n ~l ~nb ~a ~lda ~b ~ldb ~t ~ldt =
  lapacke_ztpqrt layout m n l nb (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr t) ldt

let stpqrt2 ~layout ~m ~n ~l ~a ~lda ~b ~ldb ~t ~ldt =
  lapacke_stpqrt2 layout m n l (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr t) ldt

let dtpqrt2 ~layout ~m ~n ~l ~a ~lda ~b ~ldb ~t ~ldt =
  lapacke_dtpqrt2 layout m n l (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr t) ldt

let ctpqrt2 ~layout ~m ~n ~l ~a ~lda ~b ~ldb ~t ~ldt =
  lapacke_ctpqrt2 layout m n l (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr t) ldt

let ztpqrt2 ~layout ~m ~n ~l ~a ~lda ~b ~ldb ~t ~ldt =
  lapacke_ztpqrt2 layout m n l (CI.cptr a) lda (CI.cptr b) ldb (CI.cptr t) ldt

let stprfb ~layout ~side ~trans ~direct ~storev ~m ~n ~k ~l ~v ~ldv ~t ~ldt ~a ~lda ~b ~ldb =
  lapacke_stprfb layout side trans direct storev m n k l (CI.cptr v) ldv (CI.cptr t) ldt (CI.cptr a) lda (CI.cptr b) ldb

let dtprfb ~layout ~side ~trans ~direct ~storev ~m ~n ~k ~l ~v ~ldv ~t ~ldt ~a ~lda ~b ~ldb =
  lapacke_dtprfb layout side trans direct storev m n k l (CI.cptr v) ldv (CI.cptr t) ldt (CI.cptr a) lda (CI.cptr b) ldb

let ctprfb ~layout ~side ~trans ~direct ~storev ~m ~n ~k ~l ~v ~ldv ~t ~ldt ~a ~lda ~b ~ldb =
  lapacke_ctprfb layout side trans direct storev m n k l (CI.cptr v) ldv (CI.cptr t) ldt (CI.cptr a) lda (CI.cptr b) ldb

let ztprfb ~layout ~side ~trans ~direct ~storev ~m ~n ~k ~l ~v ~ldv ~t ~ldt ~a ~lda ~b ~ldb =
  lapacke_ztprfb layout side trans direct storev m n k l (CI.cptr v) ldv (CI.cptr t) ldt (CI.cptr a) lda (CI.cptr b) ldb

let ssysv_rook ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_ssysv_rook layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let dsysv_rook ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_dsysv_rook layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let csysv_rook ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_csysv_rook layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let zsysv_rook ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_zsysv_rook layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let ssytrf_rook ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_ssytrf_rook layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let dsytrf_rook ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_dsytrf_rook layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let csytrf_rook ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_csytrf_rook layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let zsytrf_rook ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_zsytrf_rook layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let ssytrs_rook ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_ssytrs_rook layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let dsytrs_rook ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_dsytrs_rook layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let csytrs_rook ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_csytrs_rook layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let zsytrs_rook ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_zsytrs_rook layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let chetrf_rook ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_chetrf_rook layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let zhetrf_rook ~layout ~uplo ~n ~a ~lda ~ipiv =
  lapacke_zhetrf_rook layout uplo n (CI.cptr a) lda (CI.cptr ipiv)

let chetrs_rook ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_chetrs_rook layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let zhetrs_rook ~layout ~uplo ~n ~nrhs ~a ~lda ~ipiv ~b ~ldb =
  lapacke_zhetrs_rook layout uplo n nrhs (CI.cptr a) lda (CI.cptr ipiv) (CI.cptr b) ldb

let csyr ~layout ~uplo ~n ~alpha ~x ~incx ~a ~lda =
  lapacke_csyr layout uplo n alpha (CI.cptr x) incx (CI.cptr a) lda

let zsyr ~layout ~uplo ~n ~alpha ~x ~incx ~a ~lda =
  lapacke_zsyr layout uplo n alpha (CI.cptr x) incx (CI.cptr a) lda
