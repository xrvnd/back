#!/bin/zsh

function back () {

    #saving IFS (internal field separator which is space/tab as default)
    local OLDIFS=$IFS

    #change IFS to /
    IFS=/

    #get all paths as words and store in an array
    #using zsh's native string splitting ${(s:/:)PWD} instead of ($PWD)
    #because bash-style ($PWD) splitting doesnt work reliably in zsh
    local path_arr=("${(s:/:)PWD}")

    #setting IFS as the default IFS : space/tab
    IFS=$OLDIFS

    #pos starts at 0, and increments AFTER each check
    #so when we match, pos already holds the correct index of that dir
    local pos=0
    local found=0

    #loop through every dir name in path_arr
    for dir in "${path_arr[@]}"
    do
        #dir name matching
        if [ "$1" = "$dir" ]
        then
            found=1

            #now get how many levels up i might need to go
            #get total dirs in path
            local dir_in_path=${#path_arr[@]}

            #save current path
            local cwd=$PWD

            #to go back ../ , need to take total dirs, get the
            #pos of target and then reduce 1 to account for matched dir
            #i.e totaldirs - pos - 1 = limit (no. of ../s)
            local limit=$((dir_in_path - pos - 1))

            #append /.. to this path for each level
            for ((i=0; i < limit; i++))
            do
                cwd=$cwd/..
            done

            #then navigate to path
            cd $cwd

            #break after finding target
            break

        fi

        #increment pos after the check so it correctly reflects
        #the index of the current dir when we match on next iteration
        pos=$((pos+1))

    done

    if [ $found -eq 0 ]; then
        echo "back: '$1' not found in current path"
        return 1
    fi

}