all:
	ocamlfind ocamlc -c matrix.ml -package lacaml
	ocamlfind ocamlc -o dummy matrix.cmo dummy.ml -package lacaml -linkpkg
clean:
	rm -rf *.cmi *.cmo *.cmx *.o dummy
