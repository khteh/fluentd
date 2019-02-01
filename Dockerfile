FROM ubuntu:18.10
MAINTAINER Kok How, Teh <funcoolgeeek@gmail.com>
RUN apt update -y
RUN ulimit -n 65536
RUN apt install -y curl gnupg2 sudo
RUN curl -s https://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add -
RUN curl -sL https://toolbelt.treasuredata.com/sh/install-ubuntu-bionic-td-agent3.sh | sh
RUN sed -i -e "s/USER=td-agent/USER=root/" -e "s/GROUP=td-agent/GROUP=root/" /etc/init.d/td-agent
RUN /usr/sbin/td-agent-gem install fluent-plugin-elasticsearch
CMD /usr/sbin/td-agent $FLUENTD_ARGS
