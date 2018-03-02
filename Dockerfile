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
RUN apt-get -y install libopenblas-dev liblapacke-dev

RUN apt-get -y install opam && yes | opam init && eval $(opam config env)
RUN opam update && opam switch 4.06.0 && eval $(opam config env)
RUN opam install -y oasis jbuilder ocaml-compiler-libs ctypes utop plplot alcotest


#################### SET UP ENV VARS #######################

ENV PATH /root/.opam/4.06.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH
ENV CAML_LD_LIBRARY_PATH /root/.opam/4.06.0/lib/stublibs

ENV EIGENPATH /root/eigen
RUN cd /root && git clone https://github.com/ryanrhymes/eigen.git
RUN sed -i -- 's/-flto/ /g' $EIGENPATH/lib/Makefile # FIXME: hacking
RUN sed -i -- 's/-flto/ /g' $EIGENPATH/_oasis       # FIXME: hacking
RUN make -C $EIGENPATH oasis && make -C $EIGENPATH && make -C $EIGENPATH install


################## INSTALL OWL LIBRARY #####################

ENV OWLPATH /root/owl
RUN cd /root && git clone https://github.com/ryanrhymes/owl.git

RUN sed -i -- 's/-lopenblas/-lopenblas -llapacke/g' $OWLPATH/src/owl/jbuild  # FIXME: hacking
RUN make -C $OWLPATH && make -C $OWLPATH install && make -C $OWLPATH test && make -C $OWLPATH clean
RUN mv /root/.opam/4.06.0/lib/stubslibs/* /root/.opam/4.06.0/lib/stublibs    # FIXME: hacking


############## SET UP DEFAULT CONTAINER VARS ##############

RUN echo "#require \"owl_top\";; open Owl;;" >> /root/.ocamlinit
WORKDIR $OWLPATH
ENTRYPOINT /bin/bash
