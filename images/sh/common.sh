#!/bin/bash

if [ -z $JO_BASEROOT ];then
    exit 'sys err'
fi


haltApp() {
    exit
}

checkDockEnv() {
    # exit
    return 1
}

checkDockFileExist() {    
    fName='Dockerfile'
    if [ $# != 1 ];then
        echo 'need 1 param'
        haltApp
    fi

    
    echo "./"$1"/"$fName

    if [ -f "./"$1"/"$fName ];then
        return 1
    fi
    return 0
}

dockerBuild() {
    if [ $# != 2 ];then
        echo 'need 2 param'
        return 0
    fi
    
    docker build -t $1 $2
    return 1
}

logOk() {
    echo -e "\033[40;42m $1 ! \033[0m"    
}

logErr() {
    echo -e "\033[40;41m $1 ! \033[0m"
}

logWarn() {
    echo -e "\033[43;35m $1 ! \033[0m"    
}