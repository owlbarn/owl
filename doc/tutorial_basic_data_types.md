Array and Matrix are the building block of Owl library. Obviously, matrix is a special case of n-dimensional array, and in fact many functions in Matrix module calls the functions in Ndarray directly.

For both n-dimensional array and matrix, Owl supports: both dense and sparse data structures; both single and double precisions; both real and complex number. Therefore, there are 16 basic data types which we will introduce in this short tutorial.

In the following examples, I suppose you already loaded `Owl` library with `#require "owl"`, and opened `Owl` module with `open Owl` in `utop`. If you don't have `Owl` installed locally, you can still try the examples by pulling a ready-made docker images of the latest `Owl` with the following commands.

```bash
docker pull ryanrhymes/owl
docker run -t -i ryanrhymes/owl
```

OK, let's start.


## Module Structure

In Owl, `Dense` module contains the modules of dense data structures. For example, `Dense.Matrix` supports the operations of dense matrices. Similarly, `Sparse` module contains the modules of sparse data structures.

```ocaml
Dense.Ndarray   (* dense ndarray *)
Dense.Matrix    (* dense matrix *)

Sparse.Ndarray  (* sparse ndarray *)
Sparse.Matrix   (* sparse ndarray *)
```

All these four modules consists of five submodules to handle different types of numbers.

* `S` module supports single precision float numbers `float32`;
* `D` module supports double precision float numbers `float64`;
* `C` module supports single precision complex numbers `complex32`;
* `Z` module supports double precision complex numbers `complex64`;
* `Generic` module supports all aforementioned number types via GADT.

With `Dense.Ndarray`, you can create a dense n-dimensional array of no more than 16 dimensions. This constraint originates from the underlying `Bigarray.Genarray` module. In practice, this constraint makes sense since the space requirement will explode as the dimension increases. If you need anything higher than 16 dimensions, you need to use `Sparse.Ndarray` to create a sparse data structure.

Because we often use double precision float numbers in many programming tasks, to save some efforts, there are also some aliases in `Owl` module.

* `Arr` is an alias for `Dense.Ndarray.D`;
* `Mat` is an alias for `Dense.Matrix.D`;
* `Vec` is an alias for `Dense.Vector.D`;

After opening `Owl` module, you can use `Mat.zeros 4 4` instead of `Dense.Matrix.D.zeros 4 4`.


## Number & Precision

After deciding the suitable data structure (either dense or sparse), you can create a ndarray/matrix using creation function in the modules: e.g., `empty`, `create`, `zeros`, `ones` ... The type of numbers (real or complex) and its precision (single or double) needs to be passed to the creations functions as the parameters.

Herein, we use creation fucntion `zeros` as an example. With `zeros` function, all the elements in the created data structure will be initialised to zeros.

The following examples are for dense ndarrays.

```ocaml
Dense.Ndarray.S.zeros [|5;5|];;    (* single precision real ndarray *)
Dense.Ndarray.D.zeros [|5;5|];;    (* double precision real ndarray *)
Dense.Ndarray.C.zeros [|5;5|];;    (* single precision complex ndarray *)
Dense.Ndarray.Z.zeros [|5;5|];;    (* double precision complex ndarray *)
```

The following examples are for dense matrices.

```ocaml
Dense.Matrix.S.zeros 5 5;;     (* single precision real matrix *)
Dense.Matrix.D.zeros 5 5;;     (* double precision real matrix *)
Dense.Matrix.C.zeros 5 5;;     (* single precision complex matrix *)
Dense.Matrix.Z.zeros 5 5;;     (* double precision complex matrix *)
```

The following examples are for sparse ndarrays.

```ocaml
Sparse.Ndarray.S.zeros [|5;5|];;    (* single precision real ndarray *)
Sparse.Ndarray.D.zeros [|5;5|];;    (* double precision real ndarray *)
Sparse.Ndarray.C.zeros [|5;5|];;    (* single precision complex ndarray *)
Sparse.Ndarray.Z.zeros [|5;5|];;    (* double precision complex ndarray *)
```

The following examples are for sparse matrices.

```ocaml
Sparse.Matrix.S.zeros 5 5;;     (* single precision real matrix *)
Sparse.Matrix.D.zeros 5 5;;     (* double precision real matrix *)
Sparse.Matrix.C.zeros 5 5;;     (* single precision complex matrix *)
Sparse.Matrix.Z.zeros 5 5;;     (* double precision complex matrix *)
```

## Polymorphic Functions

