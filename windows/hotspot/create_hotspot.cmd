netsh interface set interface name="Wi-Fi" admin=disabled
netsh wlan set hostednetwork mode=allow ssid=DORABLADE key=""
netsh wlan start hostednetwork
netsh interface set interface name="Wi-Fi" admin=enabled