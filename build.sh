#!/bin/bash
$(aws ecr get-login --no-include-email)
docker build -t fluentd .
docker tag fluentd:latest 701969852130.dkr.ecr.ap-southeast-1.amazonaws.com/fluentd:latest
docker push 701969852130.dkr.ecr.ap-southeast-1.amazonaws.com/fluentd:latest
docker tag fluentd:latest khteh/fluentd:latest
docker push khteh/fluentd:latest
