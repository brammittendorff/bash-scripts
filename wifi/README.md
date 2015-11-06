# A collection of wifi scripts

## connect.sh
To view WIFI or SSID's you should use iwlist and scan and to much thinking I made it easy for myself to create this script

## Usage

To view SSID's
```
sudo /bin/bash connect.sh -i=wlan0 |grep ssid
```

To view all the details of iwlist
```
sudo /bin/bash connect.sh -i=wlan0
```

To add a wifi with wpa2 password use the following command
```
sudo /bin/bash connect.sh -s=your wifi -p=wpa password
```

To clear the iwlist cache file use the following command
```
sudo /bin/bash connect.sh --clear
```
