#!/bin/bash
docker run -d -t -e FLUENTD_ARGS="-c /etc/td-agent/td-agent.conf" khteh/fluent:latest
