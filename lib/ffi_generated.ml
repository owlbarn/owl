module CI = Cstubs_internals

external owl_stub_1_gsl_matrix_equal : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_1_gsl_matrix_equal" 

external owl_stub_2_gsl_matrix_isnull : _ CI.fatptr -> int
  = "owl_stub_2_gsl_matrix_isnull" 

external owl_stub_3_gsl_matrix_ispos : _ CI.fatptr -> int
  = "owl_stub_3_gsl_matrix_ispos" 

external owl_stub_4_gsl_matrix_isneg : _ CI.fatptr -> int
  = "owl_stub_4_gsl_matrix_isneg" 

external owl_stub_5_gsl_matrix_isnonneg : _ CI.fatptr -> int
  = "owl_stub_5_gsl_matrix_isnonneg" 

external owl_stub_6_gsl_matrix_min : _ CI.fatptr -> float
  = "owl_stub_6_gsl_matrix_min" 

external owl_stub_7_gsl_matrix_max : _ CI.fatptr -> float
  = "owl_stub_7_gsl_matrix_max" 

external owl_stub_8_gsl_matrix_min_index
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> unit
  = "owl_stub_8_gsl_matrix_min_index" 

external owl_stub_9_gsl_matrix_max_index
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> unit
  = "owl_stub_9_gsl_matrix_max_index" 

external owl_stub_10_gsl_vector_alloc : Unsigned.size_t -> CI.voidp
  = "owl_stub_10_gsl_vector_alloc" 

external owl_stub_11_gsl_matrix_alloc
  : Unsigned.size_t -> Unsigned.size_t -> CI.voidp
  = "owl_stub_11_gsl_matrix_alloc" 

external owl_stub_12_gsl_matrix_get_col
  : _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_12_gsl_matrix_get_col" 

external owl_stub_13_gsl_matrix_float_equal
  : _ CI.fatptr -> _ CI.fatptr -> int = "owl_stub_13_gsl_matrix_float_equal" 

external owl_stub_14_gsl_matrix_float_isnull : _ CI.fatptr -> int
  = "owl_stub_14_gsl_matrix_float_isnull" 

external owl_stub_15_gsl_matrix_float_ispos : _ CI.fatptr -> int
  = "owl_stub_15_gsl_matrix_float_ispos" 

external owl_stub_16_gsl_matrix_float_isneg : _ CI.fatptr -> int
  = "owl_stub_16_gsl_matrix_float_isneg" 

external owl_stub_17_gsl_matrix_float_isnonneg : _ CI.fatptr -> int
  = "owl_stub_17_gsl_matrix_float_isnonneg" 

external owl_stub_18_gsl_matrix_float_min : _ CI.fatptr -> float
  = "owl_stub_18_gsl_matrix_float_min" 

external owl_stub_19_gsl_matrix_float_max : _ CI.fatptr -> float
  = "owl_stub_19_gsl_matrix_float_max" 

external owl_stub_20_gsl_matrix_float_min_index
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> unit
  = "owl_stub_20_gsl_matrix_float_min_index" 

external owl_stub_21_gsl_matrix_float_max_index
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> unit
  = "owl_stub_21_gsl_matrix_float_max_index" 

external owl_stub_22_gsl_matrix_complex_equal
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_22_gsl_matrix_complex_equal" 

external owl_stub_23_gsl_matrix_complex_isnull : _ CI.fatptr -> int
  = "owl_stub_23_gsl_matrix_complex_isnull" 

external owl_stub_24_gsl_matrix_complex_ispos : _ CI.fatptr -> int
  = "owl_stub_24_gsl_matrix_complex_ispos" 

external owl_stub_25_gsl_matrix_complex_isneg : _ CI.fatptr -> int
  = "owl_stub_25_gsl_matrix_complex_isneg" 

external owl_stub_26_gsl_matrix_complex_isnonneg : _ CI.fatptr -> int
  = "owl_stub_26_gsl_matrix_complex_isnonneg" 

external owl_stub_27_gsl_matrix_complex_float_equal
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_27_gsl_matrix_complex_float_equal" 

external owl_stub_28_gsl_matrix_complex_float_isnull : _ CI.fatptr -> int
  = "owl_stub_28_gsl_matrix_complex_float_isnull" 

external owl_stub_29_gsl_matrix_complex_float_ispos : _ CI.fatptr -> int
  = "owl_stub_29_gsl_matrix_complex_float_ispos" 

external owl_stub_30_gsl_matrix_complex_float_isneg : _ CI.fatptr -> int
  = "owl_stub_30_gsl_matrix_complex_float_isneg" 

external owl_stub_31_gsl_matrix_complex_float_isnonneg : _ CI.fatptr -> int
  = "owl_stub_31_gsl_matrix_complex_float_isnonneg" 

