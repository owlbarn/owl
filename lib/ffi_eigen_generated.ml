module CI = Cstubs_internals

external owl_stub_1_c_eigen_spmat_d_new : int -> int -> CI.voidp
  = "owl_stub_1_c_eigen_spmat_d_new" 

external owl_stub_2_c_eigen_spmat_d_delete : _ CI.fatptr -> unit
  = "owl_stub_2_c_eigen_spmat_d_delete" 

external owl_stub_3_c_eigen_spmat_d_eye : int -> CI.voidp
  = "owl_stub_3_c_eigen_spmat_d_eye" 

external owl_stub_4_c_eigen_spmat_d_rows : _ CI.fatptr -> int
  = "owl_stub_4_c_eigen_spmat_d_rows" 

external owl_stub_5_c_eigen_spmat_d_cols : _ CI.fatptr -> int
  = "owl_stub_5_c_eigen_spmat_d_cols" 

external owl_stub_6_c_eigen_spmat_d_nnz : _ CI.fatptr -> int
  = "owl_stub_6_c_eigen_spmat_d_nnz" 

external owl_stub_7_c_eigen_spmat_d_get : _ CI.fatptr -> int -> int -> float
  = "owl_stub_7_c_eigen_spmat_d_get" 

external owl_stub_8_c_eigen_spmat_d_set
  : _ CI.fatptr -> int -> int -> float -> unit
  = "owl_stub_8_c_eigen_spmat_d_set" 

external owl_stub_9_c_eigen_spmat_d_reset : _ CI.fatptr -> unit
  = "owl_stub_9_c_eigen_spmat_d_reset" 

external owl_stub_10_c_eigen_spmat_d_is_compressed : _ CI.fatptr -> int
  = "owl_stub_10_c_eigen_spmat_d_is_compressed" 

external owl_stub_11_c_eigen_spmat_d_compress : _ CI.fatptr -> unit
  = "owl_stub_11_c_eigen_spmat_d_compress" 

external owl_stub_12_c_eigen_spmat_d_uncompress : _ CI.fatptr -> unit
  = "owl_stub_12_c_eigen_spmat_d_uncompress" 

external owl_stub_13_c_eigen_spmat_d_reshape
  : _ CI.fatptr -> int -> int -> unit = "owl_stub_13_c_eigen_spmat_d_reshape" 

external owl_stub_14_c_eigen_spmat_d_prune
  : _ CI.fatptr -> float -> float -> unit
  = "owl_stub_14_c_eigen_spmat_d_prune" 

external owl_stub_15_c_eigen_spmat_d_clone : _ CI.fatptr -> CI.voidp
  = "owl_stub_15_c_eigen_spmat_d_clone" 

external owl_stub_16_c_eigen_spmat_d_row : _ CI.fatptr -> int -> CI.voidp
  = "owl_stub_16_c_eigen_spmat_d_row" 

external owl_stub_17_c_eigen_spmat_d_col : _ CI.fatptr -> int -> CI.voidp
  = "owl_stub_17_c_eigen_spmat_d_col" 

external owl_stub_18_c_eigen_spmat_d_transpose : _ CI.fatptr -> CI.voidp
  = "owl_stub_18_c_eigen_spmat_d_transpose" 

external owl_stub_19_c_eigen_spmat_d_adjoint : _ CI.fatptr -> CI.voidp
  = "owl_stub_19_c_eigen_spmat_d_adjoint" 

external owl_stub_20_c_eigen_spmat_d_is_zero : _ CI.fatptr -> int
  = "owl_stub_20_c_eigen_spmat_d_is_zero" 

external owl_stub_21_c_eigen_spmat_d_is_positive : _ CI.fatptr -> int
  = "owl_stub_21_c_eigen_spmat_d_is_positive" 

external owl_stub_22_c_eigen_spmat_d_is_negative : _ CI.fatptr -> int
  = "owl_stub_22_c_eigen_spmat_d_is_negative" 

external owl_stub_23_c_eigen_spmat_d_is_nonpositive : _ CI.fatptr -> int
  = "owl_stub_23_c_eigen_spmat_d_is_nonpositive" 

