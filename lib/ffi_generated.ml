module CI = Cstubs_internals

external owl_stub_1_gsl_vector_alloc : Unsigned.size_t -> CI.voidp
  = "owl_stub_1_gsl_vector_alloc" 

external owl_stub_2_gsl_matrix_alloc
  : Unsigned.size_t -> Unsigned.size_t -> CI.voidp
  = "owl_stub_2_gsl_matrix_alloc" 

external owl_stub_3_gsl_matrix_get_col
  : _ CI.fatptr -> _ CI.fatptr -> int -> int
  = "owl_stub_3_gsl_matrix_get_col" 

external owl_stub_4_gsl_matrix_equal : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_4_gsl_matrix_equal" 

external owl_stub_5_gsl_matrix_isnull : _ CI.fatptr -> int
  = "owl_stub_5_gsl_matrix_isnull" 

external owl_stub_6_gsl_matrix_ispos : _ CI.fatptr -> int
  = "owl_stub_6_gsl_matrix_ispos" 

external owl_stub_7_gsl_matrix_isneg : _ CI.fatptr -> int
  = "owl_stub_7_gsl_matrix_isneg" 

external owl_stub_8_gsl_matrix_isnonneg : _ CI.fatptr -> int
  = "owl_stub_8_gsl_matrix_isnonneg" 

external owl_stub_9_gsl_matrix_min : _ CI.fatptr -> float
  = "owl_stub_9_gsl_matrix_min" 

external owl_stub_10_gsl_matrix_min_index
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> unit
  = "owl_stub_10_gsl_matrix_min_index" 

external owl_stub_11_gsl_matrix_max : _ CI.fatptr -> float
  = "owl_stub_11_gsl_matrix_max" 

external owl_stub_12_gsl_matrix_max_index
  : _ CI.fatptr -> _ CI.fatptr -> _ CI.fatptr -> unit
  = "owl_stub_12_gsl_matrix_max_index" 

external owl_stub_13_gsl_matrix_complex_equal
  : _ CI.fatptr -> _ CI.fatptr -> int
  = "owl_stub_13_gsl_matrix_complex_equal" 

external owl_stub_14_gsl_matrix_complex_isnull : _ CI.fatptr -> int
  = "owl_stub_14_gsl_matrix_complex_isnull" 

external owl_stub_15_gsl_matrix_complex_ispos : _ CI.fatptr -> int
  = "owl_stub_15_gsl_matrix_complex_ispos" 

external owl_stub_16_gsl_matrix_complex_isneg : _ CI.fatptr -> int
  = "owl_stub_16_gsl_matrix_complex_isneg" 

external owl_stub_17_gsl_matrix_complex_isnonneg : _ CI.fatptr -> int
  = "owl_stub_17_gsl_matrix_complex_isnonneg" 

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
  "gsl_matrix_complex_isnonneg" ->
  (fun x1 -> owl_stub_17_gsl_matrix_complex_isnonneg (CI.cptr x1))
| Function (CI.Pointer x4, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_complex_isneg" ->
  (fun x3 -> owl_stub_16_gsl_matrix_complex_isneg (CI.cptr x3))
| Function (CI.Pointer x6, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_complex_ispos" ->
  (fun x5 -> owl_stub_15_gsl_matrix_complex_ispos (CI.cptr x5))
| Function (CI.Pointer x8, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_complex_isnull" ->
  (fun x7 -> owl_stub_14_gsl_matrix_complex_isnull (CI.cptr x7))
| Function
    (CI.Pointer x10,
     Function (CI.Pointer x12, Returns (CI.Primitive CI.Int))),
  "gsl_matrix_complex_equal" ->
  (fun x9 x11 ->
    owl_stub_13_gsl_matrix_complex_equal (CI.cptr x9) (CI.cptr x11))
| Function
    (CI.Pointer x14,
     Function (CI.Pointer x16, Function (CI.Pointer x18, Returns CI.Void))),
  "gsl_matrix_max_index" ->
  (fun x13 x15 x17 ->
    owl_stub_12_gsl_matrix_max_index (CI.cptr x13) (CI.cptr x15)
    (CI.cptr x17))
| Function (CI.Pointer x20, Returns (CI.Primitive CI.Double)),
  "gsl_matrix_max" -> (fun x19 -> owl_stub_11_gsl_matrix_max (CI.cptr x19))
| Function
    (CI.Pointer x22,
     Function (CI.Pointer x24, Function (CI.Pointer x26, Returns CI.Void))),
  "gsl_matrix_min_index" ->
  (fun x21 x23 x25 ->
    owl_stub_10_gsl_matrix_min_index (CI.cptr x21) (CI.cptr x23)
    (CI.cptr x25))
| Function (CI.Pointer x28, Returns (CI.Primitive CI.Double)),
  "gsl_matrix_min" -> (fun x27 -> owl_stub_9_gsl_matrix_min (CI.cptr x27))
| Function (CI.Pointer x30, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_isnonneg" ->
  (fun x29 -> owl_stub_8_gsl_matrix_isnonneg (CI.cptr x29))
| Function (CI.Pointer x32, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_isneg" ->
  (fun x31 -> owl_stub_7_gsl_matrix_isneg (CI.cptr x31))
| Function (CI.Pointer x34, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_ispos" ->
  (fun x33 -> owl_stub_6_gsl_matrix_ispos (CI.cptr x33))
| Function (CI.Pointer x36, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_isnull" ->
  (fun x35 -> owl_stub_5_gsl_matrix_isnull (CI.cptr x35))
| Function
    (CI.Pointer x38,
     Function (CI.Pointer x40, Returns (CI.Primitive CI.Int))),
  "gsl_matrix_equal" ->
  (fun x37 x39 -> owl_stub_4_gsl_matrix_equal (CI.cptr x37) (CI.cptr x39))
| Function
    (CI.Pointer x42,
     Function
       (CI.Pointer x44,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Int)))),
  "gsl_matrix_get_col" ->
  (fun x41 x43 x45 ->
    owl_stub_3_gsl_matrix_get_col (CI.cptr x41) (CI.cptr x43) x45)
| Function
    (CI.Primitive CI.Size_t,
     Function (CI.Primitive CI.Size_t, Returns (CI.Pointer x48))),
  "gsl_matrix_alloc" ->
  (fun x46 x47 -> CI.make_ptr x48 (owl_stub_2_gsl_matrix_alloc x46 x47))
| Function (CI.Primitive CI.Size_t, Returns (CI.Pointer x50)),
  "gsl_vector_alloc" ->
  (fun x49 -> CI.make_ptr x50 (owl_stub_1_gsl_vector_alloc x49))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

