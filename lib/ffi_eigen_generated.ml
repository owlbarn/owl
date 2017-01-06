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

external owl_stub_20_c_eigen_spmat_d_add
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_20_c_eigen_spmat_d_add" 

external owl_stub_21_c_eigen_spmat_d_sub
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_21_c_eigen_spmat_d_sub" 

external owl_stub_22_c_eigen_spmat_d_mul
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_22_c_eigen_spmat_d_mul" 

external owl_stub_23_c_eigen_spmat_d_div
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_23_c_eigen_spmat_d_div" 

external owl_stub_24_c_eigen_spmat_d_dot
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_24_c_eigen_spmat_d_dot" 

external owl_stub_25_c_eigen_spmat_d_add_scalar
  : _ CI.fatptr -> float -> CI.voidp
  = "owl_stub_25_c_eigen_spmat_d_add_scalar" 

external owl_stub_26_c_eigen_spmat_d_sub_scalar
  : _ CI.fatptr -> float -> CI.voidp
  = "owl_stub_26_c_eigen_spmat_d_sub_scalar" 

external owl_stub_27_c_eigen_spmat_d_mul_scalar
  : _ CI.fatptr -> float -> CI.voidp
  = "owl_stub_27_c_eigen_spmat_d_mul_scalar" 

external owl_stub_28_c_eigen_spmat_d_div_scalar
  : _ CI.fatptr -> float -> CI.voidp
  = "owl_stub_28_c_eigen_spmat_d_div_scalar" 

external owl_stub_29_c_eigen_spmat_d_min2
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_29_c_eigen_spmat_d_min2" 

external owl_stub_30_c_eigen_spmat_d_max2
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_30_c_eigen_spmat_d_max2" 

external owl_stub_31_c_eigen_spmat_d_sum : _ CI.fatptr -> float
  = "owl_stub_31_c_eigen_spmat_d_sum" 

external owl_stub_32_c_eigen_spmat_d_abs : _ CI.fatptr -> CI.voidp
  = "owl_stub_32_c_eigen_spmat_d_abs" 

external owl_stub_33_c_eigen_spmat_d_neg : _ CI.fatptr -> CI.voidp
  = "owl_stub_33_c_eigen_spmat_d_neg" 

external owl_stub_34_c_eigen_spmat_d_sqrt : _ CI.fatptr -> CI.voidp
  = "owl_stub_34_c_eigen_spmat_d_sqrt" 

external owl_stub_35_c_eigen_spmat_d_print : _ CI.fatptr -> unit
  = "owl_stub_35_c_eigen_spmat_d_print" 

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
  (fun x1 -> owl_stub_35_c_eigen_spmat_d_print (CI.cptr x1))
| Function (CI.Pointer x4, Returns (CI.Pointer x5)), "c_eigen_spmat_d_sqrt" ->
  (fun x3 -> CI.make_ptr x5 (owl_stub_34_c_eigen_spmat_d_sqrt (CI.cptr x3)))
| Function (CI.Pointer x7, Returns (CI.Pointer x8)), "c_eigen_spmat_d_neg" ->
  (fun x6 -> CI.make_ptr x8 (owl_stub_33_c_eigen_spmat_d_neg (CI.cptr x6)))
| Function (CI.Pointer x10, Returns (CI.Pointer x11)), "c_eigen_spmat_d_abs" ->
  (fun x9 -> CI.make_ptr x11 (owl_stub_32_c_eigen_spmat_d_abs (CI.cptr x9)))
| Function (CI.Pointer x13, Returns (CI.Primitive CI.Double)),
  "c_eigen_spmat_d_sum" ->
  (fun x12 -> owl_stub_31_c_eigen_spmat_d_sum (CI.cptr x12))
| Function
    (CI.Pointer x15, Function (CI.Pointer x17, Returns (CI.Pointer x18))),
  "c_eigen_spmat_d_max2" ->
  (fun x14 x16 ->
    CI.make_ptr x18
      (owl_stub_30_c_eigen_spmat_d_max2 (CI.cptr x14) (CI.cptr x16)))
