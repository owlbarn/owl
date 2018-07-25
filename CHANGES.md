### 0.4.0 (2018-07-25)

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
