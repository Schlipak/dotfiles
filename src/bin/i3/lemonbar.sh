#!/bin/bash

### GLOBALS ###
updates_print=""
temp_print=""
disk_print=""
volume_print=""
net_print=""
battery_print=""
time_print=""
###############

### WS BULLETS ###
WSOFF="\uf10c"
WSON="\uf111"
##################

### WORKSPACES ###
WS1="\uf268" # Chromium
WS2="\uf120" # Terminal
WS3="\uf121" # Code
WS4="\uf435" # Files
WS5="\uf38d" # Chat
WS6="\uf03e" # Image
WS7="\uf0c2" # Cloud
WS8="\uf1c0" # Database
WS9="\uf0ae" # Tasks
WS10="\uf074" # Random
##################

### SPACING ###
spacing="   "
###############

### COLORS ###
color_bright="#ffff9800"
color_dim="#ccf8f8f2"
color_off="#44f8f8f2"
color_main="#ddf8f8f2"
##############

# Draw workspace indicators
workspaces () {
    currentws=$(i3-msg -t get_workspaces | jq -r 'map(select(.focused))[0].num')
    wslist=$(i3-msg -t get_workspaces | jq -rjcM 'map(.num)' | cut -d'[' -f2 | cut -d']' -f1)
    for i in {1..10}
    do
        wscolor="color_off"
        wsname="WSOFF"
        if [ $i -eq $currentws ]
        then
            wscolor="color_bright"
            wsname="WSON"
            echo -ne "%{F${!wscolor}}%{A:i3-msg workspace $i:}${spacing}${!wsname}${spacing}%{A}%{F}"
            continue
        fi
        while IFS=',' read -ra ARREXIST; do
            for j in "${ARREXIST[@]}"; do
                if [ $i -eq $j ]
                then
                    wscolor="color_dim"
                    wsname="WSOFF"
                fi
            done
        done <<< "$wslist"
        echo -ne "%{F${!wscolor}}%{A:i3-msg workspace $i:}${spacing}${!wsname}${spacing}%{A}%{F}"
    done
}

# Get current time
gettime () {
    hour=$(date '+%H:%M')
    echo -e "%{F${color_main}}${spacing}\uf3b3  ${hour}${spacing}%{F}"
}

# Get battery indicator and percentage
getbattery () {
    percentage=$(cat /sys/class/power_supply/BAT0/capacity)
    specialspacing="  "
    if [ "$percentage" -ge 87 ]
    then
        indicator=""
	    percentage="${percentage}%"
    elif [ "$percentage" -ge 62 ]
    then
        indicator=""
	    percentage="${percentage}%" 
    elif [ "$percentage" -ge 37 ]
    then
        indicator=""
	    percentage="${percentage}%" 
    elif [ "$percentage" -ge 12 ]
    then
        indicator=""
	    percentage="${percentage}%" 
    else
        indicator=""
	    percentage="${percentage}%" 
    fi

    if [ "$(cat /sys/class/power_supply/BAT0/status)" = "Charging" ]
    then
	    indicator="\uf1e6"
    elif [ "$(cat /sys/class/power_supply/BAT0/status)" = "Full" ]
    then
        indicator="\uf240"
    fi
    echo -e "%{F${color_main}}${spacing}$indicator${specialspacing}$percentage${spacing}%{F}"
}

# Get current network status
networkstatus () {
    if [ $(nmcli --fields STATE -t d | head -1) = "connected" ]
    then
        echo -e "%{F${color_main}}${spacing}  Connected${spacing}%{F}"
    else
        echo -e "%{F${color_main}}${spacing}  No Connection${spacing}%{F}"
    fi
}

# Get current CPU temperature (First core only)
cpu_temperature () {
    temperature=$(sensors | grep "Physical" | cut -d' ' -f5 | cut -d+ -f2 | cut -d. -f1)
    if [[ -z ${temperature} ]]; then
        return
    fi
    echo -e "%{F${color_main}}${spacing}\uf2b6  ${temperature}°C${spacing}%{F}"
}

# Get pending updates number
updates () {
    number=$(yaourt -Qua | wc -l)
    case $number in  
        0)
            echo "";;
        1)
            echo -e "%{F${color_main}}${spacing}  ${number} Update${spacing}%{F}";;
        *)
            echo -e "%{F${color_main}}${spacing}  ${number} Updates${spacing}%{F}";;
    esac
}

# Get percentage of used disk space (Root partition only)
diskspace () {
    usage=$(df -h | grep /dev/sda8 | awk -F' ' '{ print $5 }' | awk -F% '{ print $1 }')
    if [[ -z ${usage} ]]; then
        return
    fi
    echo -e "%{F${color_main}}${spacing}  ${usage}%${spacing}%{F}"
}

# Get current sound volume
volume () {
    state=$(amixer get Master | grep "Front Left:" | awk -F'[' '{print $3}' | awk -F ']' '{print $1}')
    volume=$(amixer get Master | grep "Front Left:" | cut -d'[' -f2 | cut -d'%' -f1)
    if [ ${state} == 'on' ]; then
	    if [ "${volume}" -eq 0 ]; then
		    echo -e "%{F${color_main}}${spacing}\uf3b8  ${volume}%${spacing}%{F}"
	    elif [ "${volume}" -gt 0 ] && [ "${volume}" -lt 50 ]; then
		    echo -e "%{F${color_main}}${spacing}\uf3b7  ${volume}%${spacing}%{F}"
	    else
		    echo -e "%{F${color_main}}${spacing}\uf3ba  ${volume}%${spacing}%{F}"
	    fi
    else
	    echo -e "%{F${color_main}}${spacing}\uf3b9  ${volume}%${spacing}%{F}"
    fi
}

# Updates the printable values
update_values() {
    updates_print=$(updates)
    temp_print=$(cpu_temperature)
    disk_print=$(diskspace)
    volume_print=$(volume)
    net_print=$(networkstatus)
    battery_print=$(getbattery)
    time_print=$(gettime)
}

lb_time_now=$(date +%s)
update_values
while true; do
    current_tmp=$(date +%s)
    if [[ $((current_tmp - lb_time_now)) -gt 1 ]]; then
        lb_time_now=$(date +%s)
        update_values
    fi
    echo "%{l}${spacing}$(workspaces)%{r}${updates_print}${temp_print}${disk_print}${volume_print}${net_print}${battery_print}${time_print}${spacing}%{r}"
done
