#!/bin/bash

# ssh reverse proxy with dream.n7sa.com

date

set -xe
cd "$(dirname $0)"

REVERSE_PROXY_PORT=2224

function ssh_reverse_proxy {
  ssh -R $REVERSE_PROXY_PORT:localhost:22 -L $REVERSE_PROXY_PORT:localhost:22 user@dream.n7sa.com -CN &
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
  ssh -A user@localhost -p $REVERSE_PROXY_PORT "ssh user@localhost -p $REVERSE_PROXY_PORT id"
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

