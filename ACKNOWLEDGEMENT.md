# Acknowledgement

Owl is built on top of an enormous amount of previous work. Without the efforts of these projects and the intellectual contribution of these people, it will be very difficult for us to continue developing Owl.

In designing and developing the various components in Owl, we have been studying many systems and keep learning from them. Here is a list to show the contributions from various individuals/projects/software. The credit goes to them.

Because Owl is always under active development, there might be a lag between the development code and the list here. In case you think there is something/someone missing in the list, please do contact me. I will try to make this list up-to-date.

- Tremendous support and help from my [colleagues](http://ocamllabs.io/people/) in [OCaml Labs](http://ocamllabs.io/).

- The interface design are heavily influenced by [Numpy](http://www.numpy.org/), [SciPy](https://www.scipy.org/), [Julia](https://julialang.org/), [Matlab](https://www.mathworks.com/products/matlab.html).

- The early versions heavily relied on [Markus Mottl's](http://www.ocaml.info/) projects: [Lacaml](https://github.com/mmottl/lacaml), [Gsl](https://github.com/mmottl/gsl-ocaml). Even now, the pretty printing function of matrices still uses Markus' code.

- [Ben Catterall](https://www.linkedin.com/in/ben-catterall-38643287/?ppe=1) did excellent theoretical work for Owl's underlying distributed computation engine. He also contributed to the NLP module.

- Interfacing to other C/C++ libraries (e.g., BLAS and Eigen) relies on [Jeremy Yallop](https://www.cl.cam.ac.uk/~jdy22/)'s [ocaml-ctypes](https://github.com/ocamllabs/ocaml-ctypes).

- The plot module is built on top of [Hezekiah M. Carty](https://github.com/hcarty)'s project: [ocmal-plplot](https://github.com/hcarty/ocaml-plplot).

- The [Algodiff] module partly uses the design of [DiffSharp](http://diffsharp.github.io/DiffSharp/) by [Atilim Gunes Baydin](http://www.cs.nuim.ie/~gunes/), [Barak A. Pearlmutter](http://www.bcl.hamilton.ie/~barak/), and et al., [[techreport]](https://arxiv.org/abs/1502.05767).

- [Sergei Lebedev](https://github.com/superbobry) and [bagmanas](https://github.com/bagmanas) have been contributing to various hypothesis test functions in Stats module.

- Many functions rely on [Eigen](http://eigen.tuxfamily.org/index.php?title=Main_Page) and its [OCaml binding](https://github.com/ryanrhymes/eigen). The binding also contains some functions (e.g., convolution functions) from Google's [Tensorflow](https://www.tensorflow.org/).

- Other projects which have been providing useful insights: [Oml](https://github.com/hammerlab/oml), [pareto](https://github.com/superbobry/pareto).
