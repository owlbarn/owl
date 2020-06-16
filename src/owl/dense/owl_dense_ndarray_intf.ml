(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_types

module type Common = sig
  include Owl_base_dense_ndarray_intf.Common

  (* NOTE: below are all the functions that have
     not been implemented in Base*)

  (** {6 Create N-dimensional array} *)

  val linspace : elt -> elt -> int -> arr
  (**
``linspace k 0. 9. 10`` ...
 *)

  val logspace : ?base:float -> elt -> elt -> int -> arr
  (**
``logspace k 0. 9. 10`` ...
 *)

  val unit_basis : int -> int -> arr
  (**
``unit_basis k n i`` returns a unit basis vector with ``i``th element set to 1.
 *)

  (** {6 Obtain basic properties} *)

  val num_dims : arr -> int

  val nth_dim : arr -> int -> int

  val nnz : arr -> int

  val density : arr -> float

  val size_in_bytes : arr -> int

  val same_shape : arr -> arr -> bool

  val same_data : arr -> arr -> bool

  val ind : arr -> int -> int array

  val i1d : arr -> int array -> int

  (** {6 Manipulate a N-dimensional array} *)

  val get_index : arr -> int array array -> elt array

  val set_index : arr -> int array array -> elt array -> unit

  val get_fancy : index list -> arr -> arr

  val set_fancy : index list -> arr -> arr -> unit

  val sub_left : arr -> int -> int -> arr

  val sub_ndarray : int array -> arr -> arr array

  val slice_left : arr -> int array -> arr

  val fill : arr -> elt -> unit

  val resize : ?head:bool -> arr -> int array -> arr

  val flip : ?axis:int -> arr -> arr

  val rotate : arr -> int -> arr

  val swap : int -> int -> arr -> arr

  val concat_vertical : arr -> arr -> arr

  val concat_horizontal : arr -> arr -> arr

  val concat_vh : arr array array -> arr

  val split_vh : (int * int) array array -> arr -> arr array array

  val dropout : ?rate:float -> arr -> arr

  val top : arr -> int -> int array array

  val bottom : arr -> int -> int array array

  val sort : arr -> arr

  val sort1 : ?axis:int -> arr -> arr

  val argsort : arr -> (int64, int64_elt, c_layout) Genarray.t

  val mmap : Unix.file_descr -> ?pos:int64 -> bool -> int array -> arr

  (** {6 Iterate array elements} *)

  val iter2i : (int -> elt -> elt -> unit) -> arr -> arr -> unit

  val iter2 : (elt -> elt -> unit) -> arr -> arr -> unit

  val map2i : (int -> elt -> elt -> elt) -> arr -> arr -> arr

  val map2 : (elt -> elt -> elt) -> arr -> arr -> arr

  val iteri_nd : (int array -> elt -> unit) -> arr -> unit

  val mapi_nd : (int array -> elt -> elt) -> arr -> arr

  val foldi_nd : ?axis:int -> (int array -> elt -> elt -> elt) -> elt -> arr -> arr

  val scani_nd : ?axis:int -> (int array -> elt -> elt -> elt) -> arr -> arr

  val filteri_nd : (int array -> elt -> bool) -> arr -> int array array

  val iter2i_nd : (int array -> elt -> elt -> unit) -> arr -> arr -> unit

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

  val approx_equal : ?eps:float -> arr -> arr -> bool

  val approx_equal_scalar : ?eps:float -> arr -> elt -> bool

  val approx_elt_equal : ?eps:float -> arr -> arr -> arr

  val approx_elt_equal_scalar : ?eps:float -> arr -> elt -> arr

  (** {6 Input/Output functions} *)

  val to_array : arr -> elt array

  val save : out:string -> arr -> unit

  val load : string -> arr

  val save_npy : out:string -> arr -> unit

  val load_npy : string -> arr

  (** {6 Unary mathematical operations } *)

  val prod : ?axis:int -> ?keep_dims:bool -> arr -> arr

  val prod' : arr -> elt

  val mean : ?axis:int -> ?keep_dims:bool -> arr -> arr

  val mean' : arr -> elt

  val median' : arr -> elt

  val median : ?axis:int -> ?keep_dims:bool -> arr -> arr

  val var : ?axis:int -> ?keep_dims:bool -> arr -> arr

  val var' : arr -> elt

  val std : ?axis:int -> ?keep_dims:bool -> arr -> arr

  val std' : arr -> elt

  val sem : ?axis:int -> ?keep_dims:bool -> arr -> arr

  val sem' : arr -> elt

  val minmax : ?axis:int -> ?keep_dims:bool -> arr -> arr * arr

  val minmax' : arr -> elt * elt

  val min_i : arr -> elt * int array

  val max_i : arr -> elt * int array

  val minmax_i : arr -> (elt * int array) * (elt * int array)

  val abs2 : arr -> arr

  val conj : arr -> arr

  val reci : arr -> arr

  val reci_tol : ?tol:elt -> arr -> arr

  val cbrt : arr -> arr

  val exp2 : arr -> arr

  val exp10 : arr -> arr

  val expm1 : arr -> arr

  val log1p : arr -> arr

  val trunc : arr -> arr

  val fix : arr -> arr

  val modf : arr -> arr * arr

  val l1norm : ?axis:int -> ?keep_dims:bool -> arr -> arr

  val l1norm' : arr -> elt

  val l2norm : ?axis:int -> ?keep_dims:bool -> arr -> arr

  val l2norm' : arr -> elt

  val l2norm_sqr : ?axis:int -> ?keep_dims:bool -> arr -> arr

  val l2norm_sqr' : arr -> elt

  val vecnorm : ?axis:int -> ?p:float -> ?keep_dims:bool -> arr -> arr

  val vecnorm' : ?p:float -> arr -> elt

  val cumsum : ?axis:int -> arr -> arr

  val cumprod : ?axis:int -> arr -> arr

  val cummin : ?axis:int -> arr -> arr

  val cummax : ?axis:int -> arr -> arr

  val diff : ?axis:int -> ?n:int -> arr -> arr

  val lgamma : arr -> arr

  (** {6 Binary mathematical operations } *)

  val min2 : arr -> arr -> arr

  val max2 : arr -> arr -> arr

  val ssqr' : arr -> elt -> elt

  val ssqr_diff' : arr -> arr -> elt

  val clip_by_value : ?amin:elt -> ?amax:elt -> arr -> arr

  val clip_by_l2norm : elt -> arr -> arr

  (** {6 Tensor Calculus}  *)

  val contract1 : (int * int) array -> arr -> arr

  val contract2 : (int * int) array -> arr -> arr -> arr

  (** {6 Experimental functions} *)

  val sum_slices : ?axis:int -> arr -> arr

  val slide : ?axis:int -> ?ofs:int -> ?step:int -> window:int -> arr -> arr

  (** {6 Functions of in-place modification } *)

  val create_ : out:arr -> elt -> unit

  val uniform_ : ?a:elt -> ?b:elt -> out:arr -> unit

  val gaussian_ : ?mu:elt -> ?sigma:elt -> out:arr -> unit

  val sequential_ : ?a:elt -> ?step:elt -> out:arr -> unit

  val bernoulli_ : ?p:float -> out:arr -> unit

  val zeros_ : out:arr -> unit

  val ones_ : out:arr -> unit

  val sort_ : arr -> unit

  val one_hot_ : out:arr -> int -> arr -> unit

  val get_fancy_ : out:arr -> index list -> arr -> unit

  val set_fancy_ : out:arr -> index list -> arr -> arr -> unit

  val get_slice_ : out:arr -> int list list -> arr -> unit

  val set_slice_ : out:arr -> int list list -> arr -> arr -> unit

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

  val dot_
    :  ?transa:bool
    -> ?transb:bool
    -> ?alpha:elt
    -> ?beta:elt
    -> c:arr
    -> arr
    -> arr
    -> unit

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

  val softmax_ : ?out:arr -> ?axis:int -> arr -> unit

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
  (** {6 Matrix functions} *)

  val col : arr -> int -> arr

  val cols : arr -> int array -> arr

  val dot : arr -> arr -> arr

  val trace : arr -> elt

  val to_arrays : arr -> elt array array

  val draw_rows : ?replacement:bool -> arr -> int -> arr * int array

  val draw_cols : ?replacement:bool -> arr -> int -> arr * int array

  val draw_rows2 : ?replacement:bool -> arr -> arr -> int -> arr * arr * int array

  val draw_cols2 : ?replacement:bool -> arr -> arr -> int -> arr * arr * int array
end

module type Real = sig
  include Owl_base_dense_ndarray_intf.Real

  (* NOTE: below are all the functions that have
     not been implemented in Base*)

  (** {6 Real operations} *)

  val i0 : arr -> arr

  val i0e : arr -> arr

  val i1 : arr -> arr

  val i1e : arr -> arr

  val iv : v:arr -> arr -> arr

  val scalar_iv : v:elt -> arr -> arr

  val iv_scalar : v:arr -> elt -> arr

  val j0 : arr -> arr

  val j1 : arr -> arr

  val jv : v:arr -> arr -> arr

  val scalar_jv : v:elt -> arr -> arr

  val jv_scalar : v:arr -> elt -> arr

  val erf : arr -> arr

  val erfc : arr -> arr

  val logistic : arr -> arr

  val elu : ?alpha:elt -> arr -> arr

  val leaky_relu : ?alpha:elt -> arr -> arr

  val softplus : arr -> arr

  val softsign : arr -> arr

  val softmax : ?axis:int -> arr -> arr

  val sigmoid : arr -> arr

  val log_sum_exp' : arr -> float

  val log_sum_exp : ?axis:int -> ?keep_dims:bool -> arr -> arr

  val scalar_atan2 : elt -> arr -> arr

  val atan2_scalar : arr -> elt -> arr

  val hypot : arr -> arr -> arr

  val fmod : arr -> arr -> arr

  val fmod_scalar : arr -> elt -> arr

  val scalar_fmod : elt -> arr -> arr

  val cross_entropy' : arr -> arr -> float

  val fused_adagrad_ : ?out:arr -> rate:float -> eps:float -> arr -> unit

  val poisson : mu:elt -> int array -> arr

  val poisson_ : mu:elt -> out:arr -> unit
end

module type Complex = sig
  type elt

  type arr

  type cast_arr

  (** {6 Complex operations} *)

  val complex : cast_arr -> cast_arr -> arr
  (**
``complex re im`` constructs a complex ndarray/matrix from ``re`` and ``im``.
``re`` and ``im`` contain the real and imaginary part of ``x`` respectively.

Note that both ``re`` and ``im`` can be complex but must have same type. The real
part of ``re`` will be the real part of ``x`` and the imaginary part of ``im`` will
be the imaginary part of ``x``.
 *)

  val polar : cast_arr -> cast_arr -> arr
  (**
``polar rho theta`` constructs a complex ndarray/matrix from polar
coordinates ``rho`` and ``theta``. ``rho`` contains the magnitudes and ``theta``
contains phase angles. Note that the behaviour is undefined if ``rho`` has
negative elelments or ``theta`` has infinity elelments.
 *)

  val re : arr -> cast_arr

  val im : arr -> cast_arr

  val sum' : arr -> elt
end

module type Distribution = sig
  type arr

  (** {6 Stats & distribution functions} *)

  val uniform_rvs : a:arr -> b:arr -> n:int -> arr

  val uniform_pdf : a:arr -> b:arr -> arr -> arr

  val uniform_logpdf : a:arr -> b:arr -> arr -> arr

  val uniform_cdf : a:arr -> b:arr -> arr -> arr

  val uniform_logcdf : a:arr -> b:arr -> arr -> arr

  val uniform_ppf : a:arr -> b:arr -> arr -> arr

  val uniform_sf : a:arr -> b:arr -> arr -> arr

  val uniform_logsf : a:arr -> b:arr -> arr -> arr

  val uniform_isf : a:arr -> b:arr -> arr -> arr

  val gaussian_rvs : mu:arr -> sigma:arr -> n:int -> arr

  val gaussian_pdf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_logpdf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_cdf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_logcdf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_ppf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_sf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_logsf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_isf : mu:arr -> sigma:arr -> arr -> arr

  val exponential_rvs : lambda:arr -> n:int -> arr

  val exponential_pdf : lambda:arr -> arr -> arr

  val exponential_logpdf : lambda:arr -> arr -> arr

  val exponential_cdf : lambda:arr -> arr -> arr

  val exponential_logcdf : lambda:arr -> arr -> arr

  val exponential_ppf : lambda:arr -> arr -> arr

  val exponential_sf : lambda:arr -> arr -> arr

  val exponential_logsf : lambda:arr -> arr -> arr

  val exponential_isf : lambda:arr -> arr -> arr

  val gamma_rvs : shape:arr -> scale:arr -> n:int -> arr

  val gamma_pdf : shape:arr -> scale:arr -> arr -> arr

  val gamma_logpdf : shape:arr -> scale:arr -> arr -> arr

  val gamma_cdf : shape:arr -> scale:arr -> arr -> arr

  val gamma_logcdf : shape:arr -> scale:arr -> arr -> arr

  val gamma_ppf : shape:arr -> scale:arr -> arr -> arr

  val gamma_sf : shape:arr -> scale:arr -> arr -> arr

  val gamma_logsf : shape:arr -> scale:arr -> arr -> arr

  val gamma_isf : shape:arr -> scale:arr -> arr -> arr

  val beta_rvs : a:arr -> b:arr -> n:int -> arr

  val beta_pdf : a:arr -> b:arr -> arr -> arr

  val beta_logpdf : a:arr -> b:arr -> arr -> arr

  val beta_cdf : a:arr -> b:arr -> arr -> arr

  val beta_logcdf : a:arr -> b:arr -> arr -> arr

  val beta_ppf : a:arr -> b:arr -> arr -> arr

  val beta_sf : a:arr -> b:arr -> arr -> arr

  val beta_logsf : a:arr -> b:arr -> arr -> arr

  val beta_isf : a:arr -> b:arr -> arr -> arr

  val chi2_rvs : df:arr -> n:int -> arr

  val chi2_pdf : df:arr -> arr -> arr

  val chi2_logpdf : df:arr -> arr -> arr

  val chi2_cdf : df:arr -> arr -> arr

  val chi2_logcdf : df:arr -> arr -> arr

  val chi2_ppf : df:arr -> arr -> arr

  val chi2_sf : df:arr -> arr -> arr

  val chi2_logsf : df:arr -> arr -> arr

  val chi2_isf : df:arr -> arr -> arr

  val f_rvs : dfnum:arr -> dfden:arr -> n:int -> arr

  val f_pdf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_logpdf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_cdf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_logcdf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_ppf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_sf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_logsf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_isf : dfnum:arr -> dfden:arr -> arr -> arr

  val cauchy_rvs : loc:arr -> scale:arr -> n:int -> arr

  val cauchy_pdf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_logpdf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_cdf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_logcdf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_ppf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_sf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_logsf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_isf : loc:arr -> scale:arr -> arr -> arr

  val lomax_rvs : shape:arr -> scale:arr -> n:int -> arr

  val lomax_pdf : shape:arr -> scale:arr -> arr -> arr

  val lomax_logpdf : shape:arr -> scale:arr -> arr -> arr

  val lomax_cdf : shape:arr -> scale:arr -> arr -> arr

  val lomax_logcdf : shape:arr -> scale:arr -> arr -> arr

  val lomax_ppf : shape:arr -> scale:arr -> arr -> arr

  val lomax_sf : shape:arr -> scale:arr -> arr -> arr

  val lomax_logsf : shape:arr -> scale:arr -> arr -> arr

  val lomax_isf : shape:arr -> scale:arr -> arr -> arr

  val weibull_rvs : shape:arr -> scale:arr -> n:int -> arr

  val weibull_pdf : shape:arr -> scale:arr -> arr -> arr

  val weibull_logpdf : shape:arr -> scale:arr -> arr -> arr

  val weibull_cdf : shape:arr -> scale:arr -> arr -> arr

  val weibull_logcdf : shape:arr -> scale:arr -> arr -> arr

  val weibull_ppf : shape:arr -> scale:arr -> arr -> arr

  val weibull_sf : shape:arr -> scale:arr -> arr -> arr

  val weibull_logsf : shape:arr -> scale:arr -> arr -> arr

  val weibull_isf : shape:arr -> scale:arr -> arr -> arr

  val laplace_rvs : loc:arr -> scale:arr -> n:int -> arr

  val laplace_pdf : loc:arr -> scale:arr -> arr -> arr

  val laplace_logpdf : loc:arr -> scale:arr -> arr -> arr

  val laplace_cdf : loc:arr -> scale:arr -> arr -> arr

  val laplace_logcdf : loc:arr -> scale:arr -> arr -> arr

  val laplace_ppf : loc:arr -> scale:arr -> arr -> arr

  val laplace_sf : loc:arr -> scale:arr -> arr -> arr

  val laplace_logsf : loc:arr -> scale:arr -> arr -> arr

  val laplace_isf : loc:arr -> scale:arr -> arr -> arr

  val gumbel1_rvs : a:arr -> b:arr -> n:int -> arr

  val gumbel1_pdf : a:arr -> b:arr -> arr -> arr

  val gumbel1_logpdf : a:arr -> b:arr -> arr -> arr

  val gumbel1_cdf : a:arr -> b:arr -> arr -> arr

  val gumbel1_logcdf : a:arr -> b:arr -> arr -> arr

  val gumbel1_ppf : a:arr -> b:arr -> arr -> arr

  val gumbel1_sf : a:arr -> b:arr -> arr -> arr

  val gumbel1_logsf : a:arr -> b:arr -> arr -> arr

  val gumbel1_isf : a:arr -> b:arr -> arr -> arr

  val gumbel2_rvs : a:arr -> b:arr -> n:int -> arr

  val gumbel2_pdf : a:arr -> b:arr -> arr -> arr

  val gumbel2_logpdf : a:arr -> b:arr -> arr -> arr

  val gumbel2_cdf : a:arr -> b:arr -> arr -> arr

  val gumbel2_logcdf : a:arr -> b:arr -> arr -> arr

  val gumbel2_ppf : a:arr -> b:arr -> arr -> arr

  val gumbel2_sf : a:arr -> b:arr -> arr -> arr

  val gumbel2_logsf : a:arr -> b:arr -> arr -> arr

  val gumbel2_isf : a:arr -> b:arr -> arr -> arr

  val logistic_rvs : loc:arr -> scale:arr -> n:int -> arr

  val logistic_pdf : loc:arr -> scale:arr -> arr -> arr

  val logistic_logpdf : loc:arr -> scale:arr -> arr -> arr

  val logistic_cdf : loc:arr -> scale:arr -> arr -> arr

  val logistic_logcdf : loc:arr -> scale:arr -> arr -> arr

  val logistic_ppf : loc:arr -> scale:arr -> arr -> arr

  val logistic_sf : loc:arr -> scale:arr -> arr -> arr

  val logistic_logsf : loc:arr -> scale:arr -> arr -> arr

  val logistic_isf : loc:arr -> scale:arr -> arr -> arr

  val lognormal_rvs : mu:arr -> sigma:arr -> n:int -> arr

  val lognormal_pdf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_logpdf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_cdf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_logcdf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_ppf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_sf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_logsf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_isf : mu:arr -> sigma:arr -> arr -> arr

  val rayleigh_rvs : sigma:arr -> n:int -> arr

  val rayleigh_pdf : sigma:arr -> arr -> arr

  val rayleigh_logpdf : sigma:arr -> arr -> arr

  val rayleigh_cdf : sigma:arr -> arr -> arr

  val rayleigh_logcdf : sigma:arr -> arr -> arr

  val rayleigh_ppf : sigma:arr -> arr -> arr

  val rayleigh_sf : sigma:arr -> arr -> arr

  val rayleigh_logsf : sigma:arr -> arr -> arr

  val rayleigh_isf : sigma:arr -> arr -> arr
end

module type NN = sig
  include Owl_base_dense_ndarray_intf.NN

  (* NOTE: below are all the functions that have
     not been implemented in Base*)

  (** {6 Neural network related functions} *)

  val max_pool2d_argmax
    :  ?padding:padding
    -> arr
    -> int array
    -> int array
    -> arr * (int64, int64_elt, c_layout) Genarray.t

  val conv1d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> unit

  val conv2d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> unit

  val conv3d_ : out:arr -> ?padding:padding -> arr -> arr -> int array -> unit

  val dilated_conv1d_
    :  out:arr
    -> ?padding:padding
    -> arr
    -> arr
    -> int array
    -> int array
    -> unit

  val dilated_conv2d_
    :  out:arr
    -> ?padding:padding
    -> arr
    -> arr
    -> int array
    -> int array
    -> unit

  val dilated_conv3d_
    :  out:arr
    -> ?padding:padding
    -> arr
    -> arr
    -> int array
    -> int array
    -> unit

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

  val dilated_conv1d_backward_input_
    :  out:arr
    -> arr
    -> arr
    -> int array
    -> int array
    -> arr
    -> unit

  val dilated_conv1d_backward_kernel_
    :  out:arr
    -> arr
    -> arr
    -> int array
    -> int array
    -> arr
    -> unit

  val dilated_conv2d_backward_input_
    :  out:arr
    -> arr
    -> arr
    -> int array
    -> int array
    -> arr
    -> unit

  val dilated_conv2d_backward_kernel_
    :  out:arr
    -> arr
    -> arr
    -> int array
    -> int array
    -> arr
    -> unit

  val dilated_conv3d_backward_input_
    :  out:arr
    -> arr
    -> arr
    -> int array
    -> int array
    -> arr
    -> unit

  val dilated_conv3d_backward_kernel_
    :  out:arr
    -> arr
    -> arr
    -> int array
    -> int array
    -> arr
    -> unit

  val transpose_conv1d_backward_input_ : out:arr -> arr -> arr -> int array -> arr -> unit

  val transpose_conv1d_backward_kernel_
    :  out:arr
    -> arr
    -> arr
    -> int array
    -> arr
    -> unit

  val transpose_conv2d_backward_input_ : out:arr -> arr -> arr -> int array -> arr -> unit

  val transpose_conv2d_backward_kernel_
    :  out:arr
    -> arr
    -> arr
    -> int array
    -> arr
    -> unit

  val transpose_conv3d_backward_input_ : out:arr -> arr -> arr -> int array -> arr -> unit

  val transpose_conv3d_backward_kernel_
    :  out:arr
    -> arr
    -> arr
    -> int array
    -> arr
    -> unit

  val max_pool1d_backward_
    :  out:arr
    -> padding
    -> arr
    -> int array
    -> int array
    -> arr
    -> unit

  val max_pool2d_backward_
    :  out:arr
    -> padding
    -> arr
    -> int array
    -> int array
    -> arr
    -> unit

  val max_pool3d_backward_
    :  out:arr
    -> padding
    -> arr
    -> int array
    -> int array
    -> arr
    -> unit

  val avg_pool1d_backward_
    :  out:arr
    -> padding
    -> arr
    -> int array
    -> int array
    -> arr
    -> unit

  val avg_pool2d_backward_
    :  out:arr
    -> padding
    -> arr
    -> int array
    -> int array
    -> arr
    -> unit

  val avg_pool3d_backward_
    :  out:arr
    -> padding
    -> arr
    -> int array
    -> int array
    -> arr
    -> unit

  val upsampling2d_backward_ : out:arr -> arr -> int array -> arr -> unit
end
