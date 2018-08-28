# Acknowledgement

Owl is built on top of an enormous amount of previous work. Without the efforts of these projects and the intellectual contribution of these people, it will be very difficult for us to continue developing Owl.

In designing and developing the various components in Owl, we have been studying many systems and keep learning from them. Here is a list to show the contributions from various individuals/projects/software. The credit goes to them.

Because Owl is always under active development, there might be a lag between the development code and the list here. In case you think there is something/someone missing in the list, please do contact me. I will try to make this list up-to-date.

- Tremendous support and help from my [colleagues](http://ocamllabs.io/people/) in [OCaml Labs](http://ocamllabs.io/) and [System Research Group](https://www.cl.cam.ac.uk/research/srg/netos/people/) in the Computer Lab.

- The interface design are heavily influenced by [Numpy](http://www.numpy.org/), [SciPy](https://www.scipy.org/), [Julia](https://julialang.org/), [Matlab](https://www.mathworks.com/products/matlab.html).

- The early versions heavily relied on [Markus Mottl](http://www.ocaml.info/) and [Christophe Troestler](https://github.com/Chris00)'s projects: [Lacaml](https://github.com/mmottl/lacaml), [Gsl](https://github.com/mmottl/gsl-ocaml).

- [Richard Mortier](https://github.com/mor1) has been providing great support and constructive feedback. We two together have been running interesting sub-projects on top of Owl.

- [Ben Catterall](https://www.linkedin.com/in/ben-catterall-38643287/?ppe=1) did excellent theoretical work for Owl's underlying distributed computation engine. He also contributed to the NLP module.

- [Tudor Tiplea](https://github.com/tptiplea) contributed the initial Ndarray implementation in the base module.

- [Maria (kanisteri)](https://github.com/kanisteri) contributed several root-finding algorithms. She is also working on other numerical functions in Owl.

- [Gavin Stark](https://github.com/atthecodeface) contributed and reshaped many unit tests. His work has been helping us in identifying and fixing existing bugs and preventing potential ones, greatly assured the quality of Owl.

- [Jianxin Zhao](https://github.com/jzstark/) optimised some core operations of ndarray, built advanced machine learning and deep neural network applications on top of Owl. He's been working on Zoo system for future service deployment.

- [Marshall Abrams](https://github.com/mars0i) has been contributing code to Plot and other modules, improving the documentation. Moreover, he always provide useful feedback and constructive discussion.

- [Sergei Lebedev](https://github.com/superbobry) and [bagmanas](https://github.com/bagmanas) contributed various hypothesis test functions in Stats module.

- Interfacing to other C/C++ libraries (e.g., CBLAS, LAPACKE, Eigen, OpenCL, and etc.) relies on [Jeremy Yallop](https://www.cl.cam.ac.uk/~jdy22/)'s [ocaml-ctypes](https://github.com/ocamllabs/ocaml-ctypes).

- The plot module is built on top of [Hezekiah M. Carty](https://github.com/hcarty)'s project: [ocaml-plplot](https://github.com/hcarty/ocaml-plplot).

- [Francois BERENGER](https://github.com/UnixJunkie) implemented a light and neat logging module which Owl borrows many ideas. The older version of Owl directly used Francois' library.

- Many functions rely on [Eigen](http://eigen.tuxfamily.org/index.php?title=Main_Page) and its [OCaml binding](https://github.com/ryanrhymes/eigen). The binding also contains some functions (e.g., convolution functions) from Google's [Tensorflow](https://www.tensorflow.org/).

- [Jérémie Dimino](https://github.com/diml) and many others built the powerful [building system](https://github.com/ocaml/dune) and convenient [toplevel](https://github.com/diml/utop) for OCaml.

- Other projects which have been providing useful insights: [Oml](https://github.com/hammerlab/oml), [pareto](https://github.com/superbobry/pareto).
