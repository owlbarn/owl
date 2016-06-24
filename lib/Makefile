all:
	ocamlfind ocamlc -c matrix.ml -package lacaml
	ocamlfind ocamlc -c learn.ml matrix.cmo
	ocamlfind ocamlc -o dummy matrix.cmo dummy.ml -package lacaml -linkpkg
native:
	ocamlfind ocamlopt -c matrix.ml -package lacaml
	ocamlfind ocamlopt -c learn.ml matrix.cmx
	ocamlfind ocamlopt -o dummy matrix.cmx dummy.ml -package lacaml -linkpkg	
clean:
	rm -rf *.cmi *.cmo *.cmx *.o dummy
