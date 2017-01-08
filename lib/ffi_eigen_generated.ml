module CI = Cstubs_internals

external owl_stub_1_c_eigen_spmat_s_new : int64 -> int64 -> CI.voidp
  = "owl_stub_1_c_eigen_spmat_s_new" 

external owl_stub_2_c_eigen_spmat_s_delete : _ CI.fatptr -> unit
  = "owl_stub_2_c_eigen_spmat_s_delete" 

external owl_stub_3_c_eigen_spmat_s_eye : int64 -> CI.voidp
  = "owl_stub_3_c_eigen_spmat_s_eye" 

external owl_stub_4_c_eigen_spmat_s_rows : _ CI.fatptr -> int64
  = "owl_stub_4_c_eigen_spmat_s_rows" 

external owl_stub_5_c_eigen_spmat_s_cols : _ CI.fatptr -> int64
  = "owl_stub_5_c_eigen_spmat_s_cols" 

external owl_stub_6_c_eigen_spmat_s_nnz : _ CI.fatptr -> int64
  = "owl_stub_6_c_eigen_spmat_s_nnz" 

external owl_stub_7_c_eigen_spmat_s_get
  : _ CI.fatptr -> int64 -> int64 -> float = "owl_stub_7_c_eigen_spmat_s_get" 

external owl_stub_8_c_eigen_spmat_s_set
  : _ CI.fatptr -> int64 -> int64 -> float -> unit
  = "owl_stub_8_c_eigen_spmat_s_set" 

external owl_stub_9_c_eigen_spmat_s_reset : _ CI.fatptr -> unit
  = "owl_stub_9_c_eigen_spmat_s_reset" 

external owl_stub_10_c_eigen_spmat_s_is_compressed : _ CI.fatptr -> int
  = "owl_stub_10_c_eigen_spmat_s_is_compressed" 

external owl_stub_11_c_eigen_spmat_s_compress : _ CI.fatptr -> unit
  = "owl_stub_11_c_eigen_spmat_s_compress" 

external owl_stub_12_c_eigen_spmat_s_uncompress : _ CI.fatptr -> unit
  = "owl_stub_12_c_eigen_spmat_s_uncompress" 

external owl_stub_13_c_eigen_spmat_s_reshape
  : _ CI.fatptr -> int64 -> int64 -> unit
  = "owl_stub_13_c_eigen_spmat_s_reshape" 

external owl_stub_14_c_eigen_spmat_s_prune
  : _ CI.fatptr -> float -> float -> unit
  = "owl_stub_14_c_eigen_spmat_s_prune" 

external owl_stub_15_c_eigen_spmat_s_valueptr
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_15_c_eigen_spmat_s_valueptr" 

external owl_stub_16_c_eigen_spmat_s_innerindexptr : _ CI.fatptr -> CI.voidp
  = "owl_stub_16_c_eigen_spmat_s_innerindexptr" 

external owl_stub_17_c_eigen_spmat_s_outerindexptr : _ CI.fatptr -> CI.voidp
  = "owl_stub_17_c_eigen_spmat_s_outerindexptr" 

external owl_stub_18_c_eigen_spmat_s_clone : _ CI.fatptr -> CI.voidp
  = "owl_stub_18_c_eigen_spmat_s_clone" 

external owl_stub_19_c_eigen_spmat_s_row : _ CI.fatptr -> int64 -> CI.voidp
  = "owl_stub_19_c_eigen_spmat_s_row" 

external owl_stub_20_c_eigen_spmat_s_col : _ CI.fatptr -> int64 -> CI.voidp
  = "owl_stub_20_c_eigen_spmat_s_col" 

external owl_stub_21_c_eigen_spmat_s_transpose : _ CI.fatptr -> CI.voidp
  = "owl_stub_21_c_eigen_spmat_s_transpose" 

external owl_stub_22_c_eigen_spmat_s_adjoint : _ CI.fatptr -> CI.voidp
  = "owl_stub_22_c_eigen_spmat_s_adjoint" 

external owl_stub_23_c_eigen_spmat_s_diagonal : _ CI.fatptr -> CI.voidp
  = "owl_stub_23_c_eigen_spmat_s_diagonal" 

external owl_stub_24_c_eigen_spmat_s_trace : _ CI.fatptr -> float
  = "owl_stub_24_c_eigen_spmat_s_trace" 

external owl_stub_25_c_eigen_spmat_s_is_zero : _ CI.fatptr -> int
  = "owl_stub_25_c_eigen_spmat_s_is_zero" 

external owl_stub_26_c_eigen_spmat_s_is_positive : _ CI.fatptr -> int
  = "owl_stub_26_c_eigen_spmat_s_is_positive" 

external owl_stub_27_c_eigen_spmat_s_is_negative : _ CI.fatptr -> int
  = "owl_stub_27_c_eigen_spmat_s_is_negative" 

external owl_stub_28_c_eigen_spmat_s_is_nonpositive : _ CI.fatptr -> int
  = "owl_stub_28_c_eigen_spmat_s_is_nonpositive" 

external owl_stub_29_c_eigen_spmat_s_is_nonnegative : _ CI.fatptr -> int
  = "owl_stub_29_c_eigen_spmat_s_is_nonnegative" 

external owl_stub_30_c_eigen_spmat_s_is_equal
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_30_c_eigen_spmat_s_is_equal" 

external owl_stub_31_c_eigen_spmat_s_is_unequal
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_31_c_eigen_spmat_s_is_unequal" 

external owl_stub_32_c_eigen_spmat_s_is_greater
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_32_c_eigen_spmat_s_is_greater" 

external owl_stub_33_c_eigen_spmat_s_is_smaller
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_33_c_eigen_spmat_s_is_smaller" 

external owl_stub_34_c_eigen_spmat_s_equal_or_greater
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_34_c_eigen_spmat_s_equal_or_greater" 

external owl_stub_35_c_eigen_spmat_s_equal_or_smaller
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_35_c_eigen_spmat_s_equal_or_smaller" 

external owl_stub_36_c_eigen_spmat_s_add
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_36_c_eigen_spmat_s_add" 

external owl_stub_37_c_eigen_spmat_s_sub
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_37_c_eigen_spmat_s_sub" 

external owl_stub_38_c_eigen_spmat_s_mul
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_38_c_eigen_spmat_s_mul" 

external owl_stub_39_c_eigen_spmat_s_div
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_39_c_eigen_spmat_s_div" 

external owl_stub_40_c_eigen_spmat_s_dot
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_40_c_eigen_spmat_s_dot" 

external owl_stub_41_c_eigen_spmat_s_add_scalar
  : _ CI.fatptr -> float -> CI.voidp
  = "owl_stub_41_c_eigen_spmat_s_add_scalar" 

external owl_stub_42_c_eigen_spmat_s_sub_scalar
  : _ CI.fatptr -> float -> CI.voidp
  = "owl_stub_42_c_eigen_spmat_s_sub_scalar" 

external owl_stub_43_c_eigen_spmat_s_mul_scalar
  : _ CI.fatptr -> float -> CI.voidp
  = "owl_stub_43_c_eigen_spmat_s_mul_scalar" 

external owl_stub_44_c_eigen_spmat_s_div_scalar
  : _ CI.fatptr -> float -> CI.voidp
  = "owl_stub_44_c_eigen_spmat_s_div_scalar" 

external owl_stub_45_c_eigen_spmat_s_min2
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_45_c_eigen_spmat_s_min2" 

external owl_stub_46_c_eigen_spmat_s_max2
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_46_c_eigen_spmat_s_max2" 

external owl_stub_47_c_eigen_spmat_s_sum : _ CI.fatptr -> float
  = "owl_stub_47_c_eigen_spmat_s_sum" 

external owl_stub_48_c_eigen_spmat_s_min : _ CI.fatptr -> float
  = "owl_stub_48_c_eigen_spmat_s_min" 

external owl_stub_49_c_eigen_spmat_s_max : _ CI.fatptr -> float
  = "owl_stub_49_c_eigen_spmat_s_max" 

external owl_stub_50_c_eigen_spmat_s_abs : _ CI.fatptr -> CI.voidp
  = "owl_stub_50_c_eigen_spmat_s_abs" 

external owl_stub_51_c_eigen_spmat_s_neg : _ CI.fatptr -> CI.voidp
  = "owl_stub_51_c_eigen_spmat_s_neg" 

external owl_stub_52_c_eigen_spmat_s_sqrt : _ CI.fatptr -> CI.voidp
  = "owl_stub_52_c_eigen_spmat_s_sqrt" 

