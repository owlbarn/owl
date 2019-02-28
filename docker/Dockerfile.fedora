############################################################
# Dockerfile to build Owl docker image
# Based on owlbarn/owl master branch
# By Liang Wang <liang.wang@cl.cam.ac.uk>
############################################################

FROM ocaml/opam2:fedora-29
USER opam


##################### PREREQUISITES ########################

RUN sudo yum update -y
RUN sudo yum -y install git wget unzip m4 pkg-config gcc-gfortran
RUN sudo dnf -y install openblas-devel plplot-devel

RUN opam update && opam switch create 4.06.0 && eval $(opam config env)
RUN opam install -y dune ocaml-compiler-libs ctypes utop stdio configurator alcotest sexplib plplot


#################### SET UP ENV VARS #######################

ENV PATH /home/opam/.opam/4.06.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH
ENV CAML_LD_LIBRARY_PATH /home/opam/.opam/4.06.0/lib/stublibs


################# INSTALL EIGEN LIBRARY ####################

ENV EIGENPATH /home/opam/eigen
RUN cd /home/opam/ && git clone https://github.com/owlbarn/eigen.git

RUN sed -i -- 's/-Wno-extern-c-compat -Wno-c++11-long-long -Wno-invalid-partial-specialization/-Wno-ignored-attributes/g' $EIGENPATH/eigen_cpp/lib/Makefile

RUN cd $EIGENPATH && make && make install


################## INSTALL OWL LIBRARY #####################

ENV OWLPATH /home/opam/owl
RUN cd /home/opam && git clone https://github.com/owlbarn/owl.git

RUN make -C $OWLPATH && make -C $OWLPATH install


############## SET UP DEFAULT CONTAINER VARS ##############

RUN echo "#require \"owl-top\";; open Owl;;" >> /home/opam/.ocamlinit
WORKDIR $OWLPATH
ENTRYPOINT /bin/bash
