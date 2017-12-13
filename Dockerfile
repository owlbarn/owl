############################################################
# Dockerfile to build Owl docker image
# Based on ryanrhymes/owl master branch
# By Liang Wang <liang.wang@cl.cam.ac.uk>
############################################################

FROM ubuntu:latest
MAINTAINER Liang Wang


##################### PREREQUISITES ########################

RUN apt-get update
RUN apt-get -y install git build-essential ocaml wget unzip aspcud m4 pkg-config
RUN apt-get -y install camlp4-extra libshp-dev libplplot-dev
RUN apt-get -y install libgsl-dev libopenblas-dev liblapacke-dev

RUN wget https://github.com/ocaml/opam/archive/2.0.0-beta4.tar.gz && tar xzvf 2.0.0-beta4.tar.gz
RUN cd opam-2.0.0-beta4 && ./configure && make lib-ext && make && make install
RUN yes | opam init && eval $(opam env) && opam update && opam switch create 4.04.0

RUN opam install -y oasis jbuilder ocaml-compiler-libs ctypes utop plplot "gsl=1.20.0"


#################### SET UP ENV VARS #######################

ENV PATH /root/.opam/4.04.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH
ENV CAML_LD_LIBRARY_PATH /root/.opam/4.04.0/lib/stublibs

ENV EIGENPATH /root/eigen
RUN cd /root && git clone https://github.com/ryanrhymes/eigen.git
RUN sed -i -- 's/-flto/ /g' $EIGENPATH/lib/Makefile ###FIXME
RUN sed -i -- 's/-flto/ /g' $EIGENPATH/_oasis       ###FIXME
RUN make -C $EIGENPATH oasis && make -C $EIGENPATH && make -C $EIGENPATH install


################## INSTALL OWL LIBRARY #####################

ENV OWLPATH /root/owl
RUN cd /root && git clone https://github.com/ryanrhymes/owl.git

# FIXME: hacking ... need to be fixed in future
RUN sed -i -- 's/-lopenblas/-lopenblas -llapacke/g' $OWLPATH/src/owl/jbuild

RUN make -C $OWLPATH && make -C $OWLPATH install


############## SET UP DEFAULT CONTAINER VARS ##############

RUN echo "#require \"owl_top\";; open Owl;;" >> /root/.ocamlinit
WORKDIR $OWLPATH
ENTRYPOINT /bin/bash
