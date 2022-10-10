#!/bin/bash

user="natas18" 
url="http://$user.natas.labs.overthewire.org" 
pass=$(cat credentials/natas18)

curl -s -u "$user:$pass" "$url" | html2text
