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

external owl_stub_22_c_eigen_spmat_d_print : _ CI.fatptr -> unit
  = "owl_stub_22_c_eigen_spmat_d_print" 

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
  (fun x1 -> owl_stub_22_c_eigen_spmat_d_print (CI.cptr x1))
| Function (CI.Pointer x4, Function (CI.Pointer x6, Returns (CI.Pointer x7))),
  "c_eigen_spmat_d_div" ->
  (fun x3 x5 ->
    CI.make_ptr x7
      (owl_stub_21_c_eigen_spmat_d_div (CI.cptr x3) (CI.cptr x5)))
| Function
    (CI.Pointer x9, Function (CI.Pointer x11, Returns (CI.Pointer x12))),
  "c_eigen_spmat_d_mul" ->
  (fun x8 x10 ->
    CI.make_ptr x12
      (owl_stub_20_c_eigen_spmat_d_mul (CI.cptr x8) (CI.cptr x10)))
| Function
    (CI.Pointer x14, Function (CI.Pointer x16, Returns (CI.Pointer x17))),
  "c_eigen_spmat_d_sub" ->
  (fun x13 x15 ->
    CI.make_ptr x17
      (owl_stub_19_c_eigen_spmat_d_sub (CI.cptr x13) (CI.cptr x15)))
| Function
    (CI.Pointer x19, Function (CI.Pointer x21, Returns (CI.Pointer x22))),
  "c_eigen_spmat_d_add" ->
  (fun x18 x20 ->
    CI.make_ptr x22
      (owl_stub_18_c_eigen_spmat_d_add (CI.cptr x18) (CI.cptr x20)))
| Function (CI.Pointer x24, Returns (CI.Pointer x25)),
  "c_eigen_spmat_d_transpose" ->
  (fun x23 ->
    CI.make_ptr x25 (owl_stub_17_c_eigen_spmat_d_transpose (CI.cptr x23)))
| Function
    (CI.Pointer x27,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x29))),
  "c_eigen_spmat_d_col" ->
  (fun x26 x28 ->
    CI.make_ptr x29 (owl_stub_16_c_eigen_spmat_d_col (CI.cptr x26) x28))
| Function
    (CI.Pointer x31,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x33))),
  "c_eigen_spmat_d_row" ->
  (fun x30 x32 ->
    CI.make_ptr x33 (owl_stub_15_c_eigen_spmat_d_row (CI.cptr x30) x32))
| Function (CI.Pointer x35, Returns (CI.Pointer x36)),
  "c_eigen_spmat_d_clone" ->
  (fun x34 ->
    CI.make_ptr x36 (owl_stub_14_c_eigen_spmat_d_clone (CI.cptr x34)))
| Function
    (CI.Pointer x38,
     Function
       (CI.Primitive CI.Int, Function (CI.Primitive CI.Int, Returns CI.Void))),
  "c_eigen_spmat_d_reshape" ->
  (fun x37 x39 x40 ->
    owl_stub_13_c_eigen_spmat_d_reshape (CI.cptr x37) x39 x40)
| Function (CI.Pointer x42, Returns CI.Void), "c_eigen_spmat_d_uncompress" ->
  (fun x41 -> owl_stub_12_c_eigen_spmat_d_uncompress (CI.cptr x41))
| Function (CI.Pointer x44, Returns CI.Void), "c_eigen_spmat_d_compress" ->
  (fun x43 -> owl_stub_11_c_eigen_spmat_d_compress (CI.cptr x43))
| Function (CI.Pointer x46, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_compressed" ->
  (fun x45 -> owl_stub_10_c_eigen_spmat_d_is_compressed (CI.cptr x45))
| Function (CI.Pointer x48, Returns CI.Void), "c_eigen_spmat_d_reset" ->
  (fun x47 -> owl_stub_9_c_eigen_spmat_d_reset (CI.cptr x47))
| Function
    (CI.Pointer x50,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function (CI.Primitive CI.Double, Returns CI.Void)))),
  "c_eigen_spmat_d_set" ->
  (fun x49 x51 x52 x53 ->
    owl_stub_8_c_eigen_spmat_d_set (CI.cptr x49) x51 x52 x53)
| Function
    (CI.Pointer x55,
     Function
       (CI.Primitive CI.Int,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "c_eigen_spmat_d_get" ->
  (fun x54 x56 x57 -> owl_stub_7_c_eigen_spmat_d_get (CI.cptr x54) x56 x57)
| Function (CI.Pointer x59, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_nnz" ->
  (fun x58 -> owl_stub_6_c_eigen_spmat_d_nnz (CI.cptr x58))
| Function (CI.Pointer x61, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_cols" ->
  (fun x60 -> owl_stub_5_c_eigen_spmat_d_cols (CI.cptr x60))
| Function (CI.Pointer x63, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_rows" ->
  (fun x62 -> owl_stub_4_c_eigen_spmat_d_rows (CI.cptr x62))
| Function (CI.Primitive CI.Int, Returns (CI.Pointer x65)),
  "c_eigen_spmat_d_eye" ->
  (fun x64 -> CI.make_ptr x65 (owl_stub_3_c_eigen_spmat_d_eye x64))
| Function (CI.Pointer x67, Returns CI.Void), "c_eigen_spmat_d_delete" ->
  (fun x66 -> owl_stub_2_c_eigen_spmat_d_delete (CI.cptr x66))
| Function
    (CI.Primitive CI.Int,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x70))),
  "c_eigen_spmat_d_new" ->
  (fun x68 x69 -> CI.make_ptr x70 (owl_stub_1_c_eigen_spmat_d_new x68 x69))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

