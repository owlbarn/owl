(*
  Define the types shared by various modules
*)


type float_array2 = (float, float64_elt, c_layout) Array2.t


(** [ define the vector record ]  *)
type vector_record = {
  mutable vsize : int;            (* size of a vector *)
  mutable stride : int;           (* stride of a vector *)
  mutable vdata : float_array2;   (* actual data of a vector *)
  mutable vptr : Matrix_foreign.vec Ctypes_static.structure Ctypes_static.ptr;
  (* pointer to a vector's memory *)
}
