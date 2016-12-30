all:
	ocamlfind ocamlc -c -linkpkg -package ctypes,dolog owl_types.ml
	ocamlfind ocamlc -c -linkpkg -package ctypes.stubs ffi_bindings_base.ml
	ocamlfind ocamlc -linkpkg -custom -package ctypes.stubs,dolog owl_types.cmo ffi_bindings_base.cmo ffi_stubgen.ml -o ffi_stubgen.byte
clean:
	rm -rf _build *.cmo *.cmi *.byte