external owl_stub_24_c_eigen_spmat_d_is_nonnegative : _ CI.fatptr -> int
  = "owl_stub_24_c_eigen_spmat_d_is_nonnegative" 

external owl_stub_25_c_eigen_spmat_d_is_equal
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_25_c_eigen_spmat_d_is_equal" 

external owl_stub_26_c_eigen_spmat_d_is_unequal
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_26_c_eigen_spmat_d_is_unequal" 

external owl_stub_27_c_eigen_spmat_d_is_greater
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_27_c_eigen_spmat_d_is_greater" 

external owl_stub_28_c_eigen_spmat_d_is_smaller
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_28_c_eigen_spmat_d_is_smaller" 

external owl_stub_29_c_eigen_spmat_d_equal_or_greater
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_29_c_eigen_spmat_d_equal_or_greater" 

external owl_stub_30_c_eigen_spmat_d_equal_or_smaller
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_30_c_eigen_spmat_d_equal_or_smaller" 

external owl_stub_31_c_eigen_spmat_d_add
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_31_c_eigen_spmat_d_add" 

external owl_stub_32_c_eigen_spmat_d_sub
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_32_c_eigen_spmat_d_sub" 

external owl_stub_33_c_eigen_spmat_d_mul
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_33_c_eigen_spmat_d_mul" 

external owl_stub_34_c_eigen_spmat_d_div
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_34_c_eigen_spmat_d_div" 

external owl_stub_35_c_eigen_spmat_d_dot
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_35_c_eigen_spmat_d_dot" 

external owl_stub_36_c_eigen_spmat_d_add_scalar
  : _ CI.fatptr -> float -> CI.voidp
  = "owl_stub_36_c_eigen_spmat_d_add_scalar" 

external owl_stub_37_c_eigen_spmat_d_sub_scalar
  : _ CI.fatptr -> float -> CI.voidp
  = "owl_stub_37_c_eigen_spmat_d_sub_scalar" 

external owl_stub_38_c_eigen_spmat_d_mul_scalar
  : _ CI.fatptr -> float -> CI.voidp
  = "owl_stub_38_c_eigen_spmat_d_mul_scalar" 

external owl_stub_39_c_eigen_spmat_d_div_scalar
  : _ CI.fatptr -> float -> CI.voidp
  = "owl_stub_39_c_eigen_spmat_d_div_scalar" 

external owl_stub_40_c_eigen_spmat_d_min2
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_40_c_eigen_spmat_d_min2" 

external owl_stub_41_c_eigen_spmat_d_max2
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_41_c_eigen_spmat_d_max2" 

external owl_stub_42_c_eigen_spmat_d_sum : _ CI.fatptr -> float
  = "owl_stub_42_c_eigen_spmat_d_sum" 

external owl_stub_43_c_eigen_spmat_d_min : _ CI.fatptr -> float
  = "owl_stub_43_c_eigen_spmat_d_min" 

external owl_stub_44_c_eigen_spmat_d_max : _ CI.fatptr -> float
  = "owl_stub_44_c_eigen_spmat_d_max" 

external owl_stub_45_c_eigen_spmat_d_abs : _ CI.fatptr -> CI.voidp
  = "owl_stub_45_c_eigen_spmat_d_abs" 

external owl_stub_46_c_eigen_spmat_d_neg : _ CI.fatptr -> CI.voidp
  = "owl_stub_46_c_eigen_spmat_d_neg" 

external owl_stub_47_c_eigen_spmat_d_sqrt : _ CI.fatptr -> CI.voidp
  = "owl_stub_47_c_eigen_spmat_d_sqrt" 

external owl_stub_48_c_eigen_spmat_d_print : _ CI.fatptr -> unit
  = "owl_stub_48_c_eigen_spmat_d_print" 

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
| Function (CI.Pointer x2, Returns CI.Void), "c_eigen_spmat_d_print" ->
  (fun x1 -> owl_stub_48_c_eigen_spmat_d_print (CI.cptr x1))
