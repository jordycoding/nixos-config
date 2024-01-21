#!/usr/bin/env nix-shell
#! nix-shell -i bash -p dialog nixpkgs-fmt perl jq
shopt -s globstar

choose_nix_config () {
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
        nixconfig=${configs[$choice-1]}
        add_disko_config
    else
        clear
        checkconfig
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

    diskoconfig=${disko_configs[$choice-1]}

    clear
    perl -i -0777 -spe "s/(?<=\Nimports\s=\s\[\n)(.*?)(?=\];)/\$1\n#Auto generated\n..\/..\/\$config\ninputs.disko.nixosModules.disko/s" -- -config="$diskoconfig" $nixconfig
    nixpkgs-fmt $nixconfig
    
    checkconfig
}

checkconfig () {
    echo
    echo "--System config--"
    echo $nixconfig
    echo
    cat $nixconfig
    echo "Is this correct? (y/n)"
    read answer
    case $answer in
        y|Y) ;;
        n|N) echo "Exiting..." && exit ;;
        *) echo "Invalid input" && exit ;;
    esac
    echo
    echo "--Disko config--"
    echo $diskoconfig
    echo
    cat $diskoconfig
    echo "Is this correct? (y/n)"
    read answer
    case $answer in
        y|Y) ;;
        n|N) echo "Exiting..." && exit ;;
        *) echo "Invalid input" && exit ;;
    esac
    partition
}

partition () {
    readarray -t options <  <(lsblk -J -d -o PATH,MODEl \
        | jq -r '.blockdevices[] | join(";")' \
        | awk -v OFS="\n" -F';' '{print $1, $2}'
        )
    CHOICE=$(dialog --clear \
                    --backtitle "NixOS Installation" \
                    --title "Partitioning" \
                    --menu "Select a disk to partition" \
                    0 0 0 \
                    "${options[@]}" \
                    2>&1 >/dev/tty)
    dialog  --stdout \
            --clear \
            --backtitle "NixOS Installation" \
            --title "Confirm" \
            --yesno "This will erase all contents on device $CHOICE, are you sure you want to proceed?" 0 0
    dialog_status=$?                
    if [ "$dialog_status" -eq 0 ];
    then
        sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko $diskoconfig --arg disks "[ \"$CHOICE\"]"
        install
    else
        exit 
    fi
}

install () {
    dialog  --clear \
            --backtitle "NixOS Installation" \
            --title "Finished partitioning" \
            --msgbox "Setup has finished partitioning the disk and will now begin installation" 0 0

    local configdir=$(dirname $nixconfig)
    sudo nixos-generate-config --no-filesystems --root /mnt --dir $configdir &> /dev/null
    rm -f $configdir/configuration.nix

    local hostname=$(perl -lne "print \$1 if /\s+networking\.hostName\s=\s\"(.*)\"/" $nixconfig)
    dialog  --stdout \
            --clear \
            --backtitle "NixOS Installation" \
            --title "Ready for installation" \
            --yesno "Do you want to proceed with installing NixOS" 0 0
    local confirmation=$?
    if [ "$confirmation" -eq 0 ];
    then
        sudo nixos-install --flake /mnt/etc/nixos#$hostname
    else
        exit
    fi

}

choose_nix_config
