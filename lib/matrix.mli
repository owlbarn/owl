(*
 A library for matrix operations
*)

type mat

module Dense : sig

  (* matrix creation operations *)

  val empty : int -> int -> mat

  val create : int -> int -> float -> mat

  val zeros : int -> int -> mat

  val ones : int -> int -> mat

  val eye : int -> mat

  val identity : int -> mat

  val sequential : int -> int -> mat

  val uniform_int : ?a:int -> ?b:int -> int -> int -> mat

  val uniform : ?scale:float -> int -> int -> mat

  val gaussian : ?sigma:float -> int -> int -> mat

  val vector : int -> mat

  val vector_zeros : int -> mat

  val vector_ones : int -> mat

  val vector_uniform : int -> mat

  (* matrix manipulations functions *)

  val shape : mat -> int * int

  val row_num : mat -> int

  val col_num : mat -> int

  val numel : mat -> int

  val same_shape : mat -> mat -> bool

  val row : mat -> int -> mat

  val col : mat -> int -> mat

  val rows : mat -> int array -> mat

  val cols : mat -> int array -> mat

  val clone : mat -> mat

  val copy_to : mat -> mat -> unit

  val copy_row_to : mat -> mat -> int -> unit

  val copy_col_to : mat -> mat -> int -> unit

  val concat_vertical : mat -> mat -> mat

  val concat_horizontal : mat -> mat -> mat

  val transpose : mat -> mat

  val diag : mat -> mat

  val trace : mat -> float

  val add_diag : mat -> float -> mat

  val draw_rows : ?replacement:bool -> mat -> int -> mat

  val draw_cols : ?replacement:bool -> mat -> int -> mat

  (* matrix iteration operations *)

  val iter : (float -> 'a) -> mat -> unit

  val iteri : (int -> int -> float -> 'a) -> mat -> unit

  val map : (float -> float) -> mat -> mat

  val mapi : (int -> int -> float -> float) -> mat -> mat

  val filter : (float -> bool) -> mat -> (int * int) array

  val filteri : (int -> int -> float -> bool) -> mat -> (int * int) array

  val fold : ('a -> float -> 'a) -> 'a -> mat -> 'a

  val iter_rows : (mat -> 'a) -> mat -> unit

  val iteri_rows : (int -> mat -> 'a) -> mat -> unit

  val map_rows : (mat -> 'a) -> mat -> 'a array

  val mapi_rows : (int -> mat -> 'a) -> mat -> 'a array

  val filter_rows : (mat -> bool) -> mat -> int array

  val filteri_rows : (int -> mat -> bool) -> mat -> int array

  val fold_rows : ('a -> mat -> 'a) -> 'a -> mat -> 'a

  val iter_cols : (mat -> 'a) -> mat -> unit

  val iteri_cols : (int -> mat -> 'a) -> mat -> unit

  val map_cols : (mat -> 'a) -> mat -> 'a array

  val mapi_cols : (int -> mat -> 'a) -> mat -> 'a array

  val filter_cols : (mat -> bool) -> mat -> int array

  val filteri_cols : (int -> mat -> bool) -> mat -> int array

  val fold_cols : ('a -> mat -> 'a) -> 'a -> mat -> 'a

  val exists : (float -> bool) -> mat -> bool

  val not_exists : (float -> bool) -> mat -> bool

  val for_all : (float -> bool) -> mat -> bool

  (* functions for comparing two matrices *)

  val is_equal : mat -> mat -> bool

  val is_unequal : mat -> mat -> bool

  val is_greater : mat -> mat -> bool

  val is_smaller : mat -> mat -> bool

  val equal_or_greater : mat -> mat -> bool

  val equal_or_smaller : mat -> mat -> bool

  (* basic arithmetic functions *)

  val add : mat -> mat -> mat

  val sub : mat -> mat -> mat

  val mul : mat -> mat -> mat

  val div : mat -> mat -> mat

  val dot : mat -> mat -> mat

  val abs : mat -> mat

  val neg : mat -> mat

  val power : mat -> float -> mat

  val add_scalar : mat -> float -> mat

  val sub_scalar : mat -> float -> mat

  val mul_scalar : mat -> float -> mat

  val div_scalar : mat -> float -> mat

  val sum : mat -> float

  val sum_rows : mat -> mat

  val sum_cols : mat -> mat

  val average : mat -> float

  val average_rows : mat -> mat

  val average_cols : mat -> mat

  val min : mat -> float * (int * int)

  val min_rows : mat -> (float * (int * int)) array

  val min_cols : mat -> (float * (int * int)) array

  val max : mat -> float * (int * int)

  val max_rows : mat -> (float * (int * int)) array

  val max_cols : mat -> (float * (int * int)) array

  (* advanced linear algebra functions *)

  (* val svd : mat -> mat -> mat -> mat *)

  (* input and output functions *)

  val dump : mat -> string -> unit

  val load : string -> mat

  val print : mat -> unit

  val pprint : mat -> unit

  (* some short hand infix operators *)

  val ( >> ) : mat -> mat -> unit

  val ( << ) : mat -> mat -> unit

  val ( @= ) : mat -> mat -> mat

  val ( @|| ) : mat -> mat -> mat

  val ( +@ ) : mat -> mat -> mat

  val ( -@ ) : mat -> mat -> mat

  val ( *@ ) : mat -> mat -> mat

  val ( /@ ) : mat -> mat -> mat

  val ( $@ ) : mat -> mat -> mat

  val ( **@ ) : mat -> float -> mat

  val ( +$ ) : mat -> float -> mat

  val ( -$ ) : mat -> float -> mat

  val ( *$ ) : mat -> float -> mat

  val ( /$ ) : mat -> float -> mat

  val ( $+ ) : float -> mat -> mat

  val ( $- ) : float -> mat -> mat

  val ( $* ) : float -> mat -> mat

  val ( $/ ) : float -> mat -> mat

  val ( =@ ) : mat -> mat -> bool

  val ( >@ ) : mat -> mat -> bool

  val ( <@ ) : mat -> mat -> bool

  val ( <>@ ) : mat -> mat -> bool

  val ( >=@ ) : mat -> mat -> bool

  val ( <=@ ) : mat -> mat -> bool

end
