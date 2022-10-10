import requests, os, sys
from pwn import *
from requests.auth import HTTPBasicAuth
import urllib.parse
import string, signal


def ctrl_c_handler(sig, frame):
    print('\n\n[*] Exit...\n')
    sys.exit(1)

signal.signal(signal.SIGINT, ctrl_c_handler)


def get_password(user):
    file = open(f'credentials/{user}', 'r')
    password = file.read().replace('\n', '')
    file.close()
    return password


user = 'natas15'
password = get_password(user) 
url = f"http://{user}.natas.labs.overthewire.org"


def make_request(params):
    auth = HTTPBasicAuth(user, password)
    res = requests.get(url, auth=auth, params=params)
    return res.text


if __name__ == "__main__":
    pass

