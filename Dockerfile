############################################################
# Dockerfile to build Owl container image from github
# Based on ryanrhymes/owl-base
# By Liang Wang <liang.wang@cl.cam.ac.uk>
############################################################

FROM ryanrhymes/owl-base
MAINTAINER Liang Wang


##################### PREREQUISITES ########################

# Set up the environment variables
ENV PATH /root/.opam/4.04.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH
ENV CAML_LD_LIBRARY_PATH /root/.opam/4.04.0/lib/stublibs

ENV EIGENPATH /root/eigen
RUN cd /root && git clone https://github.com/ryanrhymes/eigen.git
RUN make -C $EIGENPATH oasis && make -C $EIGENPATH && make -C $EIGENPATH install

RUN opam update
RUN opam install ocaml-compiler-libs
RUN opam install jbuilder

RUN apt-get -y install libopenblas-dev liblapacke-dev


################## INSTALL OWL LIBRARY #####################

ENV OWLPATH /root/owl
RUN cd /root && git clone https://github.com/ryanrhymes/owl.git

# FIXME: hacking ... need to be fixed in future
RUN sed -i -- 's/-lopenblas/-lopenblas -llapacke/g' $OWLPATH/src/owl/jbuild

RUN make -C $OWLPATH && make -C $OWLPATH install

# FIXME: hacking ... need to be fixed in future
RUN mv /root/.opam/4.04.0/lib/stubslibs/dllowl_stubs.so /root/.opam/4.04.0/lib/stublibs/dllowl_stubs.so


# Set default container command
WORKDIR $OWLPATH
ENTRYPOINT /bin/bash
