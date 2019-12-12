#!/bin/bash


if [ -z $JO_BASEROOT ];then
    exit 'sys err'
fi

echo $mod $ver

local dirArchive=$JO_ARCHIVE
local curModDir="$JO_SCRIPT/$mod/$ver"
local curArchiveConfDir="$curModDir/$JO_ARCHIVECONF"
local curArchiveSrcDir="$curModDir/$JO_ARCHIVESRC"


if [ ! -d $curArchiveSrcDir ];then
    mkdir $curArchiveSrcDir
fi

if [ ! -d $dirArchive ];then
    mkdir $dirArchive
fi
if [ ! -d $dirArchive"/$mod" ];then
    mkdir $dirArchive"/$mod"
fi
if [ ! -d $dirArchive"/$mod/$ver" ];then
    mkdir $dirArchive"/$mod/$ver"
fi

dirArchive=$dirArchive"/$mod/$ver"

if [ -d $curArchiveConfDir ];then
    echo "begin down"
    cd $curArchiveConfDir
    local confFiles=(`ls *.sh`) 
    for configFile in $confFiles
    do
        ARCH_FILE=''
        ARCH_DOWN_URL=''        
        source "$curArchiveConfDir/$configFile"
        
        local fileExist=0
        if [ $ARCH_FILE ];then            
            if [ -f "$curArchiveSrcDir/$ARCH_FILE" ];then
                checkSign "$curArchiveSrcDir/$ARCH_FILE" "$ARCH_FILE_SIGN"
                if [ $? == 1 ];then
                    fileExist=1
                fi
            fi

            if [ $fileExist!=1 ];then
                if [ -f "$dirArchive/$ARCH_FILE" ];then
                    checkSign "$dirArchive/$ARCH_FILE" "$ARCH_FILE_SIGN"
                    if [ $? == 1 ];then
                        fileExist=1                
                    fi
                fi

                if [ $fileExist!=1 ];then
                    rm -rf "$dirArchive/*"
                    if [ $ARCH_DOWN_URL ];then
                        logOk "downloading $ARCH_DOWN_URL to $curArchiveSrcDir/ "
                        wget -P "$curArchiveSrcDir/" $ARCH_DOWN_URL
                        logOk "download end "
                    fi
                else                    
                    logOk "ok, $dirArchive/$ARCH_FILE has exist"                                      
                fi
                
                if [ -f "$dirArchive/$ARCH_FILE" ];then
                    rm -rf "$curArchiveSrcDir/*"                    
                    logOk "copying $dirArchive/$ARCH_FILE to $curArchiveSrcDir/ "
                    cp "$dirArchive/$ARCH_FILE" "$curArchiveSrcDir/"
                    logOk "copy end "
                else
                    logErr "error: not exist $dirArchive/$ARCH_FILE"
                fi                
            else
                logOk "ok, $curArchiveSrcDir/$ARCH_FILE has exist"
            fi            
        else 
            logErr "have no archive file config"
        fi        
    done
fi