Even through you can create four different types of data structure with one module (using different precision and number types), it does not mean you need different functions to process them in Owl. Polymorphism is achieved by pattern matching and GADT.

Herein I use the `sum` function in `Dense.Matrix.Generic` module as an example. `sum` function returns the summation of all the elements in a matrix.

```ocaml
let x = Dense.Matrix.S.eye 5 in Dense.Matrix.Generic.sum x;;
let x = Dense.Matrix.D.eye 5 in Dense.Matrix.Generic.sum x;;
let x = Dense.Matrix.C.eye 5 in Dense.Matrix.Generic.sum x;;
let x = Dense.Matrix.Z.eye 5 in Dense.Matrix.Generic.sum x;;
```

As we can see, no matter what kind of numbers are held in an identity matrix, we always pass it to `Dense.Matrix.Generic.sum` function. Similarly, we can do the same thing for other modules (`Dense.Ndarray`, `Sparse.Matrix`, and etc.) and other functions (`add`, `mul`, `neg`, and etc.).

However, there is no need to do so (i.e. passing the variables to `Generic` module) in practical programming since each submodule already contains the same set of operations. E.g, as below,

```ocaml
Dense.Matrix.S.(eye 5 |> sum);;
```


## Shortcuts to Double Precision Matrix

However, always passing type information into creation function may turn out to be a pain for some people. In reality, we often work with double precision numbers on most platforms nowadays. Therefore, Owl provides some shortcuts to the data structures of double precision float numbers:

* `Arr` is equivalent to double precision real `Dense.Ndarray.D`;
* `Mat` is equivalent to double precision real `Dense.Matrix.D`;
* `Vec` is equivalent to double precision real `Dense.Vector.D`;

With these shortcut modules, you are no longer required to pass in type information (e.g., in creation functions). Here are some examples as below.

```ocaml
Arr.zeros [|5|];;        (* same as Dense.Ndarray.D.zeros [|5|] *)
Mat.zeros 5 5;;          (* same as Dense.Matrix.D.zeros 5 5 *)
Vec.ones 5;;             (* same as Dense.Vector.D.ones 5 *)
...
```

More examples besides creation functions are as follows.

```ocaml
Mat.load "data.mat";;    (* same as Dense.Matrix.D.load "data.mat" *)
Mat.of_array 5 5 x;;     (* same as Dense.Matrix.D.of_array 5 5 x *)
Mat.linspace 0. 9. 10;;  (* same as Dense.Matrix.D.linspace 0. 9. 10 *)
...
```

In general, it is recommended to use these shortcut modules to operate matrices unless you really want to control the precision by yourself. If you actually often work on other number types like Complex, you can certainly make your own alias to corresponding `S`, `D`, `C`, and `Z` module if you like.


## Casting into Another Type

As I mentioned before, there are four basic types for each module. You cast one value into another type by using the `cast_*` functions in `Generic` module. Here I only list the functions for `Ndarray` module, there are similar functions also for `Matrix` module.

* `Generic.cast_s2d`: cast from `float32` to `float64`;
* `Generic.cast_d2s`: cast from `float64` to `float32`;
* `Generic.cast_c2z`: cast from `complex32` to `complex64`;
* `Generic.cast_z2c`: cast from `complex64` to `complex32`;
* `Generic.cast_s2c`: cast from `float32` to `complex32`;
* `Generic.cast_d2z`: cast from `float64` to `complex64`;
* `Generic.cast_s2z`: cast from `float32` to `complex64`;
* `Generic.cast_d2c`: cast from `float64` to `complex32`;


## More in Documents

To know more about the functions provided in each module, please read the corresponding interface file of `Generic` module. The `Generic` module contains the documentation of all the operations that the other four submodules (i.e., `S`, `D`, `C`, `Z`) can do.

* `Dense.Ndarray.Generic`: [owl_dense_ndarray_generic](https://github.com/ryanrhymes/owl/blob/master/lib/owl_dense_ndarray_generic.mli)
* `Dense.Matrix.Generic`: [owl_dense_matrix_generic](https://github.com/ryanrhymes/owl/blob/master/lib/owl_dense_matrix_generic.mli)
* `Sparse.Ndarray.Generic`: [owl_sparse_ndarray_generic](https://github.com/ryanrhymes/owl/blob/master/lib/owl_dense_ndarray_generic.mli)
* `Sparse.Matrix.Generic`: [owl_sparse_matrix_generic](https://github.com/ryanrhymes/owl/blob/master/lib/owl_sparse_matrix_generic.mli)

Enjoy Owl! Happy hacking!