external owl_stub_32_gsl_spmatrix_alloc : int -> int -> CI.voidp
  = "owl_stub_32_gsl_spmatrix_alloc" 

external owl_stub_33_gsl_spmatrix_alloc_nzmax
  : int -> int -> int -> int -> CI.voidp
  = "owl_stub_33_gsl_spmatrix_alloc_nzmax" 

external owl_stub_34_gsl_spmatrix_set
  : _ CI.fatptr -> int -> int -> float -> int
  = "owl_stub_34_gsl_spmatrix_set" 

external owl_stub_35_gsl_spmatrix_get : _ CI.fatptr -> int -> int -> float
  = "owl_stub_35_gsl_spmatrix_get" 

external owl_stub_36_gsl_spmatrix_add
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_36_gsl_spmatrix_add" 

external owl_stub_37_gsl_spmatrix_scale : _ CI.fatptr -> float -> int
  = "owl_stub_37_gsl_spmatrix_scale" 

external owl_stub_38_gsl_spmatrix_memcpy : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_38_gsl_spmatrix_memcpy" 

external owl_stub_39_gsl_spmatrix_compcol : _ CI.fatptr -> CI.voidp
  = "owl_stub_39_gsl_spmatrix_compcol" 

external owl_stub_40_gsl_spmatrix_minmax
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_40_gsl_spmatrix_minmax" 

external owl_stub_41_gsl_spmatrix_equal : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_41_gsl_spmatrix_equal" 

external owl_stub_42_gsl_spmatrix_transpose_memcpy
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_42_gsl_spmatrix_transpose_memcpy" 

external owl_stub_43_gsl_spmatrix_set_zero : _ CI.fatptr -> int
  = "owl_stub_43_gsl_spmatrix_set_zero" 

external owl_stub_44_gsl_spblas_dgemm
  : float -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_44_gsl_spblas_dgemm" 

external owl_stub_45_gsl_spmatrix_d2sp : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_45_gsl_spmatrix_d2sp" 

external owl_stub_46_gsl_spmatrix_sp2d : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_46_gsl_spmatrix_sp2d" 

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
    (CI.Pointer x2, Function (CI.Pointer x4, Returns (CI.Primitive CI.Int))),
  "gsl_spmatrix_sp2d" ->
  (fun x1 x3 -> owl_stub_46_gsl_spmatrix_sp2d (CI.cptr x1) (CI.cptr x3))
| Function
    (CI.Pointer x6, Function (CI.Pointer x8, Returns (CI.Primitive CI.Int))),
  "gsl_spmatrix_d2sp" ->
  (fun x5 x7 -> owl_stub_45_gsl_spmatrix_d2sp (CI.cptr x5) (CI.cptr x7))
| Function
    (CI.Primitive CI.Double,
     Function
       (CI.Pointer x11,
        Function
          (CI.Pointer x13,
           Function (CI.Pointer x15, Returns (CI.Primitive CI.Int))))),
  "gsl_spblas_dgemm" ->
  (fun x9 x10 x12 x14 ->
    owl_stub_44_gsl_spblas_dgemm x9 (CI.cptr x10) (CI.cptr x12) (CI.cptr x14))
| Function (CI.Pointer x17, Returns (CI.Primitive CI.Int)),
  "gsl_spmatrix_set_zero" ->
  (fun x16 -> owl_stub_43_gsl_spmatrix_set_zero (CI.cptr x16))
| Function
    (CI.Pointer x19,
     Function (CI.Pointer x21, Returns (CI.Primitive CI.Int))),
  "gsl_spmatrix_transpose_memcpy" ->
  (fun x18 x20 ->
    owl_stub_42_gsl_spmatrix_transpose_memcpy (CI.cptr x18) (CI.cptr x20))
| Function
    (CI.Pointer x23,
     Function (CI.Pointer x25, Returns (CI.Primitive CI.Int))),
  "gsl_spmatrix_equal" ->
  (fun x22 x24 -> owl_stub_41_gsl_spmatrix_equal (CI.cptr x22) (CI.cptr x24))
| Function
    (CI.Pointer x27,
     Function
       (CI.Pointer x29,
        Function (CI.Pointer x31, Returns (CI.Primitive CI.Int)))),
  "gsl_spmatrix_minmax" ->
  (fun x26 x28 x30 ->
    owl_stub_40_gsl_spmatrix_minmax (CI.cptr x26) (CI.cptr x28) (CI.cptr x30))
| Function (CI.Pointer x33, Returns (CI.Pointer x34)), "gsl_spmatrix_compcol" ->
  (fun x32 ->
    CI.make_ptr x34 (owl_stub_39_gsl_spmatrix_compcol (CI.cptr x32)))
