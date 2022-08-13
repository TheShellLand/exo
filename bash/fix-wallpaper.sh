REM Fix Windows 11 backgronud wallpaper reverting from Slideshow to Picture
REM Run as admin

dism /Online /Cleanup-Image /CheckHealth
dism /Online /Cleanup-Image /ScanHealth
dism /Online /Cleanup-Image /RestoreHealth

sfc /scannow
