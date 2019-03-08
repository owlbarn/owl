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
RUN cd /home/opam/opam-repository && git pull --quiet origin master
RUN opam update -q

####################   INSTALL OWL  #######################

ENV OWLPATH /home/opam/owl
RUN opam install owl owl-plplot -y

############## SET UP DEFAULT CONTAINER VARS ##############

RUN echo "#require \"owl-top\";; open Owl;;" >> /home/opam/.ocamlinit \
    && bash -c 'echo -e "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH" >> /home/opam/.profile' \
    && opam config env >> /home/opam/.profile \
    && bash -c "source /home/opam/.profile"

WORKDIR $OWLPATH
ENTRYPOINT /bin/bash
