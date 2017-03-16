all:
	ocamlfind ocamlc -c -linkpkg -package ctypes.stubs owl_cblas_bindings.ml
	ocamlfind ocamlc -linkpkg -package ctypes.stubs owl_cblas_bindings.cmo owl_cblas_stubgen.ml -o owl_cblas_stubgen.byte
	./owl_cblas_stubgen.byte -ml > owl_cblas_generated.ml
	./owl_cblas_stubgen.byte -c > owl_cblas_generated_stub.c
install:
	cp owl_*_bindings.ml ../
	cp owl_*_generated* ../
clean:
	rm -rf _build *.cmo *.cmi *.byte *.so owl_cblas_generated*
