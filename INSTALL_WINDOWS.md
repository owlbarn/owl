# Owl on Windows

This document gives instructions on how to install Owl on Windows, natively. For use within `WSL2`, please refer to the ordinary instruction and use the standard `opam` installation procedure.

## OCaml

The recommended way to build native apps from OCaml is the [OCaml for Windows](https://fdopen.github.io/opam-repository-mingw/) setup, which uses a `Cygwin` environment, but compiles to native Windows (without relying on `Cygwin.dll`). OCaml for Windows (_OfW_) features an opam repository and sets up the needed toolchains, e.g., `gcc`, `make`, `pc-config`, so that most opam packages build out-of-the-box, even the ones relying on C-code.

Please make sure the path is correctly setup, as described on the OfW website: [depext cygwin](https://fdopen.github.io/opam-repository-mingw/depext-cygwin/). Otherwise, theh cross-compiling tools might not find the correct binaries.

## Pre-Requisites

### OpenBLAS

OpenBLAS supports cross-compiling, like it is used in _OfW_, when building from source. One might need to install the FORTRAN crosscompiler `x86_64-w64-mingw32-gfortran` via Cygwins package manager beforehand. Also, the generated binaries have to be installed at the cross compilers `sys-root` location instead under `/usr/local`. Note that during cross-compiling the target CPU has to be given explicitely (`HASWELL` needs to be replaced with your own model, please consult OpenBLAS documentation for available CPUs).

```
git clone https://github.com/xianyi/OpenBLAS.git
cd OpenBLAS
make CC=x86_64-w64-mingw32-gcc FC=x86_64-w64-mingw32-gfortran TARGET=HASWELL
make CC=x86_64-w64-mingw32-gcc FC=x86_64-w64-mingw32-gfortran TARGET=HASWELL PREFIX=/usr/x86_64-w64-mingw32/sys-root/mingw install
```

### PlPLot

__TODO__

## Owl

Now we can install Owl via the usual `opam` tool.

### conf-openblas

`conf-openblas.0.2.1` currently needs a manual installation of the `OpenBLAS` library as described above.

### eigen

`eigen.0.3.0` should work on _OfW_ out of the box.

### Installation

If all prerequisites are setup, installation of `owl` and `owl-top` can be done via `opam`:

```
opam install owl owl-top
```

## Status

Porting to Windows is still work-in-progress. At the moment `owl`, `owl-top`, and `owl-zoo` can be installed and basic functionality works. Netherless, compiling `owl` still generates quite a lot of warnings and test failures:

Crashed tests:
* `math`: test `mulmod`
* `math`: test `pow_mod`

Failed tests:
* `dense matrix`: test `save_load` (-> maybe a Windows filesystem issue?)


