(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(* math operator definitions *)

let sin x = Owl_opencl_operand.(pack_op (Map "sin") [|x|])

let cos x = Owl_opencl_operand.(pack_op (Map "cos") [|x|])

let add x y = Owl_opencl_operand.(pack_op (MapN "add") [|x; y|])

let add_scalar x a = Owl_opencl_operand.(pack_op (MapArrScalar "add_scalar") [|x; a|])

let sum x = Owl_opencl_operand.(pack_op (Reduce "sum") [|x|])

(* ends here *)
