############################################################
# Dockerfile to build Owl container image from github
# Based on ryanrhymes/owl-base
# By Liang Wang <liang.wang@cl.cam.ac.uk>
############################################################

FROM ryanrhymes/owl-base
MAINTAINER Liang Wang


##################### PREREQUISITES ########################

# Set up the environment variables
ENV EIGENPATH /root/eigen
ENV PATH /root/.opam/4.04.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH
ENV CAML_LD_LIBRARY_PATH /root/.opam/4.04.0/lib/stublibs

RUN cd /root && git clone https://github.com/ryanrhymes/eigen.git
RUN make -C $EIGENPATH oasis && make -C $EIGENPATH && make -C $EIGENPATH install
RUN opam install ocaml-compiler-libs

RUN apt-get -y install libopenblas-dev liblapacke-dev


################## INSTALL OWL LIBRARY #####################

# Set up the environment variables
ENV OWLPATH /root/owl

# Clone the repo, compile, and install
RUN cd /root && git clone https://github.com/ryanrhymes/owl.git
RUN make -C $OWLPATH oasis && make -C $OWLPATH && make -C $OWLPATH install

# Set default container command
WORKDIR $OWLPATH
ENTRYPOINT /bin/bash
