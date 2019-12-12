#!/bin/bash

mods=()
if [ -z $JO_BASEROOT ];then
    exit 'sys err'
fi

function menuMod {
    # clear
    
    local modsBaseDir=$JO_SCRIPT     
    
    cd $modsBaseDir
    mods=(`ls -l | egrep "^d"| awk 'BEGIN{ORS=" "} {print $NF}'`)
    modsLen=${#mods[@]}
    
    local menuStr="\tchoose a image to install\n\n"
    menuStr=$menuStr"\t------------------------------\n\n"
    
    local modIndex=0
    for((; modIndex<$modsLen;modIndex++))
    do        
        menuStr=$menuStr"\t"$[modIndex+1]". "${mods[$modIndex]}"\n"
    done

    menuStr=$menuStr"\n\t0. Exit program\n\n"

    menuStr=$menuStr"\t------------------------------\n\n"
    menuStr=$menuStr"\tEnter option: "

    echo -e $menuStr    
    read -n 2 option    
}

function menuModShow {
    while [ 1 ]
    do
        menuMod
        # echo $modsLen
        case $option in
            0)
                haltApp 
                ;;
            [1-$modsLen])
                echo "ddd"
                exit
                menuVersionShow ${mods[$[$option-1]]}
                break           
                ;;
            *)  
                echo $option
                logWarn "Sorry, wrong selection"        
                ;;
        esac        
    done
}


# *****************************************************************
# **************  choose a version to install *********************
# ********                                                *********
# ********    1.ddddddddddddddd                           *********
# ********    1.ddddddddddddddd                           *********
# ********    1.ddddddddddddddd                           *********
# ********    1.ddddddddddddddd                           *********
# ********    1.ddddddddddddddd                           *********
# ********    1.ddddddddddddddd                           *********
# ********    1.ddddddddddddddd                           *********
# ********    1.ddddddddddddddd                           *********
# ********    1.ddddddddddddddd                           *********
# ********    1.ddddddddddddddd                           *********
# *****************************************************************
# *****************************************************************


function menuVersion {
    # clear
        
    mod=$1
    local verBaseDir="$JO_SCRIPT/$mod"
    
    cd $verBaseDir
    vers=(`ls -l | egrep "^d"| awk 'BEGIN{ORS=" "} {print $NF}'`)
    versLen=${#vers[@]}

    local menuStr="\tchoose a version to install\n\n"
    menuStr=$menuStr"\t********************************\n\n"

    local verIndex=0
    for((; verIndex<$versLen;verIndex++))
    do        
        menuStr=$menuStr"\t"$[verIndex+1]". "${vers[$verIndex]}"\n"
    done

    menuStr=$menuStr"\n\t0. go back to main menu\n\n"

    menuStr=$menuStr"\t------------------------------\n\n"
    menuStr=$menuStr"\tEnter option: "

    echo -e $menuStr
    read -n 2 option
}

function menuVersionShow {
    while [ 1 ]
    do
        menuVersion $1
        local verBaseDir="$JO_SCRIPT/$mod"
        

        case $option in
            0)
                menuModShow
                break
            ;;
            [1-$versLen])
                
                ver=${vers[$[$option-1]]}                

                if [ ! -f "$verBaseDir/$ver/$JO_DOCKERFILE" ];then
                    logErr "$verBaseDir/$ver/$JO_DOCKERFILE not exists"
                    menuModShow
                else 
                    . $JO_SH"/checkAndGetArchive.sh" $mod $ver
                    echo "build start...."
                    dockerBuild $mod "$verBaseDir/$ver/"
                    echo "build finish"
                fi
                break
            ;;
            *)            
                clear
                logWarn "Sorry, wrong selection"        
            ;;
        esac        
    done
}



clear
