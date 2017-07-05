## What is the future plan of Owl?

Owl aims to be a general OCaml numerical library for scientific computing. The library focuses on the following perspective:

* Dense matrix operations             (99% completed)
* Sparse matrix operations            (99% completed)
* Advanced mathematical functions     (90% completed)
* Advanced statistical functions      (70% completed)
* Linear algebra                      (40% completed)
* Regression functions                (40% completed)
* Machine learning                    (10% completed)
* Basic Plotting functions            (75% completed)

As you can see, Owl is still in its infancy phase. I appreciate any comments and look forward to any help from anyone who want to contribute.

## What are the specific TODOs?

There is a list of things (either well-defined or not) in my mind to push the project forward. Bold font marks the task I am currently working on.

* **Unify all the mathematical operators (long term, need to wait for MI).**
* **Unify the indexing and slicing operator (long term, need to wait for 4.06).**.
* **Implement algorithmic differentiation, forward mode.**
* **Provide a pure OCaml implementation of Sparse Matrix module.**
* **Support N-dimensional view.**
* **Add uniform error handling, e.g., check the matrix shape.**
* Add hypothesis tests in Stats module.
* A Core module for matrix without dependency on GSL.
* Serialise matrices to standard formats such as HDF5.
* Add integration and ODE functions.
* Add Graph module (build atop of ocamlgraph).
* Extensive tests on Dense matrix module to eliminate bugs.
* Complete some missing functions in Sparse matrix module.
* Make Sparse matrix module support "x.{i,j}" to access the elements.
* Add more types of plots in Plot module.
* Add consistent error management in all modules.
* Complete all the missing functions in Linalg module for dense matrices.
* Automate the document generation using ocamldoc.
* Make a docker image supporting GUI so Plot module can plot in X window.
* Make Linalg module support sparse matrices.
* Implement more optimisation algorithms in Optimise module: e.g., coordinate descent, proximal gradient, and etc.
* Implement more machine learning algorithms (clustering, deep neural networks, and etc.), may introduce a new separate module in Owl.
* Include a set of approximate algorithms in Owl as a separate module (e.g., approximate k-means, approximate k-nn, and etc.)
* Embed a small probabilistic programming language in Stats module.
* Add a web interface so that the plot can be dynamically updated on the fly.
* whatever else helpful ...

## What have been DONE?

* ~~Support Float32, Float64, Complex32, Complex64 in Matrix.~~
* ~~Support sparse N-dimensional array.~~
* ~~Create project page for owl on github.~~
* ~~Improve the documentation and write a series of tutorials (posts) for Owl.~~
* ~~Dense N-dimensional array (Ndarray).~~
* ~~Add FFT functions.~~
* ~~Enhance sparse real matrices.~~
* ~~Add the library to OPAM repository.~~
* ~~Add the supports of sparse complex matrices.~~
* ~~Add the supports of dense complex matrices.~~
* ~~Get rid of ctypes.foreign, use stub generation to interface with GSL~~
* ~~Add widely used constants to the module, e.g., pi, speed of light, natural number, gravity constant, and etc.~~