| Function
    (CI.Pointer x20, Function (CI.Pointer x22, Returns (CI.Pointer x23))),
  "c_eigen_spmat_d_min2" ->
  (fun x19 x21 ->
    CI.make_ptr x23
      (owl_stub_29_c_eigen_spmat_d_min2 (CI.cptr x19) (CI.cptr x21)))
| Function
    (CI.Pointer x25,
     Function (CI.Primitive CI.Double, Returns (CI.Pointer x27))),
  "c_eigen_spmat_d_div_scalar" ->
  (fun x24 x26 ->
    CI.make_ptr x27
      (owl_stub_28_c_eigen_spmat_d_div_scalar (CI.cptr x24) x26))
| Function
    (CI.Pointer x29,
     Function (CI.Primitive CI.Double, Returns (CI.Pointer x31))),
  "c_eigen_spmat_d_mul_scalar" ->
  (fun x28 x30 ->
    CI.make_ptr x31
      (owl_stub_27_c_eigen_spmat_d_mul_scalar (CI.cptr x28) x30))
| Function
    (CI.Pointer x33,
     Function (CI.Primitive CI.Double, Returns (CI.Pointer x35))),
  "c_eigen_spmat_d_sub_scalar" ->
  (fun x32 x34 ->
    CI.make_ptr x35
      (owl_stub_26_c_eigen_spmat_d_sub_scalar (CI.cptr x32) x34))
| Function
    (CI.Pointer x37,
     Function (CI.Primitive CI.Double, Returns (CI.Pointer x39))),
  "c_eigen_spmat_d_add_scalar" ->
  (fun x36 x38 ->
    CI.make_ptr x39
      (owl_stub_25_c_eigen_spmat_d_add_scalar (CI.cptr x36) x38))
| Function
    (CI.Pointer x41, Function (CI.Pointer x43, Returns (CI.Pointer x44))),
  "c_eigen_spmat_d_dot" ->
  (fun x40 x42 ->
    CI.make_ptr x44
      (owl_stub_24_c_eigen_spmat_d_dot (CI.cptr x40) (CI.cptr x42)))
| Function
    (CI.Pointer x46, Function (CI.Pointer x48, Returns (CI.Pointer x49))),
  "c_eigen_spmat_d_div" ->
  (fun x45 x47 ->
    CI.make_ptr x49
      (owl_stub_23_c_eigen_spmat_d_div (CI.cptr x45) (CI.cptr x47)))
| Function
    (CI.Pointer x51, Function (CI.Pointer x53, Returns (CI.Pointer x54))),
  "c_eigen_spmat_d_mul" ->
  (fun x50 x52 ->
    CI.make_ptr x54
      (owl_stub_22_c_eigen_spmat_d_mul (CI.cptr x50) (CI.cptr x52)))
| Function
    (CI.Pointer x56, Function (CI.Pointer x58, Returns (CI.Pointer x59))),
  "c_eigen_spmat_d_sub" ->
  (fun x55 x57 ->
    CI.make_ptr x59
      (owl_stub_21_c_eigen_spmat_d_sub (CI.cptr x55) (CI.cptr x57)))
| Function
    (CI.Pointer x61, Function (CI.Pointer x63, Returns (CI.Pointer x64))),
  "c_eigen_spmat_d_add" ->
  (fun x60 x62 ->
    CI.make_ptr x64
      (owl_stub_20_c_eigen_spmat_d_add (CI.cptr x60) (CI.cptr x62)))
| Function (CI.Pointer x66, Returns (CI.Pointer x67)),
  "c_eigen_spmat_d_adjoint" ->
  (fun x65 ->
    CI.make_ptr x67 (owl_stub_19_c_eigen_spmat_d_adjoint (CI.cptr x65)))
| Function (CI.Pointer x69, Returns (CI.Pointer x70)),
  "c_eigen_spmat_d_transpose" ->
  (fun x68 ->
    CI.make_ptr x70 (owl_stub_18_c_eigen_spmat_d_transpose (CI.cptr x68)))
