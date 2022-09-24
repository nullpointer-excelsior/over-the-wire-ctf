sshpass -f passwords/bandit4 ssh bandit4@bandit.labs.overthewire.org -p 2220 "file inhere/* | grep text | tr -d : | awk '{print \$1}' | xargs cat" > passwords/bandit5

