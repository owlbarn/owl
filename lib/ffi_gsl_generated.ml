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

external owl_stub_8_gsl_matrix_minmax
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> unit
  = "owl_stub_8_gsl_matrix_minmax" 

external owl_stub_9_gsl_matrix_min_index
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> unit
  = "owl_stub_9_gsl_matrix_min_index" 

external owl_stub_10_gsl_matrix_max_index
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> unit
  = "owl_stub_10_gsl_matrix_max_index" 

external owl_stub_11_gsl_matrix_minmax_index
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr ->
    _ CI.fatptr -> unit = "owl_stub_11_gsl_matrix_minmax_index" 

external owl_stub_12_gsl_vector_alloc : Unsigned.size_t -> CI.voidp
  = "owl_stub_12_gsl_vector_alloc" 

external owl_stub_13_gsl_matrix_alloc
  : Unsigned.size_t -> Unsigned.size_t -> CI.voidp
  = "owl_stub_13_gsl_matrix_alloc" 

external owl_stub_14_gsl_matrix_get_col
  : _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_14_gsl_matrix_get_col" 

external owl_stub_15_gsl_matrix_float_equal
  : _ CI.fatptr -> _ CI.fatptr -> int = "owl_stub_15_gsl_matrix_float_equal" 

external owl_stub_16_gsl_matrix_float_isnull : _ CI.fatptr -> int
  = "owl_stub_16_gsl_matrix_float_isnull" 

external owl_stub_17_gsl_matrix_float_ispos : _ CI.fatptr -> int
  = "owl_stub_17_gsl_matrix_float_ispos" 

external owl_stub_18_gsl_matrix_float_isneg : _ CI.fatptr -> int
  = "owl_stub_18_gsl_matrix_float_isneg" 

external owl_stub_19_gsl_matrix_float_isnonneg : _ CI.fatptr -> int
  = "owl_stub_19_gsl_matrix_float_isnonneg" 

external owl_stub_20_gsl_matrix_float_min : _ CI.fatptr -> float
  = "owl_stub_20_gsl_matrix_float_min" 

external owl_stub_21_gsl_matrix_float_max : _ CI.fatptr -> float
  = "owl_stub_21_gsl_matrix_float_max" 

external owl_stub_22_gsl_matrix_float_minmax
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> unit
  = "owl_stub_22_gsl_matrix_float_minmax" 

external owl_stub_23_gsl_matrix_float_min_index
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> unit
  = "owl_stub_23_gsl_matrix_float_min_index" 

external owl_stub_24_gsl_matrix_float_max_index
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> unit
  = "owl_stub_24_gsl_matrix_float_max_index" 

external owl_stub_25_gsl_matrix_float_minmax_index
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr ->
    _ CI.fatptr -> unit = "owl_stub_25_gsl_matrix_float_minmax_index" 

external owl_stub_26_gsl_matrix_complex_equal
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_26_gsl_matrix_complex_equal" 

external owl_stub_27_gsl_matrix_complex_isnull : _ CI.fatptr -> int
  = "owl_stub_27_gsl_matrix_complex_isnull" 

external owl_stub_28_gsl_matrix_complex_ispos : _ CI.fatptr -> int
  = "owl_stub_28_gsl_matrix_complex_ispos" 

external owl_stub_29_gsl_matrix_complex_isneg : _ CI.fatptr -> int
  = "owl_stub_29_gsl_matrix_complex_isneg" 

external owl_stub_30_gsl_matrix_complex_isnonneg : _ CI.fatptr -> int
  = "owl_stub_30_gsl_matrix_complex_isnonneg" 

external owl_stub_31_gsl_matrix_complex_float_equal
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_31_gsl_matrix_complex_float_equal" 

external owl_stub_32_gsl_matrix_complex_float_isnull : _ CI.fatptr -> int
  = "owl_stub_32_gsl_matrix_complex_float_isnull" 

external owl_stub_33_gsl_matrix_complex_float_ispos : _ CI.fatptr -> int
  = "owl_stub_33_gsl_matrix_complex_float_ispos" 

external owl_stub_34_gsl_matrix_complex_float_isneg : _ CI.fatptr -> int
  = "owl_stub_34_gsl_matrix_complex_float_isneg" 

