FROM ubuntu:24.10
MAINTAINER Kok How, Teh <funcoolgeeek@gmail.com>
RUN apt update -y
RUN ulimit -n 65536
RUN apt install -y curl gnupg2 sudo
# https://docs.fluentd.org/installation/install-by-deb
RUN curl -fsSL https://toolbelt.treasuredata.com/sh/install-ubuntu-noble-fluent-package5.sh | sh
RUN apt install -y build-essential libgeoip-dev automake autoconf libtool
RUN /usr/sbin/fluent-gem install fluent-plugin-elasticsearch fluent-plugin-geoip fluent-plugin-filter_typecast fluent-plugin-fields-autotype
CMD /usr/sbin/fluentd $FLUENTD_ARGS
