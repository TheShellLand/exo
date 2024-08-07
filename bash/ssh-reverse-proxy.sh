#!/bin/bash

# ssh reverse proxy

date
echo $(dirname $0)/$(basename "$0")

#set -xe
cd "$(dirname $0)"

REVERSE_PROXY_PORT=$REVERSE_PROXY_PORT

function ssh_reverse_proxy {
  echo -n "ssh :: ssh_reverse_proxy :: connecting :: "
  ssh -R $REVERSE_PROXY_PORT:localhost:22 -L $REVERSE_PROXY_PORT:localhost:22 user@dream.n7sa.com -CN &
  echo $! > SSH_PID
  echo "PID $(cat SSH_PID)"
  return $?
}


function pid_check {
  if [ -f SSH_PID ]; then
    echo -n "ssh :: pid_check :: checking :: process :: "
    ps -fp $(cat SSH_PID) | grep $(cat SSH_PID)
  fi 
  return $?
}


function ssh_agent {
  echo -n "ssh :: agent :: "
  ssh-add
  return $?
}


function ssh_check {
  echo -n "ssh :: ssh_check :: command :: "
  echo ssh -A user@localhost -p $REVERSE_PROXY_PORT "ssh -A user@localhost -p $REVERSE_PROXY_PORT hostname"
  echo -n "ssh :: ssh_check :: checking :: remote hostname :: "
  ssh -A user@localhost -p $REVERSE_PROXY_PORT "ssh -A user@localhost -p $REVERSE_PROXY_PORT hostname"
#  ssh -A user@localhost -p $REVERSE_PROXY_PORT "hostname"
  return $?
}


function pid_kill {
  if [ -f SSH_PID ]; then
    echo "ssh :: pid_kill :: killing"
    kill -9 $(cat SSH_PID)
  fi 
  return $?
}


if ssh_agent; then
  echo "ssh :: agent :: OK"
fi

if ! pid_check; then
  echo "ssh :: pid_check :: FAIL"
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

  echo "ssh :: ssh_check :: OK"

fi
