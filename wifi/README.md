# A collection of wifi scripts

## connect.sh
To view WIFI or SSID's you should use iwlist and scan and to much thinking I made it easy for myself to create this script

## Usage

To view all the details of iwlist
```
bash connect.sh -i=wlan0
```

To view SSID's
```
bash connect.sh -i=wlan0 |grep SSID
```

If you need new iwlist results everytime you scan you can use
```
bash connect.sh --clear | bash connect.sh -i=wlan0
```

To add a wifi with wpa2 password to your wpa_supplicant file use the following command
```
bash connect.sh -s=your wifi -p=wpa password
```

To clear the iwlist cache file use the following command
```
bash connect.sh --clear
```
