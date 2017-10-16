#!/bin/bash

tmp="/tmp/issue"

# Create a backup of the original
if [ ! -f /etc/issue-base ]; then cp /etc/issue /etc/issue-base; fi

cat /etc/issue-base > $tmp
echo "" >> $tmp
echo $(ip r | grep -oP "(?<=src )[0-9.]*" >> /tmp/issue) >> $tmp
echo "" >> $tmp
cp /tmp/issue /etc/issue
