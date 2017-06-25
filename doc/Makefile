DIR="../lib"
DOCS=\
	${DIR}/owl_cblas.mli \
	${DIR}/owl_lapacke.ml \
	${DIR}/owl_lapacke_generated.mli \
	${DIR}/owl_dense_matrix_generic.mli \
	${DIR}/owl_dense_ndarray_generic.mli \
	${DIR}/owl_sparse_matrix_generic.mli \
	${DIR}/owl_sparse_ndarray_generic.mli \
	${DIR}/owl_linalg.mli \
	${DIR}/owl_maths.mli \
	${DIR}/owl_stats.mli \
	${DIR}/owl_algodiff_generic.mli \
	${DIR}/owl_algodiff_numerical.mli \
	${DIR}/neural/owl_neural_neuron.ml \
	${DIR}/neural/owl_neural_feedforward.ml \
	${DIR}/neural/owl_neural_graph.ml \
	${DIR}/owl_plot.mli \
	${DIR}/owl_operator.ml \
	${DIR}/owl_const.mli
INCDIR=\
	-I ../_build/lib \
	-I ../_build/lib/neural \
	-I `ocamlfind query ctypes` \
	-I `ocamlfind query dolog`
DOCFLAGS=-html -d .
all:
	ocamldoc ${INCDIR} ${DOCFLAGS} ${DOCS}
clean:
	rm -rf *.html *.css
