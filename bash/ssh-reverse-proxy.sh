#!/bin/bash

# ssh reverse proxy

date
echo $(dirname $0)/$(basename "$0")

#set -xe
cd "$(dirname $0)"


REVERSE_PROXY_PORT=$REVERSE_PROXY_PORT


if [ "$REVERSE_PROXY_PORT" ]; then
  echo "ssh :: REVERSE_PROXY_PORT :: $REVERSE_PROXY_PORT"
else
  echo "ssh :: ERROR :: REVERSE_PROXY_PORT :: not set"
  exit 1
fi


function ssh_reverse_proxy {
  echo -n "ssh :: ssh_reverse_proxy :: command :: "
  echo ssh -A -i $HOME/.ssh/id_rsa -R $REVERSE_PROXY_PORT:localhost:22 -L $REVERSE_PROXY_PORT:localhost:22 user@dream.n7sa.com -CN
  echo -n "ssh :: ssh_reverse_proxy :: connecting :: "
  ssh -A -i $HOME/.ssh/id_rsa -R $REVERSE_PROXY_PORT:localhost:22 -L $REVERSE_PROXY_PORT:localhost:22 user@dream.n7sa.com -CN &
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
  ssh-agent bash
  return $?
}


function ssh_add {
  echo -n "ssh :: agent :: add key :: "
  ssh-add
  return $?
}


function ssh_check {
  echo -n "ssh :: ssh_check :: command :: "
  echo ssh -A -i $HOME/.ssh/id_rsa user@localhost -p $REVERSE_PROXY_PORT "ssh -A user@localhost -p $REVERSE_PROXY_PORT hostname"
  echo -n "ssh :: ssh_check :: checking :: remote hostname :: "
  ssh -A -i $HOME/.ssh/id_rsa user@localhost -p $REVERSE_PROXY_PORT "ssh -A user@localhost -p $REVERSE_PROXY_PORT hostname"
#  ssh -A user@localhost -p $REVERSE_PROXY_PORT "hostname"
  return $?
}


function pid_kill {
  if [ -f SSH_PID ]; then
    echo -n "ssh :: pid_kill :: kill -9 $(cat SSH_PID) :: "
    kill -9 $(cat SSH_PID)
  fi 
  return $?
}



if pid_check; then
  echo "ssh :: pid_check :: OK"
elif pid_kill; then
  echo "ssh :: pid_kill :: OK"
fi

if ssh_check; then
  echo "ssh :: ssh_check :: OK"
  exit 0
fi

echo "ssh :: ssh_check :: FAIL"

if ssh_reverse_proxy; then
  echo "ssh :: ssh_reverse_proxy :: OK"

  if ssh_check; then
    echo "ssh :: ssh_check :: OK"
    exit 0
  else
    echo "ssh :: ssh_check :: FAIL"
  fi

fi

if pid_kill; then
  echo "ssh :: pid_kill :: OK"
fi

exit 1