open Owl_types

module type Sig = sig
  type t

  type elt

  type arr

  type op

  (** {6 Ops Builder } *)
  module Builder :
    Owl_algodiff_ops_builder_sig.Sig
      with type t := t
       and type elt := elt
       and type arr := arr
       and type op := op

  (** {6 Supported Maths functions} *)

  module Maths : sig
    val ( + ) : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val ( - ) : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val ( * ) : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val ( / ) : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val ( *@ ) : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val ( ** ) : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val add : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val sub : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val mul : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val div : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val dot : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val pow : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val atan2 : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val min2 : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val max2 : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val cross_entropy : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val inv : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val neg : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val abs : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val signum : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val floor : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val ceil : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val round : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val sqr : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val sqrt : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val log : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val log2 : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val log10 : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val exp : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val sin : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val cos : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val tan : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val sinh : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val cosh : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val tanh : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val asin : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val acos : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val atan : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val asinh : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val acosh : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val atanh : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val sum' : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val sum : ?axis:int -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val sum_reduce : ?axis:int array -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val mean : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val transpose : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val l1norm' : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val l2norm' : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val l2norm_sqr' : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val sigmoid : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val relu : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val softplus : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val softsign : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val softmax : ?axis:int -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val reshape : t -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val flatten : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val get_item : t -> int -> int -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val get_row : t -> int -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val concat : axis:int -> t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val split : axis:int -> int array -> t -> t array
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val of_arrays : t array array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val to_arrays : t -> t array array
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val concatenate : axis:int -> t array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val get_slice : int list list -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val set_slice : int list list -> t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val diag : ?k:int -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val diagm : ?k:int -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val trace : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val triu : ?k:int -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val tril : ?k:int -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)
  end

  (** {6 Supported Linalg functions} *)

  module Linalg : sig
    val inv : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val logdet : t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val chol : ?upper:bool -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val qr : t -> t * t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val lq : t -> t * t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val svd : ?thin:bool -> t -> t * t * t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val sylvester : t -> t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val lyapunov : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val discrete_lyapunov : ?solver:[ `default | `bilinear | `direct ] -> t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val ( /@ ) : t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val linsolve : ?trans:bool -> ?typ:[ `n | `u | `l ] -> t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val care : ?diag_r:bool -> t -> t -> t -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)
  end

  (** {6 Supported Neural Network functions} *)

  module NN : sig
    val dropout : ?rate:float -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val conv1d : ?padding:padding -> t -> t -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val conv2d : ?padding:padding -> t -> t -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val conv3d : ?padding:padding -> t -> t -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val dilated_conv1d : ?padding:padding -> t -> t -> int array -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val dilated_conv2d : ?padding:padding -> t -> t -> int array -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val dilated_conv3d : ?padding:padding -> t -> t -> int array -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val transpose_conv1d : ?padding:padding -> t -> t -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val transpose_conv2d : ?padding:padding -> t -> t -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val transpose_conv3d : ?padding:padding -> t -> t -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val max_pool1d : padding -> t -> int array -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val max_pool2d : padding -> t -> int array -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val max_pool3d : padding -> t -> int array -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val avg_pool1d : padding -> t -> int array -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val avg_pool2d : padding -> t -> int array -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val avg_pool3d : padding -> t -> int array -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val upsampling2d : t -> int array -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)

    val pad : ?v:elt -> int list list -> t -> t
    (** Refer to :doc:`owl_dense_ndarray_generic` *)
  end

  (* Simple wrappers of matrix and ndarray module, so you don't have to pack and unpack
     stuff all the time. Some operations just interface to those already defined in the
     Maths module. *)

  (** {6 Supported Mat functions} *)

  module Mat : sig
    val empty : int -> int -> t

    val zeros : int -> int -> t

    val eye : int -> t

    val ones : int -> int -> t

    val uniform : ?a:elt -> ?b:elt -> int -> int -> t

    val gaussian : ?mu:elt -> ?sigma:elt -> int -> int -> t

    val shape : t -> int * int

    val numel : t -> int

    val row_num : t -> int

    val col_num : t -> int

    val reset : t -> unit

    val reshape : int -> int -> t -> t

    val get : t -> int -> int -> t

    val set : t -> int -> int -> t -> t

    val row : t -> int -> t

    val mean : t -> t

    val add : t -> t -> t

    val sub : t -> t -> t

    val mul : t -> t -> t

    val div : t -> t -> t

    val dot : t -> t -> t

    val map_by_row : (t -> t) -> t -> t

    val of_arrays : elt array array -> t

    val init_2d : int -> int -> (int -> int -> t) -> t

    val print : t -> unit
  end

  (** {6 Supported Arr functions} *)

  module Arr : sig
    val empty : int array -> t

    val zeros : int array -> t

    val ones : int array -> t

    val uniform : ?a:elt -> ?b:elt -> int array -> t

    val gaussian : ?mu:elt -> ?sigma:elt -> int array -> t

    val shape : t -> int array

    val numel : t -> int

    val reset : t -> unit

    val reshape : t -> int array -> t

    val add : t -> t -> t

    val sub : t -> t -> t

    val mul : t -> t -> t

    val div : t -> t -> t

    val dot : t -> t -> t
  end
end
