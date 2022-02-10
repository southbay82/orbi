#!/bin/sh
#Parameters
ROOT_DIR=~/build/orbi_reboot
USER_PASS=$ORBISECRET
LOGGER_TAG="[orbi]"
logger -t $LOGGER_TAG "Rebooting Orbi...."

#Clear previous cookie
rm $ROOT_DIR/orbi.cookie 2>/dev/null
rm $ROOT_DIR/reboot.htm 2>/dev/null

#Authenticate, get cookie, and token
wget -O $ROOT_DIR/reboot.htm --user admin --password $USER_PASS --keep-session-cookies --save-cookies $ROOT_DIR/orbi.cookie "http://192.168.1.1/reboot.htm"

#Parse token
temp_token=$(/usr/bin/grep "apply" $ROOT_DIR/reboot.htm | /usr/bin/cut -d"=" -f4 | /usr/bin/cut -d "\"" -f1)

#Execute the reboot
wget -O $ROOT_DIR/result --user admin --password $USER_PASS --load-cookies $ROOT_DIR/orbi.cookie --post-data "submit_flag=reboot&yes=Yes" "http://192.168.1.1/apply.cgi?/reboot_waiting.htm timestamp=$temp_token"

#Cleanup
#m $ROOT_DIR/orbi.cookie 2>/dev/null
rm $ROOT_DIR/reboot.htm 2>/dev/null
rm $ROOT_DIR/result 2>/dev/null

#Touch tracker
touch $ROOT_DIR/last_run

#Return to previous path
exit 0