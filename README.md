# Owl - An OCaml Numerical Library

%%VERSION%% travis-ci: [![Travis build Status](https://travis-ci.org/ryanrhymes/owl.svg?branch=master)](https://travis-ci.org/owlbarn/owl)

Owl is an emerging numerical library for scientific computing and engineering. The library is developed in the OCaml language and inherits all its powerful features such as static type checking, powerful module system, and superior runtime efficiency. Owl allows you to write succinct type-safe numerical applications in functional language without sacrificing performance, significantly reduces the cost from prototype to production use.

Behind the scene, Owl builds the advanced numerical functions atop of its solid implementation of n-dimensional arrays. Quite different from other libraries, algorithmic differentiation and distributed computing have been included as integral components in the core library to maximise developers' productivity. Owl is young but grows fast, the current features include:

* N-dimensional array (both dense and sparse)
* Various number types: `float32`, `float64`, `complex32`, `complex64`, `int8`, `int16`, `int32` ...
* Linear algebra and full interface to CBLAS and LAPACKE
* Algorithmic differentiation (or automatic differentiation)
* Neural network module for deep learning applications
* Dynamic computational graph allowing greatest flexibility for applications
* Parallel and Distributed engine (map-reduce, parameter server, etc.)
* Advanced math and stats functions (e.g., hypothesis tests, MCMC, etc.)
* Zoo system for efficient scripting and code sharing
* GPU support (work in progress ...)

You can reach us in the following ways, looking forward to hearing from you!

- [Email Me](mailto:liang.wang@cl.cam.ac.uk)
- [Slack Channel](https://join.slack.com/t/owl-dev-team/shared_invite/enQtMjQ3OTM1MDY4MDIwLTA3MmMyMmQ5Y2U0NjJiNjI0NzFhZDAwNGFhODBmMTk4N2ZmNDExYjZiMzI2N2M1MGNiMTUyYTQ5MTAzZjliZDI)



## Learning

Owl's documentation contains a lot of learning materials to help you start. The full documentation consists of two parts: [Tutorial Book](http://www.cl.cam.ac.uk/~lw525/owl/chapter/index.html) and [API Reference](http://www.cl.cam.ac.uk/~lw525/owl/apidoc/index.html). Both are perfectly synchronised with the code in the repository by the automatic building system. You can access both parts with the following link.

* [Owl's Full Documentation](http://www.cl.cam.ac.uk/~lw525/owl/)



## Installation

Owl requires OCaml `>=4.06.0`. The installation is rather trivial. There are four possible ways to try out Owl, as shown below, from the most straightforward one to the least one.

### Option 1: Install from OPAM

You can simply type the following in the command line to start.

```bash
opam install owl
```

Owl's current version on OPAM is `0.2.9`, and it lags way behind the master branch (current `0.3.4`) and misses many new features. If you want to try the newest version, I recommend the other three ways to install.

### Option 2: Pull from Docker Hub

You only need to pull in [Owl's docker image](https://hub.docker.com/r/ryanrhymes/owl/) and start a container, then play with it in `utop`. The source code is stored in `/root/owl` directory.

```bash
docker pull ryanrhymes/owl
docker run -t -i ryanrhymes/owl
```

There are several Linux distributions provided including an [ARM-based Ubuntu](https://github.com/ryanrhymes/owl/blob/master/docker/Dockerfile.ubuntu.arm). You can pull in a specific Owl image with corresponding tags.

```bash
docker pull ryanrhymes/owl:ubuntu
docker pull ryanrhymes/owl:debian
docker pull ryanrhymes/owl:alpine
docker pull ryanrhymes/owl:centos
docker pull ryanrhymes/owl:opensuse
docker pull ryanrhymes/owl:fedora
```

All these images are perfectly synced with the master branch by automatic building. You can check the building history on [Docker Hub](https://hub.docker.com/r/ryanrhymes/owl/builds/).

### Option 3: Pin the Dev-Repo

`opam pin` allows us to pin the local code to Owl's development repository on Github. The first command `opam depext` installs all the dependencies Owl needs.

```bash
opam depext owl
opam pin add owl --dev-repo
```

### Option 4: Compile from Source

First, you need to clone the repository.

```bash
git clone git@github.com:ryanrhymes/owl.git
```

Second, you need to figure out the missing dependencies and install them.

```bash
jbuilder external-lib-deps --missing @install
```

Last, this is perhaps the most classic step.

```bash
make && make install
```

### CBLAS/LAPACKE Dependency

The most important dependency is [OpenBLAS](https://github.com/xianyi/OpenBLAS). Linking to the correct OpenBLAS is the key to achieve the best performance. Depending on the specific platform, you can use `yum`, `apt-get`, `brew` to install the binary format. For example on Mac OSX,

```bash
brew install homebrew/science/openblas
```

However, installing from OpenBLAS source code leads to way better performance in my own experiment. In future, the dependency on OpenBLAS should also be resolved by `opam` automatically.

### Integration to Toplevel

Owl is well integrated with `utop`. You can use `utop` to try out the experiments in our tutorials. If you want `utop` to automatically load Owl for you, you can also edit `.ocamlinit` file in your home folder by adding the following lines. (Note that the library name is `owl` with lowercase `o`.)

```bash
#require "owl-top"
```

The `owl-top` is the toplevel library of Owl, it automatically loads `owl` core library and installs the corresponding pretty printers of various data types.


## Access Modules

`Owl` currently has the following core modules and their names all start with `Owl_` to avoid name conflicts, e.g., `Owl_dense`, `Owl_sparse`, `Owl_maths`, `Owl_stats`, `Owl_const`, `Owl_fft`, `Owl_plot` and etc. After `utop` successfully loads `Owl` library, you can access the module functions using aforementioned names.

However, a more convenient way is to use `Owl` module as an entry point which provides aliases of the core module names for easy access, e.g., `Owl.Dense` is the same as `Owl_dense`, and `Owl.Regression` is the same as `Owl_regression`. Given no name conflicts, you can simply open the whole `Owl` module for convenience as I will do in the rest of this tutorial.

```ocaml
open Owl;;
```


## Create Matrices

[`Dense.Matrix`](https://github.com/ryanrhymes/owl/blob/master/lib/owl_dense_matrix.ml) module supports dense matrix operations while [`Sparse.Matrix`](https://github.com/ryanrhymes/owl/blob/master/lib/owl_sparse_matrix.ml) module supports sparse ones. There are five submodules in `Dense.Matrix`:

* `Dense.Matrix.S` module supports single precision float numbers `float32`;
* `Dense.Matrix.D` module supports double precision float numbers `float64`;
* `Dense.Matrix.C` module supports single precision complex numbers `complex32`;
* `Dense.Matrix.Z` module supports double precision complex numbers `complex64`;
* `Dense.Matrix.Generic` module supports all aforementioned number types via GADT.

To start, we can use `Dense.Matrix.D.uniform_int` to create a 5x5 random dense matrix.

```ocaml
let x = Dense.Matrix.D.uniform_int 5 5;;
```

You should see the following output in `utop`.

```bash
   C0 C1 C2 C3 C4
R0 25  2 77 85 72
R1 71 92 98 87 53
R2 35 29 82 65 20
R3  2 29 66 42 12
R4 99 72 78 30 11
val x : Owl_dense_matrix_d.mat =
```

To save some typing efforts, we have made `Mat` as an alias of `Dense.Matrix.D` by assuming 64-bit float numbers are commonly used. Therefore, we can use `Mat` directly after open `Owl` instead of using `Dense.Matrix.D`. Similarly, there are also aliases for 64-bit float vectors and ndarrays (i.e., `Vec` and `Arr`) but we will talk about them later. `Mat` module also provides other functions to create various matrices, e.g., as below.

```ocaml
let x = Mat.eye 5;;             (* identity matrix *)
let x = Mat.zeros 5 5;;         (* all elements are zeros *)
let x = Mat.ones 5 5;;          (* all elements are ones *)
let x = Mat.uniform 5 5;;       (* random matrix of uniform distribution *)
let x = Mat.gaussian 5 5;;      (* random matrix of gaussian distribution *)
let x = Mat.triu x;;            (* Upper triangular matrix *)
let x = Mat.toeplitz v;;        (* Toeplitz matrix *)
let x = Mat.hankel v;;          (* Hankel matrix *)
let x = Mat.hadamard 8;;        (* Hadamard matrix *)
let x = Mat.magic 8;;           (* Magic square matrix *)
...
```

Combined with `Stats` module, you can also create any matrices of many distributions. E.g., the following code first creates an empty dense matrix, then initialise the elements with Bernoulli distribution. Test it in `utop`, you should get a dense matrix where half of the elements are zeros.

```ocaml
let x = Mat.empty 8 8 |> Mat.map (fun _ -> Stats.Rnd.bernoulli 0.5 |> float_of_int);;
```

Or create a matrix where the elements follow Laplace distribution.

```ocaml
let x = Mat.empty 8 8 |> Mat.map (fun _ -> Stats.Rnd.laplace 0.2);;
```

With `Dense` module, you can also generate linearly spaced interval and meshgrids, e.g.,

```ocaml
let x = Mat.linspace 0. 5. 6;;
```
which will return a 1x5 row vector as below
```bash
   C0  C1  C2  C3  C4  C5
R0  0   1   2   3   4   5
val x : Owl_dense_matrix_d.mat =
```

The created matrices can be casted into other number types easily. For example the following code casts a `float32` matrix `x` into `complex64` matrix `y`.

```ocaml
let x = Dense.Matrix.S.uniform 3 3;;
let y = Dense.Matrix.Generic.cast_s2z x;;
```

Matrices can be saved to and loaded from a file.

```ocaml
Mat.save x "matrix_01.data";;  (* save the matrix to a file *)
Mat.load "matrix_01.data";;    (* load the matrix from a file *)
```


## Access Elements, Rows, and Columns

Both `Dense.Matrix` and `Sparse.Matrix` modules provide a wide range of operations to access the elements, rows, and columns of a matrix. You can refer to the full document in [`Dense.Matrix.Generic`](http://www.cl.cam.ac.uk/~lw525/owl/apidoc/owl_dense_matrix_generic.html). Here we just gave some simple examples briefly.

You can use `Mat.set` and `Mat.get` to manipulate individual element.

```ocaml
Mat.set x 0 1 2.5;;
Mat.get x 0 1;;
```

More conveniently, Owl provides a set of extending indexing and slicing operators as below. You can learn more in the tutorial on [Indexing and Slicing](http://www.cl.cam.ac.uk/~lw525/owl/chapter/slicing.html).

```ocaml
x.%{ [|0; 1|] } <- 2.5;;      (* Mat.set x 0 1 2.5 *)
x.%{ [|0; 1|] };;             (* Mat.get x 0 1 *)
x.${ [[0;4]; [6;-1]] };;      (* Mat.get_slice *)
x.${ [[0;4]; [6;-1]] } <- b;; (* Mat.set_slice *)
```

We can use `Mat.row` and `Mat.col` to retrieve a specific row or column of a matrix, or use `Mat.rows` and `Mat.cols` to retrieve multiple of them.

```ocaml
Mat.row x 5;;            (* retrieve the fifth row *)
Mat.cols x [|1;3;2|];;   (* retrieve the column 1, 3, and 2 *)
```

E.g., the following code generates a random matrix, then scales up each element by a factor of 10 using `Mat.map` function.

```ocaml
let x = Mat.(uniform 6 6 |> map (fun x -> x *. 10.));;
```

We can iterate a matrix row by row, or column by column. The following code calculates the sum of each row by calling `Mat.map_rows` function.

```ocaml
let x = Mat.(uniform 6 6 |> map_rows sum);;
```

We can fold elements by calling `Mat.fold`, fold rows by calling `Mat.fold_rows`. Similarly, there are also functions for `filter` operations. The following code filters out the elements not greater than 0.1 in x.

```ocaml
Mat.filter ((>) 0.1) x;;    (* not greater than 0.1 in x *)
```

We can also do something more complicated, e.g., by filtering out the rows whose summation is greater than 3.

```ocaml
Mat.filter_rows (fun r -> Mat.sum r > 3.) x;;
```

Shuffle the rows and columns, or draw some of them from a matrix.

```ocaml
Mat.shuffle_rows x;;     (* shuffle the rows in x *)
Mat.draw_cols x 3;;      (* draw 3 columns from x with replacement *)
...
```

Practically, `Sparse.Matrix` module provides a subset of the similar operations for sparse matrices. In addition, `Sparse.Matrix` module also has extra functions such as only iterating non-zero elements `Sparse.Matrix.Generic.iter_nz`, and etc. Please read the full documentation for [`Sparse.Matrix.Generic`](http://www.cl.cam.ac.uk/~lw525/owl/apidoc/owl_sparse_matrix_generic.html) for details.


## Linear Algebra

Simple matrix mathematics like add, sub, multiplication, and division are included in `Dense` module. Moreover, there are predefined shorthands for such operations. E.g., the following code creates two random matrices then compare which is greater.

```ocaml
let x = Mat.uniform 6 6;;
let y = Mat.uniform 6 6;;
Mat.(x > y);;                (* is x greater than y? return boolean *)
Mat.(x = y);;                (* is x equal to y? *)
Mat.(x =~ y);;               (* is x approximately equal to y? *)
Mat.(x <. y);;               (* is x smaller than y? return 0/1 matrix *)
...
```

Owl natively supports broadcast operation similar to other numerical libraries. Some basic math operations includes:

```ocaml
Mat.(x + y);;                (* addition of two matrices *)
Mat.(x * y);;                (* element-wise multiplication *)
Mat.(x *@ y);;               (* matrix multiplication of two matrices *)
Mat.(x +$ 2.);;              (* add a scalar to all elements in x *)
...
```

Apply various functions in `Maths` module to every element in x

```ocaml
Mat.(Maths.atanh @@ x);;        (* apply atanh function *)
Mat.(Maths.airy_Ai @@ x);;      (* apply Airy function *)
...
```

However, it is worth pointing out that `Mat` already implements many useful math functions. These functions are vectorised and are much faster than the example above which actually calls `Mat.map` for transformation.

```ocaml
Mat.sin x;;         (* call sine function *)
Mat.erfc x;;        (* call erfc function *)
Mat.round x;;       (* call round function *)
Mat.signum x;;      (* call signum function *)
Mat.sigmoid x;;     (* apply sigmoid function *)
...
```

Concatenate two matrices, vertically or horizontally by

```ocaml
Mat.(x @= y);;              (* equivalent to Mat.concat_vertical *)
Mat.(x @|| y);;             (* equivalent to Mat.concat_horizontal *)
Mat.concatenate [|x;...|];; (* concatenate a list of matrices along rows *)
```

More advanced linear algebra operations such as `svd`, `qr`, and `cholesky` decomposition are included in `Linalg` module. `Linalg` module also supports both real and complex number of single and double precision.

```ocaml
let u,s,v = Linalg.D.svd x;;     (* singular value decomposition *)
let q,r = Linalg.D.qr x;;        (* QR decomposition *)
let l,u,_ = Linalg.D.lu x;;      (* LU decomposition *)
let l = Linalg.D.chol x;;        (* cholesky decomposition *)
...
let e, v = Linalg.D.eig x;;      (* Eigenvectors and eigenvalues *)
let x = Linalg.D.null a;;        (* Solve A*x = 0, null space *)
let x = Linalg.D.linsolve a b;;  (* Solve A*x = B *)
let a, b = Linalg.D.linreg x y;; (* Simple linear regression y = a*x + b *)
...
```

`Linalg` module offers additional functions to check the properties of a matrix. For example,

```ocaml
Linalg.D.cond x;;          (* condition number of x *)
Linalg.D.rank x;;          (* rank of x *)
Linalg.D.is_diag x;;       (* is it diagonal *)
Linalg.D.is_triu x;;       (* is it upper triangular *)
Linalg.D.is_tril x;;       (* is it lower triangular *)
Linalg.D.is_posdef x;;     (* is it positive definite *)
Linalg.D.is_symmetric x;;  (* is it symmetric *)
...
```

Owl has implemented a complete set of OCaml interface to [`CBLAS`](https://github.com/ryanrhymes/owl/blob/master/src/owl/cblas/owl_cblas.mli) and [`LAPACKE`](https://github.com/ryanrhymes/owl/blob/master/src/owl/lapacke/owl_lapacke_generated.mli) libraries. You can utilise these highly optimised functions to achieve the best performance. However in most cases, you should only use the high-level functions in `Linalg` module rather than dealing with these low-level interface.



## Regression

`Regression` module currently includes `linear`, `exponential`, `nonlinear`, `ols`, `ridge`, `lasso`, `svm`, and etc. Most of them are based on a stochastic gradient descent algorithm implemented in `Optimise` module.

In the following, let's use an example to illustrate the simplest linear regression in `Regression` module. First, let's generate the measurement x which is a 1000 x 3 matrix. Each row of x is an independent measurement.

```ocaml
let x = Mat.uniform 1000 3;;
```

Next let's define the parameter of a linear model, namely p, a 3 x 1 matrix.

```ocaml
let p = Mat.of_array [|0.2;0.4;0.8|] 3 1;;
```

Then we generate the observations y from x and p by

```ocaml
let y = Mat.(x *@ p);;
```

Now, assume we only know x and y, how can we fit x and y into a linear model? It is very simple.

```ocaml
let p' = Regression.linear x y;;
```

From `utop`, you can see that p' equals `[|0.2; 0.4; 0.8|]` which is exactly the same as p. For other regression such as `lasso` and `svm`, the operation is more or less the same, please read Owl document for details.


## Plotting

There is another separate [Tutorial on Plotting in Owl](http://www.cl.cam.ac.uk/~lw525/owl/chapter/plot.html).
Herein, let's use an example to briefly show how to plot the result using `Plot` module. We first generate two mesh grids then apply sine function to them by using the operations introduced before.

```ocaml
let x, y = Mat.meshgrid (-2.5) 2.5 (-2.5) 2.5 100 100 in
let z = Mat.(sin ((x * x) + (y * y))) in
Plot.mesh x y z;;
```

No matter what plot terminal you use, you should end up with a figure as below.

![Plot example 01](examples/test_plot_01.png)

Besides `Plot.mesh`, there are several other basic plotting functions in `Plot`. Even though the module is still immature and under active development, it can already do some fairly complicated plots with minimal coding efforts. E.g., the following code will generate a `2 x 2` subplot.

```ocaml
let f p i = match i with
  | 0 -> Stats.Rnd.gaussian ~sigma:0.5 () +. p.(1)
  | _ -> Stats.Rnd.gaussian ~sigma:0.1 () *. p.(0)
in
let y = Stats.gibbs_sampling f [|0.1;0.1|] 5_000 |> Mat.of_arrays in
let h = Plot.create ~m:2 ~n:2 "" in
Plot.set_background_color h 255 255 255;

Plot.subplot h 0 0;
Plot.set_title h "Bivariate model";
Plot.scatter ~h (Mat.col y 0) (Mat.col y 1);

Plot.subplot h 0 1;
Plot.set_title h "Distribution of y";
Plot.set_xlabel h "y";
Plot.set_ylabel h "Frequency";
Plot.histogram ~h ~bin:50 (Mat.col y 1);

Plot.subplot h 1 0;
Plot.set_title h "Distribution of x";
Plot.set_ylabel h "Frequency";
Plot.histogram ~h ~bin:50 (Mat.col y 0);

Plot.subplot h 1 1;
Plot.set_foreground_color h 0 50 255;
Plot.set_title h "Sine function";
Plot.(plot_fun ~h ~spec:[ LineStyle 2 ] Maths.sin 0. 28.);
Plot.autocorr ~h (Mat.sequential 1 28);

Plot.output h;;
```

The end result is as follows. You probably have already grasped the idea of how to plot in Owl. But I promise to write another separate post to introduce plotting in more details.

![Plot example 04](examples/test_plot_04.png)


## Maths and Stats

There are a lot of basic and advanced mathematical and statistical functions in `Maths` and `Stats` modules. The document lags significantly behind the development, so I recommend you to read the mli file directly at the moment.

[`Stats`](https://github.com/ryanrhymes/owl/blob/master/src/owl/stats/owl_stats.mli) includes many functions for random numbers: `*_rvs` for random number generator, `*_pdf` for probably density/mass functions, `*_cdf` for cumulative density functions, `*_sf` for survival functions, `*_sf` for percentile functions, and etc. In addition, there are also many other statistical functions such as ranking correlations: `Stats.kendall_tau` and `Stats.spearman_rho`); hypothesis tests, and etc.


## N-dimensional Array

Owl has a very powerful module to manipulate dense N-dimensional arrays, i.e., [`Dense.Ndarray`](https://github.com/ryanrhymes/owl/blob/master/lib/owl_dense_ndarray.ml). Ndarray is very similar to the corresponding modules in Numpy and Julia. For sparse N-dimensional arrays, you can use `Sparse.Ndarray` which provides a similar set of APIs as aforementioned Ndarray. Here is an [initial evaluation](https://github.com/ryanrhymes/owl/wiki/Evaluation:-Performance-Test) on the performance of Ndarray.

Similar to `Matrix` module, `Ndarray` also has five submodules `S` (for `float32`), `D` (for `float32`), `C` (for `complex32`), `Z` (for `complex64`), and `Generic` (for all types) to handle different number types. There is an alias in `Owl` for double precision float ndarray (i.e., `Dense.Ndarray.D`) which is `Arr`. `Ndarray` also natively supports broadcast operations

In the following, I will present a couple of examples using `Dense.Ndarray` module. First, we can create empty ndarrays of shape `[|3;4;5|]`.

```ocaml
let x0 = Dense.Ndarray.S.empty [|3;4;5|];;
let x1 = Dense.Ndarray.D.empty [|3;4;5|];;
let x2 = Dense.Ndarray.C.empty [|3;4;5|];;
let x3 = Dense.Ndarray.Z.empty [|3;4;5|];;
```

You can also assign the initial values to the elements, generate a zero/one ndarray, or even a random ndarray.

```ocaml
Dense.Ndarray.C.zeros [|3;4;5|];;
Dense.Ndarray.D.ones [|3;4;5|];;
Dense.Ndarray.S.create [|3;4;5|] 1.5;;
Dense.Ndarray.Z.create [|3;4;5|] Complex.({im=1.5; re=2.5});;
Dense.Ndarray.D.uniform [|3;4;5|];;
```

With these created ndarray, you can do some math operation as below. Now, let's use shortcut `Arr` module to make examples.

```ocaml
let x = Arr.uniform [|3;4;5|];;
let y = Arr.uniform [|3;4;5|];;
let z = Arr.add x y;;
Arr.print z;;
```

Owl supports many math operations and these operations have been well vectorised so they are very fast.

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

Examining elements and comparing two ndarrays are also very easy.

```ocaml
Arr.is_zero x;;
Arr.is_positive x;;
Arr.is_nonnegative x;;
...
Arr.equal x y;;
Arr.greater x y;;
Arr.less_equal x y;;
...
```

You can certainly plugin your own functions to check each elements.

```ocaml
Arr.exists ((>) 2.) x;;
Arr.not_exists ((<) 2.) x;;
Arr.for_all ((=) 2.) x;;
```

Most importantly, you can use Owl to index, slice, and iterate a ndarray in various ways. There are many functions to facilitate such operations: `iteri`, `iter`, `mapi`, `map`, `filteri`, `filter`, `foldi`, `fold`, `iteri_slice`, `iter_slice`, `iter2i`, `iter2`. Please refer to the tutorials on [Ndarray](http://www.cl.cam.ac.uk/~lw525/owl/chapter/ndarray.html) and [Indexing and Slicing](http://www.cl.cam.ac.uk/~lw525/owl/chapter/slicing.html).


## Algorithmic Differentiation

Algorithmic differentiation (AD) is another key component in Owl which can make many analytical tasks so easy to perform. It is also often referred to as Automatic differentiation. Here is a [Wikipedia article](https://en.wikipedia.org/wiki/Automatic_differentiation) to help you understand the topic if you are interested in.

The AD support is provided `Algodiff` module. More precisely, `Algodiff.Numerical` provides numerical differentiation whilst `Algodiff.S` and `Algodiff.D` provides algorithmic differentiation for single and double precision float numbers respectively. For the detailed differences between the two, please read the wiki article as your starting point. Simply put, `Algodiff.S/D` is able to provide exact result of the derivative whereas `Algodiff.Numerical` is just approximation which is subject to round and truncate errors.

`Algodiff.S` supports higher-order derivatives. Here is an example which calculates till the fourth derivative of `tanh` function.

```ocaml
open Algodiff.S;;

(* calculate derivatives of f0 *)
let f0 x = Maths.(tanh x);;
let f1 = f0 |> diff;;
let f2 = f0 |> diff |> diff;;
let f3 = f0 |> diff |> diff |> diff;;
let f4 = f0 |> diff |> diff |> diff |> diff;;
```

Quite easy, isn't it? Then we can plot the values of `tanh` and its four derivatives between interval `[-4, 4]`.

```ocaml
let map f x = Vec.map (fun a -> a |> pack_flt |> f |> unpack_flt) x;;

(* calculate point-wise values *)
let x = Vec.linspace (-4.) 4. 200;;
let y0 = map f0 x;;
let y1 = map f1 x;;
let y2 = map f2 x;;
let y3 = map f3 x;;
let y4 = map f4 x;;

(* plot the values of all functions *)
let h = Plot.create "plot_021.png" in
Plot.set_foreground_color h 0 0 0;
Plot.set_background_color h 255 255 255;
Plot.plot ~h x y0;
Plot.plot ~h x y1;
Plot.plot ~h x y2;
Plot.plot ~h x y3;
Plot.plot ~h x y4;
Plot.output h;;
```

Then you should be able to see a figure like this one below. For more advanced use, please see my separate tutorial.

![plot021](https://raw.githubusercontent.com/wiki/ryanrhymes/owl/image/plot_021.png)


## Machine Learning and Neural Network

Even though this is still work in progress, I find it necessary to present a small neural network example to show how necessary it is to have a comprehensive numerical infrastructure. The illustration in the following is of course the classic MNIST example wherein we will train a two-layer network that can recognise hand-written digits.

`Neural` module has been included in `Owl` main library. To define a feedforward network, you can first open `Neural.S.Graph` in `utop`. `Neural.S.Graph` contains many easy-to-use wrappers to create different types of neuron node, `S` indicates the network is for single precision.

```ocaml
open Neural.S;;
open Neural.S.Graph;;
```

Now, let's see how to define a two-layer neural network.

```ocaml
let nn = input [|784|]
  |> linear 300 ~act_typ:Activation.Tanh
  |> linear 10  ~act_typ:Activation.Softmax
  |> get_network
;;
```

Done! Only three lines of code, that's easy, isn't it? Owl's `Neural` module is built atop of its `Algodiff` module. I am often amazed by the power of algorithmic differentiation while developing the neural network module, it just simplifies the design so much and makes life so easy.

Let's look closer at what the code does: the first line defines the input shape of the neural network; the second line adds a linear layer (of shape `784 x 300`) with `Tanh` activation; the third line does the similar thing by adding another linear layer with `Softmax` activation. The input shape of each layer is automatically inferred for you. The last line `get_network` returns the created network for training.

You can print out the summary of the neural network by calling `Graph.print nn`, then you see the following output.

```bash
Graphical network

[ Node input_0 ]:
    Input : in/out:[*,784]
    prev:[] next:[linear_1]

[ Node linear_1 ]:
    Linear : matrix in:(*,784) out:(*,300)
    init   : standard
    params : 235500
    w      : 784 x 300
    b      : 1 x 300
    prev:[input_0] next:[activation_2]

[ Node activation_2 ]:
    Activation : tanh in/out:[*,300]
    prev:[linear_1] next:[linear_3]

[ Node linear_3 ]:
    Linear : matrix in:(*,300) out:(*,10)
    init   : standard
    params : 3010
    w      : 300 x 10
    b      : 1 x 10
    prev:[activation_2] next:[activation_4]

[ Node activation_4 ]:
    Activation : softmax in/out:[*,10]
    prev:[linear_3] next:[]
```

How to train the defined network now? You only need two lines of code to load the dataset and start training. By the way, calling `Dataset.download_all ()` will download all the data sets used in Owl (about 1GB uncompressed data).

```ocaml
let x, _, y = Dataset.load_mnist_train_data () in
train nn x y;;
```

You may ask "what if I want different training configuration?" Well, the training and network module is actually very flexible and highly configurable. But I will talk about these details in another [separate tutorial](http://www.cl.cam.ac.uk/~lw525/owl/chapter/neural.html).


## Distributed & Parallel Computing

Owl's distributed and parallel computing relies on my another research prototype - Actor System. Actor is a specialised distributed data processing framework. Please do not get confused with [Actor Model](https://en.wikipedia.org/wiki/Actor_model) since Owl's Actor system actually implements three engines: MapReduce, Parameter Server, and Peer-to-Peer.

My design principle of distributed analytics is: Owl handles "analytics" whilst Actor deals with "distribution" with a suitable engine. Two systems can be composed through functors just like we play LEGO. This composition includes both low-level data structures and high-level models.

For example, the following one-line code composes Owl's Ndarray with Actor's MapReduce engine to provide us a distributed Ndarray module `M1`.

```ocaml
module M1 = Owl_parallel.Make_Distributed (Dense.Ndarray.D) (Actor_mapre)
```

Similarly, for high-level neural network models, we only need to add one extra line of code to transform a single-node training model to a distributed training model. Note that we have composed Owl's Feedforward neural network with Actor's Parameter Server engine.

```ocaml
module M2 = Owl_neural_parallel.Make (Owl_neural_feedforward) (Actor_param)
```

Actor system is currently in a closed repository (due to my techreport writing). I will introduce this exciting feature very soon (in September).


## How To Contribute

Owl is under active development, and I really look forward to your comments and contributions. Besides setting up a complete development environment on your native system, the easiest way to contribute is to use the [Owl Docker Images](https://hub.docker.com/r/ryanrhymes/owl/). Moreover, we have also built a docker image for ARM-based platform so that you can run Owl on Raspberry PI and Cubietruck (see the section above).

Just pull the image and dig into code saved in `/root/owl`, then have fun!

**Student Project:** If you happen to be a student in the [Computer Lab](http://www.cl.cam.ac.uk/) and want to do some challenging development and design, here are some [Part II Projects](http://www.cl.cam.ac.uk/research/srg/netos/stud-projs/studproj-17/#owl0). If you are interested in more researchy topics, I also offer Part III Projects and please contact me directly via [Email](mailto:liang.wang@cl.cam.ac.uk).

**Acknowledgement: Funded in part by EPSRC project - Contrive (EP/N028422/1).** Please refer to the [full acknowledgement](https://github.com/ryanrhymes/owl/blob/master/ACKNOWLEDGEMENT.md) for more details.
