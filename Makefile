all:
	ocamlfind ocamlopt -c ./lib/matrix.ml -package lacaml
	ocamlfind ocamlopt -c ./lib/learn.ml ./lib/matrix.cmx
	ocamlfind ocamlc -o dummy ../lib/matrix.cmx ./test/dummy.ml -package lacaml -linkpkg
clean:
	cd ./lib && rm -rf *.cmi *.cmo *.cmx *.o dummy && cd ../
