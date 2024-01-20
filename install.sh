#!/usr/bin/env bash
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
        add_disko_config
    else
        clear
        echo $diskoconfig
    fi
}

add_disko_config () {
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
}

disko_config
