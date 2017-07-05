## N-dimensional Array

Multi-dimensional array (i.e., n-dimensional array) is extremely useful in scientific computing, e.g., computer vision, image processing, and etc. Therefore, n-dimensional array support is necessary in modern numerical libraries.

Owl has two very powerful modules to manipulate dense n-dimensional arrays. One is `Ndarray`, and the other is `Ndview`. `Ndarray` is very similar to the corresponding modules in Numpy and Julia, whereas `Ndview` is specifically optimised for pipelining the operations on the ndarray.

In this tutorial, I will only focus on the `Ndarray` module, and I will present a series of examples to walk you through the functionality in the module.


## Create N-dimensional Arrays

With `Ndarray` module, you can create four types of n-dimensional arrays: single precision float numbers `float32`, double precision float numbers `float64`, single precision complex numbers `complex32`, and double precision complex numbers `complex64` through four submodules: `Ndarray.S`, `Ndarray.D`, `Ndarray.C`, and `Ndarray.Z`.

First, we can create empty ndarrays of shape `[|3;4;5|]` with the following code. Because `Ndarray` is built atop of `Bigarray`, it supports maximum 16 dimensions. For even higher dimensions, Owl will provides a separate module to support high-dimensional sparse ndarrays in the future.

```ocaml
let x0 = Dense.Ndarray.S.empty [|3;4;5|];;
let x1 = Dense.Ndarray.D.empty [|3;4;5|];;
let x2 = Dense.Ndarray.C.empty [|3;4;5|];;
let x3 = Dense.Ndarray.Z.empty [|3;4;5|];;
```

The elements in a ndarray are not initialised by calling `empty` function. You can certainly assign the initial values to the elements by calling `create`, generate a zero/one ndarray by calling `zeros` or `ones`, or even create a random ndarray by calling `uniform`.

```ocaml
Dense.Ndarray.C.zeros [|3;4;5|];;
Dense.Ndarray.D.ones [|3;4;5|];;
Dense.Ndarray.S.create [|3;4;5|] 1.5;;
Dense.Ndarray.Z.create [|3;4;5|] Complex.({im=1.5; re=2.5});;
Dense.Ndarray.D.uniform [|3;4;5|];;
```

There is an alias `Arr` for `Dense.Ndarray.D`, so we will use `Arr` module in the following examples.

If you want to assign the initial values in a more complicated way. You can first create an empty ndarray, then call the `map` function in Ndarray module. The following example calls Owl's `Stats.Rnd.gaussian` function to initialised each element in `x`.

```ocaml
let x = Arr.zeros[|3;4;5|] |> Arr.map (fun _ -> Stats.Rnd.gaussian ());;
```

Then you can print `x` out using `` function to check the element values.

```ocaml
Arr.print x;;
```


## Obtain Ndarray Properties

There are a set of functions you can call to obtain the basic properties of a n-dimensional array.

```ocaml
Arr.shape x;;       (* return the shape of the ndarray *)
Arr.num_dims x;;    (* return the number of dimensions *)
Arr.nth_dim x 0;;   (* return the size of first dimension *)
Arr.numel x;;       (* return the number of elements *)
Arr.nnz x;;         (* return the number of non-zero elements *)
Arr.density x;;     (* return the percent of non-zero elements *)
```

You can check whether two ndarrays have the same shape by `same_shape` function.

```ocaml
Arr.same_shape x y;;
```

## Access and Manipulate Ndarrays

The standard way of accessing and modifying the elements in a ndarray is `get` and `set` functions. You need to pass in the index of the element to indicate which element you want to access. Moreover, the modification by calling `set` is in place.

```ocaml
Arr.get x [|0;1;1|];;
Arr.set x [|0;1;1|] 2.;;
```

Using `fill`, you can set all the elements to one value at once instead of calling `set` in a loop.

```ocaml
Arr.fill x 5.;;
```

You can make a copy of a ndarray using `clone`, or copy the elements in one ndarray to another using `copy`.

```ocaml
let y = Arr.clone x;;
let z = Arr.(empty (shape x));;
Arr.copy x z;;
```

A ndarray can be flattened or reshaped, but you need to make sure the total number of elements is the same before and after reshaping. Reshaping will not modify the original data but make a copy of the ndarray.

```ocaml
let y = Arr.flatten x;;
let z = Arr.reshape x [|5;4;3|];;
```

You can transpose a ndarray along multiple axes by calling `transpose` function. The parameter passed to `transpose` must be a valid permutation of axis indices. E.g., for the previously created three-dimensional ndarray `x`, it can be

```ocaml
let y = Arr.transpose ~axis:[|0;1;2|] x;;  (* no changes actually *)
let y = Arr.transpose ~axis:[|0;2;1|] x;;
let y = Arr.transpose ~axis:[|1;0;2|] x;;
let y = Arr.transpose ~axis:[|1;2;0|] x;;
let y = Arr.transpose ~axis:[|2;0;1|] x;;
let y = Arr.transpose ~axis:[|2;1;0|] x;;
```

