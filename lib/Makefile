all:
	ocamlfind ocamlc -c matrix.ml -package lacaml
	ocamlfind ocamlc -c learn.ml matrix.cmo
	ocamlfind ocamlc -o test_operation str.cma matrix.cmo test_operation.ml -package lacaml -linkpkg
test:
	ocamlfind ocamlopt -c matrix.ml -package lacaml
	ocamlfind ocamlopt -c learn.ml matrix.cmx
	ocamlfind ocamlopt -o test_performance str.cmxa matrix.cmx test_performance.ml -package lacaml -linkpkg
	ocamlfind ocamlopt -o test_operation str.cmxa matrix.cmx test_operation.ml -package lacaml -linkpkg
clean:
	rm -rf *.cmi *.cmo *.cmx *.o test_performance test_operation
