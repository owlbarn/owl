(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(**
N-dimensional array module: including creation, manipulation, and various
vectorised mathematical operations.
*)

(**
About the comparison of two complex numbers ``x`` and ``y``, Owl uses the
following conventions: 1) ``x`` and ``y`` are equal iff both real and imaginary
parts are equal; 2) ``x`` is less than ``y`` if the magnitude of ``x`` is less than
the magnitude of ``y``; in case both ``x`` and ``y`` have the same magnitudes, ``x``
is less than ``y`` if the phase of ``x`` is less than the phase of ``y``; 3) less or
equal, greater, greater or equal relation can be further defined atop of the
aforementioned conventions.
 *)

open Bigarray

open Owl_types


(** {6 Type definition} *)

type ('a, 'b) t = ('a, 'b, c_layout) Genarray.t
(**
N-dimensional array type, i.e. Bigarray Genarray type.
 *)

type ('a, 'b) kind = ('a, 'b) Bigarray.kind
(**
Type of the ndarray, e.g., Bigarray.Float32, Bigarray.Complex64, and etc.
 *)


(** {6 Create Ndarrays}  *)

val empty : ('a, 'b) kind -> int array -> ('a, 'b) t
(**
``empty Bigarray.Float64 [|3;4;5|]`` creates a three diemensional array of
``Bigarray.Float64`` type. Each dimension has the following size: 3, 4, and 5.
The elements in the array are not initialised, they can be any value. ``empty``
is faster than ``zeros`` to create a ndarray.

The module only supports the following four types of ndarray: ``Bigarray.Float32``,
``Bigarray.Float64``, ``Bigarray.Complex32``, and ``Bigarray.Complex64``.
 *)


val create : ('a, 'b) kind -> int array -> 'a -> ('a, 'b) t
(**
``create Bigarray.Float64 [|3;4;5|] 2.`` creates a three-diemensional array of
``Bigarray.Float64`` type. Each dimension has the following size: 3, 4, and 5.
The elements in the array are initialised to ``2.``
 *)

