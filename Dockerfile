from alpine:3.11

run mkdir /wien2k

copy WIEN2k_19.1.tar /wien2k

run apk update \
  && apk add make gcc gfortran tcsh \
  && cd /wien2k \
  && tar -xvf WIEN2k_19.1.tar \
  && gunzip *.gz \
  && chmod +x expand_lapw \
  && ./expand_lapw

