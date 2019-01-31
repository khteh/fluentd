#!/bin/bash
docker run -d -t -e FLUENTD_ARGS="-c /etc/td-agent/td-agent.conf" 701969852130.dkr.ecr.ap-southeast-1.amazonaws.com/fluent:latest
