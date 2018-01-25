### 0.3.2 (in progress)

* Rewrite the documentation migrate to Sphinx system.


### 0.3.1 (2018-01-25)

* Design View module as an experimental module for Ndarray.
* Include Mersenne Twister (SFMT) to generate random numbers.
* Implement random number generator of various distributions.
* Implement native functions for maths and stats module.
* Include FFTPACK to provide native support for FFT functions.
* Minimise dependency, remove dependencies on Gsl and etc.
* Implement slicing and indexing as native C functions.
* Use new extended indexing operators for slicing functions.
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
