(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(*
 * Owl's implementation of ONNX standards. This implementation connects Owl's
 * internal computation graph, i.e. cgraph, with other accelerator frameworks
 * using ONNX protobuf. By so doing, we can offload computations defined by
 * Owl to various accelerators.
 *
 * Refer to 
 *     1. https://onnx.ai/
 *     2. https://github.com/onnx/onnx/
            
 *)
 