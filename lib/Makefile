all:
	ocamlfind ocamlc -c matrix.ml -package lacaml
	ocamlfind ocamlc -c learn.ml matrix.cmo
test:
	ocamlfind ocamlopt -c matrix.ml -package lacaml
	ocamlfind ocamlopt -c learn.ml matrix.cmx
	ocamlfind ocamlopt -o test_matrix matrix.cmx test_matrix.ml -package lacaml -linkpkg
clean:
	rm -rf *.cmi *.cmo *.cmx *.o dummy
