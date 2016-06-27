all:
	ocamlfind ocamlc -c utils.ml
	ocamlfind ocamlc -c matrix.ml -package lacaml
	ocamlfind ocamlc -c learn.ml matrix.cmo -package lacaml
	ocamlfind ocamlc -o test_performance utils.cmo str.cma matrix.cmo test_performance.ml -package lacaml -linkpkg
	ocamlfind ocamlc -o test_operation utils.cmo str.cma matrix.cmo learn.cmo test_operation.ml -package lacaml -linkpkg
test:
	ocamlfind ocamlopt -c utils.ml
	ocamlfind ocamlopt -c matrix.ml -package lacaml
	ocamlfind ocamlopt -c learn.ml matrix.cmx -package lacaml
	ocamlfind ocamlopt -o test_performance utils.cmx str.cmxa matrix.cmx test_performance.ml -package lacaml -linkpkg
	ocamlfind ocamlopt -o test_operation utils.cmx str.cmxa matrix.cmx learn.cmx test_operation.ml -package lacaml -linkpkg
	ocamlfind ocamlopt -o test_kmeans utils.cmx str.cmxa matrix.cmx learn.cmx test_kmeans.ml -package lacaml -linkpkg
clean:
	rm -rf *.cmi *.cmo *.cmx *.o test*.tmp test_performance test_operation
