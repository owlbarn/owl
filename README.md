# Owl - OCaml Scientific and Engineering Computing

Owl is a dedicated system for scientific and engineering computing in the
functional programming language OCaml.

This software is currently maintained by [Komposio](http://komposio.com), a
Helsinki-based software consulting company.

Visit the project website at [ocaml.xyz](http://ocaml.xyz)



## Optional features

You can enable optional features by setting the following variables to `1`
before compilation:

- `OWL_ENABLE_EXPMODE=1`: turn on experiment features like `-flto`

- `OWL_ENABLE_DEVMODE=1`: turn on all the warnings in development

- `OWL_ENABLE_OPENMP=1`: turn on OpenMP support in core module and
  the automatic parameter tuning (AEOS)

- `OWL_CFLAGS` allows to change the default flags passed to the C targets,
  it defaults to
  ```
  OWL_CFLAGS="-g -O3 -Ofast -march=native -mfpmath=sse -funroll-loops -ffast-math -DSFMT_MEXP=19937 -msse2 -fno-strict-aliasing -Wno-tautological-constant-out-of-range-compare"`
  ```

- `OWL_AEOS_CFLAGS` allows to change the default flags passed to the C targets
  when compiling AEOS. It defaults to
  ```
  OWL_AEOS_CFLAGS="-g -O3 -Ofast -march=native -funroll-loops -ffast-math -DSFMT_MEXP=19937 -fno-strict-aliasing"
  ```

- `OWL_DISABLE_LAPACKE_LINKING_FLAG=1` disables the `-llapacke` flag in the
  linking options. This is useful when you have lapacke installed on
  non-standard localtion.

If you are not using `opam`, you should run `make clean` before recompiling
the library after having changed any of those environment variables.

For examples of use of this feature, you can refer to the `Docker.ubuntu`
and `Docker.ubuntu.arm` docker files, or to the snippet in
https://github.com/owlbarn/owl/issues/394#issuecomment-471364916
(which also shows how to use it within `esy`).

## Troubleshooting

A common source of frustration when installing `owl` is the possible appearence of linking errors (see for example https://github.com/owlbarn/owl/issues/450).
This usually happens when installing `owl` on ubuntu (where it depends on how openblas is complied and packaged), but could happen in other distributions (see for example https://discuss.ocaml.org/t/owl-undefined-symbols-after-standard-installation/4186/13).
The only way we could solve those issues is to recompile `openblas` and install it manually. You can see how we do it by looking at the Docker files in the repository: https://github.com/owlbarn/owl/blob/master/docker/Dockerfile.ubuntu
