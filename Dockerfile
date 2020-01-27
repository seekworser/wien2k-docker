FROM ubuntu:xenial

ENV WIENROOT=/wien2k
ENV PATH=$PATH:/wien2k

RUN mkdir /wien2k

COPY WIEN2k_19.1.tar /wien2k
COPY expand_lapw_inputs /wien2k
COPY siteconfig_lapw_inputs /wien2k
COPY w2web_inputs /wien2k
COPY hfpara_lapw /
COPY x_lapw /

RUN sed -i.bak -e "s%http://us.archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list \
  && apt update \
  && apt install -y make gcc gfortran tcsh libstdc++6 libc-dev perl bc liblapack-dev libblas-dev gnuplot \
  && cd /wien2k \
  && tar -xvf WIEN2k_19.1.tar \
  && gunzip *.gz \
  && chmod +x expand_lapw \
  && ./expand_lapw < expand_lapw_inputs \
  && cp /hfpara_lapw /wien2k \
  && cp /x_lapw /wien2k \
  && ./siteconfig_lapw < siteconfig_lapw_inputs \
  && w2web < w2web_inputs
