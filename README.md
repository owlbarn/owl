# Owl - An OCaml Math Library
Owl is an OCaml math library. It supports both dense and sparse matrix operations, linear algebra, regressions, and many advanced mathematical and statistical functions (such as Markov chain Monte Carlo methods).

## Installation

Installation is rather trivial. First, you need to clone the repository.

```bash
git clone git@github.com:ryanrhymes/owl.git
```

Then you need to install all the dependencies. Owl depends on gsl, ctypes, plplot, and several other modules. Check the `_oasis` file in the `owl` folder to find out the complete list of required modules.

Next, you can compile and install the module with the following command.

```bash
make oasis
make && make install
```

If you want `utop` to automatically load Owl for you, you can also edit `.ocamlinit` file in your home folder by adding the following lines.

```bash
#require "Owl"
#require "ctypes"
#require "ctypes.foreign"
```

Owl is well integrated with `utop`. Now you can start `utop` and continue this tutorial to do some experiments.


## Create Matrices

Create Matrices