external owl_stub_53_c_eigen_spmat_s_print : _ CI.fatptr -> unit
  = "owl_stub_53_c_eigen_spmat_s_print" 

external owl_stub_54_c_eigen_spmat_d_new : int64 -> int64 -> CI.voidp
  = "owl_stub_54_c_eigen_spmat_d_new" 

external owl_stub_55_c_eigen_spmat_d_delete : _ CI.fatptr -> unit
  = "owl_stub_55_c_eigen_spmat_d_delete" 

external owl_stub_56_c_eigen_spmat_d_eye : int64 -> CI.voidp
  = "owl_stub_56_c_eigen_spmat_d_eye" 

external owl_stub_57_c_eigen_spmat_d_rows : _ CI.fatptr -> int64
  = "owl_stub_57_c_eigen_spmat_d_rows" 

external owl_stub_58_c_eigen_spmat_d_cols : _ CI.fatptr -> int64
  = "owl_stub_58_c_eigen_spmat_d_cols" 

external owl_stub_59_c_eigen_spmat_d_nnz : _ CI.fatptr -> int64
  = "owl_stub_59_c_eigen_spmat_d_nnz" 

external owl_stub_60_c_eigen_spmat_d_get
  : _ CI.fatptr -> int64 -> int64 -> float
  = "owl_stub_60_c_eigen_spmat_d_get" 

external owl_stub_61_c_eigen_spmat_d_set
  : _ CI.fatptr -> int64 -> int64 -> float -> unit
  = "owl_stub_61_c_eigen_spmat_d_set" 

external owl_stub_62_c_eigen_spmat_d_reset : _ CI.fatptr -> unit
  = "owl_stub_62_c_eigen_spmat_d_reset" 

external owl_stub_63_c_eigen_spmat_d_is_compressed : _ CI.fatptr -> int
  = "owl_stub_63_c_eigen_spmat_d_is_compressed" 

external owl_stub_64_c_eigen_spmat_d_compress : _ CI.fatptr -> unit
  = "owl_stub_64_c_eigen_spmat_d_compress" 

external owl_stub_65_c_eigen_spmat_d_uncompress : _ CI.fatptr -> unit
  = "owl_stub_65_c_eigen_spmat_d_uncompress" 

external owl_stub_66_c_eigen_spmat_d_reshape
  : _ CI.fatptr -> int64 -> int64 -> unit
  = "owl_stub_66_c_eigen_spmat_d_reshape" 

external owl_stub_67_c_eigen_spmat_d_prune
  : _ CI.fatptr -> float -> float -> unit
  = "owl_stub_67_c_eigen_spmat_d_prune" 

external owl_stub_68_c_eigen_spmat_d_valueptr
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_68_c_eigen_spmat_d_valueptr" 

external owl_stub_69_c_eigen_spmat_d_innerindexptr : _ CI.fatptr -> CI.voidp
  = "owl_stub_69_c_eigen_spmat_d_innerindexptr" 

external owl_stub_70_c_eigen_spmat_d_outerindexptr : _ CI.fatptr -> CI.voidp
  = "owl_stub_70_c_eigen_spmat_d_outerindexptr" 

external owl_stub_71_c_eigen_spmat_d_clone : _ CI.fatptr -> CI.voidp
  = "owl_stub_71_c_eigen_spmat_d_clone" 

external owl_stub_72_c_eigen_spmat_d_row : _ CI.fatptr -> int64 -> CI.voidp
  = "owl_stub_72_c_eigen_spmat_d_row" 

external owl_stub_73_c_eigen_spmat_d_col : _ CI.fatptr -> int64 -> CI.voidp
  = "owl_stub_73_c_eigen_spmat_d_col" 

external owl_stub_74_c_eigen_spmat_d_transpose : _ CI.fatptr -> CI.voidp
  = "owl_stub_74_c_eigen_spmat_d_transpose" 

external owl_stub_75_c_eigen_spmat_d_adjoint : _ CI.fatptr -> CI.voidp
  = "owl_stub_75_c_eigen_spmat_d_adjoint" 

external owl_stub_76_c_eigen_spmat_d_diagonal : _ CI.fatptr -> CI.voidp
  = "owl_stub_76_c_eigen_spmat_d_diagonal" 

external owl_stub_77_c_eigen_spmat_d_trace : _ CI.fatptr -> float
  = "owl_stub_77_c_eigen_spmat_d_trace" 

external owl_stub_78_c_eigen_spmat_d_is_zero : _ CI.fatptr -> int
  = "owl_stub_78_c_eigen_spmat_d_is_zero" 

external owl_stub_79_c_eigen_spmat_d_is_positive : _ CI.fatptr -> int
  = "owl_stub_79_c_eigen_spmat_d_is_positive" 

external owl_stub_80_c_eigen_spmat_d_is_negative : _ CI.fatptr -> int
  = "owl_stub_80_c_eigen_spmat_d_is_negative" 

external owl_stub_81_c_eigen_spmat_d_is_nonpositive : _ CI.fatptr -> int
  = "owl_stub_81_c_eigen_spmat_d_is_nonpositive" 

external owl_stub_82_c_eigen_spmat_d_is_nonnegative : _ CI.fatptr -> int
  = "owl_stub_82_c_eigen_spmat_d_is_nonnegative" 

external owl_stub_83_c_eigen_spmat_d_is_equal
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_83_c_eigen_spmat_d_is_equal" 

external owl_stub_84_c_eigen_spmat_d_is_unequal
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_84_c_eigen_spmat_d_is_unequal" 

external owl_stub_85_c_eigen_spmat_d_is_greater
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_85_c_eigen_spmat_d_is_greater" 

external owl_stub_86_c_eigen_spmat_d_is_smaller
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_86_c_eigen_spmat_d_is_smaller" 

external owl_stub_87_c_eigen_spmat_d_equal_or_greater
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_87_c_eigen_spmat_d_equal_or_greater" 

external owl_stub_88_c_eigen_spmat_d_equal_or_smaller
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_88_c_eigen_spmat_d_equal_or_smaller" 

external owl_stub_89_c_eigen_spmat_d_add
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_89_c_eigen_spmat_d_add" 

external owl_stub_90_c_eigen_spmat_d_sub
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_90_c_eigen_spmat_d_sub" 

external owl_stub_91_c_eigen_spmat_d_mul
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_91_c_eigen_spmat_d_mul" 

external owl_stub_92_c_eigen_spmat_d_div
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_92_c_eigen_spmat_d_div" 

external owl_stub_93_c_eigen_spmat_d_dot
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_93_c_eigen_spmat_d_dot" 

external owl_stub_94_c_eigen_spmat_d_add_scalar
  : _ CI.fatptr -> float -> CI.voidp
  = "owl_stub_94_c_eigen_spmat_d_add_scalar" 

external owl_stub_95_c_eigen_spmat_d_sub_scalar
  : _ CI.fatptr -> float -> CI.voidp
  = "owl_stub_95_c_eigen_spmat_d_sub_scalar" 

external owl_stub_96_c_eigen_spmat_d_mul_scalar
  : _ CI.fatptr -> float -> CI.voidp
  = "owl_stub_96_c_eigen_spmat_d_mul_scalar" 

external owl_stub_97_c_eigen_spmat_d_div_scalar
  : _ CI.fatptr -> float -> CI.voidp
  = "owl_stub_97_c_eigen_spmat_d_div_scalar" 

external owl_stub_98_c_eigen_spmat_d_min2
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_98_c_eigen_spmat_d_min2" 

external owl_stub_99_c_eigen_spmat_d_max2
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_99_c_eigen_spmat_d_max2" 

external owl_stub_100_c_eigen_spmat_d_sum : _ CI.fatptr -> float
  = "owl_stub_100_c_eigen_spmat_d_sum" 

external owl_stub_101_c_eigen_spmat_d_min : _ CI.fatptr -> float
  = "owl_stub_101_c_eigen_spmat_d_min" 

external owl_stub_102_c_eigen_spmat_d_max : _ CI.fatptr -> float
  = "owl_stub_102_c_eigen_spmat_d_max" 

external owl_stub_103_c_eigen_spmat_d_abs : _ CI.fatptr -> CI.voidp
  = "owl_stub_103_c_eigen_spmat_d_abs" 

external owl_stub_104_c_eigen_spmat_d_neg : _ CI.fatptr -> CI.voidp
  = "owl_stub_104_c_eigen_spmat_d_neg" 

