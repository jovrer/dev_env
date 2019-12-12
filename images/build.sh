#!/bin/sh


#docker run -v /Users/fku/Documents/mywork/dev_env:/data/wwwroot -it centos /bin/bash


setupEnv() {
    curFileAbs=$(readlink -f "$0")
    curFile="${curFileAbs##*/}"
    curBaseDir=$(dirname "$curFileAbs")

    export JO_BASEROOT=$curBaseDir
    export JO_ARCHIVE=$curBaseDir"/archives"
    export JO_ARCHIVECONF="archive_conf"
    export JO_ARCHIVESRC="src"
    export JO_SH=$curBaseDir"/sh"
    export JO_SCRIPT=$curBaseDir"/scripts"
    export JO_DOCKERFILE="Dockerfile"

}



setupEnv

cd $JO_BASEROOT

. $JO_SH'/common.sh'
. $JO_SH'/menu.sh'

menuModShow