import requests
import os
import re
from requests.auth import HTTPBasicAuth
import base64
import urllib.parse


url = "http://natas11.natas.labs.overthewire.org"
user = "natas11"
password = "1KFqoJXi6hRaPluAmk8ESDW4fSysRoIg"


def xor_decrypt(key, text):
    out = list(range(len(text)))
    for idx, val in enumerate(text):
        out[idx] = chr(ord(val) ^ key[idx])
    return(out)


def xor_encrypt(key, text):
    out = list(range(len(text)))
    for idx, val in enumerate(text):
        out[idx] = ord(val) ^ ord(key[idx % len(key)])
    return(out)


def find_key(decripted):
    key = []
    for x in decripted:
        if x not in key:
            key.append(x)
    return ''.join(key)

auth = HTTPBasicAuth(user, password)
res = requests.get(url, auth=auth)

data = res.cookies['data']
decoded_data = base64.b64decode(urllib.parse.unquote(data))

json_encoded_array = '{"showpassword":"no","bgcolor":"#ffffff"}'
output = xor_decrypt(decoded_data, json_encoded_array)
decripted = ''.join(output)
key = find_key(decripted)

computed_data = xor_encrypt(key, '{"showpassword":"yes","bgcolor":"#ffffff"}')
output = base64.b64encode(bytes(computed_data)).decode('utf-8')

res = requests.get(url, auth=auth, cookies={'data':output}, params={'bgcolor': '#f0f0f0'})
match = re.findall(r"^The password for natas12 is.*<br>$", res.text, re.MULTILINE)[0]

password = match.replace('<br>', '').split()[-1]
print(password)

# YWqo0pjpcXzSIl5NMAVxg12QxeC1w9QG



