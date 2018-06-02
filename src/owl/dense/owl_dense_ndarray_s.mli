(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types

type elt = float
type arr = (float, float32_elt, c_layout) Genarray.t


(** {6 Create N-dimensional array} *)

val empty : int array -> arr

val create : int array -> elt -> arr

val init : int array -> (int -> elt) -> arr

val init_nd : int array -> (int array -> elt) -> arr

val zeros : int array -> arr

val ones : int array -> arr

val uniform : ?a:elt -> ?b:elt -> int array -> arr

val gaussian : ?mu:elt -> ?sigma:elt -> int array -> arr

val sequential : ?a:elt -> ?step:elt -> int array -> arr

val linspace : elt -> elt -> int -> arr

val logspace : ?base:float -> elt -> elt -> int -> arr

val bernoulli : ?p:float -> int array -> arr


(** {6 Obtain basic properties} *)

val shape : arr -> int array

val num_dims : arr -> int

val nth_dim : arr -> int -> int

val numel : arr -> int

val nnz : arr -> int

val density : arr -> float

val size_in_bytes : arr -> int

val same_shape : arr -> arr -> bool

val strides : arr -> int array

val slice_size : arr -> int array

val ind : arr -> int -> int array

val i1d : arr -> int array -> int


(** {6 Manipulate a N-dimensional array} *)

val get : arr -> int array -> elt

val set : arr -> int array -> elt -> unit

val get_index : arr -> int array array -> elt array

val set_index : arr -> int array array -> elt array -> unit

val get_fancy : index list -> arr -> arr

val set_fancy : index list -> arr -> arr -> unit

val get_slice : int list list -> arr -> arr

val set_slice : int list list -> arr -> arr -> unit

val sub_left : arr -> int -> int -> arr

val sub_ndarray : int array -> arr -> arr array

val slice_left : arr -> int array -> arr

val copy_to : arr -> arr -> unit

val reset : arr -> unit

val fill : arr -> elt -> unit

val copy : arr -> arr

val resize : ?head:bool -> arr -> int array -> arr

val reshape : arr -> int array -> arr

val flatten : arr -> arr

val reverse : arr -> arr

val flip : ?axis:int -> arr -> arr

val rotate : arr -> int -> arr

val transpose : ?axis:int array -> arr -> arr

val swap : int -> int -> arr -> arr

val tile : arr -> int array -> arr

val repeat : ?axis:int -> arr -> int -> arr

val concat_vertical : arr -> arr -> arr

val concat_horizontal : arr -> arr -> arr

val concat_vh : arr array array -> arr

val concatenate : ?axis:int -> arr array -> arr

val split : ?axis:int -> int array -> arr -> arr array

val split_vh : (int * int) array array -> arr -> arr array array

val squeeze : ?axis:int array -> arr -> arr

val expand : ?hi:bool -> arr -> int -> arr

val pad : ?v:elt -> int list list -> arr -> arr

val dropout : ?rate:float -> arr -> arr

val top : arr -> int -> int array array

val bottom : arr -> int -> int array array

val sort : arr -> arr

val argsort : arr -> (int64, int64_elt, c_layout) Genarray.t

val draw : ?axis:int -> arr -> int -> arr * int array

val mmap : Unix.file_descr -> ?pos:int64 -> bool -> int array -> arr


(** {6 Iterate array elements} *)

val iteri : (int -> elt -> unit) -> arr -> unit

val iter : (elt -> unit) -> arr -> unit

val mapi : (int -> elt -> elt) -> arr -> arr

val map : (elt -> elt) -> arr -> arr

val foldi : ?axis:int -> (int -> elt -> elt -> elt) -> elt -> arr -> arr

val fold : ?axis:int -> (elt -> elt -> elt) -> elt -> arr -> arr

val scani : ?axis:int -> (int -> elt -> elt -> elt) -> arr -> arr

val scan : ?axis:int -> (elt -> elt -> elt) -> arr -> arr

val filteri : (int -> elt -> bool) -> arr -> int array

val filter : (elt -> bool) -> arr -> int array

val iter2i : (int -> elt -> elt -> unit) -> arr -> arr -> unit

val iter2 : (elt -> elt -> unit) -> arr -> arr -> unit

val map2i : (int -> elt -> elt -> elt) -> arr -> arr -> arr

val map2 : (elt -> elt -> elt) -> arr -> arr -> arr

val iteri_nd :(int array -> elt -> unit) -> arr -> unit

val mapi_nd : (int array -> elt -> elt) -> arr -> arr

val foldi_nd : ?axis:int -> (int array -> elt -> elt -> elt) -> elt -> arr -> arr

val scani_nd : ?axis:int -> (int array -> elt -> elt -> elt) -> arr -> arr

val filteri_nd : (int array -> elt -> bool) -> arr -> int array array

val iter2i_nd :(int array -> elt -> elt -> unit) -> arr -> arr -> unit

val map2i_nd : (int array -> elt -> elt -> elt) -> arr -> arr -> arr

val iteri_slice : ?axis:int -> (int -> arr -> unit) -> arr -> unit

val iter_slice : ?axis:int -> (arr -> unit) -> arr -> unit

val mapi_slice : ?axis:int -> (int -> arr -> 'c) -> arr -> 'c array

val map_slice : ?axis:int -> (arr -> 'c) -> arr -> 'c array

val filteri_slice : ?axis:int -> (int -> arr -> bool) -> arr -> arr array

val filter_slice : ?axis:int -> (arr -> bool) -> arr -> arr array

val foldi_slice : ?axis:int -> (int -> 'c -> arr -> 'c) -> 'c -> arr -> 'c

val fold_slice : ?axis:int -> ('c -> arr -> 'c) -> 'c -> arr -> 'c


(** {6 Examine array elements or compare two arrays } *)

val exists : (elt -> bool) -> arr -> bool

val not_exists : (elt -> bool) -> arr -> bool

val for_all : (elt -> bool) -> arr -> bool

val is_zero : arr -> bool

val is_positive : arr -> bool

val is_negative : arr -> bool

val is_nonpositive : arr -> bool

val is_nonnegative : arr -> bool

val is_normal : arr -> bool

val not_nan : arr -> bool

val not_inf : arr -> bool

val equal : arr -> arr -> bool

val not_equal : arr -> arr -> bool

val greater : arr -> arr -> bool

val less : arr -> arr -> bool

val greater_equal : arr -> arr -> bool

val less_equal : arr -> arr -> bool

val elt_equal : arr -> arr -> arr

val elt_not_equal : arr -> arr -> arr

val elt_less : arr -> arr -> arr

val elt_greater : arr -> arr -> arr

val elt_less_equal : arr -> arr -> arr

val elt_greater_equal : arr -> arr -> arr

val equal_scalar : arr -> elt -> bool

val not_equal_scalar : arr -> elt -> bool

val less_scalar : arr -> elt -> bool

val greater_scalar : arr -> elt -> bool

val less_equal_scalar : arr -> elt -> bool

val greater_equal_scalar : arr -> elt -> bool

val elt_equal_scalar : arr -> elt -> arr

val elt_not_equal_scalar : arr -> elt -> arr

val elt_less_scalar : arr -> elt -> arr

val elt_greater_scalar : arr -> elt -> arr

val elt_less_equal_scalar : arr -> elt -> arr

val elt_greater_equal_scalar : arr -> elt -> arr

val approx_equal : ?eps:float -> arr -> arr -> bool

val approx_equal_scalar : ?eps:float -> arr -> elt -> bool

val approx_elt_equal : ?eps:float -> arr -> arr -> arr

val approx_elt_equal_scalar : ?eps:float -> arr -> elt -> arr


(** {6 Input/Output functions} *)

val of_array : elt array -> int array -> arr

val to_array : arr -> elt array

val print : ?max_row:int -> ?max_col:int -> ?header:bool -> ?fmt:(elt -> string) -> arr -> unit

val save : arr -> string -> unit

val load : string -> arr


(** {6 Unary mathematical operations } *)

val sum : ?axis:int -> arr -> arr

val sum': arr -> elt

val prod : ?axis:int -> arr -> arr

val prod' : arr -> elt

val mean : ?axis:int -> arr -> arr

val mean': arr -> elt

val var : ?axis:int -> arr -> arr

val var': arr -> elt

val std : ?axis:int -> arr -> arr

val std': arr -> elt

val min : ?axis:int -> arr -> arr

val min' : arr -> elt

val max : ?axis:int -> arr -> arr

val max' : arr -> elt

val minmax : ?axis:int -> arr -> arr * arr

val minmax' : arr -> elt * elt

val min_i : arr -> elt * int array

val max_i : arr -> elt * int array

val minmax_i : arr -> (elt * (int array)) * (elt * (int array))

val abs : arr -> arr

val abs2 : arr -> arr

val conj : arr -> arr

val neg : arr -> arr

val reci : arr -> arr

val reci_tol : ?tol:elt -> arr -> arr

val signum : arr -> arr

val sqr : arr -> arr

val sqrt : arr -> arr

val cbrt : arr -> arr

val exp : arr -> arr

val exp2 : arr -> arr

val exp10 : arr -> arr

val expm1 : arr -> arr

val log : arr -> arr

val log10 : arr -> arr

val log2 : arr -> arr

val log1p : arr -> arr

val sin : arr -> arr

val cos : arr -> arr

val tan : arr -> arr

val asin : arr -> arr

val acos : arr -> arr

val atan : arr -> arr

val sinh : arr -> arr

val cosh : arr -> arr

val tanh : arr -> arr

val asinh : arr -> arr

val acosh : arr -> arr

val atanh : arr -> arr

val floor : arr -> arr

val ceil : arr -> arr

val round : arr -> arr

val trunc : arr -> arr

val fix : arr -> arr

val modf : arr -> arr * arr

val erf : arr -> arr

val erfc : arr -> arr

val logistic : arr -> arr

val relu : arr -> arr

val elu : ?alpha:elt -> arr -> arr

val leaky_relu : ?alpha:elt -> arr -> arr

val softplus : arr -> arr

val softsign : arr -> arr

val softmax : ?axis:int -> arr -> arr

val sigmoid : arr -> arr

val log_sum_exp' : arr -> float

val l1norm : ?axis:int -> arr -> arr

val l1norm' : arr -> elt

val l2norm : ?axis:int -> arr -> arr

val l2norm' : arr -> elt

val l2norm_sqr : ?axis:int -> arr -> arr

val l2norm_sqr' : arr -> elt

val vecnorm : ?axis:int -> ?p:float -> arr -> arr

val vecnorm' : ?p:float -> arr -> elt

val cumsum : ?axis:int -> arr -> arr

val cumprod : ?axis:int -> arr -> arr

val cummin : ?axis:int -> arr -> arr

val cummax : ?axis:int -> arr -> arr

val diff : ?axis:int -> ?n:int -> arr -> arr


(** {6 Binary mathematical operations } *)

val add : arr -> arr -> arr

val sub : arr -> arr -> arr

val mul : arr -> arr -> arr

val div : arr -> arr -> arr

val add_scalar : arr -> elt -> arr

val sub_scalar : arr -> elt -> arr

val mul_scalar : arr -> elt -> arr

val div_scalar : arr -> elt -> arr

val scalar_add : elt -> arr -> arr

val scalar_sub : elt -> arr -> arr

val scalar_mul : elt -> arr -> arr

val scalar_div : elt -> arr -> arr

val pow : arr -> arr -> arr

val scalar_pow : elt -> arr -> arr

val pow_scalar : arr -> elt -> arr

val atan2 : arr -> arr -> arr

val scalar_atan2 : elt -> arr -> arr

val atan2_scalar : arr -> elt -> arr

val hypot : arr -> arr -> arr

val min2 : arr -> arr -> arr

val max2 : arr -> arr -> arr

val fmod : arr -> arr -> arr

val fmod_scalar : arr -> elt -> arr

val scalar_fmod : elt -> arr -> arr

val ssqr' : arr -> elt -> elt

val ssqr_diff' : arr -> arr -> elt

val cross_entropy' : arr -> arr -> float

val clip_by_value : ?amin:elt -> ?amax:elt -> arr -> arr

val clip_by_l2norm : float -> arr -> arr


(** {6 Neural network related functions} *)

val conv1d : ?padding:padding -> arr -> arr -> int array -> arr

val conv2d : ?padding:padding -> arr -> arr -> int array -> arr

val conv3d : ?padding:padding -> arr -> arr -> int array -> arr

val atrous_conv1d : ?padding:padding -> ?stride:int array -> arr -> arr -> int -> arr

val atrous_conv2d : ?padding:padding -> ?stride:int array -> arr -> arr -> int -> arr

val atrous_conv3d : ?padding:padding -> ?stride:int array -> arr -> arr -> int -> arr

val transpose_conv1d : ?padding:padding -> arr -> arr -> int array -> arr

val transpose_conv2d : ?padding:padding -> arr -> arr -> int array -> arr

val transpose_conv3d : ?padding:padding -> arr -> arr -> int array -> arr

val max_pool1d : ?padding:padding -> arr -> int array -> int array -> arr

val max_pool2d : ?padding:padding -> arr -> int array -> int array -> arr

val max_pool3d : ?padding:padding -> arr -> int array -> int array -> arr

val avg_pool1d : ?padding:padding -> arr -> int array -> int array -> arr

val avg_pool2d : ?padding:padding -> arr -> int array -> int array -> arr

val avg_pool3d : ?padding:padding -> arr -> int array -> int array -> arr

val max_pool2d_argmax : ?padding:padding -> arr -> int array -> int array -> arr * (int64, int64_elt, c_layout) Genarray.t

val conv1d_backward_input : arr -> arr -> int array -> arr -> arr

val conv1d_backward_kernel : arr -> arr -> int array -> arr -> arr

val conv2d_backward_input : arr -> arr -> int array -> arr -> arr

val conv2d_backward_kernel : arr -> arr -> int array -> arr -> arr

val conv3d_backward_input : arr -> arr -> int array -> arr -> arr

val conv3d_backward_kernel : arr -> arr -> int array -> arr -> arr

val atrous_conv1d_backward_input : ?stride:int array -> arr -> arr -> arr -> int -> arr

val atrous_conv1d_backward_kernel : ?stride:int array -> arr -> arr -> arr -> int -> arr

val atrous_conv2d_backward_input : ?stride:int array -> arr -> arr -> arr -> int -> arr

val atrous_conv2d_backward_kernel : ?stride:int array -> arr -> arr -> arr -> int -> arr

val atrous_conv3d_backward_input : ?stride:int array -> arr -> arr -> arr -> int -> arr

val atrous_conv3d_backward_kernel : ?stride:int array -> arr -> arr -> arr -> int -> arr

val transpose_conv1d_backward_input : arr -> arr -> int array -> arr -> arr

val transpose_conv1d_backward_kernel : arr -> arr -> int array -> arr -> arr

val transpose_conv2d_backward_input : arr -> arr -> int array -> arr -> arr

val transpose_conv2d_backward_kernel : arr -> arr -> int array -> arr -> arr

val transpose_conv3d_backward_input : arr -> arr -> int array -> arr -> arr

val transpose_conv3d_backward_kernel : arr -> arr -> int array -> arr -> arr

val max_pool1d_backward : padding -> arr -> int array -> int array -> arr -> arr

val max_pool2d_backward : padding -> arr -> int array -> int array -> arr -> arr

val max_pool3d_backward : padding -> arr -> int array -> int array -> arr -> arr

val avg_pool1d_backward : padding -> arr -> int array -> int array -> arr -> arr

val avg_pool2d_backward : padding -> arr -> int array -> int array -> arr -> arr

val avg_pool3d_backward : padding -> arr -> int array -> int array -> arr -> arr


(** {6 Tensor Calculus}  *)

val contract1 : (int * int) array -> arr -> arr

val contract2 : (int * int) array -> arr -> arr -> arr


(** {6 Experimental functions} *)

val one_hot : int -> arr -> arr

val sum_slices : ?axis:int -> arr -> arr

val sum_reduce : ?axis:int array -> arr -> arr

val slide : ?axis:int -> ?ofs:int -> ?step:int -> window:int -> arr -> arr


(** {6 Fucntions of in-place modification } *)

val sort_ : arr -> unit

val add_ : arr -> arr -> unit

val sub_ : arr -> arr -> unit

val mul_ : arr -> arr -> unit

val div_ : arr -> arr -> unit

val pow_ : arr -> arr -> unit

val atan2_ : arr -> arr -> unit

val hypot_ : arr -> arr -> unit

val fmod_ : arr -> arr -> unit

val min2_ : arr -> arr -> unit

val max2_ : arr -> arr -> unit

val add_scalar_ : arr -> elt -> unit

val sub_scalar_ : arr -> elt -> unit

val mul_scalar_ : arr -> elt -> unit

val div_scalar_ : arr -> elt -> unit

val pow_scalar_ : arr -> elt -> unit

val atan2_scalar_ : arr -> elt -> unit

val fmod_scalar_ : arr -> elt -> unit

val scalar_add_ : elt -> arr -> unit

val scalar_sub_ : elt -> arr -> unit

val scalar_mul_ : elt -> arr -> unit

val scalar_div_ : elt -> arr -> unit

val scalar_pow_ : elt -> arr -> unit

val scalar_atan2_ : elt -> arr -> unit

val scalar_fmod_ : elt -> arr -> unit

val conj_ : arr -> unit

val abs_ : arr -> unit

val neg_ : arr -> unit

val reci_ : arr -> unit

val signum_ : arr -> unit

val sqr_ : arr -> unit

val sqrt_ : arr -> unit

val cbrt_ : arr -> unit

val exp_ : arr -> unit

val exp2_ : arr -> unit

val exp10_ : arr -> unit

val expm1_ : arr -> unit

val log_ : arr -> unit

val log2_ : arr -> unit

val log10_ : arr -> unit

val log1p_ : arr -> unit

val sin_ : arr -> unit

val cos_ : arr -> unit

val tan_ : arr -> unit

val asin_ : arr -> unit

val acos_ : arr -> unit

val atan_ : arr -> unit

val sinh_ : arr -> unit

val cosh_ : arr -> unit

val tanh_ : arr -> unit

val asinh_ : arr -> unit

val acosh_ : arr -> unit

val atanh_ : arr -> unit

val floor_ : arr -> unit

val ceil_ : arr -> unit

val round_ : arr -> unit

val trunc_ : arr -> unit

val fix_ : arr -> unit

val erf_ : arr -> unit

val erfc_ : arr -> unit

val relu_ : arr -> unit

val softplus_ : arr -> unit

val softsign_ : arr -> unit

val sigmoid_ : arr -> unit

val softmax_ : ?axis:int -> arr -> unit

val cumsum_ : ?axis:int -> arr -> unit

val cumprod_ : ?axis:int -> arr -> unit

val cummin_ : ?axis:int -> arr -> unit

val cummax_ : ?axis:int -> arr -> unit

val dropout_ : ?rate:float -> arr -> unit

val elt_equal_ : arr -> arr -> unit

val elt_not_equal_ : arr -> arr -> unit

val elt_less_ : arr -> arr -> unit

val elt_greater_ : arr -> arr -> unit

val elt_less_equal_ : arr -> arr -> unit

val elt_greater_equal_ : arr -> arr -> unit

val elt_equal_scalar_ : arr -> elt -> unit

val elt_not_equal_scalar_ : arr -> elt -> unit

val elt_less_scalar_ : arr -> elt -> unit

val elt_greater_scalar_ : arr -> elt -> unit

val elt_less_equal_scalar_ : arr -> elt -> unit

val elt_greater_equal_scalar_ : arr -> elt -> unit


(** {6 Matrix functions} *)

val row : arr -> int -> arr

val col : arr -> int -> arr

val rows : arr -> int array -> arr

val cols : arr -> int array -> arr

val copy_row_to : arr -> arr -> int -> unit

val copy_col_to : arr -> arr -> int -> unit

val row_num : arr -> int

val col_num : arr -> int

val dot : arr -> arr -> arr

val trace : arr -> elt

val to_rows : arr -> arr array

val of_rows : arr array -> arr

val to_cols : arr -> arr array

val of_cols : arr array -> arr

val to_arrays : arr -> elt array array

val of_arrays : elt array array -> arr

val draw_rows : ?replacement:bool -> arr -> int -> arr * int array

val draw_cols : ?replacement:bool -> arr -> int -> arr * int array

val draw_rows2 : ?replacement:bool -> arr -> arr -> int -> arr * arr * int array

val draw_cols2 : ?replacement:bool -> arr -> arr -> int -> arr * arr * int array
