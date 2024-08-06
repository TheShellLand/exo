#!/bin/bash

# ssh reverse proxy

date

#set -xe
cd "$(dirname $0)"

REVERSE_PROXY_PORT=2224

function ssh_reverse_proxy {
  echo "ssh :: ssh_reverse_proxy :: connecting"
  ssh -R $REVERSE_PROXY_PORT:localhost:22 -L $REVERSE_PROXY_PORT:localhost:22 user@dream.n7sa.com -CN &
  echo $! > SSH_PID
  return $?
}


function pid_check {
  if [ -f SSH_PID ]; then
    echo -n "ssh :: pid_check :: checking :: "
    ps -fp $(cat SSH_PID) | grep $(cat SSH_PID)
  fi 
  return $?
}


function ssh_check {
  echo -n "ssh :: ssh_check :: checking :: "
#  ssh -A user@localhost -p $REVERSE_PROXY_PORT "ssh user@localhost -p $REVERSE_PROXY_PORT id"
  ssh -A user@localhost -p $REVERSE_PROXY_PORT "id"
  return $?
}


function pid_kill {
  if [ -f SSH_PID ]; then
    echo "ssh :: pid_kill :: killing"
    kill -9 $(cat SSH_PID)
  fi 
  return $?
}


if ! pid_check; then
  while ! ssh_reverse_proxy; do
    sleep 1
  done

  echo "ssh :: ssh_reverse_proxy :: OK"

else

  if ! ssh_check; then
    echo "ssh :: ssh_check :: FAIL"

    if pid_kill; then
      echo "ssh :: pid_kill :: OK"

      if ssh_reverse_proxy; then
        echo "ssh :: ssh_reverse_proxy :: OK"
      fi

    fi
  fi
fi
