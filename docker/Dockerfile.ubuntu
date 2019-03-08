############################################################
# Dockerfile to build Owl docker image
# Based on owlbarn/owl master branch
# By Liang Wang <liang.wang@cl.cam.ac.uk>
############################################################

FROM ocaml/opam2:ubuntu
USER opam

##################### PREREQUISITES ########################

RUN sudo apt-get -y update
RUN sudo apt-get -y install m4 wget unzip aspcud libshp-dev libplplot-dev gfortran
RUN sudo apt-get -y install pkg-config git
RUN cd /home/opam/opam-repository && git pull --quiet origin master
RUN opam update -q

#################### INSTALL OPENBLAS ######################

ENV OPENBLASPATH /home/opam/OpenBLAS
RUN cd /home/opam && git clone https://github.com/xianyi/OpenBLAS.git
RUN cd $OPENBLASPATH && sudo make && sudo make install && sudo make clean

####################   INSTALL OWL  #######################

ENV OWLPATH /home/opam/owl
ENV PKG_CONFIG_PATH /opt/OpenBLAS/lib/pkgconfig:$PKG_CONFIG_PATH
RUN CFLAGS="-I/opt/OpenBLAS/include -L/opt/OpenBLAS/lib" opam install conf-openblas -y
RUN opam install owl owl-plplot -y

############## SET UP DEFAULT CONTAINER VARS ##############

RUN echo "#require \"owl-top\";; open Owl;;" >> /home/opam/.ocamlinit \
    && bash -c 'echo -e "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH" >> /home/opam/.profile' \
    && opam config env >> /home/opam/.bashrc \
    && bash -c "source /home/opam/.bashrc"

WORKDIR $OWLPATH
ENTRYPOINT /bin/bash