If you only want to swap two axes, you can call `swap` instead of `transpose`. The following two lines of code are equivalent.

```ocaml
let y = Arr.swap 0 1 x;;
let y = Arr.transpose ~axis:[|1;0;2|] x;;
```


## Define a Slice in Ndarray

It is possible to iterate a ndarray in various ways. However, before we introduce these iteration function, I want to spend some efforts in explaining the "slice definition" in `Ndarray`.

Owl provides a simple yet flexible and powerful way to define a "slice". Logically, a slice of data in a ndarray is those elements whose indices with some fixed axes. E.g., using the previously defined `x` of dimension `[|3;4;5|]`, a slice can be logically defined as `(0;*;*)`, which refers to the data of the following indices: `(0;0;0)`; `(0;0;1)`; `(0;0;2)`; `(0;0;3)` ... `(0;1;0)`; `(0;1;1)`; `(0;1;2)` ... `(0;3;3)`; `(0;3;4)`.

With `Bigarray` module, you can take a slice out by fixing some of the left-most axes if you use `c-layout`, or fixing right-most axes if you use `fortran-layout`. However, no matter which layout, the fixed axes need to be continuous. That means you cannot define a slice like this `(*;1;*)`, which only takes `(0;1;0)`; `(0;1;1)`; `(0;1;2)` ... `(2;1;0)`; `(2;1;1)`; `(2;1;2)` ...

Comparing to the "`Bigarray.slice_left`" function, the slice in Owl's `Ndarray` does not have to start from the left-most or right-most axes and they are not necessarily continuous. E.g., for the previously defined `[|3;4;5|]` ndarray `x`, you can define a slice in the following ways:

```ocaml
let s0 = [|None; None; None|]      (* (*,*,*), essentially the whole ndarray as one slice *)
let s1 = [|Some 0; None; None|]    (* (0,*,*) *)
let s2 = [|None; Some 2; None|]    (* (*,2,*) *)
let s3 = [|None; None; Some 1|]    (* (*,*,1) *)
let s4 = [|Some 1; None; Some 2|]  (* (1,*,2) *)
...
```

However, as you move towards the right-most axes, the size of a continuous block in the memory becomes smaller and smaller (due to the default `c-layout` used in Owl). In the extreme case, you fix the right-most axes like `[|None; None; Some 1|]` which has continuous block size 1.


## Iterate Elements in a Slice

With the slice definition above, we can iterate and map the elements in a slice. E.g., we add one to all the elements in slice `(0,*,*)`.

```ocaml
Arr.map ~axis:[|Some 0; None; None|] (fun a -> a +. 1.) x;;
```

There are more functions to help you to iterate elements and slices in a ndarray: `iteri`, `iter`, `mapi`, `map`, `filteri`, `filter`, `foldi`, `fold`, `iteri_slice`, `iter_slice`, `iter2i`, `iter2`. Please refer to the documentation for their details.

One thing to emphasise is that - when you iterate elements, **do NOT ever modify the index passed in directly!** Instead, please make a copy of the passed in index, then modify the copy if necessary.


## Basic Maths Functions

With those created ndarrays, you can do some math operations as below.

```ocaml
let x = Arr.uniform [|3;4;5|];;
let y = Arr.uniform [|3;4;5|];;
let z = Arr.add x y;;
Arr.print z;;
```

Owl supports many math operations and these operations have been well vectorised (by underlying BLAS and LAPACK libraries) so they are very fast.

```ocaml
Arr.sin x;;
Arr.tan x;;
Arr.exp x;;
Arr.log x;;
Arr.min x;;
Arr.add_scalar x 2.;;
Arr.mul_scalar x 2.;;
...
```

For the complete list of maths functions, please refer to the [Ndarray documentation] (https://github.com/ryanrhymes/owl/blob/master/lib/owl_dense_ndarray.mli). You can certainly implement your own functions then apply it to the ndarray elements by calling `map` function.


## Examine Elements and Compare Ndarrays

Examining elements and comparing two ndarrays are also very easy.

```ocaml
Arr.is_zero x;;
Arr.is_positive x;;
Arr.is_negative x;;
Arr.is_nonpositive x;;
Arr.is_nonnegative x;;
...
Arr.is_equal x y;;
Arr.is_unequal x y;;
Arr.is_greater x y;;
Arr.is_smaller x y;;
Arr.equal_or_greater x y;;
Arr.equal_or_smaller x y;;
...
```

You can certainly plug in your own functions to check each elements.

```ocaml
Arr.exists ((>) 2.) x;;
Arr.not_exists ((<) 2.) x;;
Arr.for_all ((=) 2.) x;;
```

Similar to matrix operations, `Ndarray` also provide a set of shorthand infix operators to simplify your code.
