(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Complex dense matrix module: this module supports operations on dense
  matrices of complex numbers. The complex number has a record type of
  [{re = float; im = float}].

  This page only contains detailed explanations for the operations specific to
  Dense.Complex module. Most of the other operations are the same to those in
  Dense.Real module, therefore please refer to the documentation of Dense.Real
  for more information.
 *)

open Bigarray

open Owl_types

type elt = Complex.t
type mat = (Complex.t, complex32_elt) Owl_dense_matrix_generic.t
type cast_mat = (float, float32_elt) Owl_dense_matrix_generic.t


(** {6 Create dense matrices} *)

val empty : int -> int -> mat

val init : int -> int -> (int -> elt) -> mat

val init_2d : int -> int -> (int -> int -> elt) -> mat

val create : int -> int -> elt -> mat

val zeros : int -> int -> mat

val ones : int -> int -> mat

val eye : int -> mat

val complex : cast_mat -> cast_mat -> mat

val polar : cast_mat -> cast_mat -> mat

val sequential : ?a:elt -> ?step:elt -> int -> int -> mat

val uniform : ?a:elt -> ?b:elt -> int -> int -> mat

val gaussian : ?mu:elt -> ?sigma:elt -> int -> int -> mat

val linspace : elt -> elt -> int -> mat

val meshgrid : elt -> elt -> elt -> elt -> int -> int -> mat * mat

val meshup : mat -> mat -> mat * mat

val bernoulli : ?p:float -> int -> int -> mat

val diagm : ?k:int -> mat -> mat

val triu : ?k:int -> mat -> mat

val tril : ?k:int -> mat -> mat

val symmetric : ?upper:bool -> mat -> mat

val hermitian : ?upper:bool -> mat -> mat

val bidiagonal : ?upper:bool -> mat -> mat -> mat

val toeplitz : ?c:mat -> mat -> mat

val hankel : ?r:mat -> mat -> mat

val hadamard : int -> mat

val magic : int -> mat


(** {7 Dense row vectors and meshgrids} *)

val vector : int -> mat

val vector_zeros : int -> mat

val vector_ones : int -> mat

val vector_uniform : int -> mat

val linspace : elt -> elt -> int -> mat

val logspace : ?base:float -> elt -> elt -> int -> mat

val meshgrid : elt -> elt -> elt -> elt -> int -> int -> mat * mat

val meshup : mat -> mat -> mat * mat


(** {6 Obtain the basic properties of a matrix} *)

val shape : mat -> int * int

val row_num : mat -> int

val col_num : mat -> int

val numel : mat -> int

val nnz : mat -> int

val density : mat -> float

val size_in_bytes : mat -> int

val same_shape : mat -> mat -> bool


(** {6 Manipulate a matrix} *)

val get : mat -> int -> int -> elt

val set : mat -> int -> int -> elt -> unit

val get_index : mat -> int array array -> elt array

val set_index : mat -> int array array -> elt array -> unit

val get_fancy : index list -> mat -> mat

val set_fancy : index list -> mat -> mat -> unit

val get_slice : int list list -> mat -> mat

val set_slice : int list list -> mat -> mat -> unit

val row : mat -> int -> mat

val col : mat -> int -> mat

val rows : mat -> int array -> mat

val cols : mat -> int array -> mat

val resize : ?head:bool -> mat -> int array -> mat

val reshape : mat -> int array -> mat

val flatten : mat -> mat

val reverse : mat -> mat

val flip : ?axis:int -> mat -> mat

val rotate : mat -> int -> mat

val reset : mat -> unit

val fill : mat -> elt -> unit

val copy : mat -> mat

val copy_to : mat -> mat -> unit

val copy_row_to : mat -> mat -> int -> unit

val copy_col_to : mat -> mat -> int -> unit

val concat_vertical : mat -> mat -> mat

val concat_horizontal : mat -> mat -> mat

val concat_vh : mat array array -> mat

val concatenate : ?axis:int -> mat array -> mat

val split : ?axis:int -> int array -> mat -> mat array

val split_vh : (int * int) array array -> mat -> mat array array

val transpose : mat -> mat

val ctranspose : mat -> mat

val diag : ?k:int -> mat -> mat

val swap_rows : mat -> int -> int -> unit

val swap_cols : mat -> int -> int -> unit

val tile : mat -> int array -> mat

val repeat : ?axis:int -> mat -> int -> mat

val pad : ?v:elt -> int list list -> mat -> mat

val dropout : ?rate:float -> mat -> mat

val top : mat -> int -> int array array

val bottom : mat -> int -> int array array

val sort : mat -> mat

val argsort : mat -> (int64, int64_elt, c_layout) Genarray.t


(** {6 Iterate elements, columns, and rows.} *)