| Function
    (CI.Pointer x36,
     Function (CI.Pointer x38, Returns (CI.Primitive CI.Int))),
  "gsl_spmatrix_memcpy" ->
  (fun x35 x37 ->
    owl_stub_38_gsl_spmatrix_memcpy (CI.cptr x35) (CI.cptr x37))
| Function
    (CI.Pointer x40,
     Function (CI.Primitive CI.Double, Returns (CI.Primitive CI.Int))),
  "gsl_spmatrix_scale" ->
  (fun x39 x41 -> owl_stub_37_gsl_spmatrix_scale (CI.cptr x39) x41)
| Function
    (CI.Pointer x43,
     Function
       (CI.Pointer x45,
        Function (CI.Pointer x47, Returns (CI.Primitive CI.Int)))),
  "gsl_spmatrix_add" ->
  (fun x42 x44 x46 ->
    owl_stub_36_gsl_spmatrix_add (CI.cptr x42) (CI.cptr x44) (CI.cptr x46))
| Function
    (CI.Pointer x49,
     Function
       (CI.Primitive CI.Int,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "gsl_spmatrix_get" ->
  (fun x48 x50 x51 -> owl_stub_35_gsl_spmatrix_get (CI.cptr x48) x50 x51)
| Function
    (CI.Pointer x53,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function (CI.Primitive CI.Double, Returns (CI.Primitive CI.Int))))),
  "gsl_spmatrix_set" ->
  (fun x52 x54 x55 x56 ->
    owl_stub_34_gsl_spmatrix_set (CI.cptr x52) x54 x55 x56)
| Function
    (CI.Primitive CI.Int,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function (CI.Primitive CI.Int, Returns (CI.Pointer x61))))),
  "gsl_spmatrix_alloc_nzmax" ->
  (fun x57 x58 x59 x60 ->
    CI.make_ptr x61 (owl_stub_33_gsl_spmatrix_alloc_nzmax x57 x58 x59 x60))
| Function
    (CI.Primitive CI.Int,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x64))),
  "gsl_spmatrix_alloc" ->
  (fun x62 x63 -> CI.make_ptr x64 (owl_stub_32_gsl_spmatrix_alloc x62 x63))
