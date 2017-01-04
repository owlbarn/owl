all:
	# gsl:
	ocamlfind ocamlc -c -linkpkg -package ctypes,dolog owl_types.ml
	ocamlfind ocamlc -c -linkpkg -package ctypes.stubs ffi_gsl_bindings.ml
	ocamlfind ocamlc -linkpkg -package ctypes.stubs,dolog owl_types.cmo ffi_gsl_bindings.cmo ffi_gsl_stubgen.ml -o ffi_gsl_stubgen.byte
	# generate ffi stubs
	./ffi_gsl_stubgen.byte -ml > ffi_gsl_generated.ml
	./ffi_gsl_stubgen.byte -c > ffi_gsl_generated_stub.c
	# eigen:
	ocamlfind ocamlc -c -linkpkg -package ctypes.stubs ffi_eigen_bindings.ml
	ocamlfind ocamlc -linkpkg -package ctypes.stubs ffi_eigen_bindings.cmo ffi_eigen_stubgen.ml -o ffi_eigen_stubgen.byte
	# generate ffi stubs
	./ffi_eigen_stubgen.byte -ml > ffi_eigen_generated.ml
	./ffi_eigen_stubgen.byte -c > ffi_eigen_generated_stub.c
install:
	cp ffi_*_bindings.ml ../
	cp ffi_*_generated* ../
clean:
	rm -rf _build *.cmo *.cmi *.byte *.so ffi_gsl_generated* ffi_eigen_generated*