| Function
    (CI.Pointer x72,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x74))),
  "c_eigen_spmat_d_col" ->
  (fun x71 x73 ->
    CI.make_ptr x74 (owl_stub_17_c_eigen_spmat_d_col (CI.cptr x71) x73))
| Function
    (CI.Pointer x76,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x78))),
  "c_eigen_spmat_d_row" ->
  (fun x75 x77 ->
    CI.make_ptr x78 (owl_stub_16_c_eigen_spmat_d_row (CI.cptr x75) x77))
| Function (CI.Pointer x80, Returns (CI.Pointer x81)),
  "c_eigen_spmat_d_clone" ->
  (fun x79 ->
    CI.make_ptr x81 (owl_stub_15_c_eigen_spmat_d_clone (CI.cptr x79)))
| Function
    (CI.Pointer x83,
     Function
       (CI.Primitive CI.Double,
        Function (CI.Primitive CI.Double, Returns CI.Void))),
  "c_eigen_spmat_d_prune" ->
  (fun x82 x84 x85 ->
    owl_stub_14_c_eigen_spmat_d_prune (CI.cptr x82) x84 x85)
| Function
    (CI.Pointer x87,
     Function
       (CI.Primitive CI.Int, Function (CI.Primitive CI.Int, Returns CI.Void))),
  "c_eigen_spmat_d_reshape" ->
  (fun x86 x88 x89 ->
    owl_stub_13_c_eigen_spmat_d_reshape (CI.cptr x86) x88 x89)
| Function (CI.Pointer x91, Returns CI.Void), "c_eigen_spmat_d_uncompress" ->
  (fun x90 -> owl_stub_12_c_eigen_spmat_d_uncompress (CI.cptr x90))
| Function (CI.Pointer x93, Returns CI.Void), "c_eigen_spmat_d_compress" ->
  (fun x92 -> owl_stub_11_c_eigen_spmat_d_compress (CI.cptr x92))
| Function (CI.Pointer x95, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_compressed" ->
  (fun x94 -> owl_stub_10_c_eigen_spmat_d_is_compressed (CI.cptr x94))
| Function (CI.Pointer x97, Returns CI.Void), "c_eigen_spmat_d_reset" ->
  (fun x96 -> owl_stub_9_c_eigen_spmat_d_reset (CI.cptr x96))
| Function
    (CI.Pointer x99,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function (CI.Primitive CI.Double, Returns CI.Void)))),
  "c_eigen_spmat_d_set" ->
  (fun x98 x100 x101 x102 ->
    owl_stub_8_c_eigen_spmat_d_set (CI.cptr x98) x100 x101 x102)
| Function
    (CI.Pointer x104,
     Function
       (CI.Primitive CI.Int,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "c_eigen_spmat_d_get" ->
  (fun x103 x105 x106 ->
    owl_stub_7_c_eigen_spmat_d_get (CI.cptr x103) x105 x106)
| Function (CI.Pointer x108, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_nnz" ->
  (fun x107 -> owl_stub_6_c_eigen_spmat_d_nnz (CI.cptr x107))
| Function (CI.Pointer x110, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_cols" ->
  (fun x109 -> owl_stub_5_c_eigen_spmat_d_cols (CI.cptr x109))
| Function (CI.Pointer x112, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_rows" ->
  (fun x111 -> owl_stub_4_c_eigen_spmat_d_rows (CI.cptr x111))
| Function (CI.Primitive CI.Int, Returns (CI.Pointer x114)),
  "c_eigen_spmat_d_eye" ->
  (fun x113 -> CI.make_ptr x114 (owl_stub_3_c_eigen_spmat_d_eye x113))
| Function (CI.Pointer x116, Returns CI.Void), "c_eigen_spmat_d_delete" ->
  (fun x115 -> owl_stub_2_c_eigen_spmat_d_delete (CI.cptr x115))
| Function
    (CI.Primitive CI.Int,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x119))),
  "c_eigen_spmat_d_new" ->
  (fun x117 x118 ->
    CI.make_ptr x119 (owl_stub_1_c_eigen_spmat_d_new x117 x118))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

