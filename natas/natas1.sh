url="http://natas1.natas.labs.overthewire.org" 
user="natas1" 
pass=$(cat credentials/natas1)

# natas1 context menu disabled
curl -s -u "$user:$pass" "$url" | grep "The password" | awk '{ print $6; }'