| Function (CI.Pointer x4, Returns (CI.Pointer x5)), "c_eigen_spmat_d_sqrt" ->
  (fun x3 -> CI.make_ptr x5 (owl_stub_47_c_eigen_spmat_d_sqrt (CI.cptr x3)))
| Function (CI.Pointer x7, Returns (CI.Pointer x8)), "c_eigen_spmat_d_neg" ->
  (fun x6 -> CI.make_ptr x8 (owl_stub_46_c_eigen_spmat_d_neg (CI.cptr x6)))
| Function (CI.Pointer x10, Returns (CI.Pointer x11)), "c_eigen_spmat_d_abs" ->
  (fun x9 -> CI.make_ptr x11 (owl_stub_45_c_eigen_spmat_d_abs (CI.cptr x9)))
| Function (CI.Pointer x13, Returns (CI.Primitive CI.Double)),
  "c_eigen_spmat_d_max" ->
  (fun x12 -> owl_stub_44_c_eigen_spmat_d_max (CI.cptr x12))
| Function (CI.Pointer x15, Returns (CI.Primitive CI.Double)),
  "c_eigen_spmat_d_min" ->
  (fun x14 -> owl_stub_43_c_eigen_spmat_d_min (CI.cptr x14))
| Function (CI.Pointer x17, Returns (CI.Primitive CI.Double)),
  "c_eigen_spmat_d_sum" ->
  (fun x16 -> owl_stub_42_c_eigen_spmat_d_sum (CI.cptr x16))
| Function
    (CI.Pointer x19, Function (CI.Pointer x21, Returns (CI.Pointer x22))),
  "c_eigen_spmat_d_max2" ->
  (fun x18 x20 ->
    CI.make_ptr x22
      (owl_stub_41_c_eigen_spmat_d_max2 (CI.cptr x18) (CI.cptr x20)))
| Function
    (CI.Pointer x24, Function (CI.Pointer x26, Returns (CI.Pointer x27))),
  "c_eigen_spmat_d_min2" ->
  (fun x23 x25 ->
    CI.make_ptr x27
      (owl_stub_40_c_eigen_spmat_d_min2 (CI.cptr x23) (CI.cptr x25)))
| Function
    (CI.Pointer x29,
     Function (CI.Primitive CI.Double, Returns (CI.Pointer x31))),
  "c_eigen_spmat_d_div_scalar" ->
  (fun x28 x30 ->
    CI.make_ptr x31
      (owl_stub_39_c_eigen_spmat_d_div_scalar (CI.cptr x28) x30))
| Function
    (CI.Pointer x33,
     Function (CI.Primitive CI.Double, Returns (CI.Pointer x35))),
  "c_eigen_spmat_d_mul_scalar" ->
  (fun x32 x34 ->
    CI.make_ptr x35
      (owl_stub_38_c_eigen_spmat_d_mul_scalar (CI.cptr x32) x34))
| Function
    (CI.Pointer x37,
     Function (CI.Primitive CI.Double, Returns (CI.Pointer x39))),
  "c_eigen_spmat_d_sub_scalar" ->
  (fun x36 x38 ->
    CI.make_ptr x39
      (owl_stub_37_c_eigen_spmat_d_sub_scalar (CI.cptr x36) x38))
| Function
    (CI.Pointer x41,
     Function (CI.Primitive CI.Double, Returns (CI.Pointer x43))),
  "c_eigen_spmat_d_add_scalar" ->
  (fun x40 x42 ->
    CI.make_ptr x43
      (owl_stub_36_c_eigen_spmat_d_add_scalar (CI.cptr x40) x42))
| Function
    (CI.Pointer x45, Function (CI.Pointer x47, Returns (CI.Pointer x48))),
  "c_eigen_spmat_d_dot" ->
  (fun x44 x46 ->
    CI.make_ptr x48
      (owl_stub_35_c_eigen_spmat_d_dot (CI.cptr x44) (CI.cptr x46)))
| Function
    (CI.Pointer x50, Function (CI.Pointer x52, Returns (CI.Pointer x53))),
  "c_eigen_spmat_d_div" ->
  (fun x49 x51 ->
    CI.make_ptr x53
      (owl_stub_34_c_eigen_spmat_d_div (CI.cptr x49) (CI.cptr x51)))