external owl_stub_105_c_eigen_spmat_d_sqrt : _ CI.fatptr -> CI.voidp
  = "owl_stub_105_c_eigen_spmat_d_sqrt" 

external owl_stub_106_c_eigen_spmat_d_print : _ CI.fatptr -> unit
  = "owl_stub_106_c_eigen_spmat_d_print" 

external owl_stub_107_c_eigen_spmat_c_new : int64 -> int64 -> CI.voidp
  = "owl_stub_107_c_eigen_spmat_c_new" 

external owl_stub_108_c_eigen_spmat_c_delete : _ CI.fatptr -> unit
  = "owl_stub_108_c_eigen_spmat_c_delete" 

external owl_stub_109_c_eigen_spmat_c_eye : int64 -> CI.voidp
  = "owl_stub_109_c_eigen_spmat_c_eye" 

external owl_stub_110_c_eigen_spmat_c_rows : _ CI.fatptr -> int64
  = "owl_stub_110_c_eigen_spmat_c_rows" 

external owl_stub_111_c_eigen_spmat_c_cols : _ CI.fatptr -> int64
  = "owl_stub_111_c_eigen_spmat_c_cols" 

external owl_stub_112_c_eigen_spmat_c_nnz : _ CI.fatptr -> int64
  = "owl_stub_112_c_eigen_spmat_c_nnz" 

external owl_stub_113_c_eigen_spmat_c_get
  : _ CI.fatptr -> int64 -> int64 -> Complex.t
  = "owl_stub_113_c_eigen_spmat_c_get" 

external owl_stub_114_c_eigen_spmat_c_set
  : _ CI.fatptr -> int64 -> int64 -> Complex.t -> unit
  = "owl_stub_114_c_eigen_spmat_c_set" 

external owl_stub_115_c_eigen_spmat_c_reset : _ CI.fatptr -> unit
  = "owl_stub_115_c_eigen_spmat_c_reset" 

external owl_stub_116_c_eigen_spmat_c_is_compressed : _ CI.fatptr -> int
  = "owl_stub_116_c_eigen_spmat_c_is_compressed" 

external owl_stub_117_c_eigen_spmat_c_compress : _ CI.fatptr -> unit
  = "owl_stub_117_c_eigen_spmat_c_compress" 

external owl_stub_118_c_eigen_spmat_c_uncompress : _ CI.fatptr -> unit
  = "owl_stub_118_c_eigen_spmat_c_uncompress" 

external owl_stub_119_c_eigen_spmat_c_reshape
  : _ CI.fatptr -> int64 -> int64 -> unit
  = "owl_stub_119_c_eigen_spmat_c_reshape" 

external owl_stub_120_c_eigen_spmat_c_prune
  : _ CI.fatptr -> Complex.t -> float -> unit
  = "owl_stub_120_c_eigen_spmat_c_prune" 

external owl_stub_121_c_eigen_spmat_c_valueptr
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_121_c_eigen_spmat_c_valueptr" 

external owl_stub_122_c_eigen_spmat_c_innerindexptr : _ CI.fatptr -> CI.voidp
  = "owl_stub_122_c_eigen_spmat_c_innerindexptr" 

external owl_stub_123_c_eigen_spmat_c_outerindexptr : _ CI.fatptr -> CI.voidp
  = "owl_stub_123_c_eigen_spmat_c_outerindexptr" 

external owl_stub_124_c_eigen_spmat_c_clone : _ CI.fatptr -> CI.voidp
  = "owl_stub_124_c_eigen_spmat_c_clone" 

external owl_stub_125_c_eigen_spmat_c_row : _ CI.fatptr -> int64 -> CI.voidp
  = "owl_stub_125_c_eigen_spmat_c_row" 

external owl_stub_126_c_eigen_spmat_c_col : _ CI.fatptr -> int64 -> CI.voidp
  = "owl_stub_126_c_eigen_spmat_c_col" 

external owl_stub_127_c_eigen_spmat_c_transpose : _ CI.fatptr -> CI.voidp
  = "owl_stub_127_c_eigen_spmat_c_transpose" 

external owl_stub_128_c_eigen_spmat_c_adjoint : _ CI.fatptr -> CI.voidp
  = "owl_stub_128_c_eigen_spmat_c_adjoint" 

external owl_stub_129_c_eigen_spmat_c_diagonal : _ CI.fatptr -> CI.voidp
  = "owl_stub_129_c_eigen_spmat_c_diagonal" 

external owl_stub_130_c_eigen_spmat_c_trace : _ CI.fatptr -> Complex.t
  = "owl_stub_130_c_eigen_spmat_c_trace" 

external owl_stub_131_c_eigen_spmat_c_is_zero : _ CI.fatptr -> int
  = "owl_stub_131_c_eigen_spmat_c_is_zero" 

external owl_stub_132_c_eigen_spmat_c_is_positive : _ CI.fatptr -> int
  = "owl_stub_132_c_eigen_spmat_c_is_positive" 

external owl_stub_133_c_eigen_spmat_c_is_negative : _ CI.fatptr -> int
  = "owl_stub_133_c_eigen_spmat_c_is_negative" 

external owl_stub_134_c_eigen_spmat_c_is_nonpositive : _ CI.fatptr -> int
  = "owl_stub_134_c_eigen_spmat_c_is_nonpositive" 

external owl_stub_135_c_eigen_spmat_c_is_nonnegative : _ CI.fatptr -> int
  = "owl_stub_135_c_eigen_spmat_c_is_nonnegative" 

external owl_stub_136_c_eigen_spmat_c_is_equal
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_136_c_eigen_spmat_c_is_equal" 

external owl_stub_137_c_eigen_spmat_c_is_unequal
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_137_c_eigen_spmat_c_is_unequal" 

external owl_stub_138_c_eigen_spmat_c_is_greater
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_138_c_eigen_spmat_c_is_greater" 

external owl_stub_139_c_eigen_spmat_c_is_smaller
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_139_c_eigen_spmat_c_is_smaller" 

external owl_stub_140_c_eigen_spmat_c_equal_or_greater
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_140_c_eigen_spmat_c_equal_or_greater" 

external owl_stub_141_c_eigen_spmat_c_equal_or_smaller
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_141_c_eigen_spmat_c_equal_or_smaller" 

external owl_stub_142_c_eigen_spmat_c_add
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_142_c_eigen_spmat_c_add" 

external owl_stub_143_c_eigen_spmat_c_sub
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_143_c_eigen_spmat_c_sub" 

external owl_stub_144_c_eigen_spmat_c_mul
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_144_c_eigen_spmat_c_mul" 

external owl_stub_145_c_eigen_spmat_c_div
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_145_c_eigen_spmat_c_div" 

external owl_stub_146_c_eigen_spmat_c_dot
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_146_c_eigen_spmat_c_dot" 

external owl_stub_147_c_eigen_spmat_c_add_scalar
  : _ CI.fatptr -> Complex.t -> CI.voidp
  = "owl_stub_147_c_eigen_spmat_c_add_scalar" 

external owl_stub_148_c_eigen_spmat_c_sub_scalar
  : _ CI.fatptr -> Complex.t -> CI.voidp
  = "owl_stub_148_c_eigen_spmat_c_sub_scalar" 

external owl_stub_149_c_eigen_spmat_c_mul_scalar
  : _ CI.fatptr -> Complex.t -> CI.voidp
  = "owl_stub_149_c_eigen_spmat_c_mul_scalar" 

external owl_stub_150_c_eigen_spmat_c_div_scalar
  : _ CI.fatptr -> Complex.t -> CI.voidp
  = "owl_stub_150_c_eigen_spmat_c_div_scalar" 

external owl_stub_151_c_eigen_spmat_c_sum : _ CI.fatptr -> Complex.t
  = "owl_stub_151_c_eigen_spmat_c_sum" 

external owl_stub_152_c_eigen_spmat_c_neg : _ CI.fatptr -> CI.voidp
  = "owl_stub_152_c_eigen_spmat_c_neg" 

external owl_stub_153_c_eigen_spmat_c_sqrt : _ CI.fatptr -> CI.voidp
  = "owl_stub_153_c_eigen_spmat_c_sqrt" 

external owl_stub_154_c_eigen_spmat_c_print : _ CI.fatptr -> unit
  = "owl_stub_154_c_eigen_spmat_c_print" 

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
| Function (CI.Pointer x2, Returns CI.Void), "c_eigen_spmat_c_print" ->
  (fun x1 -> owl_stub_154_c_eigen_spmat_c_print (CI.cptr x1))
