FROM fluent/fluentd:v1.3.3-debian-1.0
MAINTAINER Kok How, Teh <kokhow.teh@taiger.com>
# Use root account to use apt
USER root

# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish
RUN buildDeps="sudo make gcc g++ libc-dev ruby-dev"
RUN apt update -y
RUN apt install -y --no-install-recommends $buildDeps
RUN gem install fluent-plugin-elasticsearch
RUN gem sources --clear-all
RUN SUDO_FORCE_REMOVE=yes apt purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps
RUN rm -rf /var/lib/apt/lists/* /home/fluent/.gem/ruby/2.3.0/cache/*.gem
USER fluent