| Function
    (CI.Pointer x55, Function (CI.Pointer x57, Returns (CI.Pointer x58))),
  "c_eigen_spmat_d_mul" ->
  (fun x54 x56 ->
    CI.make_ptr x58
      (owl_stub_33_c_eigen_spmat_d_mul (CI.cptr x54) (CI.cptr x56)))
| Function
    (CI.Pointer x60, Function (CI.Pointer x62, Returns (CI.Pointer x63))),
  "c_eigen_spmat_d_sub" ->
  (fun x59 x61 ->
    CI.make_ptr x63
      (owl_stub_32_c_eigen_spmat_d_sub (CI.cptr x59) (CI.cptr x61)))
| Function
    (CI.Pointer x65, Function (CI.Pointer x67, Returns (CI.Pointer x68))),
  "c_eigen_spmat_d_add" ->
  (fun x64 x66 ->
    CI.make_ptr x68
      (owl_stub_31_c_eigen_spmat_d_add (CI.cptr x64) (CI.cptr x66)))
| Function
    (CI.Pointer x70,
     Function (CI.Pointer x72, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_d_equal_or_smaller" ->
  (fun x69 x71 ->
    owl_stub_30_c_eigen_spmat_d_equal_or_smaller (CI.cptr x69) (CI.cptr x71))
| Function
    (CI.Pointer x74,
     Function (CI.Pointer x76, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_d_equal_or_greater" ->
  (fun x73 x75 ->
    owl_stub_29_c_eigen_spmat_d_equal_or_greater (CI.cptr x73) (CI.cptr x75))
| Function
    (CI.Pointer x78,
     Function (CI.Pointer x80, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_d_is_smaller" ->
  (fun x77 x79 ->
    owl_stub_28_c_eigen_spmat_d_is_smaller (CI.cptr x77) (CI.cptr x79))
| Function
    (CI.Pointer x82,
     Function (CI.Pointer x84, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_d_is_greater" ->
  (fun x81 x83 ->
    owl_stub_27_c_eigen_spmat_d_is_greater (CI.cptr x81) (CI.cptr x83))
| Function
    (CI.Pointer x86,
     Function (CI.Pointer x88, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_d_is_unequal" ->
  (fun x85 x87 ->
    owl_stub_26_c_eigen_spmat_d_is_unequal (CI.cptr x85) (CI.cptr x87))
| Function
    (CI.Pointer x90,
     Function (CI.Pointer x92, Returns (CI.Primitive CI.Int))),
  "c_eigen_spmat_d_is_equal" ->
  (fun x89 x91 ->
    owl_stub_25_c_eigen_spmat_d_is_equal (CI.cptr x89) (CI.cptr x91))
| Function (CI.Pointer x94, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_nonnegative" ->
  (fun x93 -> owl_stub_24_c_eigen_spmat_d_is_nonnegative (CI.cptr x93))
| Function (CI.Pointer x96, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_nonpositive" ->
  (fun x95 -> owl_stub_23_c_eigen_spmat_d_is_nonpositive (CI.cptr x95))
| Function (CI.Pointer x98, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_negative" ->
  (fun x97 -> owl_stub_22_c_eigen_spmat_d_is_negative (CI.cptr x97))
| Function (CI.Pointer x100, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_positive" ->
  (fun x99 -> owl_stub_21_c_eigen_spmat_d_is_positive (CI.cptr x99))
| Function (CI.Pointer x102, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_zero" ->
  (fun x101 -> owl_stub_20_c_eigen_spmat_d_is_zero (CI.cptr x101))
| Function (CI.Pointer x104, Returns (CI.Pointer x105)),
  "c_eigen_spmat_d_adjoint" ->
  (fun x103 ->
    CI.make_ptr x105 (owl_stub_19_c_eigen_spmat_d_adjoint (CI.cptr x103)))
| Function (CI.Pointer x107, Returns (CI.Pointer x108)),
  "c_eigen_spmat_d_transpose" ->
  (fun x106 ->
    CI.make_ptr x108 (owl_stub_18_c_eigen_spmat_d_transpose (CI.cptr x106)))
| Function
    (CI.Pointer x110,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x112))),
  "c_eigen_spmat_d_col" ->
  (fun x109 x111 ->
    CI.make_ptr x112 (owl_stub_17_c_eigen_spmat_d_col (CI.cptr x109) x111))
| Function
    (CI.Pointer x114,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x116))),
  "c_eigen_spmat_d_row" ->
  (fun x113 x115 ->
    CI.make_ptr x116 (owl_stub_16_c_eigen_spmat_d_row (CI.cptr x113) x115))
| Function (CI.Pointer x118, Returns (CI.Pointer x119)),
  "c_eigen_spmat_d_clone" ->
  (fun x117 ->
    CI.make_ptr x119 (owl_stub_15_c_eigen_spmat_d_clone (CI.cptr x117)))
| Function
    (CI.Pointer x121,
     Function
       (CI.Primitive CI.Double,
        Function (CI.Primitive CI.Double, Returns CI.Void))),
  "c_eigen_spmat_d_prune" ->
  (fun x120 x122 x123 ->
    owl_stub_14_c_eigen_spmat_d_prune (CI.cptr x120) x122 x123)
| Function
    (CI.Pointer x125,
     Function
       (CI.Primitive CI.Int, Function (CI.Primitive CI.Int, Returns CI.Void))),
  "c_eigen_spmat_d_reshape" ->
  (fun x124 x126 x127 ->
    owl_stub_13_c_eigen_spmat_d_reshape (CI.cptr x124) x126 x127)
| Function (CI.Pointer x129, Returns CI.Void), "c_eigen_spmat_d_uncompress" ->
  (fun x128 -> owl_stub_12_c_eigen_spmat_d_uncompress (CI.cptr x128))
| Function (CI.Pointer x131, Returns CI.Void), "c_eigen_spmat_d_compress" ->
  (fun x130 -> owl_stub_11_c_eigen_spmat_d_compress (CI.cptr x130))
| Function (CI.Pointer x133, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_compressed" ->
  (fun x132 -> owl_stub_10_c_eigen_spmat_d_is_compressed (CI.cptr x132))
| Function (CI.Pointer x135, Returns CI.Void), "c_eigen_spmat_d_reset" ->
  (fun x134 -> owl_stub_9_c_eigen_spmat_d_reset (CI.cptr x134))
| Function
    (CI.Pointer x137,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function (CI.Primitive CI.Double, Returns CI.Void)))),
  "c_eigen_spmat_d_set" ->
  (fun x136 x138 x139 x140 ->
    owl_stub_8_c_eigen_spmat_d_set (CI.cptr x136) x138 x139 x140)
| Function
    (CI.Pointer x142,
     Function
       (CI.Primitive CI.Int,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "c_eigen_spmat_d_get" ->
  (fun x141 x143 x144 ->
    owl_stub_7_c_eigen_spmat_d_get (CI.cptr x141) x143 x144)
| Function (CI.Pointer x146, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_nnz" ->
  (fun x145 -> owl_stub_6_c_eigen_spmat_d_nnz (CI.cptr x145))
| Function (CI.Pointer x148, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_cols" ->
  (fun x147 -> owl_stub_5_c_eigen_spmat_d_cols (CI.cptr x147))
| Function (CI.Pointer x150, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_rows" ->
  (fun x149 -> owl_stub_4_c_eigen_spmat_d_rows (CI.cptr x149))
| Function (CI.Primitive CI.Int, Returns (CI.Pointer x152)),
  "c_eigen_spmat_d_eye" ->
  (fun x151 -> CI.make_ptr x152 (owl_stub_3_c_eigen_spmat_d_eye x151))
| Function (CI.Pointer x154, Returns CI.Void), "c_eigen_spmat_d_delete" ->
  (fun x153 -> owl_stub_2_c_eigen_spmat_d_delete (CI.cptr x153))
| Function
    (CI.Primitive CI.Int,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x157))),
  "c_eigen_spmat_d_new" ->
  (fun x155 x156 ->
    CI.make_ptr x157 (owl_stub_1_c_eigen_spmat_d_new x155 x156))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

