FROM ubuntu:latest

SHELL ["/bin/bash", "-c"]

ENV PATH="$PATH:~/FlowMethod/codeql"

WORKDIR /root

ADD scripts /root/scripts
ADD scripts/flowmethod.sh /root

RUN ["./scripts/install_dependencies.sh"]
RUN ["./scripts/install_codeql.sh"]
RUN ["./scripts/clone_repos.sh"]
