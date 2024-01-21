#!/usr/bin/env nix-shell
#! nix-shell -i bash -p dialog nixpkgs-fmt perl
shopt -s globstar

disko_config () {
    local MENU_OPTIONS=
    local CONFIG_OPTIONS=
    local COUNT=0

    local configs=(hosts/**/default.nix)

    for i in "${configs[@]}"
    do
        local COUNT=$[COUNT+1]
        local MENU_OPTIONS="$MENU_OPTIONS $COUNT $i"
    done
    local cmd=(dialog --menu "Select NixOS Config:" 22 76 16)
    local options=($MENU_OPTIONS)
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

    local diskoconfig=$(perl -lne "print \$1 if /.*\/(disko\/.*\.nix)/" ${configs[$choice-1]})
    if [ -z "$diskoconfig" ]
    then
        add_disko_config ${configs[$choice-1]}
    else
        clear
        checkconfig ${configs[$choice-1]} $diskoconfig
    fi
}

add_disko_config () {
    echo $1
    local MENU_OPTIONS=
    local DISKO_OPTIONS=
    local COUNT=

    local disko_configs=(disko/**/*.nix)

    for i in "${disko_configs[@]}"
    do
        local COUNT=$[COUNT+1]
        local MENU_OPTIONS="$MENU_OPTIONS $COUNT $i"
    done
    local cmd=(dialog --clear --menu "No disko config in selected configuration, select one:" 22 76 16)
    local options=($MENU_OPTIONS)
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

    configfile=${disko_configs[$choice-1]}

    clear
    perl -i -0777 -spe "s/(?<=\Nimports\s=\s\[\n)(.*?)(?=\];)/\$1\n#Auto generated\n..\/..\/\$config\ninputs.disko.nixosModules.disko/s" -- -config="$configfile" $1
    nixpkgs-fmt $1
    
    checkconfig $1 $configfile
}

checkconfig () {
    echo
    echo "--System config--"
    echo $1
    echo
    cat $1 
    echo "Is this correct? (y/n)"
    read answer
    case $answer in
        y|Y) ;;
        n|N) echo "Exiting..." && exit ;;
        *) echo "Invalid input" && exit ;;
    esac
    echo
    echo "--Disko config--"
    echo $2
    echo
    cat $2
    echo "Is this correct? (y/n)"
    read answer
    case $answer in
        y|Y) ;;
        n|N) echo "Exiting..." && exit ;;
        *) echo "Invalid input" && exit ;;
    esac
    echo "Press enter to begin installation"
    read answer
    if [ "$answer" = "" ];
    then
        partition $2
    else
        echo "cancelling"
    fi
}

partition () {
    clear
    echo "Choose disk to partition"
    lsblk -f
    read disk
    echo "This will erase the contents on drive /dev/$disk, are you sure you wanna proceed? (y/n)"
    read answer
    case $answer in
        y|Y) ;;
        n|N) echo "Exiting..." && exit ;;
        *) echo "Invalid input" && exit ;;
    esac
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko $1 --arg disks '['"/dev/$disk"']'
}

disko_config
