(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

(* Functor of making the symbols of a computation graph. *)

module type Sig = sig

  module Device : Owl_types_computation_device.Sig

  open Device


  (** {6 Type definition} *)

  type state = Valid | Invalid
  (** TODO *)

  type t = attr Owl_graph.node
  (** TODO *)

  and block = {
    size           : int;      (* the number of elements of the block *)
    block_id       : int;      (* id of the block *)
    mutable active : t option; (* the node whose memory is being stored (if any) *)
    mutable memory : value;    (* the value of the active node *)
    mutable nodes  : t list;   (* the nodes sharing the memory block *)
  }
  (**
  ``block`` type keeps a reference to a block of memory and to the nodes
  sharing that block.
   *)

  and attr = {
    mutable op     : op;                        (* operation stored in this node *)
    mutable freeze : bool;                      (* whether or not a node can link to other nodes *)
    mutable reuse  : bool;                      (* whether others can reuse the allocated memory *)
    mutable state  : state;                     (* state to show whether re-evaluation is needed *)
    mutable shape  : (int array option) array;  (* shape of the output values stored in the node *)
    mutable value  : value array;               (* output values of the node *)
    mutable block  : (block array) option;      (* the memory blocks to store the node values *)
  }
  (** TODO *)


  and arr = Arr of t

  and elt = Elt of t

  and op =
    | Noop
    | Var
    | Const
    | Empty                         of int array
    | Zeros                         of int array
    | Ones                          of int array
    | Create                        of int array
    | Sequential                    of int array
    | Uniform                       of int array
    | Gaussian                      of int array
    | Bernoulli                     of int array
    | Init                          of int array * (int -> elt)
    | Get                           of int array
    | Set                           of int array
    | GetSlice                      of int list list
    | SetSlice                      of int list list
    | Copy
    | Reset
    | Reshape                       of int array
    | Reverse
    | Tile                          of int array
    | Repeat                        of int array
    | Pad                           of elt * int list list
    | Concatenate                   of int
    | Split                         of int * int array
    | Draw                          of int * int
    | Map                           of (elt -> elt)
    | Fold                          of int * (elt -> elt -> elt)
    | Scan                          of int * (elt -> elt -> elt)
    | OneHot                        of int
    | Delay                         of (A.arr -> A.arr)
    | DelayArray                    of int array * (A.arr array -> A.arr)
    | LazyPrint                     of int option * int option * bool option * (A.elt -> string) option
    | Abs
    | Neg
    | Floor
    | Ceil
    | Round
    | Sqr
    | Sqrt
    | Log
    | Log2
    | Log10
    | Exp
    | Sin
    | Cos
    | Tan
    | Sinh
    | Cosh
    | Tanh
    | Asin
    | Acos
    | Atan
    | Asinh
    | Acosh
    | Atanh
    | Min                           of int
    | Max                           of int
    | Sum                           of int
    | SumReduce                     of int array
    | Signum
    | Sigmoid
    | Relu
    | Min'
    | Max'
    | Sum'
    | L1norm'
    | L2norm'
    | L2NormSqr'
    | ClipByValue
    | ClipByL2norm
    | Pow
    | ScalarPow
    | PowScalar
    | Atan2
    | ScalarAtan2
    | Atan2Scalar
    | Hypot
    | Min2
    | Max2
    | Add
    | Sub
    | Mul
    | Div
    | AddScalar
    | SubScalar
    | MulScalar
    | DivScalar
    | ScalarAdd
    | ScalarSub
    | ScalarMul
    | ScalarDiv
    | FMA
    | EltEqual
    | EltNotEqual
    | EltLess
    | EltGreater
    | EltLessEqual
    | EltGreaterEqual
    | EltEqualScalar
    | EltNotEqualScalar
    | EltLessScalar
    | EltGreaterScalar
    | EltLessEqualScalar
    | EltGreaterEqualScalar
    | Conv1d                        of padding * int array
    | Conv2d                        of padding * int array
    | Conv3d                        of padding * int array
    | TransposeConv1d               of padding * int array
    | TransposeConv2d               of padding * int array
    | TransposeConv3d               of padding * int array
    | DilatedConv1d                 of padding * int array * int array
    | DilatedConv2d                 of padding * int array * int array
    | DilatedConv3d                 of padding * int array * int array
    | MaxPool1d                     of padding * int array * int array
    | MaxPool2d                     of padding * int array * int array
    | MaxPool3d                     of padding * int array * int array
    | AvgPool1d                     of padding * int array * int array
    | AvgPool2d                     of padding * int array * int array
    | AvgPool3d                     of padding * int array * int array
    | UpSampling2d                  of int array
    | Conv1dBackwardInput           of int array
    | Conv1dBackwardKernel          of int array
    | Conv2dBackwardInput           of int array
    | Conv2dBackwardKernel          of int array
    | Conv3dBackwardInput           of int array
    | Conv3dBackwardKernel          of int array
    | TransposeConv1dBackwardInput  of int array
    | TransposeConv1dBackwardKernel of int array
    | TransposeConv2dBackwardInput  of int array
    | TransposeConv2dBackwardKernel of int array
    | TransposeConv3dBackwardInput  of int array
    | TransposeConv3dBackwardKernel of int array
    | DilatedConv1dBackwardInput    of int array * int array
    | DilatedConv1dBackwardKernel   of int array * int array
    | DilatedConv2dBackwardInput    of int array * int array
    | DilatedConv2dBackwardKernel   of int array * int array
    | DilatedConv3dBackwardInput    of int array * int array
    | DilatedConv3dBackwardKernel   of int array * int array
    | MaxPool1dBackward             of padding * int array * int array
    | MaxPool2dBackward             of padding * int array * int array
    | MaxPool3dBackward             of padding * int array * int array
    | AvgPool1dBackward             of padding * int array * int array
    | AvgPool2dBackward             of padding * int array * int array
    | AvgPool3dBackward             of padding * int array * int array
    | UpSampling2dBackward          of int array
    | RowNum
    | ColNum
    | Row
    | Rows                          of int array
    | CopyRowTo
    | CopyColTo
    | Dot                           of bool * bool * elt * elt
    | Inv
    | Trace
    | Transpose                     of int array
    | ToRows
    | OfRows
    | Scalar_Add
    | Scalar_Sub
    | Scalar_Mul
    | Scalar_Div
    | Scalar_Pow
    | Scalar_Atan2
    | Scalar_Abs
    | Scalar_Neg
    | Scalar_Sqr
    | Scalar_Sqrt
    | Scalar_Exp
    | Scalar_Log
    | Scalar_Log2
    | Scalar_Log10
    | Scalar_Signum
    | Scalar_Floor
    | Scalar_Ceil
    | Scalar_Round
    | Scalar_Sin
    | Scalar_Cos
    | Scalar_Tan
    | Scalar_Sinh
    | Scalar_Cosh
    | Scalar_Tanh
    | Scalar_Asin
    | Scalar_Acos
    | Scalar_Atan
    | Scalar_Asinh
    | Scalar_Acosh
    | Scalar_Atanh
    | Scalar_Relu
    | Scalar_Sigmoid
    | Fused_Adagrad                 of float * float
  (** TODO *)

end
