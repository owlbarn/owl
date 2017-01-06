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

external owl_stub_25_c_eigen_spmat_d_mul_scalar
  : _ CI.fatptr -> float -> CI.voidp
  = "owl_stub_25_c_eigen_spmat_d_mul_scalar" 

external owl_stub_26_c_eigen_spmat_d_div_scalar
  : _ CI.fatptr -> float -> CI.voidp
  = "owl_stub_26_c_eigen_spmat_d_div_scalar" 

external owl_stub_27_c_eigen_spmat_d_min2
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_27_c_eigen_spmat_d_min2" 

external owl_stub_28_c_eigen_spmat_d_max2
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_28_c_eigen_spmat_d_max2" 

external owl_stub_29_c_eigen_spmat_d_sum : _ CI.fatptr -> float
  = "owl_stub_29_c_eigen_spmat_d_sum" 

external owl_stub_30_c_eigen_spmat_d_abs : _ CI.fatptr -> CI.voidp
  = "owl_stub_30_c_eigen_spmat_d_abs" 

external owl_stub_31_c_eigen_spmat_d_sqrt : _ CI.fatptr -> CI.voidp
  = "owl_stub_31_c_eigen_spmat_d_sqrt" 

external owl_stub_32_c_eigen_spmat_d_print : _ CI.fatptr -> unit
  = "owl_stub_32_c_eigen_spmat_d_print" 

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
  (fun x1 -> owl_stub_32_c_eigen_spmat_d_print (CI.cptr x1))
| Function (CI.Pointer x4, Returns (CI.Pointer x5)), "c_eigen_spmat_d_sqrt" ->
  (fun x3 -> CI.make_ptr x5 (owl_stub_31_c_eigen_spmat_d_sqrt (CI.cptr x3)))
| Function (CI.Pointer x7, Returns (CI.Pointer x8)), "c_eigen_spmat_d_abs" ->
  (fun x6 -> CI.make_ptr x8 (owl_stub_30_c_eigen_spmat_d_abs (CI.cptr x6)))
| Function (CI.Pointer x10, Returns (CI.Primitive CI.Double)),
  "c_eigen_spmat_d_sum" ->
  (fun x9 -> owl_stub_29_c_eigen_spmat_d_sum (CI.cptr x9))
| Function
    (CI.Pointer x12, Function (CI.Pointer x14, Returns (CI.Pointer x15))),
  "c_eigen_spmat_d_max2" ->
  (fun x11 x13 ->
    CI.make_ptr x15
      (owl_stub_28_c_eigen_spmat_d_max2 (CI.cptr x11) (CI.cptr x13)))
| Function
    (CI.Pointer x17, Function (CI.Pointer x19, Returns (CI.Pointer x20))),
  "c_eigen_spmat_d_min2" ->
  (fun x16 x18 ->
    CI.make_ptr x20
      (owl_stub_27_c_eigen_spmat_d_min2 (CI.cptr x16) (CI.cptr x18)))
| Function
    (CI.Pointer x22,
     Function (CI.Primitive CI.Double, Returns (CI.Pointer x24))),
  "c_eigen_spmat_d_div_scalar" ->
  (fun x21 x23 ->
    CI.make_ptr x24
      (owl_stub_26_c_eigen_spmat_d_div_scalar (CI.cptr x21) x23))
| Function
    (CI.Pointer x26,
     Function (CI.Primitive CI.Double, Returns (CI.Pointer x28))),
  "c_eigen_spmat_d_mul_scalar" ->
  (fun x25 x27 ->
    CI.make_ptr x28
      (owl_stub_25_c_eigen_spmat_d_mul_scalar (CI.cptr x25) x27))
| Function
    (CI.Pointer x30, Function (CI.Pointer x32, Returns (CI.Pointer x33))),
  "c_eigen_spmat_d_dot" ->
  (fun x29 x31 ->
    CI.make_ptr x33
      (owl_stub_24_c_eigen_spmat_d_dot (CI.cptr x29) (CI.cptr x31)))
| Function
    (CI.Pointer x35, Function (CI.Pointer x37, Returns (CI.Pointer x38))),
  "c_eigen_spmat_d_div" ->
  (fun x34 x36 ->
    CI.make_ptr x38
      (owl_stub_23_c_eigen_spmat_d_div (CI.cptr x34) (CI.cptr x36)))
| Function
    (CI.Pointer x40, Function (CI.Pointer x42, Returns (CI.Pointer x43))),
  "c_eigen_spmat_d_mul" ->
  (fun x39 x41 ->
    CI.make_ptr x43
      (owl_stub_22_c_eigen_spmat_d_mul (CI.cptr x39) (CI.cptr x41)))
| Function
    (CI.Pointer x45, Function (CI.Pointer x47, Returns (CI.Pointer x48))),
  "c_eigen_spmat_d_sub" ->
  (fun x44 x46 ->
    CI.make_ptr x48
      (owl_stub_21_c_eigen_spmat_d_sub (CI.cptr x44) (CI.cptr x46)))
