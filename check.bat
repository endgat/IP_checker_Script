@echo off
setlocal enabledelayedexpansion

echo Checking IP addresses...

:: Get local IP address
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| find "IPv4 Address"') do (
    set "local_ip=%%a"
    set "local_ip=!local_ip:~1!"
    goto :found_local
)
:found_local

:: Get public IP address
for /f %%a in ('powershell -Command "(Invoke-WebRequest -Uri 'https://api.ipify.org' -UseBasicParsing).Content"') do set "public_ip=%%a"

:: Display results
if defined local_ip (
    echo Local IP Address: %local_ip%
) else (
    echo Unable to determine Local IP Address
)

if defined public_ip (
    echo Public IP Address: %public_ip%
) else (
    echo Unable to determine Public IP Address
)

pause