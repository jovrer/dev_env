#!/bin/bash

if [ -z $JO_BASEROOT ];then
    exit 'sys err'
fi


haltApp() {
    exit
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

checkDockerEnv() {
    # exit
    return 1
    # return 0
}

checkSign() {
    if [ $# == 2 ];then
        local filePath=$1
        local fileSign=$2        

        if [ -f $filePath ];then
            if [ $fileSign != "" ];then
                local signGen=`md5sum $filePath | cut -d " " -f1`                             
                if [ $signGen == $fileSign ];then                    
                    return 1
                else
                    logErr "err: $filePath has wrong sign"
                fi                 
            else
                logErr 'param file sign is empty'        
            fi    
        else
            logErr "$filePath is not exist"
        fi
        
    else 
        logErr 'checkSign need 2 param'        
    fi   

    return 0
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

