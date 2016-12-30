all:
	ocamlfind ocamlc -c -linkpkg -package ctypes,dolog owl_types.ml
	ocamlfind ocamlc -c -linkpkg -package ctypes.stubs ffi_gsl_bindings.ml
	ocamlfind ocamlc -linkpkg -custom -package ctypes.stubs,dolog owl_types.cmo ffi_gsl_bindings.cmo ffi_gsl_stubgen.ml -o ffi_gsl_stubgen.byte
clean:
	rm -rf _build *.cmo *.cmi *.byte
