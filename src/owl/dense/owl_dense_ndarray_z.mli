(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types


(** {6 Types and constants} *)

type elt = Complex.t

type arr = (Complex.t, complex64_elt, c_layout) Genarray.t

type cast_arr = (float, float64_elt, c_layout) Genarray.t

val number : number


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

val complex : cast_arr -> cast_arr -> arr

val polar : cast_arr -> cast_arr -> arr


(** {6 Obtain basic properties} *)

val shape : arr -> int array

val num_dims : arr -> int

val nth_dim : arr -> int -> int

val numel : arr -> int

val nnz : arr -> int

val density : arr -> float

val size_in_bytes : arr -> int

val same_shape : arr -> arr -> bool

val same_data : arr -> arr -> bool

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

val repeat : arr -> int array -> arr

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

val min : ?axis:int -> arr -> arr

val min' : arr -> elt

val max : ?axis:int -> arr -> arr

val max' : arr -> elt

val minmax : ?axis:int -> arr -> arr * arr

val minmax' : arr -> elt * elt

val min_i : arr -> elt * int array

val max_i : arr -> elt * int array

val minmax_i : arr -> (elt * (int array)) * (elt * (int array))

val re : arr -> cast_arr

val im : arr -> cast_arr

val sum': arr -> elt

val sum : ?axis:int -> arr -> arr

val prod' : arr -> elt

val prod : ?axis:int -> arr -> arr

val mean : ?axis:int -> arr -> arr

val mean': arr -> elt

val var : ?axis:int -> arr -> arr

val var': arr -> elt

val std : ?axis:int -> arr -> arr

val std': arr -> elt

val abs : arr -> arr

val abs2 : arr -> arr

val conj : arr -> arr

val neg : arr -> arr

val reci : arr -> arr

val reci_tol : ?tol:elt -> arr -> arr

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

val angle : arr -> arr

val proj : arr -> arr


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

val ssqr' : arr -> elt -> elt

val ssqr_diff' : arr -> arr -> elt

val min2 : arr -> arr -> arr

val max2 : arr -> arr -> arr

val pow : arr -> arr -> arr

val scalar_pow : elt -> arr -> arr

val pow_scalar : arr -> elt -> arr

val clip_by_value : ?amin:elt -> ?amax:elt -> arr -> arr

val fma : arr -> arr -> arr -> arr


(** {6 Neural network related functions} *)

val conv1d : ?padding:padding -> arr -> arr -> int array -> arr

val conv2d : ?padding:padding -> arr -> arr -> int array -> arr

val conv3d : ?padding:padding -> arr -> arr -> int array -> arr

val dilated_conv1d : ?padding:padding -> arr -> arr -> int array -> int array -> arr

val dilated_conv2d : ?padding:padding -> arr -> arr -> int array -> int array -> arr

val dilated_conv3d : ?padding:padding -> arr -> arr -> int array -> int array -> arr

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

val upsampling2d : arr -> int array -> arr

val conv1d_backward_input : arr -> arr -> int array -> arr -> arr

val conv1d_backward_kernel : arr -> arr -> int array -> arr -> arr

val conv2d_backward_input : arr -> arr -> int array -> arr -> arr

val conv2d_backward_kernel : arr -> arr -> int array -> arr -> arr

val conv3d_backward_input : arr -> arr -> int array -> arr -> arr

val conv3d_backward_kernel : arr -> arr -> int array -> arr -> arr

val dilated_conv1d_backward_input : arr -> arr -> int array -> int array -> arr -> arr

val dilated_conv1d_backward_kernel : arr -> arr -> int array -> int array -> arr -> arr

val dilated_conv2d_backward_input : arr -> arr -> int array -> int array -> arr -> arr

val dilated_conv2d_backward_kernel : arr -> arr -> int array -> int array -> arr -> arr

val dilated_conv3d_backward_input : arr -> arr -> int array -> int array -> arr -> arr

val dilated_conv3d_backward_kernel : arr -> arr -> int array -> int array -> arr -> arr

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

val upsampling2d_backward : arr -> int array -> arr -> arr


(** {6 Tensor Calculus}  *)

val contract1 : (int * int) array -> arr -> arr

val contract2 : (int * int) array -> arr -> arr -> arr


(** {6 Experimental functions} *)

val one_hot : int -> arr -> arr

val sum_slices : ?axis:int -> arr -> arr

val sum_reduce : ?axis:int array -> arr -> arr

val slide : ?axis:int -> ?ofs:int -> ?step:int -> window:int -> arr -> arr


(** {6 Fucntions of in-place modification } *)

val create_ : out:arr -> elt -> unit

val uniform_ : ?a:elt -> ?b:elt -> out:arr -> unit

val gaussian_ : ?mu:elt -> ?sigma:elt -> out:arr -> unit

val sequential_ :?a:elt -> ?step:elt -> out:arr -> unit

val bernoulli_ : ?p:float -> out:arr -> unit

val zeros_ : out:arr -> unit

val ones_ : out:arr -> unit

val sort_ : arr -> unit

val get_fancy_ : out:arr -> index list -> arr -> unit

val set_fancy_ : out:arr -> index list -> arr -> arr -> unit

val get_slice_ : out:arr -> int list list -> arr -> unit

val set_slice_ : out:arr -> int list list -> arr -> arr -> unit

val copy_ : out:arr -> arr -> unit

val reshape_ : out:arr -> arr -> unit

val reverse_ : out:arr -> arr -> unit

val transpose_ : out:arr -> ?axis:int array -> arr -> unit

val repeat_ : out:arr -> arr -> int array -> unit

val tile_ : out:arr -> arr -> int array -> unit

val pad_ : out:arr -> ?v:elt -> int list list -> arr -> unit

val sum_ : out:arr -> axis:int -> arr -> unit

val min_ : out:arr -> axis:int -> arr -> unit

val max_ : out:arr -> axis:int -> arr -> unit

val add_ : ?out:arr -> arr -> arr -> unit

val sub_ : ?out:arr -> arr -> arr -> unit

val mul_ : ?out:arr -> arr -> arr -> unit

val div_ : ?out:arr -> arr -> arr -> unit

val pow_ : ?out:arr -> arr -> arr -> unit

val atan2_ : ?out:arr -> arr -> arr -> unit

val hypot_ : ?out:arr -> arr -> arr -> unit

val fmod_ : ?out:arr -> arr -> arr -> unit

val min2_ : ?out:arr -> arr -> arr -> unit

val max2_ : ?out:arr -> arr -> arr -> unit

val add_scalar_ : ?out:arr -> arr -> elt -> unit

val sub_scalar_ : ?out:arr -> arr -> elt -> unit

val mul_scalar_ : ?out:arr -> arr -> elt -> unit

val div_scalar_ : ?out:arr -> arr -> elt -> unit

val pow_scalar_ : ?out:arr -> arr -> elt -> unit

val atan2_scalar_ : ?out:arr -> arr -> elt -> unit

val fmod_scalar_ : ?out:arr -> arr -> elt -> unit

val scalar_add_ : ?out:arr -> elt -> arr -> unit

val scalar_sub_ : ?out:arr -> elt -> arr -> unit

val scalar_mul_ : ?out:arr -> elt -> arr -> unit

val scalar_div_ : ?out:arr -> elt -> arr -> unit

val scalar_pow_ : ?out:arr -> elt -> arr -> unit

val scalar_atan2_ : ?out:arr -> elt -> arr -> unit

val scalar_fmod_ : ?out:arr -> elt -> arr -> unit

val fma_ : ?out:arr -> arr -> arr -> arr -> unit

val clip_by_value_ : ?out:arr -> ?amin:elt -> ?amax:elt -> arr -> unit

val clip_by_l2norm_ : ?out:arr -> elt -> arr -> unit

val dot_ : ?transa:bool -> ?transb:bool -> ?alpha:elt -> ?beta:elt -> c:arr -> arr -> arr -> unit

val conj_ : ?out:arr -> arr -> unit

val abs_ : ?out:arr -> arr -> unit

val neg_ : ?out:arr -> arr -> unit

val reci_ : ?out:arr -> arr -> unit

val signum_ : ?out:arr -> arr -> unit

val sqr_ : ?out:arr -> arr -> unit

val sqrt_ : ?out:arr -> arr -> unit

val cbrt_ : ?out:arr -> arr -> unit

val exp_ : ?out:arr -> arr -> unit

val exp2_ : ?out:arr -> arr -> unit

val exp10_ : ?out:arr -> arr -> unit

val expm1_ : ?out:arr -> arr -> unit

val log_ : ?out:arr -> arr -> unit

val log2_ : ?out:arr -> arr -> unit

val log10_ : ?out:arr -> arr -> unit

val log1p_ : ?out:arr -> arr -> unit

val sin_ : ?out:arr -> arr -> unit

val cos_ : ?out:arr -> arr -> unit

val tan_ : ?out:arr -> arr -> unit

val asin_ : ?out:arr -> arr -> unit

val acos_ : ?out:arr -> arr -> unit

val atan_ : ?out:arr -> arr -> unit

val sinh_ : ?out:arr -> arr -> unit

val cosh_ : ?out:arr -> arr -> unit

val tanh_ : ?out:arr -> arr -> unit

val asinh_ : ?out:arr -> arr -> unit

val acosh_ : ?out:arr -> arr -> unit

val atanh_ : ?out:arr -> arr -> unit

val floor_ : ?out:arr -> arr -> unit

val ceil_ : ?out:arr -> arr -> unit

val round_ : ?out:arr -> arr -> unit

val trunc_ : ?out:arr -> arr -> unit

val fix_ : ?out:arr -> arr -> unit

val erf_ : ?out:arr -> arr -> unit

val erfc_ : ?out:arr -> arr -> unit

val relu_ : ?out:arr -> arr -> unit

val softplus_ : ?out:arr -> arr -> unit

val softsign_ : ?out:arr -> arr -> unit

val sigmoid_ : ?out:arr -> arr -> unit

val cumsum_ : ?out:arr -> ?axis:int -> arr -> unit

val cumprod_ : ?out:arr -> ?axis:int -> arr -> unit

val cummin_ : ?out:arr -> ?axis:int -> arr -> unit

val cummax_ : ?out:arr -> ?axis:int -> arr -> unit

val dropout_ : ?out:arr -> ?rate:float -> arr -> unit

val elt_equal_ : ?out:arr -> arr -> arr -> unit

val elt_not_equal_ : ?out:arr -> arr -> arr -> unit

val elt_less_ : ?out:arr -> arr -> arr -> unit

val elt_greater_ : ?out:arr -> arr -> arr -> unit

val elt_less_equal_ : ?out:arr -> arr -> arr -> unit

val elt_greater_equal_ : ?out:arr -> arr -> arr -> unit

val elt_equal_scalar_ : ?out:arr -> arr -> elt -> unit

val elt_not_equal_scalar_ : ?out:arr -> arr -> elt -> unit

val elt_less_scalar_ : ?out:arr -> arr -> elt -> unit

val elt_greater_scalar_ : ?out:arr -> arr -> elt -> unit

val elt_less_equal_scalar_ : ?out:arr -> arr -> elt -> unit

val elt_greater_equal_scalar_ : ?out:arr -> arr -> elt -> unit

val conv1d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> unit

val conv2d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> unit

val conv3d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> unit

val dilated_conv1d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> int array -> unit

val dilated_conv2d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> int array -> unit

val dilated_conv3d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> int array -> unit

val transpose_conv1d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> unit

val transpose_conv2d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> unit

val transpose_conv3d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> unit

val max_pool1d_ : out:arr -> ?padding:padding -> arr -> int array -> int array -> unit

val max_pool2d_ : out:arr -> ?padding:padding -> arr -> int array -> int array -> unit

val max_pool3d_ : out:arr -> ?padding:padding -> arr -> int array -> int array -> unit

val avg_pool1d_ : out:arr -> ?padding:padding -> arr -> int array -> int array -> unit

val avg_pool2d_ : out:arr -> ?padding:padding -> arr -> int array -> int array -> unit

val avg_pool3d_ : out:arr -> ?padding:padding -> arr -> int array -> int array -> unit

val upsampling2d_ : out:arr -> arr -> int array -> unit

val conv1d_backward_input_ : out:arr -> arr -> arr -> int array -> arr -> unit

val conv1d_backward_kernel_ : out:arr -> arr -> arr -> int array -> arr -> unit

val conv2d_backward_input_ : out:arr -> arr -> arr -> int array -> arr -> unit

val conv2d_backward_kernel_ : out:arr -> arr -> arr -> int array -> arr -> unit

val conv3d_backward_input_ : out:arr -> arr -> arr -> int array -> arr -> unit

val conv3d_backward_kernel_ : out:arr -> arr -> arr -> int array -> arr -> unit

val dilated_conv1d_backward_input_ : out:arr -> arr -> arr -> int array -> int array -> arr -> unit

val dilated_conv1d_backward_kernel_ : out:arr -> arr -> arr -> int array -> int array -> arr -> unit

val dilated_conv2d_backward_input_ : out:arr -> arr -> arr -> int array -> int array -> arr -> unit

val dilated_conv2d_backward_kernel_ : out:arr -> arr -> arr -> int array -> int array -> arr -> unit

val dilated_conv3d_backward_input_ : out:arr -> arr -> arr -> int array -> int array -> arr -> unit

val dilated_conv3d_backward_kernel_ : out:arr -> arr -> arr -> int array -> int array -> arr -> unit

val transpose_conv1d_backward_input_ : out:arr -> arr -> arr -> int array -> arr -> unit

val transpose_conv1d_backward_kernel_ : out:arr -> arr -> arr -> int array -> arr -> unit

val transpose_conv2d_backward_input_ : out:arr -> arr -> arr -> int array -> arr -> unit

val transpose_conv2d_backward_kernel_ : out:arr -> arr -> arr -> int array -> arr -> unit

val transpose_conv3d_backward_input_ : out:arr -> arr -> arr -> int array -> arr -> unit

val transpose_conv3d_backward_kernel_ : out:arr -> arr -> arr -> int array -> arr -> unit

val max_pool1d_backward_ : out:arr -> padding -> arr -> int array -> int array -> arr -> unit

val max_pool2d_backward_ : out:arr -> padding -> arr -> int array -> int array -> arr -> unit

val max_pool3d_backward_ : out:arr -> padding -> arr -> int array -> int array -> arr -> unit

val avg_pool1d_backward_ : out:arr -> padding -> arr -> int array -> int array -> arr -> unit

val avg_pool2d_backward_ : out:arr -> padding -> arr -> int array -> int array -> arr -> unit

val avg_pool3d_backward_ : out:arr -> padding -> arr -> int array -> int array -> arr -> unit

val upsampling2d_backward_ : out:arr -> arr -> int array -> arr -> unit
