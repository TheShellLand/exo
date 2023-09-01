#!/bin/bash

# check list dirs

if [ -f logs.log ]; then rm -v logs.log; fi 

for remote in $(rclone listremotes); do 
  if rclone lsd "$remote" >/dev/null; then 
    echo "OK $remote" | tee -a logs.log
    rclone lsd "$remote" >> logs.log
  else 
    echo "FAIL rclone lsd $remote"
  fi 
done


