#!/bin/bash

# ssh reverse proxy with dream.n7sa.com

date

set -xe
cd "$(dirname $0)"

REVERSE_PROXY_PORT=2223

function ssh_reverse_proxy {
  echo "ssh_reverse_proxy :: checking"
  ssh -R $REVERSE_PROXY_PORT:localhost:22 -L $REVERSE_PROXY_PORT:localhost:22 user@dream.n7sa.com -CN &
  echo $! > SSH_PID
  return $?
}


function pid_check {
  if [ -f SSH_PID ]; then
    echo "pid_check :: checking"
    ps -fp $(cat SSH_PID)
  fi 
  return $?
}


function ssh_check {
  echo "ssh_check :: checking"
  ssh -A user@localhost -p $REVERSE_PROXY_PORT "ssh user@localhost -p $REVERSE_PROXY_PORT id"
  return $?
}


function pid_kill {
  if [ -f SSH_PID ]; then 
    echo "pid_kill :: killing"
    kill -9 $(cat SSH_PID)
  fi 
  return $?
}


if ! pid_check; then
  while ! ssh_reverse_proxy; do
    sleep 1
  done

  echo "ssh_reverse_proxy :: OK"

else

  if ! ssh_check; then
    echo "ssh_check :: FAIL"

    if pid_kill; then
      echo "pid_kill :: OK"

      if ssh_reverse_proxy; then
        echo "ssh_reverse_proxy :: OK"
      fi

    fi
  fi
fi
