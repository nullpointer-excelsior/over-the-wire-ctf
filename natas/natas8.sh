#!/bin/bash
url="http://natas8.natas.labs.overthewire.org"
user="natas8"
pass=$(cat credentials/natas8)
encoded_secret="3d3d516343746d4d6d6c315669563362"

secret=$(echo "$encoded_secret" | xxd -p -r | rev | base64 -d) 

curl -s -X POST -d "secret=$secret" -d "submit=submit" -u "$user:$pass" "$url" | grep "The password" | awk '{print $8}'
