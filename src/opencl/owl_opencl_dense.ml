(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


(* math operator definitions *)

let sin x = Owl_opencl_operand.(pack_op (Map "sin") [|x|])

let cos x = Owl_opencl_operand.(pack_op (Map "cos") [|x|])

let add x y = Owl_opencl_operand.(pack_op (Combine "add") [|x; y|])

(* ends here *)
