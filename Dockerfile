############################################################
# Dockerfile to build Owl container image from github
# Based on ryanrhymes/owl-base
# By Liang Wang <liang.wang@cl.cam.ac.uk>
############################################################

FROM ryanrhymes/owl-base
MAINTAINER Liang Wang

################## INSTALL OWL LIBRARY #####################
# Set up the environment variables
ENV OWLPATH /root/owl
ENV PATH /root/.opam/4.04.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH
ENV CAML_LD_LIBRARY_PATH /root/.opam/4.04.0/lib/stublibs

# Clone the repo, compile, and install
RUN cd /root && git clone https://github.com/ryanrhymes/owl.git
RUN make -C $OWLPATH oasis && make -C $OWLPATH && make -C $OWLPATH install

# Set default container command
WORKDIR $OWLPATH
ENTRYPOINT /bin/bash