val init : ('a, 'b) kind -> int array -> (int -> 'a) -> ('a, 'b) t
(**
``init Bigarray.Float64 d f`` creates a ndarray ``x`` of shape ``d``, then using
``f`` to initialise the elements in ``x``. The input of ``f`` is 1-dimensional
index of the ndarray. You need to explicitly convert it if you need N-dimensional
index. The function ``ind`` can help you.
 *)

val init_nd : ('a, 'b) kind -> int array -> (int array -> 'a) -> ('a, 'b) t
(**
``init_nd`` is almost the same as ``init`` but ``f`` receives n-dimensional index
as input. It is more convenient since you don't have to convert the index by
yourself, but this also means ``init_nd`` is slower than ``init``.
 *)

val zeros : ('a, 'b) kind -> int array -> ('a, 'b) t
(**
``zeros Bigarray.Complex32 [|3;4;5|]`` creates a three-diemensional array of
``Bigarray.Complex32`` type. Each dimension has the following size: 3, 4, and 5.
The elements in the array are initialised to "zero". Depending on the ``kind``,
zero can be ``0.`` or ``Complex.zero``.
 *)

val ones : ('a, 'b) kind -> int array -> ('a, 'b) t
(**
``ones Bigarray.Complex32 [|3;4;5|]`` creates a three-diemensional array of
``Bigarray.Complex32`` type. Each dimension has the following size: 3, 4, and 5.
The elements in the array are initialised to "one". Depending on the ``kind``,
one can be ``1.`` or ``Complex.one``.
 *)

val eye : ('a, 'b) kind -> int -> ('a, 'b) t
(**
``eye m`` creates an ``m`` by ``m`` identity matrix.
 *)

val uniform : ('a, 'b) kind -> ?a:'a -> ?b:'a -> int array -> ('a, 'b) t
(**
``uniform Bigarray.Float64 [|3;4;5|]`` creates a three-diemensional array
of type ``Bigarray.Float64``. Each dimension has the following size: 3, 4,
and 5. The elements in the array follow a uniform distribution ``0,1``.
 *)

val gaussian : ('a, 'b) kind -> ?mu:'a -> ?sigma:'a -> int array -> ('a, 'b) t
(**
``gaussian Float64 [|3;4;5|]`` ...
 *)

val sequential : ('a, 'b) kind -> ?a:'a -> ?step:'a -> int array -> ('a, 'b) t
(**
``sequential Bigarray.Float64 [|3;4;5|] 2.`` creates a three-diemensional
array of type ``Bigarray.Float64``. Each dimension has the following size: 3, 4,
and 5. The elements in the array are assigned sequential values.

``?a`` specifies the starting value and the default value is zero; whilst
``?step`` specifies the step size with default value one.
 *)

val linspace : ('a, 'b) kind -> 'a -> 'a -> int -> ('a, 'b) t
(**
``linspace k 0. 9. 10`` ...
 *)

val logspace : ('a, 'b) kind -> ?base:float -> 'a -> 'a -> int -> ('a, 'b) t
(**
``logspace k 0. 9. 10`` ...
 *)

val bernoulli : ('a, 'b) kind -> ?p:float -> int array -> ('a, 'b) t
(**
``bernoulli k ~p:0.3 [|2;3;4|]``
 *)

val complex : ('a, 'b) kind -> ('c, 'd) kind -> ('a, 'b) t -> ('a, 'b) t -> ('c, 'd) t
(**
``complex re im`` constructs a complex ndarray/matrix from ``re`` and ``im``.
``re`` and ``im`` contain the real and imaginary part of ``x`` respectively.

Note that both ``re`` and ``im`` can be complex but must have same type. The real
part of ``re`` will be the real part of ``x`` and the imaginary part of ``im`` will
be the imaginary part of ``x``.
 *)

val polar : ('a, 'b) kind -> ('c, 'd) kind -> ('a, 'b) t -> ('a, 'b) t -> ('c, 'd) t
(**
``complex rho theta`` constructs a complex ndarray/matrix from polar
coordinates ``rho`` and ``theta``. ``rho`` contains the magnitudes and ``theta``
contains phase angles. Note that the behaviour is undefined if ``rho`` has
negative elelments or ``theta`` has infinity elelments.
 *)


(** {6 Obtain basic properties}  *)

val shape : ('a, 'b) t -> int array
(**
``shape x`` returns the shape of ndarray ``x``.
 *)

val num_dims : ('a, 'b) t -> int
(**
``num_dims x`` returns the number of dimensions of ndarray ``x``.
 *)

val nth_dim : ('a, 'b) t -> int -> int
(**
``nth_dim x`` returns the size of the nth dimension of ``x``.
 *)

val numel : ('a, 'b) t -> int
(**
``numel x`` returns the number of elements in ``x``.
 *)

val nnz : ('a, 'b) t -> int
(**
``nnz x`` returns the number of non-zero elements in ``x``.
 *)

val density : ('a, 'b) t -> float
(**
``density x`` returns the percentage of non-zero elements in ``x``.
 *)

val size_in_bytes : ('a, 'b) t -> int
(**
``size_in_bytes x`` returns the size of ``x`` in bytes in memory.
 *)

val same_shape : ('a, 'b) t -> ('c, 'd) t -> bool
(**
``same_shape x y`` checks whether ``x`` and ``y`` has the same shape or not.
*)

val kind : ('a, 'b) t -> ('a, 'b) kind
(**
``kind x`` returns the type of ndarray ``x``. It is one of the four possible
values: ``Bigarray.Float32``, ``Bigarray.Float64``, ``Bigarray.Complex32``, and
``Bigarray.Complex64``.
 *)

val strides : ('a, 'b) t -> int array
(**
``strides x`` calculates the strides of ``x``. E.g., if ``x`` is of shape
``[|3;4;5|]``, the returned strides will be ``[|20;5;1|]``.
 *)

val slice_size : ('a, 'b) t -> int array
(**
``slice_size`` calculates the slice size in each dimension, E.g., if ``x`` is of
shape ``[|3;4;5|]``, the returned slice size will be ``[|60; 20; 5|]``.
 *)

val ind : ('a, 'b) t -> int -> int array
(**
``ind x i`` converts ``x``'s one-dimensional index ``i`` to n-dimensional one.
*)

val i1d : ('a, 'b) t -> int array -> int
(**
``i1d x i`` converts ``x``'s n-dimensional index ``i`` to one-dimensional one.
*)


(** {6 Manipulate Ndarrays}  *)

val get : ('a, 'b) t -> int array -> 'a
(**
``get x i`` returns the value at ``i`` in ``x``. E.g., ``get x [|0;2;1|]`` returns
the value at ``[|0;2;1|]`` in ``x``.
 *)

val set : ('a, 'b) t -> int array -> 'a -> unit
(**
``set x i a`` sets the value at ``i`` to ``a`` in ``x``.
 *)

val get_index : ('a, 'b) t -> int array array -> 'a array
(**
``get_index i x`` returns an array of element values specified by the indices
``i``. The length of array ``i`` equals the number of dimensions of ``x``. The
arrays in ``i`` must have the same length, and each represents the indices in
that dimension.

E.g., ``[| [|1;2|]; [|3;4|] |]`` returns the value of elements at position
``(1,3)`` and ``(2,4)`` respectively.
 *)

val set_index : ('a, 'b) t -> int array array -> 'a array -> unit
(**
``set_index i x a`` sets the value of elements in ``x`` according to the indices
specified by ``i``. The length of array ``i`` equals the number of dimensions of
``x``. The arrays in ``i`` must have the same length, and each represents the
indices in that dimension.

If the length of ``a`` equals to the length of ``i``, then each element will be
assigned by the value in the corresponding position in ``x``. If the length of
``a`` equals to one, then all the elements will be assigned the same value.
 *)

val get_fancy : index list -> ('a, 'b) t -> ('a, 'b) t
(**
``get_fancy s x`` returns a copy of the slice in ``x``. The slice is defined by
``a`` which is an ``int option array``. E.g., for a ndarray ``x`` of dimension
``[|2; 2; 3|]``, ``slice [0] x`` takes the following slices of index ``\(0,*,*\)``,
i.e., ``[|0;0;0|]``, ``[|0;0;1|]``, ``[|0;0;2|]`` ... Also note that if the length
of ``s`` is less than the number of dimensions of ``x``, ``slice`` function will
append slice definition to higher diemensions by assuming all the elements in
missing dimensions will be taken.

Basically, ``slice`` function offers very much the same semantic as that in
numpy, i.e., start:stop:step grammar, so if you how to index and slice ndarray
in numpy, you should not find it difficult to use this function. Please just
refer to numpy documentation or my tutorial.

There are two differences between ``slice_left`` and ``slice``: ``slice_left`` does
not make a copy but simply moving the pointer; ``slice_left`` can only make a
slice from left-most axis whereas ``slice`` is much more flexible and can work
on arbitrary axis which need not start from left-most side.
 *)

val set_fancy : index list -> ('a, 'b) t -> ('a, 'b) t -> unit
(**
``set_fancy axis x y`` set the slice defined by ``axis`` in ``x`` according to
the values in ``y``. ``y`` must have the same shape as the one defined by ``axis``.

About the slice definition of ``axis``, please refer to ``get_fancy`` function.
 *)

val get_slice : int list list -> ('a, 'b) t -> ('a, 'b) t
(**
``get_slice axis x`` aims to provide a simpler version of ``get_fancy``.
This function assumes that every list element in the passed in ``int list list``
represents a range, i.e., ``R`` constructor.

E.g., ``[[];[0;3];[0]]`` is equivalent to ``[R []; R [0;3]; R [0]]``.
 *)

val set_slice : int list list -> ('a, 'b) t -> ('a, 'b) t -> unit
(**
``set_slice axis x y`` aims to provide a simpler version of ``set_fancy``.
This function assumes that every list element in the passed in ``int list list``
represents a range, i.e., ``R`` constructor.

E.g., ``[[];[0;3];[0]]`` is equivalent to ``[R []; R [0;3]; R [0]]``.
 *)

val sub_left : ('a, 'b) t -> int -> int -> ('a, 'b) t
(**
Some as ``Bigarray.sub_left``, please refer to Bigarray documentation.
 *)

val slice_left : ('a, 'b) t -> int array -> ('a, 'b) t
(**
Same as ``Bigarray.slice_left``, please refer to Bigarray documentation.
 *)

val copy_to : ('a, 'b) t -> ('a, 'b) t -> unit
(**
``copy_to src dst`` copies the data from ndarray ``src`` to ``dst``.
 *)

val reset : ('a, 'b) t -> unit
(**
``reset x`` resets all the elements in ``x`` to zero.
 *)

val fill : ('a, 'b) t -> 'a -> unit
(**
``fill x a`` assigns the value ``a`` to the elements in ``x``.
 *)

val copy : ('a, 'b) t -> ('a, 'b) t
(**
``copy x`` makes a copy of ``x``.
 *)

val resize : ?head:bool -> ('a, 'b) t -> int array -> ('a, 'b) t
(**
``resize ~head x d`` resizes the ndarray ``x``. If there are less number of
elelments in the new shape than the old one, the new ndarray shares part of
the memeory with the old ``x``. ``head`` indicates the alignment between the new
and old data, either from head or from tail. Note the data is flattened
before the operation.

If there are more elements in the new shape ``d``. Then new memeory space will
be allocated and the content of ``x`` will be copied to the new memory. The rest
of the allocated space will be filled with zeros.
 *)

val reshape : ('a, 'b) t -> int array -> ('a, 'b) t
(**
``reshape x d`` transforms ``x`` into a new shape definted by ``d``. Note the
``reshape`` function will not make a copy of ``x``, the returned ndarray shares
the same memory with the original ``x``.
 *)

val flatten : ('a, 'b) t -> ('a, 'b) t
(**
``flatten x`` transforms ``x`` into a one-dimsonal array without making a copy.
Therefore the returned value shares the same memory space with original ``x``.
 *)

val reverse : ('a, 'b) t -> ('a, 'b) t
(**
``reverse x`` reverse the order of all elements in the flattened ``x`` and
returns the results in a new ndarray. The original ``x`` remains intact.
 *)

val flip : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(**
``flip ~axis x`` flips a matrix/ndarray along ``axis``. By default ``axis = 0``.
The result is returned in a new matrix/ndarray, so the original ``x`` remains
intact.
 *)

val rotate : ('a, 'b) t -> int -> ('a, 'b) t
(**
``rotate x d`` rotates ``x`` clockwise ``d`` degrees. ``d`` must be multiple times
of ``90``, otherwise the function will fail. If ``x`` is an n-dimensional array,
then the function rotates the plane formed by the first and second dimensions.
 *)

val transpose : ?axis:int array -> ('a, 'b) t -> ('a, 'b) t
(**
``transpose ~axis x`` makes a copy of ``x``, then transpose it according to
``~axis``. ``~axis`` must be a valid permutation of ``x`` dimension indices. E.g.,
for a three-dimensional ndarray, it can be ``[2;1;0]``, ``[0;2;1]``, ``[1;2;0]``, and etc.
 *)

val swap : int -> int -> ('a, 'b) t -> ('a, 'b) t
(**
``swap i j x`` makes a copy of ``x``, then swaps the data on axis ``i`` and ``j``.
 *)

val tile : ('a, 'b) t -> int array -> ('a, 'b) t
(**
``tile x a`` tiles the data in ``x`` according the repitition specified by ``a``.
This function provides the exact behaviour as ``numpy.tile``, please refer to
the numpy's online documentation for details.
 *)

val repeat : ?axis:int -> ('a, 'b) t -> int -> ('a, 'b) t
(**
``repeat ~axis x a`` repeats the elements along ``axis`` for ``a`` times. The default
value of ``?axis`` is the highest dimension of ``x``. This function is similar to
``numpy.repeat`` except that ``a`` is an integer instead of an array.
 *)

val concat_vertical : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(**
``concat_vertical x y`` concatenates two ndarray ``x`` and ``y`` vertically.
This is just a convenient function for concatenating two ndarrays along their
lowest dimension, i.e. 0.

The associated operator is ``@||``, please refer to :doc:`owl_operator`.
 *)

val concat_horizontal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(**
``concat_horizontal x y`` concatenates two ndarrays ``x`` and ``y`` horizontally.
This is just a convenient function for concatenating two ndarrays along their
highest dimension.

The associated operator is ``@=``, please refer to :doc:`owl_operator`.
 *)

val concat_vh : ('a, 'b) t array array -> ('a, 'b) t
(**
``concat_vh`` is used to assemble small parts of matrices into a bigger one.
E.g. In ``[| [|a; b; c|]; [|d; e; f|]; [|g; h; i|] |]``, wherein `a, b, c ... i`
are matrices of different shapes. They will be concatenated into a big matrix
as follows.

.. math::
  \begin{bmatrix}
    a & b & c \\
    d & e & f \\
    g & h & i
  \end{bmatrix}

This is achieved by first concatenating along ``axis:1`` for each element in the
array, then concatenating along ``axis:0``. The number of elements in each
array needs not to be equal as long as the aggregated dimensions match. E.g.,
please check the following example.

.. code-block:: ocaml

  let a00 = Mat.sequential 2 3 in
  let a01 = Mat.sequential 2 2 in
  let a02 = Mat.sequential 2 1 in
  let a10 = Mat.sequential 3 3 in
  let a11 = Mat.sequential 3 3 in
  Mat.concat_vh [| [|a00; a01; a02|]; [|a10; a11|] |];;
 *)

val concatenate : ?axis:int -> ('a, 'b) t array -> ('a, 'b) t
(**
``concatenate ~axis:2 x`` concatenates an array of ndarrays along the third
dimension. For the ndarrays in ``x``, they must have the same shape except the
dimension specified by ``axis``. The default value of ``axis`` is 0, i.e., the
lowest dimension of a matrix/ndarray.
 *)

val split : ?axis:int -> int array -> ('a, 'b) t -> ('a, 'b) t array
(**
``split ~axis parts x`` ... TODO
 *)

val squeeze : ?axis:int array -> ('a, 'b) t -> ('a, 'b) t
(**
``squeeze ~axis x`` removes single-dimensional entries from the shape of ``x``.
 *)

val expand : ?hi:bool -> ('a, 'b) t -> int -> ('a, 'b) t
(**
``expand x d`` reshapes ``x`` by increasing its rank from ``num_dims x`` to
``d``. The opposite operation is ``squeeze x``. The ``hi`` parameter is used to
specify wether the expandsion is along high dimension (by setting ``true``), or
along the low dimension (by setting ``false``). The default value is ``false``.
 *)

val pad : ?v:'a -> int list list -> ('a, 'b) t -> ('a, 'b) t
(**
``pad ~v:0. [[1;1]] x`` ... TODO
 *)

val dropout : ?rate:float -> ('a, 'b) t -> ('a, 'b) t
(**
``dropout ~rate:0.3 x`` drops out 30% of the elements in ``x``, in other words,
by setting their values to zeros.
 *)

val top : ('a, 'b) t -> int -> int array array
(**
``top x n`` returns the indices of ``n`` greatest values of ``x``. The indices
are arranged according to the corresponding elelment values, from the greatest
one to the smallest one.
 *)

val bottom : ('a, 'b) t -> int -> int array array
(**
``bottom x n`` returns the indices of ``n`` smallest values of ``x``. The
indices are arranged according to the corresponding elelment values, from the
smallest one to the greatest one.
 *)

val sort : ('a, 'b) t -> ('a, 'b) t
(**
``sort x`` performs quicksort of the elelments in ``x``. A new copy is returned
as result, the original ``x`` remains intact. If you want to perform in-place
sorting, please use `sort_` instead.
 *)

val draw : ?axis:int -> ('a, 'b) t -> int -> ('a, 'b) t * int array
(**
``draw ~axis x n`` draws ``n`` samples from ``x`` along the specified ``axis``,
with replacement. ``axis`` is set to zero by default. The return is a tuple
of both samples and the indices of the selected samples.
 *)

val mmap : Unix.file_descr -> ?pos:int64 -> ('a, 'b) kind -> bool -> int array -> ('a, 'b) t
(**
``mmap fd kind layout shared dims`` ...
 *)


(** {6 Iteration functions}  *)

val iteri :(int -> 'a -> unit) -> ('a, 'b) t -> unit
(**
``iteri f x`` applies function ``f`` to each element in ``x``. Note that 1d index
is passed to function ``f``, you need to convert it to nd-index by yourself.
 *)

val iter : ('a -> unit) -> ('a, 'b) t -> unit
(**
``iter f x`` is similar to ``iteri f x``, excpet the index is not passed to ``f``.
 *)

val mapi : (int -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(**
``mapi f x`` makes a copy of ``x``, then applies ``f`` to each element in ``x``.
 *)

val map : ('a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(**
``map f x`` is similar to ``mapi f x`` except the index is not passed.
 *)

val foldi : ?axis:int -> (int -> 'a -> 'a -> 'a) -> 'a -> ('a, 'b) t -> ('a, 'b) t
(**
``foldi ~axis f a x`` folds (or reduces) the elements in ``x`` from left along
the specified ``axis`` using passed in function ``f``. ``a`` is the initial element
and in ``f i acc b`` ``acc`` is the accumulater and ``b`` is one of the elemets in
``x`` along the same axis. Note that ``i`` is 1d index of ``b``.
 *)

val fold : ?axis:int -> ('a -> 'a -> 'a) -> 'a -> ('a, 'b) t -> ('a, 'b) t
(**
Similar to ``foldi``, except that the index of an element is not passed to ``f``.
 *)

val scani : ?axis:int -> (int -> 'a -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(**
``scan ~axis f x`` scans the ``x`` along the specified ``axis`` using passed in
function ``f``. ``f acc a b`` returns an updated ``acc`` which will be passed in
the next call to ``f i acc a``. This function can be used to implement
accumulative operations such as ``sum`` and ``prod`` functions. Note that the ``i``
is 1d index of ``a`` in ``x``.
 *)

val scan : ?axis:int -> ('a -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(**
Similar to ``scani``, except that the index of an element is not passed to ``f``.
 *)

val filteri : (int -> 'a -> bool) -> ('a, 'b) t -> int array
(**
``filteri f x`` uses ``f`` to filter out certain elements in ``x``. An element
will be included if ``f`` returns ``true``. The returned result is an array of
1-dimensional indices of the selected elements. To obtain the n-dimensional
indices, you need to convert it manulally with Owl's helper function.
 *)

val filter : ('a -> bool) -> ('a, 'b) t -> int array
(**
Similar to ``filteri``, but the indices are not passed to ``f``.
 *)

val iter2i : (int -> 'a -> 'b -> unit) -> ('a, 'c) t -> ('b, 'd) t -> unit
(**
Similar to ``iteri`` but applies to two N-dimensional arrays ``x`` and ``y``. Both
``x`` and ``y`` must have the same shape.
 *)

val iter2 : ('a -> 'b -> unit) -> ('a, 'c) t -> ('b, 'd) t -> unit
(** Similar to ``iter2i``, except that the index not passed to ``f``. *)

val map2i : (int -> 'a -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(**
``map2i f x y`` applies ``f`` to two elements of the same position in both ``x``
and ``y``. Note that 1d index is passed to funciton ``f``.
 *)

val map2 : ('a -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(**
``map2 f x y`` is similar to ``map2i f x y`` except the index is not passed.
 *)

val iteri_nd :(int array -> 'a -> unit) -> ('a, 'b) t -> unit
(** Similar to `iteri` but n-d indices are passed to the user function. *)

val mapi_nd : (int array -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** Similar to `mapi` but n-d indices are passed to the user function. *)

val foldi_nd : ?axis:int -> (int array -> 'a -> 'a -> 'a) -> 'a -> ('a, 'b) t -> ('a, 'b) t
(** Similar to `foldi` but n-d indices are passed to the user function. *)

val scani_nd : ?axis:int -> (int array -> 'a -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t
(** Similar to `scani` but n-d indices are passed to the user function. *)

val filteri_nd : (int array -> 'a -> bool) -> ('a, 'b) t -> int array array
(** Similar to `filteri` but n-d indices are returned. *)

val iter2i_nd :(int array -> 'a -> 'c -> unit) -> ('a, 'b) t -> ('c, 'd) t -> unit
(** Similar to `iter2i` but n-d indices are passed to the user function. *)

val map2i_nd : (int array -> 'a -> 'a -> 'a) -> ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Similar to `map2i` but n-d indices are passed to the user function. *)


(** {6 Examination & Comparison}  *)

val exists : ('a -> bool) -> ('a, 'b) t -> bool
(**
``exists f x`` checks all the elements in ``x`` using ``f``. If at least one
element satisfies ``f`` then the function returns ``true`` otherwise ``false``.
 *)

val not_exists : ('a -> bool) -> ('a, 'b) t -> bool
(**
``not_exists f x`` checks all the elements in ``x``, the function returns
``true`` only if all the elements fail to satisfy ``f : float -> bool``.
 *)

val for_all : ('a -> bool) -> ('a, 'b) t -> bool
(**
``for_all f x`` checks all the elements in ``x``, the function returns ``true``
if and only if all the elements pass the check of function ``f``.
 *)

val is_zero : ('a, 'b) t -> bool
(**
``is_zero x`` returns ``true`` if all the elements in ``x`` are zeros.
 *)

val is_positive : ('a, 'b) t -> bool
(**
``is_positive x`` returns ``true`` if all the elements in ``x`` are positive.
 *)

val is_negative : ('a, 'b) t -> bool
(**
``is_negative x`` returns ``true`` if all the elements in ``x`` are negative.
 *)

val is_nonpositive : ('a, 'b) t -> bool
(**
``is_nonpositive`` returns ``true`` if all the elements in ``x`` are non-positive.
 *)

val is_nonnegative : ('a, 'b) t -> bool
(**
``is_nonnegative`` returns ``true`` if all the elements in ``x`` are non-negative.
 *)

val is_normal : ('a, 'b) t -> bool
(**
``is_normal x`` returns ``true`` if all the elelments in ``x`` are normal float
numbers, i.e., not ``NaN``, not ``INF``, not ``SUBNORMAL``. Please refer to

https://www.gnu.org/software/libc/manual/html_node/Floating-Point-Classes.html
https://www.gnu.org/software/libc/manual/html_node/Infinity-and-NaN.html#Infinity-and-NaN
 *)

val not_nan : ('a, 'b) t -> bool
(**
``not_nan x`` returns ``false`` if there is any ``NaN`` element in ``x``. Otherwise,
the function returns ``true`` indicating all the numbers in ``x`` are not ``NaN``.
 *)

val not_inf : ('a, 'b) t -> bool
(**
``not_inf x`` returns ``false`` if there is any positive or negative ``INF``
element in ``x``. Otherwise, the function returns ``true``.
 *)

val equal : ('a, 'b) t -> ('a, 'b) t -> bool
(**
``equal x y`` returns ``true`` if two matrices ``x`` and ``y`` are equal.
 *)

val not_equal : ('a, 'b) t -> ('a, 'b) t -> bool
(**
``not_equal x y`` returns ``true`` if there is at least one element in ``x`` is
not equal to that in ``y``.
 *)

val greater : ('a, 'b) t -> ('a, 'b) t -> bool
(**
``greater x y`` returns ``true`` if all the elements in ``x`` are greater than
the corresponding elements in ``y``.
 *)

val less : ('a, 'b) t -> ('a, 'b) t -> bool
(**
``less x y`` returns ``true`` if all the elements in ``x`` are smaller than
the corresponding elements in ``y``.
 *)

val greater_equal : ('a, 'b) t -> ('a, 'b) t -> bool
(**
``greater_equal x y`` returns ``true`` if all the elements in ``x`` are not
smaller than the corresponding elements in ``y``.
 *)

val less_equal : ('a, 'b) t -> ('a, 'b) t -> bool
(**
``less_equal x y`` returns ``true`` if all the elements in ``x`` are not
greater than the corresponding elements in ``y``.
 *)

val elt_equal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(**
``elt_equal x y`` performs element-wise ``=`` comparison of ``x`` and ``y``. Assume
that ``a`` is from ``x`` and ``b`` is the corresponding element of ``a`` from ``y`` of
the same position. The function returns another binary (``0`` and ``1``)
ndarray/matrix wherein ``1`` indicates ``a = b``.

The function supports broadcast operation.
 *)

val elt_not_equal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(**
``elt_not_equal x y`` performs element-wise ``!=`` comparison of ``x`` and ``y``.
Assume that ``a`` is from ``x`` and ``b`` is the corresponding element of ``a`` from
``y`` of the same position. The function returns another binary (``0`` and ``1``)
ndarray/matrix wherein ``1`` indicates ``a <> b``.

The function supports broadcast operation.
*)

val elt_less : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(**
``elt_less x y`` performs element-wise ``<`` comparison of ``x`` and ``y``. Assume
that ``a`` is from ``x`` and ``b`` is the corresponding element of ``a`` from ``y`` of
the same position. The function returns another binary (``0`` and ``1``)
ndarray/matrix wherein ``1`` indicates ``a < b``.

The function supports broadcast operation.
 *)

val elt_greater : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(**
``elt_greater x y`` performs element-wise ``>`` comparison of ``x`` and ``y``.
Assume that ``a`` is from ``x`` and ``b`` is the corresponding element of ``a`` from
``y`` of the same position. The function returns another binary (``0`` and ``1``)
ndarray/matrix wherein ``1`` indicates ``a > b``.

The function supports broadcast operation.
 *)

val elt_less_equal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(**
``elt_less_equal x y`` performs element-wise ``<=`` comparison of ``x`` and ``y``.
Assume that ``a`` is from ``x`` and ``b`` is the corresponding element of ``a`` from
``y`` of the same position. The function returns another binary (``0`` and ``1``)
ndarray/matrix wherein ``1`` indicates ``a <= b``.

The function supports broadcast operation.
 *)

val elt_greater_equal : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(**
``elt_greater_equal x y`` performs element-wise ``>=`` comparison of ``x`` and ``y``.
Assume that ``a`` is from ``x`` and ``b`` is the corresponding element of ``a`` from
``y`` of the same position. The function returns another binary (``0`` and ``1``)
ndarray/matrix wherein ``1`` indicates ``a >= b``.

The function supports broadcast operation.
 *)

val equal_scalar : ('a, 'b) t -> 'a -> bool
(**
``equal_scalar x a`` checks if all the elements in ``x`` are equal to ``a``. The
function returns ``true`` iff for every element ``b`` in ``x``, ``b = a``.
 *)

val not_equal_scalar : ('a, 'b) t -> 'a -> bool
(**
``not_equal_scalar x a`` checks if all the elements in ``x`` are not equal to ``a``.
The function returns ``true`` iff for every element ``b`` in ``x``, ``b <> a``.
 *)

val less_scalar : ('a, 'b) t -> 'a -> bool
(**
``less_scalar x a`` checks if all the elements in ``x`` are less than ``a``.
The function returns ``true`` iff for every element ``b`` in ``x``, ``b < a``.
 *)

val greater_scalar : ('a, 'b) t -> 'a -> bool
(**
``greater_scalar x a`` checks if all the elements in ``x`` are greater than ``a``.
The function returns ``true`` iff for every element ``b`` in ``x``, ``b > a``.
 *)

val less_equal_scalar : ('a, 'b) t -> 'a -> bool
(**
``less_equal_scalar x a`` checks if all the elements in ``x`` are less or equal
to ``a``. The function returns ``true`` iff for every element ``b`` in ``x``, ``b <= a``.
 *)

val greater_equal_scalar : ('a, 'b) t -> 'a -> bool
(**
``greater_equal_scalar x a`` checks if all the elements in ``x`` are greater or
equal to ``a``. The function returns ``true`` iff for every element ``b`` in ``x``,
``b >= a``.
 *)

val elt_equal_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(**
``elt_equal_scalar x a`` performs element-wise ``=`` comparison of ``x`` and ``a``.
Assume that ``b`` is one element from ``x`` The function returns another binary
(``0`` and ``1``) ndarray/matrix wherein ``1`` of the corresponding position
indicates ``a = b``, otherwise ``0``.
 *)

val elt_not_equal_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(**
``elt_not_equal_scalar x a`` performs element-wise ``!=`` comparison of ``x`` and
``a``. Assume that ``b`` is one element from ``x`` The function returns another
binary (``0`` and ``1``) ndarray/matrix wherein ``1`` of the corresponding position
indicates ``a <> b``, otherwise ``0``.
 *)

val elt_less_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(**
``elt_less_scalar x a`` performs element-wise ``<`` comparison of ``x`` and ``a``.
Assume that ``b`` is one element from ``x`` The function returns another binary
(``0`` and ``1``) ndarray/matrix wherein ``1`` of the corresponding position
indicates ``a < b``, otherwise ``0``.
 *)

val elt_greater_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(**
``elt_greater_scalar x a`` performs element-wise ``>`` comparison of ``x`` and ``a``.
Assume that ``b`` is one element from ``x`` The function returns another binary
(``0`` and ``1``) ndarray/matrix wherein ``1`` of the corresponding position
indicates ``a > b``, otherwise ``0``.
 *)

val elt_less_equal_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(**
``elt_less_equal_scalar x a`` performs element-wise ``<=`` comparison of ``x`` and
``a``. Assume that ``b`` is one element from ``x`` The function returns another
binary (``0`` and ``1``) ndarray/matrix wherein ``1`` of the corresponding position
indicates ``a <= b``, otherwise ``0``.
 *)

val elt_greater_equal_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(**
``elt_greater_equal_scalar x a`` performs element-wise ``>=`` comparison of ``x``
and ``a``. Assume that ``b`` is one element from ``x`` The function returns
another binary (``0`` and ``1``) ndarray/matrix wherein ``1`` of the corresponding
position indicates ``a >= b``, otherwise ``0``.
 *)

val approx_equal : ?eps:float -> ('a, 'b) t -> ('a, 'b) t -> bool
(**
``approx_equal ~eps x y`` returns ``true`` if ``x`` and ``y`` are approximately
equal, i.e., for any two elements ``a`` from ``x`` and ``b`` from ``y``, we have
``abs (a - b) < eps``. For complex numbers, the ``eps`` applies to both real
and imaginary part.

Note: the threshold check is exclusive for passed in ``eps``, i.e., the
threshold interval is ``(a-eps, a+eps)``.
 *)

val approx_equal_scalar : ?eps:float -> ('a, 'b) t -> 'a -> bool
(**
``approx_equal_scalar ~eps x a`` returns ``true`` all the elements in ``x`` are
approximately equal to ``a``, i.e., ``abs (x - a) < eps``. For complex numbers,
the ``eps`` applies to both real and imaginary part.

Note: the threshold check is exclusive for the passed in ``eps``.
 *)

val approx_elt_equal : ?eps:float -> ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(**
``approx_elt_equal ~eps x y`` compares the element-wise equality of ``x`` and
``y``, then returns another binary (i.e., ``0`` and ``1``) ndarray/matrix wherein
``1`` indicates that two corresponding elements ``a`` from ``x`` and ``b`` from ``y``
are considered as approximately equal, namely ``abs (a - b) < eps``.
 *)

val approx_elt_equal_scalar : ?eps:float -> ('a, 'b) t -> 'a -> ('a, 'b) t
(**
``approx_elt_equal_scalar ~eps x a`` compares all the elements of ``x`` to a
scalar value ``a``, then returns another binary (i.e., ``0`` and ``1``)
ndarray/matrix wherein ``1`` indicates that the element ``b`` from ``x`` is
considered as approximately equal to ``a``, namely ``abs (a - b) < eps``.
 *)


(** {6 Input/Output functions}  *)

val of_array : ('a, 'b) kind -> 'a array -> int array -> ('a, 'b) t
(**
``of_array k x d`` takes an array ``x`` and converts it into an ndarray of type
``k`` and shape ``d``.
 *)

val to_array : ('a, 'b) t -> 'a array
(**
``to_array x`` converts an ndarray ``x`` to OCaml's array type. Note that the
ndarray ``x`` is flattened before convertion.
 *)

val print : ?max_row:int -> ?max_col:int -> ?header:bool -> ?fmt:('a -> string) -> ('a, 'b) t -> unit
(**
``print x`` prints all the elements in ``x`` as well as their indices. ``max_row``
and ``max_col`` specify the maximum number of rows and columns to display.
``header`` specifies whether or not to print out the headers. ``fmt`` is the
function to format every element into string.
 *)

val pp_dsnda : Format.formatter -> ('a, 'b) t -> unit
(**
``pp_dsnda x`` prints ``x`` in OCaml toplevel. If the ndarray is too long,
``pp_dsnda`` only prints out parts of the ndarray.
 *)

val save : ('a, 'b) t -> string -> unit
(**
``save x s`` serialises a ndarray ``x`` to a file of name ``s``.
 *)

val load : ('a, 'b) kind -> string -> ('a, 'b) t
(**
``load k s`` loads previously serialised ndarray from file ``s`` into memory.
It is necesssary to specify the type of the ndarray with paramater ``k``.
*)


(** {6 Unary math operators }  *)

val re_c2s : (Complex.t, complex32_elt) t -> (float, float32_elt) t
(**
``re_c2s x`` returns all the real components of ``x`` in a new ndarray of same shape.
 *)

val re_z2d : (Complex.t, complex64_elt) t -> (float, float64_elt) t
(**
``re_d2z x`` returns all the real components of ``x`` in a new ndarray of same shape.
 *)

val im_c2s : (Complex.t, complex32_elt) t -> (float, float32_elt) t
(**
``im_c2s x`` returns all the imaginary components of ``x`` in a new ndarray of same shape.
 *)

val im_z2d : (Complex.t, complex64_elt) t -> (float, float64_elt) t
(**
``im_d2z x`` returns all the imaginary components of ``x`` in a new ndarray of same shape.
 *)

val sum : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(**
``sum ~axis x`` sums the elements in ``x`` along specified ``axis``.
 *)

val sum' : ('a, 'b) t -> 'a
(**
``sum' x`` returns the sumtion of all elements in ``x``.
 *)

val prod : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(**
``prod ~axis x`` multiples the elements in ``x`` along specified ``axis``.
 *)

val prod' : ('a, 'b) t -> 'a
(**
``prod x`` returns the product of all elements in ``x`` along passed in axises.
 *)

val mean : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(**
``mean ~axis x`` calculates the mean along specified ``axis``.
 *)

val mean' : ('a, 'b) t -> 'a
(**
``mean' x`` calculates the mean of all the elements in ``x``.
 *)

val var : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(**
``var ~axis x`` calculates the variance along specified ``axis``.
 *)

val var' : ('a, 'b) t -> 'a
(**
``var' x`` calculates the variance of all the elements in ``x``.
 *)

val std : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(**
``std ~axis`` calculates the standard deviation along specified ``axis``.
 *)

val std' : ('a, 'b) t -> 'a
(**
``std' x`` calculates the standard deviation of all the elements in ``x``.
 *)

val min : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(**
``min x`` returns the minimum of all elements in ``x`` along specified ``axis``.
If no axis is specified, ``x`` will be flattened and the minimum of all the
elements will be returned.  For two complex numbers, the one with the smaller
magnitude will be selected. If two magnitudes are the same, the one with the
smaller phase will be selected.
 *)

val min' : ('a, 'b) t -> 'a
(**
``min' x`` is similar to ``min`` but returns the minimum of all elements in ``x``
in scalar value.
 *)

val max : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(**
``max x`` returns the maximum of all elements in ``x`` along specified ``axis``.
If no axis is specified, ``x`` will be flattened and the maximum of all the
elements will be returned.  For two complex numbers, the one with the greater
magnitude will be selected. If two magnitudes are the same, the one with the
greater phase will be selected.
 *)

val max' : ('a, 'b) t -> 'a
(**
``max' x`` is similar to ``max`` but returns the maximum of all elements in ``x``
in scalar value.
 *)

val minmax : ?axis:int -> ('a, 'b) t -> ('a, 'b) t * ('a, 'b) t
(**
``minmax' x`` returns ``(min_v, max_v)``, ``min_v`` is the minimum value in ``x``
while ``max_v`` is the maximum.
 *)

val minmax' : ('a, 'b) t -> 'a * 'a
(**
``minmax' x`` returns ``(min_v, max_v)``, ``min_v`` is the minimum value in ``x``
while ``max_v`` is the maximum.
 *)

val min_i : ('a, 'b) t -> 'a * int array
(**
``min_i x`` returns the minimum of all elements in ``x`` as well as its index.
 *)

val max_i : ('a, 'b) t -> 'a * int array
(**
``max_i x`` returns the maximum of all elements in ``x`` as well as its index.
 *)

val minmax_i : ('a, 'b) t -> ('a * (int array)) * ('a * (int array))
(**
``minmax_i x`` returns ``((min_v,min_i), (max_v,max_i))`` where ``(min_v,min_i)``
is the minimum value in ``x`` along with its index while ``(max_v,max_i)`` is the
maximum value along its index.
 *)

val abs : ('a, 'b) t -> ('a, 'b) t
(**
``abs x`` returns the absolute value of all elements in ``x`` in a new ndarray.
 *)

val abs_c2s : (Complex.t, complex32_elt) t -> (float, float32_elt) t
(**
``abs_c2s x`` is similar to ``abs`` but takes ``complex32`` as input.
 *)

val abs_z2d : (Complex.t, complex64_elt) t -> (float, float64_elt) t
(**
``abs_z2d x`` is similar to ``abs`` but takes ``complex64`` as input.
 *)

val abs2 : ('a, 'b) t -> ('a, 'b) t
(**
``abs2 x`` returns the square of absolute value of all elements in ``x`` in a new ndarray.
 *)

val abs2_c2s : (Complex.t, complex32_elt) t -> (float, float32_elt) t
(**
``abs2_c2s x`` is similar to ``abs2`` but takes ``complex32`` as input.
 *)

val abs2_z2d : (Complex.t, complex64_elt) t -> (float, float64_elt) t
(**
``abs2_z2d x`` is similar to ``abs2`` but takes ``complex64`` as input.
 *)

val conj : ('a, 'b) t -> ('a, 'b) t
(**
``conj x`` returns the conjugate of the complex ``x``.
 *)

val neg : ('a, 'b) t -> ('a, 'b) t
(**
``neg x`` negates the elements in ``x`` and returns the result in a new ndarray.
 *)

val reci : ('a, 'b) t -> ('a, 'b) t
(**
``reci x`` computes the reciprocal of every elements in ``x`` and returns the
result in a new ndarray.
 *)

val reci_tol : ?tol:'a -> ('a, 'b) t -> ('a, 'b) t
(**
``reci_tol ~tol x`` computes the reciprocal of every element in ``x``. Different
from ``reci``, ``reci_tol`` sets the elements whose ``abs`` value smaller than ``tol``
to zeros. If ``tol`` is not specified, the defautl ``Owl_utils.eps Float32`` will
be used. For complex numbers, refer to Owl's doc to see how to compare.
 *)

val signum : (float, 'a) t -> (float, 'a) t
(**
``signum`` computes the sign value (``-1`` for negative numbers, ``0`` (or ``-0``)
for zero, ``1`` for positive numbers, ``nan`` for ``nan``).
 *)

val sqr : ('a, 'b) t -> ('a, 'b) t
(**
``sqr x`` computes the square of the elements in ``x`` and returns the result in
a new ndarray.
 *)

val sqrt : ('a, 'b) t -> ('a, 'b) t
(**
``sqrt x`` computes the square root of the elements in ``x`` and returns the
result in a new ndarray.
 *)

val cbrt : ('a, 'b) t -> ('a, 'b) t
(**
``cbrt x`` computes the cubic root of the elements in ``x`` and returns the
result in a new ndarray.
 *)

val exp : ('a, 'b) t -> ('a, 'b) t
(**
``exp x`` computes the exponential of the elements in ``x`` and returns the
result in a new ndarray.
 *)

val exp2 : ('a, 'b) t -> ('a, 'b) t
(**
``exp2 x`` computes the base-2 exponential of the elements in ``x`` and returns
the result in a new ndarray.
 *)

val exp10 : ('a, 'b) t -> ('a, 'b) t
(**
``exp10 x`` computes the base-10 exponential of the elements in ``x`` and returns
the result in a new ndarray.
 *)

val expm1 : ('a, 'b) t -> ('a, 'b) t
(**
``expm1 x`` computes ``exp x -. 1.`` of the elements in ``x`` and returns the
result in a new ndarray.
 *)

val log : ('a, 'b) t -> ('a, 'b) t
(**
``log x`` computes the logarithm of the elements in ``x`` and returns the
result in a new ndarray.
 *)

val log10 : ('a, 'b) t -> ('a, 'b) t
(**
``log10 x`` computes the base-10 logarithm of the elements in ``x`` and returns
the result in a new ndarray.
 *)

val log2 : ('a, 'b) t -> ('a, 'b) t
(**
``log2 x`` computes the base-2 logarithm of the elements in ``x`` and returns
the result in a new ndarray.
 *)

val log1p : ('a, 'b) t -> ('a, 'b) t
(**
``log1p x`` computes ``log (1 + x)`` of the elements in ``x`` and returns the
result in a new ndarray.
 *)

val sin : ('a, 'b) t -> ('a, 'b) t
(**
``sin x`` computes the sine of the elements in ``x`` and returns the result in
a new ndarray.
 *)

val cos : ('a, 'b) t -> ('a, 'b) t
(**
``cos x`` computes the cosine of the elements in ``x`` and returns the result in
a new ndarray.
 *)

val tan : ('a, 'b) t -> ('a, 'b) t
(**
``tan x`` computes the tangent of the elements in ``x`` and returns the result
in a new ndarray.
 *)

val asin : ('a, 'b) t -> ('a, 'b) t
(**
``asin x`` computes the arc sine of the elements in ``x`` and returns the result
in a new ndarray.
 *)

val acos : ('a, 'b) t -> ('a, 'b) t
(**
``acos x`` computes the arc cosine of the elements in ``x`` and returns the
result in a new ndarray.
 *)

val atan : ('a, 'b) t -> ('a, 'b) t
(**
``atan x`` computes the arc tangent of the elements in ``x`` and returns the
result in a new ndarray.
 *)

val sinh : ('a, 'b) t -> ('a, 'b) t
(**
``sinh x`` computes the hyperbolic sine of the elements in ``x`` and returns
the result in a new ndarray.
 *)

val cosh : ('a, 'b) t -> ('a, 'b) t
(**
``cosh x`` computes the hyperbolic cosine of the elements in ``x`` and returns
the result in a new ndarray.
 *)

val tanh : ('a, 'b) t -> ('a, 'b) t
(**
``tanh x`` computes the hyperbolic tangent of the elements in ``x`` and returns
the result in a new ndarray.
 *)

val asinh : ('a, 'b) t -> ('a, 'b) t
(**
``asinh x`` computes the hyperbolic arc sine of the elements in ``x`` and
returns the result in a new ndarray.
 *)

val acosh : ('a, 'b) t -> ('a, 'b) t
(**
``acosh x`` computes the hyperbolic arc cosine of the elements in ``x`` and
returns the result in a new ndarray.
 *)

val atanh : ('a, 'b) t -> ('a, 'b) t
(**
``atanh x`` computes the hyperbolic arc tangent of the elements in ``x`` and
returns the result in a new ndarray.
 *)

val floor : ('a, 'b) t -> ('a, 'b) t
(**
``floor x`` computes the floor of the elements in ``x`` and returns the result
in a new ndarray.
 *)

val ceil : ('a, 'b) t -> ('a, 'b) t
(**
``ceil x`` computes the ceiling of the elements in ``x`` and returns the result
in a new ndarray.
 *)

val round : ('a, 'b) t -> ('a, 'b) t
(**
``round x`` rounds the elements in ``x`` and returns the result in a new ndarray.
 *)

val trunc : ('a, 'b) t -> ('a, 'b) t
(**
``trunc x`` computes the truncation of the elements in ``x`` and returns the
result in a new ndarray.
 *)

val fix : ('a, 'b) t -> ('a, 'b) t
(**
``fix x`` rounds each element of ``x`` to the nearest integer toward zero.
For positive elements, the behavior is the same as ``floor``. For negative ones,
the behavior is the same as ``ceil``.
 *)

val modf : ('a, 'b) t -> ('a, 'b) t * ('a, 'b) t
(**
``modf x`` performs ``modf`` over all the elements in ``x``, the fractal part is
saved in the first element of the returned tuple whereas the integer part is
saved in the second element.
 *)

val erf : (float, 'a) t -> (float, 'a) t
(**
``erf x`` computes the error function of the elements in ``x`` and returns the
result in a new ndarray.
 *)

val erfc : (float, 'a) t -> (float, 'a) t
(**
``erfc x`` computes the complementary error function of the elements in ``x``
and returns the result in a new ndarray.
 *)

val logistic : (float, 'a) t -> (float, 'a) t
(**
``logistic x`` computes the logistic function ``1/(1 + exp(-a)`` of the elements
in ``x`` and returns the result in a new ndarray.
 *)

val relu : (float, 'a) t -> (float, 'a) t
(**
``relu x`` computes the rectified linear unit function ``max(x, 0)`` of the
elements in ``x`` and returns the result in a new ndarray.
 *)

val elu : ?alpha:float -> (float, 'a) t -> (float, 'a) t
(**
``elu alpha x`` computes the exponential linear unit function
``x >= 0. ? x : (alpha * (exp(x) - 1))``  of the elements in ``x`` and returns
the result in a new ndarray.
 *)

val leaky_relu : ?alpha:float -> (float, 'a) t -> (float, 'a) t
(**
``leaky_relu alpha x`` computes the leaky rectified linear unit function
``x >= 0. ? x : (alpha * x)`` of the elements in ``x`` and returns the result
in a new ndarray.
 *)

val softplus : (float, 'a) t -> (float, 'a) t
(**
``softplus x`` computes the softplus function ``log(1 + exp(x)`` of the elements
in ``x`` and returns the result in a new ndarray.
 *)

val softsign : (float, 'a) t -> (float, 'a) t
(**
``softsign x`` computes the softsign function ``x / (1 + abs(x))`` of the
elements in ``x`` and returns the result in a new ndarray.
 *)

val softmax : (float, 'a) t -> (float, 'a) t
(**
``softmax x`` computes the softmax functions ``(exp x) / (sum (exp x))`` of
all the elements in ``x`` and returns the result in a new array.
 *)

val sigmoid : (float, 'a) t -> (float, 'a) t
(**
``sigmoid x`` computes the sigmoid function ``1 / (1 + exp (-x))`` for each
element in ``x``.
 *)

val log_sum_exp' : (float, 'a) t -> float
(**
``log_sum_exp x`` computes the logarithm of the sum of exponentials of all
the elements in ``x``.
 *)

val l1norm : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(**
``l1norm x`` calculates the l1-norm of of ``x`` along specified axis.
 *)

val l1norm' : ('a, 'b) t -> 'a
(**
``l1norm x`` calculates the l1-norm of all the element in ``x``.
 *)

val l2norm : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(**
``l2norm x`` calculates the l2-norm of of ``x`` along specified axis.
 *)

val l2norm' : ('a, 'b) t -> 'a
(**
``l2norm x`` calculates the l2-norm of all the element in ``x``.
 *)

val l2norm_sqr : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(**
``l2norm_sqr x`` calculates the square l2-norm of of ``x`` along specified axis.
 *)

val l2norm_sqr' : ('a, 'b) t -> 'a
(**
``l2norm_sqr x`` calculates the square of l2-norm (or l2norm, Euclidean norm)
of all elements in ``x``. The function uses conjugate transpose in the product,
hence it always returns a float number.
 *)

val vecnorm : ?axis:int -> ?p:float -> ('a, 'b) t -> ('a, 'b) t
(**
``vecnorm ~axis ~p x`` calculates the generalised vector p-norm along the
specified ``axis``. The generalised p-norm is defined as below.

.. math::
  ||v||_p = \Big[ \sum_{k=0}^{N-1} |v_k|^p \Big]^{1/p}

Parameters:
  * ``axis`` is the axis for reduction.
  * ``p`` is order of norm, default value is 2.
  * ``x`` is the input ndarray.

Returns:
  * If ``p = infinity``, then returns :math:`||v||_{\infty} = \max_i(|v(i)|)`.
  * If ``p = -infinity``, then returns :math:`||v||_{-\infty} = \min_i(|v(i)|)`.
  * Otherwise returns generalised vector p-norm defined above.
 *)

val vecnorm' : ?p:float -> ('a, 'b) t -> 'a
(**
``vecnorm'`` flattens the input into 1-d vector first, then calculates the
generalised p-norm the same as ``venorm``.
 *)

val cumsum : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(**
``cumsum ~axis x`` : performs cumulative sum of the elements along the given
axis ``~axis``. If ``~axis`` is ``None``, then the ``cumsum`` is performed along the
lowest dimension. The returned result however always remains the same shape.
 *)

val cumprod : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(**
``cumprod ~axis x`` : similar to ``cumsum`` but performs cumulative product of
the elements along the given ``~axis``.
 *)

val cummin : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(**
``cummin ~axis x`` : performs cumulative ``min`` along ``axis`` dimension.
 *)

val cummax : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(**
``cummax ~axis x`` : performs cumulative ``max`` along ``axis`` dimension.
 *)

val diff : ?axis:int -> ?n:int -> ('a, 'b) t -> ('a, 'b) t
(**
``diff ~axis ~n x`` calculates the ``n``-th difference of ``x`` along the
specified ``axis``.

Parameters:
  * ``axis``: axis to calculate the difference. The default value is the
    highest dimension.
  * ``n``: how many times to calculate the difference. The default value is 1.

Return:
  * The difference ndarray y. Note the shape of ``y`` 1 less than that of ``x``
    along specified axis.
 *)

val angle : (Complex.t, 'a) t -> (Complex.t, 'a) t
(**
``angle x`` calculates the phase angle of all complex numbers in ``x``.
 *)

val proj : (Complex.t, 'a) t -> (Complex.t, 'a) t
(**
``proj x`` computes the projection on Riemann sphere of all elelments in ``x``.
 *)


(** {6 Binary math operators}  *)

val add : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(**
``add x y`` adds all the elements in ``x`` and ``y`` elementwise, and returns the
result in a new ndarray.

General broadcast operation is automatically applied to add/sub/mul/div, etc.
The function compares the dimension element-wise from the highest to the
lowest with the following broadcast rules (same as numpy):
1. equal; 2. either is 1.
 *)

val sub : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(**
``sub x y`` subtracts all the elements in ``x`` and ``y`` elementwise, and returns
the result in a new ndarray.
 *)

val mul : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(**
``mul x y`` multiplies all the elements in ``x`` and ``y`` elementwise, and
returns the result in a new ndarray.
 *)

val div : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(**
``div x y`` divides all the elements in ``x`` and ``y`` elementwise, and returns
the result in a new ndarray.
 *)

val add_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(**
``add_scalar x a`` adds a scalar value ``a`` to each element in ``x``, and
returns the result in a new ndarray.
 *)

val sub_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(**
``sub_scalar x a`` subtracts a scalar value ``a`` from each element in ``x``,
and returns the result in a new ndarray.
 *)

val mul_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(**
``mul_scalar x a`` multiplies each element in ``x`` by a scalar value ``a``,
and returns the result in a new ndarray.
 *)

val div_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(**
``div_scalar x a`` divides each element in ``x`` by a scalar value ``a``, and
returns the result in a new ndarray.
 *)

val scalar_add : 'a -> ('a, 'b) t -> ('a, 'b) t
(**
``scalar_add a x`` adds a scalar value ``a`` to each element in ``x``,
and returns the result in a new ndarray.
 *)

val scalar_sub : 'a -> ('a, 'b) t -> ('a, 'b) t
(**
``scalar_sub a x`` subtracts each element in ``x`` from a scalar value ``a``,
and returns the result in a new ndarray.
 *)

val scalar_mul : 'a -> ('a, 'b) t -> ('a, 'b) t
(**
``scalar_mul a x`` multiplies each element in ``x`` by a scalar value ``a``,
and returns the result in a new ndarray.
 *)

val scalar_div : 'a -> ('a, 'b) t -> ('a, 'b) t
(**
``scalar_div a x`` divides a scalar value ``a`` by each element in ``x``,
and returns the result in a new ndarray.
 *)

val pow : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(**
``pow x y`` computes ``pow(a, b)`` of all the elements in ``x`` and ``y``
elementwise, and returns the result in a new ndarray.
 *)

val scalar_pow : 'a -> ('a, 'b) t -> ('a, 'b) t
(**
``scalar_pow a x`` computes the power value of a scalar value ``a`` using the elements
in a ndarray ``x``.
 *)

val pow_scalar : ('a, 'b) t -> 'a -> ('a, 'b) t
(**
``pow_scalar x a`` computes each element in ``x`` power to ``a``.
 *)

val atan2 : (float, 'a) t -> (float, 'a) t -> (float, 'a) t
(**
``atan2 x y`` computes ``atan2(a, b)`` of all the elements in ``x`` and ``y``
elementwise, and returns the result in a new ndarray.
 *)

val scalar_atan2 : float -> (float, 'a) t -> (float, 'a) t
(**
``scalar_atan2 a x``
 *)

val atan2_scalar : (float, 'a) t -> float -> (float, 'a) t
(**
``scalar_atan2 x a``
 *)

val hypot : (float, 'a) t -> (float, 'a) t -> (float, 'a) t
(**
``hypot x y`` computes ``sqrt(x*x + y*y)`` of all the elements in ``x`` and ``y``
elementwise, and returns the result in a new ndarray.
 *)

val min2 : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(**
``min2 x y`` computes the minimum of all the elements in ``x`` and ``y``
elementwise, and returns the result in a new ndarray.
 *)

val max2 : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(**
``max2 x y`` computes the maximum of all the elements in ``x`` and ``y``
elementwise, and returns the result in a new ndarray.
 *)

val fmod : (float, 'a) t -> (float, 'a) t -> (float, 'a) t
(**
``fmod x y`` performs float mod division.
 *)

val fmod_scalar : (float, 'a) t -> float -> (float, 'a) t
(**
``fmod_scalar x a`` performs mod division between ``x`` and scalar ``a``.
 *)

val scalar_fmod : float -> (float, 'a) t -> (float, 'a) t
(**
``scalar_fmod x a`` performs mod division between scalar ``a`` and ``x``.
 *)

val ssqr' : ('a, 'b) t -> 'a -> 'a
(**
``ssqr x a`` computes the sum of squared differences of all the elements in
``x`` from constant ``a``. This function only computes the square of each element
rather than the conjugate transpose as {!l2norm_sqr} does.
 *)

val ssqr_diff' : ('a, 'b) t -> ('a, 'b) t -> 'a
(**
``ssqr_diff x y`` computes the sum of squared differences of every elements in
``x`` and its corresponding element in ``y``.
 *)

val cross_entropy' : (float, 'a) t -> (float, 'a) t -> float
(**
``cross_entropy x y`` calculates the cross entropy between ``x`` and ``y`` using base ``e``.
 *)

val clip_by_value : ?amin:'a -> ?amax:'a -> ('a, 'b) t -> ('a, 'b) t
(**
``clip_by_value ~amin ~amax x`` clips the elements in ``x`` based on ``amin`` and
``amax``. The elements smaller than ``amin`` will be set to ``amin``, and the
elements greater than ``amax`` will be set to ``amax``.
 *)

val clip_by_l2norm : float -> (float, 'a) t -> (float, 'a) t
(**
``clip_by_l2norm t x`` clips the ``x`` according to the threshold set by ``t``.
 *)


(** {6 Cast functions}  *)

val cast : ('a, 'b) kind -> ('c, 'd) t -> ('a, 'b) t
(**
``cast kind x`` casts ``x`` of type ``('c, 'd) t`` to type ``('a, 'b) t``
specify by the passed in ``kind`` parameter. This function is a generalisation
of the other type casting functions such as ``cast_s2d``, ``cast_c2z``, and etc.
 *)

val cast_s2d : (float, float32_elt) t -> (float, float64_elt) t
(**
``cast_s2d x`` casts ``x`` from ``float32`` to ``float64``.
 *)

val cast_d2s : (float, float64_elt) t -> (float, float32_elt) t
(**
``cast_d2s x`` casts ``x`` from ``float64`` to ``float32``.
 *)

val cast_c2z : (Complex.t, complex32_elt) t -> (Complex.t, complex64_elt) t
(**
``cast_c2z x`` casts ``x`` from ``complex32`` to ``complex64``.
 *)

val cast_z2c : (Complex.t, complex64_elt) t -> (Complex.t, complex32_elt) t
(**
``cast_z2c x`` casts ``x`` from ``complex64`` to ``complex32``.
 *)

val cast_s2c : (float, float32_elt) t -> (Complex.t, complex32_elt) t
(**
``cast_s2c x`` casts ``x`` from ``float32`` to ``complex32``.
 *)

val cast_d2z : (float, float64_elt) t -> (Complex.t, complex64_elt) t
(**
``cast_d2z x`` casts ``x`` from ``float64`` to ``complex64``.
 *)

val cast_s2z : (float, float32_elt) t -> (Complex.t, complex64_elt) t
(**
``cast_s2z x`` casts ``x`` from ``float32`` to ``complex64``.
 *)

val cast_d2c : (float, float64_elt) t -> (Complex.t, complex32_elt) t
(**
``cast_d2c x`` casts ``x`` from ``float64`` to ``complex32``.
 *)


(** {6 Neural network related}  *)

val conv1d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t
(**
[]
 *)

val conv2d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t
(**
[]
 *)

val conv3d : ?padding:padding -> (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t
(**
[]
 *)

val max_pool1d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(**
[]
 *)

val max_pool2d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(**
[]
 *)

val max_pool3d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(**
[]
 *)

val avg_pool1d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(**
[]
 *)

val avg_pool2d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(**
[]
 *)

val avg_pool3d : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t
(**
[]
 *)

val max_pool2d_argmax : ?padding:padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t * (int64, int64_elt) t
(**
[]
 *)

val conv1d_backward_input : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(**
[]
 *)

val conv1d_backward_kernel : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(**
[]
 *)

val conv2d_backward_input : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(**
[]
 *)

val conv2d_backward_kernel : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(**
[]
 *)

val conv3d_backward_input : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(**
[]
 *)

val conv3d_backward_kernel : (float, 'a) t -> (float, 'a) t -> int array -> (float, 'a) t -> (float, 'a) t
(**
[]
 *)

val max_pool1d_backward : padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(**
[]
 *)

val max_pool2d_backward : padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(**
[]
 *)

val max_pool3d_backward : padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(** [] *)

val avg_pool1d_backward : padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(**
[]
 *)

val avg_pool2d_backward : padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(**
[]
 *)

val avg_pool3d_backward : padding -> (float, 'a) t -> int array -> int array -> (float, 'a) t -> (float, 'a) t
(** [] *)


(** {6 Helper functions }  *)

(**
The following functions are helper functions for some other functions in
both Ndarray and Ndview modules. In general, you are not supposed to use
these functions directly.
 *)

val print_element : ('a, 'b) kind -> 'a -> unit
(**
``print_element kind a`` prints the value of a single element.
 *)

val print_index : int array -> unit
(**
``print_index i`` prints out the index of an element.
 *)

val _check_transpose_axis : int array -> int -> unit
(**
``_check_transpose_axis a d`` checks whether ``a`` is a legiti('a, 'b) te transpose index.
 *)

val sum_slices : ?axis:int -> ('a, 'b) t -> ('a, 'b) t
(**
``sum_slices ~axis:2 x`` for ``x`` of ``[|2;3;4;5|]``, it returns an ndarray of
shape ``[|4;5|]``. Currently, the operation is done using ``gemm``, fast but uses
more memory.
 *)


(** {6 In-place modification}  *)

val sort_ : ('a, 'b) t -> unit
(**
``sort_ x`` performs in-place quicksort of the elelments in ``x``.
 *)

val add_ : ('a, 'b) t -> ('a, 'b) t -> unit
(**
``add_ x y`` is simiar to ``add`` function but the output is written to ``x``.
The broadcast operation only allows broadcasting ``y`` over ``x``, so you need to
make sure ``x`` is big enough to hold the output result.
 *)

val sub_ : ('a, 'b) t -> ('a, 'b) t -> unit
(**
``sub_ x y`` is simiar to ``sub`` function but the output is written to ``x``.
The broadcast operation only allows broadcasting ``y`` over ``x``, so you need to
make sure ``x`` is big enough to hold the output result.
 *)

val mul_ : ('a, 'b) t -> ('a, 'b) t -> unit
(**
``mul_ x y`` is simiar to ``mul`` function but the output is written to ``x``.
The broadcast operation only allows broadcasting ``y`` over ``x``, so you need to
make sure ``x`` is big enough to hold the output result.
 *)

val div_ : ('a, 'b) t -> ('a, 'b) t -> unit
(**
``div_ x y`` is simiar to ``div`` function but the output is written to ``x``.
The broadcast operation only allows broadcasting ``y`` over ``x``, so you need to
make sure ``x`` is big enough to hold the output result.
 *)

val pow_ : ('a, 'b) t -> ('a, 'b) t -> unit
(**
``pow_ x y`` is simiar to ``pow`` function but the output is written to ``x``.
The broadcast operation only allows broadcasting ``y`` over ``x``, so you need to
make sure ``x`` is big enough to hold the output result.
 *)

val atan2_ : ('a, 'b) t -> ('a, 'b) t -> unit
(**
``atan2_ x y`` is simiar to ``atan2`` function but the output is written to ``x``.
The broadcast operation only allows broadcasting ``y`` over ``x``, so you need to
make sure ``x`` is big enough to hold the output result.
 *)

val hypot_ : ('a, 'b) t -> ('a, 'b) t -> unit
(**
``hypot_ x y`` is simiar to ``hypot`` function but the output is written to ``x``.
The broadcast operation only allows broadcasting ``y`` over ``x``, so you need to
make sure ``x`` is big enough to hold the output result.
 *)

val fmod_ : ('a, 'b) t -> ('a, 'b) t -> unit
(**
``fmod_ x y`` is simiar to ``fmod`` function but the output is written to ``x``.
The broadcast operation only allows broadcasting ``y`` over ``x``, so you need to
make sure ``x`` is big enough to hold the output result.
 *)

val min2_ : ('a, 'b) t -> ('a, 'b) t -> unit
(**
``min2_ x y`` is simiar to ``min2`` function but the output is written to ``x``.
The broadcast operation only allows broadcasting ``y`` over ``x``, so you need to
make sure ``x`` is big enough to hold the output result.
 *)

val max2_ : ('a, 'b) t -> ('a, 'b) t -> unit
(**
``max2_ x y`` is simiar to ``max2`` function but the output is written to ``x``.
The broadcast operation only allows broadcasting ``y`` over ``x``, so you need to
make sure ``x`` is big enough to hold the output result.
 *)

val add_scalar_ : ('a, 'b) t -> 'a -> unit
(**
``add_scalar_ x y`` is simiar to ``add_scalar`` function but the output is
written to ``x``.
 *)

val sub_scalar_ : ('a, 'b) t -> 'a -> unit
(**
``sub_scalar_ x y`` is simiar to ``sub_scalar`` function but the output is
written to ``x``.
 *)

val mul_scalar_ : ('a, 'b) t -> 'a -> unit
(**
``mul_scalar_ x y`` is simiar to ``mul_scalar`` function but the output is
written to ``x``.
 *)

val div_scalar_ : ('a, 'b) t -> 'a -> unit
(**
``div_scalar_ x y`` is simiar to ``div_scalar`` function but the output is
written to ``x``.
 *)

val pow_scalar_ : ('a, 'b) t -> 'a -> unit
(**
``pow_scalar_ x y`` is simiar to ``pow_scalar`` function but the output is
written to ``x``.
 *)

val atan2_scalar_ : ('a, 'b) t -> 'a -> unit
(**
``atan2_scalar_ x y`` is simiar to ``atan2_scalar`` function but the output is
written to ``x``.
 *)

val fmod_scalar_ : ('a, 'b) t -> 'a -> unit
(**
``fmod_scalar_ x y`` is simiar to ``fmod_scalar`` function but the output is
written to ``x``.
 *)

val scalar_add_ : 'a -> ('a, 'b) t -> unit
(**
``scalar_add_ a x`` is simiar to ``scalar_add`` function but the output is
written to ``x``.
 *)

val scalar_sub_ : 'a -> ('a, 'b) t -> unit
(**
``scalar_sub_ a x`` is simiar to ``scalar_sub`` function but the output is
written to ``x``.
 *)

val scalar_mul_ : 'a -> ('a, 'b) t -> unit
(**
``scalar_mul_ a x`` is simiar to ``scalar_mul`` function but the output is
written to ``x``.
 *)

val scalar_div_ : 'a -> ('a, 'b) t -> unit
(**
``scalar_div_ a x`` is simiar to ``scalar_div`` function but the output is
written to ``x``.
 *)

val scalar_pow_ : 'a -> ('a, 'b) t -> unit
(**
``scalar_pow_ a x`` is simiar to ``scalar_pow`` function but the output is
written to ``x``.
 *)

val scalar_atan2_ : 'a -> ('a, 'b) t -> unit
(**
``scalar_atan2_ a x`` is simiar to ``scalar_atan2`` function but the output is
written to ``x``.
 *)

val scalar_fmod_ : 'a -> ('a, 'b) t -> unit
(**
``scalar_fmod_ a x`` is simiar to ``scalar_fmod`` function but the output is
written to ``x``.
 *)

val conj_ : ('a, 'b) t -> unit
(**
``conj_ x`` is similar to ``conj`` but output is written to ``x``
 *)

val abs_ : ('a, 'b) t -> unit
(**
``abs_ x`` is similar to ``abs`` but output is written to ``x``
 *)

val neg_ : ('a, 'b) t -> unit
(**
``neg_ x`` is similar to ``neg`` but output is written to ``x``
 *)

val reci_ : ('a, 'b) t -> unit
(**
``reci_ x`` is similar to ``reci`` but output is written to ``x``
 *)

val signum_ : ('a, 'b) t -> unit
(**
``signum_ x`` is similar to ``signum`` but output is written to ``x``
 *)

val sqr_ : ('a, 'b) t -> unit
(**
``sqr_ x`` is similar to ``sqr`` but output is written to ``x``
 *)

val sqrt_ : ('a, 'b) t -> unit
(**
``sqrt_ x`` is similar to ``sqrt`` but output is written to ``x``
 *)

val cbrt_ : ('a, 'b) t -> unit
(**
``cbrt_ x`` is similar to ``cbrt`` but output is written to ``x``
 *)

val exp_ : ('a, 'b) t -> unit
(**
``exp_ x`` is similar to ``exp_`` but output is written to ``x``
 *)

val exp2_ : ('a, 'b) t -> unit
(**
``exp2_ x`` is similar to ``exp2`` but output is written to ``x``
 *)

val exp10_ : ('a, 'b) t -> unit
(**
``exp2_ x`` is similar to ``exp2`` but output is written to ``x``
 *)

val expm1_ : ('a, 'b) t -> unit
(**
``expm1_ x`` is similar to ``expm1`` but output is written to ``x``
 *)

val log_ : ('a, 'b) t -> unit
(**
``log_ x`` is similar to ``log`` but output is written to ``x``
 *)

val log2_ : ('a, 'b) t -> unit
(**
``log2_ x`` is similar to ``log2`` but output is written to ``x``
 *)

val log10_ : ('a, 'b) t -> unit
(**
``log10_ x`` is similar to ``log10`` but output is written to ``x``
 *)

val log1p_ : ('a, 'b) t -> unit
(**
``log1p_ x`` is similar to ``log1p`` but output is written to ``x``
 *)

val sin_ : ('a, 'b) t -> unit
(**
``sin_ x`` is similar to ``sin`` but output is written to ``x``
 *)

val cos_ : ('a, 'b) t -> unit
(**
``cos_ x`` is similar to ``cos`` but output is written to ``x``
 *)

val tan_ : ('a, 'b) t -> unit
(**
``tan_ x`` is similar to ``tan`` but output is written to ``x``
 *)

val asin_ : ('a, 'b) t -> unit
(**
``asin_ x`` is similar to ``asin`` but output is written to ``x``
 *)

val acos_ : ('a, 'b) t -> unit
(**
``acos_ x`` is similar to ``acos`` but output is written to ``x``
 *)

val atan_ : ('a, 'b) t -> unit
(**
``atan_ x`` is similar to ``atan`` but output is written to ``x``
 *)

val sinh_ : ('a, 'b) t -> unit
(**
``sinh_ x`` is similar to ``sinh`` but output is written to ``x``
 *)

val cosh_ : ('a, 'b) t -> unit
(**
``cosh_ x`` is similar to ``cosh`` but output is written to ``x``
 *)

val tanh_ : ('a, 'b) t -> unit
(**
``tanh_ x`` is similar to ``tanh`` but output is written to ``x``
 *)

val asinh_ : ('a, 'b) t -> unit
(**
``asinh_ x`` is similar to ``asinh`` but output is written to ``x``
 *)

val acosh_ : ('a, 'b) t -> unit
(**
``acosh_ x`` is similar to ``acosh`` but output is written to ``x``
 *)

val atanh_ : ('a, 'b) t -> unit
(**
``atanh_ x`` is similar to ``atanh`` but output is written to ``x``
 *)

val floor_ : ('a, 'b) t -> unit
(**
``floor_ x`` is similar to ``floor`` but output is written to ``x``
 *)

val ceil_ : ('a, 'b) t -> unit
(**
``ceil_ x`` is similar to ``ceil`` but output is written to ``x``
 *)

val round_ : ('a, 'b) t -> unit
(**
``round_ x`` is similar to ``round`` but output is written to ``x``
 *)

val trunc_ : ('a, 'b) t -> unit
(**
``trunc_ x`` is similar to ``trunc`` but output is written to ``x``
 *)

val fix_ : ('a, 'b) t -> unit
(**
``fix_ x`` is similar to ``fix`` but output is written to ``x``
 *)

val erf_ : ('a, 'b) t -> unit
(**
``erf_ x`` is similar to ``erf`` but output is written to ``x``
 *)

val erfc_ : ('a, 'b) t -> unit
(**
``erfc_ x`` is similar to ``erfc`` but output is written to ``x``
 *)

val relu_ : ('a, 'b) t -> unit
(**
``relu_ x`` is similar to ``relu`` but output is written to ``x``
 *)

val softplus_ : ('a, 'b) t -> unit
(**
``softplus_ x`` is similar to ``softplus`` but output is written to ``x``
 *)

val softsign_ : ('a, 'b) t -> unit
(**
``softsign_ x`` is similar to ``softsign`` but output is written to ``x``
 *)

val sigmoid_ : ('a, 'b) t -> unit
(**
``sigmoid_ x`` is similar to ``sigmoid`` but output is written to ``x``
 *)

val softmax_ : ('a, 'b) t -> unit
(**
``softmax_ x`` is similar to ``softmax`` but output is written to ``x``
 *)

val cumsum_ : ?axis:int -> ('a, 'b) t -> unit
(**
``cumsum_ x`` is similar to ``cumsum`` but output is written to ``x``
 *)

val cumprod_ : ?axis:int -> ('a, 'b) t -> unit
(**
``cumprod_ x`` is similar to ``cumprod`` but output is written to ``x``
 *)

val cummin_ : ?axis:int -> ('a, 'b) t -> unit
(**
``cummin_ x`` is similar to ``cummin`` but output is written to ``x``
 *)

val cummax_ : ?axis:int -> ('a, 'b) t -> unit
(**
``cummax_ x`` is similar to ``cummax`` but output is written to ``x``
 *)

val dropout_ : ?rate:float -> ('a, 'b) t -> unit
(**
``dropout_ x`` is similar to ``dropout`` but output is written to ``x``
 *)

val elt_equal_ : ('a, 'b) t -> ('a, 'b) t -> unit
(**
``elt_equal_ x y`` is simiar to ``elt_equal`` function but the output is written
to ``x``. The broadcast operation only allows broadcasting ``y`` over ``x``, so you
need to make sure ``x`` is big enough to hold the output result.
 *)

val elt_not_equal_ : ('a, 'b) t -> ('a, 'b) t -> unit
(**
``elt_not_equal_ x y`` is simiar to ``elt_not_equal`` function but the output is
written to ``x``. The broadcast operation only allows broadcasting ``y`` over ``x``,
so you need to make sure ``x`` is big enough to hold the output result.
 *)

val elt_less_ : ('a, 'b) t -> ('a, 'b) t -> unit
(**
``elt_less_ x y`` is simiar to ``elt_less`` function but the output is written
to ``x``. The broadcast operation only allows broadcasting ``y`` over ``x``, so you
need to make sure ``x`` is big enough to hold the output result.
 *)

val elt_greater_ : ('a, 'b) t -> ('a, 'b) t -> unit
(**
``elt_greater_ x y`` is simiar to ``elt_greater`` function but the output is
written to ``x``. The broadcast operation only allows broadcasting ``y`` over ``x``,
so you need to make sure ``x`` is big enough to hold the output result.
 *)

val elt_less_equal_ : ('a, 'b) t -> ('a, 'b) t -> unit
(**
``elt_less_equal_ x y`` is simiar to ``elt_less_equal`` function but the output
is written to ``x``. The broadcast operation only allows broadcasting ``y`` over
``x``, so you need to make sure ``x`` is big enough to hold the output result.
 *)

val elt_greater_equal_ : ('a, 'b) t -> ('a, 'b) t -> unit
(**
``elt_greater_equal_ x y`` is simiar to ``elt_greater_equal`` function but the
output is written to ``x``. The broadcast operation only allows broadcasting ``y``
over ``x``, so you need to make sure ``x`` is big enough to hold the output result.
 *)

val elt_equal_scalar_ : ('a, 'b) t -> 'a -> unit
(**
``elt_equal_scalar_ x a`` is simiar to ``elt_equal_scalar`` function but the
output is written to ``x``.
 *)

val elt_not_equal_scalar_ : ('a, 'b) t -> 'a -> unit
(**
``elt_not_equal_scalar_ x a`` is simiar to ``elt_not_equal_scalar`` function but
the output is written to ``x``.
 *)

val elt_less_scalar_ : ('a, 'b) t -> 'a -> unit
(**
``elt_less_scalar_ x a`` is simiar to ``elt_less_scalar`` function but the
output is written to ``x``.
 *)

val elt_greater_scalar_ : ('a, 'b) t -> 'a -> unit
(**
``elt_greater_scalar_ x a`` is simiar to ``elt_greater_scalar`` function but the
output is written to ``x``.
 *)

val elt_less_equal_scalar_ : ('a, 'b) t -> 'a -> unit
(**
``elt_less_equal_scalar_ x a`` is simiar to ``elt_less_equal_scalar`` function
but the output is written to ``x``.
 *)

val elt_greater_equal_scalar_ : ('a, 'b) t -> 'a -> unit
(**
``elt_greater_equal_scalar_ x a`` is simiar to ``elt_greater_equal_scalar``
function but the output is written to ``x``.
 *)


(** {6 Matrix functions}  *)

type area = { a : int; b : int; c : int; d : int }
(** Refer to :doc:`owl_dense_matrix_generic` *)

val area : int -> int -> int -> int -> area
(** Refer to :doc:`owl_dense_matrix_generic` *)

val copy_area_to : ('a, 'b) t -> area -> ('a, 'b) t -> area -> unit
(** Refer to :doc:`owl_dense_matrix_generic` *)

val row_num : ('a, 'b) t -> int
(** Refer to :doc:`owl_dense_matrix_generic` *)

val col_num : ('a, 'b) t -> int
(** Refer to :doc:`owl_dense_matrix_generic` *)

val row : ('a, 'b) t -> int -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val col : ('a, 'b) t -> int -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val rows : ('a, 'b) t -> int array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val cols : ('a, 'b) t -> int array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val copy_row_to : ('a, 'b) t -> ('a, 'b) t -> int -> unit
(** Refer to :doc:`owl_dense_matrix_generic` *)

val copy_col_to : ('a, 'b) t -> ('a, 'b) t -> int -> unit
(** Refer to :doc:`owl_dense_matrix_generic` *)

val dot : ('a, 'b) t -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val diag : ?k:int -> ('a, 'b) t -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val trace : ('a, 'b) t -> 'a
(** Refer to :doc:`owl_dense_matrix_generic` *)

val to_rows : ('a, 'b) t -> ('a, 'b) t array
(** Refer to :doc:`owl_dense_matrix_generic` *)

val of_rows : ('a, 'b) t array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val to_cols : ('a, 'b) t -> ('a, 'b) t array
(** Refer to :doc:`owl_dense_matrix_generic` *)

val of_cols : ('a, 'b) t array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val to_arrays : ('a, 'b) t -> 'a array array
(** Refer to :doc:`owl_dense_matrix_generic` *)

val of_arrays : ('a, 'b) kind -> 'a array array -> ('a, 'b) t
(** Refer to :doc:`owl_dense_matrix_generic` *)

val draw_rows : ?replacement:bool -> ('a, 'b) t -> int -> ('a, 'b) t * int array
(** Refer to :doc:`owl_dense_matrix_generic` *)

val draw_cols : ?replacement:bool -> ('a, 'b) t -> int -> ('a, 'b) t * int array
(** Refer to :doc:`owl_dense_matrix_generic` *)

val draw_rows2 : ?replacement:bool -> ('a, 'b) t -> ('a, 'b) t -> int -> ('a, 'b) t * ('a, 'b) t * int array
(** Refer to :doc:`owl_dense_matrix_generic` *)

val draw_cols2 : ?replacement:bool -> ('a, 'b) t -> ('a, 'b) t -> int -> ('a, 'b) t * ('a, 'b) t * int array
(** Refer to :doc:`owl_dense_matrix_generic` *)


(* ends here *)
