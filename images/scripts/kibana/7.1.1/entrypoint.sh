#!/bin/bash

userfolder="/home/kibana"
exefile="/usr/local/kibana/bin/kibana"

if [ ! -d "$userfolder" ]; then
    mkdir "$userfolder"
fi
su - kibana -c "$exefile"