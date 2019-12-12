#!/bin/bash

sudo docker run -d -p 12000:12000 logstash_a 

sudo docker run -d -p 12001:12001 kibana_a

sudo docker run -d -p 12002:12002 --privileged elas_a