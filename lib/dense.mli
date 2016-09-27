(** [ Dense Matrix ]  *)

type dsmat = Gsl.Matrix.matrix

(* matrix creation operations *)

val empty : int -> int -> dsmat

val create : int -> int -> float -> dsmat

val zeros : int -> int -> dsmat

val ones : int -> int -> dsmat

val eye : int -> dsmat

val identity : int -> dsmat

val sequential : int -> int -> dsmat

val uniform_int : ?a:int -> ?b:int -> int -> int -> dsmat

val uniform : ?scale:float -> int -> int -> dsmat

val gaussian : ?sigma:float -> int -> int -> dsmat

val semidef : int -> dsmat
(** [ semidef n ] genereates a n x n positive semi-definite dsmatrix *)

val vector : int -> dsmat

val vector_zeros : int -> dsmat

val vector_ones : int -> dsmat

val vector_uniform : int -> dsmat

val linspace : float -> float -> int -> dsmat
(** [ linspace a b n ] generates linearly spaced interval *)

val meshgrid : float -> float -> float -> float -> int -> int -> dsmat * dsmat

val meshup : dsmat -> dsmat -> dsmat * dsmat

(* dsmatrix manipulations functions *)

val shape : dsmat -> int * int

val row_num : dsmat -> int

val col_num : dsmat -> int

val numel : dsmat -> int

val same_shape : dsmat -> dsmat -> bool

val reshape : int -> int -> dsmat -> dsmat

val row : dsmat -> int -> dsmat

val col : dsmat -> int -> dsmat

val rows : dsmat -> int array -> dsmat

val cols : dsmat -> int array -> dsmat

val clone : dsmat -> dsmat

val copy_to : dsmat -> dsmat -> unit

val copy_row_to : dsmat -> dsmat -> int -> unit

val copy_col_to : dsmat -> dsmat -> int -> unit

val concat_vertical : dsmat -> dsmat -> dsmat

val concat_horizontal : dsmat -> dsmat -> dsmat

val transpose : dsmat -> dsmat

val draw_rows : ?replacement:bool -> dsmat -> int -> dsmat * int array

val draw_cols : ?replacement:bool -> dsmat -> int -> dsmat * int array

val shuffle_rows : dsmat -> dsmat

val shuffle_cols : dsmat -> dsmat

val shuffle_all: dsmat -> dsmat

val replace_row : dsmat -> dsmat -> int -> dsmat

val replace_col : dsmat -> dsmat -> int -> dsmat

(* dsmatrix iteration operations *)

