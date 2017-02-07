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
set /p OUTFILE=Set Output Path ex. (C:\Users\scott\):
echo [+] Creating Output Directory at %OUTFILE%.
rmdir /S %OUTFILE%probe_output
mkdir %OUTFILE%probe_output

echo [*******************************************************************] >> %OUTFILE%
echo [>] Grabbing System Info.
echo [*] SYSTEM INFO / SERVICES / NETWORKING >> %OUTFILE%probe_output\sysinfo.txt
systeminfo >> %OUTFILE%probe_output\sysinfo.txt
echo [>] Grabbing Drive Info.
fsutil fsinfo drives >> %OUTFILE%probe_output\sysinfo.txt
echo [>] Grabbing Services. 
sc query >> %OUTFILE%probe_output\sysinfo.txt
echo [>] Grabbing Tasklist.
Tasklist /v >> %OUTFILE%probe_output\sysinfo.txt
echo [>] Grabbing Network Sessions.
nbtstat -S >> %OUTFILE%probe_output\networking.txt
echo [>] Grabbing TCP/IP Connections / PIDS.
netstat -ano >> %OUTFILE%probe_output\networking.txt
arp -a >> %OUTFILE%probe_output\networking.txt
route print >> %OUTFILE%probe_output\networking.txt
echo [*******************************************************************] >> %OUTFILE%
echo [>] Grabbing Users and SMB Shares.
echo [*] USERS AND SHARES >> %OUTFILE%probe_output\samba.txt
net users >> %OUTFILE%probe_output\samba.txt
net share >> %OUTFILE%probe_output\samba.txt
net view >> %OUTFILE%probe_output\samba.txt
net view \\127.0.0.1 >> %OUTFILE%probe_output\samba.txt
echo [*******************************************************************] >> %OUTFILE%
echo [>] Grabbing Registry Information.
echo [*] REGISTRY >> %OUTFILE%probe_output\registry.txt
Reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run >> %OUTFILE%probe_output\registry.txt
Reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce >> %OUTFILE%probe_output\registry.txt
Reg query HKLM\Software\Microsoft\Windows NT\CurrentVersion\winlogon >> %OUTFILE%probe_output\registry.txt
Reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run >> %OUTFILE%probe_output\registry.txt
Reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run >> %OUTFILE%probe_output\registry.txt
echo [*******************************************************************] >> %OUTFILE%
echo [>] Grabbing Scheduled Tasks.
echo [*] SCHEDULED TASKS >> %OUTFILE%probe_output\schtasks.txt
schtasks >> %OUTFILE%
echo [*******************************************************************] >> %OUTFILE%
echo [>] Listing Files Larger than 100MB.
echo [*] FILESYSTEM >> %OUTFILE%probe_output\files.txt
forfiles /S /M * /C "cmd /c if @fsize geq 104857600 echo @file  @path" >> %OUTFILE%probe_output\files.txt
echo [*] Complete.
pause
