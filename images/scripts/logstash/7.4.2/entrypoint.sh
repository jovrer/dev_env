#!/bin/bash

userfolder="/home/logstash"
exefile="/usr/local/logstash/bin/logstash"
configfile="/usr/local/logstash/config/logstash-sample.conf"

if [ ! -d "$userfolder" ]; then
    mkdir "$userfolder"
fi

su - logstash -c "$exefile -f $configfile"


