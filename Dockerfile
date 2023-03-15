FROM ubuntu:latest

SHELL ["/bin/bash", "-c"]

ENV PATH="$PATH:~/Documents/FlowMethod/codeql"

WORKDIR /root

ADD scripts /root/scripts


RUN ["./scripts/install_dependencies.sh"]
RUN ["./scripts/install_codeql.sh"]
