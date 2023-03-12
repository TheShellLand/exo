netsh interface set interface name="Wi-Fi" admin=disabled
netsh wlan set hostednetwork mode=disallow
netsh wlan start hostednetwork
netsh interface set interface name="Wi-Fi" admin=enabled