#!/bin/bash
$(aws ecr get-login --no-include-email)
docker build -t fluent .
docker tag fluent:latest 701969852130.dkr.ecr.ap-southeast-1.amazonaws.com/fluent:latest
docker push 701969852130.dkr.ecr.ap-southeast-1.amazonaws.com/fluent:latest
