FROM ubuntu:26.04
LABEL org.opencontainers.image.authors="Kok How, Teh <funcoolgeeek@gmail.com>"
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update -y
RUN ulimit -n 65536
RUN apt install -y curl gnupg2 sudo build-essential libgeoip-dev automake autoconf libtool
# https://docs.fluentd.org/installation/install-by-deb
RUN curl -fsSL https://fluentd.cdn.cncf.io/sh/install-ubuntu-noble-fluent-package6.sh | sh
RUN /usr/sbin/fluent-gem install fluent-plugin-elasticsearch fluent-plugin-geoip fluent-plugin-filter_typecast fluent-plugin-fields-autotype
CMD /usr/sbin/fluentd $FLUENTD_ARGS
