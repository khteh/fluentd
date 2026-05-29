FROM fluent/fluentd:v1.19-debian
LABEL org.opencontainers.image.authors="Kok How, Teh <funcoolgeeek@gmail.com>"
# https://github.com/fluent/fluentd-docker-image/blob/master/HOWTOBUILD.md
# Use root account to use apt
USER root
# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish
RUN buildDeps="sudo make gcc g++ libc-dev libmaxminddb-dev libgeoip-dev" \
 && apt-get update \
 && apt-get install -y --no-install-recommends libmaxminddb0 libgeoip1t64 $buildDeps \
 && sudo gem install fluent-plugin-elasticsearch fluent-plugin-geoip fluent-plugin-filter_typecast fluent-plugin-fields-autotype \
 && sudo gem sources --clear-all \
 && SUDO_FORCE_REMOVE=yes \
    apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem
#RUN /usr/sbin/fluent-gem install fluent-plugin-elasticsearch fluent-plugin-geoip fluent-plugin-filter_typecast fluent-plugin-fields-autotype
#COPY fluent.conf /fluentd/etc/
COPY entrypoint.sh /bin/
RUN mkdir -p /var/log/td-agent/pos && chown -R fluent:fluent /var/log/td-agent
USER fluent
