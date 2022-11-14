FROM ubuntu:22.10
MAINTAINER Kok How, Teh <funcoolgeeek@gmail.com>
RUN apt update -y
RUN ulimit -n 65536
RUN apt install -y curl gnupg2 sudo
RUN curl -s https://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add -
# https://docs.fluentd.org/installation/install-by-deb
RUN curl -fsSL https://toolbelt.treasuredata.com/sh/install-ubuntu-jammy-td-agent4.sh | sh
RUN sed -i -e "s/USER=td-agent/USER=root/" -e "s/GROUP=td-agent/GROUP=root/" /etc/td-agent/td-agent.conf
RUN apt install -y build-essential libgeoip-dev automake autoconf libtool
RUN /usr/sbin/td-agent-gem install fluent-plugin-elasticsearch fluent-plugin-geoip fluent-plugin-filter_typecast
CMD /usr/sbin/td-agent $FLUENTD_ARGS