val iteri : (int -> elt -> unit) -> mat -> unit

val iter : (elt -> unit) -> mat -> unit

val mapi : (int -> elt -> elt) -> mat -> mat

val map : (elt -> elt) -> mat -> mat

val foldi : ?axis:int -> (int -> elt -> elt -> elt) -> elt -> mat -> mat

val fold : ?axis:int -> (elt -> elt -> elt) -> elt -> mat -> mat

val scani : ?axis:int -> (int -> elt -> elt -> elt) -> mat -> mat

val scan : ?axis:int -> (elt -> elt -> elt) -> mat -> mat

val filteri : (int -> elt -> bool) -> mat -> int array

val filter : (elt -> bool) -> mat -> int array

val iteri_2d :(int -> int -> elt -> unit) -> mat -> unit

val mapi_2d : (int -> int -> elt -> elt) -> mat -> mat

val foldi_2d : ?axis:int -> (int -> int -> elt -> elt -> elt) -> elt -> mat -> mat

val scani_2d : ?axis:int -> (int -> int -> elt -> elt -> elt) -> mat -> mat

val filteri_2d : (int -> int -> elt -> bool) -> mat -> (int * int) array

val iter2i_2d :(int -> int -> elt -> elt -> unit) -> mat -> mat -> unit

val map2i_2d : (int -> int -> elt -> elt -> elt) -> mat -> mat -> mat

val iter2i : (int -> elt -> elt -> unit) -> mat -> mat -> unit

val iter2 : (elt -> elt -> unit) -> mat -> mat -> unit

val map2i : (int -> elt -> elt -> elt) -> mat -> mat -> mat

val map2 : (elt -> elt -> elt) -> mat -> mat -> mat

val iteri_rows : (int -> mat -> unit) -> mat -> unit

val iter_rows : (mat -> unit) -> mat -> unit

val iter2i_rows : (int -> mat -> mat -> unit) -> mat -> mat -> unit

val iter2_rows : (mat -> mat -> unit) -> mat -> mat -> unit

val iteri_cols : (int -> mat -> unit) -> mat -> unit

val iter_cols : (mat -> unit) -> mat -> unit

val filteri_rows : (int -> mat -> bool) -> mat -> int array

val filter_rows : (mat -> bool) -> mat -> int array

val filteri_cols : (int -> mat -> bool) -> mat -> int array

val filter_cols : (mat -> bool) -> mat -> int array

val fold_rows : ('a -> mat -> 'a) -> 'a -> mat -> 'a

val fold_cols : ('a -> mat -> 'a) -> 'a -> mat -> 'a