| Function
    (CI.Pointer x50, Function (CI.Pointer x52, Returns (CI.Pointer x53))),
  "c_eigen_spmat_d_add" ->
  (fun x49 x51 ->
    CI.make_ptr x53
      (owl_stub_20_c_eigen_spmat_d_add (CI.cptr x49) (CI.cptr x51)))
| Function (CI.Pointer x55, Returns (CI.Pointer x56)),
  "c_eigen_spmat_d_adjoint" ->
  (fun x54 ->
    CI.make_ptr x56 (owl_stub_19_c_eigen_spmat_d_adjoint (CI.cptr x54)))
| Function (CI.Pointer x58, Returns (CI.Pointer x59)),
  "c_eigen_spmat_d_transpose" ->
  (fun x57 ->
    CI.make_ptr x59 (owl_stub_18_c_eigen_spmat_d_transpose (CI.cptr x57)))
| Function
    (CI.Pointer x61,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x63))),
  "c_eigen_spmat_d_col" ->
  (fun x60 x62 ->
    CI.make_ptr x63 (owl_stub_17_c_eigen_spmat_d_col (CI.cptr x60) x62))
| Function
    (CI.Pointer x65,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x67))),
  "c_eigen_spmat_d_row" ->
  (fun x64 x66 ->
    CI.make_ptr x67 (owl_stub_16_c_eigen_spmat_d_row (CI.cptr x64) x66))
| Function (CI.Pointer x69, Returns (CI.Pointer x70)),
  "c_eigen_spmat_d_clone" ->
  (fun x68 ->
    CI.make_ptr x70 (owl_stub_15_c_eigen_spmat_d_clone (CI.cptr x68)))
| Function
    (CI.Pointer x72,
     Function
       (CI.Primitive CI.Double,
        Function (CI.Primitive CI.Double, Returns CI.Void))),
  "c_eigen_spmat_d_prune" ->
  (fun x71 x73 x74 ->
    owl_stub_14_c_eigen_spmat_d_prune (CI.cptr x71) x73 x74)
| Function
    (CI.Pointer x76,
     Function
       (CI.Primitive CI.Int, Function (CI.Primitive CI.Int, Returns CI.Void))),
  "c_eigen_spmat_d_reshape" ->
  (fun x75 x77 x78 ->
    owl_stub_13_c_eigen_spmat_d_reshape (CI.cptr x75) x77 x78)
| Function (CI.Pointer x80, Returns CI.Void), "c_eigen_spmat_d_uncompress" ->
  (fun x79 -> owl_stub_12_c_eigen_spmat_d_uncompress (CI.cptr x79))
| Function (CI.Pointer x82, Returns CI.Void), "c_eigen_spmat_d_compress" ->
  (fun x81 -> owl_stub_11_c_eigen_spmat_d_compress (CI.cptr x81))
| Function (CI.Pointer x84, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_compressed" ->
  (fun x83 -> owl_stub_10_c_eigen_spmat_d_is_compressed (CI.cptr x83))
| Function (CI.Pointer x86, Returns CI.Void), "c_eigen_spmat_d_reset" ->
  (fun x85 -> owl_stub_9_c_eigen_spmat_d_reset (CI.cptr x85))
| Function
    (CI.Pointer x88,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function (CI.Primitive CI.Double, Returns CI.Void)))),
  "c_eigen_spmat_d_set" ->
  (fun x87 x89 x90 x91 ->
    owl_stub_8_c_eigen_spmat_d_set (CI.cptr x87) x89 x90 x91)
| Function
    (CI.Pointer x93,
     Function
       (CI.Primitive CI.Int,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "c_eigen_spmat_d_get" ->
  (fun x92 x94 x95 -> owl_stub_7_c_eigen_spmat_d_get (CI.cptr x92) x94 x95)
| Function (CI.Pointer x97, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_nnz" ->
  (fun x96 -> owl_stub_6_c_eigen_spmat_d_nnz (CI.cptr x96))
| Function (CI.Pointer x99, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_cols" ->
  (fun x98 -> owl_stub_5_c_eigen_spmat_d_cols (CI.cptr x98))
| Function (CI.Pointer x101, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_rows" ->
  (fun x100 -> owl_stub_4_c_eigen_spmat_d_rows (CI.cptr x100))
| Function (CI.Primitive CI.Int, Returns (CI.Pointer x103)),
  "c_eigen_spmat_d_eye" ->
  (fun x102 -> CI.make_ptr x103 (owl_stub_3_c_eigen_spmat_d_eye x102))
| Function (CI.Pointer x105, Returns CI.Void), "c_eigen_spmat_d_delete" ->
  (fun x104 -> owl_stub_2_c_eigen_spmat_d_delete (CI.cptr x104))
| Function
    (CI.Primitive CI.Int,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x108))),
  "c_eigen_spmat_d_new" ->
  (fun x106 x107 ->
    CI.make_ptr x108 (owl_stub_1_c_eigen_spmat_d_new x106 x107))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

