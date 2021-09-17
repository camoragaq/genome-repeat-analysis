################# BASE IMAGE #####################
FROM ubuntu:bionic-20200921
#FROM ubuntu:20.04
##site to test docker configuration files
# https://labs.play-with-docker.com/
################## METADATA #######################
LABEL base_image="ubuntu:bionic-20200921"
LABEL version="4.7.12"
LABEL software="genome-repeat-analysis"
LABEL software.version="0.1"
LABEL about.summary="Container image containing all requirements for polishing assemblies"
LABEL about.home="https://github.com/camoragaq/"
LABEL about.documentation="https://github.com/camoragaq/genome-repeat-analysis/README.md"
LABEL about.license_file="https://github.com/camoragaq/genome-repeat-analysis/LICENSE.txt"
LABEL about.license="GNU-3.0"

################## MAINTAINER ######################
MAINTAINER Carol Moraga <camoragaq@gmail.com>
################## INSTALLATION ######################
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
   wget \
   ca-certificates \
   perl-doc build-essential libomp-8-dev 
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -b -p /miniconda
ENV PATH /miniconda/bin:$PATH

COPY environment-genome-repeat-analysis.yml /
RUN conda env create -n genome-repeat-analysis -f /environment-genome-repeat-analysis.yml && conda clean -a
ENV PATH /miniconda/envs/genome-repeat-analysis/bin:$PATH


