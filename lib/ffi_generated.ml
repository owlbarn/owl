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
    (CI.Pointer x2,
     Function (CI.Pointer x4, Function (CI.Pointer x6, Returns CI.Void))),
  "gsl_matrix_max_index" ->
  (fun x1 x3 x5 ->
    owl_stub_12_gsl_matrix_max_index (CI.cptr x1) (CI.cptr x3) (CI.cptr x5))
| Function (CI.Pointer x8, Returns (CI.Primitive CI.Double)),
  "gsl_matrix_max" -> (fun x7 -> owl_stub_11_gsl_matrix_max (CI.cptr x7))
| Function
    (CI.Pointer x10,
     Function (CI.Pointer x12, Function (CI.Pointer x14, Returns CI.Void))),
  "gsl_matrix_min_index" ->
  (fun x9 x11 x13 ->
    owl_stub_10_gsl_matrix_min_index (CI.cptr x9) (CI.cptr x11) (CI.cptr x13))
| Function (CI.Pointer x16, Returns (CI.Primitive CI.Double)),
  "gsl_matrix_min" -> (fun x15 -> owl_stub_9_gsl_matrix_min (CI.cptr x15))
| Function (CI.Pointer x18, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_isnonneg" ->
  (fun x17 -> owl_stub_8_gsl_matrix_isnonneg (CI.cptr x17))
| Function (CI.Pointer x20, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_isneg" ->
  (fun x19 -> owl_stub_7_gsl_matrix_isneg (CI.cptr x19))
| Function (CI.Pointer x22, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_ispos" ->
  (fun x21 -> owl_stub_6_gsl_matrix_ispos (CI.cptr x21))
| Function (CI.Pointer x24, Returns (CI.Primitive CI.Int)),
  "gsl_matrix_isnull" ->
  (fun x23 -> owl_stub_5_gsl_matrix_isnull (CI.cptr x23))
| Function
    (CI.Pointer x26,
     Function (CI.Pointer x28, Returns (CI.Primitive CI.Int))),
  "gsl_matrix_equal" ->
  (fun x25 x27 -> owl_stub_4_gsl_matrix_equal (CI.cptr x25) (CI.cptr x27))
| Function
    (CI.Pointer x30,
     Function
       (CI.Pointer x32,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Int)))),
  "gsl_matrix_get_col" ->
  (fun x29 x31 x33 ->
    owl_stub_3_gsl_matrix_get_col (CI.cptr x29) (CI.cptr x31) x33)
| Function
    (CI.Primitive CI.Size_t,
     Function (CI.Primitive CI.Size_t, Returns (CI.Pointer x36))),
  "gsl_matrix_alloc" ->
  (fun x34 x35 -> CI.make_ptr x36 (owl_stub_2_gsl_matrix_alloc x34 x35))
| Function (CI.Primitive CI.Size_t, Returns (CI.Pointer x38)),
  "gsl_vector_alloc" ->
  (fun x37 -> CI.make_ptr x38 (owl_stub_1_gsl_vector_alloc x37))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