| Function (CI.Pointer x4, Returns (CI.Pointer x5)), "c_eigen_spmat_c_sqrt" ->
  (fun x3 -> CI.make_ptr x5 (owl_stub_153_c_eigen_spmat_c_sqrt (CI.cptr x3)))
| Function (CI.Pointer x7, Returns (CI.Pointer x8)), "c_eigen_spmat_c_neg" ->
  (fun x6 -> CI.make_ptr x8 (owl_stub_152_c_eigen_spmat_c_neg (CI.cptr x6)))
| Function (CI.Pointer x10, Returns (CI.Primitive CI.Complex32)),
  "c_eigen_spmat_c_sum" ->
  (fun x9 -> owl_stub_151_c_eigen_spmat_c_sum (CI.cptr x9))
| Function
    (CI.Pointer x12,
     Function (CI.Primitive CI.Complex32, Returns (CI.Pointer x14))),
  "c_eigen_spmat_c_div_scalar" ->
  (fun x11 x13 ->
    CI.make_ptr x14
      (owl_stub_150_c_eigen_spmat_c_div_scalar (CI.cptr x11) x13))
| Function
    (CI.Pointer x16,
     Function (CI.Primitive CI.Complex32, Returns (CI.Pointer x18))),
  "c_eigen_spmat_c_mul_scalar" ->
  (fun x15 x17 ->
    CI.make_ptr x18
      (owl_stub_149_c_eigen_spmat_c_mul_scalar (CI.cptr x15) x17))
| Function
    (CI.Pointer x20,
     Function (CI.Primitive CI.Complex32, Returns (CI.Pointer x22))),
  "c_eigen_spmat_c_sub_scalar" ->
  (fun x19 x21 ->
    CI.make_ptr x22
      (owl_stub_148_c_eigen_spmat_c_sub_scalar (CI.cptr x19) x21))
| Function
    (CI.Pointer x24,
     Function (CI.Primitive CI.Complex32, Returns (CI.Pointer x26))),
  "c_eigen_spmat_c_add_scalar" ->
  (fun x23 x25 ->
    CI.make_ptr x26
      (owl_stub_147_c_eigen_spmat_c_add_scalar (CI.cptr x23) x25))
| Function
    (CI.Pointer x28, Function (CI.Pointer x30, Returns (CI.Pointer x31))),
  "c_eigen_spmat_c_dot" ->
  (fun x27 x29 ->
    CI.make_ptr x31
      (owl_stub_146_c_eigen_spmat_c_dot (CI.cptr x27) (CI.cptr x29)))
| Function
    (CI.Pointer x33, Function (CI.Pointer x35, Returns (CI.Pointer x36))),
  "c_eigen_spmat_c_div" ->
  (fun x32 x34 ->
    CI.make_ptr x36
      (owl_stub_145_c_eigen_spmat_c_div (CI.cptr x32) (CI.cptr x34)))
| Function
    (CI.Pointer x38, Function (CI.Pointer x40, Returns (CI.Pointer x41))),
  "c_eigen_spmat_c_mul" ->
  (fun x37 x39 ->
    CI.make_ptr x41
      (owl_stub_144_c_eigen_spmat_c_mul (CI.cptr x37) (CI.cptr x39)))
| Function
    (CI.Pointer x43, Function (CI.Pointer x45, Returns (CI.Pointer x46))),
  "c_eigen_spmat_c_sub" ->
  (fun x42 x44 ->
    CI.make_ptr x46
      (owl_stub_143_c_eigen_spmat_c_sub (CI.cptr x42) (CI.cptr x44)))
| Function
    (CI.Pointer x48, Function (CI.Pointer x50, Returns (CI.Pointer x51))),
  "c_eigen_spmat_c_add" ->
  (fun x47 x49 ->
    CI.make_ptr x51
      (owl_stub_142_c_eigen_spmat_c_add (CI.cptr x47) (CI.cptr x49)))
