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

If you are not using `opam`, you should run `make clean` before recompiling
the library after having changed any of those environment variables.
