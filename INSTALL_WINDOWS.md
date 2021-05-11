# Owl on Windows

This document gives instructions on how to install Owl on Windows, natively. For use within `WSL2`, please refer to the ordinary instruction and use the standard `opam` installation procedure.

## OCaml

The recommended way to build native apps from OCaml is the [OCaml for Windows](https://fdopen.github.io/opam-repository-mingw/) setup, which uses a `Cygwin` environment, but compiles to native Windows (without relying on `Cygwin.dll`). OCaml for Windows (_OfW_) features an opam repository and sets up the needed toolchains, e.g., `gcc`, `make`, `pc-config`, so that most opam packages build out-of-the-box, even the ones relying on C-code.

Please make sure the path is correctly setup, as described on the OfW website: [depext cygwin](https://fdopen.github.io/opam-repository-mingw/depext-cygwin/). Otherwise, the cross-compiling tools might not find the correct binaries.

## Pre-Requisites

### OpenBLAS

OpenBLAS supports cross-compiling, like it is used in _OfW_, when building from source. One might need to install the FORTRAN crosscompiler `x86_64-w64-mingw32-gfortran` via Cygwins package manager beforehand. Also, the generated binaries have to be installed at the cross compilers `sys-root` location instead under `/usr/local`. Note that during cross-compiling the target CPU has to be given explicitely (`HASWELL` needs to be replaced with your own model, please consult OpenBLAS documentation for available CPUs).

Start your Cygwin shell and perform the following actions:

```
git clone https://github.com/xianyi/OpenBLAS.git
cd OpenBLAS
make CC=x86_64-w64-mingw32-gcc FC=x86_64-w64-mingw32-gfortran TARGET=HASWELL
make CC=x86_64-w64-mingw32-gcc FC=x86_64-w64-mingw32-gfortran TARGET=HASWELL PREFIX=/usr/x86_64-w64-mingw32/sys-root/mingw install
```

### PLplot

PLplot needs to be compiled with the 'native' MinGW compiler `x86_64-w64-mingw32-gcc` like OpenBLAS (see above), but in addition the 'native' Cygwin' C-compiler `gcc-core` is also needed. Thanks to the `cmake` based build system, this is only a matter of configuration.
In order to enable the `gtk3` backend, one should install the respective dependency with the Cygwin package manager beforehand: `mingw64-x86_64-gtk3`.

Then, start your Cygwin shell and perform the following actions During configure by the `cmake` command, one might see warnings about missing dependencies and disabled language bindings, e.g., for OCaml. These can be ignored, as OCaml binding will be provided by the respective opam package later during installation of `owl-plplot`.

First, clone the repository:
```
git clone https://github.com/PLplot/PLplot.git
```

Then, a native Cygwin build is needed:
```
mkdir build_cygwin
cd build_cygwin
cmake -DCMAKE_C_COMPILER=gcc ../PLplot

make all
```

Finally, PLplot can be build for the Mingw toolchain. Make sure, you start in the directory one level above the PLplot source. Unfortunately, the automatic generation of header files with the mingw-toolchain fails in the Cygwin environment due to different path naming of Cygwin & Mingw, but we can "steel" the respective files from the Cygwin build.
```
mkdir build_mingw
cd build_mingw
cmake -DCMAKE_C_COMPILER=x86_64-w64-mingw32-gcc -DCMAKE_INSTALL_PREFIX=/usr/x86_64-w64-mingw32/sys-root/mingw -DCMAKE_NATIVE_BINARY_DIR=../build_cygwin ../PLplot

make all # fails when generating tai-utc.h
cp ../build_cygwin/lib/qsastime/tai-utc.h ./lib/qsastime/tai-utc.h
make all # fails when generating deltaT.h
cp ../build_cygwin/lib/qsastime/deltaT.h ./lib/qsastime/deltaT.h
cp ../build_cygwin/include/plhershey-unicode.h ./include/plhershey-unicode.h

make all
make install
```


## Owl

Now we can install Owl via the usual `opam` tool.

### Installation

If all prerequisites are setup, installation of `owl` and `owl-top` can be done via `opam`:

```
opam install owl owl-top owl-plplot
```

## Status

Porting to Windows is still work-in-progress. At the moment `owl`, `owl-top`, and `owl-zoo` can be installed and basic functionality works. Nevertheless, compiling `owl` still generates quite a lot of warnings and test failures:

Crashed tests:
* `math`: test `mulmod`
* `math`: test `pow_mod`
-> both fixed by pending PR

Failed tests:
_none_


