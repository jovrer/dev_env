#!/bin/bash

exec ../../common/getenv.sh 
echo "before"
# exec ../../common/getenv.sh
echo "after"
# . ../../common/getenv.sh
echo 'over333'
env


exit

. ../../common/common.sh

checkDockEnv

# ls -l | awk '/^d/ {print $NF}'

installVer='7.4.2'
targetImg='elas_a'

# imageName

checkDockFileExist $installVer
if [ $? == 0 ];then
    echo 'Dockerfile not exist'
    haltApp
fi

exec ../checkAndGetArchive.sh $installVer

haltApp

dockerBuild $installVer $targetImg
if [ $? == 0 ];then
    echo 'build success'
else
    echo 'build failed'
fi



echo "over"
