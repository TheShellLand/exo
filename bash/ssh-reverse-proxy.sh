 #!/bin/bash

# ssh reverse proxy with dream.n7sa.com

date

set -xe
cd "$(dirname $0)"


function ssh_reverse_proxy {
  ssh -R 2223:localhost:22 -L 2223:localhost:22 ubuntu@dream.n7sa.com -CN &
  echo $! > SSH_PID
  return $?
}


function pid_check {
  if [ -f SSH_PID ]; then
    ps -fp $(cat SSH_PID)
  fi 
  return $?
}


function ssh_check {
  ssh -A ubuntu@localhost -p 2223 "ssh -A eric@localhost -p 2223 id"
  return $?
}


function pid_kill {
  if [ -f SSH_PID ]; then 
    kill -9 $(cat SSH_PID)
  fi 
  return $?
}


if ! pid_check; then
  ssh_reverse_proxy

else

  if ! ssh_check; then
    pid_kill
    ssh_reverse_proxy
  fi  
fi 

