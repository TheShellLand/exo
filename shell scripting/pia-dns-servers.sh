#!/bin/bash

# Change to PIA domain nameservers

ns="209.222.18.222 209.222.18.218"
resolv_new="/tmp/resolv_new.conf"
resolv="/etc/resolv.conf"

if [ -f $resolv_new ]; then
    echo "INFO    deleting old file"
    rm $resolv_new
fi

for nameserver in $ns; do
    echo "INFO    adding nameserver: $nameserver"
    echo "nameserver $nameserver" >> $resolv_new
done

echo "INFO    combining files"
cat $resolv >> $resolv_new

echo "INFO    updating resolver"
cp $resolv_new $resolv

echo "INFO    showing resolver file"
while read line; do
    echo "FILE    $line"
done < $resolv

echo "INFO    done"
