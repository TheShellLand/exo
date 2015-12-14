#!/usr/bin/env bash

mdb -ke '::prtconf ! grep ixgbe' | awk '{printf("%s::print structdev_info devi_driver_data | ::print ixgbe_t\n", $1);}' | mdb -k
