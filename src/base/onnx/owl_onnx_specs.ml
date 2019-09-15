(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module rec Model
: sig

  type t

end
= struct

  type t = {
    ir_version       : Int64.t option;
    producer_name    : string option;
    producer_version : string option;
    domain           : string option;
    model_version    : Int64.t option;
    doc_string       : string option;
    graph            : Graph.t option;
    opset_import     : OperatorSetId.t list;
    metadata_props   : StringStringEntry.t list;
  }

end


and Graph
: sig

  type t

end
 = struct

  type t = {
    node                    : Node.t list;
    name                    : string option;
    initialiser             : Tensor.t list;
    sparse_initialiser      : SparseTensor.t list;
    doc_string              : string option;
    input                   : ValueInfo.t list;
    output                  : ValueInfo.t list;
    value_info              : ValueInfo.t list;
    quantization_annotation : TensorAnnotation.t list; 
  }
  
end


and Node
: sig

  type t

end
= struct

  type t = {
    input      : string list;
    output     : string list;
    name       : string option;
    op_type    : string option;
    domain     : string option;
    attribute  : Attribute.t;
    doc_string : string option;
  }

end


and Operator
: sig

  type t

end
= struct

  type t

end


and OperatorSetId
: sig

  type t

end
= struct

  type t = {
    doman   : string option;
    version : Int64.t option;
  }

end


and TensorAnnotation
: sig

  type t

end
= struct

  type t = {
    tensor_name                  : string option;
    quant_parameter_tensor_names : StringStringEntry.t list;
  }

end


and TensorShape
: sig

  type t

end
= struct

  type t

end


and Tensor
: sig

  type t

end
= struct

  [@@@warning "-37"]

  type t = {
    dims : Int64.t list;
    data_type     : data_type option;
    segment       : segment option;
    float_data    : float list;
    int32_data    : Int32.t list;
    string_data   : Bytes.t;
    int64_data    : Int64.t list;
    name          : string option;
    doc_string    : string option;
    raw_data      : Bytes.t option;
    double_data   : float list;
    unit64_data   : Unsigned.UInt64.t list;
    external_data : StringStringEntry.t list;
    data_location : data_location;
  }

  and segment = {
    begin_pos : Int64.t option;
    end_pos   : Int64.t option;
  }

  and data_location =
    | DEFAULT
    | EXTERNAL

  and data_type =
    | UNDEFINED

    (* Basic types *)
    | FLOAT
    | UINT8
    | INT8
    | UINT16
    | INT16
    | INT32
    | INT64
    | STRING
    | BOOL

    (* IEEE754 half-precision floating-point format (16 bits wide).
     * This format has 1 sign bit, 5 exponent bits, and 10 mantissa bits. *)
    | FLOAT16
    | DOUBLE
    | UINT32
    | UINT64
    | COMPLEX64  (* complex with float32 real and imaginary components *)
    | COMPLEX128 (*complex with float64 real and imaginary components *)

    (* Non-IEEE floating-point format based on IEEE754 single-precision
     * floating-point number truncated to 16 bits.
     * This format has 1 sign bit, 8 exponent bits, and 7 mantissa bits. *)
    | BFLOAT16


end


and SparseTensor
: sig

  type t

end
= struct

  type t = {
    values  : Tensor.t option;
    indices : Tensor.t option;
    dims    : Int64.t list;
  }

end


and ValueInfo
: sig

  type t

end
= struct

  type t

end


and Attribute
: sig

  type t

end
= struct

  [@@@warning "-37"]

  type t = {
    name          : string option;
    ref_attr_name : string option;
    doc_string    :  string option;
    typ           : attr_typ option;

    (* Exactly ONE of the following fields must be present *)
    f             : float option;
    i             : Int64.t option;
    s             : string option;
    t             : Tensor.t option;
    g             : Graph.t option;
    sparse_tensor : SparseTensor.t option;
  }

  and attr_typ =
    | UNDEFINED
    | FLOAT
    | INT
    | STRING
    | TENSOR
    | GRAPH
    | SPARSE_TENSOR
    | FLOATS
    | INTS
    | STRINGS
    | TENSORS
    | GRAPHS
    | SPARSE_TENSORS

end


and StringStringEntry
: sig

  type t

end
= struct

  type t = {
    key   : string option;
    value : string option;
  }

end