@echo off

Rem https://docs.microsoft.com/en-us/windows/wsl/wsl2-install
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