external owl_stub_35_gsl_matrix_complex_float_isnonneg : _ CI.fatptr -> int
  = "owl_stub_35_gsl_matrix_complex_float_isnonneg" 

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
| Function (CI.Pointer x2, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_complex_float_isnonneg" ->
  (fun x1 -> owl_stub_35_gsl_matrix_complex_float_isnonneg (CI.cptr x1))
| Function (CI.Pointer x4, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_complex_float_isneg" ->
  (fun x3 -> owl_stub_34_gsl_matrix_complex_float_isneg (CI.cptr x3))
| Function (CI.Pointer x6, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_complex_float_ispos" ->
  (fun x5 -> owl_stub_33_gsl_matrix_complex_float_ispos (CI.cptr x5))
| Function (CI.Pointer x8, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_complex_float_isnull" ->
  (fun x7 -> owl_stub_32_gsl_matrix_complex_float_isnull (CI.cptr x7))
| Function
    (CI.Pointer x10,
     Function (CI.Pointer x12, Returns (CI.Primitive CI.Int))),
  "gsl_matrix_complex_float_equal" ->
  (fun x9 x11 ->
    owl_stub_31_gsl_matrix_complex_float_equal (CI.cptr x9) (CI.cptr x11))
| Function (CI.Pointer x14, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_complex_isnonneg" ->
  (fun x13 -> owl_stub_30_gsl_matrix_complex_isnonneg (CI.cptr x13))
| Function (CI.Pointer x16, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_complex_isneg" ->
  (fun x15 -> owl_stub_29_gsl_matrix_complex_isneg (CI.cptr x15))
| Function (CI.Pointer x18, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_complex_ispos" ->
  (fun x17 -> owl_stub_28_gsl_matrix_complex_ispos (CI.cptr x17))
| Function (CI.Pointer x20, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_complex_isnull" ->
  (fun x19 -> owl_stub_27_gsl_matrix_complex_isnull (CI.cptr x19))
| Function
    (CI.Pointer x22,
     Function (CI.Pointer x24, Returns (CI.Primitive CI.Int))),
  "gsl_matrix_complex_equal" ->
  (fun x21 x23 ->
    owl_stub_26_gsl_matrix_complex_equal (CI.cptr x21) (CI.cptr x23))
| Function
    (CI.Pointer x26,
     Function
       (CI.Pointer x28,
        Function
          (CI.Pointer x30,
           Function
             (CI.Pointer x32, Function (CI.Pointer x34, Returns CI.Void))))),
  "gsl_matrix_float_minmax_index" ->
  (fun x25 x27 x29 x31 x33 ->
    owl_stub_25_gsl_matrix_float_minmax_index (CI.cptr x25) (CI.cptr x27)
    (CI.cptr x29) (CI.cptr x31) (CI.cptr x33))
| Function
    (CI.Pointer x36,
     Function (CI.Pointer x38, Function (CI.Pointer x40, Returns CI.Void))),
  "gsl_matrix_float_max_index" ->
  (fun x35 x37 x39 ->
    owl_stub_24_gsl_matrix_float_max_index (CI.cptr x35) (CI.cptr x37)
    (CI.cptr x39))
| Function
    (CI.Pointer x42,
     Function (CI.Pointer x44, Function (CI.Pointer x46, Returns CI.Void))),
  "gsl_matrix_float_min_index" ->
  (fun x41 x43 x45 ->
    owl_stub_23_gsl_matrix_float_min_index (CI.cptr x41) (CI.cptr x43)
    (CI.cptr x45))
| Function
    (CI.Pointer x48,
     Function (CI.Pointer x50, Function (CI.Pointer x52, Returns CI.Void))),
  "gsl_matrix_float_minmax" ->
  (fun x47 x49 x51 ->
    owl_stub_22_gsl_matrix_float_minmax (CI.cptr x47) (CI.cptr x49)
    (CI.cptr x51))
| Function (CI.Pointer x54, Returns (CI.Primitive CI.Float)),
  "gsl_matrix_float_max" ->
  (fun x53 -> owl_stub_21_gsl_matrix_float_max (CI.cptr x53))
| Function (CI.Pointer x56, Returns (CI.Primitive CI.Float)),
  "gsl_matrix_float_min" ->
  (fun x55 -> owl_stub_20_gsl_matrix_float_min (CI.cptr x55))
| Function (CI.Pointer x58, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_float_isnonneg" ->
  (fun x57 -> owl_stub_19_gsl_matrix_float_isnonneg (CI.cptr x57))
| Function (CI.Pointer x60, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_float_isneg" ->
  (fun x59 -> owl_stub_18_gsl_matrix_float_isneg (CI.cptr x59))
| Function (CI.Pointer x62, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_float_ispos" ->
  (fun x61 -> owl_stub_17_gsl_matrix_float_ispos (CI.cptr x61))
| Function (CI.Pointer x64, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_float_isnull" ->
  (fun x63 -> owl_stub_16_gsl_matrix_float_isnull (CI.cptr x63))
| Function
    (CI.Pointer x66,
     Function (CI.Pointer x68, Returns (CI.Primitive CI.Int))),
  "gsl_matrix_float_equal" ->
  (fun x65 x67 ->
    owl_stub_15_gsl_matrix_float_equal (CI.cptr x65) (CI.cptr x67))
| Function
    (CI.Pointer x70,
     Function
       (CI.Pointer x72,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Int)))),
  "gsl_matrix_get_col" ->
  (fun x69 x71 x73 ->
    owl_stub_14_gsl_matrix_get_col (CI.cptr x69) (CI.cptr x71) x73)
| Function
    (CI.Primitive CI.Size_t,
     Function (CI.Primitive CI.Size_t, Returns (CI.Pointer x76))),
  "gsl_matrix_alloc" ->
  (fun x74 x75 -> CI.make_ptr x76 (owl_stub_13_gsl_matrix_alloc x74 x75))
| Function (CI.Primitive CI.Size_t, Returns (CI.Pointer x78)),
  "gsl_vector_alloc" ->
  (fun x77 -> CI.make_ptr x78 (owl_stub_12_gsl_vector_alloc x77))
| Function
    (CI.Pointer x80,
     Function
       (CI.Pointer x82,
        Function
          (CI.Pointer x84,
           Function
             (CI.Pointer x86, Function (CI.Pointer x88, Returns CI.Void))))),
  "gsl_matrix_minmax_index" ->
  (fun x79 x81 x83 x85 x87 ->
    owl_stub_11_gsl_matrix_minmax_index (CI.cptr x79) (CI.cptr x81)
    (CI.cptr x83) (CI.cptr x85) (CI.cptr x87))
| Function
    (CI.Pointer x90,
     Function (CI.Pointer x92, Function (CI.Pointer x94, Returns CI.Void))),
  "gsl_matrix_max_index" ->
  (fun x89 x91 x93 ->
    owl_stub_10_gsl_matrix_max_index (CI.cptr x89) (CI.cptr x91)
    (CI.cptr x93))
| Function
    (CI.Pointer x96,
     Function (CI.Pointer x98, Function (CI.Pointer x100, Returns CI.Void))),
  "gsl_matrix_min_index" ->
  (fun x95 x97 x99 ->
    owl_stub_9_gsl_matrix_min_index (CI.cptr x95) (CI.cptr x97) (CI.cptr x99))
| Function
    (CI.Pointer x102,
     Function (CI.Pointer x104, Function (CI.Pointer x106, Returns CI.Void))),
  "gsl_matrix_minmax" ->
  (fun x101 x103 x105 ->
    owl_stub_8_gsl_matrix_minmax (CI.cptr x101) (CI.cptr x103) (CI.cptr x105))
| Function (CI.Pointer x108, Returns (CI.Primitive CI.Double)),
  "gsl_matrix_max" -> (fun x107 -> owl_stub_7_gsl_matrix_max (CI.cptr x107))
| Function (CI.Pointer x110, Returns (CI.Primitive CI.Double)),
  "gsl_matrix_min" -> (fun x109 -> owl_stub_6_gsl_matrix_min (CI.cptr x109))
| Function (CI.Pointer x112, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_isnonneg" ->
  (fun x111 -> owl_stub_5_gsl_matrix_isnonneg (CI.cptr x111))
| Function (CI.Pointer x114, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_isneg" ->
  (fun x113 -> owl_stub_4_gsl_matrix_isneg (CI.cptr x113))
| Function (CI.Pointer x116, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_ispos" ->
  (fun x115 -> owl_stub_3_gsl_matrix_ispos (CI.cptr x115))
| Function (CI.Pointer x118, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_isnull" ->
  (fun x117 -> owl_stub_2_gsl_matrix_isnull (CI.cptr x117))
| Function
    (CI.Pointer x120,
     Function (CI.Pointer x122, Returns (CI.Primitive CI.Int))),
  "gsl_matrix_equal" ->
  (fun x119 x121 ->
    owl_stub_1_gsl_matrix_equal (CI.cptr x119) (CI.cptr x121))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