val mapi_rows : (int -> mat -> 'a) -> mat -> 'a array

val map_rows : (mat -> 'a) -> mat -> 'a array

val mapi_cols : (int -> mat -> 'a) -> mat -> 'a array

val map_cols : (mat -> 'a) -> mat -> 'a array

val mapi_by_row : int -> (int -> mat -> mat) -> mat -> mat

val map_by_row : int -> (mat -> mat) -> mat -> mat

val mapi_by_col : int -> (int -> mat -> mat) -> mat -> mat

val map_by_col : int -> (mat -> mat) -> mat -> mat

val mapi_at_row : (int -> elt -> elt) -> mat -> int -> mat

val map_at_row : (elt -> elt) -> mat -> int -> mat

val mapi_at_col : (int -> elt -> elt) -> mat -> int -> mat

val map_at_col : (elt -> elt) -> mat -> int -> mat


(** {6 Examin elements and compare two matrices} *)

val exists : (elt -> bool) -> mat -> bool

val not_exists : (elt -> bool) -> mat -> bool

val for_all : (elt -> bool) -> mat -> bool

val is_zero : mat -> bool

val is_positive : mat -> bool

val is_negative : mat -> bool

val is_nonpositive : mat -> bool

val is_nonnegative : mat -> bool

val is_normal : mat -> bool

val not_nan : mat -> bool

val not_inf : mat -> bool

val equal : mat -> mat -> bool

val not_equal : mat -> mat -> bool

val greater : mat -> mat -> bool

val less : mat -> mat -> bool

val greater_equal : mat -> mat -> bool

val less_equal : mat -> mat -> bool

val elt_equal : mat -> mat -> mat

val elt_not_equal : mat -> mat -> mat

val elt_less : mat -> mat -> mat

val elt_greater : mat -> mat -> mat

val elt_less_equal : mat -> mat -> mat

val elt_greater_equal : mat -> mat -> mat

val equal_scalar : mat -> elt -> bool

val not_equal_scalar : mat -> elt -> bool

val less_scalar : mat -> elt -> bool

val greater_scalar : mat -> elt -> bool

val less_equal_scalar : mat -> elt -> bool

val greater_equal_scalar : mat -> elt -> bool

val elt_equal_scalar : mat -> elt -> mat

val elt_not_equal_scalar : mat -> elt -> mat

val elt_less_scalar : mat -> elt -> mat

val elt_greater_scalar : mat -> elt -> mat

val elt_less_equal_scalar : mat -> elt -> mat

val elt_greater_equal_scalar : mat -> elt -> mat

val approx_equal : ?eps:float -> mat -> mat -> bool

val approx_equal_scalar : ?eps:float -> mat -> elt -> bool

val approx_elt_equal : ?eps:float -> mat -> mat -> mat

val approx_elt_equal_scalar : ?eps:float -> mat -> elt -> mat


(** {6 Randomisation functions} *)

val draw_rows : ?replacement:bool -> mat -> int -> mat * int array

val draw_cols : ?replacement:bool -> mat -> int -> mat * int array

val draw_rows2 : ?replacement:bool -> mat -> mat -> int -> mat * mat * int array

val draw_cols2 : ?replacement:bool -> mat -> mat -> int -> mat * mat * int array

val shuffle_rows : mat -> mat

val shuffle_cols : mat -> mat

val shuffle: mat -> mat


(** {6 Input/Output and helper functions} *)

val to_array : mat -> elt array

val of_array : elt array -> int -> int -> mat

val to_arrays : mat -> elt array array

val of_arrays : elt array array -> mat

val to_rows : mat -> mat array

val of_rows : mat array -> mat

val to_cols : mat -> mat array

val of_cols : mat array -> mat

val print : ?max_row:int -> ?max_col:int -> ?header:bool -> ?fmt:(elt -> string) -> mat -> unit

val save : mat -> string -> unit

val load : string -> mat

val save_txt : ?sep:string -> ?append:bool -> mat -> string -> unit

val load_txt : ?sep:string -> string -> mat


(** {6 Unary mathematical operations } *)

val min : ?axis:int -> mat -> mat

val min' : mat -> elt

val max : ?axis:int -> mat -> mat

val max' : mat -> elt

val minmax : ?axis:int -> mat -> mat * mat

val minmax' : mat -> elt * elt

val min_i : mat -> elt * int array

val max_i : mat -> elt * int array

val minmax_i : mat -> (elt * int array) * (elt * int array)

val re : mat -> cast_mat

val im : mat -> cast_mat

val trace : mat -> elt

val sum : ?axis:int -> mat -> mat

val sum': mat -> elt

val prod : ?axis:int -> mat -> mat

val prod' : mat -> elt

val mean : ?axis:int -> mat -> mat

val mean': mat -> elt

val var : ?axis:int -> mat -> mat

val var': mat -> elt

val std : ?axis:int -> mat -> mat

val std': mat -> elt

val sum_rows : mat -> mat

val sum_cols : mat -> mat

val mean_rows : mat -> mat

val mean_cols : mat -> mat

val abs : mat -> mat

val abs2 : mat -> mat

val conj : mat -> mat

val neg : mat -> mat

val reci : mat -> mat

val reci_tol : ?tol:elt -> mat -> mat

val l1norm : ?axis:int -> mat -> mat

val l1norm' : mat -> elt

val l2norm : ?axis:int -> mat -> mat

val l2norm' : mat -> elt

val l2norm_sqr : ?axis:int -> mat -> mat

val l2norm_sqr' : mat -> elt

val vecnorm : ?axis:int -> ?p:float -> mat -> mat

val vecnorm' : ?p:float -> mat -> elt

val cumsum : ?axis:int -> mat -> mat

val cumprod : ?axis:int -> mat -> mat

val cummin : ?axis:int -> mat -> mat

val cummax : ?axis:int -> mat -> mat

val diff : ?axis:int -> ?n:int -> mat -> mat

val sqr : mat -> mat

val sqrt : mat -> mat

val cbrt : mat -> mat

val exp : mat -> mat

val exp2 : mat -> mat

val exp10 : mat -> mat

val expm1 : mat -> mat

val log : mat -> mat

val log10 : mat -> mat

val log2 : mat -> mat

val log1p : mat -> mat

val sin : mat -> mat

val cos : mat -> mat

val tan : mat -> mat

val asin : mat -> mat

val acos : mat -> mat

val atan : mat -> mat

val sinh : mat -> mat

val cosh : mat -> mat

val tanh : mat -> mat

val asinh : mat -> mat

val acosh : mat -> mat

val atanh : mat -> mat

val floor : mat -> mat

val ceil : mat -> mat

val round : mat -> mat

val trunc : mat -> mat

val fix : mat -> mat

val modf : mat -> mat * mat

val angle : mat -> mat

val proj : mat -> mat

val var : ?axis:int -> mat -> mat

val std : ?axis:int -> mat -> mat

val mat2gray : ?amin:elt -> ?amax:elt -> mat -> mat


(** {6 Binary mathematical operations } *)

val add : mat -> mat -> mat

val sub : mat -> mat -> mat

val mul : mat -> mat -> mat

val div : mat -> mat -> mat

val add_scalar : mat -> elt -> mat

val sub_scalar : mat -> elt -> mat

val mul_scalar : mat -> elt -> mat

val div_scalar : mat -> elt -> mat

val scalar_add : elt -> mat -> mat

val scalar_sub : elt -> mat -> mat

val scalar_mul : elt -> mat -> mat

val scalar_div : elt -> mat -> mat

val dot : mat -> mat -> mat

val add_diag : mat -> elt -> mat

val ssqr' : mat -> elt -> elt

val ssqr_diff' : mat -> mat -> elt

val min2 : mat -> mat -> mat

val max2 : mat -> mat -> mat

val pow : mat -> mat -> mat

val scalar_pow : elt -> mat -> mat

val pow_scalar : mat -> elt -> mat

val cov : ?b:mat -> a:mat -> mat

val kron : mat -> mat -> mat

val clip_by_value : ?amin:elt -> ?amax:elt -> mat -> mat


(** {6 Fucntions of in-place modification } *)

val sort_ : mat -> unit

val add_ : mat -> mat -> unit

val sub_ : mat -> mat -> unit

val mul_ : mat -> mat -> unit

val div_ : mat -> mat -> unit

val pow_ : mat -> mat -> unit

val atan2_ : mat -> mat -> unit

val hypot_ : mat -> mat -> unit

val fmod_ : mat -> mat -> unit

val min2_ : mat -> mat -> unit

val max2_ : mat -> mat -> unit

val add_scalar_ : mat -> elt -> unit

val sub_scalar_ : mat -> elt -> unit

val mul_scalar_ : mat -> elt -> unit

val div_scalar_ : mat -> elt -> unit

val pow_scalar_ : mat -> elt -> unit

val atan2_scalar_ : mat -> elt -> unit

val fmod_scalar_ : mat -> elt -> unit

val scalar_add_ : elt -> mat -> unit

val scalar_sub_ : elt -> mat -> unit

val scalar_mul_ : elt -> mat -> unit

val scalar_div_ : elt -> mat -> unit

val scalar_pow_ : elt -> mat -> unit

val scalar_atan2_ : elt -> mat -> unit

val scalar_fmod_ : elt -> mat -> unit

val conj_ : mat -> unit

val abs_ : mat -> unit

val neg_ : mat -> unit

val reci_ : mat -> unit

val signum_ : mat -> unit

val sqr_ : mat -> unit

val sqrt_ : mat -> unit

val cbrt_ : mat -> unit

val exp_ : mat -> unit

val exp2_ : mat -> unit

val exp10_ : mat -> unit

val expm1_ : mat -> unit

val log_ : mat -> unit

val log2_ : mat -> unit

val log10_ : mat -> unit

val log1p_ : mat -> unit

val sin_ : mat -> unit

val cos_ : mat -> unit

val tan_ : mat -> unit

val asin_ : mat -> unit

val acos_ : mat -> unit

val atan_ : mat -> unit

val sinh_ : mat -> unit

val cosh_ : mat -> unit

val tanh_ : mat -> unit

val asinh_ : mat -> unit

val acosh_ : mat -> unit

val atanh_ : mat -> unit

val floor_ : mat -> unit

val ceil_ : mat -> unit

val round_ : mat -> unit

val trunc_ : mat -> unit

val fix_ : mat -> unit

val erf_ : mat -> unit

val erfc_ : mat -> unit

val relu_ : mat -> unit

val softplus_ : mat -> unit

val softsign_ : mat -> unit

val sigmoid_ : mat -> unit

val cumsum_ : ?axis:int -> mat -> unit

val cumprod_ : ?axis:int -> mat -> unit

val cummin_ : ?axis:int -> mat -> unit

val cummax_ : ?axis:int -> mat -> unit

val dropout_ : ?rate:float -> mat -> unit

val elt_equal_ : mat -> mat -> unit

val elt_not_equal_ : mat -> mat -> unit

val elt_less_ : mat -> mat -> unit

val elt_greater_ : mat -> mat -> unit

val elt_less_equal_ : mat -> mat -> unit

val elt_greater_equal_ : mat -> mat -> unit

val elt_equal_scalar_ : mat -> elt -> unit

val elt_not_equal_scalar_ : mat -> elt -> unit

val elt_less_scalar_ : mat -> elt -> unit

val elt_greater_scalar_ : mat -> elt -> unit

val elt_less_equal_scalar_ : mat -> elt -> unit

val elt_greater_equal_scalar_ : mat -> elt -> unit
