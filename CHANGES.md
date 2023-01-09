## 1.0.3 (2023-01-06)

* Change input/output_val to ocaml_input/output_val
* Adapt Zoo to the changes in ocaml-compiler-libs
* Fix a bug about unpack_arr in nested forward/reverse mode (#619)
* Add NeNormal initializer (#624)
* Update API document
* Update several mli files 
* Fix typos


## 1.0.2 (2022-02-14)

* Update Hamming, Hann, Blackman, Freqz functions in `Signal` module
* Fix a bug in sparse matrix transpose; the dimensions are now swapped properly
* Fix a bug in the split function in ndarray module
* Fix a bug in combination calculation
* Fix some compilation warnings on Windows, using Mingw toolchain
* Document updates for PLplot and Windows

## 1.0.1 (2021-01-06)

* Add eighth-order finite difference approximation
* Fix bug in Jacobian with different input/output dimensions (#557)
* Fix bug in nested grads (#558)
* Update to ocamlformat.0.16.0 (thanks @gpetiot #556)
* Add get_fancy to AD
* Check input and output type of `diff` operation
* Fix bug in `build_info` of aiso pattern in AD
* Implement split forward mode and check max tag of `build_info` 
* Add initial implementation of fft2 and ifft2
* Add nonsymmetric qs suppport for continuous and discrete time lyapunov gradients
* Improve `care` and `dare` operations in AD
* Improve forward mode efficiency for sylv, clyap and dlyap operations in AD

## 1.0.0 (2020-11-10)
* Update project governance 
* Fix bug in convolution operation 
* Fix bug in AEOS module
* Enable differentiation through the Jacobian in Algodiff
* Fix windows compatibility issue (@kkirstein #549)
* Fix bitwidth issue in mingw by replacing long type with int64_t (thanks @kkirstein)
* Fix Dockerfile for master branch

## 0.10.0 (2020-10-04)
* various documentation improvements (thanks @pveber, @UnixJunkie, @Fourchaux)
* Fix use of access operators (#543)
* Upgrade to ocamlformat 0.15.0 (thanks @gpetiot #535)
* keep_dims option (#531)
* stats: fix infinite loop in ecdf
* Use Fun.protect to ensure all file descriptors are being closed
* owl_ndarray_maths: improve user experience in case of errors
* owl_io: close file descriptors also in case of errors
* owl_dense_ndarray_generic: fix error on printing 0-ary arrays
* fixed bug in sub forward mode (#533)
* Add stack to Algodiff (#528)
* added log_sum_exp to Ndarray and Algodiff (#527)
* added single-precision and double-precision Bessel functions to Ndarray  (#526)
* Fixes #518 by introducing another `/` to resolve data directory (@jotterbach #519)
* Graph Slice node (resolves #483) (@mreppen #517)
* Graph subnetwork: Multiple outputs (@mreppen #515)
* Added kron and swap to Algodiff operations (#512)
* various other small fixes

## 0.9.0 (2020-03-03)

* owl: sync opam files versioning
* added stack function (#506)
* Owl now compatible with latest version of Ctypes (#508)
* Fix bug in _squeeze_broadcast (#503)
* using extended indexing operator since ocaml 4.10.0
* [breaking] Drop support for ocaml < 4.10.0

## 0.8.0 (2020-02-25)

*  Fix bug in _squeeze_broadcast (#503)
*  Added the Dawson function (Ndarray + Matrix + Algodiff op) (#502)
*  Fix bug in reverse mode gradients of aiso operations and pow (#501)
*  Added poisson_rvs to Owl_distribution (#499)
*  Draw poisson RVs in Ndarray and Mat modules (#498)
*  Broadcast bug for higher order derivatives (#495)
*  add sem to dense ndarray and matrix (#497)
*  Avoid input duplication with Graph.model and multi-input nn (#494)
*  Added Graph.get_subnetwork for constructing subnetworks (#491)
*  Make Graph.inputs give unique names to inputs (#493)
*  modify nlp interfaces
*  Re-add removed DiffSharp acknowledgment (#486)
*  add pretty printer for hypothesis type
*  update lambda neuron (#485)
*  fix example due to #476
*  Extend base linalg functions to complex numbers (#479)
*  [breaking] use a separate module for algodiff instead of ndarray directly (#476)
*  temp workaround and unittest (#478)
*  [breaking] Interface files for base/dense and base/linalg (#472)
*  Port code to dune2 (#474)
*  [breaking]  interface files to simplify .mli files in owl/dense (#471)
*  Save and load Npy files (#470)
*  Owl: relax bounds on base and stdio (#469)
*  Merged tests for different AD operations into one big test + autoformat tests with ocamlformat (#468)

### 0.7.2 (2019-12-06)

* fourth order finite diff approx to grad
* changes to improve stability of sylv/discrete_lyap
* fix bug in concatenate function
* add mli for owl_base_linalg_generic
* Owl-base linalg routines: LU decomposition  (#465)
* bug fixes
* Update owl.opam

### 0.7.1 (2019-11-27)

* Add unit basis
* Fix issue #337 and #457 (#458)
* owl-base: drop seemingly unnecessary dependency on integers (#456)

### 0.7.0 (2019-11-14)

* Add unsafe network save (owlbarn/owl#429)
* Sketch Count-Min and Heavy-Hitters
* Various bugfixes
* Owl_io.marshal_to_file: use to_channel
* Do not create .owl folder when loading owl library
* Re-design of exceptions and replace asserts with verify
* Add OWL_DISABLE_LAPACKE_LINKING_FLAG
* Reorganise Algodiff module
* Add parameter support to Zoo
* Two new features in algodiff: eye and linsolve (triangular option) + improved stability of qr and chol
* Implemented solve triangular
* Added linsolve and lq reverse-mode differentiation
* Fix build on archlinux (pkg-config cblas)
* Add median and sort along in ndarray
* Improve stability of lyapunov gradient tests

### 0.6.0 (2019-07-17)

* Add unsafe network save (#429)
* Sketch Count-Min and Heavy-Hitters
* Various ugfixes
* Owl_io.marshal_to_file: use to_channel
* Do not create .owl folder when loading owl library
* Re-design of exceptions and replace asserts with verify
* Add OWL_DISABLE_LAPACKE_LINKING_FLAG
* Reorganise Algodiff module
* Add parameter support to Zoo
* Two new features in algodiff: eye and linsolve (triangular option) + improved stability of qr and chol
* Implemented solve triangular
* Added linsolve and lq reverse-mode differentiation
* Fix build on archlinux (pkg-config cblas)
* Add median and sort along in ndarray
* Improve stability of lyapunov gradient tests


### 0.5.0 (2019-03-05)

* Improve building and installation.
* Fix bugs and improve performance.
* Add more functions to Algodiff.
* Split plot module out as sub library.
* Split Tfgraph module out as sub library.


### 0.4.2 (2018-11-10)

* Optimise computation graph module.
* Add some core math functions.
* Fix bugs and improve performance.


### 0.4.1 (2018-11-01)

* Improve the APIs of Dataframe module.
* Add more functions in Utils module.

### 0.4.0 (2018-08-08)

* Fix some bugs and improve performance.
* Introduce computation graph into the functor stack.
* Optimise repeat and tile function in the core.
* Adjust the OpenCL library according to computation graph.
* Improve the API of Dataframe module.
* Add more implementation of convolution operations.
* Add dilated convolution functions.
* Add transposed convolution functions.
* Add more neurons into the Neural module.
* Add more unit tests for core functions.
* Move from `jbuilder` to `dune`
* Assuage many warnings

### 0.3.8 (2018-05-22)

* Add initial support for dataframe functionality.
* Add IO module for Owl's specific file operations.
* Add more helper functions in Array module in Base.
* Add core functions such as one_hot, slide, and etc.
* Fix normalisation neuron in neural network module.
* Fix building, installation, and publishing on OPAM.
* Fix broadcasting issue in Algodiff module.
* Support negative axises in some ndarray functions.
* Add more statistical distribution functions.
* Add another higher level wrapper for CBLAS module.


### 0.3.7 (2018-04-25)

* Fix some bugs and improve performance.
* Fix some docker files for automatic image building.
* Move more pure OCaml implementation to base library.
* Add a new math module to support complex numbers.
* Improve the configuration and building system.
* Improve the automatic documentation building system.
* Change template code into C header files.
* Add initial support for OpenMP with evaluation.
* Tidy up packaging using TOPKG.


### 0.3.6 (2018-03-22)

* Fix some bugs and improve performance.
* Add more unit tests for Ndarray module.
* Add version control in Zoo gist system.
* Add tensor contract operations in Ndarray.
* Add more documentation of various functions.
* Add support of complex numbers of convolution and pooling functions.
* Enhance Owl's own Array submodule in Utils module.
* Fix pretty printer for rank 0 ndarrays.
* Add functions to iterate slices in an ndarray.
* Adjust the structure of OpenCL module.


### 0.3.5 (2018-03-12)

* Add functions for numerical integration.
* Add functions for interoperation.
* Add several root-finding algorithms.
* Introduce Owl's exception module.
* Add more functions in Linalg module.
* Add native convolution function in core.
* Remove Eigen dependency of dense data structure.
* Fix some bugs and improve performance.


### 0.3.4 (2018-02-26)

* Update README, ACKNOWLEDGEMENT, and etc.
* Initial implementation of OpenCL Context module.
* Fix some bugs and improve the performance.
* Add Adam learning rate algorithm in Optimise module.
* Add a number of statistical functions into Stats.
* Enhance View functor and add more functions.
* Include and documentation of NLP modules.
* Add dockerfile for various linux distributions.


### 0.3.3 (2018-02-12)

* Fix some bugs and improve the performance.
* Integrate with Owl's documentation system.
* Add native C implementation of pooling operations.
* Add more operators in Operator module.
* Add more functions in Linalg module.
* Optimise the Base library.
* Add more unit tests.


### 0.3.2 (2018-02-08)

* Fix some bugs and improve the performance.
* Functorise many unit tests and add more tests.
* Rewrite the documentation migrate to Sphinx system.
* Migrate many pure OCaml code into Base library.
* Implement the initial version of Base library.


### 0.3.1 (2018-01-25)

* Design View module as an experimental module for Ndarray.
* Include Mersenne Twister (SFMT) to generate random numbers.
* Implement random number generator of various distributions.
* Implement native functions for maths and stats module.
* Include FFTPACK to provide native support for FFT functions.
* Minimise dependency, remove dependencies on Gsl and etc.
* Implement slicing and indexing as native C functions.
* Use new extended indexing operators for slicing functions.
* Refine ndarray fold function and introduce scan function.
* Reorganise the module structure in the source tree.
* Fix some bugs and enhance the performance of core functions.
* Add another 200+ unit tests.


### 0.3.0 (2017-12-05)

* Migrate to jbuilder building system.
* Unify Dense Ndarray and Matrix types.
* Split Toplevel out as a separate library.
* Redesign Zoo system for recursive importing.
* Simplify the module signature for Ndarray.
* Introduce functions in Ndarray module to support in-place modification.
* Introduce reduction functions to reduce an ndarray to a scalar value.
* Add Lazy functor to support lazy evaluation, dataflow, and incremental computing.
* Implement a new and more powerful pretty printer to support both ndarray and matrix.
* Fix bugs in the core module, improve the performance.


### 0.2.8 (2017-09-02)

* New Linalg module is implemented.
* New neural network module supports both single and double precision.
* New Optimise and Regression module is built atop of Algodiff.
* Experimental Zoo system is introduced as a separate library.
* Enhance core functions and fix some bugs.


### 0.2.7 (2017-07-11)

* Enhance basic math operations for complex numbers.
* Redesign Plot module and add more plotting functions.
* Add more hypothesis test functions in Owl.Stats module.
* Support both numerical and algorithmic differentiation in Algodiff.
* Support both matrices and n-dimensional arrays in Algodiff module.
* Support interoperation of different number types in Ext and new operators.
* Support more flexible slicing, tile, repeat, and concatenate functions.
* Support n-dimensional array of any types in Dense.Ndarray.Any module.
* Support simple feedforward and convolutional neural networks.
* Support experimental distributed and parallel computing.


### 0.2.0 (2017-01-20)

* Support both dense and sparse matrices.
* Support both dense and sparse n-dimensional arrays.
* Support both real and complex numbers.
* Support both single and double precisions.
* Add more vectorised operation: sin, cos, ceil, and etc.
* Add basic unit test framework for Owl.
* Add a couple of Topic modelling algorithms.


### 0.1.0 (2016-11-09)

* Initial architecture of Owl library.
* Basic support for double precision real dense matrices.
* Basic linear functions for dense matrices.
* Basic support for plotting functions.
* SI, MKS, CGS, and CGSM metric system.
