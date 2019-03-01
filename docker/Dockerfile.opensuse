############################################################
# Dockerfile to build Owl docker image
# Based on owlbarn/owl master branch
# By Liang Wang <liang.wang@cl.cam.ac.uk>
############################################################

FROM ocaml/opam2:opensuse-42.3
USER opam


##################### PREREQUISITES ########################

RUN sudo zypper -n update
RUN sudo zypper -n in git wget unzip m4 pkg-config gcc-fortran
RUN sudo zypper ref && sudo zypper -n in openblas-devel && sudo update-alternatives --config libblas.so.3

RUN opam update && opam switch create 4.06.0 && eval $(opam config env)
RUN opam install -y oasis dune ocaml-compiler-libs ctypes utop base stdio configurator alcotest sexplib

RUN sudo zypper -n in plplot-devel
RUN opam install -y plplot


#################### SET UP ENV VARS #######################

ENV PATH /home/opam/.opam/4.06.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH
ENV CAML_LD_LIBRARY_PATH /home/opam/.opam/4.06.0/lib/stublibs


################# INSTALL EIGEN LIBRARY ####################

RUN opam source --dev-repo eigen
RUN cd eigen && git checkout 0.1.1 && \
    echo 'version: "0.1.1"' >> eigen.opam && opam install -w .


################## INSTALL OWL LIBRARY #####################

ENV OWLPATH /home/opam/owl
RUN cd /home/opam && git clone https://github.com/owlbarn/owl.git
RUN make -C $OWLPATH && make -C $OWLPATH install


############## SET UP DEFAULT CONTAINER VARS ##############

RUN echo "#require \"owl-top\";; open Owl;;" >> /home/opam/.ocamlinit
WORKDIR $OWLPATH
ENTRYPOINT /bin/bash
