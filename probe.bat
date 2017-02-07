@ECHO off
echo "                  _          "
echo "                 | |         "
echo "  _ __  _ __ ___ | |__   ___ "
echo " | '_ \| '__/ _ \| '_ \ / _ \"
echo " | |_) | | | (_) | |_) |  __/"
echo " | .__/|_|  \___/|_.__/ \___|"
echo " | |                         "
echo " |_|                         "
echo "          ver 0.1            "

echo [*] Setup
set /p DST=Set Output Directory ex: (C:\stuff):
echo [+] Creating Output Directory at %OUTFILE%
rmdir /S %OUTFILE%
mkdir %OUTFILE%

echo [*******************************************************************] >> %OUTFILE%
echo [*] SYSTEM INFO / SERVICES / NETWORKING >> %OUTFILE%
echo [>] Grabbing System Info
systeminfo >> %OUTFILE%
echo [>] Grabbing services 
sc query >> %OUTFILE%
echo [>] Grabbing Tasklist 
Tasklist /v >> %OUTFILE%
echo [>] Grabbing Network Sessions
nbtstat -S >> %OUTFILE%
echo [>] Grabbing TCP/IP Connections & PIDS
netstat -ano >> %OUTFILE%
echo [*******************************************************************] >> %OUTFILE%
echo [*] USERS AND SHARES >> %OUTFILE%
echo [>] Grabbing Users and SMB Shares
net users >> %OUTFILE%
net view >> %OUTFILE%
net view \\127.0.0.1 >> %OUTFILE%
echo [*******************************************************************] >> %OUTFILE%
echo [*] REGISTRY >> %OUTFILE%
echo [>] Grabbing Registry Information
Reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run >> %OUTFILE%
Reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce >> %OUTFILE%
Reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnceEx >> %OUTFILE%
Reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run >> %OUTFILE%
Reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run >> %OUTFILE%
Reg query HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnceEx >> %OUTFILE%
echo [*******************************************************************] >> %OUTFILE%
echo [>] Grabbing Scheduled Tasks
echo [*] SCHEDULED TASKS >> %OUTFILE%
at >> %OUTFILE%
schtasks >> %OUTFILE%
echo [*******************************************************************] >> %OUTFILE%
echo [*] FILESYSTEM >> %OUTFILE%
echo [>] Listing Files Larger than 100MB
forfiles /S /M * /C "cmd /c if @fsize geq 104857600 echo @file  @path" >> %OUTFILE%
echo [*] Complete
pause
