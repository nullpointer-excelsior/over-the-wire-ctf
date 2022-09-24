#!/bin/bash
url="http://natas3.natas.labs.overthewire.org"
user="natas3"
pass=$(cat credentials/natas3)
 
curl -s -u "$user:$pass" "$url/s3cr3t/users.txt" | awk -F ":" '{print $2}'
