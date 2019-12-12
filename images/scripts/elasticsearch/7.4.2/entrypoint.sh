#!/bin/bash

userfolder="/home/elas"
exefile="/usr/local/elasticsearch/bin/elasticsearch"

limitFile="/etc/security/limits.d/90-nproc.conf"

if [ ! -d "$userfolder" ]; then
    mkdir "$userfolder"
fi

if [ ! -f "$limitFile" ]; then
    sed '$a\eof elas soft nproc 4096\eof' "$limitFile"    
fi




sysctl -w vm.max_map_count=262144 &
ulimit -u 4096 &
su - elas -c "$exefile"
