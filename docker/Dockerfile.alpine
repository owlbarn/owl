############################################################
# Dockerfile to build Owl docker image
# Based on owlbarn/owl master branch
# By Liang Wang <liang.wang@cl.cam.ac.uk>
############################################################

FROM ocaml/opam2:alpine
USER opam

##################### PREREQUISITES ########################

RUN sudo apk update
RUN sudo apk add m4 wget unzip aspcud openblas-dev
RUN cd /home/opam/opam-repository && git pull --quiet origin master
RUN opam update -q

#################### SET UP ENV VARS #######################

RUN echo "#require \"owl-top\";; open Owl;;" >> /home/opam/.ocamlinit \
    && bash -c 'echo -e "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH" >> /home/opam/.profile' \
    && opam config env >> /home/opam/.profile \
    && bash -c "source /home/opam/.profile"

####################   INSTALL OWL  #######################

ENV OWLPATH /home/opam/owl
RUN opam install owl -y

############## SET UP DEFAULT CONTAINER VARS ##############

WORKDIR $OWLPATH
ENTRYPOINT /bin/sh
