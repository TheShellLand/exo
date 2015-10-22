#!/usr/bin/sh

# How to Create Etherstubs
You use etherstubs to isolate the virtual network from the rest of the virtual networks in the system as well as the
external network to which the system is connected. You cannot use an etherstub just by itself. Instead, you use VNICs
with an etherstub to create the private or isolated virtual networks. You can create as many etherstubs as you require.
You can also create as many VNICs over each etherstub as required.

dladm create-etherstub etherstub
dladm create-vnic -l etherstub vnic


# Configure the VNIC with a private address.
Note - To isolate the network for which you are configuring the VNIC over an etherstub, make sure to use a private IP
address that cannot be forwarded by the default router of the external network. For example, suppose the physical
interface has an address 192.168.3.0/24 that indicates that the system is on a 192.168.3.x network. You therefore
assign another address that is not known to the default router, for example, 192.168.0.x.