| Function (CI.Pointer x66, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_complex_float_isnonneg" ->
  (fun x65 -> owl_stub_31_gsl_matrix_complex_float_isnonneg (CI.cptr x65))
| Function (CI.Pointer x68, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_complex_float_isneg" ->
  (fun x67 -> owl_stub_30_gsl_matrix_complex_float_isneg (CI.cptr x67))
| Function (CI.Pointer x70, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_complex_float_ispos" ->
  (fun x69 -> owl_stub_29_gsl_matrix_complex_float_ispos (CI.cptr x69))
| Function (CI.Pointer x72, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_complex_float_isnull" ->
  (fun x71 -> owl_stub_28_gsl_matrix_complex_float_isnull (CI.cptr x71))
| Function
    (CI.Pointer x74,
     Function (CI.Pointer x76, Returns (CI.Primitive CI.Int))),
  "gsl_matrix_complex_float_equal" ->
  (fun x73 x75 ->
    owl_stub_27_gsl_matrix_complex_float_equal (CI.cptr x73) (CI.cptr x75))
| Function (CI.Pointer x78, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_complex_isnonneg" ->
  (fun x77 -> owl_stub_26_gsl_matrix_complex_isnonneg (CI.cptr x77))
| Function (CI.Pointer x80, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_complex_isneg" ->
  (fun x79 -> owl_stub_25_gsl_matrix_complex_isneg (CI.cptr x79))
| Function (CI.Pointer x82, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_complex_ispos" ->
  (fun x81 -> owl_stub_24_gsl_matrix_complex_ispos (CI.cptr x81))
| Function (CI.Pointer x84, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_complex_isnull" ->
  (fun x83 -> owl_stub_23_gsl_matrix_complex_isnull (CI.cptr x83))
| Function
    (CI.Pointer x86,
     Function (CI.Pointer x88, Returns (CI.Primitive CI.Int))),
  "gsl_matrix_complex_equal" ->
  (fun x85 x87 ->
    owl_stub_22_gsl_matrix_complex_equal (CI.cptr x85) (CI.cptr x87))
| Function
    (CI.Pointer x90,
     Function (CI.Pointer x92, Function (CI.Pointer x94, Returns CI.Void))),
  "gsl_matrix_float_max_index" ->
  (fun x89 x91 x93 ->
    owl_stub_21_gsl_matrix_float_max_index (CI.cptr x89) (CI.cptr x91)
    (CI.cptr x93))
| Function
    (CI.Pointer x96,
     Function (CI.Pointer x98, Function (CI.Pointer x100, Returns CI.Void))),
  "gsl_matrix_float_min_index" ->
  (fun x95 x97 x99 ->
    owl_stub_20_gsl_matrix_float_min_index (CI.cptr x95) (CI.cptr x97)
    (CI.cptr x99))
| Function (CI.Pointer x102, Returns (CI.Primitive CI.Float)),
  "gsl_matrix_float_max" ->
  (fun x101 -> owl_stub_19_gsl_matrix_float_max (CI.cptr x101))
| Function (CI.Pointer x104, Returns (CI.Primitive CI.Float)),
  "gsl_matrix_float_min" ->
  (fun x103 -> owl_stub_18_gsl_matrix_float_min (CI.cptr x103))
| Function (CI.Pointer x106, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_float_isnonneg" ->
  (fun x105 -> owl_stub_17_gsl_matrix_float_isnonneg (CI.cptr x105))
| Function (CI.Pointer x108, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_float_isneg" ->
  (fun x107 -> owl_stub_16_gsl_matrix_float_isneg (CI.cptr x107))
| Function (CI.Pointer x110, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_float_ispos" ->
  (fun x109 -> owl_stub_15_gsl_matrix_float_ispos (CI.cptr x109))
| Function (CI.Pointer x112, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_float_isnull" ->
  (fun x111 -> owl_stub_14_gsl_matrix_float_isnull (CI.cptr x111))
| Function
    (CI.Pointer x114,
     Function (CI.Pointer x116, Returns (CI.Primitive CI.Int))),
  "gsl_matrix_float_equal" ->
  (fun x113 x115 ->
    owl_stub_13_gsl_matrix_float_equal (CI.cptr x113) (CI.cptr x115))
| Function
    (CI.Pointer x118,
     Function
       (CI.Pointer x120,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Int)))),
  "gsl_matrix_get_col" ->
  (fun x117 x119 x121 ->
    owl_stub_12_gsl_matrix_get_col (CI.cptr x117) (CI.cptr x119) x121)
| Function
    (CI.Primitive CI.Size_t,
     Function (CI.Primitive CI.Size_t, Returns (CI.Pointer x124))),
  "gsl_matrix_alloc" ->
  (fun x122 x123 ->
    CI.make_ptr x124 (owl_stub_11_gsl_matrix_alloc x122 x123))
| Function (CI.Primitive CI.Size_t, Returns (CI.Pointer x126)),
  "gsl_vector_alloc" ->
  (fun x125 -> CI.make_ptr x126 (owl_stub_10_gsl_vector_alloc x125))
| Function
    (CI.Pointer x128,
     Function (CI.Pointer x130, Function (CI.Pointer x132, Returns CI.Void))),
  "gsl_matrix_max_index" ->
  (fun x127 x129 x131 ->
    owl_stub_9_gsl_matrix_max_index (CI.cptr x127) (CI.cptr x129)
    (CI.cptr x131))
| Function
    (CI.Pointer x134,
     Function (CI.Pointer x136, Function (CI.Pointer x138, Returns CI.Void))),
  "gsl_matrix_min_index" ->
  (fun x133 x135 x137 ->
    owl_stub_8_gsl_matrix_min_index (CI.cptr x133) (CI.cptr x135)
    (CI.cptr x137))
| Function (CI.Pointer x140, Returns (CI.Primitive CI.Double)),
  "gsl_matrix_max" -> (fun x139 -> owl_stub_7_gsl_matrix_max (CI.cptr x139))
| Function (CI.Pointer x142, Returns (CI.Primitive CI.Double)),
  "gsl_matrix_min" -> (fun x141 -> owl_stub_6_gsl_matrix_min (CI.cptr x141))
| Function (CI.Pointer x144, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_isnonneg" ->
  (fun x143 -> owl_stub_5_gsl_matrix_isnonneg (CI.cptr x143))
| Function (CI.Pointer x146, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_isneg" ->
  (fun x145 -> owl_stub_4_gsl_matrix_isneg (CI.cptr x145))
| Function (CI.Pointer x148, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_ispos" ->
  (fun x147 -> owl_stub_3_gsl_matrix_ispos (CI.cptr x147))
| Function (CI.Pointer x150, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_isnull" ->
  (fun x149 -> owl_stub_2_gsl_matrix_isnull (CI.cptr x149))
| Function
    (CI.Pointer x152,
     Function (CI.Pointer x154, Returns (CI.Primitive CI.Int))),
  "gsl_matrix_equal" ->
  (fun x151 x153 ->
    owl_stub_1_gsl_matrix_equal (CI.cptr x151) (CI.cptr x153))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