val iter : (float -> 'a) -> dsmat -> unit

val iteri : (int -> int -> float -> 'a) -> dsmat -> unit

val map : (float -> float) -> dsmat -> dsmat

val mapi : (int -> int -> float -> float) -> dsmat -> dsmat

val filter : (float -> bool) -> dsmat -> (int * int) array

val filteri : (int -> int -> float -> bool) -> dsmat -> (int * int) array

val fold : ('a -> float -> 'a) -> 'a -> dsmat -> 'a

val iter_rows : (dsmat -> 'a) -> dsmat -> unit

val iteri_rows : (int -> dsmat -> 'a) -> dsmat -> unit

val map_rows : (dsmat -> 'a) -> dsmat -> 'a array

val mapi_rows : (int -> dsmat -> 'a) -> dsmat -> 'a array

val mapi_by_row : ?d:int -> (int -> dsmat -> dsmat) -> dsmat -> dsmat

val map_by_row : ?d:int -> (dsmat -> dsmat) -> dsmat -> dsmat

val map_at_row : (float -> float) -> dsmat -> int -> dsmat

val mapi_at_row : (int -> int -> float -> float) -> dsmat -> int -> dsmat

val filter_rows : (dsmat -> bool) -> dsmat -> int array

val filteri_rows : (int -> dsmat -> bool) -> dsmat -> int array

val fold_rows : ('a -> dsmat -> 'a) -> 'a -> dsmat -> 'a

val iter_cols : (dsmat -> 'a) -> dsmat -> unit

val iteri_cols : (int -> dsmat -> 'a) -> dsmat -> unit

val map_cols : (dsmat -> 'a) -> dsmat -> 'a array

val mapi_cols : (int -> dsmat -> 'a) -> dsmat -> 'a array

val mapi_by_col : ?d:int -> (int -> dsmat -> dsmat) -> dsmat -> dsmat

val map_by_col : ?d:int -> (dsmat -> dsmat) -> dsmat -> dsmat

val map_at_col : (float -> float) -> dsmat -> int -> dsmat

val mapi_at_col : (int -> int -> float -> float) -> dsmat -> int -> dsmat

val filter_cols : (dsmat -> bool) -> dsmat -> int array

val filteri_cols : (int -> dsmat -> bool) -> dsmat -> int array

val fold_cols : ('a -> dsmat -> 'a) -> 'a -> dsmat -> 'a

val exists : (float -> bool) -> dsmat -> bool

val not_exists : (float -> bool) -> dsmat -> bool

val for_all : (float -> bool) -> dsmat -> bool

(* functions for comparing two dsmatrices *)

val is_equal : dsmat -> dsmat -> bool

val is_unequal : dsmat -> dsmat -> bool

val is_greater : dsmat -> dsmat -> bool

val is_smaller : dsmat -> dsmat -> bool

val equal_or_greater : dsmat -> dsmat -> bool

val equal_or_smaller : dsmat -> dsmat -> bool

(* basic arithmetic functions *)

val add : dsmat -> dsmat -> dsmat

val sub : dsmat -> dsmat -> dsmat

val mul : dsmat -> dsmat -> dsmat

val div : dsmat -> dsmat -> dsmat

val dot : dsmat -> dsmat -> dsmat

val abs : dsmat -> dsmat

val neg : dsmat -> dsmat

val power : dsmat -> float -> dsmat

val add_scalar : dsmat -> float -> dsmat

val sub_scalar : dsmat -> float -> dsmat

val mul_scalar : dsmat -> float -> dsmat

val div_scalar : dsmat -> float -> dsmat

val sum : dsmat -> float

val sum_rows : dsmat -> dsmat

val sum_cols : dsmat -> dsmat

val average : dsmat -> float

val average_rows : dsmat -> dsmat

val average_cols : dsmat -> dsmat

val min : dsmat -> float * int * int

val min_rows : dsmat -> (float * int * int) array

val min_cols : dsmat -> (float * int * int) array

val max : dsmat -> float * int * int

val max_rows : dsmat -> (float * int * int) array

val max_cols : dsmat -> (float * int * int) array

val minmax : dsmat -> float * float * int * int * int * int

val is_zero : dsmat -> bool

val is_positive : dsmat -> bool

val is_negative : dsmat -> bool

val is_nonnegative : dsmat -> bool

(* advanced linear algebra functions *)

val log : dsmat -> dsmat

val log10 : dsmat -> dsmat

val exp : dsmat -> dsmat

val sigmoid : dsmat -> dsmat

val diag : dsmat -> dsmat

val trace : dsmat -> float

val add_diag : dsmat -> float -> dsmat

(* val svd : dsmat -> dsmat -> dsmat -> dsmat *)

(* input and output functions *)

val to_array : dsmat -> float array
(** [ to_array x ] flatten dsmatrix x then return as an array *)

val to_arrays : dsmat -> float array array
(** [ to arrays x ] returns an array of arrays, wherein each row becomes an array *)

val of_array : float array -> int -> int -> dsmat

val of_arrays : float array array -> dsmat

val save : dsmat -> string -> unit

val load : string -> dsmat

val save_txt : dsmat -> string -> unit

val load_txt : string -> dsmat

val print : dsmat -> unit

val pp_dsmat : dsmat -> unit

(* some short-hand infix operators *)

val ( >> ) : dsmat -> dsmat -> unit

val ( << ) : dsmat -> dsmat -> unit

val ( @= ) : dsmat -> dsmat -> dsmat

val ( @|| ) : dsmat -> dsmat -> dsmat

val ( +@ ) : dsmat -> dsmat -> dsmat

val ( -@ ) : dsmat -> dsmat -> dsmat

val ( *@ ) : dsmat -> dsmat -> dsmat

val ( /@ ) : dsmat -> dsmat -> dsmat

val ( $@ ) : dsmat -> dsmat -> dsmat

val ( **@ ) : dsmat -> float -> dsmat

val ( +$ ) : dsmat -> float -> dsmat

val ( -$ ) : dsmat -> float -> dsmat

val ( *$ ) : dsmat -> float -> dsmat

val ( /$ ) : dsmat -> float -> dsmat

val ( $+ ) : float -> dsmat -> dsmat

val ( $- ) : float -> dsmat -> dsmat

val ( $* ) : float -> dsmat -> dsmat

val ( $/ ) : float -> dsmat -> dsmat

val ( =@ ) : dsmat -> dsmat -> bool

val ( >@ ) : dsmat -> dsmat -> bool

val ( <@ ) : dsmat -> dsmat -> bool

val ( <>@ ) : dsmat -> dsmat -> bool

val ( >=@ ) : dsmat -> dsmat -> bool

val ( <=@ ) : dsmat -> dsmat -> bool

val ( @@ ) : (float -> float) -> dsmat -> dsmat

(* TODO: for debug purpose *)

val gsl_col : dsmat -> int -> dsmat