| Function
    (CI.Pointer x53,
     Function (CI.Pointer x55, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_c_equal_or_smaller" ->
  (fun x52 x54 ->
    owl_stub_141_c_eigen_spmat_c_equal_or_smaller (CI.cptr x52) (CI.cptr x54))
| Function
    (CI.Pointer x57,
     Function (CI.Pointer x59, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_c_equal_or_greater" ->
  (fun x56 x58 ->
    owl_stub_140_c_eigen_spmat_c_equal_or_greater (CI.cptr x56) (CI.cptr x58))
| Function
    (CI.Pointer x61,
     Function (CI.Pointer x63, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_c_is_smaller" ->
  (fun x60 x62 ->
    owl_stub_139_c_eigen_spmat_c_is_smaller (CI.cptr x60) (CI.cptr x62))
| Function
    (CI.Pointer x65,
     Function (CI.Pointer x67, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_c_is_greater" ->
  (fun x64 x66 ->
    owl_stub_138_c_eigen_spmat_c_is_greater (CI.cptr x64) (CI.cptr x66))
| Function
    (CI.Pointer x69,
     Function (CI.Pointer x71, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_c_is_unequal" ->
  (fun x68 x70 ->
    owl_stub_137_c_eigen_spmat_c_is_unequal (CI.cptr x68) (CI.cptr x70))
| Function
    (CI.Pointer x73,
     Function (CI.Pointer x75, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_c_is_equal" ->
  (fun x72 x74 ->
    owl_stub_136_c_eigen_spmat_c_is_equal (CI.cptr x72) (CI.cptr x74))
| Function (CI.Pointer x77, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_c_is_nonnegative" ->
  (fun x76 -> owl_stub_135_c_eigen_spmat_c_is_nonnegative (CI.cptr x76))
| Function (CI.Pointer x79, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_c_is_nonpositive" ->
  (fun x78 -> owl_stub_134_c_eigen_spmat_c_is_nonpositive (CI.cptr x78))
| Function (CI.Pointer x81, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_c_is_negative" ->
  (fun x80 -> owl_stub_133_c_eigen_spmat_c_is_negative (CI.cptr x80))
| Function (CI.Pointer x83, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_c_is_positive" ->
  (fun x82 -> owl_stub_132_c_eigen_spmat_c_is_positive (CI.cptr x82))
| Function (CI.Pointer x85, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_c_is_zero" ->
  (fun x84 -> owl_stub_131_c_eigen_spmat_c_is_zero (CI.cptr x84))
| Function (CI.Pointer x87, Returns (CI.Primitive CI.Complex32)),
  "c_eigen_spmat_c_trace" ->
  (fun x86 -> owl_stub_130_c_eigen_spmat_c_trace (CI.cptr x86))
| Function (CI.Pointer x89, Returns (CI.Pointer x90)),
  "c_eigen_spmat_c_diagonal" ->
  (fun x88 ->
    CI.make_ptr x90 (owl_stub_129_c_eigen_spmat_c_diagonal (CI.cptr x88)))
| Function (CI.Pointer x92, Returns (CI.Pointer x93)),
  "c_eigen_spmat_c_adjoint" ->
  (fun x91 ->
    CI.make_ptr x93 (owl_stub_128_c_eigen_spmat_c_adjoint (CI.cptr x91)))
| Function (CI.Pointer x95, Returns (CI.Pointer x96)),
  "c_eigen_spmat_c_transpose" ->
  (fun x94 ->
    CI.make_ptr x96 (owl_stub_127_c_eigen_spmat_c_transpose (CI.cptr x94)))
| Function
    (CI.Pointer x98,
     Function (CI.Primitive CI.Int64_t, Returns (CI.Pointer x100))),
  "c_eigen_spmat_c_col" ->
  (fun x97 x99 ->
    CI.make_ptr x100 (owl_stub_126_c_eigen_spmat_c_col (CI.cptr x97) x99))
| Function
    (CI.Pointer x102,
     Function (CI.Primitive CI.Int64_t, Returns (CI.Pointer x104))),
  "c_eigen_spmat_c_row" ->
  (fun x101 x103 ->
    CI.make_ptr x104 (owl_stub_125_c_eigen_spmat_c_row (CI.cptr x101) x103))
| Function (CI.Pointer x106, Returns (CI.Pointer x107)),
  "c_eigen_spmat_c_clone" ->
  (fun x105 ->
    CI.make_ptr x107 (owl_stub_124_c_eigen_spmat_c_clone (CI.cptr x105)))
| Function (CI.Pointer x109, Returns (CI.Pointer x110)),
  "c_eigen_spmat_c_outerindexptr" ->
  (fun x108 ->
    CI.make_ptr x110
      (owl_stub_123_c_eigen_spmat_c_outerindexptr (CI.cptr x108)))
| Function (CI.Pointer x112, Returns (CI.Pointer x113)),
  "c_eigen_spmat_c_innerindexptr" ->
  (fun x111 ->
    CI.make_ptr x113
      (owl_stub_122_c_eigen_spmat_c_innerindexptr (CI.cptr x111)))
| Function
    (CI.Pointer x115, Function (CI.Pointer x117, Returns (CI.Pointer x118))),
  "c_eigen_spmat_c_valueptr" ->
  (fun x114 x116 ->
    CI.make_ptr x118
      (owl_stub_121_c_eigen_spmat_c_valueptr (CI.cptr x114) (CI.cptr x116)))
| Function
    (CI.Pointer x120,
     Function
       (CI.Primitive CI.Complex32,
        Function (CI.Primitive CI.Float, Returns CI.Void))),
  "c_eigen_spmat_c_prune" ->
  (fun x119 x121 x122 ->
    owl_stub_120_c_eigen_spmat_c_prune (CI.cptr x119) x121 x122)
| Function
    (CI.Pointer x124,
     Function
       (CI.Primitive CI.Int64_t,
        Function (CI.Primitive CI.Int64_t, Returns CI.Void))),
  "c_eigen_spmat_c_reshape" ->
  (fun x123 x125 x126 ->
    owl_stub_119_c_eigen_spmat_c_reshape (CI.cptr x123) x125 x126)
| Function (CI.Pointer x128, Returns CI.Void), "c_eigen_spmat_c_uncompress" ->
  (fun x127 -> owl_stub_118_c_eigen_spmat_c_uncompress (CI.cptr x127))
| Function (CI.Pointer x130, Returns CI.Void), "c_eigen_spmat_c_compress" ->
  (fun x129 -> owl_stub_117_c_eigen_spmat_c_compress (CI.cptr x129))
| Function (CI.Pointer x132, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_c_is_compressed" ->
  (fun x131 -> owl_stub_116_c_eigen_spmat_c_is_compressed (CI.cptr x131))
| Function (CI.Pointer x134, Returns CI.Void), "c_eigen_spmat_c_reset" ->
  (fun x133 -> owl_stub_115_c_eigen_spmat_c_reset (CI.cptr x133))
| Function
    (CI.Pointer x136,
     Function
       (CI.Primitive CI.Int64_t,
        Function
          (CI.Primitive CI.Int64_t,
           Function (CI.Primitive CI.Complex32, Returns CI.Void)))),
  "c_eigen_spmat_c_set" ->
  (fun x135 x137 x138 x139 ->
    owl_stub_114_c_eigen_spmat_c_set (CI.cptr x135) x137 x138 x139)
| Function
    (CI.Pointer x141,
     Function
       (CI.Primitive CI.Int64_t,
        Function
          (CI.Primitive CI.Int64_t, Returns (CI.Primitive CI.Complex32)))),
  "c_eigen_spmat_c_get" ->
  (fun x140 x142 x143 ->
    owl_stub_113_c_eigen_spmat_c_get (CI.cptr x140) x142 x143)
| Function (CI.Pointer x145, Returns (CI.Primitive CI.Int64_t)),
  "c_eigen_spmat_c_nnz" ->
  (fun x144 -> owl_stub_112_c_eigen_spmat_c_nnz (CI.cptr x144))
| Function (CI.Pointer x147, Returns (CI.Primitive CI.Int64_t)),
  "c_eigen_spmat_c_cols" ->
  (fun x146 -> owl_stub_111_c_eigen_spmat_c_cols (CI.cptr x146))
| Function (CI.Pointer x149, Returns (CI.Primitive CI.Int64_t)),
  "c_eigen_spmat_c_rows" ->
  (fun x148 -> owl_stub_110_c_eigen_spmat_c_rows (CI.cptr x148))
| Function (CI.Primitive CI.Int64_t, Returns (CI.Pointer x151)),
  "c_eigen_spmat_c_eye" ->
  (fun x150 -> CI.make_ptr x151 (owl_stub_109_c_eigen_spmat_c_eye x150))
| Function (CI.Pointer x153, Returns CI.Void), "c_eigen_spmat_c_delete" ->
  (fun x152 -> owl_stub_108_c_eigen_spmat_c_delete (CI.cptr x152))
| Function
    (CI.Primitive CI.Int64_t,
     Function (CI.Primitive CI.Int64_t, Returns (CI.Pointer x156))),
  "c_eigen_spmat_c_new" ->
  (fun x154 x155 ->
    CI.make_ptr x156 (owl_stub_107_c_eigen_spmat_c_new x154 x155))
| Function (CI.Pointer x158, Returns CI.Void), "c_eigen_spmat_d_print" ->
  (fun x157 -> owl_stub_106_c_eigen_spmat_d_print (CI.cptr x157))
| Function (CI.Pointer x160, Returns (CI.Pointer x161)),
  "c_eigen_spmat_d_sqrt" ->
  (fun x159 ->
    CI.make_ptr x161 (owl_stub_105_c_eigen_spmat_d_sqrt (CI.cptr x159)))
| Function (CI.Pointer x163, Returns (CI.Pointer x164)),
  "c_eigen_spmat_d_neg" ->
  (fun x162 ->
    CI.make_ptr x164 (owl_stub_104_c_eigen_spmat_d_neg (CI.cptr x162)))
| Function (CI.Pointer x166, Returns (CI.Pointer x167)),
  "c_eigen_spmat_d_abs" ->
  (fun x165 ->
    CI.make_ptr x167 (owl_stub_103_c_eigen_spmat_d_abs (CI.cptr x165)))
| Function (CI.Pointer x169, Returns (CI.Primitive CI.Double)),
  "c_eigen_spmat_d_max" ->
  (fun x168 -> owl_stub_102_c_eigen_spmat_d_max (CI.cptr x168))
| Function (CI.Pointer x171, Returns (CI.Primitive CI.Double)),
  "c_eigen_spmat_d_min" ->
  (fun x170 -> owl_stub_101_c_eigen_spmat_d_min (CI.cptr x170))
| Function (CI.Pointer x173, Returns (CI.Primitive CI.Double)),
  "c_eigen_spmat_d_sum" ->
  (fun x172 -> owl_stub_100_c_eigen_spmat_d_sum (CI.cptr x172))
| Function
    (CI.Pointer x175, Function (CI.Pointer x177, Returns (CI.Pointer x178))),
  "c_eigen_spmat_d_max2" ->
  (fun x174 x176 ->
    CI.make_ptr x178
      (owl_stub_99_c_eigen_spmat_d_max2 (CI.cptr x174) (CI.cptr x176)))
| Function
    (CI.Pointer x180, Function (CI.Pointer x182, Returns (CI.Pointer x183))),
  "c_eigen_spmat_d_min2" ->
  (fun x179 x181 ->
    CI.make_ptr x183
      (owl_stub_98_c_eigen_spmat_d_min2 (CI.cptr x179) (CI.cptr x181)))
| Function
    (CI.Pointer x185,
     Function (CI.Primitive CI.Double, Returns (CI.Pointer x187))),
  "c_eigen_spmat_d_div_scalar" ->
  (fun x184 x186 ->
    CI.make_ptr x187
      (owl_stub_97_c_eigen_spmat_d_div_scalar (CI.cptr x184) x186))
| Function
    (CI.Pointer x189,
     Function (CI.Primitive CI.Double, Returns (CI.Pointer x191))),
  "c_eigen_spmat_d_mul_scalar" ->
  (fun x188 x190 ->
    CI.make_ptr x191
      (owl_stub_96_c_eigen_spmat_d_mul_scalar (CI.cptr x188) x190))
| Function
    (CI.Pointer x193,
     Function (CI.Primitive CI.Double, Returns (CI.Pointer x195))),
  "c_eigen_spmat_d_sub_scalar" ->
  (fun x192 x194 ->
    CI.make_ptr x195
      (owl_stub_95_c_eigen_spmat_d_sub_scalar (CI.cptr x192) x194))
| Function
    (CI.Pointer x197,
     Function (CI.Primitive CI.Double, Returns (CI.Pointer x199))),
  "c_eigen_spmat_d_add_scalar" ->
  (fun x196 x198 ->
    CI.make_ptr x199
      (owl_stub_94_c_eigen_spmat_d_add_scalar (CI.cptr x196) x198))
| Function
    (CI.Pointer x201, Function (CI.Pointer x203, Returns (CI.Pointer x204))),
  "c_eigen_spmat_d_dot" ->
  (fun x200 x202 ->
    CI.make_ptr x204
      (owl_stub_93_c_eigen_spmat_d_dot (CI.cptr x200) (CI.cptr x202)))
| Function
    (CI.Pointer x206, Function (CI.Pointer x208, Returns (CI.Pointer x209))),
  "c_eigen_spmat_d_div" ->
  (fun x205 x207 ->
    CI.make_ptr x209
      (owl_stub_92_c_eigen_spmat_d_div (CI.cptr x205) (CI.cptr x207)))
| Function
    (CI.Pointer x211, Function (CI.Pointer x213, Returns (CI.Pointer x214))),
  "c_eigen_spmat_d_mul" ->
  (fun x210 x212 ->
    CI.make_ptr x214
      (owl_stub_91_c_eigen_spmat_d_mul (CI.cptr x210) (CI.cptr x212)))
| Function
    (CI.Pointer x216, Function (CI.Pointer x218, Returns (CI.Pointer x219))),
  "c_eigen_spmat_d_sub" ->
  (fun x215 x217 ->
    CI.make_ptr x219
      (owl_stub_90_c_eigen_spmat_d_sub (CI.cptr x215) (CI.cptr x217)))
| Function
    (CI.Pointer x221, Function (CI.Pointer x223, Returns (CI.Pointer x224))),
  "c_eigen_spmat_d_add" ->
  (fun x220 x222 ->
    CI.make_ptr x224
      (owl_stub_89_c_eigen_spmat_d_add (CI.cptr x220) (CI.cptr x222)))
| Function
    (CI.Pointer x226,
     Function (CI.Pointer x228, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_d_equal_or_smaller" ->
  (fun x225 x227 ->
    owl_stub_88_c_eigen_spmat_d_equal_or_smaller (CI.cptr x225)
    (CI.cptr x227))
| Function
    (CI.Pointer x230,
     Function (CI.Pointer x232, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_d_equal_or_greater" ->
  (fun x229 x231 ->
    owl_stub_87_c_eigen_spmat_d_equal_or_greater (CI.cptr x229)
    (CI.cptr x231))
| Function
    (CI.Pointer x234,
     Function (CI.Pointer x236, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_d_is_smaller" ->
  (fun x233 x235 ->
    owl_stub_86_c_eigen_spmat_d_is_smaller (CI.cptr x233) (CI.cptr x235))
| Function
    (CI.Pointer x238,
     Function (CI.Pointer x240, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_d_is_greater" ->
  (fun x237 x239 ->
    owl_stub_85_c_eigen_spmat_d_is_greater (CI.cptr x237) (CI.cptr x239))
| Function
    (CI.Pointer x242,
     Function (CI.Pointer x244, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_d_is_unequal" ->
  (fun x241 x243 ->
    owl_stub_84_c_eigen_spmat_d_is_unequal (CI.cptr x241) (CI.cptr x243))
| Function
    (CI.Pointer x246,
     Function (CI.Pointer x248, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_d_is_equal" ->
  (fun x245 x247 ->
    owl_stub_83_c_eigen_spmat_d_is_equal (CI.cptr x245) (CI.cptr x247))
| Function (CI.Pointer x250, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_nonnegative" ->
  (fun x249 -> owl_stub_82_c_eigen_spmat_d_is_nonnegative (CI.cptr x249))
| Function (CI.Pointer x252, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_nonpositive" ->
  (fun x251 -> owl_stub_81_c_eigen_spmat_d_is_nonpositive (CI.cptr x251))
| Function (CI.Pointer x254, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_negative" ->
  (fun x253 -> owl_stub_80_c_eigen_spmat_d_is_negative (CI.cptr x253))
| Function (CI.Pointer x256, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_positive" ->
  (fun x255 -> owl_stub_79_c_eigen_spmat_d_is_positive (CI.cptr x255))
| Function (CI.Pointer x258, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_zero" ->
  (fun x257 -> owl_stub_78_c_eigen_spmat_d_is_zero (CI.cptr x257))
| Function (CI.Pointer x260, Returns (CI.Primitive CI.Double)),
  "c_eigen_spmat_d_trace" ->
  (fun x259 -> owl_stub_77_c_eigen_spmat_d_trace (CI.cptr x259))
| Function (CI.Pointer x262, Returns (CI.Pointer x263)),
  "c_eigen_spmat_d_diagonal" ->
  (fun x261 ->
    CI.make_ptr x263 (owl_stub_76_c_eigen_spmat_d_diagonal (CI.cptr x261)))
| Function (CI.Pointer x265, Returns (CI.Pointer x266)),
  "c_eigen_spmat_d_adjoint" ->
  (fun x264 ->
    CI.make_ptr x266 (owl_stub_75_c_eigen_spmat_d_adjoint (CI.cptr x264)))
| Function (CI.Pointer x268, Returns (CI.Pointer x269)),
  "c_eigen_spmat_d_transpose" ->
  (fun x267 ->
    CI.make_ptr x269 (owl_stub_74_c_eigen_spmat_d_transpose (CI.cptr x267)))
| Function
    (CI.Pointer x271,
     Function (CI.Primitive CI.Int64_t, Returns (CI.Pointer x273))),
  "c_eigen_spmat_d_col" ->
  (fun x270 x272 ->
    CI.make_ptr x273 (owl_stub_73_c_eigen_spmat_d_col (CI.cptr x270) x272))
| Function
    (CI.Pointer x275,
     Function (CI.Primitive CI.Int64_t, Returns (CI.Pointer x277))),
  "c_eigen_spmat_d_row" ->
  (fun x274 x276 ->
    CI.make_ptr x277 (owl_stub_72_c_eigen_spmat_d_row (CI.cptr x274) x276))
| Function (CI.Pointer x279, Returns (CI.Pointer x280)),
  "c_eigen_spmat_d_clone" ->
  (fun x278 ->
    CI.make_ptr x280 (owl_stub_71_c_eigen_spmat_d_clone (CI.cptr x278)))
| Function (CI.Pointer x282, Returns (CI.Pointer x283)),
  "c_eigen_spmat_d_outerindexptr" ->
  (fun x281 ->
    CI.make_ptr x283
      (owl_stub_70_c_eigen_spmat_d_outerindexptr (CI.cptr x281)))
| Function (CI.Pointer x285, Returns (CI.Pointer x286)),
  "c_eigen_spmat_d_innerindexptr" ->
  (fun x284 ->
    CI.make_ptr x286
      (owl_stub_69_c_eigen_spmat_d_innerindexptr (CI.cptr x284)))
| Function
    (CI.Pointer x288, Function (CI.Pointer x290, Returns (CI.Pointer x291))),
  "c_eigen_spmat_d_valueptr" ->
  (fun x287 x289 ->
    CI.make_ptr x291
      (owl_stub_68_c_eigen_spmat_d_valueptr (CI.cptr x287) (CI.cptr x289)))
| Function
    (CI.Pointer x293,
     Function
       (CI.Primitive CI.Double,
        Function (CI.Primitive CI.Double, Returns CI.Void))),
  "c_eigen_spmat_d_prune" ->
  (fun x292 x294 x295 ->
    owl_stub_67_c_eigen_spmat_d_prune (CI.cptr x292) x294 x295)
| Function
    (CI.Pointer x297,
     Function
       (CI.Primitive CI.Int64_t,
        Function (CI.Primitive CI.Int64_t, Returns CI.Void))),
  "c_eigen_spmat_d_reshape" ->
  (fun x296 x298 x299 ->
    owl_stub_66_c_eigen_spmat_d_reshape (CI.cptr x296) x298 x299)
| Function (CI.Pointer x301, Returns CI.Void), "c_eigen_spmat_d_uncompress" ->
  (fun x300 -> owl_stub_65_c_eigen_spmat_d_uncompress (CI.cptr x300))
| Function (CI.Pointer x303, Returns CI.Void), "c_eigen_spmat_d_compress" ->
  (fun x302 -> owl_stub_64_c_eigen_spmat_d_compress (CI.cptr x302))
| Function (CI.Pointer x305, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_compressed" ->
  (fun x304 -> owl_stub_63_c_eigen_spmat_d_is_compressed (CI.cptr x304))
| Function (CI.Pointer x307, Returns CI.Void), "c_eigen_spmat_d_reset" ->
  (fun x306 -> owl_stub_62_c_eigen_spmat_d_reset (CI.cptr x306))
| Function
    (CI.Pointer x309,
     Function
       (CI.Primitive CI.Int64_t,
        Function
          (CI.Primitive CI.Int64_t,
           Function (CI.Primitive CI.Double, Returns CI.Void)))),
  "c_eigen_spmat_d_set" ->
  (fun x308 x310 x311 x312 ->
    owl_stub_61_c_eigen_spmat_d_set (CI.cptr x308) x310 x311 x312)
| Function
    (CI.Pointer x314,
     Function
       (CI.Primitive CI.Int64_t,
        Function (CI.Primitive CI.Int64_t, Returns (CI.Primitive CI.Double)))),
  "c_eigen_spmat_d_get" ->
  (fun x313 x315 x316 ->
    owl_stub_60_c_eigen_spmat_d_get (CI.cptr x313) x315 x316)
| Function (CI.Pointer x318, Returns (CI.Primitive CI.Int64_t)),
  "c_eigen_spmat_d_nnz" ->
  (fun x317 -> owl_stub_59_c_eigen_spmat_d_nnz (CI.cptr x317))
| Function (CI.Pointer x320, Returns (CI.Primitive CI.Int64_t)),
  "c_eigen_spmat_d_cols" ->
  (fun x319 -> owl_stub_58_c_eigen_spmat_d_cols (CI.cptr x319))
| Function (CI.Pointer x322, Returns (CI.Primitive CI.Int64_t)),
  "c_eigen_spmat_d_rows" ->
  (fun x321 -> owl_stub_57_c_eigen_spmat_d_rows (CI.cptr x321))
| Function (CI.Primitive CI.Int64_t, Returns (CI.Pointer x324)),
  "c_eigen_spmat_d_eye" ->
  (fun x323 -> CI.make_ptr x324 (owl_stub_56_c_eigen_spmat_d_eye x323))
| Function (CI.Pointer x326, Returns CI.Void), "c_eigen_spmat_d_delete" ->
  (fun x325 -> owl_stub_55_c_eigen_spmat_d_delete (CI.cptr x325))
| Function
    (CI.Primitive CI.Int64_t,
     Function (CI.Primitive CI.Int64_t, Returns (CI.Pointer x329))),
  "c_eigen_spmat_d_new" ->
  (fun x327 x328 ->
    CI.make_ptr x329 (owl_stub_54_c_eigen_spmat_d_new x327 x328))
| Function (CI.Pointer x331, Returns CI.Void), "c_eigen_spmat_s_print" ->
  (fun x330 -> owl_stub_53_c_eigen_spmat_s_print (CI.cptr x330))
| Function (CI.Pointer x333, Returns (CI.Pointer x334)),
  "c_eigen_spmat_s_sqrt" ->
  (fun x332 ->
    CI.make_ptr x334 (owl_stub_52_c_eigen_spmat_s_sqrt (CI.cptr x332)))
| Function (CI.Pointer x336, Returns (CI.Pointer x337)),
  "c_eigen_spmat_s_neg" ->
  (fun x335 ->
    CI.make_ptr x337 (owl_stub_51_c_eigen_spmat_s_neg (CI.cptr x335)))
| Function (CI.Pointer x339, Returns (CI.Pointer x340)),
  "c_eigen_spmat_s_abs" ->
  (fun x338 ->
    CI.make_ptr x340 (owl_stub_50_c_eigen_spmat_s_abs (CI.cptr x338)))
| Function (CI.Pointer x342, Returns (CI.Primitive CI.Float)),
  "c_eigen_spmat_s_max" ->
  (fun x341 -> owl_stub_49_c_eigen_spmat_s_max (CI.cptr x341))
| Function (CI.Pointer x344, Returns (CI.Primitive CI.Float)),
  "c_eigen_spmat_s_min" ->
  (fun x343 -> owl_stub_48_c_eigen_spmat_s_min (CI.cptr x343))
| Function (CI.Pointer x346, Returns (CI.Primitive CI.Float)),
  "c_eigen_spmat_s_sum" ->
  (fun x345 -> owl_stub_47_c_eigen_spmat_s_sum (CI.cptr x345))
| Function
    (CI.Pointer x348, Function (CI.Pointer x350, Returns (CI.Pointer x351))),
  "c_eigen_spmat_s_max2" ->
  (fun x347 x349 ->
    CI.make_ptr x351
      (owl_stub_46_c_eigen_spmat_s_max2 (CI.cptr x347) (CI.cptr x349)))
| Function
    (CI.Pointer x353, Function (CI.Pointer x355, Returns (CI.Pointer x356))),
  "c_eigen_spmat_s_min2" ->
  (fun x352 x354 ->
    CI.make_ptr x356
      (owl_stub_45_c_eigen_spmat_s_min2 (CI.cptr x352) (CI.cptr x354)))
| Function
    (CI.Pointer x358,
     Function (CI.Primitive CI.Float, Returns (CI.Pointer x360))),
  "c_eigen_spmat_s_div_scalar" ->
  (fun x357 x359 ->
    CI.make_ptr x360
      (owl_stub_44_c_eigen_spmat_s_div_scalar (CI.cptr x357) x359))
| Function
    (CI.Pointer x362,
     Function (CI.Primitive CI.Float, Returns (CI.Pointer x364))),
  "c_eigen_spmat_s_mul_scalar" ->
  (fun x361 x363 ->
    CI.make_ptr x364
      (owl_stub_43_c_eigen_spmat_s_mul_scalar (CI.cptr x361) x363))
| Function
    (CI.Pointer x366,
     Function (CI.Primitive CI.Float, Returns (CI.Pointer x368))),
  "c_eigen_spmat_s_sub_scalar" ->
  (fun x365 x367 ->
    CI.make_ptr x368
      (owl_stub_42_c_eigen_spmat_s_sub_scalar (CI.cptr x365) x367))
| Function
    (CI.Pointer x370,
     Function (CI.Primitive CI.Float, Returns (CI.Pointer x372))),
  "c_eigen_spmat_s_add_scalar" ->
  (fun x369 x371 ->
    CI.make_ptr x372
      (owl_stub_41_c_eigen_spmat_s_add_scalar (CI.cptr x369) x371))
| Function
    (CI.Pointer x374, Function (CI.Pointer x376, Returns (CI.Pointer x377))),
  "c_eigen_spmat_s_dot" ->
  (fun x373 x375 ->
    CI.make_ptr x377
      (owl_stub_40_c_eigen_spmat_s_dot (CI.cptr x373) (CI.cptr x375)))
| Function
    (CI.Pointer x379, Function (CI.Pointer x381, Returns (CI.Pointer x382))),
  "c_eigen_spmat_s_div" ->
  (fun x378 x380 ->
    CI.make_ptr x382
      (owl_stub_39_c_eigen_spmat_s_div (CI.cptr x378) (CI.cptr x380)))
| Function
    (CI.Pointer x384, Function (CI.Pointer x386, Returns (CI.Pointer x387))),
  "c_eigen_spmat_s_mul" ->
  (fun x383 x385 ->
    CI.make_ptr x387
      (owl_stub_38_c_eigen_spmat_s_mul (CI.cptr x383) (CI.cptr x385)))
| Function
    (CI.Pointer x389, Function (CI.Pointer x391, Returns (CI.Pointer x392))),
  "c_eigen_spmat_s_sub" ->
  (fun x388 x390 ->
    CI.make_ptr x392
      (owl_stub_37_c_eigen_spmat_s_sub (CI.cptr x388) (CI.cptr x390)))
| Function
    (CI.Pointer x394, Function (CI.Pointer x396, Returns (CI.Pointer x397))),
  "c_eigen_spmat_s_add" ->
  (fun x393 x395 ->
    CI.make_ptr x397
      (owl_stub_36_c_eigen_spmat_s_add (CI.cptr x393) (CI.cptr x395)))
| Function
    (CI.Pointer x399,
     Function (CI.Pointer x401, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_s_equal_or_smaller" ->
  (fun x398 x400 ->
    owl_stub_35_c_eigen_spmat_s_equal_or_smaller (CI.cptr x398)
    (CI.cptr x400))
| Function
    (CI.Pointer x403,
     Function (CI.Pointer x405, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_s_equal_or_greater" ->
  (fun x402 x404 ->
    owl_stub_34_c_eigen_spmat_s_equal_or_greater (CI.cptr x402)
    (CI.cptr x404))
| Function
    (CI.Pointer x407,
     Function (CI.Pointer x409, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_s_is_smaller" ->
  (fun x406 x408 ->
    owl_stub_33_c_eigen_spmat_s_is_smaller (CI.cptr x406) (CI.cptr x408))
| Function
    (CI.Pointer x411,
     Function (CI.Pointer x413, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_s_is_greater" ->
  (fun x410 x412 ->
    owl_stub_32_c_eigen_spmat_s_is_greater (CI.cptr x410) (CI.cptr x412))
| Function
    (CI.Pointer x415,
     Function (CI.Pointer x417, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_s_is_unequal" ->
  (fun x414 x416 ->
    owl_stub_31_c_eigen_spmat_s_is_unequal (CI.cptr x414) (CI.cptr x416))
| Function
    (CI.Pointer x419,
     Function (CI.Pointer x421, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_s_is_equal" ->
  (fun x418 x420 ->
    owl_stub_30_c_eigen_spmat_s_is_equal (CI.cptr x418) (CI.cptr x420))
| Function (CI.Pointer x423, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_s_is_nonnegative" ->
  (fun x422 -> owl_stub_29_c_eigen_spmat_s_is_nonnegative (CI.cptr x422))
| Function (CI.Pointer x425, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_s_is_nonpositive" ->
  (fun x424 -> owl_stub_28_c_eigen_spmat_s_is_nonpositive (CI.cptr x424))
| Function (CI.Pointer x427, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_s_is_negative" ->
  (fun x426 -> owl_stub_27_c_eigen_spmat_s_is_negative (CI.cptr x426))
| Function (CI.Pointer x429, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_s_is_positive" ->
  (fun x428 -> owl_stub_26_c_eigen_spmat_s_is_positive (CI.cptr x428))
| Function (CI.Pointer x431, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_s_is_zero" ->
  (fun x430 -> owl_stub_25_c_eigen_spmat_s_is_zero (CI.cptr x430))
| Function (CI.Pointer x433, Returns (CI.Primitive CI.Float)),
  "c_eigen_spmat_s_trace" ->
  (fun x432 -> owl_stub_24_c_eigen_spmat_s_trace (CI.cptr x432))
| Function (CI.Pointer x435, Returns (CI.Pointer x436)),
  "c_eigen_spmat_s_diagonal" ->
  (fun x434 ->
    CI.make_ptr x436 (owl_stub_23_c_eigen_spmat_s_diagonal (CI.cptr x434)))
| Function (CI.Pointer x438, Returns (CI.Pointer x439)),
  "c_eigen_spmat_s_adjoint" ->
  (fun x437 ->
    CI.make_ptr x439 (owl_stub_22_c_eigen_spmat_s_adjoint (CI.cptr x437)))
| Function (CI.Pointer x441, Returns (CI.Pointer x442)),
  "c_eigen_spmat_s_transpose" ->
  (fun x440 ->
    CI.make_ptr x442 (owl_stub_21_c_eigen_spmat_s_transpose (CI.cptr x440)))
| Function
    (CI.Pointer x444,
     Function (CI.Primitive CI.Int64_t, Returns (CI.Pointer x446))),
  "c_eigen_spmat_s_col" ->
  (fun x443 x445 ->
    CI.make_ptr x446 (owl_stub_20_c_eigen_spmat_s_col (CI.cptr x443) x445))
| Function
    (CI.Pointer x448,
     Function (CI.Primitive CI.Int64_t, Returns (CI.Pointer x450))),
  "c_eigen_spmat_s_row" ->
  (fun x447 x449 ->
    CI.make_ptr x450 (owl_stub_19_c_eigen_spmat_s_row (CI.cptr x447) x449))
| Function (CI.Pointer x452, Returns (CI.Pointer x453)),
  "c_eigen_spmat_s_clone" ->
  (fun x451 ->
    CI.make_ptr x453 (owl_stub_18_c_eigen_spmat_s_clone (CI.cptr x451)))
| Function (CI.Pointer x455, Returns (CI.Pointer x456)),
  "c_eigen_spmat_s_outerindexptr" ->
  (fun x454 ->
    CI.make_ptr x456
      (owl_stub_17_c_eigen_spmat_s_outerindexptr (CI.cptr x454)))
| Function (CI.Pointer x458, Returns (CI.Pointer x459)),
  "c_eigen_spmat_s_innerindexptr" ->
  (fun x457 ->
    CI.make_ptr x459
      (owl_stub_16_c_eigen_spmat_s_innerindexptr (CI.cptr x457)))
| Function
    (CI.Pointer x461, Function (CI.Pointer x463, Returns (CI.Pointer x464))),
  "c_eigen_spmat_s_valueptr" ->
  (fun x460 x462 ->
    CI.make_ptr x464
      (owl_stub_15_c_eigen_spmat_s_valueptr (CI.cptr x460) (CI.cptr x462)))
| Function
    (CI.Pointer x466,
     Function
       (CI.Primitive CI.Float,
        Function (CI.Primitive CI.Float, Returns CI.Void))),
  "c_eigen_spmat_s_prune" ->
  (fun x465 x467 x468 ->
    owl_stub_14_c_eigen_spmat_s_prune (CI.cptr x465) x467 x468)
| Function
    (CI.Pointer x470,
     Function
       (CI.Primitive CI.Int64_t,
        Function (CI.Primitive CI.Int64_t, Returns CI.Void))),
  "c_eigen_spmat_s_reshape" ->
  (fun x469 x471 x472 ->
    owl_stub_13_c_eigen_spmat_s_reshape (CI.cptr x469) x471 x472)
| Function (CI.Pointer x474, Returns CI.Void), "c_eigen_spmat_s_uncompress" ->
  (fun x473 -> owl_stub_12_c_eigen_spmat_s_uncompress (CI.cptr x473))
| Function (CI.Pointer x476, Returns CI.Void), "c_eigen_spmat_s_compress" ->
  (fun x475 -> owl_stub_11_c_eigen_spmat_s_compress (CI.cptr x475))
| Function (CI.Pointer x478, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_s_is_compressed" ->
  (fun x477 -> owl_stub_10_c_eigen_spmat_s_is_compressed (CI.cptr x477))
| Function (CI.Pointer x480, Returns CI.Void), "c_eigen_spmat_s_reset" ->
  (fun x479 -> owl_stub_9_c_eigen_spmat_s_reset (CI.cptr x479))
| Function
    (CI.Pointer x482,
     Function
       (CI.Primitive CI.Int64_t,
        Function
          (CI.Primitive CI.Int64_t,
           Function (CI.Primitive CI.Float, Returns CI.Void)))),
  "c_eigen_spmat_s_set" ->
  (fun x481 x483 x484 x485 ->
    owl_stub_8_c_eigen_spmat_s_set (CI.cptr x481) x483 x484 x485)
| Function
    (CI.Pointer x487,
     Function
       (CI.Primitive CI.Int64_t,
        Function (CI.Primitive CI.Int64_t, Returns (CI.Primitive CI.Float)))),
  "c_eigen_spmat_s_get" ->
  (fun x486 x488 x489 ->
    owl_stub_7_c_eigen_spmat_s_get (CI.cptr x486) x488 x489)
| Function (CI.Pointer x491, Returns (CI.Primitive CI.Int64_t)),
  "c_eigen_spmat_s_nnz" ->
  (fun x490 -> owl_stub_6_c_eigen_spmat_s_nnz (CI.cptr x490))
| Function (CI.Pointer x493, Returns (CI.Primitive CI.Int64_t)),
  "c_eigen_spmat_s_cols" ->
  (fun x492 -> owl_stub_5_c_eigen_spmat_s_cols (CI.cptr x492))
| Function (CI.Pointer x495, Returns (CI.Primitive CI.Int64_t)),
  "c_eigen_spmat_s_rows" ->
  (fun x494 -> owl_stub_4_c_eigen_spmat_s_rows (CI.cptr x494))
| Function (CI.Primitive CI.Int64_t, Returns (CI.Pointer x497)),
  "c_eigen_spmat_s_eye" ->
  (fun x496 -> CI.make_ptr x497 (owl_stub_3_c_eigen_spmat_s_eye x496))
| Function (CI.Pointer x499, Returns CI.Void), "c_eigen_spmat_s_delete" ->
  (fun x498 -> owl_stub_2_c_eigen_spmat_s_delete (CI.cptr x498))
| Function
    (CI.Primitive CI.Int64_t,
     Function (CI.Primitive CI.Int64_t, Returns (CI.Pointer x502))),
  "c_eigen_spmat_s_new" ->
  (fun x500 x501 ->
    CI.make_ptr x502 (owl_stub_1_c_eigen_spmat_s_new x500 x501))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

