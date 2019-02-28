############################################################
# Dockerfile to build Owl docker image
# Based on owlbarn/owl master branch
# By Liang Wang <liang.wang@cl.cam.ac.uk>
############################################################

FROM ocaml/opam2:debian-stable
USER opam

##################### PREREQUISITES ########################

RUN sudo apt-get -y update
RUN sudo apt-get -y install m4 wget unzip aspcud libshp-dev libplplot-dev gfortran
RUN sudo apt-get -y install pkg-config git camlp4-extra
RUN sudo apt-get -y install libopenblas-dev liblapacke-dev

RUN opam update && opam switch create 4.06.0 && eval $(opam config env)
RUN opam install -y dune ocaml-compiler-libs ctypes utop plplot stdio configurator alcotest sexplib


#################### SET UP ENV VARS #######################

ENV PATH /home/opam/.opam/4.06.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH
ENV CAML_LD_LIBRARY_PATH /home/opam/.opam/4.06.0/lib/stublibs
ENV LD_LIBRARY_PATH /usr/lib/:/usr/local/lib:/home/opam/.opam/4.06.0/lib/:/home/opam/.opam/4.06.0/lib/stublibs/:/usr/lib/x86_64-linux-gnu/:/opt/OpenBLAS/lib


################# INSTALL EIGEN LIBRARY ####################

ENV EIGENPATH /home/opam/eigen
RUN cd /home/opam/ && git clone https://github.com/owlbarn/eigen.git

RUN sed -i -- 's/-Wno-extern-c-compat -Wno-c++11-long-long -Wno-invalid-partial-specialization/-Wno-ignored-attributes/g' $EIGENPATH/eigen_cpp/lib/Makefile

RUN cd $EIGENPATH && make && make install

####################   INSTALL OWL  #######################

ENV OWLPATH /home/opam/owl
RUN cd /home/opam && git clone https://github.com/owlbarn/owl.git
RUN cd $OWLPATH && make && make install


############## SET UP DEFAULT CONTAINER VARS ##############

RUN echo "#require \"owl-top\";; open Owl;;" >> /home/opam/.ocamlinit \
    && bash -c 'echo -e "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH" >> /home/opam/.profile' \
    && opam config env >> /home/opam/.profile \
    && bash -c "source /home/opam/.profile"

WORKDIR $OWLPATH
ENTRYPOINT /bin/bash
