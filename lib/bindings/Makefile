all:
	# generate cblas bindings
	ocamlfind ocamlc -linkpkg -package str,unix owl_cblas_parser.ml -o owl_cblas_parser.native
	./owl_cblas_parser.native ../cblas.h owl_cblas_bindings.ml owl_cblas.ml

	# generate lapacke bindings
	ocamlfind ocamlc -linkpkg -package str,unix owl_lapacke_parser.ml -o owl_lapacke_parser.native
	./owl_lapacke_parser.native ../lapacke.h owl_lapacke_bindings.ml owl_lapacke.ml

	# compile interface generation application
	ocamlfind ocamlc -c -linkpkg -package ctypes.stubs owl_cblas_bindings.ml
	ocamlfind ocamlc -linkpkg -package ctypes.stubs owl_cblas_bindings.cmo owl_cblas_stubgen.ml -o owl_cblas_stubgen.native
	ocamlfind ocamlc -c -linkpkg -package ctypes.stubs owl_lapacke_bindings.ml
	ocamlfind ocamlc -linkpkg -package ctypes.stubs owl_lapacke_bindings.cmo owl_lapacke_stubgen.ml -o owl_lapacke_stubgen.native

	# generate interface using ctypes
	./owl_cblas_stubgen.native -ml > owl_cblas_generated.ml
	./owl_cblas_stubgen.native -c > owl_cblas_generated_stub.c
	./owl_lapacke_stubgen.native -ml > owl_lapacke_generated.ml
	./owl_lapacke_stubgen.native -c > owl_lapacke_generated_stub.c
install:
	cp owl_cblas.ml* ../
	cp owl_cblas_generated_stub.c ../owl_cblas_stub.c
	cp owl_lapacke.ml* ../
	cp owl_lapacke_generated_stub.c ../owl_lapacke_stub.c
test:
	#ocamlfind ocamlc -c -linkpkg -package ctypes.stubs owl_lapacke_generated.ml
	ocamlfind ocamlc -c -linkpkg -package ctypes.stubs owl_cblas_generated.ml
clean:
	rm -rf _build *.cmo *.cmi *.native *.so
	rm -rf owl_*_generated* owl_lapacke_bindings.ml
	rm -rf owl_cblas.ml* owl_lapacke.ml*
