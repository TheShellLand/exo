#!/bin/bash

# check if rclone accounts are still valid

if [ -f errors.log ]; then rm -fv errors.log; fi 

for remote in $(rclone listremotes); do 
  if rclone lsd "$remote" >/dev/null 2>>errors.log; then 
    echo "OK $remote"
  else 
    echo "FAIL $remote"
  fi 
done


