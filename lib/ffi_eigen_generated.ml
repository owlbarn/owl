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

external owl_stub_14_c_eigen_spmat_d_clone : _ CI.fatptr -> CI.voidp
  = "owl_stub_14_c_eigen_spmat_d_clone" 

external owl_stub_15_c_eigen_spmat_d_row : _ CI.fatptr -> int -> CI.voidp
  = "owl_stub_15_c_eigen_spmat_d_row" 

external owl_stub_16_c_eigen_spmat_d_col : _ CI.fatptr -> int -> CI.voidp
  = "owl_stub_16_c_eigen_spmat_d_col" 

external owl_stub_17_c_eigen_spmat_d_transpose : _ CI.fatptr -> CI.voidp
  = "owl_stub_17_c_eigen_spmat_d_transpose" 

external owl_stub_18_c_eigen_spmat_d_add
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_18_c_eigen_spmat_d_add" 

external owl_stub_19_c_eigen_spmat_d_sub
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_19_c_eigen_spmat_d_sub" 

external owl_stub_20_c_eigen_spmat_d_mul
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_20_c_eigen_spmat_d_mul" 

external owl_stub_21_c_eigen_spmat_d_div
  : _ CI.fatptr -> _ CI.fatptr -> CI.voidp
  = "owl_stub_21_c_eigen_spmat_d_div" 

external owl_stub_22_c_eigen_spmat_d_mul_scalar
  : _ CI.fatptr -> float -> CI.voidp
  = "owl_stub_22_c_eigen_spmat_d_mul_scalar" 

external owl_stub_23_c_eigen_spmat_d_div_scalar
  : _ CI.fatptr -> float -> CI.voidp
  = "owl_stub_23_c_eigen_spmat_d_div_scalar" 

external owl_stub_24_c_eigen_spmat_d_print : _ CI.fatptr -> unit
  = "owl_stub_24_c_eigen_spmat_d_print" 

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
  (fun x1 -> owl_stub_24_c_eigen_spmat_d_print (CI.cptr x1))
| Function
    (CI.Pointer x4,
     Function (CI.Primitive CI.Double, Returns (CI.Pointer x6))),
  "c_eigen_spmat_d_div_scalar" ->
  (fun x3 x5 ->
    CI.make_ptr x6 (owl_stub_23_c_eigen_spmat_d_div_scalar (CI.cptr x3) x5))
| Function
    (CI.Pointer x8,
     Function (CI.Primitive CI.Double, Returns (CI.Pointer x10))),
  "c_eigen_spmat_d_mul_scalar" ->
  (fun x7 x9 ->
    CI.make_ptr x10 (owl_stub_22_c_eigen_spmat_d_mul_scalar (CI.cptr x7) x9))
| Function
    (CI.Pointer x12, Function (CI.Pointer x14, Returns (CI.Pointer x15))),
  "c_eigen_spmat_d_div" ->
  (fun x11 x13 ->
    CI.make_ptr x15
      (owl_stub_21_c_eigen_spmat_d_div (CI.cptr x11) (CI.cptr x13)))
| Function
    (CI.Pointer x17, Function (CI.Pointer x19, Returns (CI.Pointer x20))),
  "c_eigen_spmat_d_mul" ->
  (fun x16 x18 ->
    CI.make_ptr x20
      (owl_stub_20_c_eigen_spmat_d_mul (CI.cptr x16) (CI.cptr x18)))
| Function
    (CI.Pointer x22, Function (CI.Pointer x24, Returns (CI.Pointer x25))),
  "c_eigen_spmat_d_sub" ->
  (fun x21 x23 ->
    CI.make_ptr x25
      (owl_stub_19_c_eigen_spmat_d_sub (CI.cptr x21) (CI.cptr x23)))
| Function
    (CI.Pointer x27, Function (CI.Pointer x29, Returns (CI.Pointer x30))),
  "c_eigen_spmat_d_add" ->
  (fun x26 x28 ->
    CI.make_ptr x30
      (owl_stub_18_c_eigen_spmat_d_add (CI.cptr x26) (CI.cptr x28)))
