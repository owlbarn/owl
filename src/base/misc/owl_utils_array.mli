(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

(** {5 Basic functions} *)

val length : 'a array -> int
(** Refer to OCaml native array. *)

val get : 'a array -> int -> 'a
(** Refer to OCaml native array. *)

val set : 'a array -> int -> 'a -> unit
(** Refer to OCaml native array. *)

val make : int -> 'a -> 'a array
(** Refer to OCaml native array. *)

val create_float : int -> float array
(** Refer to OCaml native array. *)

val init : int -> (int -> 'a) -> 'a array
(** Refer to OCaml native array. *)

val make_matrix : int -> int -> 'a -> 'a array array
(** Refer to OCaml native array. *)

val append : 'a array -> 'a array -> 'a array
(** Refer to OCaml native array. *)

val concat : 'a array list -> 'a array
(** Refer to OCaml native array. *)

val sub : 'a array -> int -> int -> 'a array
(** Refer to OCaml native array. *)

val copy : 'a array -> 'a array
(** Refer to OCaml native array. *)

val fill : 'a array -> int -> int -> 'a -> unit
(** Refer to OCaml native array. *)

val blit : 'a array -> int -> 'a array -> int -> int -> unit
(** Refer to OCaml native array. *)

val to_list : 'a array -> 'a list
(** Refer to OCaml native array. *)

val of_list : 'a list -> 'a array
(** Refer to OCaml native array. *)

val iter : ('a -> unit) -> 'a array -> unit
(** Refer to OCaml native array. *)

val iteri : (int -> 'a -> unit) -> 'a array -> unit
(** Refer to OCaml native array. *)

val fold_left : ('a -> 'b -> 'a) -> 'a -> 'b array -> 'a
(** Refer to OCaml native array. *)

val fold_right : ('b -> 'a -> 'a) -> 'b array -> 'a -> 'a
(** Refer to OCaml native array. *)

val map2 : ('a -> 'b -> 'c) -> 'a array -> 'b array -> 'c array
(** Refer to OCaml native array. *)

val for_all : ('a -> bool) -> 'a array -> bool
(** Refer to OCaml native array. *)

val exists : ('a -> bool) -> 'a array -> bool
(** Refer to OCaml native array. *)

val mem : 'a -> 'a array -> bool
(** Refer to OCaml native array. *)

val memq : 'a -> 'a array -> bool
(** Refer to OCaml native array. *)

val min_i : ?cmp:('a -> 'a -> int) -> 'a array -> int
(**
[min_i x] returns the index of minimum value in array [x]. If [cmp] is
not passed in then [Stdlib.compare] is used as default value.
*)

val max_i : ?cmp:('a -> 'a -> int) -> 'a array -> int
(**
[max_i x] returns the index of minimum value in array [x]. If [cmp] is
not passed in then [Stdlib.compare] is used as default value.
 *)

val argsort : ?cmp:('a -> 'a -> int) -> 'a array -> int array
(**
[argsort cmp x] sorts [x] according to the compare function [cmp] and
returns the corresponding indices.
 *)

val sort : ('a -> 'a -> int) -> 'a array -> unit
(** Refer to OCaml native array. *)

val stable_sort : ('a -> 'a -> int) -> 'a array -> unit
(** Refer to OCaml native array. *)

val fast_sort : ('a -> 'a -> int) -> 'a array -> unit
(** Refer to OCaml native array. *)

val sort_fill : ?min:int -> ?max:int -> ?fill:int -> int array -> int array
(**
[sort_fill ~min ~max ~fill x] first sorts [x], then expands it to an array
of length [max - min + 1], and fills the holes with [fill]. E.g.,
[sort_fill ~min:1 ~max:5 ~fill:0 [|4;2|] x] returns a new array as follows:
[[|1; 0; 2; 0; 4; 5|]].
 *)

val unsafe_get : 'a array -> int -> 'a
(** Refer to OCaml native array. *)

val unsafe_set : 'a array -> int -> 'a -> unit
(** Refer to OCaml native array. *)

(** {5 Extended functions} *)

val ( @ ) : 'a array -> 'a array -> 'a array
(** Operator of array concatenation. *)

val get_slice : int array -> 'a array -> 'a array
(**
[get_slice slice x] returns a copy of slice of [x] defined by [slice].
The [slice] definition must have [[|start;stop;step|]] format. The value
of start, stop, and step can be negative, and the boundary is inclusive.
 *)

val set_slice : int array -> 'a array -> 'a array -> unit
(**
[set_slice slice x y] sets the elements in [x] to the corresponding value
of the elements in [y] based on the slice definition [slice]. Please refer
to [get_slice] function for the information on the format of slice definition.
 *)

val flatten : 'a array array -> 'a array
(** Flatten an array array into an array. *)

val set_n : 'a array -> int array -> 'a -> unit
(** [set_n arr indices v] sets the elements at the positions specified by [indices] 
    in the array [arr] to the value [v].

    @param arr The array in which to set values.
    @param indices An array of indices specifying the positions in [arr] to be updated.
    @param v The value to set at each of the specified positions.
*)

val range : int -> int -> int array
(** [range start stop] generates an array of integers from [start] to [stop] inclusive.

    @param start The starting value of the range.
    @param stop The ending value of the range.
    @return An array of integers from [start] to [stop].
*)

val count : 'a array -> 'a -> int
(** [count arr x] counts the number of occurrences of the value [x] in the array [arr].

    @param arr The array in which to count occurrences.
    @param x The value to count within the array.
    @return The number of times [x] appears in [arr].
*)

val insert : 'a array -> 'a array -> int -> 'a array
(** [insert arr1 arr2 pos] inserts the elements of [arr2] into [arr1] at the specified position [pos].

    @param arr1 The array into which elements are inserted.
    @param arr2 The array of elements to insert into [arr1].
    @param pos The position in [arr1] at which to insert [arr2].
    @return A new array with [arr2] inserted into [arr1] at the position [pos].
*)

val unique : 'a array -> 'a array
(** [unique x] removes the duplicates in the array [x]. *)

val merge : 'a array -> 'a array -> 'a array
(** [merge x y] merges two arrays and removes the duplicates. *)

val reverse : 'a array -> unit
(** [reverse arr] reverses the elements of the array [arr] in place. *)

val remove : 'a array -> int -> 'a array
(** [remove arr pos] removes the element at position [pos] from the array [arr].*)

val replace : int -> int -> 'a array -> 'a array -> 'a array
(** [replace pos len arr1 arr2] replaces the subarray of length [len] starting at [pos] 
    in [arr1] with the elements from [arr2].
*)

val mapi : (int -> 'a -> 'b) -> 'a array -> 'b array
(** [mapi f arr] applies the function [f] to each element of the array [arr], 
    passing the index of the element as the first argument to [f], and returns 
    a new array of the results.
*)

val map : ('a -> 'b) -> 'a array -> 'b array
(** [map f arr] applies the function [f] to each element of the array [arr] 
    and returns a new array of the results.
*)

val iter2i : (int -> 'a -> 'b -> unit) -> 'a array -> 'b array -> unit
(** [iter2i f arr1 arr2] applies the function [f] to each pair of corresponding elements 
    from [arr1] and [arr2], passing the index as the first argument to [f].
*)

val iter2 : ('a -> 'b -> unit) -> 'a array -> 'b array -> unit
(** [iter2 f arr1 arr2] applies the function [f] to each pair of corresponding elements 
    from [arr1] and [arr2].
*)

val iter3i : (int -> 'a -> 'b -> 'c -> unit) -> 'a array -> 'b array -> 'c array -> unit
(** [iter3i f arr1 arr2 arr3] applies the function [f] to each triplet of corresponding elements 
    from [arr1], [arr2], and [arr3], passing the index as the first argument to [f].
*)

val iter3 : ('a -> 'b -> 'c -> unit) -> 'a array -> 'b array -> 'c array -> unit
(** [iter3 f arr1 arr2 arr3] applies the function [f] to each triplet of corresponding elements 
    from [arr1], [arr2], and [arr3].
*)


val iter4i
  :  (int -> 'a -> 'b -> 'c -> 'd -> unit)
  -> 'a array
  -> 'b array
  -> 'c array
  -> 'd array
  -> unit
(** [iter4i f arr1 arr2 arr3 arr4] applies the function [f] to each group of corresponding 
    elements from [arr1], [arr2], [arr3], and [arr4], passing the index of the elements 
    as the first argument to [f]. *)

val iter4
  :  ('a -> 'b -> 'c -> 'd -> unit)
  -> 'a array
  -> 'b array
  -> 'c array
  -> 'd array
  -> unit
(** [iter4 f arr1 arr2 arr3 arr4] applies the function [f] to each group of corresponding 
    elements from [arr1], [arr2], [arr3], and [arr4]. *)

val map2i : (int -> 'a -> 'b -> 'c) -> 'a array -> 'b array -> 'c array
(** [map2i f arr1 arr2] applies the function [f] to each pair of corresponding elements 
    from [arr1] and [arr2], passing the index of the elements as the first argument to [f], 
    and returns an array of the results. *)

val map2i_split2
  :  (int -> 'a -> 'b -> 'c * 'd)
  -> 'a array
  -> 'b array
  -> 'c array * 'd array
(** [map2i_split2 f arr1 arr2] applies the function [f] to each pair of corresponding elements 
    from [arr1] and [arr2], passing the index of the elements as the first argument to [f], 
    and returns a tuple of two arrays containing the first and second elements of the results 
    of [f]. *)

val map3i : (int -> 'a -> 'b -> 'c -> 'd) -> 'a array -> 'b array -> 'c array -> 'd array
(** [map3i f arr1 arr2 arr3] applies the function [f] to each triplet of corresponding elements 
    from [arr1], [arr2], and [arr3], passing the index of the elements as the first argument 
    to [f], and returns an array of the results. *)

val map3 : ('a -> 'b -> 'c -> 'd) -> 'a array -> 'b array -> 'c array -> 'd array
(** [map3 f arr1 arr2 arr3] applies the function [f] to each triplet of corresponding elements 
    from [arr1], [arr2], and [arr3], and returns an array of the results. *)

val map4i
  :  (int -> 'a -> 'b -> 'c -> 'd -> 'e)
  -> 'a array
  -> 'b array
  -> 'c array
  -> 'd array
  -> 'e array
(** [map4i f arr1 arr2 arr3 arr4] applies the function [f] to each group of corresponding elements 
    from [arr1], [arr2], [arr3], and [arr4], passing the index of the elements as the first argument 
    to [f], and returns an array of the results. *)

val map4
  :  ('a -> 'b -> 'c -> 'd -> 'e)
  -> 'a array
  -> 'b array
  -> 'c array
  -> 'd array
  -> 'e array
(** [map4 f arr1 arr2 arr3 arr4] applies the function [f] to each group of corresponding elements 
    from [arr1], [arr2], [arr3], and [arr4], and returns an array of the results. *)

val filteri_v : (int -> 'a -> bool * 'b) -> 'a array -> 'b array
(** [filteri_v f arr] applies the function [f] to each element of [arr], passing the index 
    of the element as the first argument to [f]. The function [f] returns a pair of a boolean 
    and a value. If the boolean is [true], the value is included in the result array. *)

val filter_v : ('a -> bool * 'b) -> 'a array -> 'b array
(** [filter_v f arr] applies the function [f] to each element of [arr]. The function [f] 
    returns a pair of a boolean and a value. If the boolean is [true], the value is included 
    in the result array. *)


val filteri : (int -> 'a -> bool) -> 'a array -> 'a array
(** [filteri f x] filters out the elements in [x] according to predicate [f]. *)

val filter : ('a -> bool) -> 'a array -> 'a array
(** [filter f x] filters out the elements in [x] according to predicate [f]. *)

val filter2i : (int -> 'a -> 'b -> bool) -> 'a array -> 'b array -> ('a * 'b) array
(**
[filter2i f x y] filters the elements in [x] and [y] using passed in
function [f]. Both arrays must have same length.
 *)

val filter2 : ('a -> 'b -> bool) -> 'a array -> 'b array -> ('a * 'b) array
(**
[filter2 f x y] is similar to [filter2i] but without passing index of
the elements to function [f].
 *)

val filter2i_i : (int -> 'a -> 'b -> bool) -> 'a array -> 'b array -> int array
(**
[filter2i_i f x y] filters the elements in [x] and [y] using passed in
function [f]. Both arrays must have same length. Note that the indices of
those satisfying the predicate [f] are returned in an array.
 *)

val filter2_i : ('a -> 'b -> bool) -> 'a array -> 'b array -> int array
(**
[filter2_i f x y] is similar to [filter2i_i] but without passing index of
the elements to function [f].
 *)

val filter2_split : ('a -> 'b -> bool) -> 'a array -> 'b array -> 'a array * 'b array
(**
[filter2_split f x y] is similar to [filter2 f x y], but the returned
results are two separated arrays rather than merging into one tuple array.
 *)

val resize : ?head:bool -> 'a -> int -> 'a array -> 'a array
(**
[resize ~head v n x] resizes [x] of length [m] to length [n]. If
[m <= n], a copy of [x] subarray is returned. If [m > n], then [x] is
extended, the extra space is filled with value [v].
 *)

val fold2 : ('a -> 'b -> 'c -> 'a) -> 'a -> 'b array -> 'c array -> 'a
(**
[fold2 a x y] folds both [x] and [y] from left with starting value [a].
 *)

 val pad : [ `Left | `Right ] -> 'a -> int -> 'a array -> 'a array
 (** [pad side v len arr] pads the array [arr] with the value [v] on the specified side 
     (`Left` or `Right`) until the array reaches the desired length [len].
 
     If [len] is less than or equal to the length of [arr], the original array is returned. *)
 

val align : [ `Left | `Right ] -> 'a -> 'a array -> 'a array -> 'a array * 'a array
(**
[align side v x y] aligns two arrays [x] and [y] along the specified side
with value [v]. The copies of two arrays are returned.
 *)

val align3
  :  [ `Left | `Right ]
  -> 'a
  -> 'a array
  -> 'a array
  -> 'a array
  -> 'a array * 'a array * 'a array
(** [align3 side v x y z] aligns three arrays [x], [y], and [z]. *)

val greater_equal : 'a array -> 'a array -> bool
(** [greater_equal arr1 arr2] returns [true] if all elements in [arr1] are greater than or equal to 
    the corresponding elements in [arr2], and [false] otherwise. *)

val swap : 'a array -> int -> int -> unit
(** [swap arr i j] swaps the elements at indices [i] and [j] in the array [arr]. *)

val permute : int array -> 'a array -> 'a array
(** [permute indices arr] rearranges the elements of [arr] according to the order specified 
    by [indices], returning a new array with the permuted elements. *)

val of_tuples : ('a * 'a) array -> 'a array
(** [of_tuples arr] converts an array of pairs into an array containing all the first elements 
    followed by all the second elements of the pairs in [arr]. *)

val complement : 'a array -> 'a array -> 'a array

(* Given set x and y, return complement of y, i.e. x \ y *)

val balance_last : float -> float array -> float array
(**
[balance_last mass x] performs the following function. Let [l] be the
length of [x], if [i < l - 1], then [x.(i) = x.(i)], otherwise
[x.(l - 1) = mass - \sum_{i < l - 1} x.(i)].
 *)

val index_of : 'a array -> 'a -> int
(** [index_of x a] returns the index of first occurrence of [a] in [x]. *)

val bsearch : cmp:('a -> 'a -> int) -> 'a -> 'a array -> int
(**
Binary search. [bsearch cmp x a] returns the index of the largest value
in the sorted array [a] less than or equal to [x], according to the
comparison function [cmp]. If [x] is smaller than all elements, returns -1.
The function raises an exception if [a] is empty.
*)

val to_string
  :  ?prefix:string
  -> ?suffix:string
  -> ?sep:string
  -> ('a -> string)
  -> 'a array
  -> string
(** [to_string ?prefix ?suffix ?sep f arr] converts the array [arr] to a string 
    representation, applying the function [f] to each element to produce a string. 
    The elements are separated by [sep] (default is ", "), and the entire output is 
    optionally wrapped with [prefix] and [suffix]. *)
