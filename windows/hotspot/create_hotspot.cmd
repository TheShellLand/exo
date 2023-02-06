netsh interface set interface name="Wi-Fi" admin=disabled
netsh wlan set hostednetwork mode=allow ssid="SECRETSQUIRREL" key="super secret key"
netsh wlan start hostednetwork
netsh interface set interface name="Wi-Fi" admin=enabled