| Function (CI.Pointer x32, Returns (CI.Pointer x33)),
  "c_eigen_spmat_d_transpose" ->
  (fun x31 ->
    CI.make_ptr x33 (owl_stub_17_c_eigen_spmat_d_transpose (CI.cptr x31)))
| Function
    (CI.Pointer x35,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x37))),
  "c_eigen_spmat_d_col" ->
  (fun x34 x36 ->
    CI.make_ptr x37 (owl_stub_16_c_eigen_spmat_d_col (CI.cptr x34) x36))
| Function
    (CI.Pointer x39,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x41))),
  "c_eigen_spmat_d_row" ->
  (fun x38 x40 ->
    CI.make_ptr x41 (owl_stub_15_c_eigen_spmat_d_row (CI.cptr x38) x40))
| Function (CI.Pointer x43, Returns (CI.Pointer x44)),
  "c_eigen_spmat_d_clone" ->
  (fun x42 ->
    CI.make_ptr x44 (owl_stub_14_c_eigen_spmat_d_clone (CI.cptr x42)))
| Function
    (CI.Pointer x46,
     Function
       (CI.Primitive CI.Int, Function (CI.Primitive CI.Int, Returns CI.Void))),
  "c_eigen_spmat_d_reshape" ->
  (fun x45 x47 x48 ->
    owl_stub_13_c_eigen_spmat_d_reshape (CI.cptr x45) x47 x48)
| Function (CI.Pointer x50, Returns CI.Void), "c_eigen_spmat_d_uncompress" ->
  (fun x49 -> owl_stub_12_c_eigen_spmat_d_uncompress (CI.cptr x49))
| Function (CI.Pointer x52, Returns CI.Void), "c_eigen_spmat_d_compress" ->
  (fun x51 -> owl_stub_11_c_eigen_spmat_d_compress (CI.cptr x51))
| Function (CI.Pointer x54, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_compressed" ->
  (fun x53 -> owl_stub_10_c_eigen_spmat_d_is_compressed (CI.cptr x53))
| Function (CI.Pointer x56, Returns CI.Void), "c_eigen_spmat_d_reset" ->
  (fun x55 -> owl_stub_9_c_eigen_spmat_d_reset (CI.cptr x55))
| Function
    (CI.Pointer x58,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function (CI.Primitive CI.Double, Returns CI.Void)))),
  "c_eigen_spmat_d_set" ->
  (fun x57 x59 x60 x61 ->
    owl_stub_8_c_eigen_spmat_d_set (CI.cptr x57) x59 x60 x61)
| Function
    (CI.Pointer x63,
     Function
       (CI.Primitive CI.Int,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "c_eigen_spmat_d_get" ->
  (fun x62 x64 x65 -> owl_stub_7_c_eigen_spmat_d_get (CI.cptr x62) x64 x65)
| Function (CI.Pointer x67, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_nnz" ->
  (fun x66 -> owl_stub_6_c_eigen_spmat_d_nnz (CI.cptr x66))
| Function (CI.Pointer x69, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_cols" ->
  (fun x68 -> owl_stub_5_c_eigen_spmat_d_cols (CI.cptr x68))
| Function (CI.Pointer x71, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_rows" ->
  (fun x70 -> owl_stub_4_c_eigen_spmat_d_rows (CI.cptr x70))
| Function (CI.Primitive CI.Int, Returns (CI.Pointer x73)),
  "c_eigen_spmat_d_eye" ->
  (fun x72 -> CI.make_ptr x73 (owl_stub_3_c_eigen_spmat_d_eye x72))
| Function (CI.Pointer x75, Returns CI.Void), "c_eigen_spmat_d_delete" ->
  (fun x74 -> owl_stub_2_c_eigen_spmat_d_delete (CI.cptr x74))
| Function
    (CI.Primitive CI.Int,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x78))),
  "c_eigen_spmat_d_new" ->
  (fun x76 x77 -> CI.make_ptr x78 (owl_stub_1_c_eigen_spmat_d_new x76 x77))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

