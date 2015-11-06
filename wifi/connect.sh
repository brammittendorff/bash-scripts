#!/bin/bash

IWLIST_FILE=".iwlist.cache"
WPA_SUPPLICANT_FILE="/etc/wpa_supplicant/wpa_supplicant.conf"

for i in "$@"
do
case $i in
    -i=*|--interface=*)
    INTERFACE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
    ;;
    -s=*|--ssid=*)
    SSID=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
    ;;
    -p=*|--password=*)
    PASSWORD=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
    ;;
    --clear)
    CLEAR=true
    ;;
    *)

    ;;
esac
done

if [ ! -z $INTERFACE ]; then
    if [ ! -f $IWLIST_FILE ]; then
        echo "Scanning $INTERFACE and writing results to $IWLIST_FILE this may take a while..."
        sudo iwlist $INTERFACE scan > $IWLIST_FILE
        cat $IWLIST_FILE
    else
        cat $IWLIST_FILE
    fi
elif [ ! -z $SSID ] || [ ! -z $PASSWORD ]; then
    sudo sh -c "wpa_passphrase $SSID $PASSWORD >> $WPA_SUPPLICANT_FILE"
    echo "Wifi $SSID with password **** written to file $WPA_SUPPLICANT_FILE"
elif [ ${CLEAR} ]; then
    rm $IWLIST_FILE
else
    echo "Usage: connect.sh [INTERFACE] [SSID] [PASSWORD] [CLEAR]"
    echo "  -i, --interface         Interface to scan for wifi"
    echo "  -s, --ssid              The ssid of your wifi"
    echo "  -p, --password          Wpa password"
    echo "  --clear                 Remove iwlist cache file"
fi
