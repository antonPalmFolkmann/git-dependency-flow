FROM ubuntu:latest

SHELL ["/bin/bash", "-c"]

ENV PATH="$PATH:~/Documents/FlowMethod/codeql"

WORKDIR /root

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install git
RUN apt-get -y install pip
RUN apt-get -y install python3
RUN apt-get -y install wget
RUN apt-get -y install unzip
RUN pip install infomap
RUN pip install virtualenv

COPY docker-startup-script.sh /root

RUN ["./docker-startup-script.sh"]
