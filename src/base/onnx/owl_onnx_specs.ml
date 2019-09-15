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
    opset_import     : OpSet.t list;
    metadata_props   : (string * string) list;
  }

end


and Graph
: sig

  type t

end
 = struct

  type t = {
    node               : Node.t list;
    name               : string option;
    initialiser        : Tensor.t list;
    sparse_initialiser : SparseTensor.t list;
    doc_string         : string option;
    input              : ValueInfo.t list;
    output             : ValueInfo.t list;
    value_info         : ValueInfo.t list; 
  }
  
end


and Node
: sig

  type t

end
= struct

  type t = {
    input     : string list;
    output    : string list;
    name      : string option;
    op_type   : string option;
    domain    : string option;
    attribute : Attribute.t;
    doc_string: string option;
  }

end


and Operator
: sig

  type t

end
= struct

  type t

end


and OpSet
: sig

  type t

end
= struct

  type t

end


and TensorAnnotation
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

  type t

end


and SparseTensor
: sig

  type t

end
= struct

  type t

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