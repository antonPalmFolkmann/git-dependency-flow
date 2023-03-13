FROM ubuntu:latest

WORKDIR /app

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install git
RUN apt-get install pip
RUN pip install python3
RUN pip install infomap

COPY . .
COPY flowmethod.sh /

ENTRYPOINT ["/flowmethod.sh"]