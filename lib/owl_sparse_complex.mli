(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Complex sparse matrix ] *)

type spmat

type elt = Complex.t


(** {6 Create sparse matrices} *)

val zeros : int -> int -> spmat

val eye : int -> spmat

val binary : int -> int -> spmat

val uniform : ?scale:float -> int -> int -> spmat

val uniform_int : ?a:int -> ?b:int -> int -> int -> spmat


(** {6 Obtain the basic properties of a matrix} *)

val shape : spmat -> int * int

val row_num : spmat -> int

val col_num : spmat -> int

val numel : spmat -> int

val nnz : spmat -> int

val nnz_rows : spmat -> int array

val nnz_cols : spmat -> int array

val density : spmat -> float


(** {6 Manipulate a matrix} *)

val set : spmat -> int -> int -> elt -> unit

val get : spmat -> int -> int -> elt

val reset : spmat -> unit

val clone : spmat -> spmat

(* val transpose : spmat -> spmat *)

val diag : spmat -> spmat

val trace : spmat -> elt

val row : spmat -> int -> spmat

val col : spmat -> int -> spmat

val rows : spmat -> int array -> spmat

val cols : spmat -> int array -> spmat


(** {6 Iterate elements, columns, and rows} *)

val iteri : (int -> int -> elt -> 'a) -> spmat -> unit

val iter : (elt -> 'a) -> spmat -> unit

val mapi : (int -> int -> elt -> elt) -> spmat -> spmat

val map : (elt -> elt) -> spmat -> spmat

val fold : ('a -> elt -> 'a) -> 'a -> spmat -> 'a

val filteri : (int -> int -> elt -> bool) -> spmat -> (int * int) array

val filter : (elt -> bool) -> spmat -> (int * int) array

val iteri_rows : (int -> spmat -> unit) -> spmat -> unit

val iter_rows : (spmat -> unit) -> spmat -> unit

val iteri_cols : (int -> spmat -> unit) -> spmat -> unit

val iter_cols : (spmat -> unit) -> spmat -> unit

val mapi_rows : (int -> spmat -> 'a) -> spmat -> 'a array

val map_rows : (spmat -> 'a) -> spmat -> 'a array

val mapi_cols : (int -> spmat -> 'a) -> spmat -> 'a array

val map_cols : (spmat -> 'a) -> spmat -> 'a array

val fold_rows : ('a -> spmat -> 'a) -> 'a -> spmat -> 'a

val fold_cols : ('a -> spmat -> 'a) -> 'a -> spmat -> 'a

val iteri_nz : (int -> int -> elt -> 'a) -> spmat -> unit

val iter_nz : (elt -> 'a) -> spmat -> unit

val mapi_nz : (int -> int -> elt -> elt) -> spmat -> spmat

val map_nz : (elt -> elt) -> spmat -> spmat

val fold_nz : ('a -> elt -> 'a) -> 'a -> spmat -> 'a

val filteri_nz : (int -> int -> elt -> bool) -> spmat -> (int * int) array

val filter_nz : (elt -> bool) -> spmat -> (int * int) array

val iteri_rows_nz : (int -> spmat -> unit) -> spmat -> unit

val iter_rows_nz : (spmat -> unit) -> spmat -> unit

val iteri_cols_nz : (int -> spmat -> unit) -> spmat -> unit

val iter_cols_nz : (spmat -> unit) -> spmat -> unit

val mapi_rows_nz : (int -> spmat -> 'a) -> spmat -> 'a array

val map_rows_nz : (spmat -> 'a) -> spmat -> 'a array

val mapi_cols_nz : (int -> spmat -> 'a) -> spmat -> 'a array

val map_cols_nz : (spmat -> 'a) -> spmat -> 'a array

val fold_rows_nz : ('a -> spmat -> 'a) -> 'a -> spmat -> 'a

val fold_cols_nz : ('a -> spmat -> 'a) -> 'a -> spmat -> 'a


(** {6 Examine the elements in a matrix} *)

val exists : (elt -> bool) -> spmat -> bool

val not_exists : (elt -> bool) -> spmat -> bool

val for_all : (elt -> bool) -> spmat -> bool

val exists_nz : (elt -> bool) -> spmat -> bool

val not_exists_nz : (elt -> bool) -> spmat -> bool

val for_all_nz :  (elt -> bool) -> spmat -> bool


(** {6 Basic mathematical operations of matrices} *)

val mul_scalar : spmat -> elt -> spmat

val div_scalar : spmat -> elt -> spmat

val add : spmat -> spmat -> spmat

val sub : spmat -> spmat -> spmat

val mul : spmat -> spmat -> spmat

val div : spmat -> spmat -> spmat

val dot : spmat -> spmat -> spmat

val abs : spmat -> spmat

val neg : spmat -> spmat

val sum : spmat -> elt

val average : spmat -> elt

val power : spmat -> elt -> spmat

val is_zero : spmat -> bool

val is_positive : spmat -> bool

val is_negative : spmat -> bool

val is_nonnegative : spmat -> bool

val min : spmat -> elt

val max : spmat -> elt

val minmax : spmat -> elt * elt

val sum_rows : spmat -> spmat

val sum_cols : spmat -> spmat

val average_rows : spmat -> spmat

val average_cols : spmat -> spmat


(** {6 Compare two matrices} *)

val is_equal : spmat -> spmat -> bool

val is_unequal : spmat -> spmat -> bool

val is_greater : spmat -> spmat -> bool

val is_smaller : spmat -> spmat -> bool

val equal_or_greater : spmat -> spmat -> bool

val equal_or_smaller : spmat -> spmat -> bool


(** {6 Randomisation functions} *)

val permutation_matrix : int -> spmat

val draw_rows : ?replacement:bool -> spmat -> int -> spmat * int array

val draw_cols : ?replacement:bool -> spmat -> int -> spmat * int array

val shuffle_rows : spmat -> spmat

val shuffle_cols : spmat -> spmat

val shuffle : spmat -> spmat


(** {6 Input/Output and helper functions} *)

val to_dense : spmat -> Owl_dense_complex.mat

val of_dense : Owl_dense_complex.mat -> spmat

val print : spmat -> unit

val pp_spmat : spmat -> unit

val save : spmat -> string -> unit

val load : string -> spmat


(** {6 Shorhand infix operators} *)

val ( +@ ) : spmat -> spmat -> spmat
(** Shorthand for [add x y], i.e., [x +@ y] *)

val ( -@ ) : spmat -> spmat -> spmat
(** Shorthand for [sub x y], i.e., [x -@ y] *)

val ( *@ ) : spmat -> spmat -> spmat
(** Shorthand for [mul x y], i.e., [x *@ y] *)

val ( /@ ) : spmat -> spmat -> spmat
(** Shorthand for [div x y], i.e., [x /@ y] *)

val ( $@ ) : spmat -> spmat -> spmat
(** Shorthand for [dot x y], i.e., [x $@ y] *)

val ( **@ ) : spmat -> elt -> spmat
(** Shorthand for [power x a], i.e., [x **@ a] *)

val ( *$ ) : spmat -> elt -> spmat
(** Shorthand for [mul_scalar x a], i.e., [x *$ a] *)

val ( /$ ) : spmat -> elt -> spmat
(** Shorthand for [div_scalar x a], i.e., [x /$ a] *)

val ( $* ) : elt -> spmat -> spmat
(** Shorthand for [mul_scalar x a], i.e., [x $* a] *)

val ( $/ ) : elt -> spmat -> spmat
(** Shorthand for [div_scalar x a], i.e., [x $/ a] *)

val ( =@ ) : spmat -> spmat -> bool
(** Shorthand for [is_equal x y], i.e., [x =@ y] *)

val ( >@ ) : spmat -> spmat -> bool
(** Shorthand for [is_greater x y], i.e., [x >@ y] *)

val ( <@ ) : spmat -> spmat -> bool
(** Shorthand for [is_smaller x y], i.e., [x <@ y] *)

val ( <>@ ) : spmat -> spmat -> bool
(** Shorthand for [is_unequal x y], i.e., [x <>@ y] *)

val ( >=@ ) : spmat -> spmat -> bool
(** Shorthand for [equal_or_greater x y], i.e., [x >=@ y] *)

val ( <=@ ) : spmat -> spmat -> bool
(** Shorthand for [equal_or_smaller x y], i.e., [x <=@ y] *)

(* val ( @@ ) : (float -> float) -> dsmat -> dsmat *)



(* TODO: debug purpose *)

val _triplet2crs : spmat -> unit

val _is_triplet : spmat -> bool
