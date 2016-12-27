all:
	ocamlbuild -use-ocamlfind -package alcotest,owl unit_dense_matrix.native
	ocamlbuild -use-ocamlfind -package alcotest,owl unit_dense_ndarray.native
	ocamlbuild -use-ocamlfind -package alcotest,owl unit_sparse_matrix.native
	ocamlbuild -use-ocamlfind -package alcotest,owl unit_sparse_ndarray.native
clean:
	rm -rf _build
	rm -rf *.native *.byte
