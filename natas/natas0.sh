#!/bin/bash

html=$(curl -s -u natas0:natas0 http://natas0.natas.labs.overthewire.org)

echo "$html" | grep "The password" | awk '{ print $6 }' 
